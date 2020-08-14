local data_util = require("data_util")
--[[
fluid box connections don't need to line up just find the right entity.
furnace is the placed entity, short but wide, outputs at front
Outpts piped heat to the turbine
turbine ies long and thin, collects from side

has a connection top and right
always goes on the bottom or left
move horizontal version down 1 pixel so animation shows

if the turbine is aove the the animation won't work
make sure furnace has outputs at both lockations
]]--
local selectable = false
local idle_horizontal = {
  layers = {
    {
      filename = "__space-exploration-graphics__/graphics/entity/condenser-turbine/condenser-turbine-H.png",
      frame_count = 1,
      height = 123,
      hr_version = data_util.hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/condenser-turbine/hr-condenser-turbine-H.png",
        frame_count = 1,
        height = 245,
        line_length = 1,
        scale = 0.5,
        shift = {
          0,
          -0.0859375
        },
        width = 320
      }),
      line_length = 1,
      shift = {
        0,
        -0.078125
      },
      width = 160
    },
    {
      draw_as_shadow = true,
      filename = "__base__/graphics/entity/steam-turbine/steam-turbine-H-shadow.png",
      frame_count = 1,
      height = 74,
      hr_version = {
        draw_as_shadow = true,
        filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-H-shadow.png",
        frame_count = 1,
        height = 150,
        line_length = 1,
        scale = 0.5,
        shift = {
          0.890625,
          0.5625
        },
        width = 435
      },
      line_length = 1,
      shift = {
        0.8984375,
        0.5625
      },
      width = 217
    }
  }
}
local idle_vertical = {
  layers = {
    {
      filename = "__space-exploration-graphics__/graphics/entity/condenser-turbine/condenser-turbine-V.png",
      frame_count = 1,
      height = 173,
      hr_version =data_util.hr( {
        filename = "__space-exploration-hr-graphics__/graphics/entity/condenser-turbine/hr-condenser-turbine-V.png",
        frame_count = 1,
        height = 347,
        line_length = 1,
        scale = 0.5,
        shift = {
          0.1484375,
          0.2109375
        },
        width = 217
      }),
      line_length = 1,
      shift = {
        0.15625,
        0.203125
      },
      width = 108
    },
    {
      draw_as_shadow = true,
      filename = "__base__/graphics/entity/steam-turbine/steam-turbine-V-shadow.png",
      frame_count = 1,
      height = 131,
      hr_version = {
        draw_as_shadow = true,
        filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-V-shadow.png",
        frame_count = 1,
        height = 260,
        line_length = 1,
        repeat_count = 1,
        scale = 0.5,
        shift = {
          1.234375,
          0.765625
        },
        width = 302
      },
      line_length = 1,
      repeat_count = 1,
      shift = {
        1.234375,
        0.765625
      },
      width = 151
    }
  }
}
local blank_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
}
data:extend({

  {
    type = "storage-tank",
    name = data_util.mod_prefix .. "condenser-turbine-tank",
    icon = "__space-exploration-graphics__/graphics/icons/condenser-turbine.png",
    icon_size = 32,
    flags = {"placeable-player", "player-creation", "not-deconstructable", "not-blueprintable"},
    max_health = 500,
    order = "zz",
    collision_box = {{-1.5, -0.25},{1.5, 0.25}},
    selection_box = {{-1.5, -0.25},{1.5, 0.25}},
    collision_mask = {"not-colliding-with-itself"},
    selectable_in_game = selectable,
    fluid_box =
    {
      filter =  data_util.mod_prefix .. "decompressing-steam",
      base_area = 0.25, -- gets multiplied by 100 by engine
      base_level = 0, -- pull fluid in
      pipe_connections =
      {
        { position = {0, -1} }, -- connects to generator
        { position = {1, -1} }, -- connects to furnace
        { position = {-1, -1} }, -- connects to furnace
      },
    },
    window_bounding_box = {{-0.0, 0.0}, {0.0, 1.0}},
    pictures = {
      picture = blank_image,
      window_background = blank_image,
      fluid_background = blank_image,
      flow_sprite = blank_image,
      gas_flow = blank_image,
    },
    flow_length_in_ticks = 360,
    circuit_wire_max_distance = 0
  },
  {
    type = "generator",
    name = data_util.mod_prefix .. "condenser-turbine-generator",
    icon = "__space-exploration-graphics__/graphics/icons/condenser-turbine.png",
    icon_size = 32,
    alert_icon_shift = { 0, 0.375 },
    burns_fluid = false,
    fluid_usage_per_tick = 1,
    selectable_in_game = selectable,
    collision_box = {  { -1.25, -1.6 }, { 1.25, 1.6 } }, -- short and wide thin
    --collision_box = { { -1, -0.1 }, { 1, 0.1 } }, -- sits on y 2.25
    collision_mask = {"not-colliding-with-itself"},
    selection_box =  {  { -1.25, -1.6 }, { 1.25, 1.6 } },
    order = "zzz",
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    effectivity = 1,
    energy_source = { type = "electric", usage_priority = "secondary-output" },
    fast_replaceable_group = "steam-engine",
    flags = { "placeable-neutral", "player-creation", "placeable-off-grid" },
    fluid_box = {
      base_area = 0.25,
      base_level = -1,
      filter =  data_util.mod_prefix .. "decompressing-steam",
      --filter =  "steam",
      height = 2,
      minimum_temperature = 15,
      pipe_connections = {
        {
          position = { 0, 1.65 },
          type = "input-output"
        },
        {
          position = { 0, -1.65 },
          type = "input-output"
        },
      },
      production_type = "input-output"
    },
    horizontal_animation = {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/condenser-turbine/condenser-turbine-H.png",
          frame_count = 8,
          height = 123,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/condenser-turbine/hr-condenser-turbine-H.png",
            frame_count = 8,
            height = 245,
            line_length = 4,
            scale = 0.5,
            shift = {
              0,
              -0.0859375 - 1/32
            },
            width = 320
          }),
          line_length = 4,
          shift = {
            0,
            -0.078125 - 1/32
          },
          width = 160
        },
      }
    },
    max_health = 300,
    maximum_temperature = 500,
    min_perceived_performance = 0.25,
    performance_to_sound_speedup = 0.5,
    resistances = {
      {
        percent = 70,
        type = "fire"
      }
    },
    smoke = {
      {
        east_position = {
          0.75,
          -0.75
        },
        frequency = 0.3125,
        name = "turbine-smoke",
        north_position = {
          0,
          -1
        },
        slow_down_factor = 1,
        starting_frame_deviation = 60,
        starting_vertical_speed = 0.08
      }
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    vertical_animation = {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/condenser-turbine/condenser-turbine-V.png",
          frame_count = 8,
          height = 173,
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/condenser-turbine/hr-condenser-turbine-V.png",
            frame_count = 8,
            height = 347,
            line_length = 4,
            scale = 0.5,
            shift = {
              0.1484375,
              0.2109375 - 1/32
            },
            width = 217
          }),
          line_length = 4,
          shift = {
            0.15625,
            0.203125 - 1/32
          },
          width = 108
        }
      }
    },
    working_sound = {
      match_speed_to_activity = true,
      sound = {
        filename = "__base__/sound/steam-engine-90bpm.ogg",
        volume = 0.6
      }
    }
  },
  {
    type = "furnace",
    name = data_util.mod_prefix .. "condenser-turbine",
    icon = "__space-exploration-graphics__/graphics/icons/condenser-turbine.png",
    collision_box = {  { -1.3, -2.15 }, { 1.3, 2.15 } },
    --selection_box = { { -1.5, -2.5 }, { 1.5, 2.5 } },
    selection_box =  {  { -1.3, -2.15 }, { 1.3, 2.15 } },
    fluid_boxes =
    {
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 1.5,
        base_level = -1,
        filter = "steam",
        pipe_connections = {
          { type="input-output", position = {0, -3} }
        },
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 1.5,
        base_level = 1,
        filter = "water",
        pipe_connections = {
          { type="output", position = {0, 3} }
        },
        secondary_draw_orders = { north = -1 }
      },
      {
        filter =  data_util.mod_prefix .. "decompressing-steam",
        --filter = "steam",
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        base_area = 1.5,
        base_level = 1,
        pipe_connections = {
          { type="output", position = {1, 2.25} },
          { type="output", position = {-1, 2.25} },
        },
        secondary_draw_orders = { north = -1 }
      },
    },
    minable = {
      mining_time = 0.3,
      result = data_util.mod_prefix .. "condenser-turbine",
    },
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    drawing_box = {{-1.5, -3}, {1.5, 4}},
    resistances = {
      { type = "poison", percent = 100 },
      { type = "fire", percent = 80 },
      { type = "explosion", percent = 50 }
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
        filename = "__base__/sound/steam-engine-90bpm.ogg",
        volume = 0.6
      }
    },
    always_draw_idle_animation = true,
    source_inventory_size = 0,
    result_inventory_size = 0,
    animation = nil,
    idle_animation = {
      east = idle_horizontal,
      west = idle_horizontal,
      north = idle_vertical,
      south = idle_vertical,
    },
    crafting_categories = {"condenser-turbine"},
    crafting_speed = 1,
    energy_source =
    {
      type = "void",
    },
    energy_usage = "0.1W",
    ingredient_count = 0,
    module_specification =
    {
      module_slots = 0
    },
    allowed_effects = {},
    working_visualisations = nil,
  },
})
