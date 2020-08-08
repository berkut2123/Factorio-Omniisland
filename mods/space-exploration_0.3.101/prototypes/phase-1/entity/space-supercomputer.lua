local data_util = require("data_util")
local blank_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
}
local pipe_pictures = {
  north = blank_image,
  east = {
    filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/pipe-right.png",
    width = 28/2,
    height = 70/2,
    priority = "extra-high",
    shift = util.by_pixel(-24, 0),
    hr_version = {
      filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/pipe-right.png",
      width = 28,
      height = 70,
      priority = "extra-high",
      shift = util.by_pixel(-24, 0),
      scale = 0.5,
    },
  },
  south = {
    filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/pipe-bottom.png",
    width = 84/2,
    height = 72/2,
    priority = "extra-high",
    shift = util.by_pixel(1, -34),
    hr_version = {
      filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/pipe-bottom.png",
      width = 84,
      height = 72,
      priority = "extra-high",
      shift = util.by_pixel(1, -34),
      scale = 0.5,
    },
  },
  west = {
    filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/pipe-left.png",
    width = 28/2,
    height = 70/2,
    priority = "extra-high",
    shift = util.by_pixel(23, 4),
    hr_version = {
      filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/pipe-left.png",
      width = 28,
      height = 70,
      priority = "extra-high",
      shift = util.by_pixel(23, 4),
      scale = 0.5,
    },
  }
}
data:extend({
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-supercomputer-1",
    icon = "__space-exploration-graphics__/graphics/icons/supercomputer-1.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = { mining_time = 0.1, result = data_util.mod_prefix .. "space-supercomputer-1"},
    fast_replaceable_group = data_util.mod_prefix .. "space-supercomputer",
    next_upgrade = data_util.mod_prefix .. "space-supercomputer-2",
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, 0),
    resistances =
    {
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
          volume = 0.7
        },
      },
      apparent_volume = 1,
    },
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
    },
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -2.7}, {2.5, 2.5}},
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/supercomputer-1.png",
          priority = "high",
          width = 320/2,
          height = 384/2,
          frame_count = 1,
          shift = util.by_pixel(-0, -16),
          animation_speed = 1,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/supercomputer-1.png",
            priority = "high",
            width = 320,
            height = 384,
            frame_count = 1,
            shift = util.by_pixel(-0, -16),
            animation_speed = 1,
            scale = 0.5,
          }
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/supercomputer-shadow.png",
          priority = "high",
          width = 302/2,
          height = 260/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(75, 27),
          hr_version = {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/supercomputer-shadow.png",
            priority = "high",
            width = 302,
            height = 260,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(75, 27),
            scale = 0.5,
          },
        },
      },
    },
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.6, size = 16, shift = {0.0, 0.0}, color = {r = 1, g = 0.2, b = 0.1}}
      },
      {
        animation = {
          filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/supercomputer-1-working.png",
          priority = "high",
          width = 792/9/2,
          height = 286/2,
          frame_count = 9,
          shift = util.by_pixel(-0, -39),
          animation_speed = 0.5,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/supercomputer-1-working.png",
            priority = "high",
            width = 792/9,
            height = 286,
            frame_count = 9,
            shift = util.by_pixel(-0, -39),
            animation_speed = 0.5,
            scale = 0.5,
          }
        },
      }
    },
    crafting_categories = {"space-supercomputing-1"},
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
      module_slots = 2
    },
    allowed_effects = {"consumption", "speed", "pollution"} -- not "productivity",
  },

  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-supercomputer-2",
    icon = "__space-exploration-graphics__/graphics/icons/supercomputer-2.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = data_util.mod_prefix .. "space-supercomputer-2"},
    fast_replaceable_group = data_util.mod_prefix .. "space-supercomputer",
    next_upgrade = data_util.mod_prefix .. "space-supercomputer-3",
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, 0),
    resistances =
    {
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
          volume = 0.7
        },
      },
      apparent_volume = 1,
    },
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
    },
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -2.7}, {2.5, 2.5}},
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/supercomputer-2.png",
          priority = "high",
          width = 320/2,
          height = 384/2,
          frame_count = 1,
          shift = util.by_pixel(-0, -16),
          animation_speed = 1,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/supercomputer-2.png",
            priority = "high",
            width = 320,
            height = 384,
            frame_count = 1,
            shift = util.by_pixel(-0, -16),
            animation_speed = 1,
            scale = 0.5,
          }
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/supercomputer-shadow.png",
          priority = "high",
          width = 302/2,
          height = 260/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(75, 27),
          hr_version = {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/supercomputer-shadow.png",
            priority = "high",
            width = 302,
            height = 260,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(75, 27),
            scale = 0.5,
          },
        },
      },
    },
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.6, size = 16, shift = {0.0, 0.0}, color = {r = 1, g = 1, b = 0.1}}
      },
      {
        animation = {
          filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/supercomputer-2-working.png",
          priority = "high",
          width = 792/9/2,
          height = 286/2,
          frame_count = 9,
          shift = util.by_pixel(-0, -39),
          animation_speed = 0.5,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/supercomputer-2-working.png",
            priority = "high",
            width = 792/9,
            height = 286,
            frame_count = 9,
            shift = util.by_pixel(-0, -39),
            animation_speed = 0.5,
            scale = 0.5,
          }
        },
      }
    },
    crafting_categories = {"space-supercomputing-1", "space-supercomputing-2"},
    crafting_speed = 2,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
    },
    energy_usage = "2500kW",
    ingredient_count = 12,
    module_specification =
    {
      module_slots = 4
    },
    allowed_effects = {"consumption", "speed", "pollution"} -- not "productivity",
  },
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-supercomputer-3",
    icon = "__space-exploration-graphics__/graphics/icons/supercomputer-3.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = data_util.mod_prefix .. "space-supercomputer-3"},
    fast_replaceable_group = data_util.mod_prefix .. "space-supercomputer",
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, 0),
    resistances =
    {
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
          volume = 0.7
        },
      },
      apparent_volume = 1,
    },
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
    },
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -2.7}, {2.5, 2.5}},
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/supercomputer-3.png",
          priority = "high",
          width = 320/2,
          height = 384/2,
          frame_count = 1,
          shift = util.by_pixel(-0, -16),
          animation_speed = 1,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/supercomputer-3.png",
            priority = "high",
            width = 320,
            height = 384,
            frame_count = 1,
            shift = util.by_pixel(-0, -16),
            animation_speed = 1,
            scale = 0.5,
          }
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/supercomputer-shadow.png",
          priority = "high",
          width = 302/2,
          height = 260/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(75, 27),
          hr_version = {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/supercomputer-shadow.png",
            priority = "high",
            width = 302,
            height = 260,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(75, 27),
            scale = 0.5,
          },
        },
      },
    },
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.6, size = 16, shift = {0.0, 0.0}, color = {r = 0.1, g = 1, b = 1}}
      },
      {
        animation = {
          filename = "__space-exploration-graphics__/graphics/entity/supercomputer/sr/supercomputer-3-working.png",
          priority = "high",
          width = 792/9/2,
          height = 286/2,
          frame_count = 9,
          shift = util.by_pixel(-0, -39),
          animation_speed = 0.5,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/supercomputer/hr/supercomputer-3-working.png",
            priority = "high",
            width = 792/9,
            height = 286,
            frame_count = 9,
            shift = util.by_pixel(-0, -39),
            animation_speed = 0.5,
            scale = 0.5,
          }
        },
      }
    },
    crafting_categories = {"space-supercomputing-1", "space-supercomputing-2", "space-supercomputing-3"},
    crafting_speed = 4,
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
      module_slots = 6
    },
    allowed_effects = {"consumption", "speed", "pollution"} -- not "productivity",
  }
})
