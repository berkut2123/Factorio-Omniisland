local data_util = require("data_util")

-- concept: fire a plague rocket.
-- it explodes in a cloud, cloud applies disease stickers to biters.
-- initial impact fires many plague projectiles in all directions.
-- impact with biter applies sticker and a new set of plague projectiles.
-- each time a projectile is spawned deal small damage in radius to biter bases.
-- sticker slows and deals damage. biters are only damaged by the sticker.

local wave_radius = 256

data:extend({
  {
    type = "ammo",
    name = data_util.mod_prefix .. "plague-bomb",
    ammo_type = {
      action = {
        action_delivery = {
          projectile = data_util.mod_prefix .. "plague-rocket",
          source_effects = {
            entity_name = "explosion-hit",
            type = "create-entity"
          },
          starting_speed = 0.05,
          type = "projectile",
          show_in_tooltip = false,
        },
        type = "direct"
      },
      category = "rocket",
      cooldown_modifier = 3,
      range_modifier = 3,
      target_type = "position"
    },
    icon = "__space-exploration-graphics__/graphics/icons/plague-bomb.png",
    icon_size = 32,
    order = "d[rocket-launcher]-d[plague-bomb]",
    stack_size = 10,
    subgroup = "ammo",
  },


  {
    type = "projectile",
    name = data_util.mod_prefix .. "plague-rocket",
    acceleration = 0.005,
    action = {
      action_delivery = {
        target_effects = {
          {
            entity_name = "explosion",
            type = "create-entity"
          },
          {
            damage = {
              amount = 50,
              type = "poison"
            },
            type = "damage"
          },
          {
            check_buildability = true,
            entity_name = "small-scorchmark",
            type = "create-entity"
          },
          {
            entity_name = data_util.mod_prefix .. "plague-cloud",
            show_in_tooltip = false,
            trigger_created_entity = true,
            type = "create-entity"
          },
          {
            action = {
              action_delivery = {
                projectile = data_util.mod_prefix .. "plague-wave",
                starting_speed = 0.05,
                starting_speed_deviation = 0.049,
                show_in_tooltip = false,
                type = "projectile"
              },
              radius = wave_radius,
              repeat_count = 64,
              target_entities = false,
              trigger_from_target = true,
              show_in_tooltip = false,
              type = "area"
            },
            show_in_tooltip = false,
            type = "nested-result"
          }
        },
        type = "instant"
      },
      type = "direct"
    },
    animation = {
      filename = "__base__/graphics/entity/rocket/rocket.png",
      frame_count = 8,
      height = 35,
      line_length = 8,
      priority = "high",
      shift = {
        0,
        0
      },
      width = 9
    },
    flags = {
      "not-on-map"
    },
    light = {
      intensity = 0.8,
      size = 15
    },
    shadow = {
      filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
      frame_count = 1,
      height = 24,
      priority = "high",
      shift = {
        0,
        0
      },
      width = 7
    },
    smoke = {
      {
        deviation = {
          0.15,
          0.15
        },
        frequency = 1,
        name = "smoke-fast",
        position = {
          0,
          -1
        },
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    },
  },


  {
    type = "projectile",
    name = data_util.mod_prefix .. "plague-wave",
    acceleration = -0.000001,
    action = {
      {
        action_delivery = {
          target_effects = {
            {
              entity_name = data_util.mod_prefix .. "plague-cloud",
              show_in_tooltip = false,
              trigger_created_entity = true,
              type = "create-entity"
            },
          },
          type = "instant"
        },
        radius = 3,
        entity_flags = { "breaths-air" },
        type = "area"
      },
    },
    animation = {
      animation_speed = 0.5,
      filename = "__space-exploration-graphics__/graphics/entity/cloud/plague-cloud-faint.png",
      run_mode = "backward",
      flags = {
        "compressed"
      },
      frame_count = 45,
      height = 128,
      line_length = 7,
      priority = "low",
      scale = 3,
      width = 128
    },
    flags = {
      "not-on-map"
    },
    shadow = {
      filename = "__core__/graphics/empty.png",
      frame_count = 1,
      height = 1,
      priority = "high",
      width = 1
    },
  },


  {
    type = "smoke-with-trigger",
    name = data_util.mod_prefix .. "plague-cloud",
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            type = "nested-result",
            action = {
              radius = 6,
              type = "area",
              action_delivery = {
                type = "instant",
                target_effects = {
                  {
                    type = "damage",
                    damage = {
                      amount = 20,
                      type = "poison"
                    },
                  },
                  {
                    type = "create-sticker",
                    sticker = data_util.mod_prefix .. "plague-sticker",
                  }
                },
              },
            },
          },
        },
      },
      {
        type = "area",
        radius = wave_radius,
        repeat_count = 3,
        target_entities = false,
        trigger_from_target = true,
        action_delivery = {
          direction_deviation = 0.5,
          projectile = data_util.mod_prefix .. "plague-wave",
          starting_speed = 0.05,
          starting_speed_deviation = 0.049,
          type = "projectile"
        },
      }
    },
    action_cooldown = 200,
    affected_by_wind = true,
    animation = {
      animation_speed = 0.5,
      filename = "__space-exploration-graphics__/graphics/entity/cloud/plague-cloud-faint.png",
      run_mode = "backward",
      flags = {
        "compressed"
      },
      frame_count = 45,
      height = 128,
      line_length = 7,
      priority = "low",
      scale = 3,
      width = 128
    },
    cyclic = true,
    duration = 30 * 60,
    fade_away_duration = 120,
    flags = {
      "not-on-map"
    },
    show_when_smoke_off = true,
    spread_duration = 10,
  },


  {
    type = "sticker",
    name = data_util.mod_prefix .. "plague-sticker",
    animation = {
      animation_speed = 0.4,
      filename = "__base__/graphics/entity/slowdown-sticker/slowdown-sticker.png",
      frame_count = 13,
      height = 11,
      priority = "extra-high",
      width = 11
    },
    damage_per_tick = {
      amount = 2,
      type = "poison"
    },
    duration_in_ticks = 60,
    flags = {
      "not-on-map"
    },
    target_movement_modifier = 0.75,
    --fire_spread_cooldown = 30,
    --fire_spread_radius = 1,
    --spread_fire_entity = "fire-flame-on-tree",
  },
})

if data_util.dot_string_greater_than(mods["base"], "0.18.35", false) then
  data.raw.sticker[data_util.mod_prefix .. "plague-sticker"].animation = {
    filename = "__base__/graphics/entity/slowdown-sticker/slowdown-sticker.png",
    priority = "extra-high",
    line_length = 5,
    width = 22,
    height = 24,
    frame_count = 50,
    animation_speed = 0.5,
    tint = {r = 0.663, g = 1.000, b = 0.000, a = 0.694},
    shift = util.by_pixel (2,-1),
    hr_version =
    {
      filename = "__base__/graphics/entity/slowdown-sticker/hr-slowdown-sticker.png",
      line_length = 5,
      width = 42,
      height = 48,
      frame_count = 50,
      animation_speed = 0.5,
      tint = {r = 0.663, g = 1.000, b = 0.000, a = 0.694},
      shift = util.by_pixel(2, -0.5),
      scale = 0.5
    }
  }
end
