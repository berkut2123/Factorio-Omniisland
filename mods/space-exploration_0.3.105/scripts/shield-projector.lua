local ShieldProjector = {}

ShieldProjector.scale_up = 4/3

ShieldProjector.name_entity = mod_prefix .. "shield-projector"
ShieldProjector.name_floor_prefix = mod_prefix .. "shield-projector-shield-floor-"
ShieldProjector.name_wall_prefix = mod_prefix .. "shield-projector-shield-wall-"
ShieldProjector.name_barrier = mod_prefix .. "shield-projector-barrier"
ShieldProjector.directions = {"north", "south", "east", "west", "northeast", "northwest", "southeast", "southwest"}

ShieldProjector.cardinal_distance = 12--9
ShieldProjector.diagonal_distance = 7.75--6
ShieldProjector.cardinal_circle_origin = -5---4
ShieldProjector.diagonal_circle_origin = -4---3
ShieldProjector.barrier_from_circle = 18--13.5

ShieldProjector.tick_interval = 60

ShieldProjector.threshold_charging = 0.1 -- below this no charging animation is shown
ShieldProjector.threshold_project = 0.9 -- above this the shield is projected if not alreay active
ShieldProjector.threshold_collapse = 0.1 -- below this an active shield will collapse.

ShieldProjector.energy_per_hit_point = 40000
ShieldProjector.free_regen = 1
ShieldProjector.regen_lag = 10
ShieldProjector.max_health_for_instant_regen = 500

function ShieldProjector.get_sub_entity_names(event)
  local names = {mod_prefix .. "shield-projector-barrier"}
  for _, direction in pairs(ShieldProjector.directions) do
    table.insert(names, ShieldProjector.name_floor_prefix .. direction)
    table.insert(names, ShieldProjector.name_wall_prefix .. direction)
  end
  return names
end

function ShieldProjector.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.name == ShieldProjector.name_entity then
    global.shield_projectors = global.shield_projectors or {}
    for _, shield_projector in pairs(global.shield_projectors) do
      if shield_projector.entity == entity then
        return -- already is set upt
      end
    end
    local shield_projector = {
      unit_number = entity.unit_number,
      entity = entity,
      surface = entity.surface,
      force = entity.force,
      barriers = {},
      floor_effect = nil,
      wall_effect = nil,
      is_projecting = false
    }
    global.shield_projectors[shield_projector.unit_number] = shield_projector

    local max_energy = shield_projector.entity.prototype.electric_energy_source_prototype.buffer_capacity
    entity.energy = math.max(entity.energy, max_energy * ShieldProjector.threshold_charging) -- start at the point where charging is shown, good to show activity
    entity.rotatable = false
  end
end
Event.addListener(defines.events.on_built_entity, ShieldProjector.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, ShieldProjector.on_entity_created)
Event.addListener(defines.events.script_raised_built, ShieldProjector.on_entity_created)
Event.addListener(defines.events.script_raised_revive, ShieldProjector.on_entity_created)

function ShieldProjector.on_removed_entity(event)
  if event.entity and event.entity.valid and event.entity.name == ShieldProjector.name_entity
    and global.shield_projectors and global.shield_projectors[event.entity.unit_number] then
      ShieldProjector.remove(global.shield_projectors[event.entity.unit_number])
  end
end
Event.addListener(defines.events.on_entity_died, ShieldProjector.on_removed_entity)
Event.addListener(defines.events.on_robot_mined_entity, ShieldProjector.on_removed_entity)
Event.addListener(defines.events.on_player_mined_entity, ShieldProjector.on_removed_entity)
Event.addListener(defines.events.script_raised_destroy, ShieldProjector.on_removed_entity)

function ShieldProjector.on_player_driving_changed_state(event)
  local player = game.players[event.player_index]
  if player and player.valid and player.character and player.character.vehicle
    and player.character.vehicle.valid and player.character.vehicle.name == ShieldProjector.name_barrier then
      local vehicle = player.character.vehicle
      vehicle.set_driver(nil)
      vehicle.set_passenger(nil)
  end
end
Event.addListener(defines.events.on_player_driving_changed_state, ShieldProjector.on_player_driving_changed_state)

function ShieldProjector.remove(shield_projector)
  ShieldProjector.remove_projection(shield_projector)
  global.shield_projectors[shield_projector.unit_number] = nil
end

function ShieldProjector.remove_projection(shield_projector)
  if shield_projector.floor_effect and shield_projector.floor_effect.valid then shield_projector.floor_effect.destroy() end
  shield_projector.floor_effect = nil
  if shield_projector.wall_effect and shield_projector.wall_effect.valid then shield_projector.wall_effect.destroy() end
  shield_projector.wall_effect = nil

  for _, barrier in pairs(shield_projector.barriers) do
    if barrier.valid then barrier.destroy() end
  end
  shield_projector.barriers = {}
end

