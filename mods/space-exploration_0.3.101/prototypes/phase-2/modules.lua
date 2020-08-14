local data_util = require("data_util")

local modules_per_tier = 3


data.raw.technology["productivity-module"].icon = "__space-exploration-graphics__/graphics/technology/modules/productivity-1.png"
data.raw.technology["productivity-module-2"].icon = "__space-exploration-graphics__/graphics/technology/modules/productivity-2.png"
data.raw.technology["productivity-module-3"].icon = "__space-exploration-graphics__/graphics/technology/modules/productivity-3.png"

data.raw.technology["speed-module"].icon = "__space-exploration-graphics__/graphics/technology/modules/speed-1.png"
data.raw.technology["speed-module-2"].icon = "__space-exploration-graphics__/graphics/technology/modules/speed-2.png"
data.raw.technology["speed-module-3"].icon = "__space-exploration-graphics__/graphics/technology/modules/speed-3.png"

data.raw.technology["effectivity-module"].icon = "__space-exploration-graphics__/graphics/technology/modules/effectivity-1.png"
data.raw.technology["effectivity-module-2"].icon = "__space-exploration-graphics__/graphics/technology/modules/effectivity-2.png"
data.raw.technology["effectivity-module-3"].icon = "__space-exploration-graphics__/graphics/technology/modules/effectivity-3.png"

data_util.tech_add_prerequisites("productivity-module-3", {"battery"})
data_util.tech_add_prerequisites("speed-module-3", {"battery"})
data_util.tech_add_prerequisites("effectivity-module-3", {"battery"})

data_util.replace_or_add_ingredient("productivity-module-2", "productivity-module", "productivity-module", modules_per_tier)
data_util.replace_or_add_ingredient("speed-module-2", "speed-module", "speed-module", modules_per_tier)
data_util.replace_or_add_ingredient("effectivity-module-2", "effectivity-module", "effectivity-module", modules_per_tier)

data_util.replace_or_add_ingredient("productivity-module-3", "productivity-module-2", "productivity-module-2", modules_per_tier)
data_util.replace_or_add_ingredient("speed-module-3", "speed-module-2", "speed-module-2", modules_per_tier)
data_util.replace_or_add_ingredient("effectivity-module-3", "effectivity-module-2", "effectivity-module-2", modules_per_tier)

data.raw.module["productivity-module"].icon = "__space-exploration-graphics__/graphics/icons/modules/productivity-1.png"
data.raw.module["productivity-module"].icon_size = 64
data.raw.module["productivity-module"].subgroup = "module-productivity"
data.raw.module["productivity-module"].effect =
  {
    productivity = {bonus = 0.04},
    consumption = {bonus = 0.5},
    pollution = {bonus = 0.05},
    speed = {bonus = -0.1}
  }
data.raw.module["productivity-module-2"].icon = "__space-exploration-graphics__/graphics/icons/modules/productivity-2.png"
data.raw.module["productivity-module-2"].icon_size = 64
data.raw.module["productivity-module-2"].subgroup = "module-productivity"
data.raw.module["productivity-module-2"].effect =
  {
    productivity = {bonus = 0.06},
    consumption = {bonus = 0.6},
    pollution = {bonus = 0.06},
    speed = {bonus = -0.15}
  }
data.raw.module["productivity-module-3"].icon = "__space-exploration-graphics__/graphics/icons/modules/productivity-3.png"
data.raw.module["productivity-module-3"].icon_size = 64
data.raw.module["productivity-module-3"].subgroup = "module-productivity"
data.raw.module["productivity-module-3"].effect =
  {
    productivity = {bonus = 0.08},
    consumption = {bonus = 0.8},
    pollution = {bonus = 0.08},
    speed = {bonus = -0.2}
  }

data.raw.module["speed-module"].icon = "__space-exploration-graphics__/graphics/icons/modules/speed-1.png"
data.raw.module["speed-module"].icon_size = 64
data.raw.module["speed-module"].subgroup = "module-speed"
data.raw.module["speed-module"].effect =
  {
    consumption = {bonus = 0.5},
    pollution = {bonus = 0.04},
    speed = {bonus = 0.2}
  }
