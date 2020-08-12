local data_util = require("data_util")
local make_recipe = data_util.make_recipe

make_recipe({
  name = data_util.mod_prefix .. "antimatter-stream",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount=50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 100},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "antimatter-stream", amount = 50}, -- 50 * 20MJ = 1000 MJ = 1GJ
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 100},
  },
  energy_required = 40, -- 400 * 5MW = 2000MJ
  main_product = data_util.mod_prefix .. "antimatter-stream",
  category = "space-materialisation",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-dirty",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 8},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 10,
  category = "space-materialisation",
  subgroup = "space-components",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item[data_util.mod_prefix .. "contaminated-scrap"].icon,
      icon_size = data.raw.item[data_util.mod_prefix .. "contaminated-scrap"].icon_size
    }
  ),
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-iron",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = "iron-ore", amount = 4},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 10,
  category = "space-materialisation",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item["iron-ore"].icon,
      icon_size = data.raw.item["iron-ore"].icon_size
    }
  ),
  subgroup = "space-components",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  localised_name = {"recipe-name.se-matter-fusion-to", {"item-name.iron-ore"}}
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-copper",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = "copper-ore", amount = 4},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 10,
  category = "space-materialisation",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item["copper-ore"].icon,
      icon_size = data.raw.item["copper-ore"].icon_size
    }
  ),
  subgroup = "space-components",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  localised_name = {"recipe-name.se-matter-fusion-to", {"item-name.copper-ore"}}
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-stone",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = "stone", amount = 4},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 10,
  category = "space-materialisation",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item["stone"].icon,
      icon_size = data.raw.item["stone"].icon_size
    }
  ),
  subgroup = "space-components",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  localised_name = {"recipe-name.se-matter-fusion-to", {"item-name.stone"}}
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-uranium",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = "uranium-ore", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 60,
  category = "space-materialisation",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item["uranium-ore"].icon,
      icon_size = data.raw.item["uranium-ore"].icon_size
    }
  ),
  subgroup = "space-components",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  localised_name = {"recipe-name.se-matter-fusion-to", {"item-name.uranium-ore"}}
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-beryllium",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = data_util.mod_prefix .."beryllium-ore", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 60,
  category = "space-materialisation",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item[data_util.mod_prefix .."beryllium-ore"].icon,
      icon_size = data.raw.item[data_util.mod_prefix .."beryllium-ore"].icon_size
    }
  ),
  subgroup = "space-components",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  localised_name = {"recipe-name.se-matter-fusion-to", {"item-name." .. data_util.mod_prefix .."beryllium-ore"}}
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-holmium",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = data_util.mod_prefix .."holmium-ore", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 60,
  category = "space-materialisation",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item[data_util.mod_prefix .."holmium-ore"].icon,
      icon_size = data.raw.item[data_util.mod_prefix .."holmium-ore"].icon_size
    }
  ),
  subgroup = "space-components",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  localised_name = {"recipe-name.se-matter-fusion-to", {"item-name." .. data_util.mod_prefix .."holmium-ore"}}
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-iridium",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = data_util.mod_prefix .."iridium-ore", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 60,
  category = "space-materialisation",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item[data_util.mod_prefix .."iridium-ore"].icon,
      icon_size = data.raw.item[data_util.mod_prefix .."iridium-ore"].icon_size
    }
  ),
  subgroup = "space-components",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  localised_name = {"recipe-name.se-matter-fusion-to", {"item-name." .. data_util.mod_prefix .."iridium-ore"}}
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-vulcanite",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = data_util.mod_prefix .."vulcanite", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 30,
  category = "space-materialisation",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item[data_util.mod_prefix .."vulcanite"].icon,
      icon_size = data.raw.item[data_util.mod_prefix .."vulcanite"].icon_size
    }
  ),
  subgroup = "space-components",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  localised_name = {"recipe-name.se-matter-fusion-to", {"item-name." .. data_util.mod_prefix .."vulcanite"}}
})

make_recipe({
  name = data_util.mod_prefix .. "matter-fusion-cryonite",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
  },
  results = {
    { name = data_util.mod_prefix .."cryonite", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 30,
  category = "space-materialisation",
  icons = data_util.transition_icons(
    {
      icon = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon,
      icon_size = data.raw.fluid[data_util.mod_prefix .. "particle-stream"].icon_size
    },
    {
      icon = data.raw.item[data_util.mod_prefix .."cryonite"].icon,
      icon_size = data.raw.item[data_util.mod_prefix .."cryonite"].icon_size
    }
  ),
  subgroup = "space-components",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  localised_name = {"recipe-name.se-matter-fusion-to", {"item-name." .. data_util.mod_prefix .."cryonite"}}
})

make_recipe({
  name = data_util.mod_prefix .. "nano-material",
  ingredients = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1, catalyst_amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 25},
    { data_util.mod_prefix .. "dynamic-emitter", 1},
    { data_util.mod_prefix .. "aeroframe-bulkhead", 1},
    { data_util.mod_prefix .. "heavy-girder", 1},
    { data_util.mod_prefix .. "vitalic-epoxy", 1},
  },
  results = {
    { name = data_util.mod_prefix .. "nano-material", amount=10},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
    { name = data_util.mod_prefix .. "fusion-test-data", amount_min = 1, amount_max = 1, probability = 0.99},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.01},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 25},
  },
  energy_required = 40,
  main_product = data_util.mod_prefix .. "nano-material",
  category = "space-materialisation",
  enabled = false,
  always_show_made_in = true,
})
