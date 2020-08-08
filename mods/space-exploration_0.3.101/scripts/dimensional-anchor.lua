DAnchor = {}

-- constants
DAnchor.name_structure = mod_prefix.."dimensional-anchor"
DAnchor.name_effects = mod_prefix.."dimensional-anchor-fx"
DAnchor.check_interval = 60
DAnchor.energy_per_tick = 1000000000 -- match the charge speed

function DAnchor.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.name == DAnchor.name_structure then
    local zone = Zone.from_surface(entity.surface)
    if zone.parent and zone.parent.type == "star" then
      if entity.surface.count_entities_filtered{name = DAnchor.name_structure} > 1 then
        cancel_entity_creation(entity, event.player_index, "You cannot have more than 1 dimensional anchor per star.")
        return
      end
      global.dimensional_anchors = global.dimensional_anchors or {}
      global.dimensional_anchors[zone.index] = {
        zone_index = zone.index,
        structure = entity,
        effects = nil,
        active = false,
        low_power_icon = nil
      }
      global.dimensional_anchors[zone.index].low_power_icon = rendering.draw_sprite{
        sprite = "utility/recharge_icon",
        surface = entity.surface,
        target = entity,
        x_scale = 0.5,
        y_scale = 0.5,
      }
    else
      cancel_entity_creation(entity, event.player_index, "Must be placed in close orbit of a star.")
      return
    end
  end

end
Event.addListener(defines.events.on_built_entity, DAnchor.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, DAnchor.on_entity_created)
Event.addListener(defines.events.script_raised_built, DAnchor.on_entity_created)
Event.addListener(defines.events.script_raised_revive, DAnchor.on_entity_created)

function DAnchor.on_entity_removed(event)
  if event.entity and event.entity.valid then
    if event.entity.name == DAnchor.name_structure and global.dimensional_anchors then
      for zone_index, anchor in pairs(global.dimensional_anchors) do
        if anchor.structure == event.entity then
          if anchor.effects and anchor.effects.valid then
            anchor.effects.destroy()
            anchor.effects = nil
          end
          global.dimensional_anchors[zone_index] = nil
        end
      end
    end
  end
end
Event.addListener(defines.events.on_player_mined_entity, DAnchor.on_entity_removed)
Event.addListener(defines.events.on_robot_mined_entity, DAnchor.on_entity_removed)
Event.addListener(defines.events.on_entity_died, DAnchor.on_entity_removed)
Event.addListener(defines.events.script_raised_destroy, DAnchor.on_entity_removed)

function DAnchor.on_tick(event)
  if game.tick % DAnchor.check_interval == 0 and global.dimensional_anchors then
    for zone_index, anchor in pairs(global.dimensional_anchors) do
      if anchor.structure and anchor.structure.valid then
        if anchor.structure.energy > DAnchor.check_interval * DAnchor.energy_per_tick then
          anchor.structure.energy = anchor.structure.energy - DAnchor.check_interval * DAnchor.energy_per_tick
          if not anchor.active then
            anchor.active = true
            anchor.effects = anchor.structure.surface.create_entity{
              name = DAnchor.name_effects,
              position = anchor.structure.position,
              target = {x = anchor.structure.position.x, y = anchor.structure.position.y - 1},
              speed = 0}
              rendering.destroy(anchor.low_power_icon)
          end
        else
          if anchor.effects and anchor.effects.valid then
            anchor.effects.destroy()
            anchor.effects = nil
          end
          if anchor.active ~= false then
            anchor.active = false
            anchor.low_power_icon = rendering.draw_sprite{
              sprite = "utility/recharge_icon",
              surface = anchor.structure.surface,
              target = anchor.structure,
              x_scale = 0.5,
              y_scale = 0.5,
            }
          end
        end
      else
        -- missing entity
      end
    end
  end
end

Event.addListener(defines.events.on_tick, DAnchor.on_tick)

return DAnchor
