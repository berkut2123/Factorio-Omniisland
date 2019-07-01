local CMF = customarathon.functions
local CML = customarathon.lists

local EQUIPMENT = CML.equipment
local ENTITIES = CML.entities
local SUCCESSIVE = CML.successive
local INGREDIENTS = CML.ingredients
local ING_LIMITED = CML.ingredients_limited
local CIRCUITS = CML.circuits
local RESULTS = CML.results
local EXCLUDE = CML.exclude
local EXPENSIVES = CML.expensives

-- SCANNING ALL RECIPES AND REFERENCE THEM --

local recipe_list = {}

for _, recipe_data in pairs(data.raw.recipe) do
  --Safety measures for barreling and excluded recipes
  if not( (string.find(recipe_data.name, "fill") or string.find(recipe_data.name, "empty")) and string.find(recipe_data.name, "barrel") ) and not CMF.is_name_in_list(recipe_data.name, EXCLUDE) then
    
    recipe_list[recipe_data.name] = {}
    
	local recipe = recipe_data.expensive or recipe_data
	
	-- SCANNING RESULTS --
	
    local all_results = CMF.get_recipe_results(recipe)
	
    if all_results then
	  recipe_list[recipe_data.name].results = {}
	  recipe_list[recipe_data.name].types = {}
      for _, result_name in pairs(all_results) do
		local result_type = CMF.get_item_prototype_type(result_name) --Checking the type of the result (item, entity, equipment, ammmo...)
		
		if CMF.is_name_in_list(result_type, EXPENSIVES) then --Checking the type to mark recipe as potential marathon
		  recipe_list[recipe_data.name].expensive_result = true
		  recipe_list[recipe_data.name].marathon = true
		  
		  if settings.startup["customarathon-tiers"].value ~= 1 then --Marking the recipe as tiered
		    recipe_list[recipe_data.name].tiered = true
			recipe_list[recipe_data.name].first_tier = true --Marking as the first tier but removing it when finding a tiered ingredient
		    CMF.insert_if_not(recipe_list[recipe_data.name].results, result_name) --Referencing the expensive result to further determine the tier
		    CMF.insert_if_not(recipe_list[recipe_data.name].types, result_type) --Referencing the type to avoid issues on cascading effects through different types
		  end
		  
		elseif settings.startup["customarathon-usables"].value ~= 1 and CMF.is_name_in_list(result_name, RESULTS) then
		  recipe_list[recipe_data.name].expensive_result = true --Checking the result to mark recipe as potential marathon
        end
		
		if settings.startup["customarathon-successive"].value and CMF.is_name_in_list(result_type, SUCCESSIVE) then
		  recipe_list[recipe_data.name].successive = true
		end
		
        if settings.startup["customarathon-ingredients"].value ~= 1 and CMF.is_name_in_list(result_name, INGREDIENTS) then
          recipe_list[recipe_data.name].ingredient_in_result = true --Checking if result is in list of ingredients to avoid cascading effects
		end
        if settings.startup["customarathon-circuits"].value and CMF.is_name_in_list(result_name, CIRCUITS) then
          recipe_list[recipe_data.name].circuit_in_result = true --Checking if result is in list of circuits to avoid cascading effects
        end
      end
	end
	
	-- SCANNING INGREDIENTS AND APPLYING MULTIPLIER --
	
	if recipe.ingredients then
	  recipe_list[recipe_data.name].ingredients = {}
	  
	  for index, ingredient in pairs(recipe.ingredients) do
	    local ing_name = CMF.get_ingredient_name(ingredient)
		local ing_type = CMF.get_item_prototype_type(ing_name)
		recipe_list[recipe_data.name].ingredients[index] = {}
		local multiplier = 1
		
		--Setting up expensive ingredients
		if settings.startup["customarathon-ingredients"].value ~= 1 then
		  --Checking to prevent cascading effects based on ingredients, and setting up the multiplier
          if CMF.is_name_in_list(ing_name, INGREDIENTS) and not recipe_list[recipe_data.name].ingredient_in_result or CMF.is_name_in_list(ing_name, CIRCUITS) and not recipe_list[recipe_data.name].circuit_in_result then
		    local limited = CMF.is_name_in_list(ing_name, ING_LIMITED) --Second check to force limited ingredients to be expensive only in specific recipes, again to avoid cascading
		    if not limited or ( limited and ( recipe_list[recipe_data.name].circuit_in_result or recipe_list[recipe_data.name].expensive_result ) ) then
              multiplier = settings.startup["customarathon-ingredients"].value
	        end
		  end
		end
		
		--Setting up the whole expensive recipe
		if recipe_list[recipe_data.name].expensive_result then
		  --Checking for cascading effect
		  local expensive = CMF.is_name_in_list(ing_type, EXPENSIVES)
		  local result = CMF.is_name_in_list(ing_name, RESULTS)
		  local excluded
		  
		  if expensive then
			if recipe_list[recipe_data.name].successive then
			  for _, result_type in pairs(recipe_list[recipe_data.name].types) do
			    if result_type == ing_type then
			      multiplier = multiplier * 2 --For successive setting, double the ingredient
				  break
				end
			  end
			end
			
			if recipe_list[recipe_data.name].tiered then
		      recipe_list[recipe_data.name].ingredients[index].excluded = true --Exclude the ingredient from being affected by tier modifier later on
			  for _, result_type in pairs(recipe_list[recipe_data.name].types) do
			    if result_type == ing_type then
			      recipe_list[recipe_data.name].first_tier = false
		          recipe_list[recipe_data.name].ingredients[index].name = ing_name --Referencing the expensive ingredient to further determine the tier
			    else
				  -- log(recipe_data.name .. " has been marked as tier 1")
				end
			  end
			end
		  end
		  
		  if not expensive and not result and #CMF.get_recipes_by_result(ing_name) == 0 then --In case the ingredient cannot be obtained in any recipe (Angel's tree on the map)
		    local is_resource
		    for _, resource in pairs(data.raw.resource) do
		      if resource.minable and ( resource.minable.result == ing_name or ( resource.minable.results and resource.minable.results.name == ing_name ) ) then
			    is_resource = true --Also making sure it's not an obtainable resource
			  end
		    end
		    if not is_resource then
		      recipe_list[recipe_data.name].ingredients[index].excluded = true --Exclude that unobtainable item
			  excluded = true
		    end
		  end
		  
		  if not expensive and not result and not excluded then --No cascading effect detected, therefore the ingredient gets the multiplier
		    multiplier = multiplier * settings.startup["customarathon-usables"].value
		  end
		end
		
		
		recipe_list[recipe_data.name].ingredients[index].multi = multiplier
		if multiplier ~= 1 then
		  recipe_list[recipe_data.name].marathon = true
		end
	  end
	end
  end
