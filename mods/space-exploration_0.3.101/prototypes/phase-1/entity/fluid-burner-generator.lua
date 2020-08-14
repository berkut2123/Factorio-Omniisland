local data_util = require("data_util")

data:extend({
  {
    type = "generator",
    name = data_util.mod_prefix .. "fluid-burner-generator",
    icon = "__space-exploration-graphics__/graphics/icons/fluid-burner-generator.png",
    icon_size = 64,
    flags = {"placeable-neutral","player-creation"},
    minable = {mining_time = 0.3, result = data_util.mod_prefix .. "fluid-burner-generator"},
    max_health = 300,
    corpse = "steam-turbine-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    effectivity = 1,
    fluid_usage_per_tick = 1,
    burns_fluid = true,
    resistances = { { type = "fire", percent = 70 } },
    fast_replaceable_group = "steam-engine",
    collision_box = {{-1.35, -2.35}, {1.35, 2.35}},
    selection_box = {{-1.5, -2.5}, {1.5, 2.5}},
    scale_fluid_usage = true,
    max_power_output = "2MW",
    maximum_temperature = 1000,
    fluid_box =
    {
      base_area = 1,
      height = 2,
      base_level = -1,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { type = "input-output", position = {0, 3} },
        { type = "input-output", position = {0, -3} }
      },
      production_type = "input-output",
    },
    effectivity = 0.75,
    energy_source = { type = "electric", usage_priority = "secondary-output" },
    horizontal_animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/fluid-burner-generator/fluid-burner-generator-h.png",
          width = 320/2,
          height = 244/2,
          frame_count = 8,
          line_length = 4,
          shift = util.by_pixel(0, -2.75),
          animation_speed = 0.5,
          hr_version =
          data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/fluid-burner-generator/hr-fluid-burner-generator-h.png",
            width = 320,
            height = 244,
            frame_count = 8,
            line_length = 4,
            shift = util.by_pixel(0, -2.75),
            animation_speed = 0.5,
            scale = 0.5
          })
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/fluid-burner-generator/fluid-burner-generator-h-shadow.png",
          width = 434/2,
          height = 150/2,
          frame_count = 1,
          repeat_count = 8,
          line_length = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(28.5, 18),
          animation_speed = 0.5,
          hr_version =
          data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/fluid-burner-generator/hr-fluid-burner-generator-h-shadow.png",
            width = 434,
            height = 150,
            frame_count = 1,
            repeat_count = 8,
            line_length = 1,
            draw_as_shadow = true,
            shift = util.by_pixel(28.5, 18),
            animation_speed = 0.5,
            scale = 0.5
          })
        }
      }
    },
    vertical_animation =
    {
     layers =
     {
        {
          filename = "__space-exploration-graphics__/graphics/entity/fluid-burner-generator/fluid-burner-generator-v.png",
          width = 864/4/2,
          height = 692/2/2,
          frame_count = 8,
          line_length = 4,
          shift = util.by_pixel(5, 6.5),
          animation_speed = 0.5,
          hr_version =
          data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/fluid-burner-generator/hr-fluid-burner-generator-v.png",
            width = 864/4,
            height = 692/2,
            frame_count = 8,
            line_length = 4,
            shift = util.by_pixel(4.75, 6.75),
            animation_speed = 0.5,
            scale = 0.5
          })
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/fluid-burner-generator/fluid-burner-generator-v-shadow.png",
          width = 256/2,
          height = 260/2,
          frame_count = 1,
          repeat_count = 8,
          line_length = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(9.5, 14.5),
          animation_speed = 0.5,
          hr_version =
          data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/fluid-burner-generator/hr-fluid-burner-generator-v-shadow.png",
            width = 256,
            height = 260,
            frame_count = 1,
            repeat_count = 8,
            line_length = 1,
            draw_as_shadow = true,
            shift = util.by_pixel(9.5, 14.5),
            animation_speed = 0.5,
            scale = 0.5
          })
        }
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/steam-engine-90bpm.ogg",
        volume = 0.6
      },
      match_speed_to_activity = true
    },
    min_perceived_performance = 0.25,
    performance_to_sound_speedup = 0.5
  },
})
