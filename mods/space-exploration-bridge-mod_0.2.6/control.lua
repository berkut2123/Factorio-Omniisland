-- control.lua

--AsteroidMinerDrill
AMD = {}

AMD.name_amd_placeholder = "asteroid-miner-placeholder"
AMD.name_amd = "asteroid-miner-drill"
AMD.se_asteroid = "se-asteroid"
AMD.se_scaffold = "se-space-platform-scaffold"
AMD.name_dust_resource = "asteroid-dust-resource"
AMD.flying_text_placement = "Must be placed on an asteroid to get dust."

function create_asteroid_miner(event)
	local entity
	local ghost = 0
	if event.entity and event.entity.valid then
		entity = event.entity
		if event.entity.type == 'entity-ghost' and event.entity.ghost_name == AMD.name_amd_placeholder then
			ghost = 1
		end
	end
	if event.created_entity and event.created_entity.valid then
		entity = event.created_entity
		if event.created_entity.type == 'entity-ghost' and event.created_entity.ghost_name == AMD.name_amd_placeholder then
			ghost = 1
		end

	end
	if not entity then
		return
	end
	if entity.name == AMD.name_amd_placeholder or ghost == 1 then
		if entity.surface and entity.surface.get_tile(entity.position.x, entity.position.y) then
			local tile = entity.surface.get_tile(entity.position.x, entity.position.y)
			
			if (entity.name == AMD.name_amd_placeholder) then
				--identified as entity
				if (tile.name == AMD.se_asteroid) then
					-- place infinity, invisible resource near miner
					local resource = entity.surface.create_entity{
						name = AMD.name_dust_resource,
						position = entity.position,
						direction = entity.direction,
						amount = 1000,
					}
					
					-- place real miner drill
					local mining_drill = entity.surface.create_entity{
						name = AMD.name_amd,
						--position = entity.position,
						position = {x = entity.position.x, y = entity.position.y + 1/32},
						direction = entity.direction,
						force = entity.force
					}
					entity.destructible = false
				else
					cancel_entity_creation(entity, event.player_index, AMD.flying_text_placement)
					return
				end
			else
				--identified as entity ghost
				if (tile.name == AMD.se_asteroid) then
					return
				else
					-- cancel ghost
					entity.surface.create_entity{
						name = "flying-text",
						position = entity.position,
						text = AMD.flying_text_placement,
						render_player_index = event.player_index,
					}
					entity.destroy()
				end
			end
		end
	end	
end

script.on_event(defines.events.on_built_entity, create_asteroid_miner)
script.on_event(defines.events.on_robot_built_entity, create_asteroid_miner)
script.on_event(defines.events.script_raised_built, create_asteroid_miner)
script.on_event(defines.events.script_raised_revive, create_asteroid_miner)

function delete_asteroid_miner(event)
	local entity
	if event.entity and event.entity.valid then
		entity = event.entity
	end
	if event.created_entity and event.created_entity.valid then
		entity = event.created_entity
	end
	if not entity then
	return
	end
	--Case1: find and delete miner drill. Normally the drill shoud be deleted(Case2). This case should not happen and is only a fail safe.
	if entity.name == AMD.name_amd_placeholder then
		local position = entity.position
		--find and delete miner
		local entities = entity.surface.find_entities_filtered{position= entity.position, name= AMD.name_amd}
		for key,entity in pairs(entities) do
			entity.destroy()
		end
		--find and delete resource
		local resources = entity.surface.find_entities_filtered{position= entity.position, name= AMD.name_dust_resource}
		for key,resource in pairs(resources) do
			resource.destroy()
		end
	end
	--Case2: find and delete miner placeholder. Normally the drill will be deleted and this case is executed.
	if entity.name == AMD.name_amd then
		local position = entity.position
		--find and delete miner
		local entities = entity.surface.find_entities_filtered{position= entity.position, name= AMD.name_amd_placeholder}
		for key,entity in pairs(entities) do
			entity.destroy()
		end
		--find and delete resource
		local resources = entity.surface.find_entities_filtered{position= entity.position, name= AMD.name_dust_resource}
		for key,resource in pairs(resources) do
			resource.destroy()
		end
	end
end

script.on_event(defines.events.on_player_mined_entity, delete_asteroid_miner)
script.on_event(defines.events.on_robot_mined_entity, delete_asteroid_miner)
script.on_event(defines.events.on_entity_died, delete_asteroid_miner)
script.on_event(defines.events.script_raised_destroy, delete_asteroid_miner)

-- Great helper function (with kind permission from Earendel)
function cancel_entity_creation(entity, player_index, message)
	-- put an item back in the inventory or drop to ground
	-- display flying text
	local player
	if player_index then
		player = game.players[player_index]
	end
	local inserted = 0
	if player then
		inserted = player.insert{name = entity.prototype.items_to_place_this[1].name, count = 1}
	end
	if inserted == 0 and entity.prototype.items_to_place_this[1] and entity.prototype.items_to_place_this[1].name then
		entity.surface.create_entity{
			name = "item-on-ground",
			position = entity.position,
			["item-entity"] = {name = entity.prototype.items_to_place_this[1].name, count = 1}
		}
	end
	entity.surface.create_entity{
		name = "flying-text",
		position = entity.position,
		text = message,
		render_player_index = player_index,
	}
	entity.destroy()
end

-- simple entity does not support rotation, bake into graphics variation
function on_player_rotated_entity(event)
  if event.entity and event.entity.valid then
    local surface = event.entity.surface
    if event.entity.name == AMD.name_amd then
      local e = event.entity.surface.find_entity(AMD.name_amd_placeholder, event.entity.position)
      --if e then e.graphics_variation = Coreminer.direction_to_variation(event.entity.direction) end
      if e then e.direction = event.entity.direction end
    end
  end
end
script.on_event(defines.events.on_player_rotated_entity, on_player_rotated_entity)