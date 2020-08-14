local data_util = require("data_util")

local space = {
  type = "tile",
  name = data_util.mod_prefix.."space",
  collision_mask = {
    --"floor-layer", -- to prevent, belts
    "object-layer", -- to prevent certain other structures
    --"item-layer", -- to prevent structures
    "resource-layer", -- to prevent resources
    "doodad-layer", -- to prevent decoratives
    space_collision_layer -- to block vehicles and identify as "in space"
  },
  autoplace = {},
  draw_in_water_layer = true,
  layer = 0,
  variants = tile_variations_template(
    "__space-exploration-graphics__/graphics/terrain/space/space.png",
    "__base__/graphics/terrain/masks/transition-3.png",
    data_util.hr("__space-exploration-hr-graphics__/graphics/terrain/space/hr-space.png"),
    data_util.hr("__base__/graphics/terrain/masks/hr-transition-3.png"),
    {
      max_size = 2,
      [1] = { weights = { 0.185, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
      [2] = { probability = 0.1, weights = {0.018, 0.0010, 0.0015, 0.0025, 0.0015, 0.0010, 0.0025, 0.0015, 0.0010, 0.0025, 0.0010, 0.0025, 0.0020, 0.0025, 0.0025, 0.0010 }, },
      --[4] = { probability = 0.1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010 }, },
      --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} },
    }
  ),
  --transitions = biomes.transitions[biome.transition .. "_transitions"],
  --transitions_between_transitions = biomes.transitions[biome.transition .. "_transitions_between_transitions"],
  --walking_sound = {},
  map_color = {r=11, g=13, b=15},
  pollution_absorption_per_second=0.0001,
  walking_speed_modifier = 0.1,
  vehicle_friction_modifier = 10000,
  decorative_removal_probability = 1,
  needs_correction = false,
}

-- fix tile_variations_template for only size 2 and below
space.variants.main[3] = nil
data:extend{space}
