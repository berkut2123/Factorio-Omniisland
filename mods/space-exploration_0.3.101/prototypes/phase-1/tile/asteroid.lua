local data_util = require("data_util")
local noise = require("noise")


data:extend(
{
  {
    type = "tile",
    name = data_util.mod_prefix.."asteroid",
    collision_mask = {space_collision_layer}, -- nothing?
    autoplace = { -- see final-noise-programs
    },
    layer = 20,
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
    walking_sound = table.deepcopy(data.raw.tile["dirt-1"].walking_sound),
    map_color = {r = 128, g = 128, b = 128},
    ageing=0.0001,
    walking_speed_modifier = 1,
    vehicle_friction_modifier = 1,
    transitions = {
        {
          to_tiles = {
            "water",
            "deepwater",
            "water-green",
            "deepwater-green",
            "water-shallow",
            "water-mud",
            data_util.mod_prefix .. "space"
          },
          transition_group = 1,
          inner_corner = {
            count = 5,
            hr_version = data_util.hr({
              count = 5,
              line_length = 5,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 0
            }),
            line_length = 5,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = true,
            x = 0,
            y = 0
          },
          inner_corner_background = {
            count = 5,
            hr_version = data_util.hr({
              count = 5,
              line_length = 5,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 0
            }),
            line_length = 5,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = true,
            x = 544,
            y = 0
          },
          inner_corner_mask = {
            count = 5,
            hr_version = data_util.hr({
              count = 5,
              line_length = 5,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              x = 2176,
              y = 0
            }),
            line_length = 5,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            x = 1088,
            y = 0
          },
          o_transition = {
            count = 4,
            hr_version = data_util.hr({
              count = 4,
              line_length = 4,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = false,
              x = 0,
              y = 2304
            }),
            line_length = 4,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = false,
            x = 0,
            y = 1152
          },
          o_transition_background = {
            count = 4,
            hr_version = data_util.hr({
              count = 4,
              line_length = 4,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = false,
              x = 1088,
              y = 2304
            }),
            line_length = 4,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = false,
            x = 544,
            y = 1152
          },
          o_transition_mask = {
            count = 4,
            hr_version = data_util.hr({
              count = 4,
              line_length = 4,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              x = 2176,
              y = 2304
            }),
            line_length = 4,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            x = 1088,
            y = 1152
          },
          outer_corner = {
            count = 5,
            hr_version = data_util.hr({
              count = 5,
              line_length = 5,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 576
            }),
            line_length = 5,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = true,
            x = 0,
            y = 288
          },
          outer_corner_background = {
            count = 5,
            hr_version = data_util.hr({
              count = 5,
              line_length = 5,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 576
            }),
            line_length = 5,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = true,
            x = 544,
            y = 288
          },
          outer_corner_mask = {
            count = 5,
            hr_version = data_util.hr({
              count = 5,
              line_length = 5,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              x = 2176,
              y = 576
            }),
            line_length = 5,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            x = 1088,
            y = 288
          },
          side = {
            count = 5,
            hr_version = data_util.hr({
              count = 5,
              line_length = 5,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1152
            }),
            line_length = 5,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = true,
            x = 0,
            y = 576
          },
          side_background = {
            count = 5,
            hr_version = data_util.hr({
              count = 5,
              line_length = 5,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1152
            }),
            line_length = 5,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = true,
            x = 544,
            y = 576
          },
          side_mask = {
            count = 5,
            hr_version = data_util.hr({
              count = 5,
              line_length = 5,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              x = 2176,
              y = 1152
            }),
            line_length = 5,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            x = 1088,
            y = 576
          },
          u_transition = {
            count = 2,
            hr_version = data_util.hr({
              count = 2,
              line_length = 2,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1728
            }),
            line_length = 2,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = true,
            x = 0,
            y = 864
          },
          u_transition_background = {
            count = 2,
            hr_version = data_util.hr({
              count = 2,
              line_length = 2,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1728
            }),
            line_length = 2,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            tall = true,
            x = 544,
            y = 864
          },
          u_transition_mask = {
            count = 2,
            hr_version = data_util.hr({
              count = 2,
              line_length = 2,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/asteroid/hr-asteroid-cliff.png",
              scale = 0.5,
              x = 2176,
              y = 1728
            }),
            line_length = 2,
            picture = "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid-cliff.png",
            x = 1088,
            y = 864
          }
        },
      }
  },
})
table.insert(data.raw.tile[data_util.mod_prefix.."asteroid"].transitions[1].to_tiles, data_util.mod_prefix.."space")
