local data_util = require("data_util")
local make_recipe = data_util.make_recipe

data:extend({
  --[[{
    type = "recipe",
    name = data_util.mod_prefix .. "gate-addon",
    icon = "__space-exploration-graphics__/graphics/icons/scaffold.png",
    icon_size = 64,
    ingredients = {
      { data_util.mod_prefix .. "space-pipe", 1000},
      { "battery", 1000},
      { data_util.mod_prefix .. "superconductive-cable", 1000},
    },
    results = {},
    energy_required = 1,
    category = "fixed-recipe",
    subgroup = "ancient",
    order = "z",
    enabled = true,
    always_show_made_in = false,
    flags = {"hidden"}
  },]]--
  {
    type = "recipe",
    name = data_util.mod_prefix .. "gate-platform",
    icon = "__space-exploration-graphics__/graphics/icons/scaffold.png",
    icon_size = 64,
    ingredients = {
      { data_util.mod_prefix .. "space-pipe", 100},
      { "battery", 100},
      { data_util.mod_prefix .. "superconductive-cable", 100},
      { data_util.mod_prefix .. "naquium-processor", 9},
    },
    results = {},
    energy_required = 1,
    category = "fixed-recipe",
    subgroup = "ancient",
    order = "z",
    enabled = true,
    always_show_made_in = false,
    hidden = true,
  }
})
