local data_util = require("data_util")
local make_recipe = data_util.make_recipe
local scale_up = 4/3
local blank = {
  direction_count = 8,
  frame_count = 1,
  filename = "__space-exploration-graphics__/graphics/blank.png",
  width = 1,
  height = 1,
  priority = "low"
}
local main = {
  layers = {
    data_util.auto_sr_hr({
      direction_count = 8,
      filename = "__space-exploration-hr-graphics__/graphics/entity/shield-projector/hr/shield-projector.png",
      frame_count = 1,
      width = 196,
      height = 284,
      line_length = 8,
      shift = { 1/32, -24/32 },
      scale = 0.5 * 1.15
    }),
    data_util.auto_sr_hr({
      direction_count = 8,
      frame_count = 1,
      draw_as_shadow = true,
      filename = "__space-exploration-hr-graphics__/graphics/entity/shield-projector/hr/shield-projector-shadow.png",
      width = 412,
      height = 249,
      line_length = 4,
      shift = { 1 + 22/32, -8/32},
      scale = 0.5 * 1.15
    }),
  }
}
local c_floor_shift = 16/32
local d_floor_shift = 24/32
 -- width, height, rows, columns, shift, drawing_box
local shield_floors = {
  east = {3584,2496,8,3,{c_floor_shift,0},{{-3,-6.5},{3.5,6.5}}},
  north = {3328,2688,4,6,{0,-c_floor_shift},{{-6.5,-3.5},{6.5,3}}},
  northeast = {3680,3680,5,5,{d_floor_shift,-d_floor_shift},{{-5.5,-6},{6,5.5}}},
  northwest = {3680,3680,5,5,{-d_floor_shift,-d_floor_shift},{{-6,-6},{5.5,5.5}}},
  south = {3328,2688,4,6,{0,c_floor_shift},{{-6.5,-3},{6.5,3.5}}},
  southeast = {3680,3680,5,5,{d_floor_shift,d_floor_shift},{{-6,-5.5},{5.5,6}}},
  southwest = {3680,3680,5,5,{-d_floor_shift,d_floor_shift},{{-5.5,-5.5},{6,6}}},
  west = {3584,2496,8,3,{-c_floor_shift, 0},{{-3.5,-6.5},{3,6.5}}},
}
local shield_walls = {
  east = {3072,1920,12,2,{-1,-4.5},{{-2.5,10},{1.5,5.5}}},
  north = {2816,1920,4,6,{0,-4},{{-5.5,-4},{5.5,1}}},
  northeast = {3456,2944,6,4,{-1,-3.5},{{-5,-6.5},{3.5,4.5}}},
  northwest = {3456,2944,6,4,{1,-3.5},{{-3.5,-6.5},{5.5,4.5}}},
  south = {2816,3456,4,6,{0,-6.5},{{-5.5,7.5},{5.5,1}}},
  southeast = {3456,3584,6,4,{-1,-6.5},{{-5,-10.5},{3.5,3.5}}},
  southwest = {3456,3584,6,4,{1,-6.5},{{-3.5,-10.5},{5,3.5}}},
  west = {3072,1920,12,2,{1,-4.5},{{-1.5,10},{2.5,5.5}}},
}
for direction, dimensions in pairs(shield_floors) do
  dimensions[5][1] = dimensions[5][1] * scale_up
  dimensions[5][2] = dimensions[5][2] * scale_up
  dimensions[6][1][1] = dimensions[6][1][1] * scale_up
  dimensions[6][1][2] = dimensions[6][1][2] * scale_up
  dimensions[6][2][1] = dimensions[6][2][1] * scale_up
  dimensions[6][2][2] = dimensions[6][2][2] * scale_up
  data:extend({
    {
      type = "simple-entity",
      name = data_util.mod_prefix.."shield-projector-shield-floor-"..direction,
      render_layer = "resource",
      collision_box = {{-0.9,-0.9},{0.9,0.9}},
      collision_mask = {"not-colliding-with-itself"},
      flags = {"placeable-off-grid"},
      drawing_box = dimensions[6],
      animations = {
        filename = "__space-exploration-graphics__/graphics/entity/shield-projector/sr/shield/floor-"..direction..".png",
        animation_speed = 0.25,
        frame_count = 24,
        width = dimensions[1]/dimensions[3]/2,
        height = dimensions[2]/dimensions[4]/2,
        shift = dimensions[5],
        line_length = dimensions[3],
        scale = scale_up,
        hr_version = data_util.hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/shield-projector/hr/shield/floor-"..direction..".png",
          scale = 0.5 * scale_up,
          animation_speed = 0.25,
          frame_count = 24,
          width = dimensions[1]/dimensions[3],
          height = dimensions[2]/dimensions[4],
          shift = dimensions[5],
          line_length = dimensions[3],
        })
      }
    }
  })
