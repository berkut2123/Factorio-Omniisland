local data_util = require("data_util")

local health_multiplier = 10

-- projectile: invisible. Deals damage if it hits stuff, maybe destroys floor too.
-- graphic: The visible graphic, may also be mined.
-- targetable: invisible. exists so that turrets will shoot it, should only exist when moving.
local blank = {
  filename = "__space-exploration-graphics__/graphics/blank.png",
  priority = "high",
  frame_count = 1,
  height = 1,
  width = 1,
}
local meteors = {
  ["meteor-01"] = {209, 138},
  ["meteor-02"] = {165,129},
  ["meteor-03"] = {151,139},
  ["meteor-04"] = {216,110},
  ["meteor-05"] = {154,147},
  ["meteor-06"] = {154,132},
  ["meteor-07"] = {193,120},
  ["meteor-08"] = {136,117},
  ["meteor-09"] = {157,115},
  ["meteor-10"] = {198,153},
  ["meteor-11"] = {190,115},
  ["meteor-12"] = {229,126},
  ["meteor-13"] = {151,125},
  ["meteor-14"] = {137,117},
  ["meteor-15"] = {201,141},
  ["meteor-16"] = {209,154},
}
local pictures_small = {}
local pictures_medium = {}
for name, meteor in pairs(meteors) do
  table.insert(pictures_small,
  {
      filename = "__space-exploration-graphics__/graphics/entity/meteor/sr/"..name..".png",
      width = math.floor(meteor[1]/2),
      height = math.floor(meteor[2]/2),
      priority = "high",
      shift = { 0, 0 },
      scale = 0.2,
  })
  table.insert(pictures_medium,
  {
      filename = "__space-exploration-graphics__/graphics/entity/meteor/sr/"..name..".png",
      width = math.floor(meteor[1]/2),
      height = math.floor(meteor[2]/2),
      priority = "high",
      shift = { 0, 0 },
      tint={r = 0.75, g = 0.75, b = 0.75},
      scale = 0.6,
  })
end
local resistances = {
  -- no laser
  { type = "explosion", percent = 10 },
  { type = "physical", percent = 20},
  { type = "impact", percent = 50 },
  { type = "electric", percent = 50 },
  { type = "fire", percent = 90 },
  { type = "poison", percent = 100 },
  { type = "meteor", percent = 100 },
}