data.raw.module["speed-module-2"].icon = "__space-exploration-graphics__/graphics/icons/modules/speed-2.png"
data.raw.module["speed-module-2"].icon_size = 64
data.raw.module["speed-module-2"].subgroup = "module-speed"
data.raw.module["speed-module-2"].effect =
  {
    consumption = {bonus = 0.6},
    pollution = {bonus = 0.06},
    speed = {bonus = 0.3}
  }
data.raw.module["speed-module-3"].icon = "__space-exploration-graphics__/graphics/icons/modules/speed-3.png"
data.raw.module["speed-module-3"].icon_size = 64
data.raw.module["speed-module-3"].subgroup = "module-speed"
data.raw.module["speed-module-3"].effect =
  {
    consumption = {bonus = 0.8},
    pollution = {bonus = 0.08},
    speed = {bonus = 0.4}
  }

data.raw.module["effectivity-module"].icon = "__space-exploration-graphics__/graphics/icons/modules/effectivity-1.png"
data.raw.module["effectivity-module"].icon_size = 64
data.raw.module["effectivity-module"].subgroup = "module-effectivity"
data.raw.module["effectivity-module"].effect =
  {
    consumption = {bonus = -0.4},
    pollution = {bonus = -0.1},
  }
data.raw.module["effectivity-module-2"].icon = "__space-exploration-graphics__/graphics/icons/modules/effectivity-2.png"
data.raw.module["effectivity-module-2"].icon_size = 64
data.raw.module["effectivity-module-2"].subgroup = "module-effectivity"
data.raw.module["effectivity-module-2"].effect =
  {
    consumption = {bonus = -0.6},
    pollution = {bonus = -0.15},
  }
data.raw.module["effectivity-module-3"].icon = "__space-exploration-graphics__/graphics/icons/modules/effectivity-3.png"
data.raw.module["effectivity-module-3"].icon_size = 64
data.raw.module["effectivity-module-3"].subgroup = "module-effectivity"
data.raw.module["effectivity-module-3"].effect =
  {
    consumption = {bonus = -1},
    pollution = {bonus = -0.2},
  }

