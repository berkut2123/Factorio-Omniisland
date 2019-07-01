local CMF = customarathon.functions
local CML = customarathon.lists

local INGREDIENTS = CML.ingredients
local CIRCUITS = CML.circuits
local RESULTS = CML.results
local EXPENSIVES = CML.expensives

local PACKS = {"rocket-part", "satellite"}
for _, pack in pairs(data.raw.tool) do
  table.insert(PACKS, pack.name)
end

local item_list = {}
local loop_checks = {}
  
local function is_item_usable(item_name)
  if not item_list[item_name] then
    item_list[item_name] = {}
  end
  if item_list[item_name].usable then
    return true
  end
  if not item_list[item_name].usable_checked and not loop_checks[item_name] then
    item_list[item_name].usable_checked = true
	local item_type = CMF.get_item_prototype_type(item_name)
    if item_type ~= "item" and item_type ~= "fluid" and item_type ~= "tool" then
      item_list[item_name].usable = true
      return true
    elseif item_type == "item" and data.raw.item[item_name].fuel_value then
	  return true
	end
    for _, recipe_data in pairs(data.raw.recipe) do
      local recipe = recipe_data.expensive or recipe_data
	  local check
      if recipe.ingredients then
	    for i, ing in pairs(recipe.ingredients) do
		  if CMF.get_ingredient_name(ing) == item_name then
		    check = true
	      end
		end
	  end
	  if check then
	    for i, ing in pairs(recipe.ingredients) do
		  loop_checks[CMF.get_ingredient_name(ing)] = true
		end
		local all_results = CMF.get_recipe_results(recipe)
		for i, result in pairs(all_results) do
		  if is_item_usable(result) then
		    item_list[item_name].usable = true
			return true
		  end
		end
	  end
	end
  end
end
  
local function check_for_rework(item_name)
  if item_list[item_name] and not item_list[item_name].rework and item_list[item_name].parents then
    loop_checks = {}
	is_item_usable(item_name)
    item_list[item_name].rework = true
	for _, parent in pairs(item_list[item_name].parents) do
      check_for_rework(parent)
    end
  end
end
  
local function check_recipe(recipe_data, parent_name) -- Recursive function to create new non marathonized dummy items instead of expensive entities
  if (string.find(recipe_data.name, "fill") or string.find(recipe_data.name, "empty")) and string.find(recipe_data.name, "barrel") then
    return nil -- Cancel if the recipe is barrelling
  end
  local recipe = recipe_data.expensive or recipe_data
  for _, ing in pairs(recipe.ingredients) do
    local ing_name = CMF.get_ingredient_name(ing)
    if CMF.is_name_in_list(ing_name, item_list) or not( CMF.is_name_in_list(ing_name, INGREDIENTS) or CMF.is_name_in_list(ing_name, CIRCUITS) ) then -- These items are safe and not expensive, no need to check for them
      if not item_list[ing_name] then -- The item is not referred yet
        item_list[ing_name] = {} -- Adding the item for further checks
      end
      local item_data = item_list[ing_name]
        
      if not item_data.parents then -- The item has no parent
        item_data.parents = {} -- First time item is referred: create table 
      end
      CMF.insert_if_not(item_data.parents, parent_name) -- Add the parent (result of recipe)
        
      if item_data.rework or CMF.is_name_in_list(CMF.get_item_prototype_type(ing_name), EXPENSIVES) or CMF.is_name_in_list(ing_name, RESULTS) then -- Expensive item detected
        check_for_rework(ing_name) -- Also mark parent as rework
      end
        
      if not item_data.checked then -- Checking item only once
        item_data.checked = true
        local recipes_for_item = CMF.get_recipes_by_result(ing_name) -- List all the recipes giving the item
        if recipes_for_item then
          item_data.recipes = recipes_for_item -- List the recipes for use later
          for _, recipe_for_item in pairs(recipes_for_item) do
            check_recipe(recipe_for_item, ing_name) -- Recursion, going down the items to the source
          end
        end
      end
    end
  end
end
  
local raw_recipes = {}
  
for _, recipe_data in pairs(data.raw.recipe) do
  local recipe = recipe_data.expensive or recipe_data
  results = CMF.get_recipe_results(recipe)
  for _, result in pairs(results) do
    if CMF.is_name_in_list(result, PACKS) then
      table.insert(raw_recipes, recipe_data)
      check_recipe(recipe_data, result)
    end
  end
end

local new_items = {}
local item_names = {}
local name_extension = "-marathoscience"

local function new_barrelling(fluid_name)
  for _, recipe_data in pairs(data.raw.recipe) do
    local recipe = recipe_data.expensive or recipe_data
    if string.find(recipe_data.name, "fill") and string.find(recipe_data.name, "barrel") then
	  for i, ing in pairs(recipe.ingredients) do
	    if fluid_name == CMF.get_ingredient_name(ing) then
		  local result = recipe.result or recipe.results[1].name or recipe.results[1][1]
		  item_list[result] = { rework = true, usable = true, recipes = { recipe_data } }
		end
	  end
	elseif string.find(recipe_data.name, "empty") and string.find(recipe_data.name, "barrel") then
	  for i, res in pairs(recipe.results) do
	    if fluid_name == CMF.get_ingredient_name(res) then
		  table.insert(raw_recipes, recipe_data)
		end
	  end
	end
  end
end
  
