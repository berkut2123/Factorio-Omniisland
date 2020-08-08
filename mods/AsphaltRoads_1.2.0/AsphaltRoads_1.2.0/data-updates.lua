local config = require "config"
local tile_layer_correction = require("util/tile-layer-correction")
local werkzeug = require "util/metamodutil"

-- only if Bio_Industries is present:
if config.use_BioIndustries_items and mods["Bio_Industries"] then
    if data.raw["item"]["stone-crushed"] then
        werkzeug.remove_recipe_ingredient("Arci-asphalt","stone-brick")
        werkzeug.add_recipe_ingredient("Arci-asphalt", {type = "item", name = "stone-crushed", amount = 8})
    end
end

-- only if Wood_Gasification is present:
if config.use_WoodGasification_items and mods["Wood_Gasification"] then
    if data.raw["fluid"]["tar"] then
        werkzeug.replace_recipe_ingredient("Arci-asphalt","crude-oil","tar")
    end
end

-- only if Py_Petroleumhandling is present:
if config.use_PyPetrol_items and mods["pypetroleumhandling"] then
    if data.raw["fluid"]["tar"] and data.raw["fluid"]["bitumen"] then
        werkzeug.clear_recipe_ingredients("Arci-asphalt")
        werkzeug.add_recipe_ingredient("Arci-asphalt", {type = "item", name = "gravel", amount = 8})
        werkzeug.add_recipe_ingredient("Arci-asphalt", {type = "fluid", name = "tar", amount = 40})
        werkzeug.add_recipe_ingredient("Arci-asphalt", {type = "fluid", name = "bitumen", amount = 60})
    end
end

-- asphalt has a lower layer than stone or other tilesets. The following function increases the layer of all tilesets accordingly.
tile_layer_correction.shift_tile_layer(config.asphalt_base_layer, 2) 