local data_util = require("data_util")
local make_recipe = data_util.make_recipe

-- plasma
make_recipe({
  name = data_util.mod_prefix .. "plasma-canister",
  ingredients = {
    { data_util.mod_prefix .. "magnetic-canister", 1},
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount=1000},
  },
  results = {
    { data_util.mod_prefix .. "plasma-canister", 1},
  },
  energy_required = 30,
  category = "space-plasma",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "plasma-canister-empty",
  ingredients = {
    { data_util.mod_prefix .. "plasma-canister", 1},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount=1000},
    { data_util.mod_prefix .. "magnetic-canister", 1},
  },
  main_product = data_util.mod_prefix .. "plasma-stream",
  energy_required = 2,
  category = "space-plasma",
  enabled = false,
  always_show_made_in = true,
  localised_name = {"recipe-name." .. data_util.mod_prefix .. "plasma-canister-empty"}
})

make_recipe({
  name = data_util.mod_prefix .. "plasma-stream",
  ingredients = {
    { name = "stone", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "chemical-gel", amount = 10},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount = 100},
  },
  energy_required = 30,
  category = "space-plasma",
  enabled = false,
  always_show_made_in = true,
})
