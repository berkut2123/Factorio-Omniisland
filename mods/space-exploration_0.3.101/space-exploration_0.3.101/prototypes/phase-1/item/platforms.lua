local data_util = require("data_util")
data:extend({
  --[[{
    type = "item",
    name = "space",
    icon = "__space-exploration-graphics__/graphics/icon/starfield-sparse.png",
    icon_size = 32,
    subgroup = "terrain",
    order = "t[starfield]-a[sparse]",
    stack_size = 100,
    place_as_tile =
    {
      result = "space",
      condition_size = 0,
      condition = { "water-tile" }
    }
  },]]--
  {
    type = "item",
    name = data_util.mod_prefix .. "space-platform-scaffold",
    icon = "__space-exploration-graphics__/graphics/icons/space-platform-scaffold.png",
    icon_size = 32,
    subgroup = "terrain",
    order = "s[space-platform]-a[scaffold]",
    stack_size = 100,
    place_as_tile =
    {
      result = data_util.mod_prefix .. "space-platform-scaffold",
      condition_size = 1,
      condition = {
        "water-tile",
        "ground-tile",
      }
    }
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "space-platform-plating",
    icon = "__space-exploration-graphics__/graphics/icons/space-platform-plating.png",
    icon_size = 32,
    subgroup = "terrain",
    order = "s[space-platform]-b[plating]",
    stack_size = 100,
    place_as_tile =
    {
      result = data_util.mod_prefix .. "space-platform-plating",
      condition_size = 1,
      condition = {
        "water-tile",
        "ground-tile",
      }
    }
  },
})
