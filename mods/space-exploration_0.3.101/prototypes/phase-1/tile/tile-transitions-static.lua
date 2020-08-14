local data_util = require("data_util")

function space_exploration_cliff_transitions()
  return {
        {
          inner_corner = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 0
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = true,
            x = 0,
            y = 0
          },
          inner_corner_background = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 0
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = true,
            x = 544,
            y = 0
          },
          inner_corner_mask = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              x = 2176,
              y = 0
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            x = 1088,
            y = 0
          },
          o_transition = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = false,
              x = 0,
              y = 2304
            }),
            line_length = 4,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = false,
            x = 0,
            y = 1152
          },
          o_transition_background = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = false,
              x = 1088,
              y = 2304
            }),
            line_length = 4,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = false,
            x = 544,
            y = 1152
          },
          o_transition_mask = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              x = 2176,
              y = 2304
            }),
            line_length = 4,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            x = 1088,
            y = 1152
          },
          outer_corner = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 576
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = true,
            x = 0,
            y = 288
          },
          outer_corner_background = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 576
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = true,
            x = 544,
            y = 288
          },
          outer_corner_mask = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              x = 2176,
              y = 576
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            x = 1088,
            y = 288
          },
          side = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1152
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = true,
            x = 0,
            y = 576
          },
          side_background = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1152
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = true,
            x = 544,
            y = 576
          },
          side_mask = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              x = 2176,
              y = 1152
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            x = 1088,
            y = 576
          },
          to_tiles = {
            "water",
            "deepwater",
            "water-green",
            "deepwater-green",
            "water-shallow",
            "water-mud"
          },
          transition_group = 1,
          u_transition = {
            count = 2,
            hr_version = data_util.hr( {
              count = 2,
              line_length = 2,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1728
            }),
            line_length = 2,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = true,
            x = 0,
            y = 864
          },
          u_transition_background = {
            count = 2,
            hr_version = data_util.hr( {
              count = 2,
              line_length = 2,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1728
            }),
            line_length = 2,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            tall = true,
            x = 544,
            y = 864
          },
          u_transition_mask = {
            count = 2,
            hr_version = data_util.hr( {
              count = 2,
              line_length = 2,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff.png",
              scale = 0.5,
              x = 2176,
              y = 1728
            }),
            line_length = 2,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff.png",
            x = 1088,
            y = 864
          }
        },
        {
          background_layer_group = "zero",
          background_layer_offset = 1,
          inner_corner_background = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 0
            }),
            line_length = 4,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 0
          },
          inner_corner_mask = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 0
            }),
            line_length = 4,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            x = 1088,
            y = 0
          },
          o_transition_background = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              tall = false,
              x = 1088,
              y = 2304
            }),
            line_length = 1,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            tall = false,
            x = 544,
            y = 1152
          },
          o_transition_mask = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 2304
            }),
            line_length = 1,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            x = 1088,
            y = 1152
          },
          offset_background_layer_by_tile_layer = true,
          outer_corner_background = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 576
            }),
            line_length = 4,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 288
          },
          outer_corner_mask = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 576
            }),
            line_length = 4,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            x = 1088,
            y = 288
          },
          side_background = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1152
            }),
            line_length = 8,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 576
          },
          side_mask = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 1152
            }),
            line_length = 8,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            x = 1088,
            y = 576
          },
          to_tiles = {
            "out-of-map"
          },
          transition_group = 2,
          u_transition_background = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1728
            }),
            line_length = 1,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 864
          },
          u_transition_mask = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 1728
            }),
            line_length = 1,
            picture = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
            x = 1088,
            y = 864
          }
        }
      }

end

