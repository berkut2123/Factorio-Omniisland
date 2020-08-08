data.raw.recipe["electric-energy-interface"].enabled = true
data.raw.item["electric-energy-interface"].subgroup = "modding"
data.raw.recipe["player-port"].enabled = true
data.raw.item["player-port"].subgroup = "modding"
local infinity_chest_recipe = table.deepcopy(data.raw.recipe["player-port"])
infinity_chest_recipe.enabled = true
infinity_chest_recipe.name = "infinity-chest"
infinity_chest_recipe.result = "infinity-chest"
data:extend({infinity_chest_recipe})
data.raw.item["infinity-chest"].subgroup = "modding"
--0.17  

local infinity_pipe_recipe = table.deepcopy(data.raw.recipe["chemical-plant"])
infinity_pipe_recipe.name = "infinity-pipe"
infinity_pipe_recipe.result = "infinity-pipe"
infinity_pipe_recipe.enabled = true
data.raw.item["infinity-pipe"].subgroup = "modding"

data:extend({infinity_pipe_recipe})
--
local radar = table.deepcopy (data.raw.radar.radar)
radar.name = "modding_radar"
radar.max_distance_of_sector_revealed=50
radar.max_distance_of_nearby_sector_revealed=50
radar.energy_per_sector="1W"

local radar_item = table.deepcopy (data.raw.item.radar)
radar_item.name = "modding_radar"
radar_item.place_result = "modding_radar"
radar_item.subgroup = "modding"
radar_item.icons = {{icon=radar_item.icon,tint={r=1.0, g=0.2, b=0.2}}}
radar_item.icon = nil

local radar_recipe = table.deepcopy(data.raw.recipe.radar)
radar_recipe.name = "modding_radar"
radar_recipe.result = "modding_radar"
radar_recipe.enabled = true

local heat_recipe = table.deepcopy(data.raw.recipe.radar)
heat_recipe.name = "heat-interface"
heat_recipe.result = "heat-interface"
heat_recipe.enabled = true

data.raw.item["heat-interface"].subgroup = "modding"
data:extend({
radar,
radar_item,
radar_recipe,
heat_recipe,

	{
		type = "item-subgroup",
		name = "modding",
		group = "logistics",
		order = "zzz"
	}
  })