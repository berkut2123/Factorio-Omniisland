local Meteor = {}

Meteor.name_meteor_defence = mod_prefix.."meteor-defence"
Meteor.name_meteor_defence_container = mod_prefix.."meteor-defence-container"
Meteor.name_meteor_defence_charger = mod_prefix.."meteor-defence-charger"
Meteor.name_meteor_defence_ammo = mod_prefix.."meteor-defence-ammo"
Meteor.name_meteor_defence_beam = mod_prefix.."meteor-defence-beam"
Meteor.name_meteor_defence_beam_offset = {x = -1, y = -5}

Meteor.name_meteor_point_defence = mod_prefix.."meteor-point-defence"
Meteor.name_meteor_point_defence_container = mod_prefix.."meteor-point-defence-container"
Meteor.name_meteor_point_defence_charger = mod_prefix.."meteor-point-defence-charger"
Meteor.name_meteor_point_defence_ammo = mod_prefix.."meteor-point-defence-ammo"
Meteor.name_meteor_point_defence_beam = mod_prefix.."meteor-point-defence-beam"
Meteor.name_meteor_point_defence_beam_offsets = {
  {x = 0.1, y = -3.5},
  {x = 0.4, y = -3.1},
  {x = -0.3, y = -3.4},
  {x = 0.7, y = -3.2},
}

Meteor.defence_accuracy = 0.8
Meteor.defence_full_power = 2000 * 1000000

Meteor.point_defence_range = 64
Meteor.point_defence_accuracy = 0.5
Meteor.point_defence_full_power = 200 * 1000000

Meteor.meteor_swarm_altitude = 100
Meteor.meteor_swarm_x_deviation = Meteor.meteor_swarm_altitude

Meteor.meteor_fall_time = 2 * 60
Meteor.meteor_chain_delay = 10

Meteor.meteor_random_range = 512
Meteor.meteor_variants = 16
Meteor.meteor_position_deviation = 10
Meteor.meteor_chain_distance = 10

Meteor.tick_skip = 10

function Meteor.on_player_selected_or_opened_changed(event)
  local player = game.players[event.player_index]
  local playerdata = get_make_playerdata(player)
  if playerdata.meteor_point_defence_radius then
    if not (
      (player.selected and player.selected.name ==  Meteor.name_meteor_point_defence_container)
    or (player.opened and player.opened_gui_type == defines.gui_type.entity and player.opened.name == Meteor.name_meteor_point_defence_container) ) then
      if rendering.is_valid(playerdata.meteor_point_defence_radius) then
        rendering.destroy(playerdata.meteor_point_defence_radius)
      end
      playerdata.meteor_point_defence_radius = nil
    end
  end
end

Event.addListener(defines.events.on_gui_opened, Meteor.on_player_selected_or_opened_changed)
Event.addListener(defines.events.on_selected_entity_changed, Meteor.on_selected_entity_changed)

function Meteor.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.name == Meteor.name_meteor_defence_container
   or entity.name == Meteor.name_meteor_point_defence_container  then

    local zone = Zone.from_surface(entity.surface)
    if zone and zone.type ~= "spaceship" then
      if entity.name == Meteor.name_meteor_defence_container then
        entity.active = false
        local charger = entity.surface.create_entity{
          name = Meteor.name_meteor_defence_charger,
          position = entity.position,
          direction = entity.direction,
          force = entity.force
        }
        charger.destructible = false

        if not zone.meteor_defences then
          zone.meteor_defences = {}
        end
        zone.meteor_defences[entity.unit_number] = {
          unit_number = entity.unit_number,
          container = entity,
          charger = charger,
        }

      else
        entity.active = false
        local charger = entity.surface.create_entity{
          name = Meteor.name_meteor_point_defence_charger,
          position = entity.position,
          direction = entity.direction,
          force = entity.force
        }
        charger.destructible = false
        charger.energy = 0

        if not zone.meteor_point_defences then
          zone.meteor_point_defences = {}
        end
        zone.meteor_point_defences[entity.unit_number] = {
          unit_number = entity.unit_number,
          container = entity,
          charger = charger,
        }

      end
      -- add to list of zones where meteors can appear
      global.meteor_zones = global.meteor_zones or {}
      global.meteor_zones[zone.index] = zone

    else
      cancel_entity_creation(entity, event.player_index, "Cannot be placed here.")
      return
    end
  elseif entity.type == "electric-pole" then
    local zone = Zone.from_surface(entity.surface)
    if zone and zone.type ~= "spaceship" then
      global.meteor_zones = global.meteor_zones or {}
      global.meteor_zones[zone.index] = zone
    end
  end
