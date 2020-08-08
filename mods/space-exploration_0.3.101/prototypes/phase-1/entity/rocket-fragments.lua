local data_util = require("data_util")
--[[
meteors and crashing rocket parts

Big sections:
general concept is have a script-controlled entity (and paired shadow)
moved from a spawn point to a predesiganted landing point.
It spawns smoke as moved.
probably use a projectile type for the primary pieces.
Upon impact there are explosions.

Some cargo part survive, some are lost.
Carried resources are reduecd by similar loss amount and then distributed among survivng containers.

additional small particles spawned during falling they can fall normally.

-- parts of rockets / ships that fall.


rockets are made of 100 x
heat shielding 20
low density structure 10
low density structure 10
10 rocket control unit
5 cargo pod (seperate)
1 rocket fuel tank
roughly 1.25k of each resource
125k total
if a scrap is 0.3 of a resource
then returning more than 4 166 666 scrap would be bad.

if there are say
4 big fragments -> 100 scrap each = 400
6 medium fragments -> 50 scrap each = 300
20 small fragments -> 20 scrap each = 400
20 tiny fragments -> 10 scrap each = 200
1.1k scrap total, recycle value is 330
]]--


local resistances = {
  { type = "fire", percent = 100 },
  { type = "explosion", percent = 100 },
  { type = "impact", percent = 50 }
}

--{"floor-layer", "player-layer", "water-tile", "object-layer"},
local collision_mask_blocking = {"player-layer", "object-layer"}
local collision_mask_nonblocking = {"item-layer"}

local fragments = { -- name = size, width, height, shadoww, shadowh, shadowoffx, shadowoffy
  ["rocket-fragment-big-a"] =     {4, 215, 185, 234, 131, 27/32, 38/32},
  ["rocket-fragment-big-b"] =     {4, 163, 129, 164, 109, 1/32,  12/32},
  ["rocket-fragment-big-c"] =     {4, 160, 131, 136, 77,  12/32, 18/32},
  ["rocket-fragment-big-d"] =     {4, 108, 86,  123, 52,  22/32, 26/32},
  ["rocket-fragment-medium-a"] =  {3, 109, 81,  115, 57,  6/32,  14/32},
  ["rocket-fragment-medium-b"] =  {3, 111, 81,  117, 82,  14/32, 18/32},
  ["rocket-fragment-medium-c"] =  {3, 120, 75,  122, 62,  2/32,  7/32},
  ["rocket-fragment-small-a"] =   {2, 65,  68,  60,  53,  1/32,  6/32},
  ["rocket-fragment-small-b"] =   {2, 65,  67,  77,  62,  7/32,  6/32},
  ["rocket-fragment-small-c"] =   {2, 69,  38,  76,  35,  3/32,  5/32},
  ["rocket-fragment-small-d"] =   {2, 79,  59,  80,  54,  6/32,  3/32},
  ["rocket-fragment-small-e"] =   {2, 69,  74,  77,  66,  5/32,  5/32},
  ["rocket-fragment-small-f"] =   {2, 55,  49,  59,  39,  4/32,  6/32},
  ["rocket-fragment-small-g"] =   {2, 62,  64,  60,  59,  12/32, 8/32},
  ["rocket-fragment-small-h"] =   {2, 59,  48,  65,  31,  4/32,  8/32},
  ["rocket-fragment-small-i"] =   {2, 41,  49,  47,  41,  5/32,  7/32},
  ["rocket-fragment-small-j"] =   {2, 68,  42,  69,  43,  1/32,  3/32},
  ["rocket-fragment-tiny-a"] =    {1, 47,  22,  47,  15,  0/32,  5/32},
  ["rocket-fragment-tiny-b"] =    {1, 48,  36,  49,  35,  2/32,  2/32},
  ["rocket-fragment-tiny-c"] =    {1, 44,  33,  48,  25,  3/32,  5/32},
  ["rocket-fragment-tiny-d"] =    {1, 58,  35,  56,  30,  1/32,  1/32},
  ["rocket-fragment-tiny-e"] =    {1, 21,  18,  23,  12,  3/32,  5/32},
  ["rocket-fragment-tiny-f"] =    {1, 46,  30,  53,  25,  3/32,  5/32},

  ["cargo-fragment-a"] =          {3, 112, 81,  117, 49,  6/32,  14/32, 0.75, true},
  ["cargo-fragment-b"] =          {3, 118, 97,  125, 82,  6/32,  14/32, 0.75, true},
  ["cargo-fragment-c"] =          {3, 138, 138, 148, 69,  6/32,  14/32, 0.75, true},
  ["cargo-fragment-d"] =          {3, 95,  62,  88,  38,  6/32,  14/32, 0.75, true},
}

