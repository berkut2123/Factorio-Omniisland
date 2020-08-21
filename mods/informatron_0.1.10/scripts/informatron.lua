local Informatron = {}

Informatron.name_shortcut = "informatron"
Informatron.name_event = "informatron"

Informatron.name_window_main = "informatron_main"
Informatron.name_window_close = "informatron_close"
Informatron.name_menu = "informatron_menu"
Informatron.name_content_title = "informatron_content_title"
Informatron.name_content = "informatron_content"

Informatron.style_menu_button = "informatron_menu_button"
Informatron.style_menu_button_selected = "informatron_menu_button_selected"
Informatron.style_menu_button_primary = "informatron_menu_button_primary"
Informatron.style_menu_button_primary_selected = "informatron_menu_button_primary_selected"
Informatron.content_width = 940

function Informatron.add_menu_item(element, item, indent)
  indent = indent or 0
  local style = (indent == 0) and Informatron.style_menu_button_primary or Informatron.style_menu_button
  local button = element.add{type="button", name=item.name, caption=item.caption, style=style}
  --side_menu_button
  --selected_slot_button when selected
  button.style.left_padding = 5 + 20 * indent
  if item.children then
    for _, child in pairs(item.children) do
      Informatron.add_menu_item(element, child, indent + 1)
    end
  end
end

function Informatron.display_page(player_index, interface, page_name)
  local menu_pane = Informatron.get_menu_pane(player_index)
  local button = menu_pane[interface][page_name]
  for _, child in pairs(menu_pane.children) do
    for _2, child2 in pairs(child.children) do
      local left_padding = child2.style.left_padding
      if child2 == button then
        if _2 == 1 then
          child2.style = Informatron.style_menu_button_primary_selected
        else
          child2.style = Informatron.style_menu_button_selected
        end
      else -- unselect others
        if _2 == 1 then
          child2.style = Informatron.style_menu_button_primary
        else
          child2.style = Informatron.style_menu_button
        end
      end
      child2.style.left_padding = left_padding
    end
  end

  local title = Informatron.get_content_title(player_index)
  title.caption = {interface..".title_"..page_name}

  local content = Informatron.get_content_pane(player_index)
  content.clear()
  if remote.interfaces[interface]["informatron_page_content"] then
    remote.call(interface, "informatron_page_content", {player_index=player_index, page_name=page_name, element=content})
  end
  for _, child in pairs(content.children) do
    child.style.horizontally_squashable = true
    child.style.maximal_width = Informatron.content_width - 40
    if child.type == "label" then
      child.style.single_line = false
    end
  end

  Informatron.set_player_last_page(player_index, {interface=interface, page_name=page_name})

end


function Informatron.get_content_pane(player_index)
  local window = Informatron.get_main_window(player_index)
  if window then
    return window.main_table.content_container[Informatron.name_content]
  end
end

function Informatron.get_content_title(player_index)
  local window = Informatron.get_main_window(player_index)
  if window then
    return window.main_table.content_container[Informatron.name_content_title]
  end
end


function Informatron.get_make_playerdata(player_index)
  global.playerdata = global.playerdata or {}
  global.playerdata[player_index] = global.playerdata[player_index] or {}
  return global.playerdata[player_index]
end


function Informatron.get_main_window(player_index)
  return game.players[player_index].gui.center[Informatron.name_window_main]
end

function Informatron.get_menu_items(player_index)
  local menu_items = {}
  -- get own first as it is the deafult one to display
  local interface = "informatron"
  local items = remote.call(interface, "informatron_menu", {player_index=player_index})
  if items then
    local primary = {
      name = interface,
      caption = {interface..".menu_"..interface},
    }
    local valid_items = Informatron.validate_menu_items(interface, items)
    if valid_items then
      primary.children = valid_items
    end
    menu_items[primary.name] = primary
  end

  -- then get others
  for interface, functions in pairs(remote.interfaces) do
    if interface ~= "informatron" and functions["informatron_menu"] and functions["informatron_page_content"] then
      local items = remote.call(interface, "informatron_menu", {player_index=player_index})
      if items then
        local primary = {
          name = interface,
          caption = {interface..".menu_"..interface},
        }
        local valid_items = Informatron.validate_menu_items(interface, items)
        if valid_items then
          primary.children = valid_items
        end
        menu_items[primary.name] = primary
      end
    end
  end
  return menu_items
end

function Informatron.get_menu_pane(player_index)
  local window = Informatron.get_main_window(player_index)
  if window then
    return window.main_table.menu_container[Informatron.name_menu]
  end
end

function Informatron.get_player_last_page(player_index)
  local playerdata = Informatron.get_make_playerdata(player_index)
  return playerdata.last_page
end

function Informatron.on_gui_click(event)
  if event.element and event.element.valid then
    if event.element.name == Informatron.name_window_close then
      local window = Informatron.get_main_window(event.player_index)
      if window then window.destroy() end
    elseif event.element.type == "button" and event.element.parent and event.element.parent.parent and event.element.parent.parent.name == Informatron.name_menu then
      Informatron.display_page(event.player_index, event.element.parent.name, event.element.name)
    end
  end
end
Event.addListener(defines.events.on_gui_click, Informatron.on_gui_click)

