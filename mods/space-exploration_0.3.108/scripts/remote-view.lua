local RemoteView = {}
--[[
Nivigation View.
Remote view is the system that detatches the player from the character.
It displays a small you-are-here window on the top left with a buttons to:
  Open the zone list
  View the starmap
  Return to your body

]]--

-- constants
RemoteView.name_gui_root = mod_prefix.."remote-view"
RemoteView.name_shortcut = mod_prefix.."remote-view"
RemoteView.name_event = mod_prefix.."remote-view"
RemoteView.name_permissions_group = mod_prefix.."remote-view"
RemoteView.name_starmap_surface = "Starmap"
RemoteView.name_window_close = "remote-view-close"
RemoteView.name_button_zonelist = "remote-view-open_zonelist"

function RemoteView.get_stack_limit(stack) -- must be lua item stack, not simple stack
  local name = stack.name
  local type = stack.type
  if type == "blueprint"
    or type == "blueprint-book"
    or type == "deconstruction-item"
    or type == "selection-tool"
    or type == "upgrade-item"
    or type == "copy-paste-tool"
    or type == "cut-paste-tool" then
      return stack.count
  end
  if name == "artillery-targeting-remote" or name == "ion-cannon-targeter" or name == "spidertron-remote" then -- type == "capsule"
    return stack.count
  end
  if name == "red-wire"
    or name == "green-wire"
    or name == "copper-cable" then
      return 2
  end
  return 0
end

function RemoteView.drop_stack(player, stack, drop_count, drop_to_ground)
  if player and player.connected and RemoteView.is_active(player) then
    local entity = player.opened or player.selected
    if entity then
      local inserted = entity.insert({name = stack.name, count = drop_count})
      if inserted < drop_count and drop_to_ground == true then
        player.surface.spill_item_stack(
          entity.position,
          {name = stack.name, count = drop_count - inserted},
          false, -- lootable
          player.force, -- deconstruct by force
          false) -- allow belts
      end
    elseif drop_to_ground then
      local limit = RemoteView.get_stack_limit(stack)
      if limit == 0 then
        player.surface.spill_item_stack(
          player.position,
          {name = stack.name, count = drop_count},
          false, -- lootable
          player.force, -- deconstruct by force
          false) -- allow belts
      end
    end
  end
end

function RemoteView.on_player_crafted_item(event)
  if not(event.item_stack and event.item_stack.valid_for_read) then return end
  local player = game.players[event.player_index]
  if player and player.connected and RemoteView.is_active(player) then
    local limit = RemoteView.get_stack_limit(event.item_stack)
    if limit > 0 then
      player.cursor_stack.set_stack(event.item_stack)
      if event.item_stack.count > limit then
        RemoteView.drop_stack(player, event.item_stack, event.item_stack.count - limit, false)
      end
      event.item_stack.count = limit
    else
      player.cursor_ghost = event.item_stack.prototype
      event.item_stack.count = 0
    end
  end
end
Event.addListener(defines.events.on_player_crafted_item, RemoteView.on_player_crafted_item)

function RemoteView.on_player_pipette(event)
  local player = game.players[event.player_index]
  if player and player.connected and RemoteView.is_active(player) then
    player.cursor_stack.clear()
    player.cursor_ghost = event.item
  end
end
Event.addListener(defines.events.on_player_pipette, RemoteView.on_player_pipette)

function RemoteView.on_player_cursor_stack_changed(event)
  local player = game.players[event.player_index]
  if player and player.connected and RemoteView.is_active(player) then
    local stack = player.cursor_stack
    if stack and stack.valid_for_read then
      local limit = RemoteView.get_stack_limit(stack)
      if limit > 0 then
        if stack.count > limit then
          if stack.name == "red-wire"
            or stack.name == "green-wire"
            or stack.name == "copper-cable" then
          --wire shortcuts mod messes things up
        else
          RemoteView.drop_stack(player, stack, stack.count - limit, true)
        end
        end
        stack.count = limit
      else
        RemoteView.drop_stack(player, stack, stack.count, true)
        player.cursor_ghost = stack.prototype
        player.cursor_stack.clear()
      end
    end
  end
end
Event.addListener(defines.events.on_player_cursor_stack_changed, RemoteView.on_player_cursor_stack_changed)

