local data_util = require("data_util")

data:extend({
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-radiator",
    icon = "__space-exploration-graphics__/graphics/icons/radiator.png",
    icon_size = 64,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = data_util.mod_prefix .. "space-radiator"},
    fast_replaceable_group = data_util.mod_prefix .. "space-radiator",
    max_health = 150,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, 0),
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    drawing_box = {{-1.5, -1.7}, {1.5, 1.5}},
    resistances =
    {
      {
        type = "fire",
        percent = 90
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
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/electric-furnace.ogg",
          volume = 0.7
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
    },
    animation =
    {
      layers =
      {
        {
          priority = "high",
          width = 196,
          height = 275,
          frame_count = 20,
          shift = util.by_pixel(-0, -12),
          animation_speed = 0.25,
          scale = 0.5,
          stripes =
          {
            {
             filename = "__space-exploration-graphics__/graphics/entity/radiator/hr/radiator.png",
             width_in_frames = 10,
             height_in_frames = 2,
            },
          }
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/radiator/hr/radiator-shadow.png",
          priority = "high",
          width = 242,
          height = 147,
          frame_count = 1,
          line_length = 1,
          repeat_count = 20,
          shift = util.by_pixel(25, 11),
          scale = 0.5,
        },
      },
    },
    crafting_categories = {"space-radiator"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 1,
    },
    energy_usage = "10kW",
    ingredient_count = 12,
    module_specification =
    {
      module_slots = 0
    },
    allowed_effects = {}, -- not "productivity",
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.3, size = 9, shift = {0.0, 0.0}, color = {r = 1, g = 0.3, b = 0.05}}
      },
    },
    module_specification =
    {
      module_slots = 2
    },
    allowed_effects = {"consumption", "speed", "pollution"} -- not "productivity",
  },
})
local radiator_2 = table.deepcopy(data.raw["assembling-machine"][data_util.mod_prefix .. "space-radiator"])
radiator_2.name = data_util.mod_prefix .. "space-radiator-2"
radiator_2.crafting_speed = 2
radiator_2.icon = "__space-exploration-graphics__/graphics/icons/radiator-blue.png"
radiator_2.minable.result = data_util.mod_prefix .. "space-radiator-2"
data_util.replace_filenames_recursive(radiator_2.animation, "radiator.png", "radiator-blue.png")
data:extend({
  radiator_2
})
data.raw["assembling-machine"][data_util.mod_prefix .. "space-radiator"].next_upgrade = radiator_2.name
