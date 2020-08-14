local data_util = require("data_util")

data.raw["utility-constants"].default.bonus_gui_ordering["cryogun"] = "k-c"
data:extend({
  {
    type = "ammo-category",
    name = "cryogun",
    bonus_gui_order = "k-c",
  },
  {
    type = "gun",
    name = data_util.mod_prefix .. "cryogun",
    icon = "__space-exploration-graphics__/graphics/icons/cryogun.png",
    icon_mipmaps = 4,
    icon_size = 64,
    subgroup = "gun",
    order = "e[flamethrower]",
    stack_size = 5,
    attack_parameters = {
      ammo_category = "cryogun",
      cooldown = 1,
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
      min_range = 3,
      movement_slow_down_factor = 0.1,
      range = 20,
      type = "stream"
    },
  },
  {
    type = "ammo",
    name = data_util.mod_prefix .. "cryogun-ammo",
    ammo_type =
    {
      category = "cryogun",
      target_type = "position",
      clamp_position = true,
      action = {
        action_delivery = {
          stream = "cryogun-stream",
          type = "stream"
        },
        type = "direct"
      },
    },
    icon = "__space-exploration-graphics__/graphics/icons/cryogun-ammo.png",
    icon_size = 64,
    magazine_size = 100,
    order = "z-t[cryogun]",
    stack_size = 100,
    subgroup = "ammo",
  },
  {
    type = "stream",
    name = "cryogun-stream",
    action = {
      {
        action_delivery = {
          target_effects = {
            {
              sticker = "slowdown-sticker",
              type = "create-sticker"
            },
            {
              apply_damage_to_trees = false,
              damage = {
                amount = 2,
                type = "cold"
              },
              type = "damage"
            },
          },
          type = "instant"
        },
        radius = 4,
        type = "area"
      },
      {
        action_delivery = {
          target_effects = {
            {
              type = "create-entity",
              entity_name = data_util.mod_prefix .. "cryogun-trigger",
              trigger_created_entity = true,
              show_in_tooltip = false,
            },
          },
          type = "instant"
        },
        type = "direct"
      }
      --[[{
        action_delivery = {
          target_effects = {
            {
              entity_name = "fire-flame",
              initial_ground_flame_count = 2,
              show_in_tooltip = true,
              type = "create-fire"
            }
          },
          type = "instant"
        },
        type = "direct"
      }]]
    },
    flags = {
      "not-on-map"
    },
    ground_light = {
      intensity = 0.8,
      size = 3.2,
      color = {r = 0.5, g = 0.5, b = 1}
    },
    particle = {
      filename = "__space-exploration-graphics__/graphics/entity/cryostream/cryostream-explosion.png",
      frame_count = 32,
      height = 64,
      line_length = 8,
      priority = "extra-high",
      scale = 0.8,
      width = 64
    },
    particle_buffer_size = 65,
    particle_end_alpha = 1,
    particle_fade_out_threshold = 0.9,
    particle_horizontal_speed = 0.5,
    particle_horizontal_speed_deviation = 0.0035,
    particle_loop_exit_threshold = 0.25,
    particle_loop_frame_count = 3,
    particle_spawn_interval = 2,
    particle_spawn_timeout = 2,
    particle_start_alpha = 0.5,
    particle_start_scale = 0.2,
    particle_vertical_acceleration = 0.003,
    shadow = {
      filename = "__base__/graphics/entity/acid-projectile/projectile-shadow.png",
      frame_count = 33,
      height = 16,
      line_length = 5,
      priority = "high",
      scale = 0.5,
      shift = {
        -0.045,
        0.1975
      },
      width = 28
    },
    smoke_sources = {
      {
        frequency = 0.05,
        name = "soft-fire-smoke",
        position = {
          0,
          0
        },
        starting_frame_deviation = 60
      }
    },
    spine_animation = {
      animation_speed = 2,
      axially_symmetrical = false,
      blend_mode = "additive-soft",
      direction_count = 1,
      filename = "__space-exploration-graphics__/graphics/entity/cryostream/cryostream-spine.png",
      frame_count = 32,
      height = 18,
      line_length = 4,
      scale = 0.75,
      shift = {
        0,
        0
      },
      width = 32
    },
    stream_light = {
      intensity = 1,
      size = 3.2,
      color = {r = 0.5, g = 0.5, b = 1}
    },
  },
  {
    type = "explosion",
    name = data_util.mod_prefix .. "cryogun-trigger",
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
    type = "simple-entity",
    name = data_util.mod_prefix .. "cryogun-ice-spacer",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/cryogun-ice.png",
    icon_size = 64,
    order = "b-z",
    collision_box = {{-0.49, -0.49}, {0.49, 0.49}},
    collision_mask = {"player-layer", "train-layer"},
    selection_box = {{-0.49, -0.49}, {0.49, 0.49}},
    selectable_in_game = false,
    map_color = {r = 0.8, g = 0.9, b = 1, a = 0.5},
    picture = {
      filename = "__space-exploration-graphics__/graphics/blank.png",
      width = 1,
      height = 1,
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "cryogun-ice",
    icon = "__space-exploration-graphics__/graphics/icons/cryogun-ice.png",
    icon_size = 64,
    subgroup = "grass",
    collision_box = {{-1.1,-1.1},{1.1,1.1}},
    collision_mask = {"player-layer", "train-layer"},
    selection_box = {{-1.1,-1.1},{1.1,1.1}},
    count_as_rock_for_filtered_deconstruction = true,
    damaged_trigger_effect = {
      entity_name = "rock-damaged-explosion",
      offset_deviation = {
        { -0.5, -0.5 },
        { 0.5, 0.5 }
      },
      offsets = { { 0, 1 } },
      type = "create-entity"
    },
    flags = {"placeable-neutral", "placeable-off-grid"},
    map_color = {r = 0.8, g = 0.9, b = 1, a = 0.5},
    icon = "__space-exploration-graphics__/graphics/icons/cryogun-ice.png",
    icon_mipmaps = 1,
    icon_size = 64,
    loot = {
      {
        item = data_util.mod_prefix .. "water-ice",
      }
    },
    max_health = 500,
    resistances = {
      {
          type = "cold",
          percent = 100
      },
      {
          type = "poison",
          percent = 100
      },
      {
          type = "fire",
          percent = -100
      },
    },
    minable = {
      mining_particle = "stone-particle",
      mining_time = 0.1,
      results = {
        {
          amount_max = 1,
          amount_min = 1,
          name = data_util.mod_prefix .. "water-ice",
        },
      }
    },
    mined_sound = {
      filename = "__base__/sound/deconstruct-bricks.ogg"
    },
    order = "b-z",
    pictures = {
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-01.png",
          height = 179,
          scale = 0.5,
          shift = {
            0.25,
            0.0625
          },
          width = 201
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-02.png",
          height = 171,
          scale = 0.5,
          shift = {
            0.429688,
            0.046875
          },
          width = 233
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-03.png",
          height = 192,
          scale = 0.5,
          shift = {
            0.398438,
            0.03125
          },
          width = 240
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-04.png",
          height = 175,
          scale = 0.5,
          shift = {
            0.148438,
            0.132812
          },
          width = 219
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-05.png",
          height = 208,
          scale = 0.5,
          shift = {
            0.3125,
            0.0625
          },
          width = 240
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-06.png",
          height = 190,
          scale = 0.5,
          shift = {
            0.1875,
            0.046875
          },
          width = 243
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-07.png",
          height = 185,
          scale = 0.5,
          shift = {
            0.398438,
            0.0546875
          },
          width = 249
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-08.png",
          height = 163,
          scale = 0.5,
          shift = {
            0.34375,
            0.0390625
          },
          width = 273
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-09.png",
          height = 175,
          scale = 0.5,
          shift = {
            0.273438,
            0.0234375
          },
          width = 275
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-10.png",
          height = 215,
          scale = 0.5,
          shift = {
            0.195312,
            0.0390625
          },
          width = 241
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-11.png",
          height = 181,
          scale = 0.5,
          shift = {
            0.523438,
            0.03125
          },
          width = 318
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-12.png",
          height = 224,
          scale = 0.5,
          shift = {
            0.0546875,
            0.0234375
          },
          width = 217
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-13.png",
          height = 228,
          scale = 0.5,
          shift = {
            0.226562,
            0.046875
          },
          width = 332
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-14.png",
          height = 243,
          scale = 0.5,
          shift = {
            0.195312,
            0.0390625
          },
          width = 290
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-15.png",
          height = 225,
          scale = 0.5,
          shift = {
            0.609375,
            0.0234375
          },
          width = 349
      },
      {
          filename = "__space-exploration-graphics__/graphics/entity/cryostream/ice/ice-16.png",
          height = 250,
          scale = 0.5,
          shift = {
            0.132812,
            0.03125
          },
          width = 287
      }
    },
    render_layer = "object",
    vehicle_impact_sound = {
      filename = "__base__/sound/car-stone-impact.ogg",
      volume = 0.5
    }
  }
})

for _, tech in pairs(data.raw.technology) do
  if tech.effects then
    for _, effect in pairs(tech.effects) do
      if (effect.type == "ammo-damage" or effect.type == "gun-speed") and effect.ammo_category == "laser-turret" then
        local c = table.deepcopy(effect)
        c.ammo_category = "cryogun"
        table.insert(tech.effects, c)
      end
    end
  end
end
