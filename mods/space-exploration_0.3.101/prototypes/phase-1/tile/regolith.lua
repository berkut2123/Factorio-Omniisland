local data_util = require("data_util")
local noise = require("noise")

local transitions = require("tile-transitions-static")


data:extend(
{
  {
    type = "tile",
    name = data_util.mod_prefix.."regolith",
    collision_mask = {space_collision_layer}, -- nothing?
    autoplace = { -- see final-noise-programs
    },
    layer = 206,
    variants = tile_variations_template(
      "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid.png",
      "__base__/graphics/terrain/masks/transition-3.png",
      data_util.hr("__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid.png"),
      data_util.hr("__base__/graphics/terrain/masks/hr-transition-3.png"),
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010 }, },
        [4] = { probability = 0.1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010 }, },
        --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} },
      }
    ),
    transitions = transitions.cliff_transitions(),
    transitions_between_transitions = transitions.cliff_transitions_between_transitions(),
    walking_sound = table.deepcopy(data.raw.tile["dirt-1"].walking_sound),
    map_color = {r = 128, g = 128, b = 128},
    ageing=0.0001,
    walking_speed_modifier = 1,
    vehicle_friction_modifier = 1,
  },
})
