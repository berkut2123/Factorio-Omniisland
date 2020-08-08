local data_util = require("data_util")
local make_recipe = data_util.make_recipe

make_recipe({
  name = data_util.mod_prefix .. "space-coolant",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "space-water", amount = 1},
    { type = "fluid", name = "heavy-oil", amount = 20},
    { name = "copper-plate", amount = 2},
    { name = "iron-plate", amount = 1},
    { name = "sulfur", amount = 1},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 5,
  subgroup = "space-cooling",
  category = "space-manufacturing",
  localised_name = {"fluid-name." .. data_util.mod_prefix .. "space-coolant"},
  always_show_made_in = true,
  order = "a-a",
})

make_recipe({
  name = data_util.mod_prefix .. "space-coolant-cryonite",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "space-water", amount = 5},
    { type = "fluid", name = "heavy-oil", amount = 5},
    { name = data_util.mod_prefix .. "cryonite-rod", amount = 1},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 5,
  subgroup = "space-cooling",
  category = "space-manufacturing",
  localised_name = {"fluid-name." .. data_util.mod_prefix .. "space-coolant"},
  always_show_made_in = true,
  order = "a-a",
})

make_recipe({
  name = data_util.mod_prefix .. "space-coolant-cold",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-warm", amount = 10},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 5},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 5},
  },
  energy_required = 1,
  subgroup = "space-cooling",
  category = "space-hypercooling",
  localised_name = {"recipe-name." .. data_util.mod_prefix .. "space-coolant-cold"},
  enabled = false,
  always_show_made_in = true,
  order = "c-a",
})


make_recipe({
  name = data_util.mod_prefix .. "space-coolant-supercooled",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 10},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 5},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 5},
  },
  energy_required = 2,
  subgroup = "space-cooling",
  category = "space-hypercooling",
  localised_name = {"recipe-name." .. data_util.mod_prefix .. "space-coolant-supercooled"},
  enabled = false,
  always_show_made_in = true,
  order = "d-a",
})

make_recipe({
  name = data_util.mod_prefix .. "space-coolant-cold-cryonite",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-warm", amount = 20},
    { type = "fluid", name = data_util.mod_prefix .. "cryonite-slush", amount = 1},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 15},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 5},
  },
  energy_required = 1,
  subgroup = "space-cooling",
  category = "space-hypercooling",
  localised_name = {"recipe-name." .. data_util.mod_prefix .. "space-coolant-cold-cryonite"},
  enabled = false,
  always_show_made_in = true,
  order = "c-a",
})


make_recipe({
  name = data_util.mod_prefix .. "space-coolant-supercooled-cryonite",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 15},
    { type = "fluid", name = data_util.mod_prefix .. "cryonite-slush", amount = 1},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 5},
  },
  energy_required = 1,
  subgroup = "space-cooling",
  category = "space-hypercooling",
  localised_name = {"recipe-name." .. data_util.mod_prefix .. "space-coolant-supercooled-cryonite"},
  enabled = false,
  always_show_made_in = true,
  order = "d-a",
})
