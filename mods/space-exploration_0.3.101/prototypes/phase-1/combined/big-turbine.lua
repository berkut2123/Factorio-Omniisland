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

local fan = {
  filename = "__space-exploration-graphics__/graphics/entity/big-turbine/sr/fan.png",
  frame_count = 4,
  line_length = 4,
  width = 656/4/2,
  height = 116/2,
  hr_version = data_util.hr({
    filename = "__space-exploration-hr-graphics__/graphics/entity/big-turbine/hr/fan.png",
    frame_count = 4,
    line_length = 4,
    width = 656/4,
    height = 116,
    scale = 0.5,
  }),
}
local fan_shifts = {
  north = {0,0},
  south = {0,0},
  east = {0,0},
  west = {0,0},
}
local fan_north = table.deepcopy(fan)
data_util.shift_recursive(fan_north, fan_shifts["north"])
local fan_south = table.deepcopy(fan)
data_util.shift_recursive(fan_south, fan_shifts["south"])
local fan_east = table.deepcopy(fan)
data_util.shift_recursive(fan_east, fan_shifts["east"])
local fan_west = table.deepcopy(fan)
data_util.shift_recursive(fan_west, fan_shifts["west"])

local blank_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
}
local length = 10
local width = 7
data:extend({
  {
    type = "recipe",
    name = data_util.mod_prefix .. "big-turbine-internal",
    icon = "__space-exploration-graphics__/graphics/icons/fluid/water.png",
    icon_size = 64,
    order = "a",
    subgroup = "spaceship-process",
    energy_required = 4/60, -- try to get craft time in line with generator fluid consumption
    category = "big-turbine",
    ingredients =
    {
      {type="fluid", name="steam", amount=100, minimum_temperature = 5000},
    },
    results = {
      {type="fluid", name="water", amount=78},
      {type="fluid", name="steam", amount=21, temperature = 500},
      {type="fluid", name=data_util.mod_prefix .. "decompressing-steam", amount=90, temperature = 5000},
    },
    hidden = true,
    enabled = true,
    allow_as_intermediate = false,
    always_show_made_in = true,
  },
  {
      type = "item",
      name = data_util.mod_prefix .. "big-turbine",
      icon = "__space-exploration-graphics__/graphics/icons/big-turbine.png",
      icon_size = 64,
      order = "d[fluid-burner-generator]-a",
      subgroup = "energy",
      stack_size = 50,
      place_result = data_util.mod_prefix .. "big-turbine",
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "big-turbine",
      result = data_util.mod_prefix .. "big-turbine",
      enabled = false,
      energy_required = 60,
      ingredients = {
        { data_util.mod_prefix .. "lattice-pressure-vessel", 10 },
        { data_util.mod_prefix .. "naquium-cube", 5 },
        { data_util.mod_prefix .. "space-pipe", 50 },
        { data_util.mod_prefix .. "heavy-composite", 20 },
        { data_util.mod_prefix .. "heat-shielding", 50 },
        { data_util.mod_prefix .. "holmium-solenoid", 20 },
        { data_util.mod_prefix .. "superconductive-cable", 20 },
      },
      requester_paste_multiplier = 1,
      always_show_made_in = false,
  },
  {
      type = "technology",
      name = data_util.mod_prefix .. "big-turbine",
      effects = {
       {
         type = "unlock-recipe",
         recipe = data_util.mod_prefix .. "big-turbine",
       },
      },
      icon = "__space-exploration-graphics__/graphics/technology/big-turbine.png",
      icon_size = 128,
      order = "e-g",
      prerequisites = {
        data_util.mod_prefix .. "big-heat-exchanger",
        data_util.mod_prefix .. "heavy-assembly",
      },
      unit = {
       count = 500,
       time = 60,
       ingredients = {
         { "automation-science-pack", 1 },
         { "logistic-science-pack", 1 },
         { "chemical-science-pack", 1 },
         { "production-science-pack", 1 },
         { data_util.mod_prefix .. "rocket-science-pack", 1 },
         { data_util.mod_prefix .. "astronomic-science-pack-4", 1 },
         { data_util.mod_prefix .. "material-science-pack-4", 1 },
         { data_util.mod_prefix .. "energy-science-pack-4", 1 },
         { data_util.mod_prefix .. "deep-space-science-pack", 1 },
       }
      },
  },
  {
    type = "storage-tank",
    name = data_util.mod_prefix .. "big-turbine-tank",
    icon = "__space-exploration-graphics__/graphics/icons/big-turbine.png",
    icon_size = 64,
    flags = {"placeable-player", "player-creation", "not-deconstructable", "not-blueprintable"},
    max_health = 500,
    order = "zz",
    collision_box = {{-1.5, -0.25},{1.5, 0.25}},
    selection_box = {{-1.5, -0.25},{1.5, 0.25}},
    collision_mask = {"not-colliding-with-itself"},
    selectable_in_game = selectable,
    selection_priority = 53,
    fluid_box =
    {
      filter =  data_util.mod_prefix .. "decompressing-steam",
      base_area = 10, -- gets multiplied by 100 by engine
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
    name = data_util.mod_prefix .. "big-turbine-generator",
    icon = "__space-exploration-graphics__/graphics/icons/big-turbine.png",
    icon_size = 64,
    alert_icon_shift = { 0, 0.375 },
    burns_fluid = false,
    scale_fluid_usage = true,
    max_power_output = "1GW",
    fluid_usage_per_tick = 25,
    selectable_in_game = selectable,
    selection_priority = 52,
    --collision_box = {  { -1.25, -1.6 }, { 1.25, 1.6 } }, -- short and wide thin
    collision_box = {  { -(width/2-0.25), -(length/2-0.9) }, { (width/2-0.25), (length/2-0.9) } },
    --selection_box = { { -1.5, -2.5 }, { 1.5, 2.5 } },
    selection_box =  {  { -width/2, -(length/2-0.5) }, { width/2, (length/2-0.5) } },
    collision_mask = {"not-colliding-with-itself"},
    order = "zzz",
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    effectivity = 1,
    energy_source = { type = "electric", usage_priority = "secondary-output" },
    fast_replaceable_group = "steam-engine",
    flags = { "placeable-neutral", "player-creation", "placeable-off-grid" },
    fluid_box = {
      base_area = 20,
      base_level = -1,
      filter =  data_util.mod_prefix .. "decompressing-steam",
      --filter =  "steam",
      height = 2,
      minimum_temperature = 5000,
      pipe_connections = {
        {
          position = { 0, (length/2-0.75) },
          type = "input-output"
        },
        {
          position = { 0, -(length/2-0.75) },
          type = "input-output"
        },
      },
      production_type = "input-output"
    },
    horizontal_animation = blank_image,
    max_health = 300,
    maximum_temperature = 5000,
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
    vertical_animation = blank_image,
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
    name = data_util.mod_prefix .. "big-turbine",
    icon = "__space-exploration-graphics__/graphics/icons/big-turbine.png",
    --collision_box = {  { -1.3, -2.15 }, { 1.3, 2.15 } },
    collision_box = {  { -(width/2-0.2), -(length/2-0.35) }, { (width/2-0.2), (length/2-0.35) } },
    --selection_box = { { -1.5, -2.5 }, { 1.5, 2.5 } },
    selection_box =  {  { -width/2, -length/2 }, { width/2, length/2 } },
    selection_priority = 50,
    fluid_boxes =
    {
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 40,
        base_level = -1,
        filter = "steam",
        pipe_connections = {
          { type="input-output", position = {0, -(length/2+0.5)} }
        },
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 20,
        base_level = 1,
        filter = "water",
        pipe_connections = {
          { type="output", position = {(width/2+0.5), 1.5} },
          { type="output", position = {(width/2+0.5), -1.5} },
          { type="output", position = {-(width/2+0.5), 1.5} },
          { type="output", position = {-(width/2+0.5), -1.5} },
        },
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 20,
        base_level = 1,
        filter = "steam",
        pipe_connections = {
          { type="output", position = {0, (length/2+0.5)} },
        },
        secondary_draw_orders = { north = -1 }
      },
      {
        filter =  data_util.mod_prefix .. "decompressing-steam",
        --filter = "steam",
        production_type = "output",
        --pipe_picture = assembler3pipepictures(),
        base_area = 20,
        base_level = 1,
        pipe_connections = {
          { type="output", position = {1, length/2 - 0.25} },
          { type="output", position = {-1, length/2 - 0.25} },
        },
        secondary_draw_orders = { north = -1 }
      },
    },
    minable = {
      mining_time = 0.3,
      result = data_util.mod_prefix .. "big-turbine",
    },
    icon_size = 64,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    max_health = 800,
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
      east = {
        layers = {
          {
            filename = "__space-exploration-graphics__/graphics/entity/big-turbine/sr/east.png",
            frame_count = 1,
            line_length = 1,
            repeat_count = 4,
            width = 640/2,
            height = 480/2,
            shift = {0,-0.25},
            hr_version = data_util.hr({
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-turbine/hr/east.png",
              frame_count = 1,
              line_length = 1,
              repeat_count = 4,
              width = 640,
              height = 480,
              shift = {0,-0.25},
              scale = 0.5,
            }),
          },
          {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/big-turbine/sr/east_shadow.png",
            frame_count = 1,
            line_length = 1,
            repeat_count = 4,
            width = 832/2,
            height = 384/2,
            shift = {1.5,0.5},
            hr_version = data_util.hr({
              draw_as_shadow = true,
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-turbine/hr/east_shadow.png",
              frame_count = 1,
              line_length = 1,
              repeat_count = 4,
              width = 832,
              height = 384,
              shift = {1.5,0.5},
              scale = 0.5,
            }),
          },
        }
      },
      west = {
        layers = {
          {
            filename = "__space-exploration-graphics__/graphics/entity/big-turbine/sr/west.png",
            frame_count = 1,
            line_length = 1,
            repeat_count = 4,
            width = 640/2,
            height = 480/2,
            shift = {0,-0.25},
            hr_version = data_util.hr({
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-turbine/hr/west.png",
              frame_count = 1,
              line_length = 1,
              repeat_count = 4,
              width = 640,
              height = 480,
              shift = {0,-0.25},
              scale = 0.5,
            }),
          },
          {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/big-turbine/sr/west_shadow.png",
            frame_count = 1,
            line_length = 1,
            repeat_count = 4,
            width = 832/2,
            height = 384/2,
            shift = {1.5,0.5},
            hr_version = data_util.hr({
              draw_as_shadow = true,
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-turbine/hr/west_shadow.png",
              frame_count = 1,
              line_length = 1,
              repeat_count = 4,
              width = 832,
              height = 384,
              shift = {1.5,0.5},
              scale = 0.5,
            }),
          },
        }
      },
      north = {
        layers = {
          {
            filename = "__space-exploration-graphics__/graphics/entity/big-turbine/sr/north.png",
            frame_count = 1,
            line_length = 1,
            repeat_count = 4,
            width = 448/2,
            height = 672/2,
            shift = {0,-0.25},
            hr_version = data_util.hr({
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-turbine/hr/north.png",
              frame_count = 1,
              line_length = 1,
              repeat_count = 4,
              width = 448,
              height = 672,
              shift = {0,-0.25},
              scale = 0.5,
            }),
          },
          {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/big-turbine/sr/north_shadow.png",
            frame_count = 1,
            line_length = 1,
            repeat_count = 4,
            width = 640/2,
            height = 576/2,
            shift = {1.5,0.5},
            hr_version = data_util.hr({
              draw_as_shadow = true,
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-turbine/hr/north_shadow.png",
              frame_count = 1,
              line_length = 1,
              repeat_count = 4,
              width = 640,
              height = 576,
              shift = {1.5,0.5},
              scale = 0.5,
            }),
          },
        }
      },
      south = {
        layers = {
          {
            filename = "__space-exploration-graphics__/graphics/entity/big-turbine/sr/south.png",
            frame_count = 1,
            line_length = 1,
            repeat_count = 4,
            width = 448/2,
            height = 672/2,
            shift = {0,-0.25},
            hr_version = data_util.hr({
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-turbine/hr/south.png",
              frame_count = 1,
              line_length = 1,
              repeat_count = 4,
              width = 448,
              height = 672,
              shift = {0,-0.25},
              scale = 0.5,
            }),
          },
          {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/big-turbine/sr/south_shadow.png",
            frame_count = 1,
            line_length = 1,
            repeat_count = 4,
            width = 640/2,
            height = 576/2,
            shift = {1.5,0.5},
            hr_version = data_util.hr({
              draw_as_shadow = true,
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-turbine/hr/south_shadow.png",
              frame_count = 1,
              line_length = 1,
              repeat_count = 4,
              width = 640,
              height = 576,
              shift = {1.5,0.5},
              scale = 0.5,
            }),
          },
        }
      },
    },
    crafting_categories = {"big-turbine"},
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
    working_visualisations = {
      east = fan_east,
      west = fan_west,
      north = fan_north,
      south = fan_south,
    },
  },
})
