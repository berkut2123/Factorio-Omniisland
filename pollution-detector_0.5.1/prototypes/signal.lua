data:extend({
  {
    type = "item-subgroup",
    name = "sensor-signals",
    group = "signals",
    order = "x[sensor-signals]"
  },

  {
    type = "virtual-signal",
    name = "pd-pollution",
    icon =  "__pollution-detector__/graphics/icons/pollution.png",
    icon_size = 32,
    subgroup = "sensor-signals",
    order = "x[sensor-signals]-aa"
  },
})