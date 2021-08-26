-- Table of positions to check for loot to deconstruct
-- Is the automated construction tech researched
-- Change to true if using a Quick Start Mod (like Arumba's) that provides robots/deconstruction planned etc
local auto_cons_researched = true

--								*** Function ***

-- Check if automated construction is researched and change auto_cons_researched to true if so.
function auto_cons_check (force)
    if force then
        if force.technologies["logistic-robotics"].researched then
            auto_cons_researched = true
        end
    elseif game.players[1] and game.players[1].force.technologies["logistic-robotics"].researched then
        auto_cons_researched = true
    end
end


--								*** Scripts ***

--Check if automated construction is researched when a research is finished
script.on_event(defines.events.on_research_finished, function(event)
    auto_cons_check(event.research.force)
end)

-- When an entity dies, we add its position to the table of positions 
-- if we have the automated construction tech and if the mod is enabled
-- ###Big UPS boost created by ptx0### 
script.on_event(defines.events.on_entity_died, function(event)
        local foundLoot = false
        if not global.artifactList then
                log("[LootChestPlus] Initialise artifactList")
                global.artifactList = {}
        end
    if string.find(event.entity.name,"spitter") or string.find(event.entity.name, "biter") or string.find(event.entity.name, "worm") or string.find(event.entity.name, "nest") or string.find(event.entity.name, "spawner") then
                entityLoot = event.loot.get_contents() -- gives LuaInventory
                lootCount = 0
                for key,value in pairs(entityLoot) do
                        lootCount = entityLoot[key]
                        itemName = key
                        if lootCount and lootCount > 0 then
                                foundLoot = true
                                if not global.artifactList[itemName] then
                                        global.artifactList[itemName] = 0
                                end
                                global.artifactList[itemName] = global.artifactList[itemName] + lootCount
                                extraText = ""
                                event.loot.clear()
                                extraText = " Uncollected loot has accumulated."
                        end
                end
        else
                return
        end

    if not foundLoot or global.artifactList == {} then
                return
        end

    --Read global.artifactList and insert into Loot Chest
        --log("[LootChestPlus] artifactList: "..serpent.block(global.artifactList))
        local chest = global.lootChest
        if not chest.valid then
                local errorMsg = "[LootChest+] No loot chest is placed, loot cannot be collected."
                if not global.validChestCheckCount then
                        global.validChestCheckCount = 0
                        game.print(errorMsg)
                end
                if global.validChestCheckCount > 3000 then
                        global.validChestCheckCount = 0
                        game.print(errorMsg)
                else
                        global.validChestCheckCount = global.validChestCheckCount + 1
                end
                return
        end
    local cannotInsert = false
        for _, itemStack in pairs(global.artifactList) do
                if itemStack > 0 then
                        parameters = {}
                        parameters["name"] = _
                        parameters["count"] = itemStack
                        if(chest.valid and chest.can_insert(parameters)) then
                          chest.insert(parameters)
                          global.artifactList[parameters["name"]] = 0
                          event.loot.clear()
                        else
                          cannotInsert = true
                        end
                end
        end
    if chest.valid and cannotInsert then
                for _, plr in pairs(chest.force.players) do
                  plr.print("Cannot insert loot. Artifact loot chest is full."..extraText)
                end
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
