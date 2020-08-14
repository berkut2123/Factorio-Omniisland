local data_util = require("data_util")

local space_assembler = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])
space_assembler.name = data_util.mod_prefix .. "space-assembling-machine"
space_assembler.icon = "__space-exploration-graphics__/graphics/icons/assembling-machine.png"
space_assembler.icon_size = 32

data_util.replace_filenames_recursive(space_assembler.animation,
  "__base__",
  "__space-exploration-graphics__")
data_util.replace_filenames_recursive(space_assembler.animation,
  "assembling-machine-3",
  "assembling-machine")
local pipe_pics = nil
for _, fluid_box in pairs(space_assembler.fluid_boxes) do
  if type(fluid_box) == "table" then
    data_util.replace_filenames_recursive(fluid_box.pipe_picture,
      "__base__",
      "__space-exploration-graphics__")
    data_util.replace_filenames_recursive(fluid_box.pipe_picture,
      "assembling-machine-3",
      "assembling-machine")
    pipe_pics = table.deepcopy(fluid_box.pipe_picture)
  end
end
space_assembler.minable.result = data_util.mod_prefix .. "space-assembling-machine"
space_assembler.allowed_effects = {"consumption", "speed",  "pollution"} -- not "productivity"
space_assembler.fast_replaceable_group = nil
space_assembler.next_upgrade = nil
space_assembler.collision_mask = {
  "water-tile",
  "ground-tile",
  "item-layer",
  "object-layer",
  "player-layer",
}
table.insert(space_assembler.crafting_categories, "space-crafting")

data:extend({
  space_assembler,
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "space-manufactory",
    icon = "__space-exploration-graphics__/graphics/icons/manufactory.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "space-manufactory"},
    max_health = 900,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-5, 2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-2, -5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-5, -2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {2, -5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {-2, 5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {5, 2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {5, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {2, 5} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {5, -2} }},
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
          filename = "__base__/sound/assembling-machine-t3-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t3-2.ogg",
          volume = 0.8
        },
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    },
    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
    },
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    drawing_box = {{-4.5, -4.7}, {4.5, 4.5}},
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/base.png",
          priority = "high",
          width = 577,
          height = 605,
          frame_count = 1,
          line_length = 1,
          repeat_count = 128,
          shift = util.by_pixel(0, -8),
          animation_speed = 0.5,
          scale = 0.5,
        },
        {
          priority = "high",
          width = 512,
          height = 422,
          frame_count = 128,
          shift = util.by_pixel(-0, -51),
          animation_speed = 0.25,
          scale = 0.5,
          stripes =
          {
            {
             filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/top-1.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/top-2.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/top-3.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/top-4.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/top-5.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/top-6.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/top-7.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/top-8.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/middle.png",
          priority = "high",
          width = 40,
          height = 82,
          frame_count = 128,
          line_length = 16,
          shift = util.by_pixel(51, 79),
          animation_speed = 0.25,
          scale = 0.5,
        },
        --[[{
          filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/lower.png",
          priority = "high",
          width = 80,
          height = 22,
          frame_count = 128,
          line_length = 8,
          shift = util.by_pixel(62, 137),
          scale = 0.5,
        },]]--
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/space-manufactory/hr/shadow.png",
          priority = "high",
          width = 795,
          height = 430,
          frame_count = 1,
          line_length = 1,
          repeat_count = 128,
          shift = util.by_pixel(67, 38),
          scale = 0.5,
        },
      },
    },
    crafting_categories = {"crafting", "advanced-crafting", "crafting-with-fluid", "space-crafting", "space-manufacturing"},
    crafting_speed = 10,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 50,
    },
    energy_usage = "2000kW",
    ingredient_count = 12,
    module_specification =
    {
      module_slots = 6
    },
    allowed_effects = {"consumption", "speed",  "pollution"}, -- not "productivity",
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.8, size = 20, shift = {0.0, 0.0}, color = {r = 0.7, g = 0.8, b = 1}}
      },
    },
  },
})
