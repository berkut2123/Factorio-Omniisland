local data_util = require("data_util")

local blank = {
  direction_count = 8,
  frame_count = 1,
  filename = "__space-exploration-graphics__/graphics/blank.png",
  width = 1,
  height = 1,
  priority = "low"
}

data:extend({

  {
    type = "technology",
    name = data_util.mod_prefix .. "delivery-cannon",
    effects = {
      { type = "unlock-recipe", recipe = data_util.mod_prefix .. "delivery-cannon", },
      { type = "unlock-recipe", recipe = data_util.mod_prefix .. "delivery-cannon-chest", },
      { type = "unlock-recipe", recipe = data_util.mod_prefix .. "delivery-cannon-capsule", },
    },
    icon = "__space-exploration-graphics__/graphics/technology/delivery-cannon.png",
    icon_size = 128,
    order = "e-g",
    prerequisites = {
      data_util.mod_prefix .. "meteor-defence",
      data_util.mod_prefix .. "rocket-landing-pad",
    },
    unit = {
     count = 200,
     time = 30,
     ingredients = {
       { "automation-science-pack", 1 },
       { "logistic-science-pack", 1 },
       { "chemical-science-pack", 1 },
     }
    },
  },

  {
      type = "item",
      name = data_util.mod_prefix .. "delivery-cannon",
      icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon.png",
      icon_size = 64,
      order = "j-a",
      subgroup = "rocket-logistics",
      stack_size = 50,
      place_result = data_util.mod_prefix .. "delivery-cannon",
  },
  {
      type = "item",
      name = data_util.mod_prefix .. "delivery-cannon-chest",
      icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-chest.png",
      icon_size = 64,
      order = "j-b",
      subgroup = "rocket-logistics",
      stack_size = 50,
      place_result = data_util.mod_prefix .. "delivery-cannon-chest",
  },
  {
      type = "item",
      name = data_util.mod_prefix .. "delivery-cannon-capsule",
      icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-capsule.png",
      icon_size = 64,
      order = "j-c",
      subgroup = "rocket-logistics",
      stack_size = 50,
  },
  {
      type = "selection-tool",
      name = data_util.mod_prefix .. "delivery-cannon-targeter",
      icon = "__space-exploration-graphics__/graphics/icons/target.png",
      icon_mipmaps = 1,
      icon_size = 64,
      flags = {},
      subgroup = "tool",
      order = "c[automated-construction]-e[unit-remote-control]",
      stack_size = 1,
      stackable = false,
      selection_color = {r = 0.3, g = 0.9, b = 0.3},
      alt_selection_color = {r = 0.9, g = 0.9, b = 0.3},
      selection_mode = {"nothing"},
      alt_selection_mode = {"nothing"},
      selection_cursor_box_type = "entity",
      alt_selection_cursor_box_type = "entity",
      hidden = true,
      flags = {"hidden"}
  },

  {
      type = "recipe",
      name = data_util.mod_prefix .. "delivery-cannon-capsule",
      result = data_util.mod_prefix .. "delivery-cannon-capsule",
      enabled = false,
      energy_required = 10,
      ingredients = {
        { "low-density-structure", 1 },
        { data_util.mod_prefix .. "heat-shielding", 1 },
        { "explosives", 5 },
        { "copper-cable", 10 },
      },
      requester_paste_multiplier = 1,
      always_show_made_in = false,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "delivery-cannon",
      result = data_util.mod_prefix .. "delivery-cannon",
      enabled = false,
      energy_required = 10,
      ingredients = {
        { "steel-chest", 10 },
        { "pipe", 10 },
        { "electric-engine-unit", 10 },
        { data_util.mod_prefix .. "heat-shielding", 10 },
        { "concrete", 20 },
      },
      requester_paste_multiplier = 1,
      always_show_made_in = false,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "delivery-cannon-chest",
      result = data_util.mod_prefix .. "delivery-cannon-chest",
      enabled = false,
      energy_required = 10,
      ingredients = {
        { "radar", 1 },
        { "steel-chest", 10 },
        { "concrete", 20 },
        { data_util.mod_prefix .. "heat-shielding", 10 },
      },
      requester_paste_multiplier = 1,
      always_show_made_in = false,
  },

  {
    type = "assembling-machine",
    name = data_util.mod_prefix.."delivery-cannon",
    minable = {
      mining_time = 0.5,
      result = data_util.mod_prefix.."delivery-cannon",
    },
    icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon.png",
    icon_size = 64,
    icon_mipmaps = 1,
    order = "a-a",
    max_health = 1500,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -2.9}, {2.5, 2.5}},
    resistances =
    {
      { type = "meteor", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "fire", percent = 99 },
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound = {
      apparent_volume = 1.5,
      idle_sound = {
        filename = "__base__/sound/idle1.ogg",
        volume = 0.6
      },
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t1-2.ogg",
          volume = 0.8
        }
      }
    },
    collision_mask = {
      "water-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer -- not spaceship
    },
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/delivery-cannon/delivery-cannon.png",
          frame_count = 1,
          line_length = 1,
          width = 320/2,
          height = 640/2,
          shift = {0,-2.5},
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/delivery-cannon/hr-delivery-cannon.png",
            frame_count = 1,
            line_length = 1,
            width = 320,
            height = 640,
            shift = {0,-2.5},
            scale = 0.5,
          }),
        },
        {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/delivery-cannon/delivery-cannon-shadow.png",
            shift = { 1.25, 1/32 },
            width = 470/2,
            height = 306/2,
            hr_version = data_util.hr({
                draw_as_shadow = true,
                filename = "__space-exploration-hr-graphics__/graphics/entity/delivery-cannon/hr-delivery-cannon-shadow.png",
                shift = { 1.25, 1/32 },
                width = 470,
                height = 306,
                scale = 0.5,
            })
        }
      }
    },
    crafting_categories = {"delivery-cannon"},
    crafting_speed = 1,
    energy_source =
    {
      type = "void",
    },
    energy_usage = "100kW",
    ingredient_count = 2,
    module_specification =
    {
      module_slots = 0
    },
    allowed_effects = {},
  },
  {
    type = "electric-energy-interface",
    name = data_util.mod_prefix .. "delivery-cannon-energy-interface",
    icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon.png",
    icon_size = 64,
    icon_mipmaps = 1,
    order = "z-d-a",
    allow_copy_paste = true,
    picture =
    {
      layers =
      {
        blank
      },
    },
    collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    selectable_in_game = false,
    collision_mask = {
      "water-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer,
    },
    selectable = false,
    continuous_animation = true,
    corpse = "medium-remnants",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "50MW",
      output_flow_limit = "0kW",
      buffer_capacity = "1000MJ",-- launch energy cost is removed from buffer
      drain = "100kW",
    },
    energy_production = "0kW",
    energy_usage = "0GW",
    flags = {
      "placeable-player",
      "player-creation",
      "hidden",
      "not-rotatable"
    },
    max_health = 1500,
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
  },

  {
    type = "container",
    name = data_util.mod_prefix .. "delivery-cannon-chest",
    icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-chest.png",
    icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "delivery-cannon-chest"},
    max_health = 1000,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-1.3,-1.3},{1.3,1.3}},
    collision_mask = {
      "water-tile",
      "item-layer",
      "object-layer",
      "player-layer",
      spaceship_collision_layer -- not spaceship
    },
    selection_box = {{-1.5,-1.5},{1.5,1.5}},
    inventory_size = 40,
    resistances = {
      { type = "meteor", percent = 99 },
      { type = "explosion", percent = 99 },
      { type = "impact", percent = 99 },
      { type = "fire", percent = 99 },
    },
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    picture = {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/delivery-cannon/delivery-cannon-chest.png",
          frame_count = 1,
          line_length = 1,
          width = 208/2,
          height = 200/2,
          shift = {0,0},
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/delivery-cannon/hr-delivery-cannon-chest.png",
            frame_count = 1,
            line_length = 1,
            width = 208,
            height = 200,
            shift = {0,0},
            scale = 0.5,
          }),
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/delivery-cannon/delivery-cannon-chest-shadow.png",
          frame_count = 1,
          line_length = 1,
          width = 278/2,
          height = 150/2,
          shift = {0.5625,0.5875},
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/delivery-cannon/hr-delivery-cannon-chest-shadow.png",
            frame_count = 1,
            line_length = 1,
            width = 278,
            height = 150,
            shift = {0.5625,0.5875},
            scale = 0.5,
          }),
        },
      }
    },
    circuit_wire_connection_point =
    {
        shadow =
        {
            red = {0.7, -1.3},
            green = {0.7, -1.3},
        },
        wire =
        {
            red = {0.7, -1.3},
            green = {0.7, -1.3},
        }
    },
    circuit_wire_max_distance = 12.5,
  },

  {
    type = "explosion",
    name = data_util.mod_prefix .. "delivery-cannon-beam",
    animations = {
      {
        filename = "__space-exploration-graphics__/graphics/entity/delivery-cannon/delivery-cannon-beam.png",
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
        b = 0.8,
        g = 1,
        r = 0.9
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
    type = "projectile",
    name = data_util.mod_prefix.."delivery-cannon-capsule-projectile",
    acceleration = 0,
    rotatable = false,
    animation = {
      filename = "__space-exploration-graphics__/graphics/entity/delivery-cannon/delivery-cannon-capsule.png",
      frame_count = 1,
      width = 58/2,
      height = 94/2,
      line_length = 1,
      priority = "high",
      shift = { 0, 0 },
      data_util.hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/delivery-cannon/hr-delivery-cannon-capsule.png",
        frame_count = 1,
        width = 58,
        height = 94,
        line_length = 1,
        priority = "high",
        shift = { 0, 0 },
        scale = 0.5,
      }),
    },
    flags = { "not-on-map", "placeable-off-grid"},
    light = { intensity = 0.2, size = 10},
    smoke = {
      {
        deviation = {
          0.15,
          0.15
        },
        frequency = 1,
        name = "smoke-fast",
        --name = "smoke-explosion-particle",
        --name = "soft-fire-smoke", -- lasts longer
        position = {0,0},
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
    name = data_util.mod_prefix.."delivery-cannon-capsule-shadow",
    acceleration = 0,
    rotatable = false,
    animation = {
      draw_as_shadow = true,
      filename = "__space-exploration-graphics__/graphics/entity/delivery-cannon/delivery-cannon-capsule-shadow.png",
      frame_count = 1,
      width = 98/2,
      height = 50/2,
      line_length = 1,
      priority = "high",
      shift = { 0, 0 },
      data_util.hr({
        draw_as_shadow = true,
        filename = "__space-exploration-hr-graphics__/graphics/entity/delivery-cannon/hr-delivery-cannon-capsule-shadow.png",
        frame_count = 1,
        width = 98,
        height = 50,
        line_length = 1,
        priority = "high",
        shift = { 0, 0 },
        scale = 0.5,
      }),
    },
    flags = { "not-on-map", "placeable-off-grid"},
  },
  {
    type = "explosion",
    name = data_util.mod_prefix.."delivery-cannon-capsule-explosion",
    animations = table.deepcopy(data.raw.explosion["medium-explosion"].animations),
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "create-particle",
            particle_name = "explosion-remnants-particle",
            initial_height = 0.5,
            initial_vertical_speed = 0.08,
            initial_vertical_speed_deviation = 0.08,
            offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
            repeat_count = 16,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.08,
          },
          {
            type = "create-particle",
            particle_name = "stone-particle",
            initial_height = 0.5,
            initial_vertical_speed = 0.1,
            initial_vertical_speed_deviation = 0.1,
            offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
            repeat_count = 60,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.08,
          },
          {
            action = {
              action_delivery = {
                target_effects = {
                  {
                    damage = {
                      amount = 5,
                      type = "meteor"
                    },
                    type = "damage"
                  },
                },
                type = "instant"
              },
              radius = 10,
              type = "area"
            },
            type = "nested-result"
          },
          {
            action = {
              action_delivery = {
                target_effects = {
                  {
                    damage = {
                      amount = 10,
                      type = "meteor"
                    },
                    type = "damage"
                  },
                },
                type = "instant"
              },
              radius = 4,
              type = "area"
            },
            type = "nested-result"
          },
          {
            action = {
              action_delivery = {
                target_effects = {
                  {
                    damage = {
                      amount = 35,
                      type = "meteor"
                    },
                    type = "damage"
                  },
                },
                type = "instant"
              },
              radius = 2,
              type = "area"
            },
            type = "nested-result"
          },
          {
            action = {
              action_delivery = {
                target_effects = {
                  {
                    damage = {
                      amount = 100,
                      type = "meteor"
                    },
                    type = "damage"
                  },
                },
                type = "instant"
              },
              radius = 1,
              type = "area"
            },
            type = "nested-result"
          },
        },
      },
    },
    flags = { "not-on-map", "placeable-off-grid"},
    light = { color = { r = 1, g = 0.9, b = 0.8 }, intensity = 1, size = 30 },
    sound = {
      aggregation = { max_count = 1, remove = true },
      variations = table.deepcopy(data.raw.explosion["medium-explosion"].sound.variations)
    },
  },
})
local delivery_cannon_settings = table.deepcopy(data.raw["programmable-speaker"][data_util.mod_prefix .. "struct-settings-string"])
delivery_cannon_settings.name = data_util.mod_prefix .. "delivery-cannon-settings"
delivery_cannon_settings.collision_box = data.raw["assembling-machine"][data_util.mod_prefix.."delivery-cannon"].collision_box
data:extend({delivery_cannon_settings})
