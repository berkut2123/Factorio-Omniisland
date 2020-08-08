local data_util = require("data_util")
data:extend({
  {
    type = "recipe",
    name = data_util.mod_prefix .. "core-miner",
    category = "crafting",
    enabled = false,
    energy_required = 100,
    ingredients = {
      {"concrete", 400},
      {"electronic-circuit", 200},
      {"steel-plate", 100},
      {"electric-mining-drill", 40},
    },
    results=
    {
      {name = data_util.mod_prefix .. "core-miner", amount=1}
    },
    icon = "__space-exploration-graphics__/graphics/icons/core-miner.png",
    icon_size = 32,
    order = "zzz-core-miner",
    always_show_made_in = true,
  },
})
