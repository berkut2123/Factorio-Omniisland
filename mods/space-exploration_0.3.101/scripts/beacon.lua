local Beacon = {}

-- Note: supply_area_distance -- extends from edge of collision box
Beacon.affected_types = {"assembling-machine", "furnace", "lab", "mining-drill", "rocket-silo"}

function Beacon.get_beacon_prototypes()
  if not Beacon.list_beacon_prototypes then
    Beacon.list_beacon_prototypes = {}
    for name, prototype in pairs(game.entity_prototypes) do
      if prototype.type == "beacon" and prototype.supply_area_distance then
        table.insert(Beacon.list_beacon_prototypes, prototype)
      end
    end
  end
  return Beacon.list_beacon_prototypes
end

function Beacon.get_max_beacon_range()
  if not Beacon.max_beacon_range then
    Beacon.max_beacon_range = 0
    for _, prototype in pairs(Beacon.list_beacon_prototypes()) do
      if prototype.supply_area_distance > Beacon.max_beacon_range then
        Beacon.max_beacon_range = prototype.supply_area_distance
      end
    end
  end
  return Beacon.max_beacon_range
end

function Beacon.validate_entity(entity, ignore_count)
  -- make sure not affected by more than 1 beacon
  if (not entity.prototype.allowed_effects) or table_size(entity.prototype.allowed_effects) == 0
    or (not entity.prototype.module_inventory_size) or entity.prototype.module_inventory_size == 0 then return end
  local ignore = ignore_count and ignore_count or 0
  local bounding_box = entity.bounding_box
  local beacons = 0
  for _, prototype in pairs(Beacon.get_beacon_prototypes()) do
    local area = util.area_extend(bounding_box, prototype.supply_area_distance)
    beacons = beacons + entity.surface.count_entities_filtered{type="beacon", name=prototype.name, area = area}
  end
  if beacons > 1 + ignore then
    if entity.active == true then
      entity.active = false
      entity.surface.create_entity{
         name = "flying-text",
         position = entity.position,
         text = {"space-exploration.beacon-overload"}
      }
      global.beacon_overloaded_entities = global.beacon_overloaded_entities or {}
      global.beacon_overloaded_entities[entity.unit_number] = entity

      local shape_id = global.beacon_overloaded_shapes[entity.unit_number]
      if shape_id and rendering.is_valid(shape_id) then rendering.destroy(shape_id) end -- shouldn't happen but best to check if other mods broke something
      shape_id = rendering.draw_sprite{
        sprite = "virtual-signal/"..mod_prefix.."beacon-overload",
        surface = entity.surface,
        target = entity,
        x_scale = 1,
        y_scale = 1,
        target_offset = entity.prototype.alert_icon_shift
      }
      global.beacon_overloaded_shapes = global.beacon_overloaded_shapes or {}
      global.beacon_overloaded_shapes[entity.unit_number] = shape_id
    end
  else
    -- TODO: add hook here so other things can cancel
    if not entity.active then
      global.beacon_overloaded_entities = global.beacon_overloaded_entities or {}
      global.beacon_overloaded_shapes = global.beacon_overloaded_shapes or {}
      local deactivated_by_beacons = false
      for unit_number, overloaed_entity in pairs(global.beacon_overloaded_entities) do
        if not overloaed_entity.valid then
          global.beacon_overloaded_entities[unit_number] = nil
          if global.beacon_overloaded_shapes[unit_number] then
            local shape_id = global.beacon_overloaded_shapes[unit_number]
            if rendering.is_valid(shape_id) then rendering.destroy(shape_id) end
            global.beacon_overloaded_shapes[unit_number] = nil
          end
        elseif entity == overloaed_entity then
          global.beacon_overloaded_entities[unit_number] = nil
          if global.beacon_overloaded_shapes[unit_number] then
            local shape_id = global.beacon_overloaded_shapes[unit_number]
            if rendering.is_valid(shape_id) then rendering.destroy(shape_id) end
            global.beacon_overloaded_shapes[unit_number] = nil
          end
          deactivated_by_beacons = true
        end
      end
      if deactivated_by_beacons then
        entity.active = true
        entity.surface.create_entity{
           name = "flying-text",
           position = entity.position,
           text = {"space-exploration.beacon-overload-ended"}
        }
        for interface, functions in pairs(remote.interfaces) do -- allow other mods to deactivate after
          if interface ~= "space-exploration" and functions["on_entity_activated"] then
            remote.call(interface, "on_entity_activated", {entity = entity, mod = "space-exploration"})
          end
        end

      end
    end
  end
end

function Beacon.validate_beacon(entity, is_deconstructing)
  local prototype = entity.prototype
  local area = util.area_extend(entity.bounding_box, prototype.supply_area_distance)
  local structures = entity.surface.find_entities_filtered{type = Beacon.affected_types, area = area}
  local ignore = is_deconstructing and 1 or 0
  for _, structure in pairs(structures) do
    Beacon.validate_entity(structure, ignore)
  end
end

function Beacon.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.type == "beacon" then
    Beacon.validate_beacon(entity)
  elseif util.table_contains(Beacon.affected_types, entity.type) then
    Beacon.validate_entity(entity)
  end
end
Event.addListener(defines.events.on_built_entity, Beacon.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, Beacon.on_entity_created)
Event.addListener(defines.events.script_raised_built, Beacon.on_entity_created)
Event.addListener(defines.events.script_raised_revive, Beacon.on_entity_created)

function Beacon.on_entity_removed(event)
  if event.entity and event.entity.valid then
    if event.entity.type == "beacon" then
      -- do validation but counting 1 beacon fewer
      Beacon.validate_beacon(event.entity, true)
    end
  end
end

Event.addListener(defines.events.on_player_mined_entity, Beacon.on_entity_removed)
Event.addListener(defines.events.on_robot_mined_entity, Beacon.on_entity_removed)
Event.addListener(defines.events.on_entity_died, Beacon.on_entity_removed)
Event.addListener(defines.events.script_raised_destroy, Beacon.on_entity_removed)

return beacon