function space_exploration_cliff_transitions_between_transitions()
  return {
        {
          inner_corner = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 0
            }),
            line_length = 3,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            tall = true,
            x = 0,
            y = 0
          },
          inner_corner_background = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 0
            }),
            line_length = 3,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            tall = true,
            x = 544,
            y = 0
          },
          inner_corner_mask = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              x = 2176,
              y = 0
            }),
            line_length = 3,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            x = 1088,
            y = 0
          },
          outer_corner = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 576
            }),
            line_length = 3,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            tall = true,
            x = 0,
            y = 288
          },
          outer_corner_background = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 576
            }),
            line_length = 3,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            tall = true,
            x = 544,
            y = 288
          },
          outer_corner_mask = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              x = 2176,
              y = 576
            }),
            line_length = 3,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            x = 1088,
            y = 288
          },
          side = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1152
            }),
            line_length = 3,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            tall = true,
            x = 0,
            y = 576
          },
          side_background = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1152
            }),
            line_length = 3,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            tall = true,
            x = 544,
            y = 576
          },
          side_mask = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              x = 2176,
              y = 1152
            }),
            line_length = 3,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            x = 1088,
            y = 576
          },
          transition_group = 0,
          transition_group1 = 0,
          transition_group2 = 1,
          u_transition = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1728
            }),
            line_length = 1,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            tall = true,
            x = 0,
            y = 864
          },
          u_transition_background = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1728
            }),
            line_length = 1,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            tall = true,
            x = 544,
            y = 864
          },
          u_transition_mask = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/water-transitions/hr/cliff-transition.png",
              scale = 0.5,
              x = 2176,
              y = 1728
            }),
            line_length = 1,
            picture = "__space-exploration-graphics__/graphics/terrain/water-transitions/sr/cliff-transition.png",
            x = 1088,
            y = 864
          },
          water_patch = {
            filename = "__base__/graphics/terrain/water-transitions/water-patch.png",
            height = 32,
            hr_version = data_util.hr( {
              filename = "__base__/graphics/terrain/water-transitions/hr-water-patch.png",
              height = 64,
              scale = 0.5,
              width = 64
            }),
            width = 32
          }
        },
        {
          background_layer_group = "zero",
          background_layer_offset = 1,
          inner_corner_background = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dirt-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 0
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 0
          },
          inner_corner_mask = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dirt-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 0
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
            x = 1088,
            y = 0
          },
          offset_background_layer_by_tile_layer = true,
          outer_corner_background = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dirt-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 576
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 288
          },
          outer_corner_mask = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dirt-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 576
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
            x = 1088,
            y = 288
          },
          side_background = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dirt-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1152
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 576
          },
          side_mask = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dirt-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 1152
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
            x = 1088,
            y = 576
          },
          transition_group = 0,
          transition_group1 = 0,
          transition_group2 = 2,
          u_transition_background = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dirt-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1728
            }),
            line_length = 1,
            picture = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 864
          },
          u_transition_mask = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dirt-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 1728
            }),
            line_length = 1,
            picture = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
            x = 1088,
            y = 864
          },
          water_patch = nil
        },
        {
          background_layer_group = "zero",
          background_layer_offset = 1,
          inner_corner = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 0
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            tall = true,
            x = 0,
            y = 0
          },
          inner_corner_background = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 0
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 0
          },
          inner_corner_mask = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 0
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            x = 1088,
            y = 0
          },
          offset_background_layer_by_tile_layer = true,
          outer_corner = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 576
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            tall = true,
            x = 0,
            y = 288
          },
          outer_corner_background = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 576
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 288
          },
          outer_corner_mask = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 576
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            x = 1088,
            y = 288
          },
          side = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1152
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            tall = true,
            x = 0,
            y = 576
          },
          side_background = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1152
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 576
          },
          side_mask = {
            count = 3,
            hr_version = data_util.hr( {
              count = 3,
              line_length = 3,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 1152
            }),
            line_length = 3,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            x = 1088,
            y = 576
          },
          transition_group = 1,
          transition_group1 = 1,
          transition_group2 = 2,
          u_transition = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1728
            }),
            line_length = 1,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            tall = true,
            x = 0,
            y = 864
          },
          u_transition_background = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1728
            }),
            line_length = 1,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            tall = true,
            x = 544,
            y = 864
          },
          u_transition_mask = {
            count = 1,
            hr_version = data_util.hr( {
              count = 1,
              line_length = 1,
              picture = "__base__/graphics/terrain/out-of-map-transition/hr-dark-dirt-shore-out-of-map-transition.png",
              scale = 0.5,
              x = 2176,
              y = 1728
            }),
            line_length = 1,
            picture = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
            x = 1088,
            y = 864
          },
          water_patch = nil
        }
      }
end

return {
  cliff_transitions = space_exploration_cliff_transitions,
  cliff_transitions_between_transitions = space_exploration_cliff_transitions_between_transitions,
}
