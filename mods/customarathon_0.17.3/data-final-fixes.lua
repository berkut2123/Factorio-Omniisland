-- require "prototypes.functions"

local CML = customarathon.lists
local CMF = customarathon.functions

local function remove_name_from_list(list, name)
  for i in pairs(list) do
    if list[i] == name then
	  table.remove(list, i)
	end
  end
end

-- Expensive ammos from settings
if settings.startup["customarathon-ammos"].value then
   CMF.combine_lists(CML.expensive_usables, CML.ammos)
end

-- Expensive modules from settings
if settings.startup["customarathon-modules"].value then
  table.insert(CML.expensive_items, "module")
end

-- Update lists based on mods loaded
for mod_name, mod in pairs(CML.mods) do
  if mods[mod_name] then --Checking if the mod is present
    if mod.ingredients then
	  for _, item_name in pairs(mod.ingredients) do
	    table.insert(CML.ingredients, item_name)
	  end
	end
    if mod.ingredients_limited then
	  for _, item_name in pairs(mod.ingredients_limited) do
	    CMF.insert_if_not(CML.ingredients, item_name)
	    table.insert(CML.ingredients_limited, item_name)
	  end
	end
	if mod.circuits then
	  for _, item_name in pairs(mod.circuits) do
	    table.insert(CML.circuits, item_name)
	  end
	end
	if mod.results then
	  for _, item_name in pairs(mod.results) do
	    table.insert(CML.results, item_name)
	  end
	end
	if mod.exclude then
	  for _, recipe_name in pairs(mod.exclude) do
	    table.insert(CML.exclude, recipe_name)
	  end
	end
	if mod.remove then
	  for _, item_name in pairs(mod.remove) do
	    remove_name_from_list(CML.ingredients, item_name)
	    remove_name_from_list(CML.ingredients_limited, item_name)
	    remove_name_from_list(CML.circuits, item_name)
	    remove_name_from_list(CML.results, item_name)
	  end
	end
  end
end

CMF.combine_lists(CML.expensives, CML.expensive_usables)
CMF.combine_lists(CML.expensives, CML.expensive_items)

if settings.startup["customarathon-new-items"].value then
  require "prototypes.science-patch"
end

require "prototypes.recipe-patch"