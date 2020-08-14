local data_util = require("data_util")
local make_recipe = data_util.make_recipe

data:extend({
  {
      type = "recipe",
      name = data_util.mod_prefix .. "rocket-landing-pad",
      result = data_util.mod_prefix .. "rocket-landing-pad",
      enabled = false,
      energy_required = 20,
      ingredients = {
        {
          "steel-plate",
          1000
        },
        {
          "concrete",
          1000
        },
        {
          "radar",
          10
        },
        {
          "steel-chest",
          10
        },
      },
      requester_paste_multiplier = 1,
    },
    always_show_made_in = true,
})
