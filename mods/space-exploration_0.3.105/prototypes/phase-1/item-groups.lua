data.raw["item-group"]["intermediate-products"].icon = "__space-exploration-graphics__/graphics/item-group/manufacturing.png"
data.raw["item-group"]["intermediate-products"].order = "c-b"
data.raw["item-group"]["combat"].icon = "__space-exploration-graphics__/graphics/item-group/equipment.png"
data:extend({

  --[[{
    type = "item-group",
    name = "space",
    order = "b-b-s",
    icon = "__space-exploration-graphics__/graphics/item-group/spaceship.png",
    icon_size = 64,
  },]]--
  {
    type = "item-group",
    name = "resources",
    order = "c-a",
    icon = "__space-exploration-graphics__/graphics/item-group/resources.png",
    icon_size = 64,
  },
  {
    type = "item-group",
    name = "science",
    order = "c-d",
    icon = "__space-exploration-graphics__/graphics/item-group/beaker/space.png",
    icon_size = 64,
  },


  {
    type = "item-subgroup",
    name = "storage",
    group = "logistics",
    order = "a[storage]"
  },
  {
    type = "item-subgroup",
    name = "transport-belt",
    group = "logistics",
    order = "b[belt]-a"
  },
  {
    type = "item-subgroup",
    name = "underground-belt",
    group = "logistics",
    order = "b[belt]-b"
  },
  {
    type = "item-subgroup",
    name = "splitter",
    group = "logistics",
    order = "b[belt]-c"
  },
  {
    type = "item-subgroup",
    name = "loader",
    group = "logistics",
    order = "b[belt]-c"
  },
  {
    type = "item-subgroup",
    name = "pipe",
    group = "logistics",
    order = "c"
  },
  {
    group = "logistics",
    name = "rail",
    order = "e[transport]-b[rail]",
    type = "item-subgroup"
  },

  {
    type = "item-subgroup",
    name = "spaceship-structure",
    group = "logistics",
    order = "k"
  },

  {
    type = "item-subgroup",
    name = "rocket-logistics",
    group = "logistics",
    order = "j"
  },
  {
    type = "item-subgroup",
    name = "delivery-cannon-capsules",
    group = "logistics",
    order = "k"
  },


  {
    type = "item-subgroup",
    name = "ancient",
    group = "logistics",
    order = "z-z-a"
  },



  {
    type = "item-subgroup",
    name = "solar",
    group = "production",
    order = "b-a"
  },
  {
    type = "item-subgroup",
    name = "mechanical",
    group = "production",
    order = "e-a"
  },
  {
    type = "item-subgroup",
    name = "assembling",
    group = "production",
    order = "e-b"
  },
  {
    type = "item-subgroup",
    name = "chemistry",
    group = "production",
    order = "e-c"
  },
  {
    type = "item-subgroup",
    name = "radiation",
    group = "production",
    order = "e-d"
  },
  {
    type = "item-subgroup",
    name = "plasma",
    group = "production",
    order = "e-e"
  },
  {
    type = "item-subgroup",
    name = "thermofluid",
    group = "production",
    order = "e-f"
  },
  {
    type = "item-subgroup",
    name = "computation",
    group = "production",
    order = "e-g"
  },
  {
    type = "item-subgroup",
    name = "telescope",
    group = "production",
    order = "e-h"
  },

  {
    type = "item-subgroup",
    name = "space-structures",
    group = "production",
    order = "h-i"
  },
  {
    type = "item-subgroup",
    name = "lab",
    group = "production",
    order = "h-j"
  },
  {
    type = "item-subgroup",
    name = "module-speed",
    group = "production",
    order = "z-m-b"
  },
  {
    type = "item-subgroup",
    name = "module-productivity",
    group = "production",
    order = "z-m-c"
  },
  {
    type = "item-subgroup",
    name = "module-effectivity",
    group = "production",
    order = "z-m-d"
  },



  {
    type = "item-subgroup",
    name = "core-fragments",
    group = "resources",
    order = "a-a"
  },
  {
    type = "item-subgroup",
    name = "pulverised",
    group = "resources",
    order = "a-b"
  },
  {
    type = "item-subgroup",
    name = "washed",
    group = "resources",
    order = "a-c"
  },
  {
    type = "item-subgroup",
    name = "ingots",
    group = "resources",
    order = "a-d"
  },
  {
    type = "item-subgroup",
    name = "plates",
    group = "resources",
    order = "a-d"
  },




  {
    type = "item-subgroup",
    name = "spaceship-process",
    group = "intermediate-products",
    order = "z-a-a-b"
  },
  {
    type = "item-subgroup",
    name = "rocket-intermediate-product",
    group = "intermediate-products",
    order = "z-a-b-b"
  },
  {
    type = "item-subgroup",
    name = "space-cooling",
    group = "intermediate-products",
    order = "z-a-e"
  },

  {
    type = "item-subgroup",
    name = "space-fluids",
    group = "intermediate-products",
    order = "z-f-a"
  },
  {
    type = "item-subgroup",
    name = "space-recycling",
    group = "intermediate-products",
    order = "z-g-a"
  },
  {
    type = "item-subgroup",
    name = "space-components",
    group = "intermediate-products",
    order = "z-h-a"
  },
  {
    type = "item-subgroup",
    name = "space-canisters",
    group = "intermediate-products",
    order = "z-h-b"
  },
  {
    type = "item-subgroup",
    name = "space-bioculture",
    group = "intermediate-products",
    order = "z-j-a"
  },
  {
    type = "item-subgroup",
    name = "space-observation-frame",
    group = "intermediate-products",
    order = "z-j-b"
  },





  {
    type = "item-subgroup",
    name = "data-generic",
    group = "science",
    order = "m-a"
  },
  {
    type = "item-subgroup",
    name = "data-significant",
    group = "science",
    order = "m-m"
  },

  {
    type = "item-subgroup",
    name = "data-catalogue-astronomic",
    group = "science",
    order = "n-a"
  },
  {
    type = "item-subgroup",
    name = "data-astronomic",
    group = "science",
    order = "n-b"
  },
  {
    type = "item-subgroup",
    name = "data-catalogue-biological",
    group = "science",
    order = "o-a"
  },
  {
    type = "item-subgroup",
    name = "data-biological",
    group = "science",
    order = "o-b"
  },
  {
    type = "item-subgroup",
    name = "data-catalogue-energy",
    group = "science",
    order = "p-a"
  },
  {
    type = "item-subgroup",
    name = "data-energy",
    group = "science",
    order = "p-b"
  },
  {
    type = "item-subgroup",
    name = "data-catalogue-material",
    group = "science",
    order = "q-a"
  },
  {
    type = "item-subgroup",
    name = "data-material",
    group = "science",
    order = "q-b"
  },


  {
    type = "item-subgroup",
    name = "virtual-signal-utility",
    group = "signals",
    order = "u-a"
  },



  {
    type = "item-subgroup",
    name = "ruins",
    group = "environment",
    order = "z-r"
  },
})