function RemoteView.on_player_main_inventory_changed(event)
  local player = game.players[event.player_index]
  if player and player.connected and RemoteView.is_active(player) then
    local inv = player.get_main_inventory()
    for i = 1, #inv do
      local stack = inv[i]
      if stack and stack.valid_for_read then
        local limit = RemoteView.get_stack_limit(stack)
        if limit > 0 then
          stack.count = limit
        else
          RemoteView.drop_stack(player, stack, stack.count, true)
          stack.count = 0
        end
      end
    end
  end
end
Event.addListener(defines.events.on_player_main_inventory_changed, RemoteView.on_player_main_inventory_changed)

function RemoteView.get_make_permission_group()
  local remote_view_permissions = game.permissions.get_group(RemoteView.name_permissions_group)
  --if remote_view_permissions then remote_view_permissions.destroy() remote_view_permissions = nil end -- debug
  if not remote_view_permissions then
    remote_view_permissions = game.permissions.create_group(RemoteView.name_permissions_group)
  end

  for _, action in pairs({
    defines.input_action.begin_mining_terrain	,
    defines.input_action.change_riding_state	,
    defines.input_action.change_shooting_state	,
    defines.input_action.cursor_split	,
    defines.input_action.destroy_opened_item	,
    defines.input_action.drop_item ,
    defines.input_action.fast_entity_split	,
    defines.input_action.fast_entity_transfer	,
    defines.input_action.inventory_split	,
    defines.input_action.inventory_transfer	,
    defines.input_action.map_editor_action	,
    defines.input_action.open_equipment	,
    defines.input_action.place_equipment	,
    defines.input_action.set_car_weapons_control	,
    defines.input_action.stack_split	,
    defines.input_action.stack_transfer	,
    defines.input_action.start_repair	,
    defines.input_action.take_equipment	,
    defines.input_action.toggle_driving	,
    defines.input_action.toggle_map_editor ,
  }) do
    remote_view_permissions.set_allows_action(action, false)
  end
  for _, action in pairs({
    defines.input_action.begin_mining	, -- allows mining ghosts, -- player.mining_state = {mining = false} stops actual mining
    defines.input_action.build_item,
    defines.input_action.build_rail	,
    defines.input_action.build_terrain,
    defines.input_action.change_picking_state,
    defines.input_action.craft	,
    defines.input_action.cursor_transfer,
    defines.input_action.open_character_gui	,
    defines.input_action.open_item	,
    defines.input_action.remove_cables	,
    defines.input_action.rotate_entity	,
    defines.input_action.start_walking	,
    defines.input_action.smart_pipette	,
    defines.input_action.undo	,
    defines.input_action.use_item	,
    defines.input_action.wire_dragging,
  }) do
    remote_view_permissions.set_allows_action(action, true)
  end

  return remote_view_permissions
end

function RemoteView.gui_close (player)
  if player.gui.left[RemoteView.name_gui_root] then
    player.gui.left[RemoteView.name_gui_root].destroy()
  end
end

function RemoteView.gui_update (player) -- only call when something changed

  root = player.gui.left[RemoteView.name_gui_root]
  if root then

    if root.currently_viewing_frame and root.currently_viewing_frame.currently_viewing_value then
      --root.current.caption = {"space-exploration.currently-viewing", current_zone and current_zone.name or player.surface.name}
      local zone = Zone.from_surface(player.surface)
      if zone then
        root.currently_viewing_frame.currently_viewing_value.caption = Zone.dropdown_name_from_zone(zone, true)
      else
        root.currently_viewing_frame.currently_viewing_value.caption = player.surface.name
      end

    end

  end
end


