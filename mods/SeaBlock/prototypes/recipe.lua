data:extend({
  {
    type = "recipe",
    name = "sb-wood-bricks-charcoal",
    category = "smelting",
    enabled = false,
    energy_required = 3.5,
    ingredients = {{"wood-bricks", 1}},
    result = "wood-charcoal",
    result_count = 5,
    subgroup = "petrochem-coal"
  },
  {
    type = "recipe",
    name = "thermal-bore-water",
    category = "thermal-bore",
    subgroup = "water-treatment",
    order = "h[thermal-bore-water]",
    energy_required = 10,
    enabled = false,
    ingredients = {
      {type = "item", name = "lithium-chloride", amount = 1}
    },
    results = {
      {type = "fluid", name = "thermal-water", amount = 5}
    }
  },
  {
    type = "recipe",
    name = "thermal-extractor-water",
    category = "thermal-extractor",
    subgroup = "water-treatment",
    order = "h[thermal-extractor-water]",
    energy_required = 5,
    enabled = false,
    ingredients = {
      {type = "fluid", name = "steam", amount = 100},
      {type = "item", name = "lithium-chloride", amount = 2}
    },
    results = {
      {type = "fluid", name = "thermal-water", amount = 100}
    }
  },
  {
    type = "recipe",
    name = "sb-water-mineralized-crystallization",
    category = "crystallizing",
    subgroup = "slag-processing-1",
    order = "z[slag-processing]",
    enabled = true,
    energy_required = 2,
    ingredients = {
      {type = "fluid", name = "water-mineralized", amount = 200}
    },
    results = {
      {type = "item", name = "angels-ore1", amount = 2, probability = 0.55},
      {type = "item", name = "angels-ore3", amount = 1, probability = 0.7},
    }
  },
  {
    type = "recipe",
    name = "sb-cellulose-foraging",
    localised_name = {"recipe-name.sb-cellulose-foraging"},
    category = "crafting-handonly",
    subgroup = "bio-processing-green",
    enabled = true,
    energy_required = 2,
    ingredients = {},
    results = {
      {type = "item", name = "cellulose-fiber", amount = 1}
    },
    order = "ab[sb-cellulose-foraging]",
    allow_as_intermediate = true,
    allow_decomposition = false
  },
  {
    -- Balance assuming blue algae is about equal to green algae in MJ value.
    -- 1 blue cellulose = 2MJ (1 green cellulose = 1MJ but converting to wood pellets doubles it.
    --   Wrong, but I'll stick with it to avoid increasing the cost of all petrochem recipes)
    -- Now for multi phase oil MJ value:
    -- 100 naphtha = 50MJ
    -- 50 fuel oil = 50MJ
    -- basic oil refining is 100 crude oil -> 30 fuel oil + 50 naphtha (and other stuff i'll ignore)
    -- 100 crude oil = 30MJ (fuel oil) + 25MJ (naphtha) = 55MJ
    -- 100 multiphase oil = 55*70/100 = 38.5 MJ.
    -- Let's round that up to 40MJ or 20 blue cellulose fiber.
    -- This is being generous, haven't counted natural gas liquids and base mineral oil.

    -- 100 sulfuric waste water -> 40 blue algae
    -- 40 blue algae -> 20 blue cellulose
    -- 20 blue cellulose -> 100 multi phase oil + 60 sulfuric waste water
    -- 100 multi phase oil -> 10 sulfuric waste water
    -- 70% of sulfuric waste water is recycled
    -- Almost forgot +20 raw gas
    -- 20 raw gas -> 4 acid gas
    -- 4 acid gas -> 2.4 hydrogen sulfide
    -- 2.4 hydrogen sulfide -> 0.12 sulfur
    -- 0.12 sulfur -> 7.2 sulfur dioxide
    -- 7.2 sulfur dioxide -> 4.8 sulfuric acid
    -- 4.8 sulfuric acid -> 16 slag slurry
    -- 16 slag slurry -> 12.8 sulfuric waste water (coal filtering)
    -- So closer to 80% sulfur return
    type = "recipe",
    name = "sb-blue-algae-liquefaction",
    icons = 
      angelsmods.functions.create_liquid_recipe_icon(
        {
          "blue-cellulose-fiber"
        },
        {{100, 100, 100}, {171, 161, 055}, {127, 163, 109}}
      ),
    category = "petrochem-separation",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "blue-cellulose-fiber", amount = 20},
      {type = "fluid", name = "steam", amount = 100}
    },
    results = {
      {type = "fluid", name = "water-yellow-waste", amount = 60},
      {type = "fluid", name = "liquid-multi-phase-oil", amount = 100},
      {type = "fluid", name = "gas-carbon-dioxide", amount = 20}
    },
    subgroup = "bio-processing-blue",
    order = "d[blue-algae-liquefaction]"
  },
  {
    type = "item",
    name = "sb-ore-sorting-facility-5",
    icons = angelsmods.functions.add_number_icon_layer(
      {
        {
          icon = "__SeaBlock__/graphics/icons/sb-ore-sorting-facility-5.png",
          icon_size = 32, icon_mipmaps = 1
        }
      },
      5, angelsmods.refining.number_tint),
    subgroup = "ore-sorter",
    order = "e[ore-sorting-facility-5]",
    place_result = "sb-ore-sorting-facility-5",
    stack_size = 10
  },
  {
    type = "assembling-machine",
    name = "sb-ore-sorting-facility-5",
    icons = angelsmods.functions.add_number_icon_layer(
      {
        {
          icon = "__SeaBlock__/graphics/icons/sb-ore-sorting-facility-5.png",
          icon_size = 32, icon_mipmaps = 1
        }
      },
      5, angelsmods.refining.number_tint),
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1, result = "sb-ore-sorting-facility-5"},
    fast_replaceable_group = "ore-sorting-facility",
    max_health = 300,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-3.4, -3.4}, {3.4, 3.4}},
    selection_box = {{-3.5, -3.5}, {3.5, 3.5}},
    module_specification = {
      module_slots = 3
    },
    allowed_effects = {"consumption", "speed", "pollution", "productivity"},
    crafting_categories = {"ore-sorting", "ore-sorting-2", "ore-sorting-3", "ore-sorting-4", "ore-sorting-5"},
    crafting_speed = 2,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 0.07 * 60
    },
    energy_usage = "350kW",
    animation = {
      layers = {
        {
          filename = "__angelsrefining__/graphics/entity/ore-sorting-facility/1ore-sorting-facility.png",
          priority = "extra-high",
          width = 256,
          height = 256,
          frame_count = 40,
          line_length = 8,
          shift = {0.5, 0},
          animation_speed = 0.5
        },
        {
          filename = "__angelsrefining__/graphics/entity/ore-sorting-facility/2ore-sorting-facility-overlay.png",
          priority = "extra-high",
          width = 256,
          height = 256,
          frame_count = 40,
          line_length = 8,
          tint = {r = 0.53, g = 0.34, b = 0.71},
          shift = {0.5, 0},
          animation_speed = 0.5
        }
      }
    },
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound = {
      sound = {filename = "__angelsrefining__/sound/ore-sorting-facility.ogg"},
      idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
      apparent_volume = 2.5
    }
  },
  {
    type = "recipe",
    name = "sb-ore-sorting-facility-5",
    energy_required = 5,
    enabled = false,
    ingredients = {
      {type = "item", name = "ore-sorting-facility-4", amount = 1}
    },
    result = "ore-sorting-facility-5"
  },
})

bobmods.lib.tech.add_prerequisite('oil-gas-extraction', 'bio-processing-blue')
bobmods.lib.tech.add_recipe_unlock('oil-gas-extraction', 'sb-blue-algae-liquefaction')
