local data_util = require("data_util")
data:extend({
  {
    type = "item",
    name = data_util.mod_prefix .. "rocket-launch-pad-silo-dummy-ingredient-item",
    icon = "__space-exploration-graphics__/graphics/icons/cargo-rocket.png",
    icon_size = 64,
    order = "q[rocket-part]-d",
    stack_size = 1,
    subgroup = "rocket-intermediate-product",
    flags = {"hidden"}
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "rocket-launch-pad-silo-dummy-result-item",
    icon = "__space-exploration-graphics__/graphics/icons/cargo-rocket.png",
    icon_size = 64,
    order = "q[rocket-part]-e",
    stack_size = 1,
    subgroup = "rocket-intermediate-product",
    flags = { "hidden" },
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "rocket-launch-pad",
    place_result = data_util.mod_prefix .. "rocket-launch-pad",
    icon = "__space-exploration-graphics__/graphics/icons/rocket-launch-pad.png",
    icon_size = 32,
    order = "b",
    stack_size = 1,
    subgroup = "rocket-logistics", -- need to move to logistics
  },
})
