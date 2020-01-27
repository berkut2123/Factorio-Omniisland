-- Table of positions to check for loot to deconstruct
-- Is the automated construction tech researched
-- Change to true if using a Quick Start Mod (like Arumba's) that provides robots/deconstruction planned etc
local auto_cons_researched = true

--								*** Function ***

-- Check if automated construction is researched and change auto_cons_researched to true if so.
function auto_cons_check ()
	if game.players[1].force.technologies["logistic-robotics"].researched then
		auto_cons_researched = true
	end
end


--								*** Scripts ***

--Check if automated construction is researched when a research is finished
script.on_event(defines.events.on_research_finished, function(event)
	auto_cons_check()
end)

-- When an entity dies, we add its position to the table of positions 
-- if we have the automated construction tech and if the mod is enabled
script.on_event(defines.events.on_entity_died, function(event)
	if auto_cons_researched then
		if not global.lootChestPos then
			global.lootChestPos = {}
		end
		table.insert(global.lootChestPos, event.entity.position)
	end
end)

script.on_init(function()
  if not global.lootChest then
		global.lootChest = {}
	end
end)

script.on_event(defines.events.on_built_entity, function(event)
  local entity = event.created_entity
	if entity.name == "artifact-loot-chest" then
		handleBuiltLootChest(event)
	end
end)

script.on_event(defines.events.on_robot_built_entity, function(event)
  local entity = event.created_entity
	if entity.name == "artifact-loot-chest" then
		handleBuiltLootChest(event)
	end
end)

script.on_event(defines.events.on_force_created, function(event)
  global.lootChest = global.lootChest or {}
 end)
 
script.on_event(defines.events.on_entity_cloned, function(event)
  local entity = event.destination
    if entity.name == "artifact-loot-chest" then
	  global.lootChest = entity
	end
end)

script.on_event(defines.events.on_tick, function(event)
	-- Every 10 seconds
	if event.tick%600 ~= 0 or not global.lootChest or not global.lootChest.valid or not global.lootChestPos or #global.lootChestPos == 0 then
		return
	end
	
	--##Phase 1
	--Initialise
	local artifactList = {}
	
	
	--##Phase 2
	--Read dead entities and find artifacts
	
	--If there are some, we check positions entity's have died
	for i, pos in ipairs(global.lootChestPos) do
	  --Local area around dead entity
	  local areaToCheck = {left_top = {pos.x-4, pos.y-4}, right_bottom = {pos.x+4, pos.y+4}}
	  --Collecting entities around the current position
	  local itemList = game.surfaces[global.lootChest.surface.name].find_entities_filtered{area = areaToCheck, type = "item-entity"}
	  for _, item in ipairs(itemList) do			
	   
	   --if the current entity is an item on the ground with the word "artifact", "corpse", "flesh" or "artifact-ore" in the name, we move it
		
		if item.valid and item.stack.valid then
		  if string.find(item.stack.name,"artifact") or string.find(item.stack.name,"corpse") or string.find(item.stack.name,"flesh") or string.find(item.stack.name,"chitin") or string.find(item.stack.name,"coin") then
			table.insert(artifactList, {name = item.stack.name, count = item.stack.count})
			item.destroy()
		  end
		end
	  end
	end
	
	--position checked so we remove it from the table of positions and we empty the table of entities
	global.lootChestPos = {}
  
	
	--## Phase 3
	--Read artifactList and insert into Loot Chest
	
	if #artifactList ~= 0 then
	  local chest = global.lootChest
	  local cannotInsert = false
	  for _, itemStack in pairs(artifactList) do
		if(chest.can_insert(itemStack)) then
		  chest.insert(itemStack)
		else
		  cannotInsert = true
		end
	  end
	  
	  if cannotInsert then
		for _, plr in pairs(chest.force.players) do
		  plr.print("Cannot insert loot. Artifact loot chest is full.")
		end
	  end
	end
end)



--logic for handling loot chest spawning, cannot have more than one per force.
function handleBuiltLootChest(event)

	--check if there is a global table entry for loot chests yet, make one if not.
	if not global.lootChest then
		global.lootChest = {}
	end
	
	local chest = event.created_entity
  
	if not global.lootChest or not global.lootChest.valid  then
		global.lootChest = chest   --this is now the force's chest. 
	else
		game.players[1].print("You can place only one loot chest!")
		chest.surface.spill_item_stack(chest.position, {name="artifact-loot-chest", count = 1}, true, chest.force)
		chest.destroy()
	end
end