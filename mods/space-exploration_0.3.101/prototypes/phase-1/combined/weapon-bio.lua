local data_util = require("data_util")
local tint = {
  0.7,
  0.6944,
  0.3584,
  0.7
}
data.raw["utility-constants"].default.bonus_gui_ordering["biogun"] = "k-c"
data:extend({
  {
      type = "technology",
      name = data_util.mod_prefix .. "biogun",
      effects = {
        { type = "unlock-recipe", recipe = data_util.mod_prefix .. "biogun" },
        { type = "unlock-recipe", recipe = data_util.mod_prefix .. "bloater-ammo" },
        { type = "unlock-recipe", recipe = data_util.mod_prefix .. "pheromone-ammo" },
      },
      icon = "__space-exploration-graphics__/graphics/technology/biogun.png",
      icon_size = 128,
      order = "e-g",
      prerequisites = {
        data_util.mod_prefix .. "vitalic-acid",
      },
      unit = {
       count = 100,
       time = 60,
       ingredients = {
         { "automation-science-pack", 1 },
         { "logistic-science-pack", 1 },
         { "chemical-science-pack", 1 },
         { data_util.mod_prefix .. "rocket-science-pack", 1 },
         { data_util.mod_prefix .. "biological-science-pack-1", 1 },
       }
      },
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "biogun",
      result = data_util.mod_prefix .. "biogun",
      enabled = false,
      energy_required = 30,
      ingredients = {
        { "glass", 10 },
        { "steel-plate", 10 },
        { data_util.mod_prefix .. "space-pipe", 1 },
      },
      requester_paste_multiplier = 1,
      always_show_made_in = false,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "pheromone-ammo",
      result = data_util.mod_prefix .. "pheromone-ammo",
      enabled = false,
      energy_required = 10,
      ingredients = {
        { data_util.mod_prefix .. "canister", 1 },
        { data_util.mod_prefix .. "vitalic-acid", 10 },
        { type = "fluid", name = data_util.mod_prefix .. "bio-sludge", amount = 100 },
      },
      requester_paste_multiplier = 1,
      always_show_made_in = false,
      category = "chemistry"
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "bloater-ammo",
      result = data_util.mod_prefix .. "bloater-ammo",
      enabled = false,
      energy_required = 10,
      ingredients = {
        { data_util.mod_prefix .. "canister", 1 },
        { data_util.mod_prefix .. "vitalic-acid", 10 },
        { type = "fluid", name = data_util.mod_prefix .. "bio-sludge", amount = 100 },
      },
      requester_paste_multiplier = 1,
      always_show_made_in = false,
      category = "chemistry"
  },
  {
    type = "ammo-category",
    name = "biogun",
    bonus_gui_order = "k-c",
  },
  {
    type = "gun",
    name = data_util.mod_prefix .. "biogun",
    icon = "__space-exploration-graphics__/graphics/icons/biogun.png",
    icon_mipmaps = 4,
    icon_size = 64,
    subgroup = "gun",
    order = "e[flamethrower]",
    stack_size = 5,
    attack_parameters = {
      ammo_category = "biogun",
      cooldown = 60,
      cyclic_sound = {
        begin_sound = {
          {
            filename = "__base__/sound/fight/flamethrower-start.ogg",
            volume = 0.7
          }
        },
        end_sound = {
          {
            filename = "__base__/sound/fight/flamethrower-end.ogg",
            volume = 0.7
          }
        },
        middle_sound = {
          {
            filename = "__base__/sound/fight/flamethrower-mid.ogg",
            volume = 0.7
          }
        }
      },
      gun_barrel_length = 0.8,
      gun_center_shift = {
        0,
        -1
      },
      movement_slow_down_factor = 0.1,
      range = 25,
      type = "stream"
    },
  },
  {
    type = "ammo",
    name = data_util.mod_prefix .. "pheromone-ammo",
    ammo_type =
    {
      category = "biogun",
      target_type = "entity",
      range_modifier = 3,
      action = {
        action_delivery = {
          projectile = data_util.mod_prefix .. "pheromone-projectile",
          source_effects = {
            entity_name = "explosion-hit",
            type = "create-entity"
          },
          starting_speed = 0.3,
          type = "projectile"
        },
        type = "direct"
      },
    },
    icon = "__space-exploration-graphics__/graphics/icons/pheromone-dart.png",
    icon_size = 64,
    magazine_size = 1,
    order = "z-t[biogun]",
    stack_size = 100,
    subgroup = "ammo",
  },
  {
    type = "projectile",
    name = data_util.mod_prefix .. "pheromone-projectile",
    acceleration = 0.005,
    action = {
      action_delivery = {
        target_effects = {
          {
            entity_name =  data_util.mod_prefix .. "pheromone-trigger",
            type = "create-entity",
            trigger_created_entity = true,
          },
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
      intensity = 0.5,
      size = 4
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
          1
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
    type = "explosion",
    name = data_util.mod_prefix .. "pheromone-trigger",
    animations = {
      {
        direction_count = 1,
        filename = "__space-exploration-graphics__/graphics/blank.png",
        frame_count = 1,
        height = 1,
        line_length = 1,
        width = 1
      }
    },
    flags = {
      "not-on-map", "placeable-off-grid"
    },
  },
  {
    type = "ammo",
    name = data_util.mod_prefix .. "bloater-ammo",
    ammo_type =
    {
      category = "biogun",
      target_type = "position",
      clamp_position = true,
      action = {
        action_delivery = {
          stream = data_util.mod_prefix .. "bloater-stream",
          type = "stream"
        },
        type = "direct"
      },
    },
    icon = "__space-exploration-graphics__/graphics/icons/bloater-ammo.png",
    icon_size = 64,
    magazine_size = 1,
    order = "z-t[biogun]",
    stack_size = 100,
    subgroup = "ammo",
  },
  {
    name = data_util.mod_prefix .. "bloater-stream",
    flags = {
      "not-on-map"
    },
    initial_action = {
      {
        action_delivery = {
          target_effects = {
            {
              sound = {
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
                  volume = 0.8
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
                  volume = 0.8
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
                  volume = 0.8
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
                  volume = 0.8
                }
              },
              type = "play-sound"
            },
            {
              entity_name = data_util.mod_prefix .. "bloater-pool-cloud",
              show_in_tooltip = true,
              type = "create-entity"
            },
          },
          type = "instant"
        },
        type = "direct"
      },
      {
        action_delivery = {
          target_effects = {
            {
              sticker = data_util.mod_prefix .. "bloater-sticker",
              type = "create-sticker"
            },
            {
              damage = {
                amount = 1,
                type = "acid"
              },
              type = "damage"
            }
          },
          type = "instant"
        },
        force = "enemy",
        ignore_collision_condition = true,
        radius = 1.75,
        type = "area"
      }
    },
    oriented_particle = true,
    particle = {
      animation_speed = 1,
      filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
      frame_count = 15,
      height = 84,
      hr_version = {
        animation_speed = 1,
        filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-head.png",
        frame_count = 15,
        height = 164,
        line_length = 5,
        priority = "high",
        scale = 0.5,
        shift = {
          -0.0625,
          0.96875
        },
        tint = tint,
        width = 42
      },
      line_length = 5,
      priority = "high",
      scale = 1,
      shift = {
        -0.0625,
        0.9375
      },
      tint = tint,
      width = 22
    },
    particle_alpha_per_part = 0.8,
    particle_buffer_size = 90,
    particle_end_alpha = 1,
    particle_fade_out_duration = 2,
    particle_horizontal_speed = 0.3375,
    particle_horizontal_speed_deviation = 0.0035,
    particle_loop_exit_threshold = 0.25,
    particle_loop_frame_count = 15,
    particle_scale_per_part = 0.8,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    particle_start_alpha = 0.5,
    particle_vertical_acceleration = 0.0045,
    shadow = {
      animation_speed = 1,
      draw_as_shadow = true,
      filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
      frame_count = 15,
      height = 84,
      hr_version = {
        animation_speed = 1,
        draw_as_shadow = true,
        filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-shadow.png",
        frame_count = 15,
        height = 164,
        line_length = 15,
        priority = "high",
        scale = 0.5,
        shift = {
          -0.0625,
          0.96875
        },
        width = 42
      },
      line_length = 15,
      priority = "high",
      scale = 1,
      shift = {
        -0.0625,
        0.9375
      },
      width = 22
    },
    shadow_scale_enabled = true,
    special_neutral_target_damage = {
      amount = 1,
      type = "acid"
    },
    spine_animation = {
      animation_speed = 1,
      filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
      frame_count = 15,
      height = 12,
      hr_version = {
        animation_speed = 1,
        filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-tail.png",
        frame_count = 15,
        height = 20,
        line_length = 5,
        priority = "high",
        scale = 0.5,
        shift = {
          0,
          -0.03125
        },
        tint = tint,
        width = 132
      },
      line_length = 5,
      priority = "high",
      scale = 1,
      shift = {
        0,
        -0.0625
      },
      tint = tint,
      width = 66
    },
    type = "stream"
  },
  {
    type = "smoke-with-trigger",
    name = data_util.mod_prefix .. "bloater-pool-cloud",
    flags = {"not-on-map"},
    show_when_smoke_off = true,
    particle_count = 16,
    particle_spread = { 11 * 1.05, 11 * 0.6 * 1.05 },
    particle_distance_scale_factor = 0.5,
    particle_scale_factor = { 1, 0.707 },
    wave_speed = { 1/80, 1/60 },
    wave_distance = { 0.3, 0.2 },
    spread_duration_variation = 20,
    particle_duration_variation = 60 * 3,
    render_layer = "object",

    affected_by_wind = false,
    cyclic = true,
    duration = 60 * 20,
    fade_away_duration = 2 * 60,
    spread_duration = 20,
    --color = {r = 0.239, g = 0.875, b = 0.992, a = 0.690}, -- #3ddffdb0,
    color = tint, -- #3ddffdb0,

    animation =
    {
      direction_count = 1,
      filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
      frame_count = 26,
      height = 116,
      hr_version = {
        direction_count = 1,
        filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
        frame_count = 26,
        height = 224,
        line_length = 8,
        scale = 0.5,
        shift = {
          -0.375,
          -0.25
        },
        tint = tint,
        width = 210
      },
      line_length = 8,
      scale = 1,
      shift = {
        -0.375,
        -0.3125
      },
      tint = tint,
      width = 106
    },

    created_effect =
    {
      {
        type = "cluster",
        cluster_count = 10,
        distance = 4,
        distance_deviation = 5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "create-fire",
            show_in_tooltip = false,
            entity_name = data_util.mod_prefix .. "bloater-pool-fire",
            initial_height = 0
          }
        }
      },
      {
        type = "cluster",
        cluster_count = 11,
        distance = 8 * 1.1,
        distance_deviation = 2,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "create-fire",
            show_in_tooltip = false,
            entity_name = data_util.mod_prefix .. "bloater-pool-fire",
            initial_height = 0
          }
        }
      }
    },

    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/poison-cloud.ogg",
        volume = 0.7
      },
    },
    action = {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 11,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  type = "damage",
                  damage = { amount = 8, type = "acid"}
                }
              }
            }
          }
        }
      },
      {
        type = "cluster",
        cluster_count = 6,
        distance = 6,
        distance_deviation = 7,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "create-fire",
            show_in_tooltip = false,
            entity_name = data_util.mod_prefix .. "bloater-pool-fire",
            initial_height = 0
          }
        }
      },
      {
        type = "cluster",
        cluster_count = 2,
        distance = 1,
        distance_deviation = 1,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "create-fire",
            show_in_tooltip = false,
            entity_name = data_util.mod_prefix .. "bloater-pool-fire",
            initial_height = 0
          }
        }
      },
    },
    action_cooldown = 10
  },
  {
    type = "fire",
    name = data_util.mod_prefix .. "bloater-pool-fire",
    add_fuel_cooldown = 10,
    burnt_patch_lifetime = 0,
    damage_multiplier_decrease_per_tick = 0.005,
    damage_multiplier_increase_per_added_fuel = 1,
    damage_per_tick = {
      amount = 0,
      type = "acid"
    },
    delay_between_initial_flames = 10,
    emissions_per_second = 0,
    fade_in_duration = 1,
    fade_out_duration = 30,
    flags = {
      "placeable-off-grid",
      "not-on-map"
    },
    initial_flame_count = 1,
    initial_lifetime = 192,
    initial_render_layer = "object",
    lifetime_increase_by = 0,
    lifetime_increase_cooldown = 4,
    limit_overlapping_particles = true,
    localised_name = {
      "entity-name.acid-splash"
    },
    maximum_damage_multiplier = 3,
    maximum_lifetime = 180,
    maximum_spread_count = 100,
    on_damage_tick_effect = {
      action_delivery = {
        target_effects = {
          {
            show_in_tooltip = true,
            sticker = data_util.mod_prefix .. "bloater-sticker",
            type = "create-sticker"
          },
          {
            apply_damage_to_trees = false,
            damage = {
              amount = 2,
              type = "acid"
            },
            type = "damage"
          }
        },
        type = "instant"
      },
      filter_enabled = true,
      ignore_collision_condition = true,
      trigger_target_mask = {
        "ground-unit"
      },
      type = "direct"
    },
    particle_alpha = 0.6,
    particle_alpha_blend_duration = 300,
    pictures = {
      {
        layers = {
          {
            direction_count = 1,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
            frame_count = 26,
            height = 116,
            hr_version = {
              direction_count = 1,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
              frame_count = 26,
              height = 224,
              line_length = 8,
              scale = 0.5,
              shift = {
                -0.375,
                -0.25
              },
              tint = tint,
              width = 210
            },
            line_length = 8,
            scale = 1,
            shift = {
              -0.375,
              -0.3125
            },
            tint = tint,
            width = 106
          },
          {
            direction_count = 1,
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
            frame_count = 26,
            height = 98,
            hr_version = {
              direction_count = 1,
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
              frame_count = 26,
              height = 188,
              line_length = 8,
              scale = 0.5,
              shift = {
                0.0625,
                0.0625
              },
              width = 266
            },
            line_length = 8,
            scale = 1,
            shift = {
              0.0625,
              0
            },
            width = 134
          }
        }
      },
      {
        layers = {
          {
            direction_count = 1,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
            frame_count = 29,
            height = 76,
            hr_version = {
              direction_count = 1,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
              frame_count = 29,
              height = 150,
              line_length = 8,
              scale = 0.5,
              shift = {
                -0.28125,
                -0.53125
              },
              tint = tint,
              width = 174
            },
            line_length = 8,
            scale = 1,
            shift = {
              -0.3125,
              -0.5625
            },
            tint = tint,
            width = 88
          },
          {
            direction_count = 1,
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
            frame_count = 29,
            height = 136,
            hr_version = {
              direction_count = 1,
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
              frame_count = 29,
              height = 266,
              line_length = 8,
              scale = 0.5,
              shift = {
                0.1875,
                0.90625
              },
              width = 238
            },
            line_length = 8,
            scale = 1,
            shift = {
              0.1875,
              0.875
            },
            width = 120
          }
        }
      },
      {
        layers = {
          {
            direction_count = 1,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
            frame_count = 29,
            height = 104,
            hr_version = {
              direction_count = 1,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
              frame_count = 29,
              height = 208,
              line_length = 8,
              scale = 0.5,
              shift = {
                0.6875,
                -0.5
              },
              tint = tint,
              width = 236
            },
            line_length = 8,
            scale = 1,
            shift = {
              0.6875,
              -0.5
            },
            tint = tint,
            width = 118
          },
          {
            direction_count = 1,
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
            frame_count = 29,
            height = 70,
            hr_version = {
              direction_count = 1,
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
              frame_count = 29,
              height = 140,
              line_length = 8,
              scale = 0.5,
              shift = {
                0.53125,
                0.0625
              },
              width = 214
            },
            line_length = 8,
            scale = 1,
            shift = {
              0.5,
              0.0625
            },
            width = 110
          }
        }
      },
      {
        layers = {
          {
            direction_count = 1,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
            frame_count = 24,
            height = 80,
            hr_version = {
              direction_count = 1,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
              frame_count = 24,
              height = 154,
              line_length = 8,
              scale = 0.5,
              shift = {
                0.53125,
                -0.59375
              },
              tint = tint,
              width = 252
            },
            line_length = 8,
            scale = 1,
            shift = {
              0.5,
              -0.625
            },
            tint = tint,
            width = 128
          },
          {
            direction_count = 1,
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
            frame_count = 24,
            height = 80,
            hr_version = {
              direction_count = 1,
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
              frame_count = 24,
              height = 160,
              line_length = 8,
              scale = 0.5,
              shift = {
                0.5625,
                -0.5
              },
              width = 248
            },
            line_length = 8,
            scale = 1,
            shift = {
              0.5625,
              -0.5
            },
            width = 124
          }
        }
      }
    },
    render_layer = "lower-object-above-shadow",
    secondary_picture_fade_out_duration = 60,
    secondary_picture_fade_out_start = 30,
    secondary_pictures = {
      {
        layers = {
          {
            direction_count = 1,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
            frame_count = 26,
            height = 116,
            hr_version = {
              direction_count = 1,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
              frame_count = 26,
              height = 224,
              line_length = 8,
              scale = 0.325,
              shift = {
                -0.24375,
                -0.1625
              },
              tint = {
                0.7,
                0.6944,
                0.3584,
                0.7
              },
              width = 210
            },
            line_length = 8,
            scale = 0.65,
            shift = {
              -0.24375,
              -0.203125
            },
            tint = {
              0.7,
              0.6944,
              0.3584,
              0.7
            },
            width = 106
          },
          {
            direction_count = 1,
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
            frame_count = 26,
            height = 98,
            hr_version = {
              direction_count = 1,
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
              frame_count = 26,
              height = 188,
              line_length = 8,
              scale = 0.325,
              shift = {
                0.040625,
                0.040625
              },
              width = 266
            },
            line_length = 8,
            scale = 0.65,
            shift = {
              0.040625,
              0
            },
            width = 134
          }
        }
      },
      {
        layers = {
          {
            direction_count = 1,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
            frame_count = 29,
            height = 76,
            hr_version = {
              direction_count = 1,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
              frame_count = 29,
              height = 150,
              line_length = 8,
              scale = 0.325,
              shift = {
                -0.1828125,
                -0.3453125
              },
              tint = {
                0.7,
                0.6944,
                0.3584,
                0.7
              },
              width = 174
            },
            line_length = 8,
            scale = 0.65,
            shift = {
              -0.203125,
              -0.365625
            },
            tint = {
              0.7,
              0.6944,
              0.3584,
              0.7
            },
            width = 88
          },
          {
            direction_count = 1,
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
            frame_count = 29,
            height = 136,
            hr_version = {
              direction_count = 1,
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
              frame_count = 29,
              height = 266,
              line_length = 8,
              scale = 0.325,
              shift = {
                0.121875,
                0.5890625
              },
              width = 238
            },
            line_length = 8,
            scale = 0.65,
            shift = {
              0.121875,
              0.56875
            },
            width = 120
          }
        }
      },
      {
        layers = {
          {
            direction_count = 1,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
            frame_count = 29,
            height = 104,
            hr_version = {
              direction_count = 1,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
              frame_count = 29,
              height = 208,
              line_length = 8,
              scale = 0.325,
              shift = {
                0.446875,
                -0.325
              },
              tint = {
                0.7,
                0.6944,
                0.3584,
                0.7
              },
              width = 236
            },
            line_length = 8,
            scale = 0.65,
            shift = {
              0.446875,
              -0.325
            },
            tint = {
              0.7,
              0.6944,
              0.3584,
              0.7
            },
            width = 118
          },
          {
            direction_count = 1,
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
            frame_count = 29,
            height = 70,
            hr_version = {
              direction_count = 1,
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
              frame_count = 29,
              height = 140,
              line_length = 8,
              scale = 0.325,
              shift = {
                0.3453125,
                0.040625
              },
              width = 214
            },
            line_length = 8,
            scale = 0.65,
            shift = {
              0.325,
              0.040625
            },
            width = 110
          }
        }
      },
      {
        layers = {
          {
            direction_count = 1,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
            frame_count = 24,
            height = 80,
            hr_version = {
              direction_count = 1,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
              frame_count = 24,
              height = 154,
              line_length = 8,
              scale = 0.325,
              shift = {
                0.3453125,
                -0.3859375
              },
              tint = {
                0.7,
                0.6944,
                0.3584,
                0.7
              },
              width = 252
            },
            line_length = 8,
            scale = 0.65,
            shift = {
              0.325,
              -0.40625
            },
            tint = {
              0.7,
              0.6944,
              0.3584,
              0.7
            },
            width = 128
          },
          {
            direction_count = 1,
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
            frame_count = 24,
            height = 80,
            hr_version = {
              direction_count = 1,
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
              frame_count = 24,
              height = 160,
              line_length = 8,
              scale = 0.325,
              shift = {
                0.365625,
                -0.325
              },
              width = 248
            },
            line_length = 8,
            scale = 0.65,
            shift = {
              0.365625,
              -0.325
            },
            width = 124
          }
        }
      }
    },
    secondary_render_layer = "higher-object-above",
    spread_delay = 300,
    spread_delay_deviation = 180,
    uses_alternative_behavior = true
  },
  {
    type = "sticker",
    name = data_util.mod_prefix .. "bloater-sticker",
    animation = {
      animation_speed = 2,
      axially_symmetrical = false,
      blend_mode = "additive",
      direction_count = 1,
      filename = "__base__/graphics/entity/fire-flame/fire-flame-13.png",
      frame_count = 25,
      height = 118,
      line_length = 8,
      scale = 0.4,
      shift = {
        -0.0078125,
        -0.18125
      },
      tint = {r = 0.2, g = 1, b = 0},
      width = 60
    },
    duration_in_ticks = 120,
    flags = {
      "not-on-map"
    },
    target_movement_modifier_from = 0.4,
    target_movement_modifier_to = 1,
    vehicle_friction_modifier_from = 1.5,
    vehicle_friction_modifier_to = 1,
    vehicle_speed_modifier_from = 0.4,
    vehicle_speed_modifier_to = 1
  },
  {
    type = "projectile",
    name = data_util.mod_prefix .. "bloater-splatter",
    acceleration = -0.01,
    action = {
      action_delivery = {
        target_effects = {
          damage = {
            amount = 50,
            type = "acid"
          },
          type = "damage"
        },
        type = "instant"
      },
      type = "direct"
    },
    animation = {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      height = 50,
      priority = "high",
      width = 3,
      scale = 1.5,
      tint = {r = 159/255, g = 229/255, b = 38/255}
    },
    collision_box = {
      {
        -0.05,
        -0.25
      },
      {
        0.05,
        0.25
      }
    },
    direction_only = true,
    flags = {
      "not-on-map"
    },
  },
})

