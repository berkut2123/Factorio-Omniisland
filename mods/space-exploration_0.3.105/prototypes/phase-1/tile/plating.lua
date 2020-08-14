local data_util = require("data_util")
data:extend(
{
  {
    type = "tile",
    name = data_util.mod_prefix .. "space-platform-plating",
    needs_correction = false,
    minable = { mining_time = 0.2, result = data_util.mod_prefix .. "space-platform-plating"},
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    collision_mask = {
      space_collision_layer,
      --"resource-layer"
    },
    walking_speed_modifier = 1.5,
    layer = 208,
    decorative_removal_probability = 1,
    variants =
    {
      main =
      {
        {
          picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile1.png",
          count = 12,
          size = 1,
          hr_version = data_util.hr(
          {
            picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile1.png",
            size = 1,
            scale = 0.5
          })
        }
      },
      inner_corner =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-inner-corner.png",
        count = 1,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-inner-corner.png",
          scale = 0.5
        })
      },
      outer_corner =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-outer-corner.png",
        count = 1,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-outer-corner.png",
          scale = 0.5
        })
      },
      side =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-side.png",
        count = 16,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-side.png",
          scale = 0.5
        })
      },
      u_transition =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-u.png",
        count = 1,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-u.png",
          scale = 0.5
        })
      },
      o_transition =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-o.png",
        count = 1,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-o.png",
          scale = 0.5
        })
      }
    },
    walking_sound =
    {
      {
        filename = "__base__/sound/walking/concrete-01.ogg",
        volume = 1.2
      },
      {
        filename = "__base__/sound/walking/concrete-02.ogg",
        volume = 1.2
      },
      {
        filename = "__base__/sound/walking/concrete-03.ogg",
        volume = 1.2
      },
      {
        filename = "__base__/sound/walking/concrete-04.ogg",
        volume = 1.2
      }
    },
    map_color={r=100, g=100, b=100},
    ageing=0,
    vehicle_friction_modifier = 100,
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
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 0
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = true,
            x = 0,
            y = 0
          },
          inner_corner_background = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 0
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = true,
            x = 544,
            y = 0
          },
          inner_corner_mask = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              x = 2176,
              y = 0
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            x = 1088,
            y = 0
          },
          o_transition = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = false,
              x = 0,
              y = 2304
            }),
            line_length = 4,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = false,
            x = 0,
            y = 1152
          },
          o_transition_background = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = false,
              x = 1088,
              y = 2304
            }),
            line_length = 4,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = false,
            x = 544,
            y = 1152
          },
          o_transition_mask = {
            count = 4,
            hr_version = data_util.hr( {
              count = 4,
              line_length = 4,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              x = 2176,
              y = 2304
            }),
            line_length = 4,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            x = 1088,
            y = 1152
          },
          outer_corner = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 576
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = true,
            x = 0,
            y = 288
          },
          outer_corner_background = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 576
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = true,
            x = 544,
            y = 288
          },
          outer_corner_mask = {
            count = 8,
            hr_version = data_util.hr( {
              count = 8,
              line_length = 8,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              x = 2176,
              y = 576
            }),
            line_length = 8,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            x = 1088,
            y = 288
          },
          side = {
            count = 16,
            hr_version = data_util.hr( {
              count = 16,
              line_length = 16,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1152
            }),
            line_length = 16,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = true,
            x = 0,
            y = 576
          },
          side_background = {
            count = 16,
            hr_version = data_util.hr( {
              count = 16,
              line_length = 16,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1152
            }),
            line_length = 16,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = true,
            x = 544,
            y = 576
          },
          side_mask = {
            count = 16,
            hr_version = data_util.hr( {
              count = 16,
              line_length = 16,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              x = 2176,
              y = 1152
            }),
            line_length = 16,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            x = 1088,
            y = 576
          },
          u_transition = {
            count = 2,
            hr_version = data_util.hr( {
              count = 2,
              line_length = 2,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = true,
              x = 0,
              y = 1728
            }),
            line_length = 2,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = true,
            x = 0,
            y = 864
          },
          u_transition_background = {
            count = 2,
            hr_version = data_util.hr( {
              count = 2,
              line_length = 2,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              tall = true,
              x = 1088,
              y = 1728
            }),
            line_length = 2,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            tall = true,
            x = 544,
            y = 864
          },
          u_transition_mask = {
            count = 2,
            hr_version = data_util.hr( {
              count = 2,
              line_length = 2,
              picture = "__space-exploration-hr-graphics__/graphics/terrain/space-platform-plating/hr-tile-transitions.png",
              scale = 0.5,
              x = 2176,
              y = 1728
            }),
            line_length = 2,
            picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-transitions.png",
            x = 1088,
            y = 864
          }
        },
      }
  },
})