data:extend({
  -- SPECK
  { -- just a visual for motion
    type = "simple-entity",
    name = data_util.mod_prefix.."spaceship-speck-graphic",
    direction_only = true,
    flags = { "not-on-map", "placeable-off-grid" },
    acceleration = 0,
    collision_mask = {"not-colliding-with-itself"},
    collision_box = { { -0.0, -0.0 }, { 0.0, 0.0 } },
    pictures = {
      filename = "__space-exploration-graphics__/graphics/entity/spaceship-particle/speck.png",
      frame_count = 1,
      height = 50,
      priority = "high",
      width = 3
    },
    localised_name = {"entity-name.small-asteroid"},
  },

  -- small-rock
  {
    type = "simple-entity-with-force",
    name = data_util.mod_prefix .. "spaceship-obstacle-rock-small-targetable",
    selectable_in_game = false,
    collision_box = { { -0, -0 }, { 0, 0 } },
    collision_mask = {"not-colliding-with-itself"},
    selection_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/small-scorchmark.png",
    icon_size = 64,
    max_health = 20*health_multiplier,
    order = "s-e-w-f",
    render_layer = "object",
    pictures = pictures_small,
    dying_explosion = "explosion-hit",
    localised_name = {"entity-name.small-asteroid"},
    resistances = resistances,
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "spaceship-obstacle-rock-small-graphic",
    selectable_in_game = true,
    selection_priority = 2,
    count_as_rock_for_filtered_deconstruction = true,
    collision_box = { { -0, -0 }, { 0, 0 } },
    collision_mask = {"not-colliding-with-itself"},
    selection_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
    minable = {
      mining_particle = "stone-particle",
      mining_time = 0.2,
      results = {
        {name = "stone", amount_min = 1, amount_max = 3},
        {name = "iron-ore", amount_min = 1, amount_max = 3},
        {name = "copper-ore", amount_min = 1, amount_max = 3},
      },
    },
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/small-scorchmark.png",
    icon_size = 64,
    max_health = 20*health_multiplier,
    order = "s-e-w-f",
    render_layer = "object",
    pictures = pictures_small,
    dying_explosion = "explosion-hit",
    localised_name = {"entity-name.small-asteroid"},
    resistances = resistances,
  },
  {
    type = "projectile",
    name = data_util.mod_prefix.."spaceship-obstacle-rock-small-projectile",
    direction_only = true,
    flags = { "not-on-map", "placeable-off-grid" },
    acceleration = 0,
    collision_box = { { -0.05, -0.25 }, { 0.05, 0.25 } },
    action = {
      action_delivery = {
        target_effects = {
          {
            damage = {
              amount = 200,
              type = "meteor"
            },
            type = "damage"
          },
          { type = "create-entity", entity_name = "explosion-hit" },
        },
        type = "instant"
      },
      type = "direct"
    },
    animation = blank,
    localised_name = {"entity-name.small-asteroid"},
  },

  -- ROCK MEDIUM
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "spaceship-obstacle-rock-medium-graphic",
    selectable_in_game = true,
    selection_priority = 2,
    count_as_rock_for_filtered_deconstruction = true,
    minable = {
      mining_particle = "stone-particle",
      mining_time = 0.5,
      results = {
        {name = "stone", amount_min = 0, amount_max = 15},
        {name = "iron-ore", amount_min = 0, amount_max = 15},
        {name = "copper-ore", amount_min = 0, amount_max = 15},
      },
    },
    collision_box = { { -0, -0 }, { 0, 0 } },
    collision_mask = {"not-colliding-with-itself"},
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/small-scorchmark.png",
    icon_size = 32,
    max_health = 200*health_multiplier,
    order = "s-e-w-f",
    render_layer = "object",
    pictures = pictures_medium,
    dying_explosion = "big-explosion-hit",
    localised_name = {"entity-name.small-asteroid"},
    resistances = resistances,
  },
  {
    type = "simple-entity-with-force",
    name = data_util.mod_prefix .. "spaceship-obstacle-rock-medium-targetable",
    selectable_in_game = false,
    collision_box = { { -0, -0 }, { 0, 0 } },
    collision_mask = {"not-colliding-with-itself"},
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    flags = { "placeable-neutral", "player-creation", "placeable-off-grid"},
    icon = "__base__/graphics/icons/small-scorchmark.png",
    icon_size = 64,
    max_health = 200*health_multiplier,
    order = "s-e-w-f",
    render_layer = "object",
    pictures = blank,
    dying_explosion = "big-explosion-hit",
    localised_name = {"entity-name.small-asteroid"},
    resistances = resistances,
  },
  {
    type = "projectile",
    name = data_util.mod_prefix.."spaceship-obstacle-rock-medium-projectile",
    direction_only = true,
    flags = { "not-on-map", "placeable-off-grid" },
    acceleration = 0,
    collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } },
    action = {
      action_delivery = {
        target_effects = {
          { type = "nested-result", action = { type = "area", radius = 0.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 400, type = "meteor" }}}},
          }},
          { type = "nested-result", action = { type = "area", radius = 1.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 40, type = "meteor" }}}},
          }},
          { type = "nested-result", action = { type = "area", radius = 2.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 5, type = "meteor" }}}},
          }},
          { type = "create-entity", entity_name = "big-explosion-hit" },
        },
        type = "instant"
      },
      type = "direct"
    },
    animation = blank,
    localised_name = {"entity-name.small-asteroid"},
  },



  -- ROCK large
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "spaceship-obstacle-rock-large-graphic",
    selectable_in_game = true,
    selection_priority = 2,
    count_as_rock_for_filtered_deconstruction = true,
    minable = {
      mining_particle = "stone-particle",
      mining_time = 4,
      results = {
        {name = "stone", amount_min = 0, amount_max = 5000},
        {name = "iron-ore", amount_min = 0, amount_max = 5000},
        {name = "copper-ore", amount_min = 0, amount_max = 5000},
        {name = "uranium-ore", amount_min = 0, amount_max = 500},
      },
    },
    collision_box = { { -0, -0 }, { 0, 0 } },
    collision_mask = {"not-colliding-with-itself"},
    selection_box = { { -1, -1 }, { 1, 1 } },
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/small-scorchmark.png",
    icon_size = 64,
    max_health = 2000*health_multiplier,
    order = "s-e-w-f",
    render_layer = "object",
    pictures = pictures_medium,
    dying_explosion = "big-explosion-hit",
    localised_name = {"entity-name.small-asteroid"},
    resistances = resistances,
  },
  {
    type = "simple-entity-with-force",
    name = data_util.mod_prefix .. "spaceship-obstacle-rock-large-targetable",
    selectable_in_game = false,
    collision_box = { { -0, -0 }, { 0, 0 } },
    collision_mask = {"not-colliding-with-itself"},
    selection_box = { { -1, -1 }, { 1, 1 } },
    flags = { "placeable-neutral", "player-creation", "placeable-off-grid"},
    icon = "__base__/graphics/icons/small-scorchmark.png",
    icon_size = 64,
    max_health = 2000*health_multiplier,
    order = "s-e-w-f",
    render_layer = "object",
    pictures = blank,
    dying_explosion = "big-explosion-hit",
    localised_name = {"entity-name.small-asteroid"},
    resistances = resistances,
  },
  {
    type = "projectile",
    name = data_util.mod_prefix.."spaceship-obstacle-rock-large-projectile",
    direction_only = true,
    flags = { "not-on-map", "placeable-off-grid" },
    acceleration = 0,
    collision_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    action = {
      action_delivery = {
        target_effects = {
          { type = "nested-result", action = { type = "area", radius = 0.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 4000, type = "meteor" }}}},
          }},
          { type = "nested-result", action = { type = "area", radius = 1.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 150, type = "meteor" }}}},
          }},
          { type = "nested-result", action = { type = "area", radius = 2.5,
              action_delivery = { type = "instant", target_effects = { { type = "damage", damage = { amount = 150, type = "meteor" }}}},
          }},
          { type = "create-entity", entity_name = "big-explosion-hit" },
        },
        type = "instant"
      },
      type = "direct"
    },
    animation = blank,
    localised_name = {"entity-name.small-asteroid"},
  },
})
