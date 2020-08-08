local data_util = require("data_util")
local make_recipe = data_util.make_recipe

-- accelerator
make_recipe({
  name = data_util.mod_prefix .. "ion-stream",
  ingredients = {
    { name = "copper-plate", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount = 100},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "ion-stream", amount = 100},
  },
  energy_required = 10,
  category = "space-accelerator",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "proton-stream",
  ingredients = {
    { name = "iron-plate", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount = 100},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "proton-stream", amount = 100},
  },
  energy_required = 20,
  category = "space-accelerator",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "particle-stream",
  ingredients = {
    { name = data_util.mod_prefix .. "material-testing-pack", amount = 1},
    { name = "sand", amount = 5},
    { type = "fluid", name = data_util.mod_prefix .. "plasma-stream", amount = 100},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "particle-stream", amount = 200},
  },
  energy_required = 30,
  category = "space-accelerator",
  enabled = false,
  always_show_made_in = true,
})

-- collider
make_recipe({
  name = data_util.mod_prefix .. "empty-antimatter-canister",
  ingredients = {
    { name = data_util.mod_prefix .. "antimatter-canister", amount = 1},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-supercooled", amount = 100},
  },
  results = {
    { type = "fluid", name = data_util.mod_prefix .. "antimatter-stream", amount=1000},
    { data_util.mod_prefix .. "magnetic-canister", 1},
    { type = "fluid", name = data_util.mod_prefix .. "space-coolant-hot", amount = 100},
  },
  icons = {
    { icon = data.raw.item[data_util.mod_prefix .. "magnetic-canister"].icon, scale = 1, icon_size = 32  },
    { icon = data.raw.fluid[data_util.mod_prefix .. "antimatter-stream"].icon, scale = 1, icon_size = 32  },
  },
  subgroup = "space-fluids",
  energy_required = 30,
  category = "space-accelerator",
  enabled = false,
  always_show_made_in = true,
})
