local Zonelist = {}
--[[
Zonelist is an informatron style popup in the middle of the screen.
It lists zones and has a starmap link.
If you choose to view a zone it puts you into remote view mode.
]]--

Zonelist.name_gui_root = mod_prefix.."zonelist_main"
Zonelist.name_shortcut = mod_prefix.."universe-explorer"
Zonelist.name_event = mod_prefix.."universe-explorer"

Zonelist.name_button_close = "zonelist_button_close"
Zonelist.name_button_starmap = "zonelist_button_starmap"
Zonelist.name_button_view_zone = "zonelist_button_view_zone"

Zonelist.name_zonelist_headings_row = "zonelist_headings_row"
Zonelist.name_zonelist_scroll = "zonelist_scroll"
Zonelist.name_zonelist_search = "zonelist_search"
Zonelist.name_zonelist_search_clear = "zonelist_search_clear"
Zonelist.name_zonelist_filters = "zonelist_filters"
Zonelist.name_zone_content_title = "zone_content_title"
Zonelist.name_zone_content_priority_flow = "zone_content_priority_flow"
Zonelist.name_zone_content_pane = "zone_content_pane"
Zonelist.name_zone_content_preview_frame = "zone_content_preview_frame"
Zonelist.name_zone_priority_field = "zone_priority_field"
Zonelist.name_zone_priority_plus_button = "zone_priority_plus_button"
Zonelist.name_zone_priority_minus_button = "zone_priority_minus_button"
Zonelist.name_zone_delete_surface_button = "zone_delete_surface_button"
Zonelist.name_zone_scan_surface_button = "zone_scan_surface_button"

Zonelist.name_color_priority_positive = {r=50/266, g=250/255, b=50/255}
Zonelist.name_color_priority_neutral = {r=255/255, g=174/255, b=0/255}
Zonelist.name_color_priority_negative = {r=250/255, g=20/255, b=20/255}

Zonelist.min_bar_brightness = 200

Zonelist.priority_max = 999

function Zonelist.get_selected_zone_or_current(player_index)
  local player = game.players[player_index]
  local playerdata = get_make_playerdata(player)
  local zone = playerdata.zonelist_selected_zone
  if not zone then
    zone = Zone.from_surface(player.surface)
  end
  return zone
end

function Zonelist.get_main_window(player_index)
  local player = game.players[player_index]
  if player and player.connected then
    return player.gui.center[Zonelist.name_gui_root]
  end
end

function Zonelist.gui_close(player_index)
  local window = Zonelist.get_main_window(player_index)
  if window then window.destroy() end
end

function Zonelist.gui_open(player_index)
  local player = game.players[player_index]
  if not player and player.connected then return end

  local gui = player.gui.center
  close_own_guis(player)
  Zonelist.gui_close(player_index)
  gui.clear()
  local playerdata = get_make_playerdata(player)
  playerdata.zonelist_filter_excludes = playerdata.zonelist_filter_excludes or {}
  local forcedata = global.forces[player.force.name]

  local root = gui.add{ type = "frame", name = Zonelist.name_gui_root, direction="vertical"}
  root.style.bottom_padding = 10

  local main_table = root.add{type="table", name="main_table", column_count=2, draw_horizontal_lines=false}
  main_table.style.horizontally_stretchable = true
  main_table.style.column_alignments[1] = "left" -- title, search, zone list table
  main_table.style.column_alignments[2] = "right" -- starmap, close, selected zone info

  local main_left_flow = main_table.add{type = "flow", name="main_left_flow", direction = "vertical"}
  local main_right_flow = main_table.add{type = "flow", name="main_right_flow", direction = "vertical"}
  main_left_flow.style.right_margin = 10

  local title_table = main_left_flow.add{type="table", name="title_table", column_count=2, draw_horizontal_lines=false}
  title_table.style.horizontally_stretchable = true
  title_table.style.column_alignments[1] = "left" -- name
  title_table.style.column_alignments[2] = "right" -- search

  -- LEFT TOP
  local title_frame = title_table.add{type="frame", name="title_frame", caption={"space-exploration.zonelist-window-title"}, style="informatron_title_frame"}


  -- LEFT TOP (right aligned)
  local filter_search_container = title_table.add{type="flow", name="filter_search_flow", direction="horizontal"}

  local filters_container = filter_search_container.add{type="flow", name=Zonelist.name_zonelist_filters, direction="horizontal"}
  for _, zone_type in pairs({"star", "planet", "planet-orbit", "moon", "moon-orbit", "asteroid-belt", "asteroid-field", "anomaly"}) do
    if zone_type ~= "anomaly" or Zone.is_visible_to_force(Zone.from_name("Foenestra"), player.force.name) then
      local style = "se_generic_square_button_down"
      if playerdata.zonelist_filter_excludes[zone_type] then
        style = "se_generic_square_button"
      end
      local button = filters_container.add{type = "sprite-button", name=zone_type, sprite="virtual-signal/se-"..zone_type, tooltip={"space-exploration.zonelist_filter_"..zone_type}, style=style}
      button.style.height = 28
      button.style.width = 28
      button.style.right_margin = 5
      button.style.top_margin = -2
    end
  end

  local zonelist_search = filter_search_container.add{ type="textfield", name=Zonelist.name_zonelist_search}
  zonelist_search.style.width = 275
  zonelist_search.style.top_margin = -4
  zonelist_search.style.left_margin = 10
  local search_button = filter_search_container.add{ type = "sprite-button", name=Zonelist.name_zonelist_search_clear, sprite="utility/search_icon", tooltip={"space-exploration.clear-search"}, style="informatron_close_button"}
  search_button.style.left_margin = 5
  search_button.style.height = 28
  search_button.style.width = 28
  search_button.style.top_margin = -2

  -- LEFT BOTTOM
  local zonelist_frame = main_left_flow.add{type="frame", name="zonelist_frame", style="informatron_inside_deep_frame", direction="vertical"}
  zonelist_frame.style.horizontally_stretchable = true
  zonelist_frame.style.minimal_height = 300
  local zonelist_headings_row = zonelist_frame.add{type="flow", name=Zonelist.name_zonelist_headings_row, direction="horizontal"}
  local zonelist_scroll = zonelist_frame.add{type="scroll-pane", name=Zonelist.name_zonelist_scroll, direction="vertical", style="zonelist_rows_pane"}

  -- TODO: Only shof if zones list is small
  if ((not forcedata.satellites_launched) or forcedata.satellites_launched < 18) and (not global.debug_view_all_zones) then
    local instruction = main_left_flow.add{type = "label", name="instruction", caption={"space-exploration.remote-view-instruction"}}
    instruction.style.single_line  = false
    instruction.style.horizontally_stretchable = true
  end


  --RIGHT TOP
  local title_table = main_right_flow.add{type="table", name="title_table", column_count=2, draw_horizontal_lines=false}
  title_table.style.horizontally_stretchable = true
  title_table.style.column_alignments[1] = "left" -- blank
  title_table.style.column_alignments[2] = "right" -- starmap, close

  local title_frame = title_table.add{type="frame", name="title_frame", caption=" ", style="informatron_title_frame", direction="horizontal"}
  title_frame.style.left_margin = -18

  local right_flow = title_table.add{type="flow", name="title_flow_right", direction="horizontal"}
  local starmap = right_flow.add{type="button", name=Zonelist.name_button_starmap, caption={"space-exploration.starmap-button"},
    style="informatron_close_button", tooltip={"space-exploration.starmap"}}
  starmap.style.right_margin = 6
  starmap.style.maximal_width = 200
  starmap.style.maximal_height = 32
  starmap.style.padding = 0
  starmap.style.left_padding = 5
  starmap.style.right_padding = 5

  local close = right_flow.add{type="sprite-button", name=Zonelist.name_button_close, sprite = "utility/close_white", style="informatron_close_button"}
  close.style.width = 28
  close.style.height = 28

  --RIGHT Upper MIDDLE
  local zone_content_frame = main_right_flow.add{type="frame", name="zone_content_frame", style="informatron_inside_deep_frame", direction="vertical"}
  local zone_content_title_frame = zone_content_frame.add{type="frame", name="zone_content_title_frame", style="informatron_content_title"}
  zone_content_title_frame.style.horizontally_stretchable = true
  zone_content_title_frame.style.margin = 0
  zone_content_title_frame.style.top_padding = 0
  zone_content_title_frame.style.bottom_padding = 0
  zone_content_title_frame.style.right_padding = 0
  local zone_content_title_table = zone_content_title_frame.add{type="table", name="title_table", column_count=2, draw_horizontal_lines=false, draw_vertical_lines=false}
  zone_content_title_table.style.horizontally_stretchable = true
  zone_content_title_table.style.column_alignments[1] = "left" -- name
  zone_content_title_table.style.column_alignments[2] = "right" -- priority
  local zone_content_title = zone_content_title_table.add{type="label", name=Zonelist.name_zone_content_title, caption=" ", style="heading_2_label"}
  zone_content_title.style.horizontally_stretchable = true
  zone_content_title.style.margin = 0
  zone_content_title.style.padding = 0
  --zone_content_title.style.width = 200
  local zone_content_priority_flow = zone_content_title_table.add{type="flow", name=Zonelist.name_zone_content_priority_flow, direction="horizontal"} -- icon, -, number, +
  zone_content_priority_flow.style.horizontal_align = "right"
  zone_content_priority_flow.style.vertical_align = "center"
  zone_content_priority_flow.style.right_padding = 0
  --zone_content_priority_flow.style.width = 200

  local zone_content_pane = zone_content_frame.add{type="scroll-pane", name=Zonelist.name_zone_content_pane, style="zonelist_content_pane"}
  zone_content_pane.style.minimal_height = 300
  zone_content_pane.style.maximal_height = 600
  zone_content_pane.style.width = 300
  zone_content_pane.style.padding = 12
  if not settings.get_player_settings(player)["se-show-zone-preview"].value then
    zone_content_pane.style.minimal_height = 600
    zone_content_pane.style.maximal_height = 900
  end

  --RIGHT BOTTOM
  if settings.get_player_settings(player)["se-show-zone-preview"].value then
    local zone_content_preview_frame = main_right_flow.add{type="frame", name=Zonelist.name_zone_content_preview_frame, style="informatron_inside_deep_frame"}
    zone_content_preview_frame.style.width = 300
    zone_content_preview_frame.style.height = 300
    zone_content_preview_frame.style.top_margin = 10
  end

  --RIGHT BOTTOM
  local zone_view_button = main_right_flow.add{type="button", name=Zonelist.name_button_view_zone, style="confirm_button", caption={"space-exploration.zonelist-view-surface"}}
  zone_view_button.style.top_margin = 10
  zone_view_button.style.horizontally_stretchable = true
  if not RemoteView.is_unlocked(player) then
    zone_view_button.enabled = false
    zone_view_button.tooltip = {"space-exploration.remote-view-requires-satellite"}
  end

  Zonelist.gui_update(player_index)