end

for recipe_name, info in pairs(recipe_list) do
  if not info.marathon then
    recipe_list[recipe_name] = nil --Clearing out the recipes that are not marathonized
  end
end

-- SETTING UP THE TIERS --

local loop_check = {}

local function tier_up(recipe_name, previous_tier)
  if CMF.is_name_in_list(recipe_name, loop_check) then
    return nil
  end
  table.insert(loop_check, recipe_name)
  if not recipe_list[recipe_name].tier or previous_tier >= recipe_list[recipe_name].tier then
    recipe_list[recipe_name].tier = previous_tier + 1
	-- log(recipe_name .. " is now tier " .. recipe_list[recipe_name].tier)
  end
  
  --Looking for the higher tier recipe through the referened recipes
  for _, result_name in pairs(recipe_list[recipe_name].results) do
	for next_tier_recipe_name, info in pairs(recipe_list) do
	  for i, ingredient in pairs(info.ingredients) do
	    if ingredient.name == result_name then --Checking if both prototypes are the same type
		  tier_up(next_tier_recipe_name, recipe_list[recipe_name].tier) 
		end
	  end
	end
  end
end

local silo_tier = 6
local silo_pack_count = 5
if data.raw.technology["rocket-silo"] and data.raw.technology["rocket-silo"].unit and data.raw.technology["rocket-silo"].unit.ingredients then
  silo_pack_count = #data.raw.technology["rocket-silo"].unit.ingredients
end

for recipe_name, info in pairs(recipe_list) do
  --Going for the first tiered recipe and tiering up the whole chain
  if info.tiered and info.first_tier then
    local tier
	if data.raw.recipe[recipe_name].enabled then
	  tier = 0 --The recipe is enabled by default, it is tier 0
	else
      for _, tech in pairs(data.raw.technology) do --Looking through what tech unlocks the recipe, and determines the tier based on that
	    if tech.effects then
	      for k, effect in pairs(tech.effects) do
		    if effect.recipe == recipe_name then
			  --Calculating tier of tech based on number of different packs the silo requires
			  if tech.unit and tech.unit.ingredients then
		        local tech_tier = math.floor( #tech.unit.ingredients / silo_pack_count * silo_tier )
		        if tier then --Taking minimum tech tier for the recipe if it's present on multiple techs
			      tier = math.min(tier, tech_tier)
			    else
			      tier = tech_tier
			    end
			  end
			  break
		    end
		  end
	    end
	  end
	end
	tier_up(recipe_name, tier or 0)
	loop_check = {}
  end
end

-- PATCHING RECIPES --

for recipe_name, info in pairs(recipe_list) do
  local recipe_data = data.raw.recipe[recipe_name]
  if not recipe_data.expensive then
    CMF.normalize_recipe(recipe_data) --Adding normal and expensive recipes (if needed)
  else
    recipe_data.expensive = table.deepcopy(recipe_data.normal) --Replacing Expensive Recipe with regular recipe to apply modifications
  end
  
  for index, ingredient in pairs(recipe_data.expensive.ingredients) do
    if info.ingredients[index] then
      if not info.ingredients[index].excluded and info.tiered and info.tier and info.tier > 1 then
	    local tier_multiplier = math.pow(settings.startup["customarathon-tiers"].value, info.tier - 1)
	    -- log(recipe_data.name .. " receives a " .. tier_multiplier .. " multiplier for " .. CMF.get_ingredient_name(ingredient) .. " ingredient")
	    CMF.multiply_ingredient(ingredient, info.ingredients[index].multi * tier_multiplier)
	  else
	    CMF.multiply_ingredient(ingredient, info.ingredients[index].multi)
	  end
	end
  end
  
  if info.expensive_result and settings.startup["customarathon-crafting-time"].value ~= 1 then
	CMF.multiply_energy(recipe_data.expensive, settings.startup["customarathon-crafting-time"].value)
  end
end
