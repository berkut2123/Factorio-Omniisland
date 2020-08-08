local data_util = require("data_util")
--heat.localised_name = {"fluid-name.steam"}
data:extend({
  {
    type = "item",
    name = data_util.mod_prefix .. "condenser-turbine",
    icon = "__space-exploration-graphics__/graphics/icons/condenser-turbine.png",
    icon_size = 32,
    order = data.raw["item"]["steam-turbine"].order or "".."-b",
    place_result = data_util.mod_prefix .. "condenser-turbine",
    stack_size = 10,
    subgroup = "energy",
    --subgroup = "space-energy",
  },
})