for _, e in pairs({10, 40, 100, 400, 1000, 4000, 10000}) do

  data:extend({
    {
      type = "explosion",
      name = data_util.mod_prefix .. "bloater-burst-"..e,
      animations = {
        {
          direction_count = 1,
          filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
          frame_count = 26,
          height = 116,
          hr_version = {
            direction_count = 1,
            filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
            frame_count = 26,
            height = 224,
            line_length = 8,
            scale = 0.5,
            shift = {
              -0.375,
              -0.25
            },
            tint = tint,
            width = 210
          },
          line_length = 8,
          scale = 1,
          shift = {
            -0.375,
            -0.3125
          },
          tint = tint,
          width = 106
        },
      },
      created_effect = {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
              {
                type = "create-particle",
                repeat_count = 12,
                repeat_count_deviation = 0,
                probability = 1,
                affects_target = false,
                show_in_tooltip = false,
                particle_name = "blood-particle-carpet",
                offsets = { { 0, 0 } },
                offset_deviation =
                {
                  left_top = { -0.5, -0.5 },
                  right_bottom = { 0.5, 0.5 }
                },
                tile_collision_mask = nil,
                initial_height = 0.2,
                initial_height_deviation = 0.05,
                initial_vertical_speed = 0.062,
                initial_vertical_speed_deviation = 0.01,
                speed_from_center = 0.18,
                speed_from_center_deviation = 0.111,
                frame_speed = 1,
                frame_speed_deviation = 0,
                tail_length = 25,
                tail_length_deviation = 0,
                tail_width = 1
              },
              {
                type = "create-particle",
                repeat_count = 10,
                repeat_count_deviation = 2,
                probability = 1,
                affects_target = false,
                show_in_tooltip = false,
                particle_name = "blood-particle-carpet",
                offsets =
                {
                  { 0.0625, 0.7891 },
                  { -0.01563, 0.2422 }
                },
                offset_deviation =
                {
                  left_top = { -1, -1 },
                  right_bottom = { 1, 1 }
                },
                tile_collision_mask = nil,
                initial_height = 0.9,
                initial_height_deviation = 0,
                initial_vertical_speed = 0.04,
                initial_vertical_speed_deviation = 0.07,
                speed_from_center = 0.135,
                speed_from_center_deviation = 0.115,
                frame_speed = 1,
                frame_speed_deviation = 0.02,
                tail_length = 12,
                tail_length_deviation = 25,
                tail_width = 1
              },
              {
                type = "create-particle",
                repeat_count = 8,
                repeat_count_deviation = 2,
                probability = 1,
                affects_target = false,
                show_in_tooltip = false,
                particle_name = "guts-entrails-particle-small-medium",
                offsets = { { 0, 0 } },
                offset_deviation =
                {
                  left_top = { -0.5, -0.5 },
                  right_bottom = { 0.5, 0.5 }
                },
                tile_collision_mask = nil,
                initial_height = 1,
                initial_height_deviation = 0.52,
                initial_vertical_speed = 0.078,
                initial_vertical_speed_deviation = 0.05,
                speed_from_center = 0.17,
                speed_from_center_deviation = 0.17/2,
                frame_speed = 1,
                frame_speed_deviation = 0
              },
              {
                type = "create-particle",
                repeat_count = 11,
                repeat_count_deviation = 0,
                probability = 1,
                affects_target = false,
                show_in_tooltip = false,
                particle_name = "blood-particle-carpet",
                offsets = { { 0, -0.03906 } },
                offset_deviation =
                {
                  left_top = { -1, -1 },
                  right_bottom = { 1, 1 }
                },
                tile_collision_mask = nil,
                initial_height = 0.1,
                initial_height_deviation = 0.05,
                initial_vertical_speed = 0.09,
                initial_vertical_speed_deviation = 0.05,
                speed_from_center = 0.04,
                speed_from_center_deviation = 0,
                frame_speed = 1,
                frame_speed_deviation = 0,
                tail_length = 21,
                tail_length_deviation = 3,
                tail_width = 1
              },
              {
                type = "create-particle",
                repeat_count = 15,
                repeat_count_deviation = 1,
                probability = 1,
                affects_target = false,
                show_in_tooltip = false,
                particle_name = "blood-particle-carpet",
                offsets = { { 0, 0 } },
                offset_deviation =
                {
                  left_top = { -1, -1 },
                  right_bottom = { 1, 1 }
                },
                tile_collision_mask = nil,
                initial_height = 0.1,
                initial_height_deviation = 0.01,
                initial_vertical_speed = 0.018,
                initial_vertical_speed_deviation = 0.005,
                speed_from_center = 0.2,
                speed_from_center_deviation = 0.141,
                frame_speed = 1,
                frame_speed_deviation = 0,
                tail_length = 11,
                tail_length_deviation = 7,
                tail_width = 1
              },
              {
                type = "create-particle",
                repeat_count = 15,
                repeat_count_deviation = 0,
                probability = 1,
                affects_target = false,
                show_in_tooltip = false,
                particle_name = "blood-particle-carpet",
                offsets = { { 0, 0 } },
                offset_deviation =
                {
                  left_top = { -1, -0.5 },
                  right_bottom = { 1, 0.5 }
                },
                tile_collision_mask = nil,
                initial_height = 0.3,
                initial_height_deviation = 0.5,
                initial_vertical_speed = 0.055,
                initial_vertical_speed_deviation = 0.003,
                speed_from_center = 0.09,
                speed_from_center_deviation = 0.042,
                frame_speed = 1,
                frame_speed_deviation = 0,
                tail_length = 10,
                tail_length_deviation = 12,
                tail_width = 1
              },
              {
                type = "create-particle",
                repeat_count = 2,
                repeat_count_deviation = 2,
                probability = 1,
                affects_target = false,
                show_in_tooltip = false,
                particle_name = "guts-entrails-particle-big",
                offsets = { { 0, 0 } },
                offset_deviation =
                {
                  left_top = { -0.5, -0.5 },
                  right_bottom = { 0.5, 0.5 }
                },
                tile_collision_mask = nil,
                initial_height = 1,
                initial_height_deviation = 0.52,
                initial_vertical_speed = 0.178,
                initial_vertical_speed_deviation = 0.15,
                speed_from_center = 0.07,
                speed_from_center_deviation = 0,
                frame_speed = 1,
                frame_speed_deviation = 0
              },
              {
                action = {
                  action_delivery = {
                    projectile = data_util.mod_prefix .. "bloater-splatter",
                    starting_speed = 0.4,
                    starting_speed_deviation = 0.2,
                    show_in_tooltip = false,
                    type = "projectile"
                  },
                  radius = 6,
                  repeat_count = math.max(1, e / 100),
                  target_entities = false,
                  trigger_from_target = true,
                  show_in_tooltip = false,
                  type = "area"
                },
                show_in_tooltip = false,
                type = "nested-result"
              },
              --[[{ type = "nested-result", action = { type = "area", radius = 3,
                  action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = e * 0.05, type = "explosion" }}}},
              }},
              { type = "nested-result", action = { type = "area", radius = 6,
                  action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount =  e * 0.01, type = "acid" }}}},
              }},]]--
            },
        },
      },
      flags = { "not-on-map" },
      sound = {
        aggregation = { max_count = 1, remove = true },
        variations = {
          { filename = "__base__/sound/small-explosion-1.ogg", volume = 0.4 },
          { filename = "__base__/sound/small-explosion-2.ogg", volume = 0.4 },
        }
      },
    },
  })
end