end
Event.addListener(defines.events.on_built_entity, Meteor.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, Meteor.on_entity_created)
Event.addListener(defines.events.script_raised_built, Meteor.on_entity_created)
Event.addListener(defines.events.script_raised_revive, Meteor.on_entity_created)

function Meteor.on_removed_entity(event)
  if event.entity and event.entity.valid and event.entity.surface then
    if event.entity.name == Meteor.name_meteor_defence_charger then
       local entity = event.entity
       local charger = entity.surface.find_entity(Meteor.name_meteor_defence_container, entity.position)
       if charger then charger.destroy() end
    elseif event.entity.name == Meteor.name_meteor_defence_container then
       local entity = event.entity
       local charger = entity.surface.find_entity(Meteor.name_meteor_defence_charger, entity.position)
       if charger then charger.destroy() end
    elseif event.entity.name == Meteor.name_meteor_point_defence_charger then
       local entity = event.entity
       local charger = entity.surface.find_entity(Meteor.name_meteor_point_defence_container, entity.position)
       if charger then charger.destroy() end
    elseif event.entity.name == Meteor.name_meteor_point_defence_container then
       local entity = event.entity
       local charger = entity.surface.find_entity(Meteor.name_meteor_point_defence_charger, entity.position)
       if charger then charger.destroy() end
    end
  end
end
Event.addListener(defines.events.on_entity_died, Meteor.on_removed_entity)
Event.addListener(defines.events.on_robot_mined_entity, Meteor.on_removed_entity)
Event.addListener(defines.events.on_player_mined_entity, Meteor.on_removed_entity)
Event.addListener(defines.events.script_raised_destroy, Meteor.on_removed_entity)

