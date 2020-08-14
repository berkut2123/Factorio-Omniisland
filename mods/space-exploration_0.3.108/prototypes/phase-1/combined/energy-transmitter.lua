local data_util = require("data_util")
--[[
Trunk 10x10, branch connections in middle of each edge.
Branch 8x4, branch connections in middle of each edge. Can have leaves connecting anywhere along the long sides.
Leaf 3x5, Has 1 connection in the middle 1 of the narrow sides. Must connect anywhere along the long side of a branch.

trunk = Maser transmitter -- storage tank?
branch = Maser chamber -- storage tank?
Leaf = Maser injector -- assembling machine

trunk = Maser transmitter -- assembling (anything that can be opened, maybe roboport?)
branch = Maser chamber -- storage tank?
Leaf = Maser injector -- assembling machine, reactor
]]
data:extend({
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "energy-transmitter", -- trunk
    icon = "__space-exploration-graphics__/graphics/icons/energy-transmitter.png",
    icon_size = 64,
    minable = {hardness = 0.2, mining_time = 1, result = data_util.mod_prefix .. "energy-transmitter"},
    order = "z-d-a",
    allow_copy_paste = true,
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/energy-transmitter/sr/energy-transmitter.png",
          priority = "high",
          width = 576/2,
          height = 672/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(0, -24),
          animation_speed = 1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/energy-transmitter/hr/energy-transmitter.png",
            priority = "high",
            width = 576,
            height = 672,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(0, -24),
            animation_speed = 1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/energy-transmitter/sr/energy-transmitter-shadow.png",
          priority = "high",
          width = 354,
          height = 238,
          frame_count = 1,
          line_length = 1,
          repeat_count = 1,
          shift = util.by_pixel(32, 28),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/energy-transmitter/hr/energy-transmitter-shadow.png",
            priority = "high",
            width = 709,
            height = 477,
            frame_count = 1,
            line_length = 1,
            repeat_count = 1,
            shift = util.by_pixel(32, 28),
            scale = 0.5,
          })
        },
      },
    },
    collision_box = {{-4.9, -4.9},{4.9, 4.9}},
    selection_box = {{-4.9, -4.9},{4.9, 4.9}},
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer,
    },
    se_allow_in_space = true,
    corpse = "medium-remnants",
    energy_source = {
      type = "void",
    },
    energy_usage = "0GW",
    flags = {
      "placeable-player",
      "player-creation",
      "hidden",
      "not-rotatable"
    },
    max_health = 5000,
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    crafting_category = "no-category",
    working_sound = {
      apparent_volume = 1.5,
      fade_in_ticks = 10,
      fade_out_ticks = 30,
      max_sounds_per_type = 3,
      sound = {
        {
          filename = "__base__/sound/nuclear-reactor-1.ogg",
          volume = 0.6
        },
        {
          filename = "__base__/sound/nuclear-reactor-2.ogg",
          volume = 0.6
        }
      }
    },
    --light = {intensity = 1, size = 8, shift = {0.0, 0.0}, color = {r = 0.6, g = 0.9, b = 1}}
  },
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "energy-transmitter-branch",
    icon = "__space-exploration-graphics__/graphics/icons/energy-transmitter.png",
    icon_size = 64,
    minable = {hardness = 0.2, mining_time = 1, result = data_util.mod_prefix .. "energy-transmitter"},
    order = "z-d-a",
    allow_copy_paste = true,
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/energy-transmitter/sr/energy-transmitter.png",
          priority = "high",
          width = 576/2,
          height = 672/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(0, -24),
          animation_speed = 1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/energy-transmitter/hr/energy-transmitter.png",
            priority = "high",
            width = 576,
            height = 672,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(0, -24),
            animation_speed = 1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/energy-transmitter/sr/energy-transmitter-shadow.png",
          priority = "high",
          width = 354,
          height = 238,
          frame_count = 1,
          line_length = 1,
          repeat_count = 1,
          shift = util.by_pixel(32, 28),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/energy-transmitter/hr/energy-transmitter-shadow.png",
            priority = "high",
            width = 709,
            height = 477,
            frame_count = 1,
            line_length = 1,
            repeat_count = 1,
            shift = util.by_pixel(32, 28),
            scale = 0.5,
          })
        },
      },
    },
    collision_box = {{-4.4, -4.4},{4.4, 4.4}},
    selection_box = {{-4.4, -4.4},{4.4, 4.4}},
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer,
    },
    se_allow_in_space = true,
    corpse = "medium-remnants",
    energy_source = {
      type = "void",
    },
    energy_usage = "0GW",
    flags = {
      "placeable-player",
      "player-creation",
      "hidden",
      "not-rotatable"
    },
    max_health = 5000,
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    crafting_category = "no-category",
    working_sound = {
      apparent_volume = 1.5,
      fade_in_ticks = 10,
      fade_out_ticks = 30,
      max_sounds_per_type = 3,
      sound = {
        {
          filename = "__base__/sound/nuclear-reactor-1.ogg",
          volume = 0.6
        },
        {
          filename = "__base__/sound/nuclear-reactor-2.ogg",
          volume = 0.6
        }
      }
    },
    --light = {intensity = 1, size = 8, shift = {0.0, 0.0}, color = {r = 0.6, g = 0.9, b = 1}}
  },
  {
    type = "projectile",
    name = data_util.mod_prefix .. "energy-transmitter-fx",
    direction_only = false,
    flags = { "not-on-map", "placeable-off-grid" },
    acceleration = 0,
    collision_mask = {"not-colliding-with-itself"},
    light = {intensity = 1, size = 8, shift = {0.0, 0.0}, color = {r = 0.6, g = 0.9, b = 1}},
    working_sound = {
      apparent_volume = 1.5,
      fade_in_ticks = 10,
      fade_out_ticks = 30,
      max_sounds_per_type = 3,
      sound = {
        {
          filename = "__base__/sound/nuclear-reactor-1.ogg",
          volume = 0.6
        },
        {
          filename = "__base__/sound/nuclear-reactor-2.ogg",
          volume = 0.6
        }
      }
    },
    animation = {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/energy-transmitter/sr/energy-transmitter-light.png",
          priority = "high",
          width = 576/2,
          height = 640/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(0, -32),
          animation_speed = 1,
          apply_runtime_tint = true,
          blend_mode = "additive", --"additive-soft"
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/energy-transmitter/hr/energy-transmitter-light.png",
            priority = "high",
            width = 576,
            height = 640,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(0, -32),
            animation_speed = 1,
            scale = 0.5,
            apply_runtime_tint = true,
            blend_mode = "additive", --"additive-soft"
          })
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/energy-transmitter/sr/energy-transmitter-skybeam.png",
          priority = "high",
          width = 38,
          height = 298,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(0, -19 * 32 -2),
          animation_speed = 1,
          scale = 4,
          apply_runtime_tint = true,
          blend_mode = "additive-soft",
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/energy-transmitter/hr/energy-transmitter-skybeam.png",
            priority = "high",
            width = 77,
            height = 597,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(0, -19 * 32 -2),
            animation_speed = 1,
            scale = 2,
            apply_runtime_tint = true,
            blend_mode = "additive-soft",
          })
        },
      }
    },
  },

})
