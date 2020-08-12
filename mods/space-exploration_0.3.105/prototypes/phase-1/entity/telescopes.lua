local data_util = require("data_util")

data:extend({
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-telescope",
    icon = "__space-exploration-graphics__/graphics/icons/telescope.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = data_util.mod_prefix .. "space-telescope"},
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    drawing_box = {{-1.5, -1.9}, {1.5, 1.5}},
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
        pipe_connections = {{ type="input", position = {0, -2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 2} }},
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
          filename = "__space-exploration-graphics__/graphics/entity/telescope/sr/telescope.png",
          priority = "high",
          width = 2080/8/2,
          height = 2128/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(6, -19),
          animation_speed = 0.1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope/hr/telescope.png",
            priority = "high",
            width = 2080/8,
            height = 2128/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(6, -19),
            animation_speed = 0.1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/telescope/sr/telescope-shadow.png",
          priority = "high",
          width = 2608/8/2,
          height = 1552/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(32, 7),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope/hr/telescope-shadow.png",
            priority = "high",
            width = 2608/8,
            height = 1552/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(32, 7),
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-observation-visible", "space-observation-uv", "space-observation-infrared"},
    crafting_speed = 2,
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
        light = {intensity = 0.5, size = 8, shift = {0.0, 0.0}, color = {r = 0.9, g = 1, b = 0.8}}
      },
    },
  },
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-telescope-xray",
    icon = "__space-exploration-graphics__/graphics/icons/telescope-xray.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-telescope-xray"},
    max_health = 500,
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
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -3} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 3} }},
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
          filename = "__space-exploration-graphics__/graphics/entity/telescope-xray/sr/telescope-xray.png",
          priority = "high",
          width = 2880/8/2,
          height = 3232/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(6, -13),
          animation_speed = 0.1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope-xray/hr/telescope-xray.png",
            priority = "high",
            width = 2880/8,
            height = 3232/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(6, -13),
            animation_speed = 0.1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/telescope-xray/sr/telescope-xray-shadow.png",
          priority = "high",
          width = 3712/8/2,
          height = 2224/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(33, 10),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope-xray/hr/telescope-xray-shadow.png",
            priority = "high",
            width = 3712/8,
            height = 2224/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(33, 10),
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-observation-xray"},
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
        light = {intensity = 0.5, size = 8, shift = {0.0, 0.0}, color = {r = 0.5, g = 0.5, b = 1}}
      },
    },
  },
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-telescope-gammaray",
    icon = "__space-exploration-graphics__/graphics/icons/telescope-gammaray.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-telescope-gammaray"},
    max_health = 500,
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
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -3} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 3} }},
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
          filename = "__space-exploration-graphics__/graphics/entity/telescope-gammaray/sr/telescope-gammaray.png",
          priority = "high",
          width = 2880/8/2,
          height = 3232/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(6, -13),
          animation_speed = 0.1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope-gammaray/hr/telescope-gammaray.png",
            priority = "high",
            width = 2880/8,
            height = 3232/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(6, -13),
            animation_speed = 0.1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/telescope-gammaray/sr/telescope-gammaray-shadow.png",
          priority = "high",
          width = 3712/8/2,
          height = 2224/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(33, 10),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope-gammaray/hr/telescope-gammaray-shadow.png",
            priority = "high",
            width = 3712/8,
            height = 2224/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(33, 10),
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-observation-gammaray"},
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
        light = {intensity = 0.5, size = 8, shift = {0.0, 0.0}, color = {r = 1, g = 0.5, b = 1}}
      },
    },
  },
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-telescope-microwave",
    icon = "__space-exploration-graphics__/graphics/icons/telescope-microwave.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-telescope-microwave"},
    max_health = 500,
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
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 5} }},
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
          filename = "__space-exploration-graphics__/graphics/entity/telescope-microwave/sr/telescope-microwave.png",
          priority = "high",
          width = 4688/8/2,
          height = 5440/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(1, -26),
          animation_speed = 0.1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope-microwave/hr/telescope-microwave.png",
            priority = "high",
            width = 4688/8,
            height = 5440/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(1, -26),
            animation_speed = 0.1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/telescope-microwave/sr/telescope-microwave-shadow.png",
          priority = "high",
          width = 5440/8/2,
          height = 4800/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(25, 19),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope-microwave/hr/telescope-microwave-shadow.png",
            priority = "high",
            width = 5440/8,
            height = 4800/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(25, 19),
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-observation-microwave"},
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
        light = {intensity = 0.5, size = 8, shift = {0.0, 0.0}, color = {r = 1, g = 1, b = 0.5}}
      },
    },
  },
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-telescope-radio",
    icon = "__space-exploration-graphics__/graphics/icons/telescope-radio.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-telescope-radio"},
    max_health = 500,
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
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 5} }},
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
          filename = "__space-exploration-graphics__/graphics/entity/telescope-radio/sr/telescope-radio.png",
          priority = "high",
          width = 4688/8/2,
          height = 5440/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(1, -26),
          animation_speed = 0.1,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope-radio/hr/telescope-radio.png",
            priority = "high",
            width = 4688/8,
            height = 5440/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(1, -26),
            animation_speed = 0.1,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/telescope-radio/sr/telescope-radio-shadow.png",
          priority = "high",
          width = 5440/8/2,
          height = 4800/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(25, 19),
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/telescope-radio/hr/telescope-radio-shadow.png",
            priority = "high",
            width = 5440/8,
            height = 4800/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(25, 19),
            scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-observation-radio"},
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
        light = {intensity = 0.5, size = 8, shift = {0.0, 0.0}, color = {r = 1, g = 0.5, b = 0.5}}
      },
    },
  },
})
