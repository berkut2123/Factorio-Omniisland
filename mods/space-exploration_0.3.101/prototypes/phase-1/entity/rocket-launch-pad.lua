--[[
The plan:
While sile is in assembly mode a vehicle with a filter
is placed over the silo that only takes rocket segments.
also, rocket segments are taken from the container if any.
once the rocket is complete the vehicle is removed so items
are placed in the silo and not the vehicle.

new rocket doors are 168 up on hr image
]]--
local data_util = require("data_util")

local silo_offset_px = -37
--local shadow_adds_width = 192;
local shadow_adds_width = 96;
local blank_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
}
local selectable = false -- false for production, true only to help debug layers
local launch_pad_collision_box = {{-4.85, -4.85}, {4.85, 4.85}}
local launch_pad_settings = table.deepcopy(data.raw["programmable-speaker"][data_util.mod_prefix .. "struct-settings-string"])
launch_pad_settings.name = data_util.mod_prefix .. "rocket-launch-pad-settings"
launch_pad_settings.collision_box = launch_pad_collision_box

local connection_point = {
  wire = { red = {-1 -8/32, 2 +20/32},   green = {-1 -2/32, 2 +20/32}, },
  shadow = { red = {2 -8/32, 5}, green = {2 -2/32, 5}, },
}
local tank_connection_point = table.deepcopy(connection_point)
tank_connection_point.wire.red[2] = connection_point.wire.red[2] - 1
tank_connection_point.wire.green[2] = connection_point.wire.green[2] - 1
tank_connection_point.shadow.red[2] = connection_point.shadow.red[2] - 1
tank_connection_point.shadow.green[2] = connection_point.shadow.green[2] - 1

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

--local container_connection_sprites = connection_sprites({ 3-12/32, 0 })
local tank_connection_sprites = connection_sprites({ -97/32, -153/32 })

