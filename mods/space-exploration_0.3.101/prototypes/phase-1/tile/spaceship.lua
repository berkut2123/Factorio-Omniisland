local data_util = require("data_util")
data:extend(
{
  {
    type = "tile",
    name = data_util.mod_prefix .. "spaceship-floor",
    needs_correction = false,
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "spaceship-floor"},
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    collision_mask = {
      space_collision_layer,
      spaceship_collision_layer,
      "resource-layer"
    },
    walking_speed_modifier = 1.5,
    layer = 208,
    decorative_removal_probability = 1,
    variants =
    {
      main =
      {
        {
          picture = "__space-exploration-graphics__/graphics/terrain/spaceship-floor/tile1.png",
          count = 12,
          size = 1,
          hr_version = data_util.hr(
          {
            picture = "__space-exploration-hr-graphics__/graphics/terrain/spaceship-floor/hr-tile1.png",
            size = 1,
            scale = 0.5
          })
        }
      },
      inner_corner =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/spaceship-floor/tile-inner-corner.png",
        count = 1,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/spaceship-floor/hr-tile-inner-corner.png",
          scale = 0.5
        })
      },
      outer_corner =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/spaceship-floor/tile-outer-corner.png",
        count = 1,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/spaceship-floor/hr-tile-outer-corner.png",
          scale = 0.5
        })
      },
      side =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/spaceship-floor/tile-side.png",
        count = 16,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/spaceship-floor/hr-tile-side.png",
          scale = 0.5
        })
      },
      u_transition =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/spaceship-floor/tile-u.png",
        count = 1,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/spaceship-floor/hr-tile-u.png",
          scale = 0.5
        })
      },
      o_transition =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/spaceship-floor/tile-o.png",
        count = 1,
        hr_version = data_util.hr(
        {
          picture = "__space-exploration-hr-graphics__/graphics/terrain/spaceship-floor/hr-tile-o.png",
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
    vehicle_friction_modifier = 100
  },
})
