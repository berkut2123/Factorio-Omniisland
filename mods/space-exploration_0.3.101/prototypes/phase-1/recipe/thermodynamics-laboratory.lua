local data_util = require("data_util")
local make_recipe = data_util.make_recipe

local recipe_multiplier = 4

make_recipe({
  name = data_util.mod_prefix .. "thermodynamics-coal",
  ingredients = {
    { name = data_util.mod_prefix .. "experimental-specimen", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount = 10},
  },
  results = {
    { name = "coal", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "contaminated-space-water", amount = 20},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 1},
  },
  energy_required = 5 * recipe_multiplier,
  subgroup = "space-components",
  category = "space-thermodynamics",
  allow_as_intermediate = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "bio-combustion-data",
  ingredients = {
    { name = data_util.mod_prefix .. "specimen", amount = 1},
    { name = data_util.mod_prefix .. "empty-data", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "bio-combustion-data", amount_min = 1, amount_max = 1, probability = 0.75},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.24},
    { type = "fluid", name = data_util.mod_prefix .. "contaminated-bio-sludge", amount = 2},
  },
  energy_required = 5 * recipe_multiplier,
  main_product = data_util.mod_prefix .. "bio-combustion-data",
  category = "space-thermodynamics",
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "bio-combustion-resistance-data",
  ingredients = {
    { name = data_util.mod_prefix .. "experimental-specimen", amount = 1},
    { name = data_util.mod_prefix .. "empty-data", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "bio-combustion-resistance-data", amount = 1},
    { name = data_util.mod_prefix .. "experimental-specimen", amount_min = 1, amount_max = 1, probability = 0.5},
    { type = "fluid", name = data_util.mod_prefix .. "contaminated-bio-sludge", amount = 7},
  },
  energy_required = 10 * recipe_multiplier,
  main_product = data_util.mod_prefix .. "bio-combustion-resistance-data",
  category = "space-thermodynamics",
  always_show_made_in = true,
})

--[[
-- removed
make_recipe({
  name = data_util.mod_prefix .. "bio-combustion-suppression-data",
  ingredients = {
    { name = data_util.mod_prefix .. "significant-specimen", amount = 1},
    { name = data_util.mod_prefix .. "experimental-material", amount = 1},
    { name = data_util.mod_prefix .. "empty-data", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount = 100},
  },
  results = {
    { name = data_util.mod_prefix .. "bio-combustion-suppression-data", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.49},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 3},
    { type = "fluid", name = data_util.mod_prefix .. "contaminated-bio-sludge", amount = 100},
  },
  category = "space-thermodynamics",
})
]]--

make_recipe({
  name = data_util.mod_prefix .. "cold-thermodynamics-data",
  ingredients = {
    { name = data_util.mod_prefix .. "material-testing-pack", amount = 4},
    { name = data_util.mod_prefix .. "empty-data", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "cold-thermodynamics-data", amount = 1},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 8},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 8},
  },
  energy_required = 10 * recipe_multiplier,
  main_product = data_util.mod_prefix .. "cold-thermodynamics-data",
  category = "space-thermodynamics",
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "hot-thermodynamics-data",
  ingredients = {
    { name = data_util.mod_prefix .. "material-testing-pack", amount = 4},
    { name = data_util.mod_prefix .. "empty-data", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "hot-thermodynamics-data", amount = 1},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 8},
  },
  energy_required = 10 * recipe_multiplier,
  main_product = data_util.mod_prefix .. "hot-thermodynamics-data",
  category = "space-thermodynamics",
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "pressure-containment-data",
  ingredients = {
    { name = data_util.mod_prefix .. "empty-data", amount = 3},
    { name = data_util.mod_prefix .. "heavy-girder", amount = 1},
    { name = "storage-tank", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "space-water", amount = 1000},
  },
  results = {
    { name = data_util.mod_prefix .. "pressure-containment-data", amount = 3},
    { name = data_util.mod_prefix .. "scrap", amount = 50},
    { type = "fluid", name = data_util.mod_prefix .. "space-water", amount = 990},
  },
  energy_required = 6 * recipe_multiplier,
  main_product = data_util.mod_prefix .. "pressure-containment-data",
  category = "space-thermodynamics",
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "explosion-shielding-data",
  ingredients = {
    { name = "explosives", amount = 20},
    { name = data_util.mod_prefix .. "material-testing-pack", amount = 4},
    { name = data_util.mod_prefix .. "heavy-girder", amount = 1},
    { name = data_util.mod_prefix .. "iridium-plate", amount = 1},
    { name = data_util.mod_prefix .. "empty-data", amount = 1},
  },
  results = {
    { name = data_util.mod_prefix .. "explosion-shielding-data", amount = 1},
    { name = data_util.mod_prefix .. "heavy-girder", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "iridium-plate", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "scrap", amount = 10},
  },
  energy_required = 10,
  main_product = data_util.mod_prefix .. "explosion-shielding-data",
  category = "space-thermodynamics",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "experimental-alloys-data",
  ingredients = {
    { name = data_util.mod_prefix .. "iridium-plate", amount = 1},
    { name = data_util.mod_prefix .. "beryllium-plate", amount = 1},
    { name = data_util.mod_prefix .. "holmium-plate", amount = 1},
    { name = "iron-plate", amount = 1},
    { name = "copper-plate", amount = 1},
    { name = data_util.mod_prefix .. "empty-data", amount = 5},
  },
  results = {
    { name = data_util.mod_prefix .. "experimental-alloys-data", amount = 5},
    { name = data_util.mod_prefix .. "scrap", amount = 5},
  },
  energy_required = 20,
  main_product = data_util.mod_prefix .. "experimental-alloys-data",
  category = "space-thermodynamics",
  enabled = false,
  always_show_made_in = true,
})

data_util.make_recipe({
  name = data_util.mod_prefix .. "cryogun",
  ingredients = {
    { data_util.mod_prefix .. "beryllium-plate", 10},
    { data_util.mod_prefix .. "aeroframe-pole", 10},
    { data_util.mod_prefix .. "cryonite-rod", 10},
  },
  results = {
    { data_util.mod_prefix .. "cryogun", 1},
  },
  energy_required = 60,
  category = "space-thermodynamics",
  enabled = false,
})

data_util.make_recipe({
  name = data_util.mod_prefix .. "cryogun-ammo",
  ingredients = {
    { data_util.mod_prefix .. "beryllium-plate", 1},
    { data_util.mod_prefix .. "cryonite-rod", 10},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
  },
  results = {
    { data_util.mod_prefix .. "cryogun-ammo", 1},
  },
  energy_required = 10,
  category = "space-thermodynamics",
  enabled = false,
  always_show_made_in = true,
})
