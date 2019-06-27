--Main reverse recipe function
require("add-recipes")

--Remove Bio Industries dissassemble recipes
if data.raw.recipe["bi_steel_furnace_disassemble"] then
  data.raw.recipe["bi_steel_furnace_disassemble"].hidden = true
  data.raw.recipe["bi_burner_mining_drill_disassemble"].hidden = true
  data.raw.recipe["bi_stone_furnace_disassemble"].hidden = true
  data.raw.recipe["bi_burner_inserter_disassemble"].hidden = true
  data.raw.recipe["bi_long_handed_inserter_disassemble"].hidden = true
  thxbob.lib.tech.remove_recipe_unlock("advanced-material-processing", "bi_steel_furnace_disassemble")
  thxbob.lib.tech.remove_recipe_unlock("automation-2", "bi_burner_mining_drill_disassemble")
  thxbob.lib.tech.remove_recipe_unlock("automation-2", "bi_stone_furnace_disassemble")
  thxbob.lib.tech.remove_recipe_unlock("automation-2", "bi_burner_inserter_disassemble")
  thxbob.lib.tech.remove_recipe_unlock("automation-2", "bi_long_handed_inserter_disassemble")
end

--Manually add Bio Industries terraformer
if data.raw.recipe["bi_Arboretum"] then if data.raw.item["bi-Arboretum-Area"] then
	createManualDualRecipe(data.raw.recipe["bi_Arboretum"], data.raw.item["bi-Arboretum-Area"])
end end

--Manually add Natural Evolution Buildings copper firearm magazine
if data.raw.recipe["copper_bullets"] then if data.raw.item["copper-bullet-magazine"] then
	createManualSimpleRecipe(data.raw.recipe["copper_bullets"], data.raw.item["copper-bullet-magazine"])
end end

--error(serpent.block(data.raw.recipe["bronze-alloy"].results[1].amount))

--Create recycling recipes
addRecipes(data.raw.ammo)					--Create recipes for all ammunitions
addRecipes(data.raw.armor)					--Create recipes for all armors
addRecipes(data.raw.item)						--Create recipes for all items
addRecipes(data.raw.gun)						--Create recipes for all weapons
addRecipes(data.raw.capsule)					--Create recipes for all capsules
addRecipes(data.raw.module)					--Create recipes for all modules
addRecipes(data.raw.tool)						--Create recipes for all forms of science packs
addRecipes(data.raw["rail-planner"])		--Create recipe for rail. Seriously, just rail.
addRecipes(data.raw["mining-tool"])		--Create recipes for all mining tools
addRecipes(data.raw["repair-tool"]) 		--Create recipes for all repair tools
if rf.vehicles then
	addRecipes(data.raw["item-with-entity-data"]) 		--Create recipes for vehicles
end

--Add the new recipes in data
data:extend(rf.recipes)

--Extend outputs to max number of results in currently scanned game
data.raw.furnace["reverse-factory-1"].result_inventory_size = rf.maxt1
data.raw.furnace["reverse-factory-2"].result_inventory_size = rf.maxt2
--[[
--Fixes recipes to the end of the assembling machine row
if data.raw.item["mini-assembler-6"] then 
	data.raw.item["reverse-factory-1"].subgroup = data.raw.item["mini-assembler-6"].subgroup
	data.raw.item["reverse-factory-1"].order = data.raw.item["mini-assembler-6"].order.."-a"
elseif data.raw.item["assembling-machine-6"] then 
	data.raw.item["reverse-factory-1"].subgroup = data.raw.item["assembling-machine-6"].subgroup
	data.raw.item["reverse-factory-1"].order = data.raw.item["assembling-machine-6"].order.."-a"
elseif data.raw.item["mini-assembler-3"] then 
	data.raw.item["reverse-factory-1"].subgroup = data.raw.item["mini-assembler-3"].subgroup
	data.raw.item["reverse-factory-1"].order = data.raw.item["mini-assembler-3"].order.."-a"
else 
	data.raw.item["reverse-factory-1"].subgroup = data.raw.item["assembling-machine-3"].subgroup
	data.raw.item["reverse-factory-1"].order = data.raw.item["assembling-machine-3"].order.."-a"
end
data.raw.item["reverse-factory-2"].subgroup = data.raw.item["reverse-factory-1"].subgroup
data.raw.item["reverse-factory-2"].order = data.raw.item["reverse-factory-1"].order.."-b"
]]--

--error(serpent.block(data.raw.item["heavy-water"]))