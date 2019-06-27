local config = require "config"
local tile_layer_correction = require("util/tile-layer-correction")

-- only if Bio_Industries is present:
if config.use_BioIndustries_items and data.raw["item"]["stone-crushed"] then
	data.raw["recipe"]["Arci-asphalt"].ingredients[3] = {type="item", name="stone-crushed", amount=8}
else 
    data.raw["recipe"]["Arci-asphalt"].ingredients[3] = {type="item", name="stone-brick", amount=4}
end 

-- only if Wood_Gasification is present:
if config.use_WoodGasification_items and data.raw["fluid"]["tar"] then
	data.raw["recipe"]["Arci-asphalt"].ingredients[1] = {type="fluid", name="tar", amount=2}
else 
    data.raw["recipe"]["Arci-asphalt"].ingredients[1] = {type="fluid", name="crude-oil", amount=30}
end 

-- asphalt has a lower layer than stone or other tilesets. The following function increases the layer of all tilesets accordingly.
tile_layer_correction.shift_tile_layer(config.asphalt_base_layer, 2) 