end

function Zonelist.gui_update(player_index) -- only call when something changed
  Zonelist.gui_update_list(player_index)
  Zonelist.gui_update_selected(player_index)
end
function Zonelist.gui_update_selected(player_index) -- only call when something changed
  local player = game.players[player_index]
  if not player and player.connected then return end
  local window = Zonelist.get_main_window(player_index)
  if not window then return end
  local force_name = player.force.name
  local forcedata = global.forces[force_name]
  local playerdata = get_make_playerdata(player)

  local selected_zone = playerdata.zonelist_selected_zone
  if not selected_zone then
    selected_zone = Zone.from_surface(player.surface)
  end
  if not selected_zone then
    if forcedata and forcedata.homeworld_index then
      selected_zone = Zone.from_zone_index(forcedata.homeworld_index)
    end
  end
  if not selected_zone then
    selected_zone = Zone.get_default()
  end
  local zone_force_assets = Zone.get_force_assets(force_name, selected_zone.index)

  local zone_content_title = util.find_first_descendant_by_name(window, Zonelist.name_zone_content_title)
  local zone_content_priority_flow = util.find_first_descendant_by_name(window, Zonelist.name_zone_content_priority_flow)
  local zone_content_pane = util.find_first_descendant_by_name(window, Zonelist.name_zone_content_pane)
  local zone_content_preview_frame = util.find_first_descendant_by_name(window, Zonelist.name_zone_content_preview_frame)

  local zonelist_scroll = util.find_first_descendant_by_name(window, Zonelist.name_zonelist_scroll)
  for _, row in pairs(zonelist_scroll.children) do
    row.style = "zonelist_row_button"
    if row.row_flow then
      for _, child in pairs(row.row_flow.children) do
        if child.name ~= "cell_priority" then
          child.style.font_color = {r=1,g=1,b=1}
        end
      end
    end
  end

  if selected_zone then
    local zone = selected_zone

    local row = Zonelist.find_row_for_zone(player_index, zone)
    if row then
      row.style = "zonelist_row_button_selected"
      if row.row_flow then
        for _, child in pairs(row.row_flow.children) do
          if child.name ~= "cell_priority" then
            child.style.font_color = {r=0,g=0,b=0}
          end
        end
      end
    end

    -- Title
    if zone_content_title then zone_content_title.caption = zone.name end
    -- Priority

    if zone_content_priority_flow then
      zone_content_priority_flow.tooltip={"space-exploration.priority-tooltip"}
      if not zone_content_priority_flow.priority_icon then
        zone_content_priority_flow.add{type="label", name="priority_icon", caption={"space-exploration.priority-icon"}, tooltip={"space-exploration.priority-tooltip"}}
      end
      if not zone_content_priority_flow[Zonelist.name_zone_priority_field] then
        local textfield = zone_content_priority_flow.add{type="textfield", name=Zonelist.name_zone_priority_field, style="zonelist_priority_textfield",
          numeric = true, allow_negative = true, tooltip={"space-exploration.priority-tooltip"}
        }
        textfield.style.width = 30
        textfield.style.height = 30
        textfield.style.horizontal_align = "center"
        textfield.style.padding = 0
        textfield.style.margin = 0
        textfield.style.right_margin = 4
      end
      local priority = Zone.get_priority(zone, force_name)
      local textfield = zone_content_priority_flow[Zonelist.name_zone_priority_field]
      textfield.text = priority
      if priority > 0 then
        textfield.style.font_color = Zonelist.name_color_priority_positive
      elseif priority < 0 then
        textfield.style.font_color = Zonelist.name_color_priority_negative
      else
        textfield.style.font_color = Zonelist.name_color_priority_neutral
      end
      if not zone_content_priority_flow["buttons_flow"] then
        local buttons_flow = zone_content_priority_flow.add{type="flow", name="buttons_flow", direction = "vertical", tooltip={"space-exploration.priority-tooltip"}}
        buttons_flow.style.margin = -1
      end
      if not zone_content_priority_flow["buttons_flow"][Zonelist.name_zone_priority_plus_button] then
        local plus = zone_content_priority_flow["buttons_flow"].add{type="button", name=Zonelist.name_zone_priority_plus_button,
          caption="▲", style="zonelist_priority_button", tooltip={"space-exploration.priority-tooltip"}}
        plus.style.margin = -2
        plus.style.padding = 0
        plus.style.width = 20
        plus.style.height = 20
        plus.style.font = "default-tiny-bold"
        plus.style.horizontal_align = "center"
      end
      if not zone_content_priority_flow["buttons_flow"][Zonelist.name_zone_priority_minus_button] then
        local minus = zone_content_priority_flow["buttons_flow"].add{type="button", name=Zonelist.name_zone_priority_minus_button,
          caption="▼", style="zonelist_priority_button", tooltip={"space-exploration.priority-tooltip"}}
        minus.style.margin = -2
        minus.style.padding = 0
        minus.style.width = 20
        minus.style.height = 20
        minus.style.font = "default-tiny-bold"
        minus.style.horizontal_align = "center"
      end
    end

    -- zone content
    if zone_content_pane then
      zone_content_pane.clear()
      local zone_properties = zone_content_pane.add{type="table", name="zone_properties", column_count=2, draw_horizontal_lines=false}
      zone_properties.style.horizontally_stretchable = true
      zone_properties.style.column_alignments[1] = "left" -- name
      zone_properties.style.column_alignments[2] = "right" -- priority
      zone_properties.style.top_margin = -5
      zone_properties.style.bottom_margin = 5
      local label, value

      label = zone_properties.add{type="label", name="label_type", caption={"space-exploration.zone-tooltip-type"}}
      label.style.horizontally_stretchable = true
      label.style.font_color = {r=0.5,g=0.5,b=0.5}
      value = zone_properties.add{type="label", name="value_type", caption="[img="..Zone.get_icon(zone) .. "] " .. Zone.type_title(zone)}
      value.style.horizontal_align = "right"

      if zone.parent then
        label = zone_properties.add{type="label", name="label_parent", caption={"space-exploration.zone-tooltip-parent"}}
        label.style.horizontally_stretchable = true
        label.style.font_color = {r=0.5,g=0.5,b=0.5}
        value = zone_properties.add{type="label", name="value_parent", caption=zone.parent.name}
        value.style.horizontal_align = "right"
      end

      if zone.radius then
        label = zone_properties.add{type="label", name="label_radius", caption={"space-exploration.zone-tooltip-radius"}}
        label.style.horizontally_stretchable = true
        label.style.font_color = {r=0.5,g=0.5,b=0.5}
        value = zone_properties.add{type="label", name="value_radius", caption=string.format("%.0f",zone.radius)}
        value.style.horizontal_align = "right"
      end

      if Zone.is_solid(zone) then
        label = zone_properties.add{type="label", name="label_daynight", caption={"space-exploration.zone-tooltip-daynight"}}
        label.style.horizontally_stretchable = true
        label.style.font_color = {r=0.5,g=0.5,b=0.5}
        value = zone_properties.add{type="label", name="value_daynight", caption=string.format("%.2f", zone.ticks_per_day/ 60 / 60 ).." minutes"}
        value.style.horizontal_align = "right"
      end


      if zone.type ~= "spaceship" then
        local interference_type = "radiation"
        if zone.type == "anomaly" then
          interference_type = "spacial-distortion"
        elseif Zone.is_solid(zone) then
          interference_type = "wind"
        end
        label = zone_properties.add{type="label", name="label_attrition", caption={"space-exploration.zone-tooltip-bot-attrition", {"space-exploration.attrition-type-"..interference_type}}}
        label.style.horizontally_stretchable = true
        label.style.font_color = {r=0.5,g=0.5,b=0.5}
        value = zone_properties.add{type="label", name="value_attrition", caption=string.format("%.2f",Zone.get_attrition(zone))}
        value.style.horizontal_align = "right"
      end

      if zone.type ~= "spaceship" then
        local threat = Zone.get_threat(zone)
        label = zone_properties.add{type="label", name="label_threat", caption={"space-exploration.zone-tooltip-threat"}}
        label.style.horizontally_stretchable = true
        label.style.font_color = {r=0.5,g=0.5,b=0.5}
        value = zone_properties.add{type="label", name="value_threat", caption=string.format("%.0f", threat*100).."%"}
        value.style.horizontal_align = "right"

      end

      local origin = Zone.from_surface(player.surface)
      if origin and origin ~= zone then
        local delta_v = Zone.get_travel_delta_v(origin, zone)
        if delta_v > 0 then
          label = zone_properties.add{type="label", name="label_delta_v", caption={"space-exploration.zone-tooltip-delta-v", origin.name}}
          label.style.horizontally_stretchable = true
          label.style.font_color = {r=0.5,g=0.5,b=0.5}
          value = zone_properties.add{type="label", name="value_delta-v", caption=string.format("%.0f", delta_v)}
          value.style.horizontal_align = "right"
        end
      end

      if zone.type == "spaceship" then
        local spaceship = zone

        local closest = Zone.find_nearest_zone(
        spaceship.space_distortion,
        spaceship.stellar_position,
        spaceship.star_gravity_well,
        spaceship.planet_gravity_well)
        label = zone_properties.add{type="label", name="label_closest", caption={"space-exploration.zone-tooltip-closest"}}
        label.style.horizontally_stretchable = true
        label.style.font_color = {r=0.5,g=0.5,b=0.5}
        value = zone_properties.add{type="label", name="value_closest", caption=closest and ("[img="..Zone.get_icon(closest) .. "] " .. closest.name)}
        value.style.horizontal_align = "right"

        local destination = Spaceship.get_destination_zone(spaceship)
        label = zone_properties.add{type="label", name="label_destination", caption={"space-exploration.zone-tooltip-destination"}}
        label.style.horizontally_stretchable = true
        label.style.font_color = {r=0.5,g=0.5,b=0.5}
        value = zone_properties.add{type="label", name="value_destination", caption=destination and ("[img="..Zone.get_icon(destination) .. "] " .. destination.name)}
        value.style.horizontal_align = "right"

      end

      local solar = Zone.get_display_light_percent(zone)
      label = zone_properties.add{type="label", name="label_solar", caption={"space-exploration.zone-tooltip-solar"}}
      label.style.horizontally_stretchable = true
      label.style.font_color = {r=0.5,g=0.5,b=0.5}
      value = zone_properties.add{type="label", name="value_solar", caption=string.format("%.0f", solar*100).."%"}
      value.style.horizontal_align = "right"

      if is_debug_mode or (global.spaceships and table_size(global.spaceships) > 0) then
        label = zone_properties.add{type="label", name="label_signals", caption="Automation signal:"}
        label.style.horizontally_stretchable = true
        label.style.font_color = {r=0.5,g=0.5,b=0.5}
        value = zone_properties.add{type="label", name="value_signals", caption=""}
        value.style.horizontal_align = "right"
        value.caption = "[img="..Zone.get_icon(zone).."] "..zone.index
        value.tooltip = {"space-exploration.simple-a-b", {"virtual-signal-name."..Zone.get_signal_name(zone)}, " "..zone.index.."\nUsed for spaceship automation."}
      end

      -- TODO: resources
      --for k = 0, 40, 1 do -- test scrollbar
      --  label = zone_properties.add{type="label", name="label_solar_"..k, caption={"space-exploration.zone-tooltip-solar"}}
      --end
      if zone.type ~= "spaceship" then
        if zone.type ~= "orbit" then
          local resources_flow = zone_content_pane.add{type="flow", name="resources_flow", direction="vertical"}
          local fsrs = {}
          local max_fsr = 0
          for resource_name, resource_settings in pairs(global.resources_and_controls.resource_settings) do
            if zone.controls[resource_name] then
              local fsr = Universe.estimate_resource_fsr(zone.controls[resource_name])
              if fsr > 0 then
                max_fsr = math.max(max_fsr, fsr)
                table.insert(fsrs, {name=resource_name, fsr=fsr})
              end
            end
          end
          table.sort(fsrs, function(a,b) return a.fsr > b.fsr end)
          local mapgen
          if zone.surface_index then mapgen = Zone.get_make_surface(zone).map_gen_settings end

          for i = 1, #fsrs, 1 do
            local resource_name = fsrs[i].name
            tooltip = {"space-exploration.zonelist-resource-bar-tooltip", "[img=entity/"..resource_name.."]", {"entity-name."..resource_name}}
            if mapgen then
              table.insert(tooltip, string.format("%.0f", mapgen.autoplace_controls[resource_name].frequency * 100).."%")
              table.insert(tooltip, string.format("%.0f", mapgen.autoplace_controls[resource_name].size * 100).."%")
              table.insert(tooltip, string.format("%.0f", mapgen.autoplace_controls[resource_name].richness * 100).."%")
            else
              local frequency_multiplier = Zone.get_frequency_multiplier(zone)
              table.insert(tooltip, string.format("%.0f", zone.controls[resource_name].frequency * frequency_multiplier * 100).."%")
              table.insert(tooltip, string.format("%.0f", zone.controls[resource_name].size * 100).."%")
              table.insert(tooltip, string.format("%.0f", zone.controls[resource_name].richness * 100).."%")
            end
            local row = resources_flow.add{type="flow", name=resource_name, direction="horizontal", tooltip = tooltip}
            row.style.top_margin = 4
            row.style.vertical_align = "center"
            local label = row.add{type="label", name="resource_icon", caption="[img=entity/"..resource_name.."]", tooltip=tooltip}
            local overlap = row.add{type="flow", name="resource_bar_overlap", direction="vertical"}
            local percent = math.pow(fsrs[i].fsr/max_fsr, 1/3)
            local progressbar = overlap.add{type="progressbar", name="resource_bar", value=percent, tooltip=tooltip, style="zonelist_progressbar"}
            progressbar.style.horizontally_stretchable = true
            progressbar.style.color = Zonelist.name_color_priority_neutral
            local proto = game.entity_prototypes[resource_name]
            if proto and proto.map_color then
              local color = proto.map_color
              local rgb = color.r + color.g + color.b
              if rgb < 150 then
                color.r = color.r + 1
                color.g = color.g + 1
                color.b = color.b + 1
                rgb = rgb + 3
              end
              --[[if rgb < 255 then
                local rgb_m = 255 / rgb
                color.r = math.min(255, color.r * rgb_m)
                color.g = math.min(255, color.g * rgb_m)
                color.b = math.min(255, color.b * rgb_m)
              end]]
              local rgb_max = math.max(color.r, math.max(color.g,color.b))
              if rgb_max < Zonelist.min_bar_brightness then
                local rgb_m = Zonelist.min_bar_brightness / rgb_max
                color.r = math.min(255, color.r * rgb_m)
                color.g = math.min(255, color.g * rgb_m)
                color.b = math.min(255, color.b * rgb_m)
              end
              progressbar.style.color = color
            end
            local label = overlap.add{type="label", name="resource_label", caption={"entity-name."..resource_name}, tooltip=tooltip}
            label.style.top_margin = -26
            label.style.left_padding = 8
            label.style.font = "default-bold"
            label.style.font_color = {}
          end
        end

        -- flags
        local has_glyph = playerdata.track_glyphs and (zone.glyph ~= nil)
        local has_visisted = playerdata.visited_zone and playerdata.visited_zone[zone.index]
        local has_launchpad = table_size(zone_force_assets.rocket_launch_pad_names) > 0
        local has_landingpad = table_size(zone_force_assets.rocket_landing_pad_names) > 0

        if has_glyph or has_visisted or has_launchpad or has_landingpad then
          local label = zone_properties.add{type="label", name="label_flags", caption={"space-exploration.zone-tooltip-flags"}}
          label.style.horizontally_stretchable = true
          label.style.font_color = {r=0.5,g=0.5,b=0.5}
          local flags_flow = zone_properties.add{type="flow", name="flags_flow", direction="horizontal"}
          flags_flow.style.horizontal_align = "right"
          if has_visisted then
            flags_flow.add{type="label", name="flag_visited", caption="[img=entity/character]", tooltip="Visited in person"}
          end
          if has_launchpad then
            flags_flow.add{type="label", name="flag_launchpad", caption="[img=entity/"..Launchpad.name_rocket_launch_pad.."]", tooltip={"entity-name."..Launchpad.name_rocket_launch_pad}}
          end
          if has_landingpad then
            flags_flow.add{type="label", name="flag_landingpad", caption="[img=entity/"..Landingpad.name_rocket_landing_pad.."]", tooltip={"entity-name."..Landingpad.name_rocket_landing_pad}}
          end
          if has_glyph then
            flags_flow.add{type="label", name="flag_tomb", caption="[img=entity/se-pyramid-a]", tooltip="Mysterious structure"}
          end
        end


        -- tags
        if zone.tags then
          local caption = nil
          for _, tag in pairs(zone.tags) do
            if not string.find(tag, "enemy", 1, true) then
              if caption == nil then
                caption = {"space-exploration.climate_"..tag}
              else
                caption = {"space-exploration.simple-a-b-comma", caption, {"space-exploration.climate_"..tag}}
              end
            end
          end
          local label = zone_content_pane.add{type="label", name="label_tags", caption="Climate tags:"}
          label.style.top_margin = 10
          label.style.horizontally_stretchable = true
          label.style.font_color = {r=0.5,g=0.5,b=0.5}
          value = zone_content_pane.add{type="label", name="value_tags", caption=caption}
          value.style.horizontal_align = "left"
          value.style.single_line = false
        end

        local scan_button = zone_content_pane.add{type="button", name=Zonelist.name_zone_scan_surface_button, --style="green_button",
          caption={"space-exploration.scan-zone-button"},
          tooltip = {"space-exploration.scan-zone-button-tooltip"}}
        scan_button.style.top_margin = 15
        if forcedata.is_scanning then
          scan_button.caption={"space-exploration.stop-scan-zone-button"}
          scan_button.tooltip={"space-exploration.stop-scan-zone-button-tooltip"}
        elseif not RemoteView.is_unlocked(player) then
          scan_button.enabled = false
          scan_button.tooltip = {"space-exploration.scan-zone-button-disabled-tooltip"}
        end

        local delete_button = zone_content_pane.add{type="button", name=Zonelist.name_zone_delete_surface_button, style="red_button", caption={"space-exploration.delete-zone-button"}}
        delete_button.style.top_margin = 10
        if not zone.surface_index then
          delete_button.enabled = false
          delete_button.tooltip = {"space-exploration.delete-zone-button-no-surface-tooltip"}
        end

      end

    end

    -- zone preview
    if zone_content_preview_frame then
      zone_content_preview_frame.clear()
      if zone.surface_index then
        local camera = zone_content_preview_frame.add{type="camera", name="zone_content_preview_camera", position={0,0}, zoom=0.05, surface_index=zone.surface_index}
        camera.style.horizontally_stretchable = true
        camera.style.vertically_stretchable = true
      end
    end
  else
    if zone_content_title then zone_content_title.caption = " " end
    if zone_content_priority_flow then zone_content_priority_flow.clear() end
    if zone_content_pane then zone_content_pane.clear() end
    if zone_content_preview_frame then zone_content_preview_frame.clear() end
  end
