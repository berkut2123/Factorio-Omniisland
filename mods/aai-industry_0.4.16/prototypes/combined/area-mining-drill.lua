if not settings.startup["aai-wide-drill"].value then return end
local data_util = require("data-util")

local base_tint = {r = 0.9, g = 0.8, b = 0.77}
local wide_tint = {r = 0.95, g = 0.98, b = 1}

local base_item = data.raw.item["electric-mining-drill"]
base_item.icons = {{ icon = base_item.icon, icon_size = base_item.icon_size, tint = base_tint}}

local base_tech = data.raw.technology["electric-mining"]
base_tech.icons = {{icon = "__aai-industry__/graphics/technology/electric-mining.png", tint = base_tint}}

local base_entity = data.raw["mining-drill"]["electric-mining-drill"]
data_util.tint_recursive(base_entity.animations, base_tint)
data_util.tint_recursive(base_entity.input_fluid_patch_sprites, base_tint)

local new_entity = table.deepcopy(base_entity)
new_entity.name = "area-electric-mining-drill"
new_entity.minable.result = "area-electric-mining-drill"
new_entity.mining_speed = new_entity.mining_speed + 0.1
new_entity.module_specification.module_slots = new_entity.module_specification.module_slots + 1
new_entity.resource_searching_radius = new_entity.resource_searching_radius + 1
data_util.tint_recursive(new_entity.animations, wide_tint)
data_util.tint_recursive(new_entity.input_fluid_patch_sprites, wide_tint)

data:extend({
  {
    type = "item",
    name = "area-electric-mining-drill",
    icons = {{ icon = base_item.icon, icon_size = base_item.icon_size, tint = wide_tint}},
    subgroup = base_item.subgroup,
    order = base_item.order.."-b",
    stack_size = base_item.stack_size,
    place_result = "area-electric-mining-drill",
  },
  {
    type = "recipe",
    name = "area-electric-mining-drill",
    category = "crafting",
    normal = {
      enabled = false,
      energy_required = 4,
      ingredients = {
        {type="item", name="electric-mining-drill", amount=1},
        {type="item", name="concrete", amount=4},
        {type="item", name="steel-plate", amount=8},
        {type="item", name="processing-unit", amount=1},
      },
      results= { {type="item", name="area-electric-mining-drill", amount=1} },
    },
    expensive = {
      enabled = false,
      energy_required = 4,
      ingredients = {
        {type="item", name="electric-mining-drill", amount=1},
        {type="item", name="concrete", amount=8},
        {type="item", name="steel-plate", amount=12},
        {type="item", name="processing-unit", amount=2},
      },
      results= { {type="item", name="area-electric-mining-drill", amount=1} },
    }
  },
  {
    type = "technology",
    name = "area-electric-mining-drill",
    icons = {{icon = "__aai-industry__/graphics/technology/electric-mining.png", tint = wide_tint}},
    icon_size = 128,
    order = "b",
    prerequisites = {
      "production-science-pack",
      "advanced-electronics-2",
    },
    unit = {
        count = 200,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
        },
        time = 30
    },
    effects = {
      { type = "unlock-recipe", recipe = "area-electric-mining-drill" }
    },
  },
  new_entity
})
