Capsule = {}

-- constants
Capsule.name_space_capsule_gui_root = mod_prefix.."space-capsule-gui"
Capsule.name_space_capsule = mod_prefix.."space-capsule"
Capsule.name_space_capsule_vehicle = mod_prefix.."space-capsule-_-vehicle"
Capsule.name_space_capsule_vehicle_shadow = mod_prefix.."space-capsule-_-vehicle-shadow"
Capsule.name_space_capsule_vehicle_light = mod_prefix.."light-space-capsule"
Capsule.name_space_capsule_vehicle_light_launch = mod_prefix.."light-space-capsule-launch"

function Capsule.launch(vehicle)

  local current_zone = Zone.from_surface(vehicle.surface)
  if current_zone and Zone.is_space(current_zone) then

      local shadow = vehicle.surface.find_entities_filtered{ area=util.position_to_area(vehicle.position, 1), name=Capsule.name_space_capsule_vehicle_shadow}[1]
      local light = vehicle.surface.find_entities_filtered{ area=util.position_to_area(vehicle.position, 1), name=Capsule.name_space_capsule_vehicle_light}[1]
      if light then light.destroy() end
      light = vehicle.surface.create_entity{name = Capsule.name_space_capsule_vehicle_light_launch, position = vehicle.position, target=vehicle, speed = 0}

      local passengers = {} -- characters not players
      if vehicle.get_driver() then
        table.insert(passengers, vehicle.get_driver())
      end
      if vehicle.get_passenger() then
        table.insert(passengers, vehicle.get_passenger())
      end

      for _, passenger in pairs(passengers) do
        if passenger.valid then passenger.destructible = false end
          if remote.interfaces["jetpack"] and remote.interfaces["jetpack"]["block_jetpack"] then
          remote.call("jetpack", "block_jetpack", {character=passenger})
        end
        if passenger.player then
          close_own_guis(passenger.player)
        end
      end

      local target_zone = Zone.find_nearest_solid_zone_from_zone(current_zone)
      Zone.get_make_surface(target_zone)

      local zone_assets = Zone.get_force_assets(vehicle.force.name, target_zone.index)

      local landing_pads = {}
      if zone_assets.rocket_landing_pad_names then
        for name, pads in pairs(zone_assets.rocket_landing_pad_names) do
          for _, pad in pairs(pads) do
            table.insert(landing_pads, pad)
          end
        end
      end

      local destination_position
      if #landing_pads > 0 then
        local pad = landing_pads[math.random(#landing_pads)]
        if pad and pad.container and pad.container.valid then
          local surface = Zone.get_make_surface(target_zone)
          destination_position = surface.find_non_colliding_position(Capsule.name_space_capsule_vehicle, pad.container.position, 32, 1) or pad.container.position
        end
      end
      if not destination_position then
        destination_position = Zone.find_zone_landing_position(target_zone)
      end

      global.space_capsule_launches = global.space_capsule_launches or {}
      global.space_capsule_launches[vehicle.unit_number] = {
        force_name = vehicle.force.name,
        unit_number = vehicle.unit_number,
        vehicle = vehicle,
        shadow = shadow,
        light = light,
        start_position = vehicle.position,
        launch_progress = 1,
        destination_zone = target_zone,
        destination_position = destination_position,
        passengers = passengers,
      }

  else -- invalid
    if vehicle.get_driver() and vehicle.get_driver().player then
      vehicle.get_driver().player.print("Invalid launch location")
    end
    if vehicle.get_passenger() and vehicle.get_passenger().player then
      vehicle.get_driver().player.print("Invalid launch location")
    end
  end

end

function Capsule.gui_close (player)
  if player.gui.left[Capsule.name_space_capsule_gui_root] then
    player.gui.left[Capsule.name_space_capsule_gui_root].destroy()
  end
end

function Capsule.gui_open(player)

  local gui = player.gui.left
  close_own_guis(player)

  local container = gui.add{ type = "frame", name = Capsule.name_space_capsule_gui_root, style="space_platform_container", direction="vertical"}

  local zone = Zone.from_surface(player.surface)

  local title = container.add{ type="label", name="title", caption={"space-exploration.space-capsule"}, style="space_platform_title"}
  if not zone then
    container.add{ type="label", name="status", caption="Status: Invalid launch location."}
    container.add{ type="label", name="info", caption="If placed in space, this capsule can take you to the nearest planet or moon."}
  elseif Zone.is_solid(zone) then
    container.add{ type="label", name="status", caption="Not enough thrust to escape the ".. zone.type .. " " .. zone.name .. " gravity well. Insert into a Cargo Rocket Silo."}
    container.add{ type="label", name="info", caption="If placed in space, this capsule can take you to the nearest planet or moon."}
  else
    local destination = Zone.find_nearest_solid_zone_from_zone(zone)
    container.add{ type="label", name="info", caption="If placed in space, this capsule can take you to the nearest planet or moon."}
    if destination then
      container.add{ type="label", name="status", caption="Status: Ready to launch"}
      container.add{ type="label", name="destination", caption="Destination: " .. destination.name}
      local launch_button = container.add{ type="button", name="launch", caption={"space-exploration.button-launch"}, style="confirm_button"}
      launch_button.style.top_margin = 10
      launch_button.style.horizontally_stretchable  = true
      launch_button.style.horizontal_align = "left"
    else
      container.add{ type="label", name="status", caption="Status: Unknown start position"}
    end
  end

end


function Capsule.on_gui_click(event)
  if event.element and event.element.valid and event.element.name == "launch" then
    local element = event.element
    local root = gui_element_or_parent(element, Capsule.name_space_capsule_gui_root)
    if root then
      local player = game.players[event.player_index]
      local vehicle = player.vehicle
      if vehicle then
        Capsule.launch(vehicle)
      end
    end
  end

end
Event.addListener(defines.events.on_gui_click, Capsule.on_gui_click)


function Capsule.on_tick()

  if global.space_capsule_launches then
    for _, space_capsule in pairs(global.space_capsule_launches) do
      if not(space_capsule.vehicle and space_capsule.vehicle.valid) then
        global.space_capsule_launches[space_capsule.unit_number] = nil
        if space_capsule.rocket_sound and space_capsule.rocket_sound.valid then
          space_capsule.rocket_sound.destroy()
        end
        if space_capsule.light and space_capsule.light.valid then
          space_capsule.light.destroy()
        end
        if space_capsule.shadow and space_capsule.shadow.valid then
          space_capsule.shadow.destroy()
        end
      else
        space_capsule.launch_progress = space_capsule.launch_progress + 1
        local animation_speed = 1/3
        local animation_move_frame = 19
        local target_surface = Zone.get_make_surface(space_capsule.destination_zone)

        space_capsule.vehicle.destructible = false

        if space_capsule.launch_progress < animation_move_frame / animation_speed + 60 * 5 then
          local animation_frames = 24
          local animation_frame = math.max(math.min(math.floor(space_capsule.launch_progress * animation_speed), animation_frames), 1)

          if animation_frame == 1 and not space_capsule.sounds_frame_1 then
            space_capsule.sounds_frame_1 = true
            space_capsule.rocket_sound = space_capsule.vehicle.surface.create_entity{
              name=mod_prefix.."sound-continous-silo-rocket", position=space_capsule.vehicle.position, target=space_capsule.vehicle, speed=0}
            space_capsule.vehicle.surface.create_entity{
              name=mod_prefix.."sound-silo-clamps-on", position=space_capsule.vehicle.position, target=space_capsule.vehicle, speed=0}
            space_capsule.vehicle.surface.create_entity{
              name=mod_prefix.."sound-machine-close", position=space_capsule.vehicle.position, target=space_capsule.vehicle, speed=0}

          end
          if animation_frame == 19 and not space_capsule.sounds_frame_19 then
            space_capsule.sounds_frame_19 = true
            space_capsule.vehicle.surface.create_entity{
              name=mod_prefix.."sound-train-breaks", position=space_capsule.vehicle.position, target=space_capsule.vehicle, speed=0}
          end

          local move_progress = math.max( 0, space_capsule.launch_progress - (animation_move_frame / animation_speed))
          local move_y = math.pow( math.max(0, move_progress), 1.5) / 100
          local position = {
            x = space_capsule.start_position.x,
            y = space_capsule.start_position.y - move_y
          }

          if space_capsule.light then
            space_capsule.light.teleport({x = position.x, y = position.y + 1})
          end
          space_capsule.rocket_sound.teleport(position)
          space_capsule.vehicle.teleport(position)
          space_capsule.vehicle.orientation = (animation_frame - 1) / animation_frames
          if space_capsule.shadow then
            space_capsule.shadow.graphics_variation = animation_frame
            space_capsule.shadow.teleport({
              x = space_capsule.start_position.x + move_y,
              y = space_capsule.start_position.y
            })
          end
          for _, passenger in pairs(space_capsule.passengers) do
            if passenger.valid then
              passenger.teleport({x = position.x, y = position.y - 0.5}) -- behind graphic
            end
          end
        else
        -- done
          global.space_capsule_launches[space_capsule.unit_number] = nil
          space_capsule.rocket_sound.destroy()
          space_capsule.light.destroy()
          space_capsule.shadow.destroy()

          local safe_pos = target_surface.find_non_colliding_position(Capsule.name_space_capsule_vehicle, space_capsule.destination_position, 32, 1)
          safe_pos = safe_pos or space_capsule.destination_position
          target_surface.request_to_generate_chunks(safe_pos, 1)
          target_surface.force_generate_chunk_requests()
          local vehicle_2 = target_surface.create_entity{
            name = space_capsule.vehicle.name,
            position = safe_pos,
            force = space_capsule.vehicle.force
          }

          local inv_a = space_capsule.vehicle.get_inventory(defines.inventory.car_trunk)
          local inv_b = vehicle_2.get_inventory(defines.inventory.car_trunk)
          Util.copy_inventory(inv_a, inv_b)

          space_capsule.vehicle.destroy()
          space_capsule.vehicle = vehicle_2
          space_capsule.vehicle.orientation = 0
          space_capsule.shadow = target_surface.create_entity{name = Capsule.name_space_capsule_vehicle_shadow, position=safe_pos, force = "neutral"}
          space_capsule.shadow.graphics_variation = 1
          space_capsule.light = target_surface.create_entity{name = Capsule.name_space_capsule_vehicle_light, position = space_capsule.vehicle.position, speed = 0, target = space_capsule.vehicle}

          for _, passenger in pairs(space_capsule.passengers) do
            if passenger.valid then
              passenger.destructible = true
              if remote.interfaces["jetpack"] and remote.interfaces["jetpack"]["unblock_jetpack"] then
                remote.call("jetpack", "unblock_jetpack", {character=passenger})
              end
              teleport_character_to_surface(passenger, target_surface, safe_pos)
            end
          end
        end
      end
    end
  end

end
-- TODO: only register this if that are any
Event.addListener(defines.events.on_tick, Capsule.on_tick)

function Capsule.on_entity_removed(event)
  local entity = event.entity
  if entity and entity.valid then
    if entity.name == Capsule.name_space_capsule_vehicle then
      local shadow = entity.surface.find_entities_filtered{ area=util.position_to_area(entity.position, 1), name=Capsule.name_space_capsule_vehicle_shadow}[1]
      local light = entity.surface.find_entities_filtered{ area=util.position_to_area(entity.position, 1), name=Capsule.name_space_capsule_vehicle_light}[1]
      if shadow then shadow.destroy() end
      if light then light.destroy() end
    end
  end
end
Event.addListener(defines.events.on_entity_died, Capsule.on_entity_removed)
Event.addListener(defines.events.on_robot_mined_entity, Capsule.on_entity_removed)
Event.addListener(defines.events.on_player_mined_entity, Capsule.on_entity_removed)
Event.addListener(defines.events.script_raised_destroy, Capsule.on_entity_removed)

function Capsule.on_player_driving_changed_state(event)
  local player = game.players[event.player_index]
  if player then
    if player.vehicle and player.vehicle.name == Capsule.name_space_capsule_vehicle then
      Capsule.gui_open(player)
    elseif player.gui.left[Capsule.name_space_capsule_gui_root] then
      player.gui.left[Capsule.name_space_capsule_gui_root].destroy()
    end
  end
end
Event.addListener(defines.events.on_player_driving_changed_state, Capsule.on_player_driving_changed_state)

function Capsule.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.name == Capsule.name_space_capsule_vehicle then
    entity.orientation = 0
    entity.surface.create_entity{name = Capsule.name_space_capsule_vehicle_shadow, position = entity.position, force="neutral"}
    entity.surface.create_entity{name = Capsule.name_space_capsule_vehicle_light, position = entity.position, speed = 0, target = entity}
  end
end
Event.addListener(defines.events.on_built_entity, Capsule.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, Capsule.on_entity_created)
Event.addListener(defines.events.script_raised_built, Capsule.on_entity_created)
Event.addListener(defines.events.script_raised_revive, Capsule.on_entity_created)

return Capsule