end

function Zonelist.get_row_name_for_zone(zone)
  local name = "zone_" .. zone.index
  if zone.type == "spaceship" then
    name = "spaceship_" .. zone.index
  end
  return name
end

function Zonelist.find_row_for_zone(player_index, zone)
  local window = Zonelist.get_main_window(player_index)
  if not window then return end
  local zonelist_scroll = util.find_first_descendant_by_name(window, Zonelist.name_zonelist_scroll)
  if not zonelist_scroll then return end
  local name = Zonelist.get_row_name_for_zone(zone)
  return zonelist_scroll[name]
end

function Zonelist.gui_update_list(player_index) -- only call when something changed
  local player = game.players[player_index]
  if not player and player.connected then return end
  local window = Zonelist.get_main_window(player_index)
  if not window then return end
  local force_name = player.force.name
  local forcedata = global.forces[force_name]
  local playerdata = get_make_playerdata(player)
  local selected_zone = playerdata.zonelist_selected_zone
  if not selected_zone then
    selected_zone = Zone.from_surface(player.surface)
  end

  local zonelist_headings_row = util.find_first_descendant_by_name(window, Zonelist.name_zonelist_headings_row)
  local zonelist_scroll = util.find_first_descendant_by_name(window, Zonelist.name_zonelist_scroll)
  local zonelist_search = util.find_first_descendant_by_name(window, Zonelist.name_zonelist_search)

  zonelist_headings_row.clear()
  zonelist_scroll.clear()

  local zones_list = {}
  -- build list in the hierarchy order as it is the most dificult to sort
  Zone.insert_if_visible_to_force(zones_list, global.universe.anomaly, force_name)
  for _, star in pairs(global.universe.stars) do
    Zone.insert_if_visible_to_force(zones_list, star.orbit, force_name)
    for _, planet_or_belt in pairs(star.children) do
      Zone.insert_if_visible_to_force(zones_list, planet_or_belt, force_name)
      if planet_or_belt.orbit then
        Zone.insert_if_visible_to_force(zones_list, planet_or_belt.orbit, force_name)
      end
      if planet_or_belt.children then
        for _, moon in pairs(planet_or_belt.children) do
          Zone.insert_if_visible_to_force(zones_list, moon, force_name)
          Zone.insert_if_visible_to_force(zones_list, moon.orbit, force_name)
        end
      end
    end
  end
  for _, zone in pairs(global.universe.space_zones) do
    Zone.insert_if_visible_to_force(zones_list, zone, force_name)
  end
  for _, spaceship in pairs(global.spaceships) do
    Zone.insert_if_visible_to_force(zones_list, spaceship, force_name)
  end

  -- filter
  if playerdata.zonelist_filter_excludes and table_size(playerdata.zonelist_filter_excludes) > 0 then
    local temp_list = zones_list
    zones_list = {}
    for _, zone in pairs(temp_list) do
      if zone.type == "orbit" then
        if zone.parent.type == "star" then
          if not playerdata.zonelist_filter_excludes["star"] then
            table.insert(zones_list, zone)
          end
        elseif zone.parent.type == "planet" then
          if not playerdata.zonelist_filter_excludes["planet-orbit"] then
            table.insert(zones_list, zone)
          end
        elseif zone.parent.type == "moon" then
          if not playerdata.zonelist_filter_excludes["moon-orbit"] then
            table.insert(zones_list, zone)
          end
        end
      else
        if not playerdata.zonelist_filter_excludes[zone.type] then
          table.insert(zones_list, zone)
        end
      end
    end
  end

  -- search
  local search = nil
  if zonelist_search then
    search = string.trim(zonelist_search.text)
    if search == "" then
      search = nil
    end
  end
  if search then
    local resource_names = {}
    for resource_name, resource_settings in pairs(global.resources_and_controls.resource_settings) do
      if string.find(string.lower(resource_name), string.lower(search), 1, true) then
        table.insert(resource_names, resource_name)
      end
    end

    local temp_list = zones_list
    zones_list = {}
    for _, zone in pairs(temp_list) do
      if string.find(string.lower(zone.name), string.lower(search), 1, true) then
        table.insert(zones_list, zone)
      elseif #resource_names > 0 and zone.type ~= "orbit" then
        for _, resource_name in pairs(resource_names) do
          if zone.controls and zone.controls[resource_name] and zone.controls[resource_name].size > 0 and zone.controls[resource_name].richness > 0 then
            table.insert(zones_list, zone)
            break
          end
        end
      end
    end
  end

  -- sort

  local try_criteria = playerdata.sort_criteria or {}
  -- set criteris in reverse order
  -- eg {"name", "type"} = sort alphabetically then by type, so type has priority, then alphabetical within type
  -- if "hierarchy" or "name" are in the list then later ones are removed as they won't do anything.

  local sort_criteria = {}
  if #try_criteria > 0 then
    for i = #try_criteria, 1, -1 do
      table.insert(sort_criteria, 1, try_criteria[i])
      if try_criteria[i].name == "hierarchy" or try_criteria[i].name == "name" then
        break
      end
    end
  end
  if #sort_criteria == 0 then
    sort_criteria = {{name="hierarchy", direction=1}}
  end
  playerdata.sort_criteria = sort_criteria

  Universe.set_hierarchy_values()
  for i = 1, #sort_criteria, 1 do
    local mode = sort_criteria[i].name
    local direction = sort_criteria[i].direction or 1
    if mode == "hierarchy" then
      Universe.set_hierarchy_values()
      -- nothing to do, should alredy be in this mode
      table.sort(zones_list, function(a,b)
        if a.type == "spaceship" then
          if b.type == "spaceship" then
            return a.name < b.name
          end
          return false
        end
        if b.type == "spaceship" then
          return true
        end
        return a.hierarchy_index < b.hierarchy_index end)
    elseif mode == "type" then
      if direction == -1 then
        table.sort(zones_list, function(a,b)
          if a.type == b.type and a.type == "orbit" then return a.parent.type < b.parent.type end
          return a.type < b.type
        end)
      else
        table.sort(zones_list, function(a,b)
          if a.type == b.type and a.type == "orbit" then return a.parent.type > b.parent.type end
          return a.type > b.type
        end)
      end
    elseif mode == "name" then
      if direction == -1 then
        table.sort(zones_list, function(a,b) return a.name > b.name end)
      else
        table.sort(zones_list, function(a,b) return a.name < b.name end)
      end
    elseif mode == "radius" then
      if direction == -1 then
        table.sort(zones_list, function(a,b) return (a.radius or 0) < (b.radius or 0) end)
      else
        table.sort(zones_list, function(a,b) return (a.radius or 0) > (b.radius or 0) end)
      end
    elseif mode == "resource" then
      if direction == -1 then
        table.sort(zones_list, function(a,b) return ((a.type ~= "orbit" and a.primary_resource) and a.primary_resource or "") < ((b.type ~= "orbit" and b.primary_resource) and b.primary_resource or "") end)
      else
        table.sort(zones_list, function(a,b) return ((a.type ~= "orbit" and a.primary_resource) and a.primary_resource or "") > ((b.type ~= "orbit" and b.primary_resource) and b.primary_resource or "") end)
      end
    elseif mode == "attrition" then
      if direction == -1 then
        table.sort(zones_list, function(a,b) return Zone.get_attrition(a) > Zone.get_attrition(b) end)
      else
        table.sort(zones_list, function(a,b) return Zone.get_attrition(a) < Zone.get_attrition(b) end)
      end
    elseif mode == "threat" then
      if direction == -1 then
        table.sort(zones_list, function(a,b) return Zone.get_threat(a) > Zone.get_threat(b) end)
      else
        table.sort(zones_list, function(a,b) return Zone.get_threat(a) < Zone.get_threat(b) end)
      end
    elseif mode == "solar" then
      if direction == -1 then
        table.sort(zones_list, function(a,b) return Zone.get_display_light_percent(a) < Zone.get_display_light_percent(b) end)
      else
        table.sort(zones_list, function(a,b) return Zone.get_display_light_percent(a) > Zone.get_display_light_percent(b) end)
      end
    elseif mode == "flags" then
      if direction == -1 then
        table.sort(zones_list, function(a,b) return Zone.get_flags_weight(a, force_name, playerdata) < Zone.get_flags_weight(b, force_name, playerdata) end)
      else
        table.sort(zones_list, function(a,b) return Zone.get_flags_weight(a, force_name, playerdata) > Zone.get_flags_weight(b, force_name, playerdata) end)
      end
    elseif mode == "priority" then
      if direction == -1 then
        table.sort(zones_list, function(a,b) return Zone.get_priority(a, force_name) < Zone.get_priority(b, force_name) end)
      else
        table.sort(zones_list, function(a,b) return Zone.get_priority(a, force_name) > Zone.get_priority(b, force_name) end)
      end
    end
  end

  -- column names are: hierarchy, type, name, radius, resource, attrition, solar, priority

  -- build headings
  local function format_cell(element, is_heading)
    if is_heading then
      element.style="dark_button"
    end
    element.style.margin = 0
    element.style.width = 70
    --element.style.horizontal_align = "center"
    if element.name == "cell_name" then
      element.style.width = 210
      element.style.maximal_width = 900
      --element.style.horizontally_stretchable = true
      --element.style.horizontal_align = "left"
    end
    return element
  end

  if zonelist_headings_row then
    local cell_hierarchy = format_cell(zonelist_headings_row.add{type="button", name="cell_hierarchy", caption="[img=virtual-signal/se-hierarchy]", tooltip={"space-exploration.zonelist-heading-hierarchy"}}, true)
    local cell_type = format_cell(zonelist_headings_row.add{type="button", name="cell_type", caption="[img=virtual-signal/se-planet]", tooltip={"space-exploration.zonelist-heading-type"}}, true)
    local cell_name = format_cell(zonelist_headings_row.add{type="button", name="cell_name", caption={"space-exploration.name"}, tooltip={"space-exploration.zonelist-heading-name"}}, true)
    cell_name.style.horizontal_align = "left"
    cell_name.style.font_color = {1,1,1}
    local cell_radius = format_cell(zonelist_headings_row.add{type="button", name="cell_radius", caption="[img=virtual-signal/se-radius]", tooltip={"space-exploration.zonelist-heading-radius"}}, true)
    local cell_resource = format_cell(zonelist_headings_row.add{type="button", name="cell_resource", caption="[img=item/se-core-fragment-omni]", tooltip={"space-exploration.zonelist-heading-primary-resource"}}, true)
    local cell_attrition = format_cell(zonelist_headings_row.add{type="button", name="cell_attrition", caption="[img=item/logistic-robot]", tooltip={"space-exploration.zonelist-heading-attrition"}}, true)
    local cell_threat = format_cell(zonelist_headings_row.add{type="button", name="cell_threat", caption="[img=item/artillery-targeting-remote]", tooltip={"space-exploration.zonelist-heading-threat"}}, true)
    local cell_solar = format_cell(zonelist_headings_row.add{type="button", name="cell_solar", caption="[img=item/solar-panel]", tooltip={"space-exploration.zonelist-heading-solar"}}, true)
    local cell_flags = format_cell(zonelist_headings_row.add{type="button", name="cell_flags", caption="[img=item/"..Landingpad.name_rocket_landing_pad.."]", tooltip={"space-exploration.zonelist-heading-flags"}}, true)
    local cell_priority = format_cell(zonelist_headings_row.add{type="button", name="cell_priority", caption="[img=virtual-signal/se-accolade]", tooltip={"space-exploration.zonelist-heading-priority"}}, true)
  end

  -- build rows
  if zonelist_scroll then
    for i, zone in pairs(zones_list) do
      -- zone row
      local hierarchy = " ✖"
      if zone.type == "planet" then
        hierarchy = "   | - ●"
      elseif zone.type == "moon" then
        hierarchy = "   |      | - ●"
      elseif zone.type == "asteroid-belt" then
        hierarchy = "   | - ✖"
      end
      if zone.type == "orbit" then
        if zone.parent.type == "star" then
          hierarchy = "⬤"
        elseif zone.parent.type == "planet" then
          hierarchy = "   |    ○"
        else
          hierarchy = "   |      |    ○"
        end
      end
      if zone.type == "anomaly" then
        hierarchy = "  ?"
      end
      if zone.type == "spaceship" then
        hierarchy = "  ▴"
      end
      local name = Zonelist.get_row_name_for_zone(zone)
      Log.debug_log("zonelist: "..zone.type.." "..zone.name.." "..zone.index, "zonelist")
      local row = zonelist_scroll.add{type="button", name=name, style=(zone == selected_zone and "zonelist_row_button_selected" or "zonelist_row_button")}
      --row.style.horizontally_stretchable = true
      --row.style.bottom_margin = -3
      local row_flow = format_cell(row.add{type="flow", name="row_flow", direction="horizontal"})
      row_flow.ignored_by_interaction = true
      local cell_hierarchy = format_cell(row_flow.add{type="label", name="cell_hierarchy", caption=hierarchy})
      cell_hierarchy.style.horizontal_align = "left"
      local cell_type = format_cell(row_flow.add{type="label", name="cell_type", caption="[img="..Zone.get_icon(zone).."]", tooltip=Zone.type_title(zone)})
      cell_type.style.horizontal_align = "center"
      cell_type.style.left_margin = -12
      local cell_name = format_cell(row_flow.add{type="label", name="cell_name", caption=zone.name})
      cell_name.style.horizontal_align = "left"
      cell_name.style.left_padding = 16
      local cell_radius = format_cell(row_flow.add{type="label", name="cell_radius", caption=zone.radius and (string.format("%.0f", zone.radius)) or "-"})
      cell_radius.style.horizontal_align = "right"
      cell_radius.style.right_padding = 16
      local cell_resource = format_cell(row_flow.add{type="label", name="cell_resource",
        caption= (zone.primary_resource and zone.type ~= "orbit") and ("[img=entity/"..zone.primary_resource.."]") or "-",
        tooltip= (zone.primary_resource and zone.type ~= "orbit") and ({"entity-name."..zone.primary_resource}) or nil})
      cell_resource.style.horizontal_align = "center"
      local cell_attrition = format_cell(row_flow.add{type="label", name="cell_attrition", caption=string.format("%.2f", Zone.get_attrition(zone))})
      cell_attrition.style.horizontal_align = "right"
      cell_attrition.style.right_padding = 16
      local cell_threat = format_cell(row_flow.add{type="label", name="cell_threat", caption=string.format("%.0f", Zone.get_threat(zone)*100).."%"})
      cell_threat.style.horizontal_align = "right"
      cell_threat.style.right_padding = 16
      local cell_solar = format_cell(row_flow.add{type="label", name="cell_solar", caption=string.format("%.0f", Zone.get_display_light_percent(zone) * 100).."%"})
      cell_solar.style.horizontal_align = "right"
      cell_solar.style.right_padding = 16
      local cell_flags = format_cell(row_flow.add{type="label", name="cell_flags", caption=""})
      cell_flags.style.horizontal_align = "center"
      if playerdata.visited_zone and playerdata.visited_zone[zone.index] then
        cell_flags.caption = cell_flags.caption .. "[img=entity/character]"
      end
      if global.forces[force_name].zone_assets and global.forces[force_name].zone_assets[zone.index] and table_size(global.forces[force_name].zone_assets[zone.index].rocket_launch_pad_names) > 0 then
        cell_flags.caption = cell_flags.caption .. "[img=entity/"..Launchpad.name_rocket_launch_pad.."]"
      end
      if global.forces[force_name].zone_assets and global.forces[force_name].zone_assets[zone.index] and table_size(global.forces[force_name].zone_assets[zone.index].rocket_landing_pad_names) > 0 then
        cell_flags.caption = cell_flags.caption .. "[img=entity/"..Landingpad.name_rocket_landing_pad.."]"
      end
      if playerdata.track_glyphs and (zone.glyph ~= nil) then
        cell_flags.caption = cell_flags.caption .. "[img=entity/se-pyramid-a]"
      end

      local priority = Zone.get_priority(zone, force_name)
      local cell_priority = format_cell(row_flow.add{type="label", name="cell_priority", caption=priority})
      cell_priority.style.horizontal_align = "right"
      cell_priority.style.right_padding = 30
      if priority > 0 then
        cell_priority.style.font_color = Zonelist.name_color_priority_positive
      elseif priority < 0 then
        cell_priority.style.font_color = Zonelist.name_color_priority_negative
      else
        cell_priority.style.font_color = Zonelist.name_color_priority_neutral
      end
    end
  end