function Meteor.tick_meteor_shower(meteor_shower)
  if type(meteor_shower.remaining_meteors) ~= "table" then
    meteor_shower.valid = false
    return
  end

  if meteor_shower.skip and meteor_shower.skip > 0 then
    meteor_shower.skip = meteor_shower.skip - Meteor.tick_skip
    return
  end

  if #meteor_shower.remaining_meteors == 0 then

    -- no meteors left, defences won, vistory message
    meteor_shower.valid = false
    Meteor.meteor_shower_alert(meteor_shower)
    return

  end

  local surface = Zone.get_make_surface(meteor_shower.zone)
  if meteor_shower.zone.meteor_defences then
    for _, defence in pairs(meteor_shower.zone.meteor_defences) do
      local charger = defence.charger
      if defence.charger and defence.charger.valid and defence.container and defence.container.valid then
        if charger.energy >= Meteor.defence_full_power * 0.99 then
          local inv = defence.container.get_inventory(defines.inventory.turret_ammo)
          local contents = inv.get_contents()
          if contents[Meteor.name_meteor_defence_ammo] and contents[Meteor.name_meteor_defence_ammo] > 0 then
            -- this defence is ready to fire
            local take = 1
            inv.remove({name=Meteor.name_meteor_defence_ammo, count=take})
            charger.force.item_production_statistics.on_flow(Meteor.name_meteor_defence_ammo, -take)
            charger.energy = 0
            meteor_shower.skip = 60

            meteor_shower.defences_activated = meteor_shower.defences_activated + 1
            if math.random() < Meteor.defence_accuracy then
              Meteor.credit_kill(defence.container)
              meteor_shower.remaining_meteors[math.random(#meteor_shower.remaining_meteors)] = nil
              local remaining_meteors = {}
              for _, meteor in pairs(meteor_shower.remaining_meteors) do
                table.insert(remaining_meteors, meteor)
              end
              meteor_shower.remaining_meteors = remaining_meteors
            end
            surface.create_entity{
              name = Meteor.name_meteor_defence_beam,
              position = Util.vectors_add(charger.position, Meteor.name_meteor_defence_beam_offset),
              target = Util.vectors_add(charger.position, {x = 0, y = -Meteor.meteor_swarm_altitude})
            }
            return
          end
        end
      end
    end
  end

  -- try point defence
  if meteor_shower.zone.meteor_point_defences then
    for _, defence in pairs(meteor_shower.zone.meteor_point_defences) do
      local charger = defence.charger
      if defence.charger and defence.charger.valid and defence.container and defence.container.valid then
        for remaining_index, meteor in pairs(meteor_shower.remaining_meteors) do
          if charger.energy >= Meteor.point_defence_full_power * 0.25 and Util.vectors_delta_length(meteor.land_position, defence.charger.position) <= Meteor.point_defence_range then
            local inv = defence.container.get_inventory(defines.inventory.turret_ammo)
            local contents = inv.get_contents()
            if contents[Meteor.name_meteor_point_defence_ammo] and contents[Meteor.name_meteor_point_defence_ammo] > 0 then
              -- this defence is ready to fire

                local take = 1
                inv.remove({name=Meteor.name_meteor_point_defence_ammo, count=take})
                charger.force.item_production_statistics.on_flow(Meteor.name_meteor_point_defence_ammo, -take)
                charger.energy = charger.energy - Meteor.point_defence_full_power * 0.25

                defence.barrel = (defence.barrel or 0) % 4 + 1
                surface.create_entity{
                  name = Meteor.name_meteor_point_defence_beam,
                  position = Util.vectors_add(charger.position, Meteor.name_meteor_point_defence_beam_offsets[defence.barrel]),
                  target = Util.vectors_add(charger.position, {x = 0, y = -Meteor.meteor_swarm_altitude})
                }

                meteor_shower.point_defences_activated = meteor_shower.point_defences_activated + 1
                if math.random() < Meteor.point_defence_accuracy then
                  Meteor.credit_kill(defence.container)

                  meteor_shower.remaining_meteors[remaining_index] = nil
                  local remaining_meteors = {}
                  for _, meteor in pairs(meteor_shower.remaining_meteors) do
                    table.insert(remaining_meteors, meteor)
                  end
                  meteor_shower.remaining_meteors = remaining_meteors
                end

                return
            end
          end
        end
      end
    end

  end

  if meteor_shower.defences_activated or meteor_shower.point_defences_activated > 0 then
    -- there were defences, meteors win, show defence status message
    Meteor.meteor_shower_alert(meteor_shower)
  end

  meteor_shower.valid = false
  Meteor.spawn_meteor_shower(meteor_shower)

end

function Meteor.meteor_shower_alert(meteor_shower)

  local meteor_defences = 0
  local meteor_defences_ready = 0
  local meteor_defences_shot_fired = meteor_shower.defences_activated

  local meteor_point_defences = 0
  local meteor_point_defences_ready = 0
  local meteor_point_defence_shots_fired = meteor_shower.point_defences_activated

  if meteor_shower.zone.meteor_defences then
    for _, defence in pairs(meteor_shower.zone.meteor_defences) do
      meteor_defences = meteor_defences + 1
      local charger = defence.charger
      if defence.charger and defence.charger.valid and defence.container and defence.container.valid then
        if charger.energy >= Meteor.defence_full_power * 0.99 then
          local inv = defence.container.get_inventory(defines.inventory.turret_ammo)
          local contents = inv.get_contents()
          if contents[Meteor.name_meteor_defence_ammo] and contents[Meteor.name_meteor_defence_ammo] > 0 then
            meteor_defences_ready = meteor_defences_ready + 1
          end
        end
      end
    end
  end

  -- try point defence
  if meteor_shower.zone.meteor_point_defences then
    for _, defence in pairs(meteor_shower.zone.meteor_point_defences) do
      meteor_point_defences = meteor_point_defences + 1
      local charger = defence.charger
      if defence.charger and defence.charger.valid and defence.container and defence.container.valid then
        if charger.energy >= Meteor.point_defence_full_power * 0.25 then
          local inv = defence.container.get_inventory(defines.inventory.turret_ammo)
          local contents = inv.get_contents()
          if contents[Meteor.name_meteor_point_defence_ammo] and contents[Meteor.name_meteor_point_defence_ammo] > 0 then
            meteor_point_defences_ready = meteor_point_defences_ready + 1
          end
        end
      end
    end
  end

  local surface = Zone.get_make_surface(meteor_shower.zone)
  local dummy = surface.create_entity{name = mod_prefix.."dummy-explosion", position = meteor_shower.land_position}
  local message = "[img=virtual-signal/se-meteor] " .. (#meteor_shower.meteors - #meteor_shower.remaining_meteors).."/"..#meteor_shower.meteors.." meteors destroyed. "
  message = message .. "[gps="..math.floor(meteor_shower.land_position.x)..","..math.floor(meteor_shower.land_position.y).."]"
  message = message .. "\n [img=item/se-meteor-defence] " .. meteor_defences_shot_fired.." shots fired. ".. meteor_defences_ready.."/"..meteor_defences.." structures remain ready."
  message = message .. "\n [img=item/se-meteor-point-defence] " .. meteor_point_defence_shots_fired.." shots fired. ".. meteor_point_defences_ready.."/"..meteor_point_defences.." structures remain ready."

  for _, player in pairs(game.connected_players) do
    if player.surface.index == surface.index then
      player.add_custom_alert( dummy, {type = "virtual", name = "se-meteor"}, message, true)
      if settings.get_player_settings(player)["se-print-meteor-info"].value then
        player.print(message)
      end
    end
  end
end

function Meteor.begin_meteor_shower(zone, position, range, force_meteor_count)
  if not zone then return end
  local surface = Zone.get_make_surface(zone)

  if not position then position = {x = 0, y = 0} end
  if not range then range = Meteor.meteor_random_range end

  local meteor_count = 1
  if force_meteor_count then
    meteor_count = force_meteor_count
  else
    local continue = true
    while continue and meteor_count < 100 do
      if math.random() < 0.5 then
        meteor_count = meteor_count + 1
      else
        continue = false
      end
    end
  end

  local x_offset = Meteor.meteor_swarm_x_deviation * 2 * (math.random() - 0.5)
  local land_position = {
    x = position.x + (math.random() - 0.5) * range * 2,
    y = position.y + (math.random() - 0.5) * range * 2
  }
  local start_position = {
    x = land_position.x + x_offset,
    y = land_position.y - Meteor.meteor_swarm_altitude
  }
  local shadow_start_position = {
    x = land_position.x + Meteor.meteor_swarm_altitude + x_offset,
    y = land_position.y
  }

  local chain_angle = math.random() * 360
  local chain = 0
  local meteors = {}
  for chain = 1, meteor_count do
    meteor = {
      id = chain,
      safe = false
    }
    if chain == 1 then
      meteor.land_position = {
        x = land_position.x,
        y = land_position.y,
      }
    else
      meteor.land_position = {
        x = land_position.x + (math.random() - 0.5) * Meteor.meteor_position_deviation,
        y = land_position.y + (math.random() - 0.5) * Meteor.meteor_position_deviation,
      }
      meteor.land_position = util.vectors_add(meteor.land_position, util.rotate_vector(chain_angle, {x = 0, y = Meteor.meteor_chain_distance * ((chain - 1) + 0.7 * math.random()) }))
    end
    table.insert(meteors, meteor)
  end

  local defences = zone.meteor_defences or {}

  global.meteor_showers = global.meteor_showers or {}
  local meteor_shower = {
    valid = true,
    type = "meteor-shower",
    zone = zone,
    land_position = land_position,
    start_position = start_position,
    shadow_start_position = shadow_start_position,
    meteors = meteors,
    remaining_meteors = table.deepcopy(meteors),
    defences_activated = 0,
    point_defences_activated = 0,
    defences = defences,
    skip = 60
  }
  table.insert(global.meteor_showers, meteor_shower)

  local surface = Zone.get_make_surface(zone)
  surface.request_to_generate_chunks(start_position)
  surface.request_to_generate_chunks(shadow_start_position)
  surface.request_to_generate_chunks(land_position)

  for _, player in pairs(game.connected_players) do
    if player.surface.index == surface.index then
      player.play_sound{path = "se-meteor-woosh", volume = 3}
    end
  end

end

function Meteor.spawn_meteor_shower(meteor_shower)
  local surface = Zone.get_make_surface(meteor_shower.zone)
  for _, meteor in pairs(meteor_shower.remaining_meteors) do
    surface.create_entity{
      name = mod_prefix.."falling-meteor-"..string.format("%02d", math.random(Meteor.meteor_variants)),
      position = meteor_shower.start_position,
      target = meteor.land_position,
      force = "neutral",
      speed = Util.vectors_delta_length(meteor_shower.start_position, meteor.land_position) / (Meteor.meteor_fall_time + Meteor.meteor_chain_delay * meteor.id)
    }
    surface.create_entity{
      name = mod_prefix.."shadow-meteor-"..string.format("%02d", math.random(Meteor.meteor_variants)),
      position = meteor_shower.shadow_start_position,
      target = meteor.land_position,
      force = "neutral",
      speed = Util.vectors_delta_length(meteor_shower.shadow_start_position, meteor.land_position) / (Meteor.meteor_fall_time + Meteor.meteor_chain_delay * meteor.id)
    }
  end
end

function Meteor.on_tick_defence (zone, defence)
    if defence.container and defence.container.valid and defence.charger and defence.charger.valid then
      if defence.charger.is_connected_to_electric_network() and defence.charger.energy < Meteor.defence_full_power * 0.99 then
        if not defence.charging_shape_id then
          defence.charging_shape_id = rendering.draw_sprite{
            sprite = "utility/recharge_icon",
            surface = defence.container.surface,
            target = defence.container,
            x_scale = 0.5,
            y_scale = 0.5,
          }
        end
        if defence.charging_text_id then
          rendering.destroy(defence.charging_text_id)
          defence.charging_text_id = nil
        end
        defence.charging_text_id = rendering.draw_text{
          text = string.format("%.2f", 100 * defence.charger.energy / Meteor.defence_full_power) .. "%",
          surface = defence.container.surface,
          target = defence.container,
          target_offset =  {x = 0, y = 1},
          color = {r=255,g=255,b=255,a=255},
          alignment = "center",
        }
      else
        if defence.charging_shape_id then
          rendering.destroy(defence.charging_shape_id)
          defence.charging_shape_id = nil
        end
        if defence.charging_text_id then
          rendering.destroy(defence.charging_text_id)
          defence.charging_text_id = nil
        end
      end
      if defence.container.health <= 0 then defence.container.active = true end
    else
      if defence.container and defence.container.valid then defence.container.destroy() end
      if defence.charger and defence.charger.valid then defence.charger.destroy() end
      if defence.charging_shape_id then
        rendering.destroy(defence.charging_shape_id)
        defence.charging_shape_id = nil
      end
      if defence.charging_text_id then
        rendering.destroy(defence.charging_text_id)
        defence.charging_text_id = nil
      end
      zone.meteor_defences[defence.unit_number] = nil
    end
end

function Meteor.on_tick_point_defence (zone, defence)
    if defence.container and defence.container.valid and defence.charger and defence.charger.valid then
      if defence.charger.is_connected_to_electric_network() and defence.charger.energy < Meteor.point_defence_full_power * 0.25 then
        if not defence.charging_shape_id then
          defence.charging_shape_id = rendering.draw_sprite{
            sprite = "utility/recharge_icon",
            surface = defence.container.surface,
            target = defence.container,
            x_scale = 0.5,
            y_scale = 0.5,
          }
        end
        if defence.charging_text_id then
          rendering.destroy(defence.charging_text_id)
          defence.charging_text_id = nil
        end
        defence.charging_text_id = rendering.draw_text{
          text = string.format("%.2f", 100 * defence.charger.energy / (Meteor.point_defence_full_power * 0.25)) .. "%",
          surface = defence.container.surface,
          target = defence.container,
          target_offset =  {x = 0, y = 1},
          color = {r=255,g=255,b=255,a=255},
          alignment = "center",
        }
      else
        if defence.charging_shape_id then
          rendering.destroy(defence.charging_shape_id)
          defence.charging_shape_id = nil
        end
        if defence.charging_text_id then
          rendering.destroy(defence.charging_text_id)
          defence.charging_text_id = nil
        end
      end
      if defence.container.health <= 0 then defence.container.active = true end
    else
      if defence.container and defence.container.valid then defence.container.destroy() end
      if defence.charger and defence.charger.valid then defence.charger.destroy() end
      if defence.charging_shape_id then
        rendering.destroy(defence.charging_shape_id)
        defence.charging_shape_id = nil
      end
      if defence.charging_text_id then
        rendering.destroy(defence.charging_text_id)
        defence.charging_text_id = nil
      end
      zone.meteor_point_defences[defence.unit_number] = nil
    end
end

function Meteor.credit_kill(charger)
    --Credit the force with the kill
    --All of the icons look the same so there's no reason in spltting the stastics up.
    --force.kill_count_statistics.on_flow(mod_prefix .. "static-meteor-" .. string.format("%02d", math.random(Meteor.meteor_variants)), 1)
    charger.force.kill_count_statistics.on_flow(mod_prefix .. "static-meteor-01", 1)
    charger.kills = charger.kills + 1
end

function Meteor.on_tick (event)
  -- TODO: make meteors appear on zones with power poles, not just where players are.
  if game.tick % Meteor.tick_skip == 0 then

    if not global.meteor_zones then
      global.meteor_zones = {}
      local nauvis = Zone.from_name("Nauvis")
      global.meteor_zones[nauvis.index] = nauvis
    end

    -- process meteor showers like tick tasks
    if global.meteor_showers then
      for i = #global.meteor_showers, 1, -1 do
        if global.meteor_showers[i].valid then
          Meteor.tick_meteor_shower(global.meteor_showers[i])
        else
          table.remove(global.meteor_showers, i)
        end
      end
    end

    for _, zone in pairs(global.meteor_zones) do
      if zone.meteor_defences then
        for _, defence in pairs(zone.meteor_defences) do
          Meteor.on_tick_defence(zone, defence)
        end
      end
      if zone.meteor_point_defences then
        for _, defence in pairs(zone.meteor_point_defences) do
          Meteor.on_tick_point_defence(zone, defence)
        end
      end
    end

    -- trigger meteor showers, should be after to let chunks generate
    if game.tick > (global.next_meteor_shower or 3600) then
      global.next_meteor_shower = game.tick + 60*60 + math.random() * 60 * 60 * settings.global["se-meteor-interval"].value

      for _, zone in pairs(global.meteor_zones) do
        local surface = Zone.get_make_surface(zone)
        local characters = surface.find_entities_filtered{name="character"}
        local position = {x = 0, y = 0}
        if #characters > 0 then
          position = characters[math.random(#characters)].position
        end
        Meteor.begin_meteor_shower(zone, position)
      end
    end

  end
end
Event.addListener(defines.events.on_tick, Meteor.on_tick)

return Meteor
