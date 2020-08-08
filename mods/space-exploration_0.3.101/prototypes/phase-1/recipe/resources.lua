local data_util = require("data_util")


data:extend({
  -- pulverising
  {
    type = "recipe",
    category = "pulverising",
    name = data_util.mod_prefix .. "beryllium-ore-crushed",
    results = {
      {name = data_util.mod_prefix .. "beryllium-ore-crushed", amount = 1} -- 2
    },
    energy_required = 1,
    ingredients = {
      {name = data_util.mod_prefix .. "beryllium-ore", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "beryllium-sulfate",
    main_product = data_util.mod_prefix .. "beryllium-sulfate",
    results = {
      {name = data_util.mod_prefix .. "beryllium-sulfate", amount = 1}, -- 4
      {name = "sand", probability = 0.5, amount_min = 1, amount_max = 1,},
      {type = "fluid", name = "water", amount = 2, catalyst_amount = 2},
    },
    energy_required = 2,
    ingredients = {
      {type = "fluid", name="sulfuric-acid", amount = 2},
      {name = data_util.mod_prefix .. "beryllium-ore-crushed", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        r = 0.338,
        b = 0.482,
        g = 0.965
      },
      quaternary = {
        a = 1,
        r = 0.191,
        b = 0.763,
        g = 0.939
      },
      secondary = {
        a = 1,
        r = 0.222,
        b = 0.56,
        g = 0.831
      },
      tertiary = {
        a = 1,
        r = 0.443,
        b = 0.728,
        g = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "beryllium-hydroxide",
    main_product = data_util.mod_prefix .. "beryllium-hydroxide",
    results = {
      {type = "fluid", name = data_util.mod_prefix .. "beryllium-hydroxide", amount = 200}, --1
    },
    energy_required = 30,
    ingredients = {
      {name = data_util.mod_prefix .. "cryonite-rod", amount = 1},
      {type = "fluid", name="water", amount = 150, catalyst_amount = 150},
      {name = data_util.mod_prefix .. "beryllium-sulfate", amount = 50}
    },
    subgroup = "fluid-recipes",
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        r = 0.338,
        b = 0.482,
        g = 0.965
      },
      quaternary = {
        a = 1,
        r = 0.191,
        b = 0.763,
        g = 0.939
      },
      secondary = {
        a = 1,
        r = 0.222,
        b = 0.56,
        g = 0.831
      },
      tertiary = {
        a = 1,
        r = 0.443,
        b = 0.728,
        g = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "beryllium-powder",
    main_product = data_util.mod_prefix .. "beryllium-powder",
    results = {
      {name = data_util.mod_prefix .. "beryllium-powder", amount = 1}, -- 2
      {type = "fluid", name = "water", amount = 1, catalyst_amount = 1},
    },
    energy_required = 1,
    ingredients = {
      {type = "fluid", name = data_util.mod_prefix .. "beryllium-hydroxide", amount = 2},
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        r = 0.338,
        b = 0.482,
        g = 0.965
      },
      quaternary = {
        a = 1,
        r = 0.191,
        b = 0.763,
        g = 0.939
      },
      secondary = {
        a = 1,
        r = 0.222,
        b = 0.56,
        g = 0.831
      },
      tertiary = {
        a = 1,
        r = 0.443,
        b = 0.728,
        g = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "beryllium-ingot",
    results = {
      {name = data_util.mod_prefix .. "beryllium-ingot", amount = 1}, -- 20
    },
    energy_required = 40,
    ingredients = {
      {name = data_util.mod_prefix .. "beryllium-powder", amount = 10},
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "crafting",
    name = data_util.mod_prefix .. "beryllium-plate",
    results = {
      {name = data_util.mod_prefix .. "beryllium-plate", amount = 4}, -- 5
    },
    energy_required = 15,
    ingredients = {
      {name = data_util.mod_prefix .. "beryllium-ingot", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
  },


  {
    type = "recipe",
    category = "pulverising",
    name = data_util.mod_prefix .. "cryonite-crushed",
    results = {
      {name = data_util.mod_prefix .. "cryonite-crushed", amount = 1}
    },
    energy_required = 0.5,
    ingredients = {
      {name = data_util.mod_prefix .. "cryonite", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "pressure-washing",
    name = data_util.mod_prefix .. "cryonite-washed",
    main_product = data_util.mod_prefix .. "cryonite-washed",
    results = {
      {name = data_util.mod_prefix .. "cryonite-washed", amount = 2},
      {name = "stone", amount_min = 1, amount_max = 1, probability = 0.25},
      {type = "fluid", name="water", amount = 5, catalyst_amount = 5},
    },
    energy_required = 1,
    ingredients = {
      {type = "fluid", name="water", amount = 6, catalyst_amount = 6},
      {name = data_util.mod_prefix .. "cryonite-crushed", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        r = 0.338,
        g = 0.482,
        b = 0.965
      },
      quaternary = {
        a = 1,
        r = 0.191,
        g = 0.763,
        b = 0.939
      },
      secondary = {
        a = 1,
        r = 0.222,
        g = 0.56,
        b = 0.831
      },
      tertiary = {
        a = 1,
        r = 0.443,
        g = 0.728,
        b = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "cryonite-rod",
    results = {
      {name = data_util.mod_prefix .. "cryonite-rod", amount = 1},
    },
    energy_required = 5,
    ingredients = {
      {name = data_util.mod_prefix .. "cryonite-washed", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "cryonite-ion-exchange-beads",
    results = {
      {name = data_util.mod_prefix .. "cryonite-ion-exchange-beads", amount = 10},
    },
    energy_required = 10,
    ingredients = {
      {name = data_util.mod_prefix .. "cryonite-rod", amount = 1},
      {name = "plastic-bar", amount = 1},
      {type = "fluid", name = "sulfuric-acid", amount = 5},
      {type = "fluid", name = "steam", amount = 5},
    },
    crafting_machine_tint = {
      primary = {
        a = 1,
        r = 0.338,
        g = 0.482,
        b = 0.965
      },
      quaternary = {
        a = 1,
        r = 0.191,
        g = 0.763,
        b = 0.939
      },
      secondary = {
        a = 1,
        r = 0.222,
        g = 0.56,
        b = 0.831
      },
      tertiary = {
        a = 1,
        r = 0.443,
        g = 0.728,
        b = 0.818,
      }
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "cryonite-lubricant",
    results = {
      {type = "fluid", name = "lubricant", amount = 10},
    },
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = data_util.mod_prefix .. "cryonite-slush", amount = 10},
      {type = "fluid", name = "heavy-oil", amount = 1},
    },
    subgroup = "fluid-recipes",
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "cryonite-slush",
    results = {
      {type = "fluid", name = data_util.mod_prefix .. "cryonite-slush", amount = 10},
    },
    energy_required = 5,
    ingredients = {
      {name = data_util.mod_prefix .. "cryonite-rod", amount = 1},
      {type = "fluid", name = "sulfuric-acid", amount = 1},
    },
    subgroup = "fluid-recipes",
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "cryonite-to-water-ice",
    results = {
      {name = data_util.mod_prefix .. "water-ice", amount = 1},
    },
    energy_required = 1,
    ingredients = {
      {type = "fluid", name = data_util.mod_prefix .. "cryonite-slush", amount = 1},
      {type = "fluid", name = "water", amount = 100},
    },
    subgroup = "fluid-recipes",
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "steam-to-water",
    results = {
      {type = "fluid", name = "water", amount = 99},
    },
    energy_required = 0.5,
    ingredients = {
      {type = "fluid", name = "steam", amount = 100},
    },
    subgroup = "fluid-recipes",
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false
  },

  {
    type = "recipe",
    category = "pulverising",
    name = data_util.mod_prefix .. "holmium-ore-crushed",
    results = {
      {name = data_util.mod_prefix .. "holmium-ore-crushed", amount = 1}
    },
    energy_required = 1,
    ingredients = {
      {name = data_util.mod_prefix .. "holmium-ore", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "pressure-washing",
    name = data_util.mod_prefix .. "holmium-ore-washed",
    main_product = data_util.mod_prefix .. "holmium-ore-washed",
    results = {
      {name = data_util.mod_prefix .. "holmium-ore-washed", amount = 2},
      {name = "stone", amount_min = 1, amount_max = 1, probability = 0.25},
      {type = "fluid", name="water", amount = 5, catalyst_amount = 5},
    },
    energy_required = 1,
    ingredients = {
      {type = "fluid", name="water", amount = 6, catalyst_amount = 6},
      {name = data_util.mod_prefix .. "holmium-ore-crushed", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        g = 0.338,
        b = 0.482,
        r = 0.965
      },
      quaternary = {
        a = 1,
        g = 0.191,
        b = 0.763,
        r = 0.939
      },
      secondary = {
        a = 1,
        g = 0.222,
        b = 0.56,
        r = 0.831
      },
      tertiary = {
        a = 1,
        g = 0.443,
        b = 0.728,
        r = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "holmium-powder",
    main_product = data_util.mod_prefix .. "holmium-powder",
    results = {
      {name = data_util.mod_prefix .. "holmium-powder", probability = 0.5, amount_min = 1, amount_max = 1},
      {name = data_util.mod_prefix .. "vulcanite-ion-exchange-beads", probability = 0.5, amount_min = 1, amount_max = 1, catalyst_amount = 1},
      {name = data_util.mod_prefix .. "holmium-ore-washed", probability = 0.5, amount_min = 1, amount_max = 1, catalyst_amount = 1},
      {name = "sand", probability = 0.25, amount_min = 1, amount_max = 1, catalyst_amount = 1},
      {type = "fluid", name = "water", amount = 5, catalyst_amount = 5},
    },
    energy_required = 1,
    ingredients = {
      {type = "fluid", name="water", amount = 6, catalyst_amount = 6},
      {name = data_util.mod_prefix .. "vulcanite-ion-exchange-beads", amount = 1, catalyst_amount = 1,},
      {name = data_util.mod_prefix .. "holmium-ore-washed", amount = 1, catalyst_amount = 1,}
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        g = 0.338,
        b = 0.482,
        r = 0.965
      },
      quaternary = {
        a = 1,
        g = 0.191,
        b = 0.763,
        r = 0.939
      },
      secondary = {
        a = 1,
        g = 0.222,
        b = 0.56,
        r = 0.831
      },
      tertiary = {
        a = 1,
        g = 0.443,
        b = 0.728,
        r = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "holmium-ingot",
    results = {
      {name = data_util.mod_prefix .. "holmium-ingot", amount = 1},
    },
    energy_required = 40,
    ingredients = {
      {name = data_util.mod_prefix .. "holmium-powder", amount = 10},
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "crafting",
    name = data_util.mod_prefix .. "holmium-plate",
    results = {
      {name = data_util.mod_prefix .. "holmium-plate", amount = 4},
    },
    energy_required = 15,
    ingredients = {
      {name = data_util.mod_prefix .. "holmium-ingot", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
  },

  {
    type = "recipe",
    category = "pulverising",
    name = data_util.mod_prefix .. "iridium-ore-crushed", -- 2
    results = {
      {name = data_util.mod_prefix .. "iridium-ore-crushed", amount = 1}
    },
    energy_required = 1,
    ingredients = {
      {name = data_util.mod_prefix .. "iridium-ore", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "pressure-washing",
    name = data_util.mod_prefix .. "iridium-ore-washed", -- 2
    main_product = data_util.mod_prefix .. "iridium-ore-washed",
    results = {
      {name = data_util.mod_prefix .. "iridium-ore-washed", amount = 2},
      {name = "stone", amount_min = 1, amount_max = 1, probability = 0.25},
      {type = "fluid", name="water", amount = 5, catalyst_amount = 5},
    },
    energy_required = 1,
    ingredients = {
      {type = "fluid", name="water", amount = 6, catalyst_amount = 6},
      {name = data_util.mod_prefix .. "iridium-ore-crushed", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        b = 0.338,
        r = 0.482,
        g = 0.965
      },
      quaternary = {
        a = 1,
        b = 0.191,
        r = 0.763,
        g = 0.939
      },
      secondary = {
        a = 1,
        b = 0.222,
        r = 0.56,
        g = 0.831
      },
      tertiary = {
        a = 1,
        b = 0.443,
        r = 0.728,
        g = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "iridium-powder", -- 4
    main_product = data_util.mod_prefix .. "iridium-powder",
    results = {
      {name = data_util.mod_prefix .. "iridium-powder", probability = 0.5, amount_min = 1, amount_max = 1},
      {name = data_util.mod_prefix .. "cryonite-ion-exchange-beads", probability = 0.5, amount_min = 1, amount_max = 1, catalyst_amount = 1},
      {name = data_util.mod_prefix .. "iridium-ore-washed", probability = 0.5, amount_min = 1, amount_max = 1, catalyst_amount = 1},
      {name = "sand", probability = 0.25, amount_min = 1, amount_max = 1, catalyst_amount = 1},
      {type = "fluid", name = "water", amount = 5, catalyst_amount = 5},
    },
    energy_required = 1,
    ingredients = {
      {type = "fluid", name="water", amount = 6, catalyst_amount = 6},
      {name = data_util.mod_prefix .. "cryonite-ion-exchange-beads", amount = 1, catalyst_amount = 1,},
      {name = data_util.mod_prefix .. "iridium-ore-washed", amount = 1, catalyst_amount = 1,}
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        b = 0.338,
        r = 0.482,
        g = 0.965
      },
      quaternary = {
        a = 1,
        b = 0.191,
        r = 0.763,
        g = 0.939
      },
      secondary = {
        a = 1,
        b = 0.222,
        r = 0.56,
        g = 0.831
      },
      tertiary = {
        a = 1,
        b = 0.443,
        r = 0.728,
        g = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "iridium-ingot", -- 40
    results = {
      {name = data_util.mod_prefix .. "iridium-ingot", amount = 1},
    },
    energy_required = 40,
    ingredients = {
      {name = data_util.mod_prefix .. "iridium-powder", amount = 10},
        {name=data_util.mod_prefix .. "vulcanite-block", amount = 1},
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "crafting",
    name = data_util.mod_prefix .. "iridium-plate", -- 10
    results = {
      {name = data_util.mod_prefix .. "iridium-plate", amount = 4},
    },
    energy_required = 15,
    ingredients = {
      {name = data_util.mod_prefix .. "iridium-ingot", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "pulverising",
    name = data_util.mod_prefix .. "naquium-ore-crushed",
    results = {
      {name = data_util.mod_prefix .. "naquium-ore-crushed", amount = 1}
    },
    energy_required = 2,
    ingredients = {
      {name = data_util.mod_prefix .. "naquium-ore", amount = 4}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "pressure-washing",
    name = data_util.mod_prefix .. "naquium-ore-washed",
    main_product = data_util.mod_prefix .. "naquium-ore-washed",
    results = {
      {name = data_util.mod_prefix .. "naquium-ore-washed", amount = 2},
      {name = "stone", amount_min = 1, amount_max = 1, probability = 0.25},
      {type = "fluid", name="water", amount = 5},
    },
    energy_required = 2,
    ingredients = {
      {type = "fluid", name="water", amount = 6},
      {name = data_util.mod_prefix .. "naquium-ore-crushed", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        g = 0.338,
        r = 0.482,
        b = 0.965
      },
      quaternary = {
        a = 1,
        g = 0.191,
        r = 0.763,
        b = 0.939
      },
      secondary = {
        a = 1,
        g = 0.222,
        r = 0.56,
        b = 0.831
      },
      tertiary = {
        a = 1,
        g = 0.443,
        r = 0.728,
        b = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "pressure-washing",
    name = data_util.mod_prefix .. "naquium-powder",
    main_product = data_util.mod_prefix .. "naquium-powder",
    results = {
      {name = data_util.mod_prefix .. "naquium-powder", amount = 1},
      {name = "sand", probability = 0.5, amount_min = 1, amount_max = 1,},
      {type="fluid", name = "water", amount = 1},
    },
    energy_required = 20,
    ingredients = {
      {name=data_util.mod_prefix .. "vitalic-acid", amount = 10},
      {name = data_util.mod_prefix .. "naquium-ore-washed", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        g = 0.338,
        r = 0.482,
        b = 0.965
      },
      quaternary = {
        a = 1,
        g = 0.191,
        r = 0.763,
        b = 0.939
      },
      secondary = {
        a = 1,
        g = 0.222,
        r = 0.56,
        b = 0.831
      },
      tertiary = {
        a = 1,
        g = 0.443,
        r = 0.728,
        b = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "naquium-ingot",
    results = {
      {name = data_util.mod_prefix .. "naquium-ingot", amount = 1},
    },
    energy_required = 60,
    ingredients = {
      {name = data_util.mod_prefix .. "naquium-powder", amount = 10},
        {name=data_util.mod_prefix .. "vulcanite-block", amount = 1},
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "crafting",
    name = data_util.mod_prefix .. "naquium-plate",
    results = {
      {name = data_util.mod_prefix .. "naquium-plate", amount = 4},
    },
    energy_required = 30,
    ingredients = {
      {name = data_util.mod_prefix .. "naquium-ingot", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "centrifuging",
    name = data_util.mod_prefix .. "enriched-naquium",
    results = {
      {name = data_util.mod_prefix .. "enriched-naquium", amount = 1},
    },
    energy_required = 2,
    ingredients = {
      {name = data_util.mod_prefix .. "naquium-ingot", amount = 10},
      {name = data_util.mod_prefix .. "cryonite-ion-exchange-beads", amount = 10}
    },
    enabled = false,
    always_show_made_in = true,
  },

  {
    type = "recipe",
    category = "pulverising",
    name = data_util.mod_prefix .. "vitamelange-nugget",
    results = {
      {name = data_util.mod_prefix .. "vitamelange-nugget", amount = 2}, -- 0.5
    },
    energy_required = 1,
    ingredients = {
      {name = data_util.mod_prefix .. "vitamelange", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "vitamelange-roast",
    results = {
      {name = data_util.mod_prefix .. "vitamelange-roast", amount = 50} -- 1
    },
    energy_required = 100,
    ingredients = {
      {name=data_util.mod_prefix .. "vulcanite-block", amount = 1},
      {name = data_util.mod_prefix .. "vitamelange-nugget", amount = 100}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "crafting",
    name = data_util.mod_prefix .. "vitamelange-spice", -- 2
    results = {
      {name = data_util.mod_prefix .. "vitamelange-spice", amount_min=1, amount_max=1, probability=0.5},
    },
    energy_required = 1,
    ingredients = {
      {name = data_util.mod_prefix .. "vitamelange-roast", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "vitamelange-extract", -- 4
    results = {
      {name = data_util.mod_prefix .. "vitamelange-extract", amount_min=1, amount_max=1, probability=0.5},
    },
    energy_required = 1,
    ingredients = {
      {name = data_util.mod_prefix .. "vitamelange-spice", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
  },


  {
    type = "recipe",
    category = "pulverising",
    name = data_util.mod_prefix .. "vulcanite-crushed",
    results = {
      {name = data_util.mod_prefix .. "vulcanite-crushed", amount = 1}
    },
    energy_required = 0.5,
    ingredients = {
      {name = data_util.mod_prefix .. "vulcanite", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "pressure-washing",
    name = data_util.mod_prefix .. "vulcanite-washed",
    main_product = data_util.mod_prefix .. "vulcanite-washed",
    results = {
      {name = data_util.mod_prefix .. "vulcanite-washed", amount = 2},
      {name = "stone", amount_min = 1, amount_max = 1, probability = 0.25},
      {type = "fluid", name="steam", amount = 3, temperature = 165},
    },
    energy_required = 1,
    ingredients = {
      {type = "fluid", name="water", amount = 6},
      {name = data_util.mod_prefix .. "vulcanite-crushed", amount = 2}
    },
    enabled = false,
    always_show_made_in = true,
    crafting_machine_tint = {
      primary = {
        a = 1,
        b = 0.338,
        r = 0.482,
        g = 0.965
      },
      quaternary = {
        a = 1,
        b = 0.191,
        r = 0.763,
        g = 0.939
      },
      secondary = {
        a = 1,
        b = 0.222,
        r = 0.56,
        g = 0.831
      },
      tertiary = {
        a = 1,
        b = 0.443,
        r = 0.728,
        g = 0.818,
      }
    },
  },
  {
    type = "recipe",
    category = "crafting",
    name = data_util.mod_prefix .. "vulcanite-block",
    results = {
      {name = data_util.mod_prefix .. "vulcanite-block", amount = 1},
    },
    energy_required = 1,
    ingredients = {
      {name = data_util.mod_prefix .. "vulcanite-washed", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "chemistry",
    name = data_util.mod_prefix .. "vulcanite-ion-exchange-beads",
    results = {
      {name = data_util.mod_prefix .. "vulcanite-ion-exchange-beads", amount = 10},
    },
    energy_required = 10,
    ingredients = {
      {name = data_util.mod_prefix .. "vulcanite-block", amount = 1},
      {name = "plastic-bar", amount = 1},
      {type = "fluid", name = "sulfuric-acid", amount = 5},
      {type = "fluid", name = "steam", amount = 5},
    },
    crafting_machine_tint = {
      primary = {
        a = 1,
        b = 0.338,
        r = 0.482,
        g = 0.965
      },
      quaternary = {
        a = 1,
        b = 0.191,
        r = 0.763,
        g = 0.939
      },
      secondary = {
        a = 1,
        b = 0.222,
        r = 0.56,
        g = 0.831
      },
      tertiary = {
        a = 1,
        b = 0.443,
        r = 0.728,
        g = 0.818,
      }
    },
    enabled = false,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "iron-smelting-vulcanite",
    results = {
      {name = "iron-plate", amount = 12},
    },
    energy_required = 24,
    ingredients = {
      {name = "iron-ore", amount = 8},
      {name = data_util.mod_prefix .. "vulcanite-block", amount = 1},
    },
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false,
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "copper-smelting-vulcanite",
    results = {
      {name = "copper-plate", amount = 12},
    },
    energy_required = 24,
    ingredients = {
      {name = "copper-ore", amount = 8},
      {name = data_util.mod_prefix .. "vulcanite-block", amount = 1},
    },
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false,
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "stone-brick-vulcanite",
    results = {
      {name = "stone-brick", amount = 6},
    },
    energy_required = 24,
    ingredients = {
      {name = "stone", amount = 8},
      {name = data_util.mod_prefix .. "vulcanite-block", amount = 1},
    },
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false,
  },
  {
    type = "recipe",
    category = "smelting",
    name = data_util.mod_prefix .. "glass-vulcanite",
    results = {
      {name = "glass", amount = 6},
    },
    energy_required = 24,
    ingredients = {
      {name = "sand", amount = 16},
      {name = data_util.mod_prefix .. "vulcanite-block", amount = 1},
    },
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false,
  },


})
