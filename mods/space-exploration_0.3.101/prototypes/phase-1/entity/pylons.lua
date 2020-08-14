local data_util = require("data_util")

local blank_image = {
  direction_count = 1,
  filename = "__space-exploration-graphics__/graphics/blank.png",
  width = 1,
  height = 1,
  frame_count = 1,
  line_length = 1,
  shift = { 0, 0 },
}
local collision_box = { { -0.65, -0.65 }, { 0.65, 0.65 } }
local selection_box = {{-1,-1},{1,1}}
local resistances = {
  { type = "fire", percent = 100 },
  { type = "electric", percent = 100 }
}
local collision_mask = {
  --"item-layer", -- stops player from dropping items on belts.
  "floor-layer",
  --"object-layer",
  "water-tile",
  "player-layer",
}
data:extend({
  {
    type = "electric-pole",
    name = data_util.mod_prefix .. "addon-power-pole",
    supply_area_distance = 0.4,
    collision_box = {{-0.2,-0.2},{0.2,0.2}},
    collision_mask = {"layer-13"}, -- walls block layer
    selection_box = {{-0.3,-0.3},{0.3,0.3}},
    selection_priority = 150,
    render_layer = "higher-object-above",
    connection_points = {
      {
        shadow = {
          copper = { 1.6-0.1, 0.1 },
          green = { 1.6-0.1, 0.1-0.3 },
          red = { 1.6-0.25, 0.1-0.2  }
        },
        wire = {
          copper = { 0+0.07, -1.2-0.2 },
          green = {  0+0.1, -1.2-0.4 },
          red = {  0-0.15, -1.2-0.3 }
        }
      },
    },
    corpse = "big-electric-pole-remnants",
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {
        { -0.5, -2.5 },
        { 0.5, 0.5 }
      },
      offsets = { { 0, 1 } },
      type = "create-entity"
    },
    drawing_box = { {-0.5,-1.5},{0.5,0.5} },
    dying_explosion = "big-electric-pole-explosion",
    fast_replaceable_group = data_util.mod_prefix .. "addon-power-pole",
    flags = {
      "placeable-neutral",
      "player-creation",
      "fast-replaceable-no-build-while-moving",
      "placeable-off-grid"
    },
    icon = "__space-exploration-graphics__/graphics/icons/addon-power-pole.png",
    icon_mipmaps = 1,
    icon_size = 64,
    max_health = 500,
    maximum_wire_distance = 9,
    minable = { mining_time = 0.1, result = data_util.mod_prefix .. "addon-power-pole" },
    pictures = {
      layers = {
        data_util.auto_sr_hr({
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/addon-power-pole/hr/addon-power-pole.png",
          width = 64,
          height = 128,
          shift = { 0, -0.75 },
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/addon-power-pole/hr/addon-power-pole-shadow.png",
          width = 128,
          height = 64,
          shift = { 0.75, 0 },
          scale = 0.5,
        }),
      }
    },
    radius_visualisation_picture = {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      height = 12,
      priority = "extra-high-no-scale",
      width = 12
    },
    resistances = resistances,
    vehicle_impact_sound = {
      {filename = "__base__/sound/car-metal-impact.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-2.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-3.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-4.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-5.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-6.ogg",volume = 0.5}
    },
    water_reflection = {
      orientation_to_variation = false,
      pictures = {
        filename = "__base__/graphics/entity/big-electric-pole/big-electric-pole-reflection.png",
        height = 32,
        priority = "extra-high",
        scale = 5,
        shift = {0,1.875},
        variation_count = 1,
        width = 16
      },
      rotate = false
    },
  },
  {
    type = "electric-pole",
    name = data_util.mod_prefix .. "pylon",
    supply_area_distance = 2,
    collision_box = collision_box,
    collision_mask = collision_mask,
    selection_box = selection_box,
    connection_points = {
      {
        shadow = {
          copper = { 1.1-0.1, 0.1 },
          green = { 1.1+0.1, 0.1-0.4 },
          red = { 1.1-0.15, 0.1-0.3  }
        },
        wire = {
          copper = { 0+0.1, -2.3-0.2 },
          green = {  0+0.2, -2.3-0.5 },
          red = {  0-0.25, -2.3-0.4 }
        }
      },
    },
    corpse = "big-electric-pole-remnants",
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {
        { -0.5, -2.5 },
        { 0.5, 0.5 }
      },
      offsets = { { 0, 1 } },
      type = "create-entity"
    },
    drawing_box = { {-1,-3},{1,0.5} },
    dying_explosion = "big-electric-pole-explosion",
    fast_replaceable_group = data_util.mod_prefix .. "pylon",
    flags = {
      "placeable-neutral",
      "player-creation",
      "fast-replaceable-no-build-while-moving"
    },
    icon = "__space-exploration-graphics__/graphics/icons/pylon.png",
    icon_mipmaps = 1,
    icon_size = 64,
    max_health = 500,
    maximum_wire_distance = 64,
    minable = { mining_time = 0.1, result = data_util.mod_prefix .. "pylon" },
    pictures = {
      layers = {
        data_util.auto_sr_hr({
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/pylon/hr/pylon.png",
          width = 128,
          height = 256,
          shift = { 0, -1.25 },
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/pylon/hr/pylon-shadow.png",
          width = 192,
          height = 128,
          shift = { 0.5, 0 },
          scale = 0.5,
        }),
      }
    },
    radius_visualisation_picture = {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      height = 12,
      priority = "extra-high-no-scale",
      width = 12
    },
    resistances = resistances,
    vehicle_impact_sound = {
      {filename = "__base__/sound/car-metal-impact.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-2.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-3.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-4.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-5.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-6.ogg",volume = 0.5}
    },
    water_reflection = {
      orientation_to_variation = false,
      pictures = {
        filename = "__base__/graphics/entity/big-electric-pole/big-electric-pole-reflection.png",
        height = 32,
        priority = "extra-high",
        scale = 5,
        shift = {0,1.875},
        variation_count = 1,
        width = 16
      },
      rotate = false
    },
  },
  {
    type = "electric-pole",
    name = data_util.mod_prefix .. "pylon-substation",
    supply_area_distance = 32,
    collision_box = collision_box,
    collision_mask = collision_mask,
    selection_box = selection_box,
    connection_points = {
      {
        shadow = {
          copper = { 1.1-0.1, 0.1 },
          green = { 1.1+0.1, 0.1-0.4 },
          red = { 1.1-0.15, 0.1-0.3  }
        },
        wire = {
          copper = { 0+0.1, -2.3-0.2 },
          green = {  0+0.2, -2.3-0.5 },
          red = {  0-0.25, -2.3-0.4 }
        }
      },
    },
    corpse = "big-electric-pole-remnants",
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {
        { -0.5, -2.5 },
        { 0.5, 0.5 }
      },
      offsets = { { 0, 1 } },
      type = "create-entity"
    },
    drawing_box = { {-1,-3},{1,0.5} },
    dying_explosion = "big-electric-pole-explosion",
    fast_replaceable_group = data_util.mod_prefix .. "pylon",
    flags = {
      "placeable-neutral",
      "player-creation",
      "fast-replaceable-no-build-while-moving"
    },
    icon = "__space-exploration-graphics__/graphics/icons/pylon-substation.png",
    icon_mipmaps = 1,
    icon_size = 64,
    max_health = 500,
    maximum_wire_distance = 64,
    minable = { mining_time = 0.1, result = data_util.mod_prefix .. "pylon-substation" },
    pictures = {
      layers = {
        data_util.auto_sr_hr({
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/pylon-substation/hr/pylon-substation.png",
          width = 128,
          height = 256,
          shift = { 0, -1.25 },
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/pylon-substation/hr/pylon-substation-shadow.png",
          width = 192,
          height = 128,
          shift = { 0.5, 0 },
          scale = 0.5,
        }),
      }
    },
    radius_visualisation_picture = {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      height = 12,
      priority = "extra-high-no-scale",
      width = 12
    },
    resistances = resistances,
    vehicle_impact_sound = {
      {filename = "__base__/sound/car-metal-impact.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-2.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-3.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-4.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-5.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-6.ogg",volume = 0.5}
    },
    water_reflection = {
      orientation_to_variation = false,
      pictures = {
        filename = "__base__/graphics/entity/big-electric-pole/big-electric-pole-reflection.png",
        height = 32,
        priority = "extra-high",
        scale = 5,
        shift = {0,1.875},
        variation_count = 1,
        width = 16
      },
      rotate = false
    },
  },
  {
    type = "electric-pole",
    name = data_util.mod_prefix .. "pylon-construction",
    placeable_by = {item = data_util.mod_prefix .. "pylon-construction", count=1},
    minable = {
      mining_time = 0.1,
      result = data_util.mod_prefix .. "pylon-construction"
    },
    supply_area_distance = 2,
    collision_mask = {"not-colliding-with-itself"},
    collision_box = collision_box,
    selection_box = selection_box,
    connection_points = {
      {
        shadow = {
          copper = { 1.1-0.1+0.1, 0.1 },
          green = { 1.1+0.1, 0.1-0.4 },
          red = { 1.1-0.15, 0.1-0.3  }
        },
        wire = {
          copper = { 0+0.1+0.1, -2.3-0.2+0.3},
          green = {  0+0.2+0.1, -2.3-0.5 },
          red = {  0-0.25-0.3, -2.3-0.4+0.1 }
        }
      },
    },
    corpse = "big-electric-pole-remnants",
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {
        { -0.5, -2.5 },
        { 0.5, 0.5 }
      },
      offsets = { { 0, 1 } },
      type = "create-entity"
    },
    drawing_box = { {-1,-3},{1,0.5} },
    dying_explosion = "big-electric-pole-explosion",
    flags = {
      "placeable-neutral",
      "not-blueprintable",
      "not-deconstructable"
    },
    icon = "__space-exploration-graphics__/graphics/icons/pylon-construction.png",
    icon_mipmaps = 1,
    icon_size = 64,
    max_health = 500,
    maximum_wire_distance = 64,
    pictures = {
      layers = {
        blank_image
      }
    },
    radius_visualisation_picture = {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      height = 12,
      priority = "extra-high-no-scale",
      width = 12
    },
    resistances = resistances,
    vehicle_impact_sound = {
      {filename = "__base__/sound/car-metal-impact.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-2.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-3.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-4.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-5.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-6.ogg",volume = 0.5}
    },
    water_reflection = {
      orientation_to_variation = false,
      pictures = {
        filename = "__base__/graphics/entity/big-electric-pole/big-electric-pole-reflection.png",
        height = 32,
        priority = "extra-high",
        scale = 5,
        shift = {0,1.875},
        variation_count = 1,
        width = 16
      },
      rotate = false
    },
  },
  {
    type = "roboport",
    name = data_util.mod_prefix .. "pylon-construction-roboport",
    placeable_by = {item = data_util.mod_prefix .. "pylon-construction", count=1},
    selectable_in_game = false,
    minable = {
      mining_time = 0.1,
      result = data_util.mod_prefix .. "pylon-construction"
    },
    logistics_radius = 0,
    logistics_connection_distance = 32,
    material_slots_count = 0,
    robot_slots_count = 0,
    construction_radius = 32,
    icon = "__space-exploration-graphics__/graphics/icons/pylon-construction.png",
    icon_mipmaps = 1,
    icon_size = 64,
    fast_replaceable_group = data_util.mod_prefix .. "pylon",
    base = blank_image,
    base_animation = {
      layers = {
        data_util.auto_sr_hr({
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/pylon-construction/hr/pylon-construction.png",
          width = 128,
          height = 256,
          frame_count = 32,
          shift = { 0, -1.25 },
          scale = 0.5,
          line_length = 16,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/pylon-construction/hr/pylon-construction-shadow.png",
          width = 192,
          height = 128,
          frame_count = 32,
          shift = { 0.5, 0 },
          scale = 0.5,
          line_length = 2,
        }),
      }
    },
    base_patch = blank_image,
    charge_approach_distance = 5,
    charging_energy = "10MW",
    charging_offsets = {
      settings.startup["se-pylon-charge-points"].value and {0, 1.5} or nil
    },
    circuit_connector_sprites = nil,
    circuit_wire_connection_point = nil,
    circuit_wire_max_distance = 0,
    collision_box = collision_box,
    collision_mask = collision_mask,
    selection_box = selection_box,
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
      buffer_capacity = "100MJ",
      input_flow_limit = "1MW",
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "10kW",
    flags = {
      "placeable-neutral",
      "player-creation",
      "fast-replaceable-no-build-while-moving"
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
    resistances = resistances,
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
  {
    type = "electric-pole",
    name = data_util.mod_prefix .. "pylon-construction-radar",
    placeable_by = {item = data_util.mod_prefix .. "pylon-construction-radar", count=1},
    minable = {
      mining_time = 0.1,
      result = data_util.mod_prefix .. "pylon-construction-radar"
    },
    collision_mask = {"not-colliding-with-itself"},
    supply_area_distance = 32,
    collision_box = collision_box,
    selection_box = selection_box,
    connection_points = {
      {
        shadow = {
          copper = { 1.1-0.1+0.1, 0.1 },
          green = { 1.1+0.1, 0.1-0.4 },
          red = { 1.1-0.15, 0.1-0.3  }
        },
        wire = {
          copper = { 0+0.1+0.1, -2.3-0.2+0.3},
          green = {  0+0.2+0.1, -2.3-0.5 },
          red = {  0-0.25-0.3, -2.3-0.4+0.1 }
        }
      },
    },
    corpse = "big-electric-pole-remnants",
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {
        { -0.5, -2.5 },
        { 0.5, 0.5 }
      },
      offsets = { { 0, 1 } },
      type = "create-entity"
    },
    drawing_box = { {-1,-3},{1,0.5} },
    dying_explosion = "big-electric-pole-explosion",
    flags = {
      "placeable-neutral",
      "not-blueprintable",
      "not-deconstructable"
    },
    icon = "__space-exploration-graphics__/graphics/icons/pylon-construction-radar.png",
    icon_mipmaps = 1,
    icon_size = 64,
    max_health = 500,
    maximum_wire_distance = 64,
    pictures = {
      layers = {
        blank_image
      }
    },
    radius_visualisation_picture = {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      height = 12,
      priority = "extra-high-no-scale",
      width = 12
    },
    resistances = resistances,
    vehicle_impact_sound = {
      {filename = "__base__/sound/car-metal-impact.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-2.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-3.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-4.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-5.ogg",volume = 0.5},
      {filename = "__base__/sound/car-metal-impact-6.ogg",volume = 0.5}
    },
    water_reflection = {
      orientation_to_variation = false,
      pictures = {
        filename = "__base__/graphics/entity/big-electric-pole/big-electric-pole-reflection.png",
        height = 32,
        priority = "extra-high",
        scale = 5,
        shift = {0,1.875},
        variation_count = 1,
        width = 16
      },
      rotate = false
    },
  },
  {
    type = "roboport",
    name = data_util.mod_prefix .. "pylon-construction-radar-roboport",
    placeable_by = {item = data_util.mod_prefix .. "pylon-construction-radar", count=1},
    selectable_in_game = false,
    minable = {
      mining_time = 0.1,
      result = data_util.mod_prefix .. "pylon-construction-radar"
    },
    logistics_radius = 0,
    logistics_connection_distance = 32,
    material_slots_count = 0,
    robot_slots_count = 0,
    construction_radius = 128,
    icon = "__space-exploration-graphics__/graphics/icons/pylon-construction-radar.png",
    icon_mipmaps = 1,
    icon_size = 64,
    fast_replaceable_group = data_util.mod_prefix .. "pylon",
    base = blank_image,
    base_animation = {
      layers = {
        data_util.auto_sr_hr({
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/pylon-construction-radar/hr/pylon-construction-radar.png",
          width = 128,
          height = 256,
          frame_count = 32,
          shift = { 0, -1.25 },
          scale = 0.5,
          line_length = 16,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          direction_count = 1,
          filename = "__space-exploration-hr-graphics__/graphics/entity/pylon-construction-radar/hr/pylon-construction-radar-shadow.png",
          width = 192,
          height = 128,
          frame_count = 32,
          shift = { 0.5, 0 },
          scale = 0.5,
          line_length = 2,
        }),
      }
    },
    base_patch = blank_image,
    charge_approach_distance = 5,
    charging_energy = "10MW",
    charging_offsets = {
      settings.startup["se-pylon-charge-points"].value and {0, 1.5} or nil
    },
    circuit_connector_sprites = nil,
    circuit_wire_connection_point = nil,
    circuit_wire_max_distance = 0,
    collision_box = collision_box,
    collision_mask = collision_mask,
    selection_box = selection_box,
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
      buffer_capacity = "100MJ",
      input_flow_limit = "1MW",
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "100kW",
    flags = {
      "placeable-neutral",
      "player-creation",
      "fast-replaceable-no-build-while-moving"
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
    resistances = resistances,
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
  {
    type = "radar",
    name = data_util.mod_prefix .. "pylon-construction-radar-radar",
    placeable_by = {item = data_util.mod_prefix .. "pylon-construction-radar", count=1},
    selectable_in_game = false,
    max_distance_of_nearby_sector_revealed = 5,
    max_distance_of_sector_revealed = 5,
    collision_box = collision_box,
    selection_box = selection_box,
    collision_mask = {"not-colliding-with-itself"},
    corpse = "radar-remnants",
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {{-0.5,-0.5},{0.5,0.5}},
      offsets = {{0,1}},
      type = "create-entity"
    },
    dying_explosion = "radar-explosion",
    energy_per_nearby_scan = "10MJ",
    energy_per_sector = "10MJ",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "1MW",
    flags = {
      "placeable-neutral",
      "not-blueprintable",
      "not-deconstructable"
    },
    icon = "__space-exploration-graphics__/graphics/icons/pylon-construction-radar.png",
    icon_mipmaps = 1,
    icon_size = 64,
    max_health = 500,
    pictures = {
      layers = {
        blank_image
      }
    },
    radius_minimap_visualisation_color = {
      a = 0.275,
      b = 0.235,
      g = 0.092,
      r = 0.059
    },
    resistances = resistances,
    rotation_speed = 0.01,
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
    working_sound = {
      apparent_volume = 2,
      sound = {
        {
          filename = "__base__/sound/radar.ogg"
        }
      }
    }
  }

})
