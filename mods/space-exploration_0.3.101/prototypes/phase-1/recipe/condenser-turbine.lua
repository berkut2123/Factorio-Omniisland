local data_util = require("data_util")
local make_recipe = data_util.make_recipe

make_recipe({
  name = data_util.mod_prefix .. "condenser-turbine",
  ingredients = {
    { name = "steam-turbine", amount = 1},
    { name = "storage-tank", amount = 2},
    { name = "electric-engine-unit", amount = 10},
    { name = "low-density-structure", amount = 20},
    { name = "glass", amount = 20},
  },
  results = {
    { name = data_util.mod_prefix .. "condenser-turbine", amount = 1},
  },
  energy_required = 5,
  category = "crafting",
  enabled = false,
  always_show_made_in = true,
})
data:extend({
  {
    type = "recipe",
    name = data_util.mod_prefix .. "condenser-turbine-reclaim-water",
    icon = "__space-exploration-graphics__/graphics/icons/fluid/water.png",
    icon_size = 32,
    order = "a",
    subgroup = "spaceship-process",
    energy_required = 0.1,
    category = "condenser-turbine",
    ingredients =
    {
      {type="fluid", name="steam", amount=100, minimum_temperature = 500},
    },
    results = {
      {type="fluid", name="water", amount=99},
      {type="fluid", name=data_util.mod_prefix .. "decompressing-steam", amount=75, temperature = 500},
    },
    hidden = true,
    enabled = true,
    allow_as_intermediate = false,
    always_show_made_in = true,
  }
})
