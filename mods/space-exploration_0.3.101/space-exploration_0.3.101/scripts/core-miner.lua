Coreminer = {}

-- constants
Coreminer.name_core_miner = mod_prefix.."core-miner"
Coreminer.name_core_miner_drill = mod_prefix.."core-miner-drill"
Coreminer.name_core_mining_recipe = mod_prefix.."core-mining"
Coreminer.resource_normal = 1000000

function Coreminer.resource_to_fragment_name(resource_name)
  local try_name = util.mod_prefix .. "core-fragment-" .. resource_name
  if game.item_prototypes[try_name] then
    return try_name
  end
  -- otherwise there is no fragment
end

function Coreminer.variation_to_direction(var)
  if var == 1 then
    return defines.direction.south
  elseif var == 2 then
    return defines.direction.west
  elseif var == 3 then
    return defines.direction.north
  else
    return defines.direction.east
  end
end

function Coreminer.direction_to_variation(dir)
  if dir == defines.direction.south then
    return 1
  elseif dir == defines.direction.west then
    return 2
  elseif dir == defines.direction.north then
    return 3
  else
    return 4
  end
end

function Coreminer.default_fragment_name(zone)
  if not zone.fragment_name then
    zone.fragment_name = Coreminer.resource_to_fragment_name(zone.primary_resource)
    if not zone.fragment_name then
      -- maybe choose something at random?
      error("Primary resource has no core fragment: " .. zone.name )
      zone.fragment_name = util.mod_prefix .. "core-fragment-omni"
    end
  end
end

function Coreminer.equalise(zone, surface)
  if not zone then
    zone = Zone.from_surface(surface)
  end
  if not (zone and surface) then return end
  Coreminer.default_fragment_name(zone)

  local resources = surface.find_entities_filtered{
    type = "resource",
    name = zone.fragment_name
  }
  local zone_efficiency = zone.type == "planet" and 0.5 or 0.25
  local efficiency = math.sqrt(#resources) / #resources
  for _, resource in pairs(resources) do
    local new_amount = Coreminer.resource_normal * zone_efficiency * efficiency
    if resource.amount ~= new_amount then
      resource.amount = new_amount
      surface.create_entity{
         name = "flying-text",
         position = resource.position,
         text = string.format("%.2f", efficiency * 100).."% effective",
       }
     end
  end
end

function Coreminer.equalise_all()
  if global.zone_index then
    for _, zone in pairs(global.zone_index) do
      if zone.surface_index and Zone.is_solid(zone) then
        Coreminer.equalise(zone, Zone.get_surface(zone))
      end
    end
  end
end

function Coreminer.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.name == Coreminer.name_core_miner or entity.name == Coreminer.name_core_miner_drill then
    local zone = Zone.from_surface(entity.surface)
    if zone and Zone.is_solid(zone) then
      Coreminer.default_fragment_name(zone)
      if not zone.fragment_name then
        game.print("[color=red]Error: This surface is missing a core fragment setting. Please report the issue.[/color]")
        cancel_entity_creation(entity, event.player_index, "Error")
      else
        local resource = entity.surface.create_entity{
           name = zone.fragment_name,
           position = entity.position,
           direction = entity.direction,
           amount = 1,
        }

        if entity.name ~= Coreminer.name_core_miner_drill then
          local drill = entity.surface.create_entity{
             name = Coreminer.name_core_miner_drill,
             position = {x = entity.position.x, y = entity.position.y + 1/32},
             direction = entity.direction,
             --direction = defines.direction.south,
             --direction = Coreminer.variation_to_direction(entity.graphics_variation),
             force = entity.force
          }
          -- drill is selectable so make that the one that takes damage
          --drill.destructible = false
          entity.destructible = false
        end
        Coreminer.equalise(zone, entity.surface)
      end
    else
      cancel_entity_creation(entity, event.player_index, "Must be placed on a Planet or Moon.")
      return
    end
  end

end
Event.addListener(defines.events.on_built_entity, Coreminer.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, Coreminer.on_entity_created)
Event.addListener(defines.events.script_raised_built, Coreminer.on_entity_created)
Event.addListener(defines.events.script_raised_revive, Coreminer.on_entity_created)

function Coreminer.on_entity_removed(event)
  if event.entity and event.entity.valid then
    local surface = event.entity.surface
    if event.entity.name == Coreminer.name_core_miner then
      local e = event.entity.surface.find_entity(Coreminer.name_core_miner_drill, event.entity.position)
      if e then e.destroy() end
      local resources = event.entity.surface.find_entities_filtered{ type="resource", area = Util.position_to_area(event.entity.position, 1)}
      for _, resource in pairs(resources) do
        resource.destroy()
      end
      Coreminer.equalise(nil, surface)
    elseif event.entity.name == Coreminer.name_core_miner_drill then
      local e = event.entity.surface.find_entity(Coreminer.name_core_miner, event.entity.position)
      if e then e.destroy() end
      local resources = event.entity.surface.find_entities_filtered{ type="resource", area = Util.position_to_area(event.entity.position, 1)}
      for _, resource in pairs(resources) do
        resource.destroy()
      end
      Coreminer.equalise(nil, surface)
    end
  end
end
Event.addListener(defines.events.on_player_mined_entity, Coreminer.on_entity_removed)
Event.addListener(defines.events.on_robot_mined_entity, Coreminer.on_entity_removed)
Event.addListener(defines.events.on_entity_died, Coreminer.on_entity_removed)
Event.addListener(defines.events.script_raised_destroy, Coreminer.on_entity_removed)

-- simple entity does not support rotation, bake into graphics variation
function Coreminer.on_player_rotated_entity(event)
  if event.entity and event.entity.valid then
    local surface = event.entity.surface
    if event.entity.name == Coreminer.name_core_miner_drill then
      local e = event.entity.surface.find_entity(Coreminer.name_core_miner, event.entity.position)
      --if e then e.graphics_variation = Coreminer.direction_to_variation(event.entity.direction) end
      if e then e.direction = event.entity.direction end
    end
  end
end
Event.addListener(defines.events.on_player_rotated_entity, Coreminer.on_player_rotated_entity)

function Coreminer.update_zone_fragment_resources(zone)
  local surface = Zone.get_surface(zone)
  if surface then
    for _, entity in pairs(surface.find_entities_filtered{name = mod_prefix.."core-miner"}) do
      local resources = surface.find_entities_filtered{type = "resource", area = Util.position_to_area(entity.position, 2)}
      for _, resource in pairs(resources) do
        resource.destroy()
      end
      local resource = entity.surface.create_entity{
         name = zone.fragment_name,
         position = entity.position,
         direction = entity.direction,
         amount = 1,
      }
    end
    Coreminer.equalise(zone, surface)
  end
end

return Coreminer
