local data_util = require("data_util")
local make_recipe = data_util.make_recipe

data:extend({
  --[[{
    type = "recipe",
    name = "starfield-sparse",
    energy_required = 10,
    category = "crafting",
    ingredients =
    {
      {"iron-plate", 1}
    },
    result= "space",
    result_count = 10
  },]]--
  {
    type = "recipe",
    name = data_util.mod_prefix .. "space-platform-scaffold",
    energy_required = 1,
    category = "crafting",
    ingredients =
    {
      {"steel-plate", 1},
      {"low-density-structure", 1},
      {data_util.mod_prefix .. "heat-shielding", 1},
    },
    energy_required = 10,
    result = data_util.mod_prefix .. "space-platform-scaffold",
    result_count = 1,
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "space-platform-plating",
    energy_required = 2,
    category = "crafting",
    ingredients =
    {
      {data_util.mod_prefix .. "space-platform-scaffold", 1},
      {data_util.mod_prefix .. "heavy-girder", 1},
      {"steel-plate", 4},
    },
    energy_required = 30,
    result = data_util.mod_prefix .. "space-platform-plating",
    result_count = 1,
    enabled = false,
    always_show_made_in = true,
  },
})
