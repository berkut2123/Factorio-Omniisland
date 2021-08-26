local include_fuel_processor = settings.startup["aai-fuel-processor"].value
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
      enabled = include_fuel_processor,
      hidden = not include_fuel_processor,
      unit = {
          count = 20,
          ingredients = {
              {"automation-science-pack", 1},
          },
          time = 10
      },
      effects = {
       { type = "unlock-recipe", recipe = "fuel-processor" },
       { type = "unlock-recipe", recipe = "fuel-processing" },
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
    type = "fuel-category",
    name = "processed-chemical"
  },

  {
      type = "item",
      name = "processed-fuel",
      icon = "__aai-industry__/graphics/icons/processed-fuel.png",
      icon_size = 64, icon_mipmaps = 1,
      fuel_value = "10MJ", -- rocket is 100MJ, solid is 12
      subgroup = "fuel-processing",
      order = "m[rocket-fuel]-b[processed-fuel]",
      stack_size = 100, --(1000MJ) rocket is 10 (2250MJ), solid is 50(1250MK),
      fuel_category = "processed-chemical",
      fuel_acceleration_multiplier = 1.75,
      fuel_top_speed_multiplier = 1.125,
      flags = (not include_fuel_processor) and {"hidden"} or {}
  },

  {
      type = "item",
      name = "fuel-processor",
      icon = "__aai-industry__/graphics/icons/fuel-processor.png",
      icon_size = 64, icon_mipmaps = 1,
      subgroup = "smelting-machine",
      order = "z",
      place_result = "fuel-processor",
      stack_size = 50,
      flags = (not include_fuel_processor) and {"hidden"} or {}
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
      result = "fuel-processor",
      hidden = (not include_fuel_processor)
  },
  {
      type = "recipe",
      name = "fuel-processing",
      enabled = false,
      energy_required = 1,
      ingredients =
      {
      },
      category = "fuel-processing",
      result = "processed-fuel",
      hidden = (not include_fuel_processor)
  },
  {
      type = "assembling-machine",
      name = "fuel-processor",
      localised_description = {"entity-description.fuel-processor", settings.startup["aai-fuel-processor-efficiency"].value},
      icon = "__aai-industry__/graphics/icons/fuel-processor.png",
      icon_size = 64, icon_mipmaps = 1,
      allowed_effects = {
        --"consumption",
        --"speed",
        --"productivity",
        "pollution"
      },
      animation = {
        layers = {
          {
            filename = "__aai-industry__/graphics/entity/fuel-processor/fuel-processor.png",
            frame_count = 1,
            width = 192/2,
            height = 108,
            priority = "high",
            shift = util.by_pixel(0, -4),
            hr_version = {
                filename = "__aai-industry__/graphics/entity/fuel-processor/hr-fuel-processor.png",
                frame_count = 1,
                width = 192,
                height = 216,
                priority = "high",
                scale = 0.5,
                shift = util.by_pixel(0, -4),
            }
          },
          {
            draw_as_shadow = true,
            filename = "__aai-industry__/graphics/entity/fuel-processor/fuel-processor-shadow.png",
            frame_count = 1,
            width = 224/2,
            height = 142/2,
            priority = "high",
            shift = util.by_pixel(20, 12),
            hr_version = {
              draw_as_shadow = true,
              filename = "__aai-industry__/graphics/entity/fuel-processor/hr-fuel-processor-shadow.png",
              frame_count = 1,
              width = 224,
              height = 142,
              priority = "high",
              scale = 0.5,
              shift = util.by_pixel(20, 12),
            }
          },
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
        {
          draw_as_light = true,
          draw_as_sprite = false,
          fadeout = true,
          animation =
          {
            filename = "__aai-industry__/graphics/entity/fuel-processor/fuel-processor-light.png",
            priority = "high",
            width = 192/2,
            height = 108,
            frame_count = 1,
            animation_speed = 1,
            shift = util.by_pixel(0, -4),
            hr_version = {
              filename = "__aai-industry__/graphics/entity/fuel-processor/hr-fuel-processor-light.png",
              priority = "high",
              width = 192,
              height = 216,
              frame_count = 1,
              animation_speed = 1,
              shift = util.by_pixel(0, -4),
              scale = 0.5
            }
          }
        },
        {
          draw_as_light = true,
          fadeout = true,
          constant_speed = true,
          animation =
          {
            filename = "__base__/graphics/entity/oil-refinery/oil-refinery-fire.png",
            line_length = 10,
            width = 20,
            height = 40,
            frame_count = 60,
            animation_speed = 0.75,
            shift = util.by_pixel(-21, -64),
            hr_version =
            {
              filename = "__base__/graphics/entity/oil-refinery/hr-oil-refinery-fire.png",
              line_length = 10,
              width = 40,
              height = 81,
              frame_count = 60,
              animation_speed = 0.75,
              scale = 0.5,
              shift = util.by_pixel(-21, -64)
            }
          },
        },
        {
          effect = "uranium-glow", -- changes alpha based on energy source light intensity
          light = {intensity = 0.1, size = 18, shift = {0.0, 1}, color = {r = 1, g = 0.4, b = 0.1}}
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
        fuel_category = "chemical",
        light_flicker =
        {
          minimum_light_size = 1,
          light_intensity_to_size_coefficient = 0.2,
          color = {1,0.6,0},
          minimum_intensity = 0.05,
          maximum_intensity = 0.2
        },
      },
      energy_usage = energy_cost.."MW", -- 9MJ per second used 10MW of fuel returned.
      fast_replaceable_group = "fuel-processor",
      flags = {
        "placeable-neutral",
        "placeable-player",
        "player-creation",
        (not include_fuel_processor) and "hidden" or nil
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
      selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
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
