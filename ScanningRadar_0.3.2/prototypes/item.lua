data:extend({
  {
    type = "item",
    name = "scanning-radar",
    icon = "__ScanningRadar__/graphics/item_icon_scanningradar.png",
    icon_size = 32,
    subgroup = "defensive-structure",
    order = "z[radar]-a[radar]",
    place_result = "scanning-radar",
    stack_size = 10,
    default_request_amount = 10
  },
  {
    type = "item",
    name = "scanning-radar-powerdump",
    icon = "__ScanningRadar__/graphics/item_icon_scanningradar.png",
    icon_size = 32,
    flags = {"hidden"},
    stack_size = 1
  },
  {
    type = "item",
    name = "scanning-radar-connection",
    icon = "__ScanningRadar__/graphics/item_icon_scanningradar.png",
    icon_size = 32,
    flags = {"hidden"},
    stack_size = 1
  }
})