for item_name, item_info in pairs(item_list) do
  if item_info.rework then
    local original_item = CMF.get_item_prototype(item_name)
    if item_info.usable then
      local new_item = {}
      new_item.name = original_item.name .. name_extension
	  if original_item.type == "fluid" then
	    new_barrelling(original_item.name)
	    new_item.type = "fluid"
	    new_item.base_color = original_item.base_color
	    new_item.flow_color = original_item.flow_color
	    new_item.default_temperature = original_item.default_temperature
	    new_item.max_temperature = original_item.max_temperature
	    new_item.flow_to_energy_ratio = original_item.flow_to_energy_ratio
	    new_item.heat_capacity = original_item.heat_capacity
	    new_item.pressure_to_speed_ratio = original_item.pressure_to_speed_ratio
	    new_item.localised_name = {"science-suffix", {"fluid-name." .. original_item.name}}
	  else
        new_item.type = "item"
        -- new_item.flags = { "goes-to-main-inventory" }
        new_item.stack_size = original_item.stack_size
        new_item.subgroup = "intermediate-product"
        local original_localization = ""
        if original_item.localised_name then
          original_localization = table.deepcopy(original_item.localised_name)
        elseif original_item.place_result then
          original_localization = {"entity-name." .. original_item.place_result}
        elseif original_item.placed_as_equipment_result then
          original_localization = {"equipment-name." .. original_item.placed_as_equipment_result}
        else
          original_localization = {"item-name." .. original_item.name}
        end
        new_item.localised_name = {"science-suffix", original_localization}
	  end
      new_item.localised_description = {"for-science"}
	  
      -- new_item.icons = { { icon = original_item.icon, icon_size = original_item.icon_size / 2 }, { icon = "__base__/graphics/icons/science-pack-1.png", icon_size = 8, shift = { 0, 5 } } }
	  if original_item.icon then
	    new_item.icons = { { icon = original_item.icon, icon_size = original_icon_size } }
	  else
	    new_item.icons = original_item.icons
	  end
	  table.insert(new_item.icons, { icon = "__base__/graphics/icons/automation-science-pack.png", scale = 0.45, shift = {10, -10} })
      new_item.icon_size = original_item.icon_size or original_item.icons[1].icon_size
      new_item.order = "s[customarathon]" .. ( original_item.order or "" )
	  
      table.insert(new_items, new_item)
      table.insert(item_names, original_item.name)
    end
    for _, recipe in pairs(item_info.recipes) do
      CMF.insert_if_not(raw_recipes, recipe)
    end
  end
end
   
local new_recipes = {}
local function patch_extension_results(recipe)
  if recipe then
    if recipe.result then
      if CMF.is_name_in_list(recipe.result, item_names) then
        recipe.result = recipe.result .. name_extension
      end
	end
    if recipe.main_product then
      if CMF.is_name_in_list(recipe.main_product, item_names) then
        recipe.main_product = recipe.main_product .. name_extension
      end
    end
	if recipe.results then
      for i, result in pairs(recipe.results) do
	    local key = CMF.get_name_key(result)
        if CMF.is_name_in_list(result[key], item_names) then
          result[key] = result[key] .. name_extension
        -- elseif not CMF.is_name_in_list(result[key], PACKS) then
          -- recipe.results[i] = nil
        end
      end
	end
  end
end
local function patch_extension_ingredients(recipe)
  if recipe and recipe.ingredients then
    for _, ingredient in pairs(recipe.ingredients) do
      local key = CMF.get_name_key(ingredient)
      if CMF.is_name_in_list(ingredient[key], item_names) and not CMF.is_name_in_list(ingredient[key], PACKS) then
        ingredient[key] = ingredient[key] .. name_extension
      end
    end
  end
end

for _, recipe_data in pairs(raw_recipes) do
  local recipe = recipe_data.expensive or recipe_data
  local results = CMF.get_recipe_results(recipe)
  local cancel, pack = false, false
  for _, result in pairs(results) do
    if CMF.is_name_in_list(result, PACKS) then
	  cancel = true
	  pack = true
	  for k, ingredient in pairs(recipe.ingredients) do
	    local ing_name = CMF.get_ingredient_name(ingredient)
		if CMF.is_name_in_list(ing_name, item_names) then
		  cancel = false
		end
	  end
	end
  end

  if not cancel then
    new_recipe = table.deepcopy(recipe_data)
    new_recipe.name = recipe_data.name .. name_extension
  
    patch_extension_results(new_recipe)
    patch_extension_results(new_recipe.normal)
    patch_extension_results(new_recipe.expensive)
    patch_extension_ingredients(new_recipe)
    patch_extension_ingredients(new_recipe.normal)
    patch_extension_ingredients(new_recipe.expensive)
  
    if recipe_data.localised_name and not pack then
	  new_recipe.localised_name = {"science-suffix", table.deepcopy(recipe_data.localised_name)}
	elseif recipe.results and #recipe.results > 1 and not( recipe.main_product or recipe.main_product == "" ) then
	  new_recipe.localised_name = {"science-suffix", {"recipe.name." .. recipe_data.name} }
	end
	if pack then
	  new_recipe.subgroup = "science-pack"
	else
	  new_recipe.subgroup = "intermediate-product"
	end
  
    table.insert(new_recipes, new_recipe)
  
    for _, module in pairs(data.raw.module) do
      if module.effect and module.effect.productivity and module.limitation then
        table.insert(module.limitation, new_recipe.name)
      end
    end
    
    for _, tech in pairs(data.raw.technology) do
      if tech.effects then
        for _, effect in pairs(tech.effects) do
          if effect.recipe == recipe_data.name then
            local new_effect = table.deepcopy(effect)
            new_effect.recipe = new_recipe.name
            table.insert(tech.effects, new_effect)
          end
        end
      end
    end
  end
end
  
if #new_recipes > 0 then
  data:extend(new_items)
  data:extend(new_recipes)
end
if data.raw.recipe["rocket-part" .. name_extension ] then
  data.raw["rocket-silo"]["rocket-silo"].fixed_recipe = "rocket-part" .. name_extension
end