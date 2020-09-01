
local jetpack_equipment_prototypes = {
  ["jetpack-1"] = {
    tier = 1, grid_width = 2, grid_height = 2, power = "100kW",
    ingredients = {
      { "steel-plate", 10},
      { "pipe", 10},
      { "electronic-circuit", 10},
    },
    science_packs = {
      { "automation-science-pack", 1 },
      { "logistic-science-pack", 1 },
      { "chemical-science-pack", 1 },
    },
    prerequisites = {
      "solar-panel-equipment",
      "rocket-fuel",
    }
  },

  ["jetpack-2"] = {
    tier = 2, grid_width = 2, grid_height = 2, power = "200kW",
    ingredients = {
      { "jetpack-1", 2},
      { "electric-engine-unit", 20},
      { "advanced-circuit", 20},
    },
    science_packs = {
      { "automation-science-pack", 1 },
      { "logistic-science-pack", 1 },
      { "chemical-science-pack", 1 },
    },
    prerequisites = {
      "jetpack-1",
      "electric-engine",
      "advanced-electronics"
    }
  },

  ["jetpack-3"] = {
    tier = 3, grid_width = 2, grid_height = 2, power = "400kW",
    ingredients = {
      { "jetpack-2", 2 },
      { "processing-unit", 30},
      { "low-density-structure", 30},
    },
    science_packs = {
      { "automation-science-pack", 1 },
      { "logistic-science-pack", 1 },
      { "chemical-science-pack", 1 },
      { "utility-science-pack", 1 },
    },
    prerequisites = {
      "jetpack-2",
      "advanced-electronics-2",
      "low-density-structure",
      "utility-science-pack"
    }
  },

  ["jetpack-4"] = {
    tier = 4, grid_width = 2, grid_height = 2, power = "800kW",
    ingredients = {
      { "jetpack-3", 2},
      { "speed-module-3", 40},
      { "effectivity-module-3", 40},
    },
    science_packs = {
      { "automation-science-pack", 1 },
      { "logistic-science-pack", 1 },
      { "chemical-science-pack", 1 },
      { "utility-science-pack", 1 },
      { "space-science-pack", 1 },
    },
    prerequisites = {
      "jetpack-3",
      "speed-module-3",
      "effectivity-module-3",
      "space-science-pack"
    }
  },
}

for name, jep in pairs(jetpack_equipment_prototypes) do

  local jetpack_equipment = table.deepcopy(data.raw["movement-bonus-equipment"]["exoskeleton-equipment"])
  jetpack_equipment.name = name
  jetpack_equipment.movement_bonus = 0
  jetpack_equipment.energy_source = {type = "void", usage_priority = "tertiary"}
  jetpack_equipment.energy_consumption = "1kW"
  jetpack_equipment.sprite = { filename = "__jetpack__/graphics/equipment/"..name..".png", width = 128, height = 128, priority = "medium" }
  jetpack_equipment.background_color = { r = 0.2, g = 0.3, b = 0.6, a = 1 }
  jetpack_equipment.shape = { width = jep.grid_width, height = jep.grid_width, type = "full" }

  local jetpack_item = table.deepcopy(data.raw["item"]["exoskeleton-equipment"])
  jetpack_item.name = name
  jetpack_item.icon = "__jetpack__/graphics/icons/"..name..".png"
  jetpack_item.icon_size = 64
  jetpack_item.placed_as_equipment_result = name

  local jetpack_recipe = table.deepcopy(data.raw["recipe"]["exoskeleton-equipment"])
  jetpack_recipe.name = name
  jetpack_recipe.icon = icon_path
  jetpack_recipe.icon_size = 32
  jetpack_recipe.enabled = false
  jetpack_recipe.result = name
  jetpack_recipe.ingredients = jep.ingredients
  jetpack_recipe.energy_required = jep.tier * 10
  jetpack_recipe.category = "crafting"

  local jetpack_tech = {
    type = "technology",
    name = name,
    effects = { { type = "unlock-recipe", recipe = name } },
    icon = "__jetpack__/graphics/technology/"..name..".png",
    icon_size = 128,
    order = "e-g",
    prerequisites = jep.prerequisites,
    unit = {
     count = jep.tier * 100,
     time = 30,
     ingredients = jep.science_packs
    },
  }

  data:extend({
    jetpack_equipment,
    jetpack_item,
    jetpack_recipe,
    jetpack_tech
  })

end
