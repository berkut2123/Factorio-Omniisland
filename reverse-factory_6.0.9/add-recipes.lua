rf.maxt1 = 1
rf.maxt2 = 1
local yuokiSuffix = "-recipe"

--Framework for adding recipes
function addRecipes(category)
	for item_name, item in pairs(category) do
		local recipe = data.raw.recipe[item_name] and data.raw.recipe[item_name] or data.raw.recipe[item_name..yuokiSuffix]
		--If recipe is not nil
		if recipe then
			--Check recipe has at least 1 product to use as an ingredient
			if recipe.result_count ~= 0 then
				--Check if simple recipes has ingredients table, and at least one ingredient under that table
				if recipe.ingredients then if next(recipe.ingredients) then
					if uncraftable(recipe, item) then new_recipe = createSimpleRecipe(recipe, item) end
				end end
				--Same check, but for normal/expensive recipes; fails unless both recipe types were properly defined
				if recipe.normal then if recipe.normal.ingredients then if next(recipe.normal.ingredients) then
					if recipe.expensive then if recipe.expensive.ingredients then if next(recipe.expensive.ingredients) then
						if uncraftable(recipe,item) then new_recipe = createDualRecipe(recipe, item) end
					end end end
				end end end
			end
		end
		table.insert(rf.recipes, new_recipe)
	end
end

