data:extend( --basicly copied roboport
{
  {
    type = "roboport",
    name = "logistic-beacon",
    icon = "__logtech-beacon__/graphics/icons/logistic-beacon.png",
	icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "logistic-beacon"},
    max_health = 180,
    corpse = "small-remnants",
	collision_box = {{-0.1, -0.1}, {0.1, 0.1}}, 
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	drawing_box = {{-1.0, -2.0}, {1.0, -0.5}}, --just a guess
    resistances =
    {
      {
        type = "fire",
        percent = 80
      },
      {
        type = "impact",
        percent = 40
      }
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "2MW",
      buffer_capacity = "5MJ", --do not change in running game
    },
    recharge_minimum = "5MJ",
    energy_usage = "10kW", --default energy draw, 1/5 of roboport
    -- per one charge slot
    charging_energy = "1000kW",
    logistics_radius = 12.5, --1/2 of Roboport. Its area, so actual area is 1/4 of roboport. 
    construction_radius = 30,
    charge_approach_distance = 5,
    robot_slots_count = 0,
    material_slots_count = 0,
    stationing_offset = {0, 0},
    charging_offsets =  {{-0.5, -0.5}, {0.5, -0.5}, {0.5, 0.5}, {-0.5, 0.5}},
    base =
    {
	layers = {
        {
          filename = "__logtech-beacon__/graphics/entity/logistic-beacon.png",
          priority = "extra-high",
          width = 30,
          height = 89,
          shift = util.by_pixel(-2, -39.5),
          hr_version = {
            filename = "__logtech-beacon__/graphics/entity/hr-logistic-beacon.png",
            priority = "extra-high",
            width = 59,
            height = 178,
            shift = util.by_pixel(-2.25, -39.5),
            scale = 0.5,
          }
        },
        {
          filename = "__logtech-beacon__/graphics/entity/logistic-beacon-shadow.png",
          priority = "extra-high",
          width = 119,
          height = 25,
          shift = util.by_pixel(52.5, -2.5),
          draw_as_shadow = true,
          hr_version = {
            filename = "__logtech-beacon__/graphics/entity/hr-logistic-beacon-shadow.png",
            priority = "extra-high",
            width = 237,
            height = 50,
            shift = util.by_pixel(52.75, -3),
            draw_as_shadow = true,
            scale = 0.5,
            }
         }
       }
	},
		
    base_patch = --empty, not shurte why it in roboport in the 1st place
    {
      filename = "__logtech-beacon__/graphics/entity/blank.png",
      priority = "low",
      width = 1,
      height = 1,
      frame_count = 1
    },
    base_animation = --no animation
    {
      filename = "__logtech-beacon__/graphics/entity/blank.png",
      priority = "low",
      width = 1,
      height = 1,
      frame_count = 1,
      animation_speed = 1
    },
    door_animation_up = --no doors
    {
      filename = "__logtech-beacon__/graphics/entity/blank.png",
      priority = "low",
      width = 1,
      height = 1,
      frame_count = 1,
      animation_speed = 1
    },
    door_animation_down =
    {
      filename = "__logtech-beacon__/graphics/entity/blank.png",
      priority = "low",
      width = 1,
      height = 1,
      frame_count = 1,
      animation_speed = 1
    },
    recharging_animation =
    {
      filename = "__base__/graphics/entity/roboport/roboport-recharging.png",
      priority = "high",
      width = 37,
      height = 35,
      frame_count = 16,
      scale = 1.5,
      animation_speed = 0.5
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = { filename = "__base__/sound/roboport-working.ogg", volume = 0.6 },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.5,
      probability = 1 / (5 * 60) -- average pause between the sound is 5 seconds
    },
    recharging_light = {intensity = 0.4, size = 5, color = {r = 1.0, g = 1.0, b = 1.0}},
    request_to_open_door_timeout = 15,
    spawn_and_station_height = -0.1,

    draw_logistic_radius_visualization = true,
    draw_construction_radius_visualization = true,
	
    circuit_wire_connection_point = circuit_connector_definitions["programmable-speaker"].points,
    circuit_connector_sprites = circuit_connector_definitions["programmable-speaker"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,
	
    default_available_logistic_output_signal = {type = "virtual", name = "signal-X"},
    default_total_logistic_output_signal = {type = "virtual", name = "signal-Y"},
    default_available_construction_output_signal = {type = "virtual", name = "signal-Z"},
    default_total_construction_output_signal = {type = "virtual", name = "signal-T"},
  },
})