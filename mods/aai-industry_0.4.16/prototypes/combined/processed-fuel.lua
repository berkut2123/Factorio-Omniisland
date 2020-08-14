if not settings.startup["aai-fuel-processor"].value then return end
local energy_cost = 10 * 100 / (100 + settings.startup["aai-fuel-processor-efficiency"].value)
data:extend({
  {
    type = "recipe-category",
    name = "fuel-processing"
  },
  {
      type = "technology",
      name = "fuel-processing",
      icon = "__aai-industry__/graphics/technology/fuel-processing.png",
      icon_size = 128,
      order = "a",
      prerequisites = {"basic-automation"},
      unit = {
          count = 20,
          ingredients = {
              {"automation-science-pack", 1},
          },
          time = 10
      },
      effects = {
       { type = "unlock-recipe", recipe = "fuel-processor" },
     },
     localised_description = {"technology-description.fuel-processing", settings.startup["aai-fuel-processor-efficiency"].value},
  },

  {
    type = "item-subgroup",
    name = "fuel-processing",
    group = "intermediate-products",
    order = "a-b"
  },
  {
      type = "item",
      name = "processed-fuel",
      icon = "__aai-industry__/graphics/icons/processed-fuel.png",
      icon_size = 32,
      fuel_value = "10MJ", -- rocket is 100MJ, solid is 12
      subgroup = "fuel-processing",
      order = "m[rocket-fuel]-b[processed-fuel]",
      stack_size = 100, --(1000MJ) rocket is 10 (2250MJ), solid is 50(1250MK),
      fuel_category = "processed-chemical",
      fuel_acceleration_multiplier = 1.75,
      fuel_top_speed_multiplier = 1.125,
  },

  {
      type = "item",
      name = "fuel-processor",
      icon = "__aai-industry__/graphics/icons/fuel-processor.png",
      icon_size = 32,
      subgroup = "smelting-machine",
      order = "z",
      place_result = "fuel-processor",
      stack_size = 50,
  },
  {
      type = "recipe",
      name = "fuel-processor",
      enabled = false,
      energy_required = 4,
      ingredients =
      {
          {"iron-plate", 10},
          {"stone-brick", 10},
          {"motor", 1},
      },
      result = "fuel-processor"
  },
  {
      type = "recipe",
      name = "fuel-processing",
      enabled = true,
      energy_required = 1,
      ingredients =
      {
      },
      category = "fuel-processing",
      result = "processed-fuel"
  },
  {
      type = "assembling-machine",
      name = "fuel-processor",
      localised_description = {"entity-description.fuel-processor", settings.startup["aai-fuel-processor-efficiency"].value},
      icon = "__aai-industry__/graphics/icons/fuel-processor.png",
      icon_size = 32,
      allowed_effects = {
        --"consumption",
        --"speed",
        --"productivity",
        "pollution"
      },
      animation = {
        filename = "__aai-industry__/graphics/entity/fuel-processor/fuel-processor.png",
        frame_count = 1,
        width = 128,
        height = 108,
        priority = "high",
        shift = util.by_pixel(16, -4),
        hr_version = {
            filename = "__aai-industry__/graphics/entity/fuel-processor/hr-fuel-processor.png",
            frame_count = 1,
            width = 256,
            height = 216,
            priority = "high",
            scale = 0.5,
            shift = util.by_pixel(16, -4),
        }
      },
      working_visualisations =
      {
        {
          animation =
          {
            filename = "__aai-industry__/graphics/entity/fuel-processor/fuel-processor-animation.png",
            priority = "high",
            width = 1328/8/2,
            height = 1008/8/2,
            line_length = 8,
            frame_count = 64,
            animation_speed = 1,
            shift = util.by_pixel(16 - 15, -4 + 11),
            hr_version = {
              filename = "__aai-industry__/graphics/entity/fuel-processor/hr-fuel-processor-animation.png",
              priority = "high",
              width = 1328/8,
              height = 1008/8,
              line_length = 8,
              frame_count = 64,
              animation_speed = 1,
              shift = util.by_pixel(16 - 15, -4 + 11),
              scale = 0.5
            }
          }
        },
      },
      collision_box = { { -1.1, -1.1, }, { 1.1, 1.1 } },
      corpse = "big-remnants",
      crafting_categories = {
        "fuel-processing"
      },
      fixed_recipe = "fuel-processing",
      crafting_speed = 1,
      dying_explosion = "medium-explosion",
      energy_source = {
        emissions_per_minute = 4,
        type = "burner",
        fuel_inventory_size = 4,
        fuel_category = "chemical"
      },
      energy_usage = energy_cost.."MW", -- 9MJ per second used 10MW of fuel returned.
      fast_replaceable_group = "fuel-processor",
      flags = {
        "placeable-neutral",
        "placeable-player",
        "player-creation"
      },
      light = {
        intensity = 1,
        size = 10
      },
      max_health = 150,
      minable = {
        mining_time = 0.2,
        result = "fuel-processor"
      },
      result_inventory_size = 1,
      selection_box = { { -1.45, -1.45 }, { 1.45, 1.45 } },
      source_inventory_size = 1,
      vehicle_impact_sound = {
        filename = "__base__/sound/car-metal-impact.ogg",
        volume = 0.65
      },
      working_sound = {
        sound = {
          filename = "__base__/sound/burner-mining-drill.ogg",
          volume = 0.8
        }
      },
    },
})