end


function Zonelist.toggle_main_window(player_index)
  local window = Zonelist.get_main_window(player_index)
  if window then
    window.destroy()
  else
    Zonelist.gui_open(player_index)
  end
end


function Zonelist.on_gui_click (event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]

  root = gui_element_or_parent(element, Zonelist.name_gui_root)
  if root then -- remote view
    local playerdata = get_make_playerdata(player)
    if element.name == Zonelist.name_button_view_zone then
      if RemoteView.is_unlocked(player) then
        local zone = Zonelist.get_selected_zone_or_current(event.player_index)
        if zone then
          Zonelist.gui_close(event.player_index)
          RemoteView.start(player, zone)
        end
      else
        player.print({"space-exploration.remote-view-requires-satellite"})
      end
    elseif element.parent and element.parent.name == Zonelist.name_zonelist_headings_row then
      playerdata.sort_criteria = playerdata.sort_criteria or {}
      local criterion = util.replace(element.name, "cell_", "")
      if playerdata.sort_criteria[#playerdata.sort_criteria].name == criterion then
        playerdata.sort_criteria[#playerdata.sort_criteria].direction = -1 * (playerdata.sort_criteria[#playerdata.sort_criteria].direction or 1)
      else
        for _, c in pairs(playerdata.sort_criteria) do
          if c.name == criterion then
            table.remove(playerdata.sort_criteria, _)
            break
          end
        end
        table.insert(playerdata.sort_criteria, {name=criterion, direction = 1})
      end
      Zonelist.gui_update_list(event.player_index)
    elseif gui_element_or_parent(element.parent, Zonelist.name_zonelist_scroll) then
      if string.find(element.name, "zone_", 1, true) then
        local number_string = util.replace(element.name, "zone_", "")
        local zone_index = util.string_to_number(number_string)
        local zone = Zone.from_zone_index(zone_index)
        if zone then
          playerdata.zonelist_selected_zone = zone
          Zonelist.gui_update_selected(event.player_index)
        end
      elseif string.find(element.name, "spaceship_", 1, true) then
        local number_string = util.replace(element.name, "spaceship_", "")
        local spaceship_index = util.string_to_number(number_string)
        local spaceship = Spaceship.from_index(spaceship_index)
        if spaceship then
          playerdata.zonelist_selected_zone = spaceship
          Zonelist.gui_update_selected(event.player_index)
        end
      end
    elseif element.name == Zonelist.name_button_starmap then
      Zonelist.gui_close(event.player_index)
      RemoteView.start_starmap(player)
    elseif element.name == Zonelist.name_zonelist_search_apply then
      local textfield = util.find_first_descendant_by_name(root, Zonelist.name_zonelist_search)
      if textfield then
        textfield.text = ""
        Zonelist.gui_update_list(event.player_index)
      end
    elseif element.parent and element.parent.name == Zonelist.name_zonelist_filters then
      playerdata.zonelist_filter_excludes = playerdata.zonelist_filter_excludes or {}
      if playerdata.zonelist_filter_excludes[element.name] then
        playerdata.zonelist_filter_excludes[element.name] = nil
        element.style = "se_generic_square_button_down"
      else
        playerdata.zonelist_filter_excludes[element.name] = true
        element.style = "se_generic_square_button"
      end
      Zonelist.gui_update_list(event.player_index)
    elseif element.name == Zonelist.name_zone_priority_plus_button then
      local zone = Zonelist.get_selected_zone_or_current(event.player_index)
      local forcedata = global.forces[player.force.name]
      if zone.type ~= "spaceship" then
        forcedata.zone_priorities = forcedata.zone_priorities or {}
        local priority = (forcedata.zone_priorities[zone.index] or 0) + 1
        Zonelist.change_priority(player.force.name, zone, priority)
      else
        forcedata.spaceship_priorities = forcedata.spaceship_priorities or {}
        local priority = (forcedata.spaceship_priorities[zone.index] or 0) + 1
        Zonelist.change_priority(player.force.name, zone, priority)
      end
    elseif element.name == Zonelist.name_zone_priority_minus_button then
      local zone = Zonelist.get_selected_zone_or_current(event.player_index)
      local forcedata = global.forces[player.force.name]
      if zone.type ~= "spaceship" then
        forcedata.zone_priorities = forcedata.zone_priorities or {}
        local priority = (forcedata.zone_priorities[zone.index] or 0) - 1
        Zonelist.change_priority(player.force.name, zone, priority)
      else
        forcedata.spaceship_priorities = forcedata.spaceship_priorities or {}
        local priority = (forcedata.spaceship_priorities[zone.index] or 0) - 1
        Zonelist.change_priority(player.force.name, zone, priority)
      end
    elseif element.name == Zonelist.name_zone_delete_surface_button then
      local zone = Zonelist.get_selected_zone_or_current(event.player_index)
      Zone.delete_surface(zone, event.player_index)
      Zonelist.gui_update_selected(event.player_index)
    elseif element.name == Zonelist.name_zone_scan_surface_button then
      local forcedata = global.forces[player.force.name]
      local zone = Zonelist.get_selected_zone_or_current(event.player_index)
      local surface = Zone.get_make_surface(zone)
      if forcedata.is_scanning then
        forcedata.is_scanning = false
        player.force.cancel_charting()
        Zonelist.gui_update_selected(event.player_index)
      else
        forcedata.is_scanning = true
        local width = zone.radius or 2000
        local height = width
        if zone.type == "orbit" or zone.type == "asteroid-belt" then
          height = width / 4
        end
        if width == height and (zone.type == "planet" or zone.type == "moon") then
          local size = width
          local innersize = math.floor(width/math.sqrt(2)/32)*32
          player.force.chart(surface, {{-innersize-32, -innersize-32}, {innersize, innersize}})
          for x = innersize+32, size, 32 do
            local y = math.floor(math.sqrt(size^2-x^2)/32)*32
            player.force.chart(surface, {{-y-32,-x-32},{y,-x-32}})
            player.force.chart(surface, {{x,-y-32},{x,y}})
            player.force.chart(surface, {{y,x},{-y-32,x}})
            player.force.chart(surface, {{-x-32,y},{-x-32,-y-32}})
          end
        else
          player.force.chart(surface, {{-width, -height}, {width, height}})
        end
        Zonelist.gui_update_selected(event.player_index)
      end
    elseif element.name == Zonelist.name_button_close then
      Zonelist.gui_close(event.player_index)
    end
    return
  end
end
Event.addListener(defines.events.on_gui_click, Zonelist.on_gui_click)

function Zonelist.change_priority(force_name, zone, priority)
  priority = math.min(math.max(priority, -Zonelist.priority_max), Zonelist.priority_max)
  local forcedata = global.forces[force_name]
  if zone.type == "spaceship" then
    forcedata.spaceship_priorities = forcedata.spaceship_priorities or {}
    forcedata.spaceship_priorities[zone.index] = priority
  else
    forcedata.zone_priorities = forcedata.zone_priorities or {}
    forcedata.zone_priorities[zone.index] = priority
  end
  for _, player in pairs(game.connected_players) do
    local window = Zonelist.get_main_window(player.index)
    if window then
      local zonelist_scroll = util.find_first_descendant_by_name(window, Zonelist.name_zonelist_scroll)

      local row = zonelist_scroll[(zone.type == "spaceship" and "spaceship" or "zone").."_"..zone.index]
      if row and row.row_flow and row.row_flow.cell_priority then
        local cell = row.row_flow.cell_priority
        cell.caption = priority
        if priority > 0 then
          cell.style.font_color = Zonelist.name_color_priority_positive
        elseif priority < 0 then
          cell.style.font_color = Zonelist.name_color_priority_negative
        else
          cell.style.font_color = Zonelist.name_color_priority_neutral
        end
      end
      local selected_zone = Zonelist.get_selected_zone_or_current(player.index)
      if selected_zone == zone then
        local textfield = util.find_first_descendant_by_name(window, Zonelist.name_zone_priority_field)
        textfield.text = priority
        if priority > 0 then
          textfield.style.font_color = Zonelist.name_color_priority_positive
        elseif priority < 0 then
          textfield.style.font_color = Zonelist.name_color_priority_negative
        else
          textfield.style.font_color = Zonelist.name_color_priority_neutral
        end
      end
    end
  end
end

function Zonelist.on_gui_text_changed(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local root = gui_element_or_parent(element, Zonelist.name_gui_root)
  if root then -- remote view
    if element.name == Zonelist.name_zonelist_search then
      Zonelist.gui_update_list(event.player_index)
    elseif element.name == Zonelist.name_zone_priority_field then
      local player = game.players[event.player_index]
      local zone = Zonelist.get_selected_zone_or_current(event.player_index)
      if zone.type ~= "spaceship" then
        local priority = util.string_to_number(element.text)
        if priority then
          Zonelist.change_priority(player.force.name, zone, priority)
        end
      end
    end
  end
end
Event.addListener(defines.events.on_gui_text_changed, Zonelist.on_gui_text_changed)

function Zonelist.on_lua_shortcut (event)
  if event.player_index
    and game.players[event.player_index]
    and game.players[event.player_index].connected then

      if event.prototype_name == Zonelist.name_shortcut then
        Zonelist.toggle_main_window(event.player_index)
      end

  end
end
Event.addListener(defines.events.on_lua_shortcut, Zonelist.on_lua_shortcut)

function Zonelist.on_universe_explorer_keypress (event)
  Zonelist.toggle_main_window(event.player_index)
end
Event.addListener(Zonelist.name_event, Zonelist.on_universe_explorer_keypress)

function Zonelist.on_gui_opened(event)
  local player_index = event.player_index
  local window = Zonelist.get_main_window(player_index)
  if window then
    window.destroy()
    game.players[player_index].opened = nil
  end
end
Event.addListener(defines.events.on_gui_opened, Zonelist.on_gui_opened)

return Zonelist