function RemoteView.gui_open (player)

  local gui = player.gui.left
  close_own_guis(player)
  RemoteView.gui_close(player)
  local playerdata = get_make_playerdata(player)

  local main = gui.add{ type = "frame", name = RemoteView.name_gui_root, style="space_platform_container", direction="vertical"}
  main.style.horizontally_stretchable = true
  main.style.padding = 12
  main.style.top_padding = 6

  local title_table = main.add{type="table", name="title_table", column_count=2, draw_horizontal_lines=false}
  title_table.style.horizontally_stretchable = true
  title_table.style.column_alignments[1] = "left"
  title_table.style.column_alignments[2] = "right"

  local title_frame = title_table.add{type="frame", name="title_frame", caption={"space-exploration.remote-view-window-title"}, style="informatron_title_frame"}
  title_frame.style.right_padding = -5

  local right_flow = title_table.add{type="flow", name="title_flow_right"}
  --local list = right_flow.add{type="button", name=RemoteView.name_button_zonelist, caption="≡", style="informatron_close_button", tooltip={"space-exploration.open-zonelist"}}
  local list = right_flow.add{type="sprite-button", name=RemoteView.name_button_zonelist, sprite = "virtual-signal/se-planet-orbit", style="informatron_close_button", tooltip={"space-exploration.zonelist-window-title"}}
  list.style.width = 28
  list.style.height = 28
  list.style.right_margin = 6
  --local close = right_flow.add{type="button", name=RemoteView.name_window_close, caption="✖", style="informatron_close_button", tooltip={"space-exploration.exit-remote-view"}}
  local close = right_flow.add{type="sprite-button", name=RemoteView.name_window_close, sprite = "utility/close_white", style="informatron_close_button", tooltip={"space-exploration.exit-remote-view"}}
  close.style.width = 28
  close.style.height = 28

  local currently_viewing_label = main.add{type="label", name="currently_viewing_label", caption={"space-exploration.remote-view-currently-viewing"}} -- left
  currently_viewing_label.style.font_color = {r=0.5,g=0.5,b=0.5}

  local currently_viewing_frame = main.add{type="frame", name="currently_viewing_frame", style="informatron_inside_deep_frame"}
  currently_viewing_frame.style.horizontally_stretchable = true
  currently_viewing_frame.style.width = 280
  currently_viewing_frame.style.padding = 10
  currently_viewing_frame.style.top_padding = 6

  --local currently_viewing_table = currently_viewing_frame.add{type="table", name="currently_viewing_table", column_count=2, draw_horizontal_lines=false}
  --currently_viewing_table.style.horizontally_stretchable = true
  --currently_viewing_table.style.column_alignments[1] = "left"
  --currently_viewing_table.style.column_alignments[2] = "right"


  local currently_viewing_value = currently_viewing_frame.add{type="label", name="currently_viewing_value", style = "heading_2_label"} -- right
  currently_viewing_value.style.horizontally_stretchable = true
  --currently_viewing_value.style.horizontal_align = "right"

  RemoteView.gui_update (player)
end


