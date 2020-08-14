local data_util = require("data_util")
local make_recipe = data_util.make_recipe
local obs_types = data_util.obs_types

make_recipe({
  name = data_util.mod_prefix .. "observation-frame-gammaray",
  ingredients = {
    { data_util.mod_prefix .. "observation-frame-blank", 12 },
    { data_util.mod_prefix .. "gammaray-detector", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 3},
  },
  results = {
    { data_util.mod_prefix .. "observation-frame-gammaray", 12 },
    { name = data_util.mod_prefix .. "scrap", amount_min = 1, amount_max = 1, probability = 0.5 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 3},
  },
  energy_required = 16,
  --energy_required = math.ceil(2 + 20 / 5 * 12 / (obs_types["gammaray"][2] / obs_types["gammaray"][3])), -- base, size, results, required, success
  main_product = data_util.mod_prefix .. "observation-frame-gammaray",
  icon = "__space-exploration-graphics__/graphics/icons/observation-frame-gammaray.png",
  category = "space-observation-gammaray",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "observation-frame-xray",
  ingredients = {
    { data_util.mod_prefix .. "observation-frame-blank", 12 },
    { data_util.mod_prefix .. "space-mirror", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 4},
  },
  results = {
    { data_util.mod_prefix .. "observation-frame-xray", 12 },
    { name = data_util.mod_prefix .. "scrap", amount_min = 1, amount_max = 1, probability = 0.25 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 4},
  },
  energy_required = 12,
  --energy_required = math.ceil(2 + 20 / 5 * 12 / (obs_types["xray"][2] / obs_types["xray"][3])), -- base, size, results, required, success
  main_product = data_util.mod_prefix .. "observation-frame-xray",
  icon = "__space-exploration-graphics__/graphics/icons/observation-frame-xray.png",
  category = "space-observation-xray",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "observation-frame-uv",
  ingredients = {
    { data_util.mod_prefix .. "observation-frame-blank", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 8},
  },
  results = {
    { data_util.mod_prefix .. "observation-frame-uv", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 8},
  },
  energy_required = math.ceil(2 + 100 / 3 * 1 / (obs_types["uv"][2] / obs_types["uv"][3])), -- base, size, results, required, success
  main_product = data_util.mod_prefix .. "observation-frame-uv",
  icon = "__space-exploration-graphics__/graphics/icons/observation-frame-uv.png",
  category = "space-observation-uv",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "observation-frame-visible",
  ingredients = {
    { data_util.mod_prefix .. "observation-frame-blank", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 8},
  },
  results = {
    { data_util.mod_prefix .. "observation-frame-visible", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 8},
  },
  energy_required = math.ceil(2 + 100 / 3 * 1 / (obs_types["visible"][2] / obs_types["visible"][3])), -- base, size, results, required, success
  main_product = data_util.mod_prefix .. "observation-frame-visible",
  icon = "__space-exploration-graphics__/graphics/icons/observation-frame-visible.png",
  category = "space-observation-visible",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "observation-frame-infrared",
  ingredients = {
    { data_util.mod_prefix .. "observation-frame-blank", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 6},
  },
  results = {
    { data_util.mod_prefix .. "observation-frame-infrared", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 6},
  },
  energy_required = math.ceil(2 + 100 / 3 * 1 / (obs_types["infrared"][2] / obs_types["infrared"][3])), -- base, size, results, required, success
  main_product = data_util.mod_prefix .. "observation-frame-infrared",
  icon = "__space-exploration-graphics__/graphics/icons/observation-frame-infrared.png",
  category = "space-observation-infrared",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "observation-frame-microwave",
  ingredients = {
    { data_util.mod_prefix .. "observation-frame-blank", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 5},
  },
  results = {
    { data_util.mod_prefix .. "observation-frame-microwave", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 5},
  },
  energy_required = math.ceil(2 + 150 / 9 * 1 / (obs_types["microwave"][2] / obs_types["microwave"][3])), -- base, size, results, required, success
  main_product = data_util.mod_prefix .. "observation-frame-microwave",
  icon = "__space-exploration-graphics__/graphics/icons/observation-frame-microwave.png",
  category = "space-observation-microwave",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "observation-frame-radio",
  ingredients = {
    { data_util.mod_prefix .. "observation-frame-blank", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 4},
  },
  results = {
    { data_util.mod_prefix .. "observation-frame-radio", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 4},
  },
  energy_required = math.ceil(2 + 150 / 9 * 1 / (obs_types["radio"][2] / obs_types["radio"][3])), -- base, size, results, required, success
  main_product = data_util.mod_prefix .. "observation-frame-radio",
  icon = "__space-exploration-graphics__/graphics/icons/observation-frame-radio.png",
  category = "space-observation-radio",
  enabled = false,
  always_show_made_in = true,
})
