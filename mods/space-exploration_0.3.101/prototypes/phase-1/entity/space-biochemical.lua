local data_util = require("data_util")

local pipe_pics = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"].fluid_boxes[1].pipe_picture)
data_util.replace_filenames_recursive(pipe_pics,
  "__base__",
  "__space-exploration-graphics__")
data_util.replace_filenames_recursive(pipe_pics,
  "assembling-machine-3",
  "assembling-machine")

data:extend({
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-biochemical-laboratory",
    icon = "__space-exploration-graphics__/graphics/icons/biochemical-laboratory.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-biochemical-laboratory"},
    max_health = 700,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    drawing_box = {{-4.5, -4.7}, {4.5, 4.5}},
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
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-5, 2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-2, -5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-5, -2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {2, -5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {-2, 5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {5, 2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {2, 5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {5, -2} }},
        secondary_draw_orders = { north = -1 }
      },
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/pumpjack.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t3-1.ogg",
          volume = 0.8
        },
      },
      idle_sound = { filename = "__base__/sound/pipe.ogg", volume = 0.6 },
      apparent_volume = 1.5,
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
          filename = "__space-exploration-graphics__/graphics/entity/biochemical-laboratory/sr/biochemical-laboratory.png",
          priority = "high",
          width = 4608/8/2,
          height = 5120/8/2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(0, -16),
          animation_speed = 0.5,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/biochemical-laboratory/hr/biochemical-laboratory.png",
            priority = "high",
            width = 4608/8,
            height = 5120/8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(0, -16),
            animation_speed = 0.5,
            scale = 0.5,
          })
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/biochemical-laboratory/sr/shadow.png",
          priority = "high",
          width = 648/2,
          height = 560/2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 64,
          shift = util.by_pixel(35, 20),
          hr_version = data_util.hr({
              draw_as_shadow = true,
              filename = "__space-exploration-hr-graphics__/graphics/entity/biochemical-laboratory/hr/shadow.png",
              priority = "high",
              width = 648,
              height = 560,
              frame_count = 1,
              line_length = 1,
              repeat_count = 64,
              shift = util.by_pixel(35, 20),
              scale = 0.5,
          })
        },
      },
    },
    crafting_categories = {"space-biochemical", "chemistry", "oil-processing"},
    crafting_speed = 4,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
    },
    energy_usage = "3000kW",
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
        light = {intensity = 0.2, size = 16, shift = {0.0, 0.0}, color = {r = 0.6, g = 1, b = 0.5}}
      },
    },
  },
})
