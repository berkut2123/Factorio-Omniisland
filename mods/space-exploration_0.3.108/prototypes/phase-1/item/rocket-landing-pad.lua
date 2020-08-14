local data_util = require("data_util")
data:extend({
  {
    type = "item",
    name = data_util.mod_prefix .. "rocket-landing-pad",
    place_result = data_util.mod_prefix .. "rocket-landing-pad",
    icon = "__space-exploration-graphics__/graphics/icons/rocket-landing-pad.png",
    icon_size = 32,
    order = "c",
    stack_size = 1,
    subgroup = "rocket-logistics", -- need to move to logistics
  },
})
