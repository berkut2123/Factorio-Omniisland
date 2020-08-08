local robot_flame = table.deepcopy(data.raw.fire["fire-flame-on-tree"])
robot_flame.name = "robot-crash-flame"
robot_flame.damage_per_tick = {amount = 10 / 60, type = "fire"}
robot_flame.fade_in_duration = 10
robot_flame.fade_out_duration = 60
data:extend({
  robot_flame
})



data:extend({
  {
    type = "explosion",
    name = "robot-explosion",
    animations = {{
      filename = "__base__/graphics/entity/medium-explosion/medium-explosion.png",
      width = 112,
      height = 94,
      line_length = 6,
      frame_count = 54,
      animation_speed = 0.5,
      priority = "high",
      shift = { -0.56, -0.96 },
      scale = 0.75,
    }},
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "create-particle",
            particle_name = "explosion-remnants-particle",
            initial_height = 0.5,
            initial_vertical_speed = 0.082,
            initial_vertical_speed_deviation = 0.05,
            offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
            repeat_count = 3,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.05,
          },
          {
            frame_speed = 1,
            frame_speed_deviation = 0.361,
            initial_height = 0.1,
            initial_height_deviation = 0.5,
            initial_vertical_speed = 0.04,
            initial_vertical_speed_deviation = 0.05,
            offset_deviation = {
              {
                -0.5,
                -0.5
              },
              {
                0.5,
                0.5
              }
            },
            particle_name = "cable-and-electronics-particle-small-medium",
            repeat_count = 13,
            speed_from_center = 0.02,
            speed_from_center_deviation = 0.05,
            type = "create-particle"
          },
          {
            frame_speed = 1,
            frame_speed_deviation = 0.463,
            initial_height = 1.2,
            initial_height_deviation = 0.5,
            initial_vertical_speed = 0.08,
            initial_vertical_speed_deviation = 0.05,
            offset_deviation = {
              {
                -0.6953,
                -0.2969
              },
              {
                0.6953,
                0.2969
              }
            },
            particle_name = "logistic-robot-metal-particle-medium",
            repeat_count = 10,
            speed_from_center = 0.02,
            speed_from_center_deviation = 0.05,
            type = "create-particle"
          },
          {
            initial_height = 1.4,
            initial_height_deviation = 0.5,
            initial_vertical_speed = 0.082,
            initial_vertical_speed_deviation = 0.05,
            offset_deviation = {
              {
                -0.5938,
                -0.5977
              },
              {
                0.5938,
                0.5977
              }
            },
            particle_name = "logistic-robot-metal-particle-small",
            repeat_count = 20,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.05,
            type = "create-particle"
          },
          { type = "nested-result", action = { type = "area", radius = 0.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 40, type = "explosion" }}}},
          }},
          { type = "nested-result", action = { type = "area", radius = 1.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 20, type = "explosion" }}}},
          }},
          { type = "nested-result", action = { type = "area", radius = 2.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 10, type = "explosion" }}}},
          }},
          { type = "nested-result", action = { type = "area", radius = 3.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 5, type = "explosion" }}}},
          }},
        },
      },
    },
    flags = { "not-on-map" },
    light = { color = { r = 1, g = 0.9, b = 0.8 }, intensity = 1, size = 15 },
    sound = {
      aggregation = { max_count = 1, remove = true },
      variations = {
        { filename = "__base__/sound/small-explosion-1.ogg", volume = 0.4 },
        { filename = "__base__/sound/small-explosion-2.ogg", volume = 0.4 },
        { filename = "__base__/sound/fight/large-explosion-1.ogg", volume = 0.4 },
        { filename = "__base__/sound/fight/large-explosion-2.ogg", volume = 0.4 }
      }
    },
  },
  {
    type = "item-entity",
    name = "robot-item-on-ground",
    collision_box = { { -0.14, -0.14 }, { 0.14, 0.14 } },
    collision_mask = { "object-layer", "floor-layer", "item-layer", "water-tile" },
    flags = { "placeable-off-grid", "not-on-map" },
    minable = { mining_time = 0.025 },
    selection_box = { { -0.17, -0.17 }, { 0.17, 0.17 } },
  },
  {
    type = "technology",
    name = "robot-attrition-explosion-safety",
    effects = { },
    icon = "__robot_attrition__/graphics/technology/robot-safety.png",
    icon_size = 128,
    order = "e-g",
    prerequisites = {
      "logistic-system"
    },
    max_level = "infinite",
    unit = {
     count_formula = "10*2^L",
     time = 30,
     ingredients = {
       { "logistic-science-pack", 1 },
       { "utility-science-pack", 1 },
     }
    },
    upgrade = true
  },
})

se_prodecural_tech_exclusions = se_prodecural_tech_exclusions or {}
table.insert(se_prodecural_tech_exclusions, "robot-attrition")