function RemoteView.start_starmap (player)

  RemoteView.start (player, nil)
  if player.character then return end -- failed

  if not game.surfaces[RemoteView.name_starmap_surface] then
    local mapgen_settings = {}
    mapgen_settings.property_expression_names = {}
    mapgen_settings.property_expression_names["tile:out-of-map:probability"] = math.huge
    game.create_surface(RemoteView.name_starmap_surface, mapgen_settings)
  end

  local surface = game.surfaces[RemoteView.name_starmap_surface]
  surface.daytime = 0;
  surface.freeze_daytime = true

  local scale = 0.25
  local text_offset = {x = 0.6, y = -0.4}

  local from_surface = player.surface
  if from_surface.name == RemoteView.name_starmap_surface then return end
  local from_zone = Zone.from_surface(from_surface)
  local start_stellar_position = nil
  if from_zone then
    start_stellar_position = Zone.get_stellar_position(from_zone)
  end
  if not start_stellar_position then start_stellar_position = {x = 0, y = 0} end

  RemoteView.stop_starmap(player)
  player.teleport(Util.vector_multiply(start_stellar_position, scale), surface)


  local playerdata = get_make_playerdata(player)
  local forcedata = global.forces[player.force.name]
  playerdata.starmap_objects = {}
  for _, star in pairs(global.universe.stars) do
    --[[local object_id = rendering.draw_sprite{
      sprite = "virtual-signal.se-star",
      surface = surface,
      target = Util.vector_multiply(star.stellar_position, scale),
      players = {player}
    }
    table.insert(playerdata.starmap_objects, object_id)]]--
    local object_id = rendering.draw_sprite{
      sprite = mod_prefix.."starmap-star",
      surface = surface,
      target = Util.vector_multiply(star.stellar_position, scale),
      players = {player},
      x_scale = 0.05,
      y_scale = 0.05,
      render_layer = 28, -- just above decals
    }
    table.insert(playerdata.starmap_objects, object_id)
    local object_id = rendering.draw_animation{
      animation = mod_prefix.."starmap-star-cloud",
      surface = surface,
      target = Util.vector_multiply(star.stellar_position, scale),
      players = {player},
      x_scale = 0.05,
      y_scale = 0.05,
      animation_speed = -1,
      tint = {r=255/255, g=100/255, b=5/255}
    }
    table.insert(playerdata.starmap_objects, object_id)
    if forcedata.zones_discovered[star.index] then
      local object_id = rendering.draw_text{
        text = star.name,
        surface = surface,
        target = Util.vectors_add(text_offset, Util.vector_multiply(star.stellar_position, scale)),
        players = {player},
        color = {r=255, g=128, b=0, a=255},
        scale_with_zoom = false,
        scale = 1.2
      }
      table.insert(playerdata.starmap_objects, object_id)
    end
  end
  for _, zone in pairs(global.universe.space_zones) do
    if forcedata.zones_discovered[zone.index] then
      local object_id = rendering.draw_sprite{
        sprite = "virtual-signal.se-asteroid-field",
        surface = surface,
        target = Util.vector_multiply(zone.stellar_position, scale),
        players = {player}
      }
      table.insert(playerdata.starmap_objects, object_id)
      local object_id = rendering.draw_text{
        text = zone.name,
        surface = surface,
        target = Util.vectors_add(text_offset, Util.vector_multiply(zone.stellar_position, scale)),
        players = {player},
        color = {r=255, g=255, b=255, a=128},
        scale_with_zoom = false,
      }
      table.insert(playerdata.starmap_objects, object_id)
    end
  end
  for _, spaceship in pairs(global.spaceships) do
    if spaceship.force_name == player.force.name then
      local object_id = rendering.draw_sprite{
        sprite = "virtual-signal.se-spaceship",
        surface = surface,
        target = Util.vector_multiply(spaceship.stellar_position, scale),
        players = {player}
      }
      table.insert(playerdata.starmap_objects, object_id)
      local object_id = rendering.draw_text{
        text = spaceship.name,
        surface = surface,
        target = Util.vectors_add(text_offset, Util.vector_multiply(spaceship.stellar_position, scale)),
        players = {player},
        color = {r=0, g=255, b=255, a=255},
        scale_with_zoom = false,
      }
      table.insert(playerdata.starmap_objects, object_id)
    end
  end

  RemoteView.gui_update (player)
end

function RemoteView.stop_starmap (player)
  -- just delete the starmap graphics for this player
  local playerdata = get_make_playerdata(player)
  if playerdata.starmap_objects then
    for _, object_id in pairs(playerdata.starmap_objects) do
      rendering.destroy(object_id)
    end
  end
  playerdata.starmap_objects = nil
end

function RemoteView.stop (player)
  player.cheat_mode = false
  local playerdata = get_make_playerdata(player)
  -- exit remote view
  if playerdata.remote_view_active then
    playerdata.remote_view_active = nil
    playerdata.remote_view_activity = nil
    RemoteView.gui_close(player)
    RemoteView.stop_starmap(player)
    player.permission_group = nil
    if playerdata.character and playerdata.character.valid then
      if playerdata.anchor_scouting_for_spaceship_index then
        player.set_controller{type = defines.controllers.ghost}
      else
        player.teleport(playerdata.character.position, playerdata.character.surface)
        player.set_controller{type = defines.controllers.character, character = playerdata.character}
      end
    elseif not player.character then
      Respawn.die(player)
    end
  end

end

function RemoteView.is_unlocked(player)
  if global.debug_view_all_zones or
   (global.forces[player.force.name]
    and global.forces[player.force.name].satellites_launched > 0) then
      return true
  end
  return false
end

