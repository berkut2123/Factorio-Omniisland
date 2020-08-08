local data_util = require("data_util")

data:extend({
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-electromagnetics-laboratory",
    icon = "__space-exploration-graphics__/graphics/icons/electromagnetics-laboratory.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-electromagnetics-laboratory"},
    max_health = 700,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-3.2, -3.2}, {3.2, 3.2}},
    selection_box = {{-3.5, -3.5}, {3.5, 3.5}},
    drawing_box = {{-3.5, -3.7}, {3.5, 3.5}},
    resistances =
    {
      {
        type = "electric",
        percent = 70
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -4} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-4, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 4} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {4, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      --off_when_no_fluid_recipe = true
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/lab.ogg",
          volume = 0.8
        },
      },
      apparent_volume = 1.5,
    },
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer,
    },
    idle_animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/electromagnetics-laboratory/sr/base.png",
          priority = "high",
          width = 448/2,
          height = 576/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 64,
          shift = util.by_pixel(0, -16),
          animation_speed = 1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/electromagnetics-laboratory/hr/base.png",
            priority = "high",
            width = 448,
            height = 576,
            frame_count = 1,
            line_length = 1,
            repeat_count = 64,
            shift = util.by_pixel(0, -16),
            animation_speed = 1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/electromagnetics-laboratory/sr/shadow.png",
          priority = "high",
          width = 566/2,
          height = 400/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 64,
          shift = util.by_pixel(35, 20),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/electromagnetics-laboratory/hr/shadow.png",
            priority = "high",
            width = 566,
            height = 400,
            frame_count = 1,
            line_length = 1,
            repeat_count = 64,
            shift = util.by_pixel(35, 20),
            scale = 0.5,
          })
        },
      },
    },
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/electromagnetics-laboratory/sr/base.png",
          priority = "high",
          width = 448/2,
          height = 576/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 64,
          shift = util.by_pixel(0, -16),
          animation_speed = 1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/electromagnetics-laboratory/hr/base.png",
            priority = "high",
            width = 448,
            height = 576,
            frame_count = 1,
            line_length = 1,
            repeat_count = 64,
            shift = util.by_pixel(0, -16),
            animation_speed = 1,
            scale = 0.5,
          })
        },
        {
          priority = "high",
          width = 1392/4/2,
          height = 1880/5/2,
          frame_count = 64,
          shift = util.by_pixel(1, -17),
          animation_speed = 0.25,
          stripes =
          {
            {
             filename = "__space-exploration-graphics__/graphics/entity/electromagnetics-laboratory/sr/animation-1.png",
             width_in_frames = 4,
             height_in_frames = 5,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/electromagnetics-laboratory/sr/animation-2.png",
             width_in_frames = 4,
             height_in_frames = 5,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/electromagnetics-laboratory/sr/animation-3.png",
             width_in_frames = 4,
             height_in_frames = 5,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/electromagnetics-laboratory/sr/animation-4.png",
             width_in_frames = 4,
             height_in_frames = 1,
            },
          },
          hr_version = data_util.hr({
            priority = "high",
            width = 1392/4,
            height = 1880/5,
            frame_count = 64,
            shift = util.by_pixel(1, -17),
            animation_speed = 0.25,
            scale = 0.5,
            stripes =
            {
              {
               filename = "__space-exploration-hr-graphics__/graphics/entity/electromagnetics-laboratory/hr/animation-1.png",
               width_in_frames = 4,
               height_in_frames = 5,
              },
              {
               filename = "__space-exploration-hr-graphics__/graphics/entity/electromagnetics-laboratory/hr/animation-2.png",
               width_in_frames = 4,
               height_in_frames = 5,
              },
              {
               filename = "__space-exploration-hr-graphics__/graphics/entity/electromagnetics-laboratory/hr/animation-3.png",
               width_in_frames = 4,
               height_in_frames = 5,
              },
              {
               filename = "__space-exploration-hr-graphics__/graphics/entity/electromagnetics-laboratory/hr/animation-4.png",
               width_in_frames = 4,
               height_in_frames = 1,
              },
            },
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/electromagnetics-laboratory/sr/shadow.png",
          priority = "high",
          width = 566/2,
          height = 400/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 64,
          shift = util.by_pixel(35, 20),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/electromagnetics-laboratory/hr/shadow.png",
            priority = "high",
            width = 566,
            height = 400,
            frame_count = 1,
            line_length = 1,
            repeat_count = 64,
            shift = util.by_pixel(35, 20),
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-electromagnetics"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
    },
    energy_usage = "2000kW",
    ingredient_count = 12,
    module_specification =
    {
      module_slots = 4
    },
    allowed_effects = {"consumption", "speed",  "pollution"}, -- not "productivity",
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.6, size = 16, shift = {0.0, 0.0}, color = {r = 0.3, g = 0.5, b = 1}}
      },
    },
  },
})
