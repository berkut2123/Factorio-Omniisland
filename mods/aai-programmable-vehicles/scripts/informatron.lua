local Informatron = {} -- informatron pages implementation.

function Informatron.menu(player_index)
  local player = game.players[player_index]
  local force = player.force
  local menu = {
    unit_remote_controller = 1,
    path_remote_controller = 1,
    unit_data = 1,
    inventory_transfer = 1,
    vehicle_depot = 1,
    vehicle_deployer = 1,
    position_beacon = 1,
  }
  return menu
end

function Informatron.page_content(page_name, player_index, element)
  local player = game.players[player_index]
  local player_data = get_make_playerdata(player)

  local force = player.force
  local force_data = global.forces[force.name]
  if page_name == "aai-programmable-vehicles" then
    element.add{type="label", name="text_1", caption={"aai-programmable-vehicles.page_main_text_1"}}

  elseif page_name == "unit_remote_controller" then
    element.add{type="label", name="text_1", caption={"aai-programmable-vehicles.page_main_text_1"}}

  elseif page_name == "path_remote_controller" then
    element.add{type="label", name="text_1", caption={"aai-programmable-vehicles.page_main_text_1"}}

  elseif page_name == "unit_data" then
    element.add{type="label", name="text_1", caption={"aai-programmable-vehicles.page_main_text_1"}}

  elseif page_name == "inventory_transfer" then
    element.add{type="label", name="text_1", caption={"aai-programmable-vehicles.page_main_text_1"}}

  elseif page_name == "vehicle_depot" then
    element.add{type="label", name="text_1", caption={"aai-programmable-vehicles.page_main_text_1"}}

  elseif page_name == "vehicle_deployer" then
    element.add{type="label", name="text_1", caption={"aai-programmable-vehicles.page_main_text_1"}}

  elseif page_name == "position_beacon" then

  end

end


function Informatron.on_gui_click (event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]

  root = gui_element_or_parent(element, "informatron_main")
  if root then -- informatron
    if element.name == Ancient.name_button_player_track_glyphs then
      local player_data = get_make_playerdata(player)
      player_data.track_glyphs = true
      remote.call("informatron", "informatron_open_to_page", {player_index = player.index, interface="aai-programmable-vehicles", page_name="archeology"})
    elseif string.find(element.name, "link_vault_", 1, true) then
      local zone_index = util.string_to_number(util.replace(element.name, "link_vault_", ""))
      local zone = Zone.from_zone_index(zone_index)
      if zone and zone.glyph then
        local surface = Zone.get_make_surface(zone)
        RemoteView.start(player, zone)
        if zone.vault_pyramid and zone.vault_pyramid.valid then
          player.teleport(zone.vault_pyramid.position)
          player.gui.center.clear()
        end
      end
    end
    return
  end
end
Event.addListener(defines.events.on_gui_click, Informatron.on_gui_click)


return Informatron
