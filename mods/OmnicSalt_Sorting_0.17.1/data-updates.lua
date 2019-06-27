local oretypes = {"angels-ore1", "angels-ore2", "angels-ore3", "angels-ore4", "angels-ore5", "angels-ore6"}
if mods['Clowns-Extended-Minerals'] then
  oretypes[#oretypes+1] = "clowns-ore1"
  oretypes[#oretypes+1] = "clowns-ore2"
  oretypes[#oretypes+1] = "clowns-ore3"
  oretypes[#oretypes+1] = "clowns-ore4"
  oretypes[#oretypes+1] = "clowns-ore5"
  oretypes[#oretypes+1] = "clowns-ore6"
  oretypes[#oretypes+1] = "clowns-ore7"
end
local oregrades = {"crushed", "chunk", "crystal", "pure"}


function convert_ingredients(base_recipe, item_name)
	if base_recipe.normal then
		return {
       	{ type="item", name=item_name, amount=base_recipe.normal.ingredients[2].amount },
       }
     end
     if base_recipe.ingredients then
		return {
       	{ type="item", name=item_name, amount=base_recipe.ingredients[2].amount }
       }
     end
end


local toAdd = {}
for _, oregrade in ipairs(oregrades) do
  for _, oretype in ipairs(oretypes) do
  	 local loc_keys = {{ oregrade }, {oretype}}
  	 local base_name = oretype.."-"..oregrade.."-salting"
  	 local base_recipe = data.raw.recipe[base_name]
  	 if base_recipe == nil then return end
  	 local item_name = oretype.."-"..oregrade.."-salt"
     local iconBase = { {icon = "__angelsrefining__/graphics/icons/"..oretype.."-"..oregrade.."-sorting.png"} }
	 if string.find(oretype, "clowns") then
	   iconBase =  { {
	   	  icon = "__Clowns-Processing__/graphics/icons/sorting.png",
	   }, {
	 	  icon = "__Clowns-Extended-Minerals__/graphics/icons/"..oretype.."/"..oregrade..".png",
	  	  scale = 0.45,
	 	  shift = { -10, 10 }
	   } }
	 end
     iconBase[#iconBase+1] = {
     		icon = "__omnimatter_crystal__/graphics/icons/omnide-salt.png",
       		scale = 0.5,
       		shift = { -10, -10 },
       	}
     local ing_prod = {}
     ing_prod["ingredients"] = convert_ingredients(base_recipe, item_name)
     ing_prod.enabled = true
     ing_prod.energy_required = 5
     if	base_recipe.normal then
     	ing_prod["results"] = table.deepcopy(base_recipe.normal.results)
     else
     	ing_prod["results"] = table.deepcopy(base_recipe.results)
     end
     toAdd[#toAdd+1] = {
       type="recipe",
       name = oretype.."-"..oregrade.."-saltmix-sorting",
  	   localised_name = {"recipe-name.saltmix-sorting", { "lookup."..oregrade }, {"lookup."..oretype}},
	   localised_description = {"recipe-description.saltmix-sorting", { "lookup."..oregrade }, {"lookup."..oretype}},
       category="ore-sorting",
       normal = ing_prod,
       icons =  iconBase,
       icon_size = 32,
       subgroup ="omni-salts-"..string.sub(oretype,1,1).."-"..oregrade,
       order = oretype,
     }
     if data.raw.recipe[oretype.."-"..oregrade.."-salting"].results then
     	data.raw.recipe[oretype.."-"..oregrade.."-salting"].results = convert_ingredients(base_recipe, item_name)
     	data.raw.recipe[oretype.."-"..oregrade.."-salting"].result = convert_ingredients(base_recipe, item_name)
     elseif data.raw.recipe[oretype.."-"..oregrade.."-salting"].normal then
     	data.raw.recipe[oretype.."-"..oregrade.."-salting"].normal.results = convert_ingredients(base_recipe, item_name)
     end
     	data.raw.recipe[oretype.."-"..oregrade.."-salting"].localised_name = {"recipe-name.omnide-salting", { "lookup."..oregrade }, {"lookup."..oretype}}
     	data.raw.recipe[oretype.."-"..oregrade.."-salting"].localised_description = {"recipe-description.omnide-salting", { "lookup."..oregrade }, {"lookup."..oretype}}
	   local iconBase = "__angelsrefining__/graphics/icons/"..oretype.."-"..oregrade..".png"
	   if string.find(oretype, "clowns") then
	     iconBase = "__Clowns-Extended-Minerals__/graphics/icons/"..oretype.."/"..oregrade..".png"
	   end
     toAdd[#toAdd+1] = {
       type="item",
       name=item_name,
		localised_name = {"item-name.salt", { "lookup."..oregrade }, {"lookup."..oretype}},
		localised_description = {"item-description.salt", { "lookup."..oregrade }, {"lookup."..oretype}},
       icons = {
       	{ icon = "__omnimatter_crystal__/graphics/icons/omnide-salt.png", },
       	{
       		icon = iconBase,
       		scale = 0.35,
       		shift = { -10, -10 },
       	}
       },
       icon_size=32,
       subgroup="omni-salts-"..string.sub(oretype,1,1).."-"..oregrade,
       order="a["..oretype.."]",
       stack_size=200
     }
  end
end
toAdd[#toAdd+1] = {
	type="item-subgroup",
	name="omni-salts-a-crushed",
	group="resource-refining",
	order="z-a"
}
toAdd[#toAdd+1] = {
	type="item-subgroup",
	name="omni-salts-c-crushed",
	group="resource-refining",
	order="z-b"
}
toAdd[#toAdd+1] = {
	type="item-subgroup",
	name="omni-salts-a-chunk",
	group="resource-refining",
	order="z-c"
}
toAdd[#toAdd+1] = {
	type="item-subgroup",
	name="omni-salts-c-chunk",
	group="resource-refining",
	order="z-d"
}
toAdd[#toAdd+1] = {
	type="item-subgroup",
	name="omni-salts-a-crystal",
	group="resource-refining",
	order="z-e"
}
toAdd[#toAdd+1] = {
	type="item-subgroup",
	name="omni-salts-c-crystal",
	group="resource-refining",
	order="z-f"
}
toAdd[#toAdd+1] = {
	type="item-subgroup",
	name="omni-salts-a-pure",
	group="resource-refining",
	order="z-g"
}
toAdd[#toAdd+1] = {
	type="item-subgroup",
	name="omni-salts-c-pure",
	group="resource-refining",
	order="z-h"
}

data:extend(toAdd)

for grade_idx, oregrade in ipairs(oregrades) do
  for _, oretype in ipairs(oretypes) do
	--omni.lib.add_unlock_recipe("crystallology-1", oretype.."-"..oregrade.."-saltmix-sorting")
	data.raw.technology["crystallology-"..grade_idx].effects[#data.raw.technology["crystallology-"..grade_idx].effects+1] =  {type="unlock-recipe",recipe = oretype.."-"..oregrade.."-saltmix-sorting"}
	data.raw.recipe[oretype.."-"..oregrade.."-saltmix-sorting"].enabled = false
  end
end