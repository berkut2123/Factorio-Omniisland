local data_util = require("data_util")
-- Note: the actual core fragments are in data-final-fixes.lua
data:extend({
  {
    type = "item",
    name = data_util.mod_prefix .. "core-miner",
    icon = "__space-exploration-graphics__/graphics/icons/core-miner.png",
    icon_size = 32,
    order = "zzzz-core-miner",
    stack_size = 1,
    subgroup = "extraction-machine",
    place_result = data_util.mod_prefix .. "core-miner",
  },
})