end
for direction, dimensions in pairs(shield_walls) do
  dimensions[5][1] = dimensions[5][1] * scale_up
  dimensions[5][2] = dimensions[5][2] * scale_up
  dimensions[6][1][1] = dimensions[6][1][1] * scale_up
  dimensions[6][1][2] = dimensions[6][1][2] * scale_up
  dimensions[6][2][1] = dimensions[6][2][1] * scale_up
  dimensions[6][2][2] = dimensions[6][2][2] * scale_up
  data:extend({
    {
      type = "simple-entity",
      name = data_util.mod_prefix.."shield-projector-shield-wall-"..direction,
      render_layer = "wires",
      collision_box = {{-0.9,-0.9},{0.9,0.9}},
      collision_mask = {"not-colliding-with-itself"},
      flags = {"placeable-off-grid"},
      drawing_box = dimensions[6],
      animations = {
        filename = "__space-exploration-graphics__/graphics/entity/shield-projector/sr/shield/wall-"..direction..".png",
        animation_speed = 0.3,
        frame_count = 24,
        width = dimensions[1]/dimensions[3]/2,
        height = dimensions[2]/dimensions[4]/2,
        shift = {dimensions[5][1]/2,dimensions[5][2]/2},
        line_length = dimensions[3],
        scale = scale_up,
        hr_version = data_util.hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/shield-projector/hr/shield/wall-"..direction..".png",
          scale = 0.5 * scale_up,
          animation_speed = 0.3,
          frame_count = 24,
          width = dimensions[1]/dimensions[3],
          height = dimensions[2]/dimensions[4],
          shift = {dimensions[5][1]/2,dimensions[5][2]/2},
          line_length = dimensions[3],
        })
      }
    }
  })
end

