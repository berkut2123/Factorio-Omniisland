-- Table of positions to check for loot to deconstruct
local table_pos = {}
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
		local pos = event.entity.position
		table.insert(table_pos, pos)
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


script.on_event(defines.events.on_tick, function(event)
	
	-- Every 10 seconds
	if event.tick%600 == 0 then
    -- We check if there are some positions to check for loot (table of positions not empty)
  
    if global.lootChest and global.lootChest.valid then
      
      if #table_pos ~= 0 then

      
      
        --##Phase 1
        --Initialise
        local artifactList = {}
        
        
        --##Phase 2
        --Read dead entities and find artifacts
        
        --If there are some, we check positions entity's have died
        for i, pos in ipairs(table_pos) do
          --Local area around dead entity
          local areaToCheck = {left_top = {pos.x-10, pos.y-10}, right_bottom = {pos.x+10, pos.y+10}}
          --Collecting entities around the current position
          itemList = game.surfaces["nauvis"].find_entities_filtered{area = areaToCheck, type = "item-entity"}
          for _, item in ipairs(itemList) do			
           
		   --if the current entity is an item on the ground with the word "artifact", "corpse", "flesh" or "artifact-ore" in the name, we move it
            
            if item.valid and item.stack.valid then
              if string.find(item.stack.name,"artifact") then
                table.insert(artifactList, {name = item.stack.name, count = item.stack.count})
                item.destroy()
              end
            end
			
			if item.valid and item.stack.valid then
              if string.find(item.stack.name,"corpse") then
                table.insert(artifactList, {name = item.stack.name, count = item.stack.count})
                item.destroy()
              end
            end
          		  
		    if item.valid and item.stack.valid then
              if string.find(item.stack.name,"flesh") then
                table.insert(artifactList, {name = item.stack.name, count = item.stack.count})
                item.destroy()
              end
            end
			
			if item.valid and item.stack.valid then
              if string.find(item.stack.name,"chitin") then
                table.insert(artifactList, {name = item.stack.name, count = item.stack.count})
                item.destroy()
              end
            end			
			
			if item.valid and item.stack.valid then
              if string.find(item.stack.name,"artifact-ore") then
                table.insert(artifactList, {name = item.stack.name, count = item.stack.count})
                item.destroy()
              end
            end
			
			if item.valid and item.stack.valid then
              if string.find(item.stack.name,"coin") then
                table.insert(artifactList, {name = item.stack.name, count = item.stack.count})
                item.destroy()
              end
            end
          end
		  
          --position checked so we remove it from the table of positions and we empty the table of entities
          table.remove(table_pos, i)
          itemList = {}
        end
      
        
        --## Phase 3
        --Read artifactList and insert into Loot Chest
        
        if artifactList ~= {} then
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
		chest.surface.spill_item_stack(chest.position, {name="artifact-loot-chest", count = 1})
		chest.destroy()
	end
end