local function get_explosion(size)
  if size == 2 then
    return data_util.mod_prefix.."medium-explosion"
  elseif size == 3 then
    return data_util.mod_prefix.."large-explosion"
  elseif size == 4 then
    return data_util.mod_prefix.."huge-explosion"
  end

  return data_util.mod_prefix.."small-explosion"
end

for name, fragment in pairs(fragments) do
  local size = fragment[1]
  local width = fragment[2]
  local height = fragment[3]
  local shadow_width = fragment[4]
  local shadow_height = fragment[5]
  local shadow_x = fragment[6]
  local shadow_y = fragment[7]
  local scale = fragment[8] or 1
  local cargo = fragment[9] == true
  local scrap = 10
  if size > 3 then
    scrap = 100
  elseif size > 2 then
    scrap = 50
  elseif size > 1 then
    scrap = 20
  end

  data:extend({
    {
      type = "projectile",
      name = data_util.mod_prefix.."falling-" .. name,
      acceleration = 0,
      rotatable = false,
      animation = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-fragments/"..name..".png",
        frame_count = 1,
        width = width,
        height = height,
        line_length = 1,
        priority = "high",
        shift = { 0, 0 },
        scale = scale
      },
      action = {
        action_delivery = {
          target_effects = {
            {
              action = {
                action_delivery = {
                  target_effects = {
                    {
                      damage = {
                        amount = 5 + 2.5 * size,
                        type = "explosion"
                      },
                      type = "damage"
                    },
                    {
                      entity_name = "explosion",
                      type = "create-entity"
                    }
                  },
                  type = "instant"
                },
                radius = 0.5 + 0.2 * size,
                type = "area"
              },
              type = "nested-result"
            },
            {
              type = "create-entity",
              entity_name = get_explosion(size),
            },
            {
              type = "create-entity",
              entity_name = "small-scorchmark",
              check_buildability = true,
            },
            {
              type = "create-entity",
              check_buildability = false,
              entity_name = data_util.mod_prefix.."static-"..name,
            },
            {
              type = "create-entity",
              entity_name = data_util.mod_prefix .. "trigger-movable-debris",
              trigger_created_entity = true,
            },
          },
          type = "instant"
        },
        type = "direct"
      },
      flags = { "not-on-map" },
      light = { intensity = 0.1 + 0.05 * size, size = 10},
      smoke = {
        {
          deviation = {
            0.15,
            0.15
          },
          frequency = 1,
          --name = "smoke-fast",
          --name = "smoke-explosion-particle",
          name = "soft-fire-smoke", -- lasts longer
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
      name = data_util.mod_prefix.."shadow-" .. name,
      acceleration = 0,
      rotatable = false,
      animation = {
        draw_as_shadow = true,
        filename = "__space-exploration-graphics__/graphics/entity/rocket-fragments/shadows/"..name..".png",
        frame_count = 1,
        width = shadow_width,
        height = shadow_height,
        line_length = 1,
        priority = "high",
        shift = { 0, 0 },
        scale = scale
      },
      flags = { "not-on-map" },
    },
    {
      type = "simple-entity",
      name = data_util.mod_prefix.."static-"..name,
      localised_name = cargo and  {"entity-name.destroyed-cargo-pod"} or {"entity-name.rocket-fragment"},
      icon = "__base__/graphics/icons/ship-wreck/small-ship-wreck.png",
      icon_size = 64,
      flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
      subgroup = "wrecks",
      order = "d[remnants]-d[ship-wreck]-c[small]-a",
      max_health = size * 100,
      minable = {
        mining_time = 0.2,
        results={
          {name= data_util.mod_prefix.."scrap", amount=scrap},
        }
      },
      resistances = resistances,
      collision_box = size > 3 and {{-1, -1}, {1, 1}} or {{-0.7, -0.7}, {0.7, 0.7}},
      collision_mask = size > 3 and collision_mask_blocking or collision_mask_nonblocking,
      selection_box = {{-1.3, -1.1}, {1.3, 1.1}},
      selection_priority = 2,
      count_as_rock_for_filtered_deconstruction = true,
      picture =
      {
        layers = {
          {
            filename = "__space-exploration-graphics__/graphics/entity/rocket-fragments/"..name..".png",
            width = width,
            height = height,
            shift = { 0, 0 },
            scale = scale
          },
          {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics__/graphics/entity/rocket-fragments/shadows/"..name..".png",
            width = shadow_width,
            height = shadow_height,
            shift = { shadow_x, shadow_y },
            scale = scale
          }
        }
      },
      render_layer = "object",
    },
    {
      type = "projectile",
      name = data_util.mod_prefix.."space-" .. name,
      acceleration = -0.001,
      rotatable = false,
      animation = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-fragments/"..name..".png",
        frame_count = 1,
        width = width,
        height = height,
        line_length = 1,
        priority = "high",
        shift = { 0, 0 },
        scale = scale
      },
      action = {
        action_delivery = {
          target_effects = {
            {
              action = {
                action_delivery = {
                  target_effects = {
                    {
                      damage = {
                        amount = 5 + 2.5 * size,
                        type = "explosion"
                      },
                      type = "damage"
                    },
                    {
                      entity_name = "explosion",
                      type = "create-entity"
                    }
                  },
                  type = "instant"
                },
                radius = 0.5 + 0.2 * size,
                type = "area"
              },
              type = "nested-result"
            },
            {
              type = "create-entity",
              check_buildability = false,
              entity_name = data_util.mod_prefix.."static-"..name,
            },
            {
              type = "create-entity",
              entity_name = data_util.mod_prefix .. "trigger-movable-debris",
              trigger_created_entity = true,
            },
          },
          type = "instant"
        },
        type = "direct"
      },
      flags = { "not-on-map" },
      light = { intensity = 0.1 + 0.05 * size, size = 10},
      smoke = {
        {
          deviation = {
            0.15,
            0.15
          },
          frequency = 1,
          --name = "smoke-fast",
          --name = "smoke-explosion-particle",
          name = "soft-fire-smoke", -- lasts longer
          position = {0,0},
          slow_down_factor = 1,
          starting_frame = 3,
          starting_frame_deviation = 5,
          starting_frame_speed = 0,
          starting_frame_speed_deviation = 5
        }
      },
    },
  })
end


-- safe version
data:extend({
  {
    type = "projectile",
    name = data_util.mod_prefix.."falling-cargo-pod",
    acceleration = 0,
    rotatable = false,
    animation = {
      filename = "__space-exploration-graphics__/graphics/entity/cargo-pod/cargo-pod.png",
      frame_count = 1,
      width = 147,
      height = 194,
      line_length = 1,
      priority = "high",
      shift = { 0, 0 },
      scale = 0.5,
    },
    flags = { "not-on-map" },
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
    name = data_util.mod_prefix.."shadow-cargo-pod",
    acceleration = 0,
    rotatable = false,
    animation = {
      draw_as_shadow = true,
      filename = "__space-exploration-graphics__/graphics/entity/cargo-pod/cargo-pod-shadow.png",
      frame_count = 1,
      width = 167,
      height = 164,
      line_length = 1,
      priority = "high",
      shift = { 0, 0 },
      scale = 0.5,
    },
    flags = { "not-on-map" },
  },
})
