local data_util = require("data_util")

local blank_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
}
local blank_directions = {
    north = blank_image,
    east = blank_image,
    south = blank_image,
    west = blank_image
}
local wall = table.deepcopy(data.raw.wall["stone-wall"])

wall.name =  data_util.mod_prefix .. "spaceship-wall"
wall.minable.result =  data_util.mod_prefix .. "spaceship-wall"
wall.max_health = 400
wall.resistances = {
  {type = "meteor", percent = 50},
  {type = "impact", percent = 50},
  {type = "physical", percent = 50},
  {type = "laser", percent = 50},
  {type = "fire", percent = 50},
  {type = "electric", percent = 50},
  {type = "explosion", percent = 50},
  {type = "acid", percent = 50},
  {type = "poison", percent = 100},
}
if mods["aai-industry"] then
  data_util.replace_filenames_recursive(wall.pictures, "__aai-industry__", "__space-exploration-graphics__")
  data_util.replace_filenames_recursive(wall.pictures, "stone-wall", "spaceship-wall")
else
  data_util.replace_filenames_recursive(wall.pictures, "__base__", "__space-exploration-graphics__")
  data_util.replace_filenames_recursive(wall.pictures, "entity/wall", "entity/spaceship-wall")
end
wall.collision_mask = {
  "ground-tile",
  "water-tile",
  "object-layer",
  "player-layer",
  "train-layer",
  "item-layer",
}
wall.fast_replaceable_group = nil
wall.next_upgrade = nil
wall.icon = "__space-exploration-graphics__/graphics/icons/spaceship-wall.png"
wall.icon_size = 32

local gate = table.deepcopy(data.raw.gate["gate"])
gate.name =  data_util.mod_prefix .. "spaceship-gate"
gate.minable.result =  data_util.mod_prefix .. "spaceship-gate"
for _, pictures in pairs({gate.horizontal_animation, gate.horizontal_rail_animation_left, gate.horizontal_rail_animation_right, gate.horizontal_rail_base,
  gate.vertical_animation, gate.vertical_rail_animation_left, gate.vertical_rail_animation_right, gate.vertical_rail_base }) do
    data_util.replace_filenames_recursive(pictures, "__base__/graphics/entity/gate/", "__space-exploration-graphics__/graphics/entity/spaceship-gate/")
end
gate.collision_mask = {
  "ground-tile",
  "water-tile",
  "object-layer",
  "item-layer",
  "player-layer",
  "train-layer",
}
gate.opened_collision_mask = { -- thanks Bilka
  "ground-tile",
  "water-tile",
  "object-layer",
  "item-layer",
}
gate.fast_replaceable_group = nil
gate.next_upgrade = nil
gate.icon = "__space-exploration-graphics__/graphics/icons/spaceship-gate.png"
gate.icon_size = 32


