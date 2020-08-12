local data_util = require("data_util")
local make_recipe = data_util.make_recipe

make_recipe({
  name = data_util.mod_prefix .. "radiating-space-coolant-slow",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 500}, -- 2.5/s
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-warm", amount = 499}, -- -0.2%
  },
  energy_required = 200,
  subgroup = "space-cooling",
  category = "space-radiator",
  localised_name = {"recipe-name." .. data_util.mod_prefix .. "radiating-space-coolant-slow"},
  enabled = false,
  always_show_made_in = true,
  order = "b-a",
})

make_recipe({
  name = data_util.mod_prefix .. "radiating-space-coolant-normal",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 50}, -- 5/s
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-warm", amount = 49}, -- -2%
  },
  energy_required = 10,
  subgroup = "space-cooling",
  category = "space-radiator",
  localised_name = {"recipe-name." .. data_util.mod_prefix .. "radiating-space-coolant-normal"},
  enabled = false,
  always_show_made_in = true,
  order = "b-b",
})



make_recipe({
  name = data_util.mod_prefix .. "radiating-space-coolant-fast",
  ingredients = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 10}, -- 10/s
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-warm", amount = 9}, -- -10%
  },
  energy_required = 1,
  subgroup = "space-cooling",
  category = "space-radiator",
  localised_name = {"recipe-name." .. data_util.mod_prefix .. "radiating-space-coolant-fast"},
  enabled = false,
  always_show_made_in = true,
  order = "b-c",
})
