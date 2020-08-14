data.raw["optimized-decorative"]["light-mud-decal"].tile_layer = default_decal_layer
data.raw["optimized-decorative"]["dark-mud-decal"].tile_layer = default_decal_layer
data.raw["optimized-decorative"]["puberty-decal"].tile_layer = default_decal_layer
data.raw["optimized-decorative"]["red-desert-decal"].tile_layer = default_decal_layer

local require_water = function(type, name)
  local prototype = data.raw[type][name]
  if not (prototype and prototype.autoplace and prototype.autoplace.peaks) then return end
  -- apply negative out of max range
  table.insert(prototype.autoplace.peaks, {
    water_optimal = 1,
    water_range = 0.5,
    water_max_range = 0.7,
    influence = 1,
    max_influence = 0,
  })

end
require_water("optimized-decorative", "brown-asterisk")
require_water("optimized-decorative", "brown-fluff-dry")
require_water("optimized-decorative", "brown-fluff")
require_water("optimized-decorative", "red-pita")