local booster = {
  type = "storage-tank",
  name = "storage-tank",
  icon = "__base__/graphics/icons/storage-tank.png",
  icon_size = 32,
  flags = {"placeable-player", "player-creation"},
  minable = {mining_time = 0.5, result = "storage-tank"},
  max_health = 500,
  corpse = "medium-remnants",
  collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  fluid_box =
  {
    base_area = 250,
    pipe_covers = pipecoverspictures(),
    pipe_connections =
    {
      { position = {-1, -2} },
      { position = {2, 1} },
      { position = {1, 2} },
      { position = {-2, -1} }
    }
  },
  two_direction_only = true,
  window_bounding_box = {{-0.125, 0.6875}, {0.1875, 1.1875}},
  pictures =
  {
    picture =
    {
      sheets =
      {
        {
          filename = "__base__/graphics/entity/storage-tank/storage-tank.png",
          priority = "extra-high",
          frames = 2,
          width = 110,
          height = 108,
          shift = util.by_pixel(0, 4),
          hr_version =
          {
            filename = "__base__/graphics/entity/storage-tank/hr-storage-tank.png",
            priority = "extra-high",
            frames = 2,
            width = 219,
            height = 215,
            shift = util.by_pixel(-0.25, 3.75),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/storage-tank/storage-tank-shadow.png",
          priority = "extra-high",
          frames = 2,
          width = 146,
          height = 77,
          shift = util.by_pixel(30, 22.5),
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__base__/graphics/entity/storage-tank/hr-storage-tank-shadow.png",
            priority = "extra-high",
            frames = 2,
            width = 291,
            height = 153,
            shift = util.by_pixel(29.75, 22.25),
            scale = 0.5,
            draw_as_shadow = true
          }
        }
      }
    },
    fluid_background =
    {
      filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
      priority = "extra-high",
      width = 32,
      height = 15
    },
    window_background =
    {
      filename = "__base__/graphics/entity/storage-tank/window-background.png",
      priority = "extra-high",
      width = 17,
      height = 24,
      hr_version =
      {
        filename = "__base__/graphics/entity/storage-tank/hr-window-background.png",
        priority = "extra-high",
        width = 34,
        height = 48,
        scale = 0.5
      }
    },
    flow_sprite =
    {
      filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
      priority = "extra-high",
      width = 160,
      height = 20
    },
    gas_flow =
    {
      filename = "__base__/graphics/entity/pipe/steam.png",
      priority = "extra-high",
      line_length = 10,
      width = 24,
      height = 15,
      frame_count = 60,
      axially_symmetrical = false,
      direction_count = 1,
      animation_speed = 0.25,
      hr_version =
      {
        filename = "__base__/graphics/entity/pipe/hr-steam.png",
        priority = "extra-high",
        line_length = 10,
        width = 48,
        height = 30,
        frame_count = 60,
        axially_symmetrical = false,
        animation_speed = 0.25,
        direction_count = 1,
        scale = 0.5
      }
    }
  },
  flow_length_in_ticks = 360,
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  working_sound =
  {
    sound =
    {
        filename = "__base__/sound/storage-tank.ogg",
        volume = 0.8
    },
    match_volume_to_activity = true,
    apparent_volume = 1.5,
    max_sounds_per_type = 3
  },
  circuit_wire_connection_points = circuit_connector_definitions["storage-tank"].points,
  circuit_connector_sprites = circuit_connector_definitions["storage-tank"].sprites,
  circuit_wire_max_distance = default_circuit_wire_max_distance
}
booster.name = data_util.mod_prefix .. "spaceship-rocket-booster-tank"
booster.minable.result =  data_util.mod_prefix .. "spaceship-rocket-booster-tank"
booster.collision_mask = {
  "water-tile",
  "ground-tile",
  "item-layer",
  "object-layer",
  "player-layer",
}
booster.rotatable = false
booster.collision_box = { {-1.3, -1.1}, {1.3, 1.3} }
booster.fluid_box = {
  filter = data_util.mod_prefix .. "liquid-rocket-fuel",
  base_area = 1000,
  pipe_connections = {
    { position = { 0, -2 } },
    { position = { 2, 0 } },
    { position = { -2, 0 } },
    { position = { 0, 2 } },
  },
  pipe_covers = pipecoverspictures(),
  secondary_draw_orders = { north = -1 }
}
booster.icon = "__space-exploration-graphics__/graphics/icons/spaceship-rocket-booster-tank.png"
booster.drawing_box = { {-1.5, -2.5}, {1.5, 1.5} }
booster.window_bounding_box = {
  util.by_pixel(40/2, -32/2),
  util.by_pixel(72/2, 64/2)
}
booster.pictures = {
  flow_sprite = {
    filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
    height = 20,
    priority = "extra-high",
    width = 160,
    --shift = util.by_pixel(56/2, 16/2),
  },
  fluid_background = {
    filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
    height = 15,
    priority = "extra-high",
    width = 32,
    shift = util.by_pixel(-5, 0)
    --shift = util.by_pixel(56/2, 16/2),
  },
  gas_flow = {
    animation_speed = 0.25,
    axially_symmetrical = false,
    direction_count = 1,
    filename = "__base__/graphics/entity/pipe/steam.png",
    frame_count = 60,
    height = 15,
    line_length = 10,
    priority = "extra-high",
    width = 24,
    shift = util.by_pixel(-14, 2),
    hr_version = {
      animation_speed = 0.25,
      axially_symmetrical = false,
      direction_count = 1,
      filename = "__base__/graphics/entity/pipe/hr-steam.png",
      frame_count = 60,
      height = 30,
      line_length = 10,
      priority = "extra-high",
      width = 48,
      shift = util.by_pixel(-14, 2),
    },
  },
  picture = {
    sheets = {
      {
        filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-booster-tank/spaceship-rocket-booster-tank.png",
        frames = 1,
        height = 256/2,
        width = 192/2,
        priority = "extra-high",
        shift = util.by_pixel(0, -16),
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-booster-tank/hr-spaceship-rocket-booster-tank.png",
          frames = 1,
          height = 256,
          width = 192,
          priority = "extra-high",
          shift = util.by_pixel(0, -16),
          scale = 0.5,
        },
      },
      {
        draw_as_shadow = true,
        filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-booster-tank/spaceship-rocket-booster-tank-shadow.png",
        frames = 1,
        width = 262/2,
        height = 134/2,
        priority = "extra-high",
        shift = util.by_pixel(18, 14),
        hr_version = {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-booster-tank/hr-spaceship-rocket-booster-tank-shadow.png",
          frames = 1,
          width = 262,
          height = 134,
          priority = "extra-high",
          shift = util.by_pixel(18, 14),
          scale = 0.5,
        },
      }
    }
  },
  window_background = {
    filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-booster-tank/spaceship-rocket-booster-tank-background.png",
    priority = "extra-high",
    width = 32/2,
    height = 96/2,
    --shift = util.by_pixel(56/2, 16/2),
    hr_version = {
      filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-booster-tank/hr-spaceship-rocket-booster-tank-background.png",
      priority = "extra-high",
      width = 32,
      height = 96,
      --shift = util.by_pixel(56/2, 16/2),
      scale = 0.5,
    },
  }
}
local antimatter_booster = table.deepcopy(booster)
antimatter_booster.name = data_util.mod_prefix.."spaceship-antimatter-booster-tank"
antimatter_booster.minable.result =  data_util.mod_prefix .. "spaceship-antimatter-booster-tank"
data_util.replace_filenames_recursive(antimatter_booster.pictures, "rocket", "antimatter")
antimatter_booster.fluid_box = {
  filter = data_util.mod_prefix .. "antimatter-stream",
  base_area = 500,
  pipe_connections = {
    { position = { 0, -2 } },
    { position = { 2, 0 } },
    { position = { -2, 0 } },
    { position = { 0, 2 } },
  },
  pipe_covers = pipecoverspictures(),
  secondary_draw_orders = { north = -1 }
}
local console_horizontal =  {
  layers =
  {
    {
      filename = "__space-exploration-graphics__/graphics/entity/spaceship-console/spaceship-console-horizontal.png",
      priority = "high",
      width = 256,
      height = 256,
      frame_count = 1,
      line_length = 1,
      shift = util.by_pixel(0, -16+3),
      animation_speed = 1,
      scale = 0.5,
    },
    {
      draw_as_shadow = true,
      filename = "__space-exploration-graphics__/graphics/entity/spaceship-console/spaceship-console-shadow.png",
      priority = "high",
      width = 110,
      height = 74,
      frame_count = 1,
      line_length = 1,
      shift = util.by_pixel(75, 16+3),
      animation_speed = 1,
      scale = 0.5,
    },
  },
}
local function connection_sprites(offset)
  return {
    blue_led_light_offset = offset,
    led_blue = {
      filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04e-blue-LED-on-sequence.png",
      height = 60,
      priority = "low",
      shift = offset,
      width = 60,
      x = 60,
      y = 0
    },
    led_blue_off = {
      filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04f-blue-LED-off-sequence.png",
      height = 44,
      priority = "low",
      shift = offset,
      width = 46,
      x = 46,
      y = 0
    },
    led_green = {
      filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04h-green-LED-sequence.png",
      height = 46,
      priority = "low",
      shift = offset,
      width = 48,
      x = 48,
      y = 0
    },
    led_light = {
      intensity = 0.8,
      size = 0.9
    },
    led_red = {
      filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04i-red-LED-sequence.png",
      height = 46,
      priority = "low",
      shift = offset,
      width = 48,
      x = 48,
      y = 0
    },
    red_green_led_light_offset = offset,
  }
