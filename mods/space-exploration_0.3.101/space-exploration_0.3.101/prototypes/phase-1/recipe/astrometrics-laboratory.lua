local data_util = require("data_util")
local make_recipe = data_util.make_recipe
local obs_types = data_util.obs_types

make_recipe({
  name = data_util.mod_prefix .. "astrometric-analysis-multispectral-1",
  ingredients = {
    { data_util.mod_prefix .. "visible-observation-data", 1 },
    { data_util.mod_prefix .. "uv-observation-data", 1 },
    { data_util.mod_prefix .. "infrared-observation-data", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 10},
  },
  results = {
    { data_util.mod_prefix .. "astrometric-data", 3 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 3,
  icon = "__space-exploration-graphics__/graphics/icons/data/astrometric.png",
  icon_size = 64,
  category = "space-astrometrics",
  subgroup = "data-astronomic",
  enabled = false,
  always_show_made_in = true,
})
make_recipe({
  name = data_util.mod_prefix .. "astrometric-analysis-multispectral-2",
  ingredients = {
    { data_util.mod_prefix .. "empty-data", 5 },
    { data_util.mod_prefix .. "visible-observation-data", 1 },
    { data_util.mod_prefix .. "uv-observation-data", 1 },
    { data_util.mod_prefix .. "infrared-observation-data", 1 },
    { data_util.mod_prefix .. "microwave-observation-data", 1 },
    { data_util.mod_prefix .. "xray-observation-data", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 10},
  },
  results = {
    { data_util.mod_prefix .. "astrometric-data", 10 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 10,
  icon = "__space-exploration-graphics__/graphics/icons/data/astrometric.png",
  icon_size = 64,
  category = "space-astrometrics",
  subgroup = "data-astronomic",
  enabled = false,
  always_show_made_in = true,
})
make_recipe({
  name = data_util.mod_prefix .. "astrometric-analysis-multispectral-3",
  ingredients = {
    { data_util.mod_prefix .. "empty-data", 13 },
    { data_util.mod_prefix .. "visible-observation-data", 1 },
    { data_util.mod_prefix .. "infrared-observation-data", 1 },
    { data_util.mod_prefix .. "uv-observation-data", 1 },
    { data_util.mod_prefix .. "microwave-observation-data", 1 },
    { data_util.mod_prefix .. "xray-observation-data", 1 },
    { data_util.mod_prefix .. "radio-observation-data", 1 },
    { data_util.mod_prefix .. "gammaray-observation-data", 1 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-cold", amount = 10},
  },
  results = {
    { data_util.mod_prefix .. "astrometric-data", 20 },
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10},
  },
  energy_required = 20,
  icon = "__space-exploration-graphics__/graphics/icons/data/astrometric.png",
  icon_size = 64,
  category = "space-astrometrics",
  subgroup = "data-astronomic",
  enabled = false,
  always_show_made_in = true,
})

local i = 0
for _, type in pairs(obs_types) do
  i = i + 1
  make_recipe({
    name = data_util.mod_prefix .. type[1] .. "-observation-data",
    ingredients = {
      { data_util.mod_prefix .. "observation-frame-" .. type[1], type[2] },
      { data_util.mod_prefix .. "empty-data", 1 },
    },
    results = {
      { name = data_util.mod_prefix .. type[1] .. "-observation-data", amount_min = 1, amount_max = 1, probability = type[3] },
      { name = data_util.mod_prefix .. "junk-data", amount_min = 1, amount_max = 1, probability = 0.99 - type[3] },
      { name = data_util.mod_prefix .. "scrap",  amount_min = 1, amount_max = 1, probability = 0.01 * type[2] },
    },
    energy_required = math.floor(60 * type[3]) / 10,
    main_product = data_util.mod_prefix .. type[1] .. "-observation-data",
    icon = "__space-exploration-graphics__/graphics/icons/data/"..type[1].."-observation.png",
    icon_size = 64,
    category = "space-astrometrics",
    order = "od-a"..i,
    enabled = false,
    always_show_made_in = true,
  })
end
