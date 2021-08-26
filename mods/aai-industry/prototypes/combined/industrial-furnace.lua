local data_util = require("data-util")

local function pipepictures()
  return {
    east = data_util.auto_sr_hr({
      filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-pipe-h.png",
      width = 128,
      height = 128,
      shift = {-1,0}
    }),
    north = data_util.auto_sr_hr({
      filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-pipe-n.png",
      width = 128,
      height = 128,
      shift = util.by_pixel(0, 24),
    }),
    south = data_util.auto_sr_hr({
      filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-pipe-s.png",
      width = 64,
      height = 32,
      shift = util.by_pixel(0, -24),
    }),
    west = data_util.auto_sr_hr({
      filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-pipe-h.png",
      width = 128,
      height = 128,
      shift = {1,0}
    }),
  }
end
data:extend({
  {
    type = "item",
    name = "industrial-furnace",
    icon = "__aai-industry__/graphics/icons/industrial-furnace.png",
    icon_size = 64,
    subgroup = "smelting-machine",
    order = "c[electric-furnace]-b",
    stack_size = 20,
    place_result = "industrial-furnace",
  },
  {
    type = "recipe",
    name = "industrial-furnace",
    category = "crafting",
    normal = {
      enabled = false,
      energy_required = 7,
      ingredients = {
        {type="item", name="steel-plate", amount=16},
        {type="item", name="concrete", amount=8},
        {type="item", name="processing-unit", amount=4},
        {type="item", name="electric-furnace", amount=1},
      },
      results= { {type="item", name="industrial-furnace", amount=1} },
    },
    expensive = {
      enabled = false,
      energy_required = 7,
      ingredients = {
        {type="item", name="steel-plate", amount=24},
        {type="item", name="concrete", amount=16},
        {type="item", name="processing-unit", amount=8},
        {type="item", name="electric-furnace", amount=1},
      },
      results= { {type="item", name="industrial-furnace", amount=1} },
    }
  },
  {
    type = "technology",
    name = "industrial-furnace",
    icon = "__aai-industry__/graphics/technology/industrial-furnace.png",
    icon_size = 256,
    order = "a",
    prerequisites = {
      "production-science-pack",
      "advanced-electronics-2",
    },
    unit = {
        count = 200,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
        },
        time = 30
    },
    effects = {
      { type = "unlock-recipe", recipe = "industrial-furnace" }
    },
  },
  {
    type = "assembling-machine",
    name = "industrial-furnace",
    icon = "__aai-industry__/graphics/icons/industrial-furnace.png",
    icon_size = 64,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.3, result = "industrial-furnace"},
    max_health = 1200,
    corpse = "big-remnants",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -2.9}, {2.5, 2.5}},
    resistances =
    {
      { type = "impact", percent = 30 },
      { type = "fire", percent = 30 },
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound = {
      idle_sound = {
        filename = "__base__/sound/idle1.ogg",
        volume = 0.6
      },
      apparent_volume = 1.5,
      fade_in_ticks = 10,
      fade_out_ticks = 60,
      max_sounds_per_type = 2,
      sound = {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.7
      }
    },
    animation =
    {
      layers =
      {
        {
          filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace.png",
          priority = "high",
          width = 350/2,
          height = 370/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(0, -5),
          animation_speed = 0.75,
          hr_version = {
            filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace.png",
            priority = "high",
            width = 350,
            height = 370,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(0, -5),
            animation_speed = 0.75,
            scale = 0.5,
          }
        },
        {
          draw_as_shadow = true,
          filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-shadow.png",
          priority = "high",
          width = 370/2,
          height = 268/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(40, 21),
          animation_speed = 0.75,
          hr_version = {
            draw_as_shadow = true,
            filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-shadow.png",
            priority = "high",
            width = 370,
            height = 268,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(40, 21),
            animation_speed = 0.75,
            scale = 0.5,
          }
        },
      },
    },
    crafting_categories = {
      "smelting",
      --"chemistry" -- only to test fluid connections
    },
    crafting_speed = 4,
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
      offsets = { { 0, 1 } },
      type = "create-entity"
    },
    dying_explosion = "electric-furnace-explosion",
    energy_source = {
      emissions_per_minute = 1.5,
      type = "electric",
      usage_priority = "secondary-input",
      light_flicker =
      {
        minimum_light_size = 5,
        color = {1,0.3,0},
        minimum_intensity = 0.6,
        maximum_intensity = 0.95
      },
    },
    energy_usage = "500kW",
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-1, -3} }},
        secondary_draw_orders = { north = -1, east = -1, west = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {1, -3} }},
        secondary_draw_orders = { north = -1, east = -1, west = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-3, -1} }},
        secondary_draw_orders = { north = -1, east = -1, west = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {3, -1} }},
        secondary_draw_orders = { north = -1, east = -1, west = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {-1, 3} }},
        secondary_draw_orders = { north = -1, east = -1, west = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {1, 3} }},
        secondary_draw_orders = { north = -1, east = -1, west = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {3, 1} }},
        secondary_draw_orders = { north = -1, east = -1, west = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {-3, 1} }}, -- west south
        secondary_draw_orders = { north = -1, east = -1, west = -1 }
      },
      off_when_no_fluid_recipe = true
    },
    ingredient_count = 12,
    module_specification =
    {
      module_slots = 5
    },
    allowed_effects = {"consumption", "speed",  "pollution", "productivity"}, -- not "productivity",
    working_visualisations =
    {
      {
        animation = {
          layers = { -- these are not lights, they need to cover the static propeller
            {
              animation_speed = 0.5,
              filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-propeller.png",
              frame_count = 4,
              height = 13,
              hr_version = {
                animation_speed = 0.5,
                filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-propeller.png",
                frame_count = 4,
                height = 25,
                priority = "high",
                scale = 0.5,
                shift = util.by_pixel(-1, -64-11),
                width = 38
              },
              priority = "high",
              shift = util.by_pixel(-1, -64-11),
              width = 19
            },
            {
              animation_speed = 0.5,
              filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-propeller.png",
              frame_count = 4,
              height = 13,
              hr_version = {
                animation_speed = 0.5,
                filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-propeller.png",
                frame_count = 4,
                height = 25,
                priority = "high",
                scale = 0.5,
                shift = util.by_pixel(-0.5, -32-8),
                width = 37
              },
              priority = "high",
              shift = util.by_pixel(-0.5, -32-8),
              width = 19
            },
            {
              animation_speed = 0.5,
              filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-propeller.png",
              frame_count = 4,
              height = 13,
              hr_version = {
                animation_speed = 0.5,
                filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-propeller.png",
                frame_count = 4,
                height = 25,
                priority = "high",
                scale = 0.5,
                shift = util.by_pixel(0, -6),
                width = 37
              },
              priority = "high",
              shift = util.by_pixel(0, -6),
              width = 19
            },
          }
        }
      },
      {
        draw_as_light = true,
        fadeout = true,
        animation = {
          layers = {
            {
              animation_speed = 0.5,
              filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-heater.png",
              frame_count = 12,
              height = 56/2,
              hr_version = {
                animation_speed = 0.5,
                filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-heater.png",
                frame_count = 12,
                height = 56,
                priority = "high",
                scale = 0.5,
                shift = util.by_pixel(0, 65),
                width = 60
              },
              priority = "high",
              shift = util.by_pixel(0, 65),
              width = 60/2
            },
          }
        }
      },
      {
        draw_as_light = true,
        fadeout = true,
        animation = {
          layers = {
            {
              filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-light.png",
              priority = "high",
              width = 350/2,
              height = 370/2,
              frame_count = 1,
              line_length = 1,
              shift = util.by_pixel(0, -5),
              animation_speed = 0.75,
              blend_mode = "additive",
              hr_version = {
                filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-light.png",
                priority = "high",
                width = 350,
                height = 370,
                frame_count = 1,
                line_length = 1,
                shift = util.by_pixel(0, -5),
                animation_speed = 0.75,
                scale = 0.5,
                blend_mode = "additive",
              }
            },
            {
              animation_speed = 0.5,
              filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-vents.png",
              frame_count = 1,
              width = 46/2,
              height = 66/2,
              hr_version = {
                animation_speed = 0.5,
                filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-vents.png",
                frame_count = 1,
                width = 46,
                height = 66,
                priority = "high",
                scale = 0.5,
                shift = util.by_pixel(-32-16-5, -32-16+4),
                blend_mode = "additive",
              },
              priority = "high",
              shift = util.by_pixel(-32-16-5, -32-16+4),
              blend_mode = "additive",
            },
          }
        }
      },
      {
        draw_as_light = true,
        fadeout = true,
        animation = {
          layers = {
            {
              animation_speed = 0.5,
              filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-propeller.png",
              frame_count = 4,
              height = 13,
              hr_version = {
                animation_speed = 0.5,
                filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-propeller.png",
                frame_count = 4,
                height = 25,
                priority = "high",
                scale = 0.5,
                shift = util.by_pixel(-1, -64-11),
                width = 38
              },
              priority = "high",
              shift = util.by_pixel(-1, -64-11),
              width = 19
            },
            {
              animation_speed = 0.5,
              filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-propeller.png",
              frame_count = 4,
              height = 13,
              hr_version = {
                animation_speed = 0.5,
                filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-propeller.png",
                frame_count = 4,
                height = 25,
                priority = "high",
                scale = 0.5,
                shift = util.by_pixel(-0.5, -32-8),
                width = 37
              },
              priority = "high",
              shift = util.by_pixel(-0.5, -32-8),
              width = 19
            },
            {
              animation_speed = 0.5,
              filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-propeller.png",
              frame_count = 4,
              height = 13,
              hr_version = {
                animation_speed = 0.5,
                filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-propeller.png",
                frame_count = 4,
                height = 25,
                priority = "high",
                scale = 0.5,
                shift = util.by_pixel(0, -6),
                width = 37
              },
              priority = "high",
              shift = util.by_pixel(0, -6),
              width = 19
            },
          }
        }
      },
      {
        draw_as_light = true,
        draw_as_sprite = false,
        fadeout = true,
        animation =
        {
          filename = "__aai-industry__/graphics/entity/industrial-furnace/sr/industrial-furnace-ground-light.png",
          blend_mode = "additive",
          width = 166/2,
          height = 124/2,
          shift = util.by_pixel(3, 69+32),
          hr_version =
          {
            filename = "__aai-industry__/graphics/entity/industrial-furnace/hr/industrial-furnace-ground-light.png",
            blend_mode = "additive",
            width = 166,
            height = 124,
            shift = util.by_pixel(3, 69+32),
            scale = 0.5,
          }
        },
      },
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.1, size = 18, shift = {0.0, 1}, color = {r = 1, g = 0.4, b = 0.1}}
      },
    },
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 24,
        shift = util.by_pixel(5, 40),
        variation_count = 1,
        scale = 7
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
})