function RemoteView.start (player, zone)
  if RemoteView.is_unlocked(player) then
    local playerdata = get_make_playerdata(player)
    Spaceship.stop_anchor_scouting(player)

    local character = player.character
    -- enter remote view
    if not playerdata.remote_view_active then
      playerdata.remote_view_active = true


      --player.set_controller{type = defines.controllers.spectator}
      --player.set_controller{type = defines.controllers.ghost}
      player.set_controller{type = defines.controllers.god}
      player.cheat_mode = true
    end

    player.permission_group = RemoteView.get_make_permission_group()

    if character then
      playerdata.character = character
      -- stop the character from continuing input action (running to doom)
      character.walking_state = {walking = false, direction = defines.direction.south}
      character.riding_state = {acceleration = defines.riding.acceleration.braking, direction = defines.riding.direction.straight}
      character.shooting_state = {state = defines.shooting.not_shooting, position=character.position}
    end

    if not zone then
      zone = Zone.from_surface(player.surface)
    end
    if not zone then
      local vault = Ancient.vault_from_surface(player.surface)
      if vault then
        zone = Zone.from_zone_index(vault.zone_index)
      end
    end
    if not zone then
      zone = Zone.get_default()
    end
    if zone then
      playerdata.remote_view_curret_zone = zone
      if zone.type == "spaceship" then
        local spaceship = zone
        if spaceship.console and spaceship.console.valid then
          player.teleport(spaceship.console.position, spaceship.console.surface)
        else
          local surface = Spaceship.get_current_surface(zone)
          if spaceship.known_tiles_average_x and spaceship.known_tiles_average_y then
            player.teleport({spaceship.known_tiles_average_x,spaceship.known_tiles_average_y}, surface)
          else
            player.teleport({0,0}, surface)
          end
        end
      else
        local surface = Zone.get_make_surface(zone)
        local position = {x=0,y=0}
        local playerdata = get_make_playerdata(player)
        if playerdata.surface_positions and playerdata.surface_positions[surface.index] then
          position = playerdata.surface_positions[surface.index]
        else
          player.force.chart(surface, util.position_to_area({x = 0, y = 0}, 256))
        end
        player.teleport(position, surface)
        Zone.apply_markers(zone) -- in case the surface exists
      end
    end

    -- add zone select gui
    RemoteView.gui_open(player)
  else
    player.print({"space-exploration.remote-view-requires-satellite"})
  end
end

function RemoteView.is_active (player)
  return get_make_playerdata(player).remote_view_active == true
end

function RemoteView.toggle (player)
  if RemoteView.is_active(player) then
    RemoteView.stop(player)
  else
    RemoteView.start(player)
  end
end

function RemoteView.on_gui_click (event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]

  root = gui_element_or_parent(element, RemoteView.name_gui_root)
  if root then -- remote view
    if element.name == RemoteView.name_window_close then
      RemoteView.stop(player)
    elseif element.name == RemoteView.name_button_zonelist then
      Zonelist.toggle_main_window(event.player_index)
    end
    return
  end
end
Event.addListener(defines.events.on_gui_click, RemoteView.on_gui_click)

function RemoteView.on_lua_shortcut (event)
  if event.player_index
    and game.players[event.player_index]
    and game.players[event.player_index].connected then

      if event.prototype_name == RemoteView.name_shortcut then
        RemoteView.toggle(game.players[event.player_index])
      end

  end
end
Event.addListener(defines.events.on_lua_shortcut, RemoteView.on_lua_shortcut)

function RemoteView.on_remote_view_keypress (event)
  if event.player_index
    and game.players[event.player_index]
    and game.players[event.player_index].connected
  then
      RemoteView.toggle(game.players[event.player_index])
  end
end
Event.addListener(RemoteView.name_event, RemoteView.on_remote_view_keypress)

function RemoteView.on_player_clicked_gps_tag (event)
  local player = game.players[event.player_index]
  if not player then return end
  local surface = game.surfaces[event.surface]
  if surface then
    local zone = Zone.from_surface(surface)
    if not zone then
      if event.surface ~= player.surface.name then
        return player.print("The GPS tag is on a different surface which cannot be viewed via satellite.")
      end
    else
      if not RemoteView.is_unlocked(player) then
        if event.surface ~= player.surface.name then
          return player.print("The GPS tag is on a different surface, launch a satellite to view the location.")
        else
          -- default to map shift with no message
        end
      else
        if Zone.is_visible_to_force(zone, player.force.name) then
          local playerdata = get_make_playerdata(player)
          RemoteView.start(player, zone)
          if playerdata.remote_view_active then
            player.teleport(event.position)
          end
          player.close_map()
          player.zoom = 0.3
        else
          player.print("Cannot view location via satellite, zone is not discovered.")
        end
      end
    end
  else
    player.print("GPS tag specifies invalid surface.")
  end
end
Event.addListener(defines.events.on_player_clicked_gps_tag, RemoteView.on_player_clicked_gps_tag)

return RemoteView