data:extend({
  launch_pad_settings,
  {
      type = "container",
      name = data_util.mod_prefix .. "rocket-launch-pad", -- "rocket-launch-pad-chest",
      icon = "__space-exploration-graphics__/graphics/icons/rocket-launch-pad.png",
      icon_size = 32,
      scale_info_icons = false,
      inventory_size = rocket_capacity,
      order = "z-z",
      flags = {"placeable-neutral", "player-creation"},
      minable = {mining_time = 0.5, result = data_util.mod_prefix .. "rocket-launch-pad"},
      max_health = 8000,
      corpse = "big-remnants",
      dying_explosion = "medium-explosion",
      collision_box = launch_pad_collision_box,
      collision_mask = {
        "water-tile",
        "item-layer",
        "object-layer",
        "player-layer",
        spaceship_collision_layer -- not spaceship
      },
      render_layer = "transport-belt", -- does not work
      selection_box = launch_pad_collision_box,
      selection_priority = 100,
      resistances = {
        { type = "meteor", percent = 90 },
        { type = "impact", percent = 100 },
        { type = "fire", percent = 100 }
      },
      open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
      close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
      vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
      picture = {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/complete.png",
          shift = { 0, -0.25 },
          width = 704/2,
          height = 736/2,
          hr_version = {
              filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-complete.png",
              shift = { 0, -0.25 },
              width = 704,
              height = 736,
              scale = 0.5,
          }
      },
      --circuit_connector_sprites = container_connection_sprites, -- these are not seen because of layering
      circuit_wire_connection_point = connection_point,
      circuit_wire_max_distance = 12.5,
  },
  { -- invisibly dummy vehicle
      type = "car",
      name = data_util.mod_prefix .. "rocket-launch-pad-_-section-input",
      collision_box = {{-3.85, -3.85}, {3.85, 3.85}},
      collision_mask = {"not-colliding-with-itself"},
      selection_box = launch_pad_collision_box,
      scale_info_icons = false,
      selection_priority = 200,
      selectable_in_game = selectable,
      has_belt_immunity = true,
      animation = {
        layers = {
          {
            animation_speed = 1,
            direction_count = 1,
            filename = "__space-exploration-graphics__/graphics/blank.png",
            frame_count = 1,
            height = 1,
            width = 1
          },
        }
      },
      braking_power = "200kW",
      burner = {
        effectivity = 1,
        fuel_category = "chemical",
        fuel_inventory_size = 0,
        render_no_power_icon = false
      },
      consumption = "1W",
      effectivity = 0.5,
      energy_per_hit_point = 1,
      flags = { "placeable-neutral", "player-creation", "placeable-off-grid" },
      friction = 0.9,
      icon = "__space-exploration-graphics__/graphics/icons/rocket-launch-pad.png",
      icon_size = 32,
      inventory_size = 2,
      max_health = 45000,
      open_sound = {
        filename = "__base__/sound/car-door-open.ogg",
        volume = 0.7
      },
      close_sound = {
        filename = "__base__/sound/car-door-close.ogg",
        volume = 0.7
      },
      render_layer = "object",
      rotation_speed = 0.00,
      order = "zz",
      weight = 10000,
  },
  {
      type = "constant-combinator",
      name = data_util.mod_prefix .. "rocket-launch-pad-combinator",
      icon = "__space-exploration-graphics__/graphics/icons/rocket-launch-pad.png",
      icon_size = 32,
      flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-deconstructable", "not-blueprintable"},
      order = "y",
      max_health = 10000,
      healing_per_tick = 10000,
      corpse = "small-remnants",
      collision_box = {{-0.0, -0.0}, {0.0, 0.0}},
      collision_mask = {"not-colliding-with-itself"},
      selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
      scale_info_icons = false,
      selectable_in_game = selectable,
      item_slot_count = 10, -- capsule, rocket parts, fuel, rocket made, slots free
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
          connection_point,  connection_point,  connection_point,  connection_point,
      },
      circuit_wire_max_distance = 10
  },
  { -- invisibly dummy vehicle
    -- allows player to enter and go with a rocket
      type = "car",
      name = data_util.mod_prefix .. "rocket-launch-pad-_-seat",
      collision_mask = {"not-colliding-with-itself"},
      collision_box = { { -0.4, -0.05 }, { 0.4, 0.05 } },
      collision_mask = {"not-colliding-with-itself"},
      has_belt_immunity = true,
      animation = {
        layers = {
          {
            animation_speed = 1,
            direction_count = 1,
            filename = "__space-exploration-graphics__/graphics/blank.png",
            frame_count = 1,
            height = 1,
            width = 1
          },
        }
      },
      braking_power = "200kW",
      burner = {
        effectivity = 1,
        fuel_category = "chemical",
        fuel_inventory_size = 0,
        render_no_power_icon = false
      },
      consumption = "150kW",
      effectivity = 0.5,
      energy_per_hit_point = 1,
      flags = { "placeable-neutral", "player-creation", "placeable-off-grid" },
      friction = 0.9,
      icon = "__space-exploration-graphics__/graphics/icons/rocket-launch-pad.png",
      icon_size = 32,
      inventory_size = 0,
      max_health = 45000,
      open_sound = {
        filename = "__base__/sound/car-door-open.ogg",
        volume = 0.7
      },
      close_sound = {
        filename = "__base__/sound/car-door-close.ogg",
        volume = 0.7
      },
      render_layer = "object",
      rotation_speed = 0.00,
      order = "zz",
      selectable_in_game = selectable,
      weight = 700,
  },
  {
    type = "storage-tank",
    name = data_util.mod_prefix .. "rocket-launch-pad-tank",
    icon = "__space-exploration-graphics__/graphics/icons/rocket-launch-pad.png",
    icon_size = 32,
    scale_info_icons = false,
    render_layer = "higher-object-above",
    flags = {"placeable-player", "player-creation", "not-deconstructable", "not-blueprintable"},
    max_health = 50000,
    order = "zz",
    corpse = "medium-remnants",
    collision_box = { -- compensate for position shift
      {launch_pad_collision_box[1][1], launch_pad_collision_box[1][2] -1},
      {launch_pad_collision_box[2][1], launch_pad_collision_box[2][2] -1}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = { -- compensate for position shift
      {launch_pad_collision_box[1][1], launch_pad_collision_box[1][2] -1},
      {launch_pad_collision_box[2][1], launch_pad_collision_box[2][2] -1}},
    selectable_in_game = selectable,
    fluid_box =
    {
      base_area = 100, -- gets multiplied by 100 by engine
      base_level = -1, -- pull fluid in
      height = 1.1,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { position = {-5.5, 3.5-1} },
        { position = {-5.5, -3.5-1} },
        { position = {3.5, -5.5-1} },
        { position = {-3.5, -5.5-1} },
        { position = {5.5, 3.5-1} },
        { position = {5.5, -3.5-1} },
        { position = {3.5, 5.5-1} },
        { position = {-3.5, 5.5-1} },
      },
    },
    two_direction_only = true,
    window_bounding_box = {{-0.125, 0.6875}, {0.1875, 1.1875}},
    pictures =
    {
      picture = {
        sheets = {
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/tank-window.png",
            priority = "extra-high",
            frames = 1,
            width = 94/2,
            height = 84/2,
            shift = {128.5/32, -154/32},
            hr_version = {
                filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-tank-window.png",
                priority = "extra-high",
                frames = 1,
                width = 94,
                height = 84,
                shift = {128.5/32, -154/32},
                scale=0.5,
              },
          },
        }
      },
      fluid_background =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/fluid-background.png",
        priority = "extra-high",
        width = 10,
        height = 30,
        shift = {128/32, -180/32},
        scale = 2
      },
      window_background = blank_image,
      --[[{
        filename = "__base__/graphics/entity/storage-tank/window-background.png",
        priority = "extra-high",
        width = 17,
        height = 24,
        shift = {-116/32, -160/32},
        hr_version = {
          filename = "__base__/graphics/entity/storage-tank/hr-window-background.png",
          priority = "extra-high",
          width = 34,
          height = 48,
          scale = 0.5,
          shift = {-116/32, -160/32},
        }
      },]]--
      flow_sprite =
      {
        filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
        priority = "extra-high",
        width = 160,
        height = 20,
        shift = {128/32, -180/32},
        scale = 2
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
        animation_speed = 0.255,
        shift = {128/32, -180/32},
        hr_version =
        {
          filename = "__base__/graphics/entity/pipe/hr-steam.png",
          priority = "extra-high",
          line_length = 10,
          width = 48,
          height = 30,
          frame_count = 60,
          axially_symmetrical = false,
          animation_speed = 0.255,
          direction_count = 1,
          shift = {128/32, -180/32},
        }
      }
    },
    flow_length_in_ticks = 360,
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
          filename = "__base__/sound/storage-tank.ogg",
          volume = 0.8
      },
      apparent_volume = 1.5,
      max_sounds_per_type = 3
    },
    circuit_wire_connection_points = {
      tank_connection_point,  tank_connection_point,  tank_connection_point,  tank_connection_point,
    },
    circuit_connector_sprites = {tank_connection_sprites,tank_connection_sprites,tank_connection_sprites,tank_connection_sprites,},
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },

  {
    -- this only exists for the animation
    -- it won't be selectable or affected normally
    -- when ready to launch the required dummy item will be added
    -- then launch will be triggered by script
    type = "rocket-silo",
    name = data_util.mod_prefix .. "rocket-launch-pad-silo",
    rocket_entity = data_util.mod_prefix .. "cargo-rocket",
    fixed_recipe = data_util.mod_prefix .. "rocket-launch-pad-silo-dummy-recipe",
    fixed_recipe = data_util.mod_prefix .. "rocket-launch-pad-silo-dummy-recipe",
    rocket_entity = data_util.mod_prefix .. "cargo-rocket",
    order = "zz",
    icon = "__space-exploration-graphics__/graphics/icons/rocket-launch-pad.png",
    icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    selection_box = launch_pad_collision_box,
    selectable_in_game = selectable,
    -- collision box stops inserters from accessing container
    --collision_box = launch_pad_collision_box, -- for power
    collision_box = {{0,0},{0,0}},
    collision_mask = {"not-colliding-with-itself"},
    crafting_categories = {"rocket-building"},
    rocket_parts_required = 1,
    crafting_speed = 1,
    rocket_result_inventory_size = 0,
    module_specification = { module_slots = 0 },
    allowed_effects = {},
    show_recipe_icon = false,
    max_health = 8000,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    hole_clipping_box = { {-2.75, -1.15 + silo_offset_px/32}, {2.75, 2.25 + silo_offset_px/32} },
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 60
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    energy_source = {
      type = "void",
      usage_priority = "primary-input",
      render_no_power_icon = false
    },
    active_energy_usage = "1000KW",
    energy_usage = "1000KW",
    idle_energy_usage = "1000KW",
    lamp_energy_usage = "100KW",

    times_to_blink = 3,
    light_blinking_speed = 1 / (3 * 60),
    door_opening_speed = 1 / (4.25 * 60),
    silo_fade_out_start_distance = 9, --8,
    silo_fade_out_end_distance = 16, --15,

    base_engine_light =
    {
      intensity = 1,
      size = 25,
      shift = {0, 1.5 + silo_offset_px/32}
    },


    shadow_sprite =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/00-rocket-silo-shadow.png",
      priority = "medium",
      width = 304,
      height = 290,
      draw_as_shadow = true,
      slice = 2,
      shift = util.by_pixel(8, 2),
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-00-rocket-silo-shadow.png",
        priority = "medium",
        width = 612,
        height = 578,
        draw_as_shadow = true,
        slice = 2,
        shift = util.by_pixel(7, 2),
        scale = 0.5
      },
    },

    hole_sprite =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/01-rocket-silo-hole.png",
      width = 202,
      height = 136,
      shift = util.by_pixel(-6, 16 + silo_offset_px),
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-01-rocket-silo-hole.png",
        width = 400,
        height = 270,
        shift = util.by_pixel(-5, 16 + silo_offset_px),
        scale = 0.5
      }
    },
    hole_light_sprite =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/01-rocket-silo-hole-light.png",
      width = 202,
      height = 136,
      shift = util.by_pixel(-6, 16 + silo_offset_px),
      tint = {1,1,1,0},
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-01-rocket-silo-hole-light.png",
        width = 400,
        height = 270,
        shift = util.by_pixel(-5, 16 + silo_offset_px),
        tint = {1,1,1,0},
        scale = 0.5
      }
    },

    rocket_shadow_overlay_sprite =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/03-rocket-over-shadow-over-rocket.png",
      width = 212,
      height = 142,
      shift = util.by_pixel(-2, 22 + silo_offset_px),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-03-rocket-over-shadow-over-rocket.png",
        width = 426,
        height = 288,
        shift = util.by_pixel(-2, 21 + silo_offset_px),
        scale = 0.5
      }
    },
    rocket_glow_overlay_sprite =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/03-rocket-over-glow.png",
      blend_mode = "additive",
      width = 218,
      height = 222,
      shift = util.by_pixel(-4, 36 + silo_offset_px),
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-03-rocket-over-glow.png",
        blend_mode = "additive",
        width = 434,
        height = 446,
        shift = util.by_pixel(-3, 36 + silo_offset_px),
        scale = 0.5
      }
    },


    door_back_sprite =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/04-door-back.png",
      width = 158,
      height = 144,
      shift = util.by_pixel(36, 12 + silo_offset_px),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-04-door-back.png",
        width = 312,
        height = 286,
        shift = util.by_pixel(37, 12 + silo_offset_px),
        scale = 0.5
      }
    },
    door_back_open_offset = {1.8, -1.8 * 0.43299225},
    door_front_sprite =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/05-door-front.png",
      width = 166,
      height = 152,
      shift = util.by_pixel(-28, 32 + silo_offset_px),
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-05-door-front.png",
        width = 332,
        height = 300,
        shift = util.by_pixel(-28, 33 + silo_offset_px),
        scale = 0.5
      }
    },
    door_front_open_offset = {-1.8, 1.8 * 0.43299225},

    base_day_sprite =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/06-rocket-silo.png",
      width = 352,
      height = 368,
      shift = util.by_pixel(0, -8),
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-06-rocket-silo.png",
        width = 704,
        height = 736,
        shift = util.by_pixel(0, -8),
        scale = 0.5
      }
    },


    red_lights_back_sprites =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {1.34375, 0.28125-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {1.34375, 0.28125-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {2.3125, 0.9375-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {2.3125, 0.9375-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {2.65625, 1.90625-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {2.65625, 1.90625-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {-2.65625, 1.90625-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {-2.65625, 1.90625-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {-2.3125, 0.9375-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {-2.3125, 0.9375-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {-1.34375, 0.28125-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {-1.34375, 0.28125-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {0, 0-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {0, 0-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        }
      }
    },

    red_lights_front_sprites =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {2.3125, 2.8125-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {2.3125, 2.8125-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {1.34375, 3.40625-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {1.34375, 3.40625-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {0, 3.75-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {0, 3.75-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {-1.34375, 3.40625-1.375 + silo_offset_px/32},
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {0, 3.75-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        },
        {
          filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/red-light.png",
          width = 32,
          height = 32,
          shift = {-2.3125, 2.8125-1.375 + silo_offset_px/32},
          hr_version = {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/07-red-lights-back/hr-red-light.png",
            width = 32,
            height = 32,
            shift = {-2.3125, 2.8125-1.375 + silo_offset_px/32},
            scale = 0.5
          }
        }
      }
    },
    satellite_animation =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/15-rocket-silo-turbine.png",
      priority = "medium",
      width = 392/4/2,
      height = 288/8/2,
      frame_count = 32,
      line_length = 4,
      animation_speed = 0.4,
      shift = util.by_pixel(-114, -4),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-15-rocket-silo-turbine.png",
        priority = "medium",
        width = 392/4,
        height = 288/8,
        frame_count = 32,
        line_length = 4,
        animation_speed = 0.4,
        shift = util.by_pixel(-114, -4),
        scale = 0.5
      }
    },

    arm_01_back_animation =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/08-rocket-silo-arms-back.png",
      priority = "medium",
      width = 66,
      height = 76,
      frame_count = 32,
      line_length = 32,
      animation_speed = 0.3,
      shift = util.by_pixel(-54, -84 + silo_offset_px),
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-08-rocket-silo-arms-back.png",
        priority = "medium",
        width = 128,
        height = 150,
        frame_count = 32,
        line_length = 32,
        animation_speed = 0.3,
        shift = util.by_pixel(-53, -84 + silo_offset_px),
        scale = 0.5
      }
    },

    arm_02_right_animation =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/08-rocket-silo-arms-right.png",
      priority = "medium",
      width = 94,
      height = 94,
      frame_count = 32,
      line_length = 32,
      animation_speed = 0.3,
      shift = util.by_pixel(100, -38 + silo_offset_px),
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-08-rocket-silo-arms-right.png",
        priority = "medium",
        width = 182,
        height = 188,
        frame_count = 32,
        line_length = 32,
        animation_speed = 0.3,
        shift = util.by_pixel(101, -38 + silo_offset_px),
        scale = 0.5
      }
    },

    arm_03_front_animation =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/13-rocket-silo-arms-front.png",
      priority = "medium",
      width = 66,
      height = 114,
      frame_count = 32,
      line_length = 32,
      animation_speed = 0.3,
      shift = util.by_pixel(-52, 16 + silo_offset_px),
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-13-rocket-silo-arms-front.png",
        priority = "medium",
        width = 126,
        height = 228,
        frame_count = 32,
        line_length = 32,
        animation_speed = 0.3,
        shift = util.by_pixel(-51, 16 + silo_offset_px),
        scale = 0.5
      }
    },

    base_front_sprite =
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/14-rocket-silo-front.png",
      width = 704 / 2,
      height = 448 / 2,
      shift = util.by_pixel(0, 64),
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-14-rocket-silo-front.png",
        width = 704,
        height = 448,
        shift = util.by_pixel(0, 64),
        scale = 0.5
      }
    },

    alarm_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/silo-alarm.ogg",
            volume = 1.0
          }
        }
      }
    },
    clamps_on_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/silo-clamps-on.ogg",
            volume = 1.0
          }
        }
      }
    },
    clamps_off_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/silo-clamps-off.ogg",
            volume = 1.0
          }
        }
      }
    },
    doors_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/silo-doors.ogg",
            volume = 1.0
          }
        }
      }
    },
    raise_rocket_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/silo-raise-rocket.ogg",
            volume = 1.0
          }
        }
      }
    }
  },
})

data.raw["storage-tank"][data_util.mod_prefix .. "rocket-launch-pad-tank"].fluid_box.pipe_covers.north.layers={blank_image}