data:extend({
  {
    type = "item",
    name = data_util.mod_prefix.."shield-projector",
    icon = "__space-exploration-graphics__/graphics/icons/shield-projector.png",
    icon_size = 64,
    icon_mipmaps = 1,
    order = "z",
    stack_size = 50,
    subgroup = "defensive-structure",
    place_result = data_util.mod_prefix.."shield-projector"
  },
  {
    type = "recipe",
    name = data_util.mod_prefix.."shield-projector",
    ingredients = {
      { name = data_util.mod_prefix.."dynamic-emitter", amount = 16 },
      { name = data_util.mod_prefix.."holmium-cable", amount = 160 },
      { name = data_util.mod_prefix.."heavy-composite", amount = 16 },
      { name = "battery", amount = 160 },
      { name = data_util.mod_prefix.."quantum-processor", amount = 160 },
    },
    result = data_util.mod_prefix.."shield-projector",
    energy_required = 16,
    enabled = false,
    always_show_made_in = false,
  },
  {
    type = "technology",
    name = data_util.mod_prefix.."shield-projector",
    effects = {
     {
       type = "unlock-recipe",
       recipe = data_util.mod_prefix.."shield-projector",
     },
    },
    icon = "__space-exploration-graphics__/graphics/technology/shield-projector.png",
    icon_size = 128,
    order = "e-g",
    prerequisites = {
      data_util.mod_prefix.."dynamic-emitter",
      data_util.mod_prefix.."heavy-composite"
    },
    unit = {
     count = 200,
     time = 60,
     ingredients = {
       { "automation-science-pack", 1 },
       { "logistic-science-pack", 1 },
       { "chemical-science-pack", 1 },
       { data_util.mod_prefix .. "rocket-science-pack", 1 },
       { data_util.mod_prefix.."energy-science-pack-3", 1 },
       { data_util.mod_prefix.."material-science-pack-3", 1 },
     }
    },
  },
  {
    type = "electric-turret",
    name = data_util.mod_prefix.."shield-projector",
    minable = {
      mining_time = 0.5,
      result = data_util.mod_prefix.."shield-projector",
    },
    flags = {
      "placeable-player",
      "player-creation",
      "building-direction-8-way"
    },
    icon = "__space-exploration-graphics__/graphics/icons/shield-projector.png",
    icon_size = 64,
    icon_mipmaps = 1,
    turret_base_has_direction = true,
    collision_box = { { -1.7, -1.7 }, { 1.7, 1.7 } },
    selection_box = { { -2, -2 }, { 2, 2 } },
    attack_parameters = {
      ammo_type = {
        action = {
          type = "direct",
          action_delivery = {
            type = "instant",
            target_effects = {
              {
                damage = {
                  amount = 0,
                  type = "electric"
                },
                type = "damage"
              },
            }
          },
        },
        target_type = "direction",
        category = "laser-turret",
      },
      cooldown = 60,
      damage_modifier = 0,
      min_range = 9.5*scale_up,
      range = 10.5*scale_up,
      turn_range = 0.19,
      source_direction_count = 8,
      source_offset = {
        0,
        -0.85587225
      },
      type = "projectile",
    },
    base_picture = blank,
    call_for_help_radius = 40,
    corpse = "laser-turret-remnants",
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
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
      offsets = {
        {
          0,
          1
        }
      },
      type = "create-entity"
    },
    dying_explosion = "laser-turret-explosion",
    energy_source = {
      buffer_capacity = "100MJ",
      drain = "1MW",
      input_flow_limit = "200MW",
      type = "electric",
      usage_priority = "primary-input"
    },
    folded_animation = main,
    folding_animation = blank,
    folding_speed = 1,
    glow_light_intensity = 0,
    max_health = 1000,
    prepared_animation = main,
    preparing_animation = blank,
    preparing_speed = 1,
    rotation_speed = 0.00,
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
        filename = "__base__/graphics/entity/laser-turret/laser-turret-reflection.png",
        height = 32,
        priority = "extra-high",
        scale = 5,
        shift = {
          0,
          1.25
        },
        variation_count = 1,
        width = 20
      },
      rotate = false
    }
  },
  {
      type = "car",
      name = data_util.mod_prefix .. "shield-projector-barrier",
      collision_mask = {
        "player-layer", -- block biters (and player)
        "train-layer", -- cars work on player layer, doesn't make sense to let trains though if cars can't
        "layer-13" -- block projectiles like a wall
      },
      collision_box = { { -1.85*scale_up, -0.5 }, { 1.85*scale_up, 0.5 } },
      selection_box = { { -1.75*scale_up, -0.5 }, { 1.75*scale_up, 0.5 } },
      animation = blank,
      braking_power = "1000kW",
      flags = {
        "placeable-player",
        "player-creation",
        "building-direction-8-way",
        "placeable-off-grid",
        "not-repairable"
      },
      energy_source = {
        type = "void"
      },
      consumption = "0W",
      effectivity = 0.5,
      energy_per_hit_point = 1,
      friction = 1,
      icon = "__space-exploration-graphics__/graphics/icons/shield-projector.png",
      icon_size = 64,
      icon_mipmaps = 1,
      inventory_size = 0,
      max_health = 5000,
      healing_per_tick = 1,
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
      selectable_in_game = true,
      weight = 700,
      minimap_representation = blank,
      selected_minimap_representation = blank,
      has_belt_immunity = true,
      resistances = {
        { type = "fire", percent = 50 },
        { type = "acid", percent = 50 },
        { type = "poison", percent = 50 },
      },
      hide_resistances = true,
      repair_speed_modifier = 0,
  },
})