--Used for basic recipes
function createSimpleRecipe(recipe, item)
	local rec_count = recipe.result_count and recipe.result_count or 1
	if recipe.results then if recipe.results[1] then if recipe.results[1].amount then
		rec_count = recipe.results[1].amount
	end end end
	local rec_name = string.gsub(recipe.name, yuokiSuffix, "")
	local new_recipe = {}
	new_recipe = {
		type = "recipe",
		name = "rf-"..rec_name,
		icon = item.icon,
		icon_size = item.icon_size,
		subgroup = "rf-multiple-outputs",
		category = "recycle",
		hidden = "true",
		energy_required = 30,
		ingredients = {{rec_name, rec_count}},
		results = recipe.ingredients,
		allow_decomposition = false
	}
	--Icons supercede the use of icon
	if item.icons then
		new_recipe.icons = item.icons
	end
	--If outputs fluid, set to separate category
	local fluid = false
	for _, ingred in ipairs(recipe.ingredients) do
		if ingred.type == "fluid" then fluid = true end
	end
	--Fluid determines max products for tier 2 recycler
	if fluid then
		new_recipe.category = "recycle-with-fluids"
		rf.maxt2 = math.max(#recipe.ingredients, rf.maxt2, rf.maxt1)
	else rf.maxt1 = math.max(#recipe.ingredients, rf.maxt1)
	end
	
	return new_recipe
end

--Used for normal/expensive recipes
function createDualRecipe(recipe, item)
	local normacount = recipe.normal.result_count and recipe.normal.result_count or 1
	if recipe.normal.results then if recipe.normal.results[1] then if recipe.normal.results[1].amount then
		normacount = recipe.normal.results[1].amount
	end end end
	local expencount = recipe.expensive.result_count and recipe.expensive.result_count or 1
	if recipe.expensive.results then if recipe.expensive.results[1] then if recipe.expensive.results[1].amount then
		expencount = recipe.expensive.results[1].amount
	end end end
	local rec_name = string.gsub(recipe.name, yuokiSuffix, "")
	local new_recipe = {}
	new_recipe = {
		type = "recipe",
		name = "rf-"..rec_name,
		icon = item.icon,
		icon_size = item.icon_size,
		category = "recycle",
		normal = {
			ingredients = {{rec_name, normacount}},
			results = recipe.normal.ingredients,
			hidden = "true",
			energy_required = 30,
			allow_decomposition = false
			},
		expensive = {
			ingredients = {{rec_name, expencount}},
			results = recipe.expensive.ingredients,
			hidden = "true",
			energy_required = 30,
			allow_decomposition = false
			},
		subgroup = "rf-multiple-outputs"
		}
	--Icons supercede the use of icon
	if item.icons then
		new_recipe.icons = item.icons
	end
	--If outputs fluid, set to separate category
	local fluid = false
	for _, ingred in ipairs(recipe.normal.ingredients) do
		if ingred.type == "fluid" then fluid = true end
	end
	for _, ingred in ipairs(recipe.expensive.ingredients) do
		if ingred.type == "fluid" then fluid = true end
	end
	--Fluid determines max products for tier 2 recycler
	if fluid then
		new_recipe.category = "recycle-with-fluids"
		rf.maxt2 = math.max(#recipe.normal.ingredients, #recipe.expensive.ingredients, rf.maxt2, rf.maxt1)
	else rf.maxt1 = math.max(#recipe.normal.ingredients, #recipe.expensive.ingredients, rf.maxt1)
	end
	
	return new_recipe
end

--Used to manually add simple recipes whose items are named differently (not caught by the automatic function)
function createManualSimpleRecipe(recipe, item)
	local rec_count = recipe.result_count and recipe.result_count or 1
	local new_recipe = {
		type = "recipe",
		name = "rf-"..recipe.name,
		icon = item.icon,
		icon_size = item.icon_size,
		category = "recycle",
		hidden = "true",
		energy_required = 30,
		ingredients = {{item.name, rec_count}},
		subgroup="rf-multiple-outputs",
		allow_decomposition = false
	}
	--Icons supercede the use of icon
	if item.icons then
		new_recipe.icons = item.icons
	end
	--Fluid determines max products for tier 2 recycler
	if fluid then
		new_recipe.category = "recycle-with-fluids"
		rf.maxt2 = math.max(#recipe.normal.ingredients, #recipe.expensive.ingredients, rf.maxt2, rf.maxt1)
	else rf.maxt1 = math.max(#recipe.normal.ingredients, #recipe.expensive.ingredients, rf.maxt1)
	end
	table.insert(rf.recipes, new_recipe)
end

--Used to manually add dual recipes whose items are named differently (not caught by the automatic function)
function createManualDualRecipe(recipe, item)
	local normacount = recipe.normal.result_count and recipe.normal.result_count or 1
	local expencount = recipe.expensive.result_count and recipe.expensive.result_count or 1
	local new_recipe = {
		type = "recipe",
		name = "rf-"..recipe.name,
		icon = item.icon,
		icon_size = item.icon_size,
		category = "recycle",
		normal = {
			ingredients = {{item.name, normacount}},
			results = recipe.normal.ingredients,
			hidden = "true",
			energy_required = 30,
			allow_decomposition = false
			},
		expensive = {
			ingredients = {{item.name, expencount}},
			results = recipe.expensive.ingredients,
			hidden = "true",
			energy_required = 30,
			allow_decomposition = false
			},
		subgroup="rf-multiple-outputs"
	}
	--Icons supercede the use of icon
	if item.icons then
		new_recipe.icons = item.icons
	end
	--Fluid determines max products for tier 2 recycler
	if fluid then
		new_recipe.category = "recycle-with-fluids"
		rf.maxt2 = math.max(#recipe.normal.ingredients, #recipe.expensive.ingredients, rf.maxt2, rf.maxt1)
	else rf.maxt1 = math.max(#recipe.normal.ingredients, #recipe.expensive.ingredients, rf.maxt1)
	end
	table.insert(rf.recipes, new_recipe)
end

--Always true if safety is toggled off. Safety prevents ingredient loss. Only works for simple and normal variant recipes.
--I also borrowed it to disable an angels crushed stone recipe (which just duplicates, for some reason)
function uncraftable(recipe, item)
	local uncraft = true
	if next(rf.norecycle_items) then
		for _, recipename in ipairs(rf.norecycle_items) do
			if recipe.name == recipename then uncraft = false end
		end
	end
	if next(rf.norecycle_categories) then
		for _, category in ipairs(rf.norecycle_categories) do
			if recipe.category == category then uncraft = false end
		end
	end
	if recipe.name == "stone-crushed" then
		uncraft = false
	end
	if rf.intermediates then
		if item.subgroup == "intermediate-product" then uncraft = false end
	end
	if not uncraft then log("Item cannot be uncrafted: "..item.name) end
	return uncraft
end


--[[
--Checks recipe for inconsistencies; Possibly no longer necessary
function errorCheck(nrec, orec, item)
	local noError = false
	local step = 0
	--If simple recipe has ingredients, no error
	if nrec.ingredients then
		noError = true
	--If complex recipe has normal and expensive ingredients, no error
	--Otherwise, log last successful step, and provide a courtesy error
	elseif nrec.normal then
		step = 1
		if nrec.normal.ingredients then
			step = 2
			if nrec.expensive then
				step = 3
				if nrec.expensive.ingredients then
					noError = true
				end
			end
		end
	end
	--If there was an error, report the recipe name, and what step it failed (if applicable)
	if not noError then
		local message = "\nThis recipe was not properly created: " .. item.name
		message = message.."\n".."You should report this error to the creator of that item"
		if step == 1 then
			message = message.."\n\n".."This recipe has no ingredients listed under its normal.ingredients"
			message = message.."\n".."Recipe info listed below for your convenience"
			message = message.."\n\n"..serpent.block(orec)
		elseif step == 2 then
			message = message.."\n\n".."This recipe has no expensive field in its recipe"
			message = message.."\n".."Recipe info listed below for your convenience"
			message = message.."\n\n"..serpent.block(orec)
		elseif step == 3 then
			message = message.."\n\n".."This recipe has no ingredients listed under its expensive.ingredients"
			message = message.."\n".."Recipe info listed below for your convenience"
			message = message.."\n\n"..serpent.block(orec)
		end
		error(message)
	end
	return noError 
end
]]--
