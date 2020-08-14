local data_util = require("data_util")
local make_recipe = data_util.make_recipe

-- collider
make_recipe({
  name = data_util.mod_prefix .. "antimatter-canister",
  ingredients = {
    { data_util.mod_prefix .. "magnetic-canister", 1},
    { type = "fluid", name = data_util.mod_prefix .. "antimatter-stream", amount=1000},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 100},
  },
  results = {
    { name = data_util.mod_prefix .. "antimatter-canister", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 100},
  },
  energy_required = 4,
  main_product = data_util.mod_prefix .. "antimatter-canister",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})


make_recipe({
  name = data_util.mod_prefix .. "atomic-data",
  ingredients = {
    { data_util.mod_prefix .. "material-testing-pack", 1},
    { data_util.mod_prefix .. "empty-data", 1},
    { type = "fluid", name = data_util.mod_prefix .. "ion-stream", amount=100},
  },
  results = {
    { name = data_util.mod_prefix .. "atomic-data", amount = 1},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 8},
  },
  energy_required = 2,
  main_product = data_util.mod_prefix .. "atomic-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "boson-data",
  ingredients = {
    { data_util.mod_prefix .. "empty-data", 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 15},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "boson-data", amount_min = 1, amount_max = 1, probability = 0.2},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.79},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 5,
  main_product = data_util.mod_prefix .. "boson-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "entanglement-data",
  ingredients = {
    { data_util.mod_prefix .. "empty-data", 1},
    { type = "fluid", name = data_util.mod_prefix .. "ion-stream", amount = 20},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "entanglement-data", amount_min = 1, amount_max = 1, probability = 0.2},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.79},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 4,
  main_product = data_util.mod_prefix .. "entanglement-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "singularity-data",
  ingredients = {
    { data_util.mod_prefix .. "entanglement-data", 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "singularity-data", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.49},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 5,
  main_product = data_util.mod_prefix .. "singularity-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "lepton-data",
  ingredients = {
    { data_util.mod_prefix .. "empty-data", 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 20},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "lepton-data", amount_min = 1, amount_max = 1, probability = 0.4},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.59},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 5,
  main_product = data_util.mod_prefix .. "lepton-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "magnetic-monopole-data",
  ingredients = {
    { data_util.mod_prefix .. "electromagnetic-field-data", 1},
    { type = "fluid", name = data_util.mod_prefix .. "proton-stream", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "magnetic-monopole-data", amount_min = 1, amount_max = 1, probability = 0.3},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.69},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 5,
  main_product = data_util.mod_prefix .. "magnetic-monopole-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "micro-black-hole-data",
  ingredients = {
    { data_util.mod_prefix .. "empty-data", 1},
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "micro-black-hole-data", amount_min = 1, amount_max = 1, probability = 0.2},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.79},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 5,
  main_product = data_util.mod_prefix .. "micro-black-hole-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "quark-data",
  ingredients = {
    { data_util.mod_prefix .. "empty-data", 1},
    { type = "fluid", name = data_util.mod_prefix .. "proton-stream", amount = 20},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "quark-data", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.49},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 5,
  main_product = data_util.mod_prefix .. "quark-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "subatomic-data",
  ingredients = {
    { data_util.mod_prefix .. "empty-data", 1},
    { type = "fluid", name = data_util.mod_prefix .. "proton-stream", amount = 20},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 10},
  },
  results = {
    { name = data_util.mod_prefix .. "subatomic-data", amount_min = 1, amount_max = 1, probability = 0.6},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.39},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 5,
  main_product = data_util.mod_prefix .. "subatomic-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "fusion-test-data",
  ingredients = {
    { name = data_util.mod_prefix .. "forcefield-data", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "proton-stream", amount = 50},
  },
  results = {
    { name = data_util.mod_prefix .. "fusion-test-data", amount = 1},
  },
  energy_required = 5,
  category = "space-collider",
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "particle-beam-shielding-data",
  ingredients = {
    { name = data_util.mod_prefix .. "empty-data", amount = 1 },
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 10},
    { name = data_util.mod_prefix .. "material-testing-pack", amount = 1 },
    { name = data_util.mod_prefix .. "iridium-plate", amount = 1},
  },
  results = {
    { name = data_util.mod_prefix .. "particle-beam-shielding-data", amount = 1},
    { name = data_util.mod_prefix .. "contaminated-scrap", amount = 10},
    { name = data_util.mod_prefix .. "iridium-plate", amount_min = 1, amount_max = 1, probability = 0.2 },
  },
  energy_required = 5,
  main_product = data_util.mod_prefix .. "particle-beam-shielding-data",
  category = "space-collider",
  enabled = false,
  always_show_made_in = true,
})
