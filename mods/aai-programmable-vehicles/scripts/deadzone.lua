local Deadzone = {}

Deadzone.block_by_types = {"unit-spawner", "turret", "ammo-turret", "electric-turret", "fluid-turret", "inserter"}

function Deadzone.construction_denial_range()
  if not global.deadzone_construction_denial_range then
    global.deadzone_construction_denial_range = settings.global["deadzone-construction-denial-range"].value
  end
  return global.deadzone_construction_denial_range
end

function Deadzone.hostile_forces(force)
  local hostile_forces = {}
  for _, o_force in pairs(game.forces) do
    if o_force.name ~= "neutral" and o_force ~= force and (not o_force.get_cease_fire(force)) and (not o_force.get_friend(force)) then
      table.insert(hostile_forces, o_force.name)
    end
  end
  --game.print(serpent.block(hostile_forces))
  return hostile_forces
end

function Deadzone.struct_construction_denial(entity, event)
  if not (entity and entity.valid) then return end
  if entity.type == "entity-ghost" or entity.type == "tile-ghost" or entity.type == "car" or entity.type == "spider-vehicle" then return end
  -- check for illegal structure placement
  local range = Deadzone.construction_denial_range()
  if range <= 0 then return end

  local enemies = entity.surface.find_entities_filtered{
    radius = range,
    position = entity.position,
    type = Deadzone.block_by_types,
    force = Deadzone.hostile_forces(entity.force) }
  for _, enemy in pairs(enemies) do
        -- deny construction
        if entity.prototype.mineable_properties
          and entity.prototype.mineable_properties.products
          and entity.prototype.mineable_properties.products[1]
          and entity.prototype.mineable_properties.products[1].type == "item" then
            local stack = {name=entity.prototype.mineable_properties.products[1].name, amount=1}
            if event and event.name == "on_dolly_moved" and event.start_pos and event.player_index then
                entity.teleport(event.start_pos)
                game.players[event.player_index].print{"construction_denied_by_enemy", {"entity-name."..enemy.name}}
                return
            elseif event
              and event.name == defines.events.on_built_entity
              and event.player_index
              and game.players[event.player_index]
              and game.players[event.player_index].connected
              and game.players[event.player_index].can_insert(stack) then
                local player = game.players[event.player_index];
                player.print{"construction_denied_by_enemy", {"entity-name."..enemy.name}}
                player.insert(stack)
                -- fix for autofill adding items before removal
                -- don't do other inventories, fuel includes turret ammo slots for some reason
                Util.transfer_inventory_loose(entity, player, defines.inventory.fuel)
            else
              local ground_item = entity.surface.create_entity{
                name = "item-on-ground",
                position = entity.position,
                stack = stack}
              if ground_item and ground_item.valid then
                ground_item.order_deconstruction(entity.force)
              end
            end
        end
        entity.destroy({raise_destroy = true})
        return
  end
end

function Deadzone.on_biter_base_built(event)
  if not(event.entity and event.entity.valid) then return end
  local range = Deadzone.construction_denial_range()
  if range <= 0 then return end
  local entity = event.entity
  local blockers = entity.surface.count_entities_filtered{
    radius = range,
    position = entity.position,
    force = Deadzone.hostile_forces(entity.force),
    type=Deadzone.block_by_types}
  if blockers > 0 then
    --game.print("Enemy expansion halted by defences")
    entity.destroy({raise_destroy = true})
  else
    --game.print("Enemy expansion")
  end
end

function Deadzone.on_dolly_moved(event)
    if event.moved_entity and event.moved_entity.valid then
        -- prevent turret creep
        event.name = "on_dolly_moved"
        Deadzone.struct_construction_denial(event.moved_entity, event)
    end
end

function on_init()
    if remote.interfaces["picker"] and remote.interfaces["picker"]["dolly_moved_entity_id"] then
        script.on_event(remote.call("picker", "dolly_moved_entity_id"), Deadzone.on_dolly_moved)
    end
end
Event.addListener("on_init", Deadzone.on_init, true)

function Deadzone.on_load()
    if remote.interfaces["picker"] and remote.interfaces["picker"]["dolly_moved_entity_id"] then
        script.on_event(remote.call("picker", "dolly_moved_entity_id"), Deadzone.on_dolly_moved)
    end
end
Event.addListener("on_load", Deadzone.on_load, true)

function Deadzone.on_runtime_mod_setting_changed( event )
  global.deadzone_construction_denial_range = settings.global["deadzone-construction-denial-range"].value
end
Event.addListener(defines.events.on_runtime_mod_setting_changed, Deadzone.on_runtime_mod_setting_changed)


function Deadzone.on_configuration_changed( event )
  global.deadzone_construction_denial_range = settings.global["deadzone-construction-denial-range"].value
end
Event.addListener("on_configuration_changed", Deadzone.on_configuration_changed, true)

return Deadzone
