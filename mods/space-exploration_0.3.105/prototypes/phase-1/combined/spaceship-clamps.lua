local data_util = require("data_util")

local blank = {
  direction_count = 8,
  frame_count = 1,
  filename = "__space-exploration-graphics__/graphics/blank.png",
  width = 1,
  height = 1,
  priority = "low"
}
local blank_set = {
  backplates = blank,
  metals = blank,
  stone_path = blank,
  ties = blank,
}
local picture_left = {
  filename = "__space-exploration-graphics__/graphics/entity/spaceship-clamps/spaceship-clamps.png",
  width = 192/2,
  height = 160/2,
  x = 192/2,
  y = 160/2,
  priority = "high",
  shift = {0,0},
  variation_count = 1,
  hr_version = {
    filename = "__space-exploration-graphics__/graphics/entity/spaceship-clamps/hr-spaceship-clamps.png",
    width = 192,
    height = 160,
    x = 192,
    y = 160,
    priority = "high",
    scale = 0.5,
    shift = {0,0},
    variation_count = 1,
  },
}

local pictures_left = {
  backplates = blank,
  metals = picture_left,
  ties = blank,
  stone_path = blank
}
local picture_right = {
  filename = "__space-exploration-graphics__/graphics/entity/spaceship-clamps/spaceship-clamps.png",
  width = 192/2,
  height = 160/2,
  y = 160/2,
  priority = "high",
  shift = {0,0},
  variation_count = 1,
  hr_version = {
    filename = "__space-exploration-graphics__/graphics/entity/spaceship-clamps/hr-spaceship-clamps.png",
    width = 192,
    height = 160,
    y = 160,
    priority = "high",
    scale = 0.5,
    shift = {0,0},
    variation_count = 1,
  },
}
local pictures_right = {
  backplates = blank,
  metals = picture_right,
  ties = blank,
  stone_path = blank
}
local connection_point = {
  wire = { red = {0,0}, green = {0,0}, },
  shadow = { red = {0,0}, green = {0,0}, },
}
data:extend({
    {
        type = "item",
        name = data_util.mod_prefix .. "spaceship-clamp",
        icon = "__space-exploration-graphics__/graphics/icons/spaceship-clamp.png",
        icon_size = 64,
        order = "c-a",
        subgroup = "spaceship-structure",
        stack_size = 50,
        place_result = data_util.mod_prefix .. "spaceship-clamp-place",
    },
    {
        type = "recipe",
        name = data_util.mod_prefix .. "spaceship-clamp",
        result = data_util.mod_prefix .. "spaceship-clamp",
        enabled = false,
        energy_required = 30,
        ingredients = {
          { data_util.mod_prefix .. "aeroframe-scaffold", 10 },
          { data_util.mod_prefix .. "heavy-girder", 6 },
          { "electric-engine-unit", 10 },
          { "processing-unit", 10 },
        },
        requester_paste_multiplier = 1,
        always_show_made_in = false,
    },
    --[[
    {
        type = "item",
        name = data_util.mod_prefix .. "spaceship-clamp-anchor",
        icon = "__space-exploration-graphics__/graphics/icons/spaceship-clamp-anchor.png",
        icon_size = 64,
        order = "c-b",
        subgroup = "energy",
        stack_size = 50,
        place_result = data_util.mod_prefix .. "spaceship-clamp-anchor",
    },
    {
        type = "recipe",
        name = data_util.mod_prefix .. "spaceship-clamp-anchor",
        result = data_util.mod_prefix .. "spaceship-clamp-anchor",
        enabled = false,
        energy_required = 30,
        ingredients = {
          { data_util.mod_prefix .. "aeroframe-scaffold", 6 },
          { data_util.mod_prefix .. "heavy-girder", 10 },
          { "electric-engine-unit", 10 },
          { "processing-unit", 10 },
        },
        requester_paste_multiplier = 1,
        always_show_made_in = true,
    },]]
    {
        type = "technology",
        name = data_util.mod_prefix .. "spaceship-clamps",
        effects = {
          { type = "unlock-recipe", recipe = data_util.mod_prefix .. "spaceship-clamp" },
          --{ type = "unlock-recipe", recipe = data_util.mod_prefix .. "spaceship-clamp-anchor" },
        },
        icon = "__space-exploration-graphics__/graphics/technology/spaceship-clamps.png",
        icon_size = 128,
        order = "e-g",
        prerequisites = {
          data_util.mod_prefix .. "spaceship",
          data_util.mod_prefix .. "heavy-girder",
        },
        unit = {
         count = 500,
         time = 60,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "astronomic-science-pack-3", 1 },
           { data_util.mod_prefix .. "material-science-pack-1", 1 },
         }
       },
    },
    {
      type = "straight-rail",
      name = data_util.mod_prefix .. "spaceship-clamp-place",
      minable = {mining_time = 0.5, result = data_util.mod_prefix .. "spaceship-clamp"},
      se_allow_in_space = true,
      corpse = "straight-rail-remnants",
      collision_box = {{-0.99,-0.99},{0.99,0.99}},
      collision_mask = {"player-layer", "floor-layer", "item-layer"},
      selection_box = {{-1,-1},{1,1}},
      damaged_trigger_effect = {
        entity_name = "wall-damaged-explosion",
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
      dying_explosion = "rail-explosion",
      flags = {
        "placeable-neutral",
        "player-creation",
      },
      icon = "__space-exploration-graphics__/graphics/icons/spaceship-clamp.png",
      icon_mipmaps = 1,
      icon_size = 64,
      max_health = 100,
      pictures = {
        curved_rail_horizontal_left_bottom = blank_set,
        curved_rail_horizontal_left_top = blank_set,
        curved_rail_horizontal_right_bottom = blank_set,
        curved_rail_horizontal_right_top = blank_set,
        curved_rail_vertical_left_bottom = blank_set,
        curved_rail_vertical_left_top = blank_set,
        curved_rail_vertical_right_bottom = blank_set,
        curved_rail_vertical_right_top = blank_set,
        rail_endings = {
          sheets = {
            {
              filename = "__space-exploration-graphics__/graphics/blank.png",
              width = 1,
              height = 1,
              flags = {
                "low-object"
              },
              priority = "low",
            },
          }
        },
        straight_rail_diagonal_left_bottom = blank_set,
        straight_rail_diagonal_left_top = blank_set,
        straight_rail_diagonal_right_bottom = blank_set,
        straight_rail_diagonal_right_top = blank_set,
        straight_rail_horizontal = pictures_left,
        straight_rail_vertical = pictures_right,
      },
      resistances = {
        {
          percent = 100,
          type = "fire"
        },
        {
          percent = 80,
          type = "acid"
        }
      },
    },
    {
      type = "constant-combinator",
      name = data_util.mod_prefix .. "spaceship-clamp",
      placeable_by = {item=data_util.mod_prefix .. "spaceship-clamp", count = 1},
      minable = {mining_time = 0.5, result = data_util.mod_prefix .. "spaceship-clamp"},
      flags = {
        "placeable-neutral",
        "player-creation",
      },
      icon = "__space-exploration-graphics__/graphics/icons/spaceship-clamp.png",
      icon_mipmaps = 1,
      icon_size = 64,
      order="c",
      max_health = 1000,
      corpse = "small-remnants",
      collision_box = {{-0.99,-0.99},{0.99,0.99}},
      collision_mask = {"player-layer", "floor-layer", "item-layer"},
      selection_box = {{-1,-1},{1,1}},
      scale_info_icons = false,
      item_slot_count = 1,
      sprites =
      {
        north = blank,
        east = picture_right,
        south = blank,
        west = picture_left
      },
      activity_led_sprites =
      {
          north = blank,
          east = blank,
          south = blank,
          west = blank
      },
      activity_led_light =
      {
          intensity = 0.8,
          size = 1,
      },
      activity_led_light_offsets =
      {
          {0, 0},
          {0, 0},
          {0, 0},
          {0, 0}
      },
      circuit_wire_connection_points =
      {
          connection_point,  connection_point,  connection_point,  connection_point,
      },
      circuit_wire_max_distance = 0
    },
})
