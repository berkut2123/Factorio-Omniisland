local data_util = require("data_util")

-- generic triggers
data:extend({
  { -- dummy explosion entity for alerts
    type = "explosion",
    name = data_util.mod_prefix .. "dummy-explosion",
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
      "not-on-map"
    },
  },
  { -- some debris has been added to the surface, in space it should move
    type = "explosion",
    name = data_util.mod_prefix .. "trigger-movable-debris",
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
      "not-on-map"
    },
  },
})


--[[
vanila explosions:
"big-artillery-explosion" -- huge smoke plume but very little debris
"big-explosion" -- biggest overall, but smaller plume
"massive-explosion" -- more debris
"medium-explosion" -- medium and wider
"ground-explosion" -- medium but higher, and with stone particles

SE explosions:
Huge
large
Medium
Small
]]--

local big_explsion_hit = table.deepcopy(data.raw.explosion["explosion-hit"])
big_explsion_hit.name = "big-explosion-hit"
big_explsion_hit.animations[1].scale = 1.5
data:extend({big_explsion_hit})

local function make_explosion(magnitude, name, animation, sound) -- magnitude is 1,2,3,4
  data:extend({
    {
      type = "explosion",
      name = data_util.mod_prefix..name,
      animations = {animation},
      created_effect = {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            {
              type = "create-particle",
              particle_name = "explosion-remnants-particle",
              initial_height = 0.5,
              initial_vertical_speed = 0.06 + 0.01 * magnitude,
              initial_vertical_speed_deviation = 0.06 + 0.01 * magnitude,
              offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
              repeat_count = 10 + 5 * magnitude,
              speed_from_center = 0.06 + 0.01 * magnitude,
              speed_from_center_deviation = 0.06 + 0.01 * magnitude,
            },
            {
              type = "create-particle",
              particle_name = "stone-particle",
              initial_height = 0.5,
              initial_vertical_speed = 0.1 + 0.05 * magnitude,
              initial_vertical_speed_deviation = 0.1 + 0.05 * magnitude,
              offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
              repeat_count = 40 + 20 * magnitude,
              speed_from_center = 0.06 + 0.02 * magnitude,
              speed_from_center_deviation = 0.06 + 0.02 * magnitude,
            }
          },
        },
      },
      flags = { "not-on-map" },
      light = { color = { r = 1, g = 0.9, b = 0.8 }, intensity = 0.8 + 0.1 * magnitude, size = 30 + 5 * magnitude },
      sound = {
        aggregation = { max_count = 1, remove = true },
        variations = sound
      },
    },

  })
end


make_explosion(1, "small-explosion", {
  filename = "__base__/graphics/entity/medium-explosion/medium-explosion.png",
  width = 112,
  height = 94,
  line_length = 6,
  frame_count = 54,
  animation_speed = 0.5,
  priority = "high",
  shift = { -0.56, -0.96 },
  scale = 0.75,
},{
  { filename = "__base__/sound/small-explosion-1.ogg", volume = 0.7 },
  { filename = "__base__/sound/small-explosion-2.ogg", volume = 0.7 }
})
make_explosion(2, "medium-explosion", {
  filename = "__base__/graphics/entity/medium-explosion/medium-explosion.png",
  width = 112,
  height = 94,
  line_length = 6,
  frame_count = 54,
  animation_speed = 0.5,
  priority = "high",
  shift = { -0.56, -0.96 },
  scale = 1,
}, {
  { filename = "__base__/sound/fight/large-explosion-1.ogg", volume = 0.7 },
  { filename = "__base__/sound/fight/large-explosion-2.ogg", volume = 0.7 }
})
make_explosion(3, "large-explosion", {
  animation_speed = 0.5,
  filename = "__base__/graphics/entity/big-explosion/big-explosion.png",
  flags = { "compressed" },
  frame_count = 47,
  height = 245,
  line_length = 6,
  shift = { 0.1875, -0.75 },
  width = 197,
  scale = 1,
},{
  { filename = "__base__/sound/fight/large-explosion-1.ogg", volume = 0.8 },
  { filename = "__base__/sound/fight/large-explosion-2.ogg", volume = 0.8 }
})
make_explosion(4, "huge-explosion", {
  animation_speed = 0.5,
  filename = "__base__/graphics/entity/bigass-explosion/hr-bigass-explosion-36f.png",
  flags = { "compressed" },
  frame_count = 36,
  width = 324,
  height = 416,
  shift = { 0, -1.5 },
  stripes = {
    { filename = "__base__/graphics/entity/bigass-explosion/hr-bigass-explosion-36f-1.png", height_in_frames = 3, width_in_frames = 6 },
    { filename = "__base__/graphics/entity/bigass-explosion/hr-bigass-explosion-36f-2.png", height_in_frames = 3, width_in_frames = 6 }
  },
  scale = 1,
}, {
  { filename = "__base__/sound/explosion1.ogg", volume = 1 },
})


data:extend({
  {
    type = "explosion",
    name = data_util.mod_prefix.."meteor-explosion",
    animations = {{
      animation_speed = 0.5,
      filename = "__base__/graphics/entity/bigass-explosion/hr-bigass-explosion-36f.png",
      flags = { "compressed" },
      frame_count = 36,
      width = 324,
      height = 416,
      shift = { 0, -1.5 },
      stripes = {
        { filename = "__base__/graphics/entity/bigass-explosion/hr-bigass-explosion-36f-1.png", height_in_frames = 3, width_in_frames = 6 },
        { filename = "__base__/graphics/entity/bigass-explosion/hr-bigass-explosion-36f-2.png", height_in_frames = 3, width_in_frames = 6 }
      },
      scale = 1,
    }},
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          -- TODO add rock fragments equivalent to "explosion-remnants-particle" from small rock graphics
          {
            type = "create-particle",
            particle_name = "stone-particle",
            initial_height = 0.5,
            initial_vertical_speed = 0.3,
            initial_vertical_speed_deviation = 0.3,
            offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
            repeat_count = 120,
            speed_from_center = 0.2,
            speed_from_center_deviation = 0.2,
          }
        },
      },
    },
    flags = { "not-on-map" },
    light = { color = { r = 1, g = 0.9, b = 0.8 }, intensity = 1, size = 50 },
    sound = {
      aggregation = { max_count = 1, remove = true },
      variations = { filename = "__base__/sound/explosion1.ogg", volume = 1 }
    },
  },

})
