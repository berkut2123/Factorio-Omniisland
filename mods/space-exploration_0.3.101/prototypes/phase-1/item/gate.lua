local data_util = require("data_util")

-- fragments
for i = 1, 13, 1 do
  data:extend({{
      type = "item",
      name = data_util.mod_prefix .. "gate-fragment-"..i,
      localised_name = {"item-name."..data_util.mod_prefix .. "gate-fragment"},
      icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-"..i..".png",
      icon_size = 64,
      order = "a[ancient]-g[gate]-a",
      stack_size = 1,
      subgroup = "ancient",
      place_result = data_util.mod_prefix .. "gate-fragment-"..i,
      flags = { "hidden" },
    }})
end
