local data_util = require("data_util")

data:extend({
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-particle-accelerator",
    icon = "__space-exploration-graphics__/graphics/icons/particle-accelerator.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-particle-accelerator"},
    max_health = 1500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-4.3, -4.3}, {4.3, 4.3}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    drawing_box = {{-4.5, -4.9}, {4.5, 4.5}},
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
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      --off_when_no_fluid_recipe = true
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
          filename = "__base__/sound/electric-furnace.ogg",
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
    },
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/particle-accelerator/sr/particle-accelerator.png",
          priority = "high",
          width = 3540/6/2,
          height = 4032/6/2,
          frame_count = 32,
          line_length = 6,
          shift = util.by_pixel(0, -24),
          animation_speed = 1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/particle-accelerator/hr/particle-accelerator.png",
            priority = "high",
            width = 3540/6,
            height = 4032/6,
            frame_count = 32,
            line_length = 6,
            shift = util.by_pixel(0, -24),
            animation_speed = 1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/particle-accelerator/sr/particle-accelerator-shadow.png",
          priority = "high",
          width = 692/2,
          height = 526/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 32,
          shift = util.by_pixel(32, 16),
          animation_speed = 1,
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/particle-accelerator/hr/particle-accelerator-shadow.png",
            priority = "high",
            width = 692,
            height = 526,
            frame_count = 1,
            line_length = 1,
            repeat_count = 32,
            shift = util.by_pixel(32, 16),
            animation_speed = 1,
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-accelerator"},
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
        light = {intensity = 0.8, size = 32, shift = {0.0, 0.0}, color = {r = 0.1, g = 0.5, b = 1}}
      },
    },
  },
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-particle-collider",
    icon = "__space-exploration-graphics__/graphics/icons/particle-collider.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-particle-collider"},
    max_health = 1500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-4.3, -4.3}, {4.3, 4.3}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    drawing_box = {{-4.5, -4.9}, {4.5, 4.5}},
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
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      --off_when_no_fluid_recipe = true
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
          filename = "__base__/sound/electric-furnace.ogg",
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
          filename = "__space-exploration-graphics__/graphics/entity/particle-collider/sr/particle-collider.png",
          priority = "high",
          width = 3540/6/2,
          height = 4032/6/2,
          frame_count = 32,
          line_length = 6,
          shift = util.by_pixel(0, -24),
          animation_speed = 1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/particle-collider/hr/particle-collider.png",
            priority = "high",
            width = 3540/6,
            height = 4032/6,
            frame_count = 32,
            line_length = 6,
            shift = util.by_pixel(0, -24),
            animation_speed = 1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/particle-collider/sr/particle-collider-shadow.png",
          priority = "high",
          width = 692/2,
          height = 526/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 32,
          shift = util.by_pixel(32, 16),
          animation_speed = 1,
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/particle-collider/hr/particle-collider-shadow.png",
            priority = "high",
            width = 692,
            height = 526,
            frame_count = 1,
            line_length = 1,
            repeat_count = 32,
            shift = util.by_pixel(32, 16),
            animation_speed = 1,
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-collider"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
    },
    energy_usage = "5000kW",
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
        light = {intensity = 0.8, size = 32, shift = {0.0, 0.0}, color = {r = 1, g = 0.1, b = 0.5}}
      },
    },
  },
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-material-fabricator",
    icon = "__space-exploration-graphics__/graphics/icons/material-fabricator.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-material-fabricator"},
    max_health = 1500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-4.3, -4.3}, {4.3, 4.3}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    drawing_box = {{-4.5, -4.9}, {4.5, 4.5}},
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
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      --off_when_no_fluid_recipe = true
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
          filename = "__base__/sound/electric-furnace.ogg",
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
          filename = "__space-exploration-graphics__/graphics/entity/material-fabricator/sr/material-fabricator.png",
          priority = "high",
          width = 3540/6/2,
          height = 4032/6/2,
          frame_count = 32,
          line_length = 6,
          shift = util.by_pixel(0, -24),
          animation_speed = 1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/material-fabricator/hr/material-fabricator.png",
            priority = "high",
            width = 3540/6,
            height = 4032/6,
            frame_count = 32,
            line_length = 6,
            shift = util.by_pixel(0, -24),
            animation_speed = 1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/material-fabricator/sr/material-fabricator-shadow.png",
          priority = "high",
          width = 692/2,
          height = 526/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 32,
          shift = util.by_pixel(32, 16),
          animation_speed = 1,
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/material-fabricator/hr/material-fabricator-shadow.png",
            priority = "high",
            width = 692,
            height = 526,
            frame_count = 1,
            line_length = 1,
            repeat_count = 32,
            shift = util.by_pixel(32, 16),
            animation_speed = 1,
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-materialisation"},
    crafting_speed = 4,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
    },
    energy_usage = "250MW",
    ingredient_count = 12,
    module_specification =
    {
      module_slots = 0
    },
    allowed_effects = {"pollution"}, -- not "speed",  "consumption", "productivity",
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.8, size = 32, shift = {0.0, 0.0}, color = {r = 1, g = 1, b = 0.2}}
      },
    },
  },
})
