local Composites = {}

-- Simple composite_entites

Composites.entities = {
  ["pylon-construction"] = {
    set = {
      { name = mod_prefix.."pylon-construction"},
      { name = mod_prefix.."pylon-construction-roboport", destructible=false },
    }
  },
  ["pylon-construction-radar"] = {
    set = {
      { name = mod_prefix.."pylon-construction-radar"  },
      { name = mod_prefix.."pylon-construction-radar-radar", destructible=false  },
      { name = mod_prefix.."pylon-construction-radar-roboport", destructible=false  },
    }
  }
}

function Composites.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  for _, ce in pairs(Composites.entities) do
    for i, struct in pairs(ce.set) do
      if entity.name == struct.name then
        --game.print(_)
        for j, struct in pairs(ce.set) do
          local e
          if i == j then
            e = entity
          else
            e = entity.surface.create_entity{
              name=struct.name,
              position=entity.position,
              direction=entity.direction,
              force=entity.force
            }
          end
          e.destructible = struct.destructible == nil and true or struct.destructible
        end
        return
      end
    end
  end
end
Event.addListener(defines.events.on_built_entity, Composites.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, Composites.on_entity_created)
Event.addListener(defines.events.script_raised_built, Composites.on_entity_created)
Event.addListener(defines.events.script_raised_revive, Composites.on_entity_created)


function Composites.on_removed_entity(event)
  if event.entity and event.entity.valid and event.entity.surface then
    local entity = event.entity
    for _, ce in pairs(Composites.entities) do
      for i, struct in pairs(ce.set) do
        if entity.name == struct.name then
          for j, struct in pairs(ce.set) do
            if j ~= i then
              local e = entity.surface.find_entity(struct.name, entity.position)
              if e then e.destroy() end
            end
          end
        end
      end
    end
  end
end
Event.addListener(defines.events.on_entity_died, Composites.on_removed_entity)
Event.addListener(defines.events.on_robot_mined_entity, Composites.on_removed_entity)
Event.addListener(defines.events.on_player_mined_entity, Composites.on_removed_entity)
Event.addListener(defines.events.script_raised_destroy, Composites.on_removed_entity)

--function Composites.on_player_rotated_entity(event)
--end
--Event.addListener(defines.events.on_player_rotated_entity, Composites.on_player_rotated_entity)

return Composites
