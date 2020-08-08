local data_util = require("data_util")
local make_recipe = data_util.make_recipe

make_recipe({
  name = data_util.mod_prefix .. "bio-spectral-data",
  ingredients = {
    { name = data_util.mod_prefix .. "specimen", amount = 1},
    { name = data_util.mod_prefix .. "empty-data", amount = 1},
  },
  results = {
    { name = data_util.mod_prefix .. "bio-spectral-data", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "contaminated-bio-sludge", amount = 10},
  },
  energy_required = 20,
  main_product = data_util.mod_prefix .. "bio-spectral-data",
  category = "space-spectrometry",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "ion-spectrometry-data",
  ingredients = {
    { name = data_util.mod_prefix .. "empty-data", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "ion-stream", amount = 40},
  },
  results = {
    { name = data_util.mod_prefix .. "ion-spectrometry-data", amount_min = 1, amount_max = 1, probability = 0.5},
    { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.49},
  },
  energy_required = 20,
  main_product = data_util.mod_prefix .. "ion-spectrometry-data",
  category = "space-spectrometry",
  enabled = false,
  always_show_made_in = true,
})
