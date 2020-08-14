local CondenserTurbine = {}

CondenserTurbine.name_condenser_turbine = mod_prefix.."condenser-turbine"
CondenserTurbine.name_condenser_turbine_generator = mod_prefix.."condenser-turbine-generator"
CondenserTurbine.name_condenser_turbine_tank = mod_prefix.."condenser-turbine-tank"
CondenserTurbine.condenser_turbine_tank_offset = 2

function CondenserTurbine.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.name == CondenserTurbine.name_condenser_turbine then
     local direction_vector = Util.vector_multiply(Util.direction_to_vector(entity.direction), -1)
    local tank_position_offset = Util.vector_multiply(direction_vector, CondenserTurbine.condenser_turbine_tank_offset)
    local tank_position = Util.vectors_add(entity.position, tank_position_offset)

    local generator = entity.surface.create_entity{
      name = CondenserTurbine.name_condenser_turbine_generator,
      position = entity.position,
      direction = entity.direction,
      force = entity.force
    }
    generator.destructible = false
    local tank = entity.surface.create_entity{
      name = CondenserTurbine.name_condenser_turbine_tank,
      position = tank_position,
      direction = entity.direction,
      force = entity.force
    }
    if tank then
      tank.destructible = false
    else
      game.print("condenser-turbine-tank error")
    end
  end
end
Event.addListener(defines.events.on_built_entity, CondenserTurbine.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, CondenserTurbine.on_entity_created)
Event.addListener(defines.events.script_raised_built, CondenserTurbine.on_entity_created)
Event.addListener(defines.events.script_raised_revive, CondenserTurbine.on_entity_created)


function CondenserTurbine.on_removed_entity(event)
  if event.entity and event.entity.valid and event.entity.surface
   and event.entity.name == CondenserTurbine.name_condenser_turbine then
     local entity = event.entity

     local direction_vector = Util.vector_multiply(Util.direction_to_vector(entity.direction), -1)
     local tank_position_offset = Util.vector_multiply(direction_vector, CondenserTurbine.condenser_turbine_tank_offset)
     local tank_position = Util.vectors_add(entity.position, tank_position_offset)

     local generator = entity.surface.find_entity(CondenserTurbine.name_condenser_turbine_generator, entity.position)
     if generator then generator.destroy() end

    local tank = entity.surface.find_entity(CondenserTurbine.name_condenser_turbine_tank, tank_position)
    if tank then tank.destroy() end

  end
end
Event.addListener(defines.events.on_entity_died, CondenserTurbine.on_removed_entity)
Event.addListener(defines.events.on_robot_mined_entity, CondenserTurbine.on_removed_entity)
Event.addListener(defines.events.on_player_mined_entity, CondenserTurbine.on_removed_entity)
Event.addListener(defines.events.script_raised_destroy, CondenserTurbine.on_removed_entity)

function CondenserTurbine.on_player_rotated_entity(event)
  if event.entity and event.entity.valid and event.entity.surface
   and event.entity.name == CondenserTurbine.name_condenser_turbine then
      local entity = event.entity

      local direction_vector = Util.vector_multiply(Util.direction_to_vector(entity.direction), -1)
      local tank_position_offset = Util.vector_multiply(direction_vector, CondenserTurbine.condenser_turbine_tank_offset)
      local tank_position = Util.vectors_add(entity.position, tank_position_offset)

      local tank = entity.surface.find_entity(CondenserTurbine.name_condenser_turbine_tank, tank_position)
      if tank then
          local direction_vector = Util.direction_to_vector(entity.direction)
          local tank_position_offset = Util.vector_multiply(direction_vector, CondenserTurbine.condenser_turbine_tank_offset)
          local tank_position = Util.vectors_add(entity.position, tank_position_offset)
          tank.teleport(tank_position)
          tank.rotate()
          tank.rotate()
      end

  end
end
Event.addListener(defines.events.on_player_rotated_entity, CondenserTurbine.on_player_rotated_entity)

function CondenserTurbine.reset_surface(surface)
  for _, entity in pairs(surface.find_entities_filtered{name = CondenserTurbine.name_condenser_turbine_tank }) do
    entity.direction = entity.direction
  end
end

return CondenserTurbine
