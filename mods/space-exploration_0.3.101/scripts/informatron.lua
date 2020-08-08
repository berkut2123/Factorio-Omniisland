local Informatron = {} -- informatron pages implementation.

function Informatron.menu(player_index)
  local player = game.players[player_index]
  local playerdata = get_make_playerdata(player)
  local force = player.force
  local menu = {
    meteor_defence = 1,
    coremining = 1,
    launching_satellites = 1,
    zone_discovery = 1,
    cargo_rockets = 1,
    lifesupport = 1,
    space_sciences = 1,
    spaceships = 1,
    exploration_journal = 1,
  }
  if playerdata.track_glyphs then
    menu["archeology"] = 1 -- shhh
  end
  if force.technologies[Ancient.name_tech_coordinates].enabled then
    menu["starmapping"] = 1 -- shhh
  end
  return menu
end

function Informatron.page_content(page_name, player_index, element)
  local player = game.players[player_index]
  local player_data = get_make_playerdata(player)

  local force = player.force
  local force_data = global.forces[force.name]
  if page_name == "space-exploration" then
    element.add{type="label", name="text_1", caption={"space-exploration.page_space_exploration_text_1"}}

  elseif page_name == "meteor_defence" then
    element.add{type="label", name="text_1", caption={"space-exploration.page_meteor_defence_text_1"}}

  elseif page_name == "coremining" then
    element.add{type="label", name="text_1", caption={"space-exploration.page_coremining_text_1"}}

  elseif page_name == "launching_satellites" then
    element.add{type="label", name="text_1", caption={"space-exploration.page_launching_satellites_text_1", force_data.satellites_launched or 0}}

  elseif page_name == "zone_discovery" then
    element.add{type="label", name="text_1", caption={"space-exploration.page_zone_discovery_text_1"}}

    local any_button_table = element.add{type="table", name="any_button_table", column_count=5, draw_horizontal_lines=false}
    any_button_table.style.horizontally_stretchable = true
    any_button_table.style.column_alignments[1] = "middle-center"
    any_button_table.style.column_alignments[2] = "middle-center"
    any_button_table.style.column_alignments[3] = "middle-center"
    any_button_table.style.top_margin = 30
    any_button_table.add{type = "flow", name="cell_left"}
    local any_button = any_button_table.add{type="button", name="any_resource",
      caption="No preference",
      style=force_data.search_for_resource == nil and "se_generic_button_active" or "se_generic_button"
    }
    any_button.style.horizontally_stretchable = true
    any_button.style.horizontal_align = "center"
    any_button.style.vertical_align = "center"
    any_button.style.font="heading-2"
    any_button.style.width = 170*2
    any_button.style.height = 70
    any_button_table.add{type = "flow", name="cell_right"}

    local r_table = element.add{type="table", name="discover_resource_table", column_count=5, draw_horizontal_lines=false}
    r_table.style.horizontally_stretchable = true
    r_table.style.column_alignments[1] = "middle-center"
    r_table.style.column_alignments[2] = "middle-center"
    r_table.style.column_alignments[3] = "middle-center"
    r_table.style.column_alignments[4] = "middle-center"
    r_table.style.column_alignments[5] = "middle-center"
    r_table.style.horizontal_spacing  = 10
    r_table.style.vertical_spacing = 30
    r_table.style.top_margin = 30

    local resources_settings = global.resources_and_controls.resource_settings
    for _, resource in pairs(resources_settings) do
      if resource.name ~= mod_prefix.."naquium-ore" then
        local button = r_table.add{type="button", name=resource.name,
          style=force_data.search_for_resource == resource.name and "se_generic_button_active" or "se_generic_button"
        }

        local l = button.add{type = "label", name = "l",
          caption={"space-exploration.discovery_look_for_resource_caption", "[img=entity/"..resource.name.."]", {"entity-name."..resource.name} },
          tooltip={"space-exploration.discovery_look_for_resource_tooltip", {"entity-name."..resource.name}}
        }
        button.style.horizontally_stretchable = true
        button.style.width = 165
        button.style.height = 90
        button.style.top_padding = 20
        --button.style.bottom_padding = 20
        button.style.horizontal_align = "center"
        button.style.vertical_align = "center"
        --l.style.horizontally_stretchable = true
        --l.style.vertically_stretchable = true
        l.ignored_by_interaction = true
        l.style.single_line = false
        l.style.width = 155
        l.style.horizontal_align = "center"
        l.style.vertical_align = "center"
        l.style.font="heading-2"
      end
    end

  elseif page_name == "cargo_rockets" then
    element.add{type="label", name="text_1", caption={"space-exploration.page_cargo_rockets_text_1", force_data.cargo_rockets_launched or 0}}

  elseif page_name == "lifesupport" then
    element.add{type="label", name="text_1", caption={"space-exploration.page_lifesupport_text_1"}}

  elseif page_name == "space_sciences" then
    element.add{type="label", name="text_1", caption={"space-exploration.page_space_sciences_text_1"}}

  elseif page_name == "spaceships" then
    element.add{type="label", name="text_1", caption={"space-exploration.page_spaceships_text_1"}}

  elseif page_name == "exploration_journal" then
    local text
    element.add{type="label", name="page_journal_title_backstory", caption={"space-exploration.page_journal_title_backstory"}, style="heading_2_label"}
    text = element.add{type="label", name="page_journal_text_backstory", caption={"space-exploration.page_journal_text_backstory"}}
    text.style.bottom_margin = 20

    if force_data.satellites_launched and force_data.satellites_launched > 0 then
      element.add{type="label", name="page_journal_title_satellite_launch", caption={"space-exploration.page_journal_title_satellite_launch"}, style="heading_2_label"}
      text = element.add{type="label", name="page_journal_text_satellite_launch", caption={"space-exploration.page_journal_text_satellite_launch"}}
      text.style.bottom_margin = 20
    end

    if force_data.cargo_rockets_launched and force_data.cargo_rockets_launched > 0 then
      element.add{type="label", name="page_journal_title_cargo_launch", caption={"space-exploration.page_journal_title_cargo_launch"}, style="heading_2_label"}
      text = element.add{type="label", name="page_journal_text_cargo_launch", caption={"space-exploration.page_journal_text_cargo_launch"}}
      text.style.bottom_margin = 20
    end

    if player_data.first_entered_vault then
      element.add{type="label", name="page_journal_title_entered_vault", caption={"space-exploration.page_journal_title_entered_vault"}, style="heading_2_label"}
      text = element.add{type="label", name="page_journal_text_entered_vault", caption={"space-exploration.page_journal_text_entered_vault", player_data.first_entered_vault.name}}
      text.style.bottom_margin = 20

      if not player_data.track_glyphs then
        local button = element.add{type = "button", name=Ancient.name_button_player_track_glyphs, caption={"space-exploration.player_track_glyphs"}}
        button.style.bottom_margin = 20
      end
    end

    local anomaly = Zone.from_name("Foenestra")
    if force_data.zones_discovered[anomaly.index] then
      element.add{type="label", name="page_journal_title_found_gate", caption={"space-exploration.page_journal_title_found_gate"}, style="heading_2_label"}
      text = element.add{type="label", name="page_journal_text_found_gate", caption={"space-exploration.page_journal_text_found_gate"}}
      text.style.bottom_margin = 20
    end
    if global.gate then
      Ancient.cryptf6()

      if player_data.has_entered_anomaly then
        element.add{type="label", name="page_journal_title_found_gate_ship", caption={"space-exploration.page_journal_title_found_gate_ship"}, style="heading_2_label"}
        text = element.add{type="label", name="page_journal_text_found_gate_ship", caption={"space-exploration.page_journal_text_found_gate_ship"}}
        text.style.bottom_margin = 20

        element.add{type="label", name="page_journal_title_found_gate_ship_authenticated", caption={"space-exploration.page_journal_title_found_gate_ship_authenticated"}, style="heading_2_label"}
        text = element.add{type="label", name="page_journal_text_found_gate_ship_authenticated", caption={"space-exploration.page_journal_text_found_gate_ship_authenticated"}}
        text.style.bottom_margin = 20

        --local player_name = player.name or "Engineer"
        --local id = 2236067977 - player.index * 13
        --local sub_id = 5 + player.index
        local player_name = game.players[1].name or "Engineer"
        local id = 2236067964
        local sub_id = 5 + 1
        local fcoord = Ancient.cryptf7(global.hcoord)

        element.add{type="label", name="page_journal_title_found_gate_ship_log", caption={"space-exploration.page_journal_title_found_gate_ship_log"}, style="heading_2_label"}
        local text_found_gate_ship_log_intro = element.add{type="label", name="page_journal_text_found_gate_ship_log_intro", caption={"space-exploration.page_journal_text_found_gate_ship_log_intro"}}
        local log_frame = element.add{type="frame", name="log_frame", style="a_inner_frame"}
        log_frame.style.vertically_stretchable = true
        local text_found_gate_ship_log = log_frame.add{
          type="label",
          name="page_journal_text_found_gate_ship_log",
          caption={"space-exploration.page_journal_text_found_gate_ship_log",
            id .. "."..sub_id.." (".. player_name.."_"..sub_id..")",
            Ancient.coordinate_to_string(fcoord)
          }
        }
        text_found_gate_ship_log.style.single_line = false
        text_found_gate_ship_log.style.font_color = {r=0.6,g=0.7,b=0.8}
      end
    end

  elseif page_name == "archeology" then

    local count = 0
    local text_1 = element.add{type="label", name="text_1", caption={"space-exploration.page_archeology_text_1", count}}
    text_1.style.bottom_margin = 20
    for _, zone in pairs(global.zone_index) do
      if zone.glyph and (force_data.zones_discovered[zone.index] or global.debug_view_all_zones) then
        count = count + 1
        local item = element.add{type="label", name="link_vault_"..zone.index, caption={"space-exploration.page_archeology_pyramid_link", "[img="..Zone.get_icon(zone).."]", zone.name} }
        item.style.bottom_margin = 20
      end
    end
    text_1.caption={"space-exploration.page_archeology_text_1", count}
    local text_2 = element.add{type="label", name="text_2", caption={"space-exploration.page_archeology_text_2", count}}
    text_2.style.bottom_margin = 20
    text_2.style.top_margin = 20


  elseif page_name == "starmapping" then
    local text_1 = element.add{type="label", name="text_1", caption={"space-exploration.page_starmapping_text_1", 0}, }
    if force_data.coordinates_discovered then
      local count = 0
      for i, glyph_id in pairs(force_data.coordinates_discovered) do
        count = count + 1
        coordinate = Ancient.cryptf4b({glyph_id})
        local label = element.add{type="label", name="glyph_"..glyph_id,
          caption={"space-exploration.starmapping-found-constellation-informatron", "[img=entity/"..mod_prefix .. "glyph-a-energy-"..glyph_id.."]", Ancient.coordinate_to_string(coordinate)}
        }
        label.style.height = 32
      end
      text_1.caption = {"space-exploration.page_starmapping_text_1", count}
      text_1.style.bottom_margin = 20
      text_1.style.vertical_align = "center"
    end
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
      remote.call("informatron", "informatron_open_to_page", {player_index = player.index, interface="space-exploration", page_name="archeology"})
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
    elseif element.parent.name == "discover_resource_table" then
      local force_data = global.forces[player.force.name]
      force_data.search_for_resource = element.name
      for _, child in pairs(util.find_first_descendant_by_name(root, "discover_resource_table").children) do
        child.style = "se_generic_button"
      end
      element.style = "se_generic_button_active"
      util.find_first_descendant_by_name(root, "any_resource").style = "se_generic_button"
    elseif element.name == "any_resource" then
      local force_data = global.forces[player.force.name]
      force_data.search_for_resource = nil
      element.style = "se_generic_button_active"
      for _, child in pairs(util.find_first_descendant_by_name(root, "discover_resource_table").children) do
        child.style = "se_generic_button"
      end
    end
    return
  end
end
Event.addListener(defines.events.on_gui_click, Informatron.on_gui_click)


return Informatron
