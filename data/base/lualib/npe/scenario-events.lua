local locations = require(mod_name .. ".lualib.locations")
local check = require(mod_name .. ".lualib.check")

local scenario_events = {}

local on_player_mined_entity = function(event)
  local list = {'coal'} -- items to remove from production when handcrafted
  for _, item in pairs(list) do
    if event.entity.name == item  and event.buffer.get_item_count(item) > 0 then
      local current = game.players[event.player_index].force.item_production_statistics.input_counts[item]
      game.players[event.player_index].force.item_production_statistics.set_input_count(
        item,
        current - event.buffer.get_item_count(item)
      )
    end
  end

  if global.build_belt_destination and global.build_belt_source then
    local result = check.two_entities_connected_by_belt(global.build_belt_source,global.build_belt_destination)
    if result then
      game.players[event.player_index].print("connection made")
    end
  end
end

local on_player_rotated_entity = function(event)
    if global.build_belt_destination and global.build_belt_source then
    local result = check.two_entities_connected_by_belt(global.build_belt_source,global.build_belt_destination)
    if result then
      game.players[event.player_index].print("connection made")
    end
  end
end

local on_research_finished = function(event)
  if event.research.name == 'improved-equipment' then
    local force = game.forces.player;
    force.set_hand_crafting_disabled_for_recipe('electronic-circuit', false)
    force.set_hand_crafting_disabled_for_recipe('copper-cable', false)
    force.set_hand_crafting_disabled_for_recipe('iron-gear-wheel', false)
    force.set_hand_crafting_disabled_for_recipe('automation-science-pack', false)
    force.set_hand_crafting_disabled_for_recipe('iron-stick', false)
  end
end

local on_entity_cloned = function(event)
  if event.source.name == 'transport-belt' or
    event.source.name == 'stone-furnace' or
    event.source.name == 'burner-inserter' or
    event.source.name == 'wooden-chest' or
    event.source.name == 'burner-mining-drill' then
    event.destination.force = game.forces.player
    event.destination.minable = true
    event.destination.rotatable = true
    event.destination.operable = true
  elseif event.source.force == 'bystander' then
    event.destination.minable = false
    event.destination.operable = true
  end

  if event.destination.supports_backer_name() then
    event.destination.backer_name = ""
  end
end

local on_built_entity = function(event)
  if event.created_entity.supports_backer_name() then
    event.created_entity.backer_name = ""
  end

  if global.build_belt_destination and global.build_belt_source then
    local result = check.two_entities_connected_by_belt(global.build_belt_source,global.build_belt_destination)
    if result then
      game.players[event.player_index].print("connection made")
    else
      game.players[event.player_index].print("no connection made")
    end
  end

end

local on_player_respawned = function()
  local corpse = locations.get_main_surface().find_entities_filtered{type = "character-corpse"}[1]

  if corpse then
    local corpse_inv = corpse.get_inventory(defines.inventory.character_corpse)
    local new_player_inv = main_player().get_main_inventory()

    local items = corpse_inv.get_contents()

    for item_name, item_count in pairs(items) do
      new_player_inv.insert{name=item_name, count=item_count}
    end

    corpse.destroy()
  end
end

scenario_events.events = {
  [defines.events.on_player_mined_entity] = on_player_mined_entity,
  [defines.events.on_player_rotated_entity] = on_player_rotated_entity,
  [defines.events.on_built_entity] = on_built_entity,
  [defines.events.on_entity_cloned] = on_entity_cloned,
  [defines.events.on_research_finished] = on_research_finished,
  [defines.events.on_player_respawned] = on_player_respawned
}

return scenario_events