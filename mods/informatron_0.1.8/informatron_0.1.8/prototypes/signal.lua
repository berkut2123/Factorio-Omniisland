-- utility sprites don't work right now so use hidden signals
data:extend({
  {
    type = "virtual-signal",
    name = "informatron",
    icon = "__informatron__/graphics/icons/informatron.png",
    icon_size = 64,
    subgroup = "virtual-signal-utility",
    order = "i[informatron]",
  },
  {
    type = "item-subgroup",
    name = "virtual-signal-utility",
    group = "signals",
    order = "u-a"
  },
})
