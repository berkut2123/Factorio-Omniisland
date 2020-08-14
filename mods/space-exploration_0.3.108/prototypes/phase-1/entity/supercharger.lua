local data_util = require("data_util")

local blank_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
}
local charging_offsets = {}
local radius = 2
for i = 1, 64 do
  local a = i/64
  table.insert(charging_offsets, {math.sin(a * 2 * math.pi) * 0.75 * radius, -2 + math.cos(a * 2 * math.pi) * radius})
end

data:extend({
  {
    type = "roboport",
    name = data_util.mod_prefix .. "supercharger",
    logistics_radius = 32,
    logistics_connection_distance = 32,
    material_slots_count = 0,
    robot_slots_count = 0,
    construction_radius = 32,
    minable = {
      mining_time = 0.1,
      result = data_util.mod_prefix .. "supercharger"
    },
    icon = "__space-exploration-graphics__/graphics/icons/supercharger.png",
    icon_mipmaps = 1,
    icon_size = 64,
    base = {
      layers = {
        data_util.auto_sr_hr({
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/supercharger/hr/supercharger.png",
          width = 256,
          height = 320,
          frame_count = 1,
          shift = { 0, -0.5 },
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/supercharger/hr/supercharger-shadow.png",
          width = 298,
          height = 165,
          frame_count = 1,
          shift = { 0.3, 0.8 },
          scale = 0.5,
        }),
      }
    },
    base_animation = blank_image,
    base_patch = blank_image,
    charge_approach_distance = 5,
    charging_energy = "1GW",
    charging_offsets = charging_offsets,
    circuit_connector_sprites = nil,
    circuit_wire_connection_point = nil,
    circuit_wire_max_distance = 0,
    collision_box = { { -1.65, -1.65 }, { 1.65, 1.65 } },
    corpse = "roboport-remnants",
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {{-0.5,-0.5},{0.5,0.5}},
      offsets = {{0,1}},
      type = "create-entity"
    },
    door_animation_down = blank_image,
    door_animation_up = blank_image,
    draw_construction_radius_visualization = true,
    draw_logistic_radius_visualization = true,
    dying_explosion = "roboport-explosion",
    energy_source = {
      buffer_capacity = "1000MJ",
      input_flow_limit = "1GW",
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "100kW",
    flags = {
      "placeable-player",
      "player-creation"
    },
    max_health = 500,
    recharge_minimum = "40MJ",
    recharging_animation = {
      animation_speed = 0.5,
      filename = "__base__/graphics/entity/roboport/roboport-recharging.png",
      frame_count = 16,
      height = 35,
      priority = "high",
      scale = 1.5,
      width = 37
    },
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
      { type = "fire", percent = 100 },
      { type = "electric", percent = 100 }
    },
    selection_box = {{-2,-2},{2,2}},
    spawn_and_station_height = -0.1,
    stationing_offset = {0,0},
    vehicle_impact_sound = {
      {
        filename = "__base__/sound/car-metal-impact.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-2.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-3.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-4.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-5.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-6.ogg",
        volume = 0.5
      }
    },
    water_reflection = {
      orientation_to_variation = false,
      pictures = {
        filename = "__base__/graphics/entity/roboport/roboport-reflection.png",
        height = 28,
        priority = "extra-high",
        scale = 5,
        shift = {
          0,
          2.34375
        },
        variation_count = 1,
        width = 28
      },
      rotate = false
    },
    working_sound = {
      audible_distance_modifier = 0.5,
      max_sounds_per_type = 3,
      probability = 0.0033333333,
      sound = {
        filename = "__base__/sound/roboport-working.ogg",
        volume = 0.6
      }
    }
  },
})
