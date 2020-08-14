local data_util = require("data_util")
local shadow =
{
  filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-shadow.png",
  priority = "high",
  width = 951,
  height = 491,
  frame_count = 1,
  shift = {2 + 3/32, 1 + 22/32},
  draw_as_shadow = true,
  scale=0.5,
}
local shadow_anim = table.deepcopy(shadow)
shadow_anim.repeat_count = 30
local off_layer = {
  layers = {
    shadow,
    {
      filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-off.png",
      priority = "high",
      width = 691,
      height = 737,
      frame_count = 1,
      shift = {0, -8/32},
      scale=0.5,
    },
  }
}
data:extend({
  {
    type = "assembling-machine",
    name = data_util.mod_prefix .. "core-miner",
    icon = "__space-exploration-graphics__/graphics/icons/core-miner.png",
    selection_priority = 0,
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "core-miner"},
    max_health = 5000,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-5.2, -5.2}, {5.2, 5.2}},
    collision_mask = {
      "item-layer",
      "object-layer",
      "player-layer",
      "water-tile",
      space_collision_layer
    },
    render_layer = "lower-object-above-shadow",
    selection_box = {{-5.5, -5.5}, {5.5, 5.5}},
    fluid_boxes =
    {
      {
        production_type = "output",
        base_area = 1,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, -5.85} }},
        secondary_draw_orders = { north = -1 }
      },
    },
    animation = off_layer,
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    energy_usage = "50MW",
    energy_source = {type = "void"},
    crafting_speed = 1,
    crafting_categories = {"dummy"},
  },
  {
    type = "mining-drill",
    name = data_util.mod_prefix .. "core-miner-drill",
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "core-miner"},
    selection_priority = 10,
    icon = "__space-exploration-graphics__/graphics/icons/core-miner.png",
    icon_size = 32,
    order = "zzz",
    flags = {"placeable-neutral", "placeable-player", "player-creation", "not-blueprintable", "not-deconstructable", "placeable-off-grid"},
    placeable_by = {item = data_util.mod_prefix .. "core-miner", count=1},
    max_health = 5000,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-5.2, -5.2}, {5.2, 5.2}},
    selection_box = {{-5.5, -5.5}, {5.5, 5.5}},
    resource_categories = { data_util.mod_prefix .. "core-mining" },
    resource_searching_radius = 2,
    mining_speed = 150,
    always_draw_idle_animation = false,
    energy_usage = "50MW",
    vector_to_place_result = { 0, -5.85 },
    animations = {
      layers = {
        shadow_anim,
        {
          priority = "high",
          width = 691,
          height = 737,
          frame_count = 30,
          animation_speed = 1,
          shift = {0, -8/32},
          scale=0.5,
          stripes =
          {
            {
              filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-1.png",
              width_in_frames = 2,
              height_in_frames = 2,
            },
            {
              filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-2.png",
              width_in_frames = 2,
              height_in_frames = 2,
            },
            {
              filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-3.png",
              width_in_frames = 2,
              height_in_frames = 2,
            },
            {
              filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-4.png",
              width_in_frames = 2,
              height_in_frames = 2,
            },
            {
              filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-5.png",
              width_in_frames = 2,
              height_in_frames = 2,
            },
            {
              filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-6.png",
              width_in_frames = 2,
              height_in_frames = 2,
            },
            {
              filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-7.png",
              width_in_frames = 2,
              height_in_frames = 2,
            },
            {
              filename = "__space-exploration-graphics__/graphics/entity/core-miner/hr/core-miner-8.png",
              width_in_frames = 2,
              height_in_frames = 1,
            },
          },
        },
      }
    },
    working_visualisations =
    {
      shadow,
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 1, size = 32, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.6, b = 0.1}}
      },
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/electric-mining-drill.ogg",
          volume = 1
        },
      },
      apparent_volume = 2
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 200,
    },
    ingredient_count = 0,
    module_specification =
    {
      module_slots = 0
    },
    allowed_effects = {}
  }
})