end

local console_connection_point_left = {
  wire = { red = {-92/64, -108/64},   green = {-102/64, -102/64}, },
  shadow = { red = {-92/64 + 1, 0.5},   green = {-102/64 + 1, 0.5}, },
}
local console_connection_point_right = {
  wire = { red = {92/64, -108/64},   green = {102/64, -102/64}, },
  shadow = { red = {92/64 + 1, 0.5},   green = {102/64 + 1, 0.5}, },
}
local output_connection_point = {
  wire = { red = {92/64-1.5, -108/64+1},   green = {102/64-1.5, -102/64+1}, },
  shadow = { red = {92/64-1.5 + 1, 0.5+1},   green = {102/64-1.5 + 1, 0.5+1}, },
}

data:extend({
  wall,
  gate,
  booster,
  antimatter_booster,
  {
    type = "accumulator",
    name = data_util.mod_prefix .. "spaceship-console",
    icon = "__space-exploration-graphics__/graphics/icons/spaceship-console.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = { mining_time = 1, result = data_util.mod_prefix .. "spaceship-console"},
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-1.6, -1.6}, {1.6, 1.6}},
    selection_box = {{-2, -2}, {2, 2}},
    drawing_box = {{-2, -2}, {2, 2}},
    resistances =
    {
      { type = "poison", percent = 100 },
      { type = "fire", percent = 80 },
      { type = "explosion", percent = 50 }
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound = {
      match_speed_to_activity = true,
      max_sounds_per_type = 2,
      sound = {
        filename = "__base__/sound/combinator.ogg",
        volume = 0.5
      }
    },
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
    },
    charge_animation = console_horizontal,
    picture = console_horizontal,
    charge_cooldown = 30,
    discharge_cooldown = 30,
    crafting_categories = {"spaceship-console"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "primary-input",
      input_flow_limit = "1001KW",
      buffer_capacity = "1J",
    },
    energy_usage = "1000kW",
    ingredient_count = 0,
    module_specification =
    {
      module_slots = 0
    },
    allowed_effects = {},
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.5, size = 8, shift = {0.0, 0.0}, color = {r = 0.7, g = 0.9, b = 1}}
      },
    },
    circuit_wire_max_distance = 10,
    circuit_wire_connection_point = console_connection_point_left,
  },
  {
      type = "constant-combinator",
      name = data_util.mod_prefix .. "spaceship-console-output",
      icon = "__space-exploration-graphics__/graphics/icons/spaceship-console.png",
      icon_size = 32,
      flags = {"placeable-player", "player-creation", "placeable-off-grid",	"not-rotatable", "not-deconstructable", "not-blueprintable"},
      order = "y",
      max_health = 500,
      corpse = "small-remnants",
      collision_box = {{-0.0, -0.0}, {0.0, 0.0}},
      collision_mask = {"not-colliding-with-itself"},
      selection_box = {{-0.5, -1}, {0.5, 1}},
      scale_info_icons = false,
      selectable_in_game = true,
      selection_priority = 150,
      item_slot_count = 10, -- speed, current_surface, target_surface, distance?
      sprites =
      {
          north = blank_image,
          east = blank_image,
          south = blank_image,
          west = blank_image
      },
      activity_led_sprites =
      {
          north = blank_image,
          east = blank_image,
          south = blank_image,
          west = blank_image
      },
      activity_led_light =
      {
          intensity = 0.8,
          size = 1,
      },
      activity_led_light_offsets =
      {
          {0, 0},
          {0, 0},
          {0, 0},
          {0, 0}
      },
      circuit_wire_connection_points =
      {
          output_connection_point,  output_connection_point,  output_connection_point,  output_connection_point,
      },
      circuit_wire_max_distance = 10
  },
  {
    type = "furnace",
    name = data_util.mod_prefix .. "spaceship-rocket-engine",
    icon = "__space-exploration-graphics__/graphics/icons/spaceship-rocket-engine.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation", "not-rotatable"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "spaceship-rocket-engine"},
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-1.45, -1.95}, {1.45, 1.95}},
    selection_box = {{-1.45, -1.95}, {1.45, 1.95}},
    drawing_box = {{-1.5, -3}, {1.5, 4}},
    resistances =
    {
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
        {
          filename = "__base__/sound/fight/flamethrower-mid.ogg",
          volume = 0.9
        },
      }
    },
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
    },
    always_draw_idle_animation = true,
    source_inventory_size = 0,
    result_inventory_size = 0,
    animation = {
      layers = {
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-engine/sr/rocket-engine-shadow.png",
          priority = "high",
          width = 302/2,
          height = 236/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(40, 24 + 16),
          animation_speed = 1,
          hr_version = {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-engine/hr/rocket-engine-shadow.png",
            priority = "high",
            width = 302,
            height = 236,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(40, 24 + 16),
            animation_speed = 1,
            scale = 0.5,
          }
        },
      },
    },
    idle_animation =  {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-engine/sr/rocket-engine-inactive.png",
          priority = "high",
          width = 256/2,
          height = 416/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(0, 24 + 16),
          animation_speed = 1,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-engine/hr/rocket-engine-inactive.png",
            priority = "high",
            width = 256,
            height = 416,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(0, 24 + 16),
            animation_speed = 1,
            scale = 0.5,
          }
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-engine/sr/rocket-engine-shadow.png",
          priority = "high",
          width = 302/2,
          height = 236/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(40, 24 + 16),
          animation_speed = 1,
          hr_version = {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-engine/hr/rocket-engine-shadow.png",
            priority = "high",
            width = 302,
            height = 236,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(40, 24 + 16),
            animation_speed = 1,
            scale = 0.5,
          }
        },
      },
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 0.1,
        base_level = -1,
        pipe_connections = {
          { type="input", position = {-1, -2.5} },
          { type="input", position = { 1, -2.5} }
        },
        secondary_draw_orders = { north = -1 }
      },
    },
    crafting_categories = {"spaceship-rocket-engine"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
      smoke = {
        {
          frequency = 10,
          name = "turbine-smoke",
          position = { 0, -2 },
          starting_frame_deviation = 60,
          starting_vertical_speed = 0.08
        }
      },
    },
    energy_usage = "100kW",
    ingredient_count = 0,
    module_specification =
    {
      module_slots = 0
    },
    allowed_effects = {},
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 1.2, size = 8, shift = {0.0, 3}, color = {r = 1, g = 0.7, b = 0.1}}
      },
      {
        animation =  {
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-engine/sr/rocket-engine-active.png",
          priority = "high",
          width = 256/2,
          height = 416/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(0, 24 + 16),
          animation_speed = 1,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/spaceship-rocket-engine/hr/rocket-engine-active.png",
            priority = "high",
            width = 256,
            height = 416,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(0, 24 + 16),
            animation_speed = 1,
            scale = 0.5,
          }
        },
      },
      smoke = {
        {
          frequency = 10,
          name = "turbine-smoke",
          position = { 0, -2 },
          starting_frame_deviation = 60,
          starting_vertical_speed = 0.08
        }
      },
    },
    smoke = {
      {
        frequency = 0.3125,
        name = "turbine-smoke",
        slow_down_factor = 1,
        starting_frame_deviation = 60,
        starting_vertical_speed = -0.08
      }
    },
    circuit_wire_max_distance = 10,
  },
  {
    type = "furnace",
    name = data_util.mod_prefix .. "spaceship-antimatter-engine",
    icon = "__space-exploration-graphics__/graphics/icons/spaceship-antimatter-engine.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation", "not-rotatable"},
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "spaceship-antimatter-engine"},
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-2.45, -2.95}, {2.45, 2.95}},
    selection_box = {{-2.45, -2.95}, {2.45, 2.95}},
    drawing_box = {{-2.5, -4}, {2.5, 4}},
    resistances =
    {
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
        {
          filename = "__base__/sound/fight/flamethrower-mid.ogg",
          volume = 0.9
        },
      }
    },
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
    },
    always_draw_idle_animation = true,
    source_inventory_size = 0,
    result_inventory_size = 0,
    animation = {
      layers = {
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-antimatter-engine/sr/antimatter-engine-shadow.png",
          priority = "high",
          width = 368/2,
          height = 474/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(40, 24 + 16),
          animation_speed = 1,
          hr_version = {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/spaceship-antimatter-engine/hr/antimatter-engine-shadow.png",
            priority = "high",
            width = 368,
            height = 474,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(40, 24 + 16),
            animation_speed = 1,
            scale = 0.5,
          }
        },
      },
    },
    idle_animation =  {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-antimatter-engine/sr/antimatter-engine-inactive.png",
          priority = "high",
          width = 384/2,
          height = 704/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(0, 76),
          animation_speed = 1,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/spaceship-antimatter-engine/hr/antimatter-engine-inactive.png",
            priority = "high",
            width = 384,
            height = 704,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(0, 76),
            animation_speed = 1,
            scale = 0.5,
          }
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-antimatter-engine/sr/antimatter-engine-shadow.png",
          priority = "high",
          width = 368/2,
          height = 474/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(40, 24 + 16),
          animation_speed = 1,
          hr_version = {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/spaceship-antimatter-engine/hr/antimatter-engine-shadow.png",
            priority = "high",
            width = 368,
            height = 474,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(40, 24 + 16),
            animation_speed = 1,
            scale = 0.5,
          }
        },
      },
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 0.1,
        base_level = -1,
        pipe_connections = {
          { type="input", position = {-1, -3.5} },
          { type="input", position = { 1, -3.5} }
        },
        secondary_draw_orders = { north = -1 }
      },
    },
    crafting_categories = {"spaceship-antimatter-engine"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4,
      smoke = {
        {
          frequency = 10,
          name = "turbine-smoke",
          position = { 0, -2 },
          starting_frame_deviation = 60,
          starting_vertical_speed = 0.08
        }
      },
    },
    energy_usage = "1000kW",
    ingredient_count = 0,
    module_specification =
    {
      module_slots = 0
    },
    allowed_effects = {},
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 1.3, size = 12, shift = {0.0, 3}, color = {r = 1, g = 0.1, b = 1}}
      },
      {
        animation =  {
          filename = "__space-exploration-graphics__/graphics/entity/spaceship-antimatter-engine/sr/antimatter-engine-active.png",
          priority = "high",
          width = 384/2,
          height = 704/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(0, 76),
          animation_speed = 1,
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/spaceship-antimatter-engine/hr/antimatter-engine-active.png",
            priority = "high",
            width = 384,
            height = 704,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(0, 76),
            animation_speed = 1,
            scale = 0.5,
          }
        },
      },
      smoke = {
        {
          frequency = 10,
          name = "turbine-smoke",
          position = { 0, -2 },
          starting_frame_deviation = 60,
          starting_vertical_speed = 0.08
        }
      },
    },
    smoke = {
      {
        frequency = 0.3125,
        name = "turbine-smoke",
        slow_down_factor = 1,
        starting_frame_deviation = 60,
        starting_vertical_speed = -0.08
      }
    },
    circuit_wire_max_distance = 10,
  },
})
