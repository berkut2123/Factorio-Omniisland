local data_util = require("data_util")

data:extend({
  {
    type = "item",
    name = data_util.mod_prefix .. "water-ice",
    icon = "__space-exploration-graphics__/graphics/icons/water-ice.png",
    icon_size = 64,
    subgroup = "raw-resource",
    order = "i-a",
    stack_size = 200,
  },


  {
    type = "item",
    name = data_util.mod_prefix .. "methane-ice",
    icon = "__space-exploration-graphics__/graphics/icons/methane-ice.png",
    icon_size = 64,
    order = "i-b",
    stack_size = 200,
    subgroup = "raw-resource",
  },


  {
    type = "item",
    name = data_util.mod_prefix .. "cryonite",
    icon = "__space-exploration-graphics__/graphics/icons/cryonite.png",
    icon_size = 64,
    order = "h-a[cryonite]",
    pictures = {
      {
        filename = "__space-exploration-graphics__/graphics/icons/cryonite.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/cryonite-01.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/cryonite-02.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/cryonite-03.png",
        scale = 0.25,
        size = 64
      }
    },
    stack_size = 50,
    subgroup = "raw-resource",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "cryonite-crushed",
    icon = "__space-exploration-graphics__/graphics/icons/cryonite-crushed.png",
    icon_size = 64,
    order = "r[resource]-c[crushed]-a",
    stack_size = 50,
    subgroup = "pulverised",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "cryonite-washed",
    icon = "__space-exploration-graphics__/graphics/icons/cryonite-washed.png",
    icon_size = 64,
    order = "r[resource]-d[washed]-a",
    stack_size = 50,
    subgroup = "washed",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "cryonite-rod",
    icon = "__space-exploration-graphics__/graphics/icons/cryonite-rod.png",
    icon_size = 64,
    order = "r[resource]-g[extract]-a",
    stack_size = 100,
    subgroup = "raw-material",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "cryonite-ion-exchange-beads",
    icon = "__space-exploration-graphics__/graphics/icons/cryonite-ion-exchange-beads.png",
    icon_size = 64,
    order = "r[resource]-h[extract]-a",
    stack_size = 200,
    subgroup = "raw-material",
  },





  {
    type = "item",
    name = data_util.mod_prefix .. "beryllium-ore",
    icon = "__space-exploration-graphics__/graphics/icons/beryllium-ore.png",
    icon_size = 64,
    order = "h-d[beryllium-ore]",
    pictures = {
      {
        filename = "__space-exploration-graphics__/graphics/icons/beryllium-ore.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/beryllium-ore-01.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/beryllium-ore-02.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/beryllium-ore-03.png",
        scale = 0.25,
        size = 64
      }
    },
    stack_size = 100,
    subgroup = "raw-resource",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "beryllium-ore-crushed",
    icon = "__space-exploration-graphics__/graphics/icons/beryllium-ore-crushed.png",
    icon_size = 64,
    order = "r[resource]-c[crushed]-d",
    stack_size = 100,
    subgroup = "pulverised",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "beryllium-sulfate",
    icon = "__space-exploration-graphics__/graphics/icons/beryllium-sulfate.png",
    icon_size = 64,
    order = "r[resource]-d[washed]-d",
    stack_size = 100,
    subgroup = "washed",
  },
  {
    type = "fluid",
    name = data_util.mod_prefix .. "beryllium-hydroxide",
    default_temperature = 25,
    heat_capacity = "0.1KJ",
    max_temperature = 100,
    base_color = {r=73, g=112, b=79},
    flow_color = {r=156, g=178, b=159},
    icon = "__space-exploration-graphics__/graphics/icons/fluid/beryllium-hydroxide.png",
    icon_size = 64,
    pressure_to_speed_ratio = 0.4,
    flow_to_energy_ratio = 0.59,
    order = "r[resources]-b",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "beryllium-powder",
    icon = "__space-exploration-graphics__/graphics/icons/beryllium-powder.png",
    icon_size = 64,
    order = "r[resource]-p[powder]-d",
    stack_size = 100,
    subgroup = "washed",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "beryllium-ingot",
    icon = "__space-exploration-graphics__/graphics/icons/beryllium-ingot.png",
    icon_size = 64,
    order = "r[resource]-i[ingot]-e",
    stack_size = 100,
    subgroup = "ingots",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "beryllium-plate",
    icon = "__space-exploration-graphics__/graphics/icons/beryllium-plate.png",
    icon_size = 64,
    order = "r[resource]-p[plate]-e",
    stack_size = 200,
    subgroup = "plates",
  },



  {
    type = "item",
    name = data_util.mod_prefix .. "holmium-ore",
    icon = "__space-exploration-graphics__/graphics/icons/holmium-ore.png",
    icon_size = 64,
    order = "h-e[holmium-ore]",
    pictures = {
      {
        filename = "__space-exploration-graphics__/graphics/icons/holmium-ore.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/holmium-ore-01.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/holmium-ore-02.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/holmium-ore-03.png",
        scale = 0.25,
        size = 64
      }
    },
    stack_size = 50,
    subgroup = "raw-resource",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "holmium-ore-crushed",
    icon = "__space-exploration-graphics__/graphics/icons/holmium-ore-crushed.png",
    icon_size = 64,
    order = "r[resource]-c[crushed]-e",
    stack_size = 50,
    subgroup = "pulverised",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "holmium-ore-washed",
    icon = "__space-exploration-graphics__/graphics/icons/holmium-ore-washed.png",
    icon_size = 64,
    order = "r[resource]-d[washed]-e",
    stack_size = 50,
    subgroup = "washed",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "holmium-powder",
    icon = "__space-exploration-graphics__/graphics/icons/holmium-powder.png",
    icon_size = 64,
    order = "r[resource]-p[powder]-e",
    stack_size = 50,
    subgroup = "washed",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "holmium-ingot",
    icon = "__space-exploration-graphics__/graphics/icons/holmium-ingot.png",
    icon_size = 64,
    order = "r[resource]-i[ingot]-e",
    stack_size = 50,
    subgroup = "ingots",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "holmium-plate",
    icon = "__space-exploration-graphics__/graphics/icons/holmium-plate.png",
    icon_size = 64,
    order = "r[resource]-p[plate]-e",
    stack_size = 100,
    subgroup = "plates",
  },



  {
    type = "item",
    name = data_util.mod_prefix .. "iridium-ore",
    icon = "__space-exploration-graphics__/graphics/icons/iridium-ore.png",
    icon_size = 64,
    order = "h-f[iridium-ore]",
    pictures = {
      {
        filename = "__space-exploration-graphics__/graphics/icons/iridium-ore.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/iridium-ore-01.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/iridium-ore-02.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/iridium-ore-03.png",
        scale = 0.25,
        size = 64
      }
    },
    stack_size = 40,
    subgroup = "raw-resource",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "iridium-ore-crushed",
    icon = "__space-exploration-graphics__/graphics/icons/iridium-ore-crushed.png",
    icon_size = 64,
    order = "r[resource]-c[crushed]-f",
    stack_size = 40,
    subgroup = "pulverised",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "iridium-ore-washed",
    icon = "__space-exploration-graphics__/graphics/icons/iridium-ore-washed.png",
    icon_size = 64,
    order = "r[resource]-d[washed]-f",
    stack_size = 40,
    subgroup = "washed",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "iridium-powder",
    icon = "__space-exploration-graphics__/graphics/icons/iridium-powder.png",
    icon_size = 64,
    order = "r[resource]p[powder]-f",
    stack_size = 30,
    subgroup = "washed",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "iridium-ingot",
    icon = "__space-exploration-graphics__/graphics/icons/iridium-ingot.png",
    icon_size = 64,
    order = "r[resource]-i[ingot]-f",
    stack_size = 20,
    subgroup = "ingots",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "iridium-plate",
    icon = "__space-exploration-graphics__/graphics/icons/iridium-plate.png",
    icon_size = 64,
    order = "r[resource]-p[plate]-f",
    stack_size = 40,
    subgroup = "plates",
  },



  {
    type = "item",
    name = data_util.mod_prefix .. "naquium-ore",
    icon = "__space-exploration-graphics__/graphics/icons/naquium-ore.png",
    icon_size = 64,
    order = "h-g[naquium-ore]",
    pictures = {
      {
        filename = "__space-exploration-graphics__/graphics/icons/naquium-ore.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/naquium-ore-01.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/naquium-ore-02.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/naquium-ore-03.png",
        scale = 0.25,
        size = 64
      }
    },
    stack_size = 10,
    subgroup = "raw-resource",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "naquium-ore-crushed",
    icon = "__space-exploration-graphics__/graphics/icons/naquium-ore-crushed.png",
    icon_size = 64,
    order = "r[resource]-c[crushed]-g",
    stack_size = 10,
    subgroup = "pulverised",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "naquium-ore-washed",
    icon = "__space-exploration-graphics__/graphics/icons/naquium-ore-washed.png",
    icon_size = 64,
    order = "r[resource]-d[washed]-g",
    stack_size = 10,
    subgroup = "washed",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "naquium-powder",
    icon = "__space-exploration-graphics__/graphics/icons/naquium-powder.png",
    icon_size = 64,
    order = "r[resource]-p[powder]-g",
    stack_size = 10,
    subgroup = "washed",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "naquium-ingot",
    icon = "__space-exploration-graphics__/graphics/icons/naquium-ingot.png",
    icon_size = 64,
    order = "r[resource]-i[ingot]-g",
    stack_size = 10,
    subgroup = "ingots",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "naquium-plate",
    icon = "__space-exploration-graphics__/graphics/icons/naquium-plate.png",
    icon_size = 64,
    order = "r[resource]-p[plate]-g",
    stack_size = 20,
    subgroup = "plates",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "enriched-naquium",
    icon = "__space-exploration-graphics__/graphics/icons/enriched-naquium.png",
    icon_size = 64,
    order = "r[resource]-g[extract]-g",
    stack_size = 10,
    subgroup = "raw-material",
  },


  {
    type = "item",
    name = data_util.mod_prefix .. "vitamelange",
    icon = "__space-exploration-graphics__/graphics/icons/vitamelange.png",
    icon_size = 64,
    order = "h-c[vitamelange]",
    pictures = {
      {
        filename = "__space-exploration-graphics__/graphics/icons/vitamelange.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/vitamelange-01.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/vitamelange-02.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/vitamelange-03.png",
        scale = 0.25,
        size = 64
      }
    },
    stack_size = 50,
    subgroup = "raw-resource",
    fuel_category = "chemical",
    fuel_value = "2MJ",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "vitamelange-nugget",
    icon = "__space-exploration-graphics__/graphics/icons/vitamelange-nugget.png",
    icon_size = 64,
    order = "r[resource]-d[washed]-c",
    stack_size = 50,
    subgroup = "pulverised",
    fuel_category = "chemical",
    fuel_value = "1MJ",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "vitamelange-roast",
    icon = "__space-exploration-graphics__/graphics/icons/vitamelange-roast.png",
    icon_size = 64,
    order = "r[resource]-e[roast]-c",
    stack_size = 50,
    subgroup = "ingots",
    fuel_category = "chemical",
    fuel_value = "2.2MJ",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "vitamelange-spice",
    icon = "__space-exploration-graphics__/graphics/icons/vitamelange-spice.png",
    icon_size = 64,
    order = "r[resource]-f[blended]-c",
    stack_size = 50,
    subgroup = "washed",
    fuel_category = "chemical",
    fuel_value = "4.5MJ",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "vitamelange-extract",
    icon = "__space-exploration-graphics__/graphics/icons/vitamelange-extract.png",
    icon_size = 64,
    order = "r[resource]-g[extract]-c",
    stack_size = 50,
    subgroup = "raw-material",
    fuel_category = "chemical",
    fuel_value = "10MJ",
  },


  {
    type = "item",
    name = data_util.mod_prefix .. "vulcanite",
    icon = "__space-exploration-graphics__/graphics/icons/vulcanite.png",
    icon_size = 64,
    order = "h-b[vulcanite]",
    pictures = {
      {
        filename = "__space-exploration-graphics__/graphics/icons/vulcanite.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/vulcanite-01.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/vulcanite-02.png",
        scale = 0.25,
        size = 64
      },
      {
        filename = "__space-exploration-graphics__/graphics/icons/vulcanite-03.png",
        scale = 0.25,
        size = 64
      }
    },
    stack_size = 50,
    subgroup = "raw-resource",
    fuel_category = "chemical",
    fuel_value = "4MJ",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "vulcanite-crushed",
    icon = "__space-exploration-graphics__/graphics/icons/vulcanite-crushed.png",
    icon_size = 64,
    order = "r[resource]-c[crushed]-b",
    stack_size = 50,
    subgroup = "pulverised",
    fuel_category = "chemical",
    fuel_value = "4MJ",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "vulcanite-washed",
    icon = "__space-exploration-graphics__/graphics/icons/vulcanite-washed.png",
    icon_size = 64,
    order = "r[resource]-d[washed]-b",
    stack_size = 50,
    subgroup = "washed",
    fuel_category = "chemical",
    fuel_value = "5MJ",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "vulcanite-block",
    icon = "__space-exploration-graphics__/graphics/icons/vulcanite-block.png",
    icon_size = 64,
    order = "r[resource]-g[extract]-b",
    stack_size = 100,
    subgroup = "raw-material",
    fuel_category = "chemical",
    fuel_value = "10MJ",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "vulcanite-ion-exchange-beads",
    icon = "__space-exploration-graphics__/graphics/icons/vulcanite-ion-exchange-beads.png",
    icon_size = 64,
    order = "r[resource]-h[extract]-b",
    stack_size = 200,
    subgroup = "raw-material",
  },

})
