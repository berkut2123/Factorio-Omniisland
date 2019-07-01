local CMF = customarathon.functions
local CML = customarathon.lists

local EQUIPMENT = CML.equipment
local ENTITIES = CML.entities
local ITEMS = CML.items
local TYPES = {}

for _, type_name in pairs(EQUIPMENT) do
  table.insert(TYPES, type_name)
end
for _, type_name in pairs(ENTITIES) do
  table.insert(TYPES, type_name)
end

-- TABLE FUNCTIONS --

function CMF.is_name_in_list(name, list)
  if not list then return nil end
  for _, name_check in pairs(list) do
    if name == name_check then
      return true
    end
  end
end

function CMF.insert_if_not(list, object)
  if not CMF.is_name_in_list(object, list) then
    table.insert(list, object)
  end
end

function CMF.combine_lists(list1, list2)
  for _, content in pairs(list2) do
    CMF.insert_if_not(list1, content)
  end
end

-- GET FUNCTIONS --

function CMF.get_name_key(ingredient) --For recipes, get where the amount of items is in the table
  if ingredient.name then return "name" else return 1 end
end

function CMF.get_amount_key(ingredient) --For recipes, get where the name of the item is in the table
  if ingredient.amount then return "amount" else return 2 end
end

function CMF.get_ingredient_name(ingredient)
  return ingredient.name or ingredient[1]
end

function CMF.get_ingredient_amount(ingredient)
  return ingredient.amount or ingredient[2]
end

function CMF.get_recipe_results(recipe) --Warning: recipe here will sometimes refer to normal or expensive
  local all_results = {}
  if recipe.result then
    table.insert(all_results, recipe.result)
  end
  if recipe.main_product and recipe.main_product ~= "" then
    table.insert(all_results, recipe.main_product)
  end
  if recipe.results then
    for _, result in pairs(recipe.results) do
      CMF.insert_if_not(all_results, result.name or result[1])
    end
  end
  return all_results
end

function CMF.get_recipes_by_result(item_name)
  local recipe_list = {}
  for _, recipe_data in pairs(data.raw.recipe) do
    if recipe_data.normal then
      recipe = recipe_data.normal
    else
      recipe = recipe_data
    end
    for _, result in pairs(CMF.get_recipe_results(recipe)) do
      if result == item_name then
        table.insert(recipe_list, recipe_data)
        break
      end
    end
  end
  return recipe_list
end

function CMF.get_entity_name_of_item(item_name) --Gets the entity name an item (if it exists)
  local item_data = data.raw.item[item_name]
  if item_data then
    if item_data.place_result then
      return item_data.place_result
    elseif item_data.place_as_tile then
      return item_data.place_as_tile.result
    end
  end
end

function CMF.get_item_prototype(item_name) --Not recipes, not techs, not entities... but item
  for _, type_check in pairs(ITEMS) do
    local proto = data.raw[type_check][item_name]
    if proto then
      return proto
    end
  end
  --Preparing error if the item is not found
  local proto_list = ""
  for proto_type in pairs(data.raw) do
    if data.raw[proto_type][item_name] then
      proto_list = proto_list .. proto_type .. " + "
    end
  end
  error(item_name .. " not found in prototypes. Mod needs to update the prototype detection, being one of these: \n" .. proto_list )
end

function CMF.get_place_prototype(item) --Argument can be either prototype or item name
  if type(item) == "string" then
    item = data.raw.item[item]
  end
  if item then
    if item.place_result then
	  for _, entity_type in pairs(ENTITIES) do
	    local entity = data.raw[entity_type][item.place_result]
	    if entity then
		  return entity
		end
	  end
	elseif item.place_as_tile then
	  return data.raw.tile[item.place_as_tile]
	elseif item.placed_as_equipment_result then
	  for _, equipment_type in pairs(EQUIPMENT) do
	    local equipment = data.raw[equipment_type][item.placed_as_equipment_result]
	    if equipment then
		  return equipment
		end
	  end
	end
  end
end

function CMF.get_item_prototype_type(item_name) --Returns the placement result type (if it exists) instead of item type, that way we can scan entities and equipment
  local item = CMF.get_item_prototype(item_name)
  local item_type = item.type
  if item_type == "item" then
    local place_proto = CMF.get_place_prototype(item)
	if place_proto then
	  item_type = place_proto.type
	end
  end
  return item_type
end

function CMF.get_item_type(item_name) --Returns entity type if item is also an entity (not interesting in knowing an item type is item...)
  local entity_name = CMF.get_entity_name_of_item(item_name)
  if entity_name then
    for _, type_check in pairs(TYPES) do
      if data.raw[type_check][entity_name] then
        return type_check
      end
    end
  else
    for _, type_check in pairs(TYPES) do
      if data.raw[type_check][item_name] then
        return type_check
      end
    end
  end
end

function CMF.get_true_item_type(item_name) --Will return item this time if item type is item!
  for _, type_check in pairs(ITEMS) do
    if data.raw[type_check][item_name] then
      return type_check
    end
  end
end


-- CHECK FUNCTIONS --

function CMF.is_ingredient_in_list(ingredient, list)
  return CMF.is_name_in_list(CMF.get_ingredient_name(ingredient), list)
end

function CMF.is_item_in_type_list(item_name, type_list)
  for _, type_check in pairs(type_list) do
    if data.raw[type_check][item_name] then
      return true
    end
  end
end

function CMF.is_entity_item_in_type_list(item_name, list)
  local entity_name = CMF.get_entity_name_of_item(item_name)
  if entity_name then
    for _, type_check in pairs(list) do
      if data.raw[type_check][entity_name] then
        return true
      end
    end
  end
end

-- BUILDER FUNCTIONS --

function CMF.multiply_ingredient(ingredient, multi)
  if multi and multi ~= 1 and ingredient then
    local key = CMF.get_amount_key(ingredient)
    local new_amount = math.floor(ingredient[key] * multi + 0.5)
    if new_amount > 65535 then
      new_amount = 65535
    elseif new_amount < 1 then
	  new_amount = 1
	end
    ingredient[key] = new_amount
  end
end

function CMF.multiply_energy(recipe, multi)
  if multi then
    if recipe.energy_required then
	  recipe.energy_required = recipe.energy_required * multi
	else
	  recipe.energy_required = 0.5 * multi
	end
  end
end

function CMF.normalize_recipe(recipe_data)
  local general_properties = { "type", "name", "category", "subgroup", "icons", "icon", "icon_size", "crafting_machine_tint" }
  if recipe_data and not recipe_data.normal and not recipe_data.expensive then
    local recipe = {}
    for index, content in pairs(recipe_data) do
      if not CMF.is_name_in_list(index, general_properties) then
        recipe[index] = content
		recipe_data[index] = nil
      end
    end
    recipe_data.normal = table.deepcopy(recipe)
    recipe_data.expensive = table.deepcopy(recipe)
  end
end