local data_util = require("data_util")

local landing_pad_collision_box = {{-4.35, -4.35}, {4.35, 4.35}}
local landing_pad_settings = table.deepcopy(data.raw["programmable-speaker"][data_util.mod_prefix .. "struct-settings-string"])
landing_pad_settings.name = data_util.mod_prefix .. "rocket-landing-pad-settings"
landing_pad_settings.collision_box = landing_pad_collision_box
data:extend({
  landing_pad_settings,
  {
      type = "container",
      name = data_util.mod_prefix .. "rocket-landing-pad", -- "rocket-launch-pad-chest",
      icon = "__space-exploration-graphics__/graphics/icons/rocket-landing-pad.png",
      icon_size = 32,
      order = "z-z",
      flags = {"placeable-neutral", "player-creation"},
      minable = {mining_time = 0.5, result = data_util.mod_prefix .. "rocket-landing-pad"},
      max_health = 5000,
      corpse = "big-remnants",
      dying_explosion = "medium-explosion",
      collision_box = landing_pad_collision_box,
      collision_mask = {
        "water-tile",
        "item-layer",
        "object-layer",
        "player-layer",
        spaceship_collision_layer -- not spaceship
      },
      selection_box = {{-4.35, -4.35}, {4.35, 4.35}},
      inventory_size = rocket_capacity + 100, -- 100 for potential recovered rocket sections and space capsule
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
          filename = "__space-exploration-graphics__/graphics/entity/rocket-landing-pad/rocket-landing-pad.png",
          height = 384,
          shift = { 0, -0.5 },
          width = 352,
          hr_version = {
                filename = "__space-exploration-graphics__/graphics/entity/rocket-landing-pad/hr-rocket-landing-pad.png",
                height = 384 * 2,
                shift = { 0, -0.5 },
                width = 352 * 2,
                scale = 0.5
          }
      },
      circuit_wire_connection_point =
      {
          shadow =
          {
              red = {-3.5, 2.7},
              green = {-3.6, 2.6},
          },
          wire =
          {
              red = {-3.5, 2.7},
              green = {-3.6, 2.6},
          }
      },
      circuit_wire_max_distance = 12.5,
  },
})
