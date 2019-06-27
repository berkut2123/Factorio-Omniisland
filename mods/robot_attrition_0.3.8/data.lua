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
            entity_name = "explosion-remnants-particle",
            initial_height = 0.5,
            initial_vertical_speed = 0.08,
            initial_vertical_speed_deviation = 0.08,
            offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
            repeat_count = 20,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.08,
          },
          {
            type = "create-particle",
            entity_name = "stone-particle",
            initial_height = 0.5,
            initial_vertical_speed = 0.1,
            initial_vertical_speed_deviation = 0.1,
            offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
            repeat_count = 60,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.08,
          },
          { type = "nested-result", action = { type = "area", radius = 0.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 50, type = "explosion" }}}},
          }},
          { type = "nested-result", action = { type = "area", radius = 1.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 25, type = "explosion" }}}},
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
        { filename = "__base__/sound/fight/small-explosion-1.ogg", volume = 0.7 },
        { filename = "__base__/sound/fight/small-explosion-2.ogg", volume = 0.7 },
        { filename = "__base__/sound/fight/large-explosion-1.ogg", volume = 0.7 },
        { filename = "__base__/sound/fight/large-explosion-2.ogg", volume = 0.7 }
      }
    },
  },
})


data:extend({
  {
    type = "item-entity",
    name = "robot-item-on-ground",
    collision_box = { { -0.14, -0.14 }, { 0.14, 0.14 } },
    collision_mask = { "object-layer", "floor-layer", "item-layer", "water-tile" },
    flags = { "placeable-off-grid", "not-on-map" },
    minable = { mining_time = 0.025 },
    selection_box = { { -0.17, -0.17 }, { 0.17, 0.17 } },
  }
})
