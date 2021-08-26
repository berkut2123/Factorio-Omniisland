data:extend({
  {
    type = "item",
    name = "blasting-charge",
    icon = "__Explosive Excavation__/graphics/icons/blasting-explosives.png",
    icon_size = 32,
    subgroup = "terrain",
    order = "c[landfill]-b[blasting-charge]",
    stack_size = 100,
    place_as_tile =
    {
      result = "water",
      condition_size = 1,
      condition = { "water-tile" }
    }
  }
})