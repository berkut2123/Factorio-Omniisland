local Interface = {}

function Interface.informatron_default_menu(player_index)
  return {
    console = 1,
    editor = 1,
  }
end

function Interface.informatron_page_content(page_name, player_index, element)
  local player = game.players[player_index]
  -- main page
  if page_name == "informatron" then
    element.add{type="label", name="text_1", caption={"informatron.page_introduction_text_1", player.name or {"informatron.player_name", player_index}}, style="heading_1_label"}
    element.add{type="label", name="text_2", caption={"informatron.page_introduction_text_2"}}
    local image_container = element.add{type="frame", name="image_1", style="informatron_image_container", direction="vertical"}
    image_container.style.horizontally_stretchable = true
    image_container.style.horizontal_align = "center"
    image_container.add{type="button", name="image_1", style="informatron_image_1"} -- image is the background
    element.add{type="label", name="text_3", caption={"informatron.page_introduction_text_3"}}

    if #Informatron.get_menu_pane(player_index).children == 1 then
      local conditional = element.add{type="label", name="text_3_c", caption={"informatron.page_introduction_text_3_conditional"}}
      conditional.style.font_color = {255/255,230/255,192/255}
    end

    element.add{type="label", name="text_4", caption={"informatron.page_introduction_text_4"}, style="heading_1_label"}
    element.add{type="label", name="text_5", caption={"informatron.page_introduction_text_5"}}
  end


  if page_name == "editor" then
    element.add{type="label", name="text_1", caption={"informatron.page_editor_text_1"}}
  end

  if page_name == "console" then
    element.add{type="label", name="text_1", caption={"informatron.page_console_text_1"}}
    element.add{type="label", name="text_2", caption={"informatron.page_console_text_2"}, style="heading_1_label"}
    element.add{type="label", name="text_3", caption={"informatron.page_console_text_3"}}
    element.add{type="label", name="text_4", caption={"informatron.page_console_text_4"}, style="heading_1_label"}

    element.add{type="label", name="text_scripting_intro", caption={"informatron.page_console_text_scripting_intro"}}

    element.add{type="text-box", name="code_editor", text="/editor"}

    element.add{type="label", name="label_editor", caption={"informatron.page_console_text_command_editor"}}

    element.add{type="text-box", name="code_indestructible", text="/c game.player.character.destructible=false"}
    element.add{type="label", name="label_indestructible", caption={"informatron.page_console_text_command_indestructible"}}

    element.add{type="text-box", name="code_cheat", text="/c game.player.cheat_mode=true"}
    element.add{type="label", name="label_cheat", caption={"informatron.page_console_text_command_cheat"}}

    element.add{type="text-box", name="code_item", text="/c game.player.insert{name=\"infinity-chest\",count=1}"}
    element.add{type="label", name="label_item", caption={"informatron.page_console_text_command_item"}}

    element.add{type="text-box", name="code_teleport", text="/c game.player.teleport({0,0})"}
    element.add{type="label", name="label_teleport", caption={"informatron.page_console_text_command_teleport"}}

    local code_chart = element.add{type="text-box", name="code_chart", text="/c local radius=300 game.player.force.chart(game.player.surface, {{game.player.position.x-radius, game.player.position.y-radius}, {game.player.position.x+radius, game.player.position.y+radius}})"}
    code_chart.word_wrap = true
    code_chart.style.height = 50
    element.add{type="label", name="label_chart", caption={"informatron.page_console_text_command_chart"}}

    element.add{type="text-box", name="code_speed", text="/c game.speed=10"}
    element.add{type="label", name="label_speed", caption={"informatron.page_console_text_command_speed"}}

    element.add{type="text-box", name="code_set_evolution", text="/c game.forces[\"enemy\"].evolution_factor=0.5"}
    element.add{type="label", name="label_set_evolution", caption={"informatron.page_console_text_command_set_evolution"}}

    element.add{type="text-box", name="code_recipes", text="/c for name, recipe in pairs(game.player.force.recipes) do recipe.enabled = true end"}
    element.add{type="label", name="label_recipes", caption={"informatron.page_console_text_command_recipes"}}

    element.add{type="text-box", name="code_research", text="/c game.player.force.research_all_technologies()"}
    element.add{type="label", name="label_research", caption={"informatron.page_console_text_command_research"}}

    element.add{type="label", name="text_scripting_outro", caption={"informatron.page_console_text_scripting_outro"}}

    for _, child in pairs(element.children) do
      if child.type == "text-box" then
        child.read_only = true
        child.style.horizontally_stretchable = true
        child.style.vertically_stretchable = true
        child.style.top_margin = 15
      end
    end

  end

end

-- Remote interface. Other mods can add menus the same way
remote.add_interface("informatron", {

  informatron_menu = function(data) -- populates the menu
    return Interface.informatron_default_menu(data.player_index)
  end,

  informatron_page_content = function(data) -- provides cntent to a page
    return Interface.informatron_page_content(data.page_name, data.player_index, data.element)
  end,

  -- called once per second, only use if you have timers on the page, avoid rebuilding the whole page
  --informatron_page_content_update = function(data)
  --  return Interface.informatron_page_content_update(data.page_name, data.player_index, data.element)
  --end,

  informatron_open_to_page = function(data) -- causes Informatron to open to a specific page
    if data.player_index and data.interface and data.page_name then
      return Informatron.open_main_window(data.player_index, {interface=data.interface, page_name=data.page_name})
    end
  end
})

return Interface