data:extend({

    --productivity
    {
        type = "recipe",
        name = "productivity-module",
        ingredients = {
            {name = "electronic-circuit", amount = 5},
            {name = "advanced-circuit", amount = 1},
        },
        energy_required = 2^1,
        result = "productivity-module",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "recipe",
        name = "productivity-module-2",
        ingredients = {
            {name = "productivity-module", amount = modules_per_tier},
            {name = "advanced-circuit", amount = 5},
            {name = "processing-unit", amount = 1},
        },
        energy_required = 2^2,
        result = "productivity-module-2",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "recipe",
        name = "productivity-module-3",
        ingredients = {
            {name = "productivity-module-2", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = "battery", amount = 1},
        },
        energy_required = 2^3,
        result = "productivity-module-3",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "module",
        name = "productivity-module-4",
        icon = "__space-exploration-graphics__/graphics/icons/modules/productivity-4.png",
        icon_size = 64,
        subgroup = "module-productivity",
        category = "productivity",
        tier = 4,
        order = "c[productivity]-d[productivity-module-4]",
        stack_size = 50,
        effect =
        {
          productivity = {bonus = 0.1},
          consumption = {bonus = 1},
          pollution = {bonus = 0.1},
          speed = {bonus = -0.25}
        },
        limitation = productivity_module_limitation(),
        limitation_message_key = "production-module-usable-only-on-intermediates"
    },
    {
        type = "recipe",
        name = "productivity-module-4",
        ingredients = {
            {name = "productivity-module-3", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "vulcanite-block", amount = 5},
            {name = data_util.mod_prefix .. "machine-learning-data", amount = 1},
        },
        energy_required = 2^4,
        result = "productivity-module-4",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "productivity-module-4",
        effects = {
            {type = "unlock-recipe", recipe = "productivity-module-4"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/productivity-4.png",
        icon_size = 128,
        order = "i-e-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "rocket-science-pack",
           "productivity-module-3"
        },
        unit = {
         count = 300,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
         }
        },
    },
    {
        type = "module",
        name = "productivity-module-5",
        icon = "__space-exploration-graphics__/graphics/icons/modules/productivity-5.png",
        icon_size = 64,
        subgroup = "module-productivity",
        category = "productivity",
        tier = 5,
        order = "c[productivity]-e[productivity-module-5]",
        stack_size = 50,
        effect =
        {
          productivity = {bonus = 0.12},
          consumption = {bonus = 1.2},
          pollution = {bonus = 0.12},
          speed = {bonus = -0.3}
        },
        limitation = productivity_module_limitation(),
        limitation_message_key = "production-module-usable-only-on-intermediates"
    },
    {
        type = "recipe",
        name = "productivity-module-5",
        ingredients = {
            {name = "productivity-module-4", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "vitamelange-extract", amount = 10},
            {name = data_util.mod_prefix .. "biological-catalogue-1", amount = 1},
        },
        energy_required = 2^5,
        result = "productivity-module-5",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "productivity-module-5",
        effects = {
            {type = "unlock-recipe", recipe = "productivity-module-5"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/productivity-5.png",
        icon_size = 128,
        order = "i-e-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-biological-1",
           "productivity-module-4",
        },
        unit = {
         count = 500,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "biological-science-pack-1", 1 },
         }
        },
    },
    {
        type = "module",
        name = "productivity-module-6",
        icon = "__space-exploration-graphics__/graphics/icons/modules/productivity-6.png",
        icon_size = 64,
        subgroup = "module-productivity",
        category = "productivity",
        tier = 6,
        order = "c[productivity]-f[productivity-module-6]",
        stack_size = 50,
        effect =
        {
          productivity = {bonus = 0.14},
          consumption = {bonus = 1.4},
          pollution = {bonus = 0.14},
          speed = {bonus = -0.35}
        },
        limitation = productivity_module_limitation(),
        limitation_message_key = "production-module-usable-only-on-intermediates"
    },
    {
        type = "recipe",
        name = "productivity-module-6",
        ingredients = {
            {name = "productivity-module-5", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "biological-catalogue-2", amount = 1}
        },
        energy_required = 2^6,
        result = "productivity-module-6",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "productivity-module-6",
        effects = {
            {type = "unlock-recipe", recipe = "productivity-module-6"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/productivity-6.png",
        icon_size = 128,
        order = "i-e-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-biological-2",
           "productivity-module-5",
        },
        unit = {
         count = 200,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "biological-science-pack-2", 1 },
         }
        },

    },
    {
        type = "module",
        name = "productivity-module-7",
        icon = "__space-exploration-graphics__/graphics/icons/modules/productivity-7.png",
        icon_size = 64,
        subgroup = "module-productivity",
        category = "productivity",
        tier = 7,
        order = "c[productivity]-f[productivity-module-7]",
        stack_size = 50,
        effect =
        {
          productivity = {bonus = 0.16},
          consumption = {bonus = 1.6},
          pollution = {bonus = 0.16},
          speed = {bonus = -0.4}
        },
        limitation = productivity_module_limitation(),
        limitation_message_key = "production-module-usable-only-on-intermediates"
    },
    {
        type = "recipe",
        name = "productivity-module-7",
        ingredients = {
            {name = "productivity-module-6", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "biological-catalogue-3", amount = 1}
        },
        energy_required = 2^7,
        result = "productivity-module-7",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "productivity-module-7",
        effects = {
            {type = "unlock-recipe", recipe = "productivity-module-7"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/productivity-7.png",
        icon_size = 128,
        order = "i-e-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-biological-3",
           "productivity-module-6"
        },
        unit = {
         count = 500,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "biological-science-pack-3", 1 },
         }
        },

    },
    {
        type = "module",
        name = "productivity-module-8",
        icon = "__space-exploration-graphics__/graphics/icons/modules/productivity-8.png",
        icon_size = 64,
        subgroup = "module-productivity",
        category = "productivity",
        tier = 8,
        order = "c[productivity]-h[productivity-module-8]",
        stack_size = 50,
        effect =
        {
          productivity = {bonus = 0.18},
          consumption = {bonus = 1.8},
          pollution = {bonus = 0.18},
          speed = {bonus = -0.45}
        },
        limitation = productivity_module_limitation(),
        limitation_message_key = "production-module-usable-only-on-intermediates"
    },
    {
        type = "recipe",
        name = "productivity-module-8",
        ingredients = {
            {name = "productivity-module-7", amount = modules_per_tier},
            {name = data_util.mod_prefix .. "neural-gel", amount = 10, type="fluid"},
            {name = data_util.mod_prefix .. "biological-catalogue-4", amount = 1}
        },
        energy_required = 2^8,
        category = "crafting-with-fluid",
        result = "productivity-module-8",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "productivity-module-8",
        effects = {
            {type = "unlock-recipe", recipe = "productivity-module-8"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/productivity-8.png",
        icon_size = 128,
        order = "i-e-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-biological-4",
           "productivity-module-7"
        },
        unit = {
         count = 800,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "biological-science-pack-4", 1 },
         }
        },

    },
    {
        type = "module",
        name = "productivity-module-9",
        icon = "__space-exploration-graphics__/graphics/icons/modules/productivity-9.png",
        icon_size = 64,
        subgroup = "module-productivity",
        category = "productivity",
        tier = 9,
        order = "c[productivity]-i[productivity-module-9]",
        stack_size = 50,
        effect =
        {
          productivity = {bonus = 0.2},
          consumption = {bonus = 2},
          pollution = {bonus = 0.2},
          speed = {bonus = -0.5}
        },
        limitation = productivity_module_limitation(),
        limitation_message_key = "production-module-usable-only-on-intermediates"
    },
    {
        type = "recipe",
        name = "productivity-module-9",
        ingredients = {
            {name = "productivity-module-8", amount = modules_per_tier},
            {name = data_util.mod_prefix .. "superconductive-cable", amount = 5},
            {name = data_util.mod_prefix .. "neural-gel-2", amount = 50, type="fluid"},
            {name = data_util.mod_prefix .. "biological-catalogue-4", amount = 1}
        },
        energy_required = 2^9,
        category = "crafting-with-fluid",
        result = "productivity-module-9",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "productivity-module-9",
        effects = {
            {type = "unlock-recipe", recipe = "productivity-module-9"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/productivity-9.png",
        icon_size = 128,
        order = "i-e-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "deep-space-science-pack",
           "productivity-module-8"
        },
        unit = {
         count = 1000,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "biological-science-pack-4", 1 },
           { data_util.mod_prefix .. "deep-space-science-pack", 1},
         }
        },

    },

    --speed
    {
        type = "recipe",
        name = "speed-module",
        ingredients = {
            {name = "electronic-circuit", amount = 5},
            {name = "advanced-circuit", amount = 1},
        },
        energy_required = 2^1,
        result = "speed-module",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "recipe",
        name = "speed-module-2",
        ingredients = {
            {name = "speed-module", amount = modules_per_tier},
            {name = "advanced-circuit", amount = 5},
            {name = "processing-unit", amount = 1},
        },
        energy_required = 2^2,
        result = "speed-module-2",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "recipe",
        name = "speed-module-3",
        ingredients = {
            {name = "speed-module-2", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = "battery", amount = 1},
        },
        energy_required = 2^3,
        result = "speed-module-3",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "module",
        name = "speed-module-4",
        icon = "__space-exploration-graphics__/graphics/icons/modules/speed-4.png",
        icon_size = 64,
        subgroup = "module-speed",
        category = "speed",
        tier = 4,
        order = "a[speed]-d[speed-module-4]",
        stack_size = 50,
        effect = {
          speed = {bonus = 0.5},
          consumption = {bonus = 1.1},
          pollution = {bonus = 0.1}
        }
    },
    {
        type = "recipe",
        name = "speed-module-4",
        ingredients = {
            {name = "speed-module-3", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "iridium-plate", amount = 5},
            {name = data_util.mod_prefix .. "machine-learning-data", amount = 1},
        },
        energy_required = 2^4,
        result = "speed-module-4",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "speed-module-4",
        effects = {
            {type = "unlock-recipe", recipe = "speed-module-4"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/speed-4.png",
        icon_size = 128,
        order = "i-c-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "rocket-science-pack",
           "speed-module-3"
        },
        unit = {
         count = 300,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
         }
        },

    },
    {
        type = "module",
        name = "speed-module-5",
        icon = "__space-exploration-graphics__/graphics/icons/modules/speed-5.png",
        icon_size = 64,
        subgroup = "module-speed",
        category = "speed",
        tier = 5,
        order = "a[speed]-e[speed-module-5]",
        stack_size = 50,
        effect = {
          speed = {bonus = 0.6},
          consumption = {bonus = 1.5},
          pollution = {bonus = 0.12}
        }
    },
    {
        type = "recipe",
        name = "speed-module-5",
        ingredients = {
            {name = "speed-module-4", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "material-catalogue-1", amount = 1}
        },
        energy_required = 2^5,
        result = "speed-module-5",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "speed-module-5",
        effects = {
            {type = "unlock-recipe", recipe = "speed-module-5"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/speed-5.png",
        icon_size = 128,
        order = "i-c-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-material-1",
           "speed-module-4"
        },
        unit = {
         count = 500,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "material-science-pack-1", 1 },
         }
        },

    },
    {
        type = "module",
        name = "speed-module-6",
        icon = "__space-exploration-graphics__/graphics/icons/modules/speed-6.png",
        icon_size = 64,
        subgroup = "module-speed",
        category = "speed",
        tier = 6,
        order = "a[speed]-f[speed-module-6]",
        stack_size = 50,
        effect = {
          speed = {bonus = 0.7},
          consumption = {bonus = 2},
          pollution = {bonus = 0.14}
        }
    },
    {
        type = "recipe",
        name = "speed-module-6",
        ingredients = {
            {name = "speed-module-5", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "material-catalogue-2", amount = 1}
        },
        energy_required = 2^6,
        result = "speed-module-6",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "speed-module-6",
        effects = {
            {type = "unlock-recipe", recipe = "speed-module-6"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/speed-6.png",
        icon_size = 128,
        order = "i-c-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-material-2",
           "speed-module-5"
        },
        unit = {
         count = 200,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "material-science-pack-2", 1 },
         }
        },

    },
    {
        type = "module",
        name = "speed-module-7",
        icon = "__space-exploration-graphics__/graphics/icons/modules/speed-7.png",
        icon_size = 64,
        subgroup = "module-speed",
        category = "speed",
        tier = 7,
        order = "a[speed]-g[speed-module-7]",
        stack_size = 50,
        effect = {
          speed = {bonus = 0.8},
          consumption = {bonus = 2.6},
          pollution = {bonus = 0.16}
        }
    },
    {
        type = "recipe",
        name = "speed-module-7",
        ingredients = {
            {name = "speed-module-6", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "material-catalogue-3", amount = 1}
        },
        energy_required = 2^7,
        result = "speed-module-7",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "speed-module-7",
        effects = {
            {type = "unlock-recipe", recipe = "speed-module-7"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/speed-7.png",
        icon_size = 128,
        order = "i-c-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-material-3",
           "speed-module-6"
        },
        unit = {
         count = 500,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "material-science-pack-3", 1 },
         }
        },

    },
    {
        type = "module",
        name = "speed-module-8",
        icon = "__space-exploration-graphics__/graphics/icons/modules/speed-8.png",
        icon_size = 64,
        subgroup = "module-speed",
        category = "speed",
        tier = 8,
        order = "a[speed]-h[speed-module-8]",
        stack_size = 50,
        effect = {
          speed = {bonus = 0.9},
          consumption = {bonus = 3.3},
          pollution = {bonus = 0.18}
        }
    },
    {
        type = "recipe",
        name = "speed-module-8",
        ingredients = {
            {name = "speed-module-7", amount = modules_per_tier},
            {name = data_util.mod_prefix .. "superconductive-cable", amount = 5},
            {name = data_util.mod_prefix .. "material-catalogue-4", amount = 1}
        },
        energy_required = 2^8,
        result = "speed-module-8",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "speed-module-8",
        effects = {
            {type = "unlock-recipe", recipe = "speed-module-8"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/speed-8.png",
        icon_size = 128,
        order = "i-c-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-material-4",
           "speed-module-7"
        },
        unit = {
         count = 800,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "material-science-pack-4", 1 },
         }
        },

    },
    {
        type = "module",
        name = "speed-module-9",
        icon = "__space-exploration-graphics__/graphics/icons/modules/speed-9.png",
        icon_size = 64,
        subgroup = "module-speed",
        category = "speed",
        tier = 9,
        order = "a[speed]-i[speed-module-9]",
        stack_size = 50,
        effect = {
          speed = {bonus = 1},
          consumption = {bonus = 4},
          pollution = {bonus = 0.2}
        }
    },
    {
        type = "recipe",
        name = "speed-module-9",
        ingredients = {
            {name = "speed-module-8", amount = modules_per_tier},
            {name = data_util.mod_prefix .. "superconductive-cable", amount = 5},
            {name = data_util.mod_prefix .. "nano-material", amount = 25},
            {name = data_util.mod_prefix .. "material-catalogue-4", amount = 1}
        },
        energy_required = 2^9,
        result = "speed-module-9",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "speed-module-9",
        effects = {
            {type = "unlock-recipe", recipe = "speed-module-9"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/speed-9.png",
        icon_size = 128,
        order = "i-c-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "deep-space-science-pack",
           data_util.mod_prefix .. "nano-material",
           "speed-module-8"
        },
        unit = {
         count = 1000,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "material-science-pack-4", 1 },
           { data_util.mod_prefix .. "deep-space-science-pack", 1 },
         }
        },

    },
      --efficiency
    {
        type = "recipe",
        name = "effectivity-module",
        ingredients = {
            {name = "electronic-circuit", amount = 5},
            {name = "advanced-circuit", amount = 1},
        },
        energy_required = 2^1,
        result = "effectivity-module",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "recipe",
        name = "effectivity-module-2",
        ingredients = {
            {name = "effectivity-module", amount = modules_per_tier},
            {name = "advanced-circuit", amount = 5},
            {name = "processing-unit", amount = 1},
        },
        energy_required = 2^2,
        result = "effectivity-module-2",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "recipe",
        name = "effectivity-module-3",
        ingredients = {
            {name = "effectivity-module-2", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = "battery", amount = 1},
        },
        energy_required = 2^3,
        result = "effectivity-module-3",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "module",
        name = "effectivity-module-4",
        icon = "__space-exploration-graphics__/graphics/icons/modules/effectivity-4.png",
        icon_size = 64,
        subgroup = "module-effectivity",
        category = "effectivity",
        tier = 4,
        order = "c[effectivity]-d[effectivity-module-4]",
        stack_size = 50,
        effect = {
          consumption = {bonus = -1.7},
          pollution = {bonus = -0.25},
        }
    },
    {
        type = "recipe",
        name = "effectivity-module-4",
        ingredients = {
            {name = "effectivity-module-3", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "holmium-plate", amount = 5},
            {name = data_util.mod_prefix .. "machine-learning-data", amount = 1}
        },
        energy_required = 2^4,
        result = "effectivity-module-4",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "effectivity-module-4",
        effects = {
            {type = "unlock-recipe", recipe = "effectivity-module-4"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/effectivity-4.png",
        icon_size = 128,
        order = "i-g-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "rocket-science-pack",
           "effectivity-module-3"
        },
        unit = {
         count = 300,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
         }
        },

    },
    {
        type = "module",
        name = "effectivity-module-5",
        icon = "__space-exploration-graphics__/graphics/icons/modules/effectivity-5.png",
        icon_size = 64,
        subgroup = "module-effectivity",
        category = "effectivity",
        tier = 5,
        order = "c[effectivity]-e[effectivity-module-5]",
        stack_size = 50,
        effect = {
          consumption = {bonus = -2.7},
          pollution = {bonus = -0.3},
        }
    },
    {
        type = "recipe",
        name = "effectivity-module-5",
        ingredients = {
            {name = "effectivity-module-4", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "energy-catalogue-1", amount = 1}
        },
        energy_required = 2^5,
        result = "effectivity-module-5",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "effectivity-module-5",
        effects = {
            {type = "unlock-recipe", recipe = "effectivity-module-5"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/effectivity-5.png",
        icon_size = 128,
        order = "i-g-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-energy-1",
           "effectivity-module-4"
        },
        unit = {
         count = 500,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "energy-science-pack-1", 1 },
         }
        },

    },
    {
        type = "module",
        name = "effectivity-module-6",
        icon = "__space-exploration-graphics__/graphics/icons/modules/effectivity-6.png",
        icon_size = 64,
        subgroup = "module-effectivity",
        category = "effectivity",
        tier = 6,
        order = "c[effectivity]-f[effectivity-module-6]",
        stack_size = 50,
        effect = {
          consumption = {bonus = -4},
          pollution = {bonus = -0.35},
        }
    },
    {
        type = "recipe",
        name = "effectivity-module-6",
        ingredients = {
            {name = "effectivity-module-5", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "energy-catalogue-2", amount = 1}
        },
        energy_required = 2^6,
        result = "effectivity-module-6",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "effectivity-module-6",
        effects = {
            {type = "unlock-recipe", recipe = "effectivity-module-6"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/effectivity-6.png",
        icon_size = 128,
        order = "i-g-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-energy-2",
           "effectivity-module-5"
        },
        unit = {
         count = 200,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "energy-science-pack-2", 1 },
         }
        },

    },
    {
        type = "module",
        name = "effectivity-module-7",
        icon = "__space-exploration-graphics__/graphics/icons/modules/effectivity-7.png",
        icon_size = 64,
        subgroup = "module-effectivity",
        category = "effectivity",
        tier = 7,
        order = "c[effectivity]-g[effectivity-module-7]",
        stack_size = 50,
        effect = {
          consumption = {bonus = -5.6},
          pollution = {bonus = -0.4},
        }
    },
    {
        type = "recipe",
        name = "effectivity-module-7",
        ingredients = {
            {name = "effectivity-module-6", amount = modules_per_tier},
            {name = "processing-unit", amount = 5},
            {name = data_util.mod_prefix .. "energy-catalogue-3", amount = 1}
        },
        energy_required = 2^7,
        result = "effectivity-module-7",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "effectivity-module-7",
        effects = {
            {type = "unlock-recipe", recipe = "effectivity-module-7"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/effectivity-7.png",
        icon_size = 128,
        order = "i-g-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-energy-3",
           "effectivity-module-6"
        },
        unit = {
         count = 500,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "energy-science-pack-3", 1 },
         }
        },

    },
    {
        type = "module",
        name = "effectivity-module-8",
        icon = "__space-exploration-graphics__/graphics/icons/modules/effectivity-8.png",
        icon_size = 64,
        subgroup = "module-effectivity",
        category = "effectivity",
        tier = 8,
        order = "c[effectivity]-h[effectivity-module-8]",
        stack_size = 50,
        effect = {
          consumption = {bonus = -7.6},
          pollution = {bonus = -0.45}
        }
    },
    {
        type = "recipe",
        name = "effectivity-module-8",
        ingredients = {
            {name = "effectivity-module-7", amount = modules_per_tier},
            {name = data_util.mod_prefix .. "superconductive-cable", amount = 5},
            {name = data_util.mod_prefix .. "energy-catalogue-4", amount = 1}
        },
        energy_required = 2^8,
        result = "effectivity-module-8",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "effectivity-module-8",
        effects = {
            {type = "unlock-recipe", recipe = "effectivity-module-8"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/effectivity-8.png",
        icon_size = 128,
        order = "i-g-a",
        upgrade = true,
        prerequisites = {
           data_util.mod_prefix .. "space-catalogue-energy-4",
           "effectivity-module-7"
        },
        unit = {
         count = 800,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "energy-science-pack-4", 1 },
         }
        },

    },
    {
        type = "module",
        name = "effectivity-module-9",
        icon = "__space-exploration-graphics__/graphics/icons/modules/effectivity-9.png",
        icon_size = 64,
        subgroup = "module-effectivity",
        category = "effectivity",
        tier = 9,
        order = "c[effectivity]-i[effectivity-module-9]",
        stack_size = 50,
        effect = {
          consumption = {bonus = -10},
          pollution = {bonus = -0.5}
        }
    },
    {
        type = "recipe",
        name = "effectivity-module-9",
        ingredients = {
            {name = "effectivity-module-8", amount = modules_per_tier},
            {name = data_util.mod_prefix .. "superconductive-cable", amount = 5},
            {name = data_util.mod_prefix .. "antimatter-canister", amount = 1},
            {name = data_util.mod_prefix .. "energy-catalogue-4", amount = 1}
        },
        energy_required = 512,
        result = "effectivity-module-9",
        enabled = false,
        always_show_products = true,
        always_show_made_in = true,
    },
    {
        type = "technology",
        name = "effectivity-module-9",
        effects = {
            {type = "unlock-recipe", recipe = "effectivity-module-9"}
        },
        icon = "__space-exploration-graphics__/graphics/technology/modules/effectivity-9.png",
        icon_size = 128,
        order = "i-g-a",
        upgrade = true,
        prerequisites = {
            data_util.mod_prefix .. "deep-space-science-pack",
            "effectivity-module-8"
        },
        unit = {
         count = 1000,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "energy-science-pack-4", 1 },
           { data_util.mod_prefix .. "deep-space-science-pack", 1 },
         }
        },

    },
}
)
