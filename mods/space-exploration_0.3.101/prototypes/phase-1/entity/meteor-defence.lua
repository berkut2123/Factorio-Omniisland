local data_util = require("data_util")

local blank_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    direction_count = 1,
    shift = { 0, 0 },
}

local selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } }
local collision_box = { { -4.3, -4.3 }, { 4.3, 4.3 } }

data:extend({
  {
    type = "ammo-turret",
    name = data_util.mod_prefix .. "meteor-defence-container",
    minable = {
      mining_time = 0.5,
      result = data_util.mod_prefix .. "meteor-defence"
    },
    alert_when_attacking = false,
    automated_ammo_count = 4,
    attack_parameters = {
      ammo_category = data_util.mod_prefix .. "meteor-defence",
      cooldown = 300,
      range = 1,
      type = "projectile"
    },
    base_picture_render_layer = "object",
    base_picture = {
      layers = {
        {
            filename = "__space-exploration-graphics__/graphics/entity/meteor-defence/meteor-defence.png",
            shift = { 0, -4.75 },
            width = 616/2,
            height = 1198/2,
            hr_version = data_util.hr({
                filename = "__space-exploration-hr-graphics__/graphics/entity/meteor-defence/hr-meteor-defence.png",
                shift = { 0, -4.75 },
                width = 616,
                height = 1198,
                scale = 0.5,
            })
        },
        {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/meteor-defence/meteor-defence-shadow.png",
            shift = { 2.5, 2/32 },
            width = 890/2,
            height = 578/2,
            hr_version = data_util.hr({
                draw_as_shadow = true,
                filename = "__space-exploration-hr-graphics__/graphics/entity/meteor-defence/hr-meteor-defence-shadow.png",
                shift = { 2.5, 2/32 },
                width = 890,
                height = 578,
                scale = 0.5,
            })
        }
      }
    },
    call_for_help_radius = 40,
    folded_animation = blank_image,
    collision_box = collision_box,
    drawing_box = { { -4.5, -4.5-9 }, { 4.5, 4.5 } },
    collision_mask = {
      "water-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer,
    },
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    flags = {"placeable-neutral", "player-creation"},
    icon = "__space-exploration-graphics__/graphics/icons/meteor-defence.png",
    icon_size = 64,
    order = "z-z",
    inventory_size = 1,
    max_health = 8000,
    resistances = {
      { type = "impact", percent = 100 },
      { type = "fire", percent = 100 }
    },
    open_sound = {
      filename = "__base__/sound/machine-open.ogg",
      volume = 0.85
    },
    close_sound = {
      filename = "__base__/sound/machine-close.ogg",
      volume = 0.75
    },
    rotation_speed = 0.015,
    selection_box = selection_box,
    selection_priority = 100,
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    }
  },
  {
    type = "roboport",
    name = data_util.mod_prefix .. "meteor-defence-charger",
    icon = "__space-exploration-graphics__/graphics/icons/meteor-defence.png",
    flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-deconstructable", "not-blueprintable"},
    icon_size = 64,
    order = "z-z",
    selectable_in_game = false,
    base = blank_image,
    base_animation = blank_image,
    base_patch = blank_image,
    charge_approach_distance = 0,
    charging_energy = "1000kW",
    charging_offsets = {},
    circuit_wire_connection_point = {
      shadow = {
        green = { 1.078125, 2.140625 },
        red = { 1.296875, 2.09375 }
      },
      wire = {
        green = { 0.9375, 1.5625 },
        red = { 0.875, 1.328125 }
      }
    },
    circuit_wire_max_distance = 0,
    close_door_trigger_effect = {
      {
        sound = {
          filename = "__base__/sound/roboport-door.ogg",
          volume = 0.75
        },
        type = "play-sound"
      }
    },
    selection_box = selection_box,
    collision_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
    collision_mask = {"not-colliding-with-itself"},
    construction_radius = 0,
    corpse = "big-remnants",
    default_available_construction_output_signal = {
      name = "signal-Z",
      type = "virtual"
    },
    default_available_logistic_output_signal = {
      name = "signal-X",
      type = "virtual"
    },
    default_total_construction_output_signal = {
      name = "signal-T",
      type = "virtual"
    },
    default_total_logistic_output_signal = {
      name = "signal-Y",
      type = "virtual"
    },
    door_animation_down = blank_image,
    door_animation_up = blank_image,
    draw_construction_radius_visualization = false,
    draw_logistic_radius_visualization = false,
    dying_explosion = "medium-explosion",
    energy_source = {
      buffer_capacity = "2000MJ",
      input_flow_limit = "20MW",
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "5MW",
    logistics_radius = 0,
    logistics_connection_distance = 0,
    material_slots_count = 0,
    max_health = 8000,
    open_door_trigger_effect = {
      {
        sound = {
          filename = "__base__/sound/roboport-door.ogg",
          volume = 1
        },
        type = "play-sound"
      }
    },
    recharge_minimum = "2000MJ",
    recharging_animation = blank_image,
    recharging_light = {
      color = {
        b = 1,
        g = 1,
        r = 1
      },
      intensity = 0.4,
      size = 5
    },
    request_to_open_door_timeout = 15,
    resistances = {
      {
        percent = 60,
        type = "fire"
      },
      {
        percent = 30,
        type = "impact"
      }
    },
    robot_slots_count = 0,
    spawn_and_station_height = -0.1,
    stationing_offset = {
      0,
      0
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    working_sound = {
      audible_distance_modifier = 0.5,
      max_sounds_per_type = 3,
      probability = 0.0033333333,
      sound = {
        filename = "__base__/sound/radar.ogg",
        volume = 0.6
      }
    }
  },
  {
    type = "explosion",
    name = data_util.mod_prefix .. "meteor-defence-beam",
    animations = {
      {
        filename = "__space-exploration-graphics__/graphics/entity/meteor-defence/meteor-defence-beam.png",
        frame_count = 6,
        height = 1,
        priority = "extra-high",
        width = 187
      }
    },
    beam = true,
    flags = { "not-on-map", "placeable-off-grid"},
    light = {
      color = {
        b = 0,
        g = 0,
        r = 1
      },
      intensity = 1,
      size = 20
    },
    rotate = true,
    smoke = "smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 1,
    sound = {
      {
        filename = "__base__/sound/fight/old/huge-explosion.ogg",
        volume = 1
      }
    },
  },
  {
    type = "ammo-turret",
    name = data_util.mod_prefix .. "meteor-point-defence-container",
    minable = {
      mining_time = 0.3,
      result =  data_util.mod_prefix .. "meteor-point-defence",
    },
    alert_when_attacking = false,
    automated_ammo_count = 4,
    attack_parameters = {
      ammo_category = data_util.mod_prefix .. "meteor-point-defence",
      cooldown = 300,
      range = 64,
      type = "projectile"
    },
    base_picture_render_layer = "object",
    base_picture = {
      layers = {
        {
            filename = "__space-exploration-graphics__/graphics/entity/meteor-point-defence/meteor-point-defence.png",
            shift = { 1/32, -1.5 },
            width = 206/2,
            height = 400/2,
            hr_version = data_util.hr({
                filename = "__space-exploration-hr-graphics__/graphics/entity/meteor-point-defence/hr-meteor-point-defence.png",
                shift = { 1/32, -1.5 },
                width = 206,
                height = 400,
                scale = 0.5,
            })
        },
        {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/meteor-point-defence/meteor-point-defence-shadow.png",
            shift = { 1.7, 0.6 },
            width = 408/2,
            height = 136/2,
            hr_version = data_util.hr({
                draw_as_shadow = true,
                filename = "__space-exploration-hr-graphics__/graphics/entity/meteor-point-defence/hr-meteor-point-defence-shadow.png",
                shift = { 1.7, 0.6 },
                width = 408,
                height = 136,
                scale = 0.5,
            })
        }
      }
    },
    call_for_help_radius = 40,
    folded_animation = blank_image,
    collision_box = { { -1.35, -1.35 }, { 1.35, 1.35 } },
    collision_mask = {
      "water-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer,
    },
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    flags = {"placeable-neutral", "player-creation"},
    icon = "__space-exploration-graphics__/graphics/icons/meteor-point-defence.png",
    icon_size = 64,
    order = "z-z",
    inventory_size = 1,
    max_health = 2000,
    resistances = {
      { type = "impact", percent = 100 },
      { type = "fire", percent = 100 }
    },
    open_sound = {
      filename = "__base__/sound/machine-open.ogg",
      volume = 0.85
    },
    close_sound = {
      filename = "__base__/sound/machine-close.ogg",
      volume = 0.75
    },
    rotation_speed = 0.015,
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    selection_priority = 100,
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    }
  },
  {
    type = "roboport",
    name = data_util.mod_prefix .. "meteor-point-defence-charger",
    icon = "__space-exploration-graphics__/graphics/icons/meteor-point-defence.png",
    flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-deconstructable", "not-blueprintable"},
    icon_size = 64,
    order = "z-z",
    selectable_in_game = false,
    base = blank_image,
    base_animation = blank_image,
    base_patch = blank_image,
    charge_approach_distance = 0,
    charging_energy = "10kW",
    charging_offsets = {},
    circuit_wire_connection_point = {
      shadow = {
        green = { 1.078125, 2.140625 },
        red = { 1.296875, 2.09375 }
      },
      wire = {
        green = { 0.9375, 1.5625 },
        red = { 0.875, 1.328125 }
      }
    },
    circuit_wire_max_distance = 0,
    close_door_trigger_effect = {
      {
        sound = {
          filename = "__base__/sound/roboport-door.ogg",
          volume = 0.75
        },
        type = "play-sound"
      }
    },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    collision_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    collision_mask = {"not-colliding-with-itself"},
    construction_radius = 0,
    corpse = "big-remnants",
    default_available_construction_output_signal = {
      name = "signal-Z",
      type = "virtual"
    },
    default_available_logistic_output_signal = {
      name = "signal-X",
      type = "virtual"
    },
    default_total_construction_output_signal = {
      name = "signal-T",
      type = "virtual"
    },
    default_total_logistic_output_signal = {
      name = "signal-Y",
      type = "virtual"
    },
    door_animation_down = blank_image,
    door_animation_up = blank_image,
    draw_construction_radius_visualization = false,
    draw_logistic_radius_visualization = false,
    dying_explosion = "medium-explosion",
    energy_source = {
      buffer_capacity = "200MJ",
      input_flow_limit = "2MW",
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "1MW",
    logistics_radius = 0,
    logistics_connection_distance = 0,
    material_slots_count = 0,
    max_health = 8000,
    open_door_trigger_effect = {
      {
        sound = {
          filename = "__base__/sound/roboport-door.ogg",
          volume = 1
        },
        type = "play-sound"
      }
    },
    recharge_minimum = "20MJ",
    recharging_animation = blank_image,
    recharging_light = {
      color = {
        b = 1,
        g = 1,
        r = 1
      },
      intensity = 0.4,
      size = 5
    },
    request_to_open_door_timeout = 15,
    resistances = {
      {
        percent = 60,
        type = "fire"
      },
      {
        percent = 30,
        type = "impact"
      }
    },
    robot_slots_count = 0,
    spawn_and_station_height = -0.1,
    stationing_offset = {
      0,
      0
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    working_sound = {
      audible_distance_modifier = 0.5,
      max_sounds_per_type = 3,
      probability = 0.0033333333,
      sound = {
        filename = "__base__/sound/radar.ogg",
        volume = 0.6
      }
    }
  },
  {
    type = "explosion",
    name = data_util.mod_prefix .. "meteor-point-defence-beam",
    animations = {
      {
        filename = "__space-exploration-graphics__/graphics/entity/meteor-point-defence/meteor-point-defence-beam.png",
        frame_count = 6,
        height = 1,
        priority = "extra-high",
        width = 576/6
      }
    },
    beam = true,
    flags = { "not-on-map", "placeable-off-grid"},
    light = {
      color = {
        b = 0.5,
        g = 0.95,
        r = 1
      },
      intensity = 1,
      size = 20
    },
    rotate = true,
    smoke = "smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 1,
    sound = {
      {
        filename = "__base__/sound/fight/heavy-gunshot-1.ogg",
        volume = 0.45
      },
      {
        filename = "__base__/sound/fight/heavy-gunshot-2.ogg",
        volume = 0.45
      },
      {
        filename = "__base__/sound/fight/heavy-gunshot-3.ogg",
        volume = 0.45
      },
      {
        filename = "__base__/sound/fight/heavy-gunshot-4.ogg",
        volume = 0.45
      }
    },
  },
})
