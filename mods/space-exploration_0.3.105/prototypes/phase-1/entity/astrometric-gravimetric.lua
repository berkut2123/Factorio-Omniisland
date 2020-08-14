local data_util = require("data_util")

local pipe_pictures = {
  north = blank_image,
  east = {
    filename = "__space-exploration-graphics__/graphics/entity/astrometrics-laboratory/sr/pipe-right.png",
    width = 10/2,
    height = 60/2,
    priority = "extra-high",
    shift = util.by_pixel(-18, 1),
    hr_version = data_util.hr({
      filename = "__space-exploration-hr-graphics__/graphics/entity/astrometrics-laboratory/hr/pipe-right.png",
      width = 10,
      height = 60,
      priority = "extra-high",
      shift = util.by_pixel(-18, 1),
      scale = 0.5,
    }),
  },
  north = {
    filename = "__space-exploration-graphics__/graphics/entity/astrometrics-laboratory/sr/pipe-top.png",
    width = 128/2,
    height = 128/2,
    priority = "extra-high",
    shift = util.by_pixel(0, 22),
    hr_version = data_util.hr({
      filename = "__space-exploration-hr-graphics__/graphics/entity/astrometrics-laboratory/hr/pipe-top.png",
      width = 128,
      height = 128,
      priority = "extra-high",
      shift = util.by_pixel(0, 22),
      scale = 0.5,
    }),
  },
  south = {
    filename = "__space-exploration-graphics__/graphics/entity/astrometrics-laboratory/sr/pipe-bottom.png",
    width = 70/2,
    height = 44/2,
    priority = "extra-high",
    shift = util.by_pixel(3, -27),
    hr_version = data_util.hr({
      filename = "__space-exploration-hr-graphics__/graphics/entity/astrometrics-laboratory/hr/pipe-bottom.png",
      width = 70,
      height = 44,
      priority = "extra-high",
      shift = util.by_pixel(3, -27),
      scale = 0.5,
    }),
  },
  west = {
    filename = "__space-exploration-graphics__/graphics/entity/astrometrics-laboratory/sr/pipe-left.png",
    width = 10/2,
    height = 64/2,
    priority = "extra-high",
    shift = util.by_pixel(18, 2),
    hr_version = data_util.hr({
      filename = "__space-exploration-hr-graphics__/graphics/entity/astrometrics-laboratory/hr/pipe-left.png",
      width = 10,
      height = 64,
      priority = "extra-high",
      shift = util.by_pixel(18, 2),
      scale = 0.5,
    }),
  }
}

data:extend({
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-astrometrics-laboratory",
    icon = "__space-exploration-graphics__/graphics/icons/astrometrics-laboratory.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 1, result = data_util.mod_prefix .. "space-astrometrics-laboratory"},
    max_health = 700,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -2.9}, {2.5, 2.5}},
    resistances =
    {
      {
        type = "impact",
        percent = 10
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = pipe_pictures,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -3} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipe_pictures,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 3} }},
        secondary_draw_orders = { north = -1 }
      },
      off_when_no_fluid_recipe = true
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound = {
      apparent_volume = 1.5,
      idle_sound = {
        filename = "__base__/sound/idle1.ogg",
        volume = 0.6
      },
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t1-2.ogg",
          volume = 0.8
        }
      }
    },
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer,
    },
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/astrometrics-laboratory/sr/astrometrics-laboratory.png",
          priority = "high",
          width = 2752/8/2,
          height = 3120/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(0, -11),
          animation_speed = 1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/astrometrics-laboratory/hr/astrometrics-laboratory.png",
            priority = "high",
            width = 2752/8,
            height = 3120/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(0, -11),
            animation_speed = 1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/astrometrics-laboratory/sr/astrometrics-laboratory-shadow.png",
          priority = "high",
          width = 330/2,
          height = 220/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 64,
          shift = util.by_pixel(26, 24),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/astrometrics-laboratory/hr/astrometrics-laboratory-shadow.png",
            priority = "high",
            width = 330,
            height = 220,
            frame_count = 1,
            line_length = 1,
            repeat_count = 64,
            shift = util.by_pixel(26, 24),
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-astrometrics"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
    },
    energy_usage = "1000kW",
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
        light = {intensity = 0.5, size = 8, shift = {0.0, 0.0}, color = {r = 1, g = 0.9, b = 0.5}}
      },
    },
  },
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-gravimetrics-laboratory",
    icon = "__space-exploration-graphics__/graphics/icons/gravimetrics-laboratory.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 1, result = data_util.mod_prefix .. "space-gravimetrics-laboratory"},
    max_health = 700,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -2.9}, {2.5, 2.5}},
    resistances =
    {
      {
        type = "impact",
        percent = 10
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = pipe_pictures,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -3} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipe_pictures,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 3} }},
        secondary_draw_orders = { north = -1 }
      },
      off_when_no_fluid_recipe = true
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound = {
      apparent_volume = 1.5,
      idle_sound = {
        filename = "__base__/sound/idle1.ogg",
        volume = 0.6
      },
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t1-2.ogg",
          volume = 0.8
        }
      }
    },
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer,
    },
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/gravimetrics-laboratory/sr/gravimetrics-laboratory.png",
          priority = "high",
          width = 2752/8/2,
          height = 3120/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(0, -11),
          animation_speed = 1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/gravimetrics-laboratory/hr/gravimetrics-laboratory.png",
            priority = "high",
            width = 2752/8,
            height = 3120/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(0, -11),
            animation_speed = 1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/gravimetrics-laboratory/sr/gravimetrics-laboratory-shadow.png",
          priority = "high",
          width = 330/2,
          height = 220/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 64,
          shift = util.by_pixel(26, 24),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/gravimetrics-laboratory/hr/gravimetrics-laboratory-shadow.png",
            priority = "high",
            width = 330,
            height = 220,
            frame_count = 1,
            line_length = 1,
            repeat_count = 64,
            shift = util.by_pixel(26, 24),
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-gravimetrics"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
    },
    energy_usage = "1000kW",
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
        light = {intensity = 0.5, size = 8, shift = {0.0, 0.0}, color = {r = 100/255, g = 48/255, b = 1}}
      },
    },
  },
})