function Informatron.on_lua_shortcut (event)
  if event.player_index
    and game.players[event.player_index]
    and game.players[event.player_index].connected then

      if event.prototype_name == Informatron.name_shortcut then
        Informatron.toggle_main_window(event.player_index)
      end

  end
end
Event.addListener(defines.events.on_lua_shortcut, Informatron.on_lua_shortcut)

function Informatron.on_informatron_keypress (event)
  if event.player_index
    and game.players[event.player_index]
    and game.players[event.player_index].connected
  then
      Informatron.toggle_main_window(event.player_index)
  end
end
Event.addListener(Informatron.name_event, Informatron.on_informatron_keypress)

function Informatron.first_timers ()
  for _, player in pairs(game.connected_players) do
    local player_index = player.index
    local playerdata = Informatron.get_make_playerdata(player_index)
    if not playerdata.last_page then
      if settings.get_player_settings(player)["informatron-show-at-start"].value == true then
        Informatron.open_main_window(player.index)
      end
    end
  end
end
function Informatron.on_configuration_changed()
  for _, player in pairs(game.connected_players) do
    local window = Informatron.get_main_window(player.index)
    if window then
      Informatron.toggle_main_window(player.index)
      Informatron.toggle_main_window(player.index) -- refresh
    end
  end
  Informatron.first_timers ()
end
Event.addListener("on_configuration_changed", Informatron.on_configuration_changed, true)


function Informatron.on_nth_tick ()
  if game.tick >= 1200 then
    Informatron.first_timers()
  end
end
Event.addListener("on_init", Informatron.on_init, true)

script.on_nth_tick(1200, Informatron.on_nth_tick)

function Informatron.on_gui_opened(event)
  local player_index = event.player_index
  local window = Informatron.get_main_window(player_index)
  if window then
    window.destroy()
    game.players[player_index].opened = nil
  end
end
Event.addListener(defines.events.on_gui_opened, Informatron.on_gui_opened)

function Informatron.open_main_window(player_index, target_page)
  -- if no target_page then re-open at the last page that was open
  local player = game.players[player_index]
  if not (player and player.connected) then return end
  local center = player.gui.center
  center.clear()

  local main = center.add{type="frame", name=Informatron.name_window_main, direction="vertical"}

  local title_table = main.add{type="table", name="title_table", column_count=2, draw_horizontal_lines=false}
  title_table.style.horizontally_stretchable = true
  title_table.style.column_alignments[1] = "left"
  title_table.style.column_alignments[2] = "right"

  local title_frame = title_table.add{type="frame", name="title_frame", caption={"informatron.window_title_label"}, style="informatron_title_frame"}

  local close = title_table.add{type="sprite-button", name=Informatron.name_window_close, sprite = "utility/close_white", style="informatron_close_button"}
  close.style.width = 28
  close.style.height = 28

  local main_table = main.add{type="table", name="main_table", column_count=2, draw_horizontal_lines=false}
  main_table.style.horizontally_stretchable = true
  main_table.style.column_alignments[1] = "left"
  main_table.style.column_alignments[2] = "right"
  main_table.style.horizontal_spacing = 10

  local menu_frame = main_table.add{type="frame", name="menu_container", style="informatron_inside_deep_frame"}
  local menu_pane = menu_frame.add{type="scroll-pane", name=Informatron.name_menu , direction="vertical", style="informatron_menu_pane"}

  menu_items = Informatron.get_menu_items(player_index)
  -- encapsulate the primary items so sub-item names are safe
  for _, item in pairs(menu_items) do
    local mod_flow = menu_pane.add{type="flow", direction="vertical", name=item.name}
    Informatron.add_menu_item(mod_flow, item, 0)
  end

  local content_frame = main_table.add{type="frame", name="content_container", style="informatron_inside_deep_frame", direction="vertical"}

  local content_title = content_frame.add{type="frame", name=Informatron.name_content_title, caption="Content Heading", style="informatron_content_title"}

  local content_pane = content_frame.add{type="scroll-pane", name=Informatron.name_content, style = "informatron_content_pane"}

  if target_page and target_page.interface and remote.interfaces[target_page.interface] then
    Informatron.display_page(player_index, target_page.interface, target_page.page_name)
  else
    local last_page = Informatron.get_player_last_page(player_index)
    if last_page and last_page.interface and remote.interfaces[last_page.interface] then
      Informatron.display_page(player_index, last_page.interface, last_page.page_name)
    else
      Informatron.display_page(player_index, menu_pane.children[1].name,  menu_pane.children[1].children[1].name)
    end
  end

end

function Informatron.set_player_last_page(player_index, interface_page_name)
  local playerdata = Informatron.get_make_playerdata(player_index)
  playerdata.last_page = interface_page_name
end

function Informatron.toggle_main_window(player_index)
  local window = Informatron.get_main_window(player_index)
  if window then
    window.destroy()
  else
    Informatron.open_main_window(player_index)
  end
end

function Informatron.validate_menu_items(interface, items)
  if not items then return end
  local valid_items = {}
  local n_valid_items = 0
  for item_name, children in pairs(items) do
    valid_items[item_name] = {name=item_name, caption={interface..".menu_"..item_name}}
    n_valid_items = n_valid_items + 1
    if type(children) == "table" then
      valid_items[item_name].children = Informatron.validate_menu_items(interface, children)
    end
  end
  if n_valid_items > 0 then
    return valid_items
  end
end

return Informatron