function ShieldProjector.update(shield_projector)
  if not shield_projector.entity.valid then
    return ShieldProjector.remove(shield_projector)
  end
  local energy = shield_projector.entity.energy
  energy_p = energy / shield_projector.entity.prototype.electric_energy_source_prototype.buffer_capacity

  if shield_projector.is_projecting then
    shield_projector.every_tick = false
    for _, barrier in pairs(shield_projector.barriers) do
      if barrier.valid then
        ShieldProjector.repair_barrier (shield_projector, barrier, true)
      else
        shield_projector.entity.energy = 0
        energy = 0
        energy_p = 0
        break
      end
    end

    if energy_p <= ShieldProjector.threshold_collapse then
      ShieldProjector.remove_projection(shield_projector)
      shield_projector.is_projecting = false
      shield_projector.entity.energy = 0
    end
  else -- not projecting
    shield_projector.every_tick = false
    if energy_p > ShieldProjector.threshold_project then
      shield_projector.is_projecting = true
      local orientation = shield_projector.entity.orientation
      local direction = shield_projector.entity.direction
      local vector = util.direction_to_vector(direction)
      local cardinal = (orientation * 4) % 1 == 0
      local position = shield_projector.entity.position

      -- graphics
      local graphic_position = table.deepcopy(position)
      local graphic_offset = cardinal and ShieldProjector.cardinal_distance or ShieldProjector.diagonal_distance
      graphic_position.x = graphic_position.x + vector.x * graphic_offset
      graphic_position.y = graphic_position.y + vector.y * graphic_offset

      shield_projector.floor_effect = shield_projector.entity.surface.create_entity{name = ShieldProjector.name_floor_prefix..util.direction_to_string(direction),
        position = graphic_position, direction = direction, force = shield_projector.entity.force}
      shield_projector.floor_effect.destructible = false

      shield_projector.wall_effect = shield_projector.entity.surface.create_entity{name = ShieldProjector.name_wall_prefix..util.direction_to_string(direction),
          position = graphic_position, direction = direction, force = shield_projector.entity.force}
      shield_projector.wall_effect.destructible = false

      -- barriers
      local circle_center = table.deepcopy(position)
      local circle_offset = cardinal and ShieldProjector.cardinal_circle_origin or ShieldProjector.diagonal_circle_origin
      circle_center.x = circle_center.x + vector.x * circle_offset
      circle_center.y = circle_center.y + vector.y * circle_offset
      for _, orientation_offset in pairs{-1/24, 0, 1/24} do
        local barrier_orientation = orientation + orientation_offset
        local b_position = table.deepcopy(circle_center)
        b_position.x = b_position.x + math.sin(math.pi * 2 * barrier_orientation) * ShieldProjector.barrier_from_circle
        b_position.y = b_position.y + -math.cos(math.pi * 2 * barrier_orientation) * ShieldProjector.barrier_from_circle
        local barrier = shield_projector.entity.surface.create_entity{name = ShieldProjector.name_barrier, position = b_position, direction = direction, force = shield_projector.entity.force}
        barrier.orientation = barrier_orientation
        barrier.minable = false
        barrier.operable = false
        table.insert(shield_projector.barriers, barrier)
      end
    end
  end
end

function ShieldProjector.on_tick (event)
  if global.shield_projectors then
    for _, shield_projector in pairs(global.shield_projectors) do
      if shield_projector.every_tick or (shield_projector.unit_number + game.tick) % ShieldProjector.tick_interval == 0 then
        ShieldProjector.update(shield_projector)
      end
    end
  end
end
Event.addListener(defines.events.on_tick, ShieldProjector.on_tick)

function ShieldProjector.repair_barrier (shield_projector, barrier, free_regen)
  local health = barrier.health
  local max_health = barrier.prototype.max_health
  if health < max_health then
    local damage = max_health - health
    local damage_percent = damage / max_health
    local energy_required = damage * ShieldProjector.energy_per_hit_point
    local energy = shield_projector.entity.energy
    local max_energy = shield_projector.entity.prototype.electric_energy_source_prototype.buffer_capacity

    local energy_available = energy - max_energy * ShieldProjector.threshold_collapse
    local energy_for_repair = math.min(
      energy_available/3,-- /3 minimum so energy is shared over segments
      energy_required * damage_percent * damage_percent / ShieldProjector.regen_lag
    )
    barrier.health = barrier.health + energy_for_repair / ShieldProjector.energy_per_hit_point + (free_regen and ShieldProjector.free_regen or 0)
    shield_projector.entity.energy = energy - energy_for_repair
    if barrier.health < max_health * 0.01 then
      barrier.destroy()
    elseif barrier.health < max_health then
      shield_projector.every_tick = true
    end
  end
end

function ShieldProjector.on_entity_damaged (event)
  if event.entity and event.entity.valid and event.entity.name == ShieldProjector.name_barrier then
    for _, shield_projector in pairs(global.shield_projectors) do
      for _, barrier in pairs(shield_projector.barriers) do
        if barrier == event.entity then
          shield_projector.every_tick = true
          if barrier.health < ShieldProjector.max_health_for_instant_regen then
            ShieldProjector.repair_barrier(shield_projector, barrier)
          end
        end
      end
    end
  end
end
Event.addListener(defines.events.on_entity_damaged, ShieldProjector.on_entity_damaged)

function ShieldProjector.find_on_surface(surface)
  local entities = surface.find_entities_filtered{name=ShieldProjector.name_entity}
  for _, entity in pairs(entities) do
    ShieldProjector.on_entity_created({entity = entity})
  end
end

return ShieldProjector
