local data_util = require("data_util")
local make_recipe = data_util.make_recipe

make_recipe({
  name = data_util.mod_prefix .. "empty-lifesupport-canister",
  ingredients = {
    { data_util.mod_prefix .. "canister", 1},
    { "processing-unit", 1},
  },
  results = {
    { data_util.mod_prefix .. "empty-lifesupport-canister", 1},
  },
  energy_required = 10,
  category = "lifesupport",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "lifesupport-canister-fish",
  ingredients = {
    { data_util.mod_prefix .. "empty-lifesupport-canister", 2},
    { "raw-fish", 1},
    { "wood", 10},
    { type = "fluid", name = "water" , amount = 100},
  },
  results = {
    { data_util.mod_prefix .. "lifesupport-canister", 2},
  },
  energy_required = 10,
  category = "lifesupport",
  enabled = false,
  icons = {
    { icon = data.raw.item[data_util.mod_prefix .. "lifesupport-canister"].icon, scale = 1, icon_size = 32 },
    { icon = data.raw.item["wood"].icon, scale = 0.25, shift = {-10, 10}, icon_size = 64 },
    { icon = data.raw.capsule["raw-fish"].icon, scale = 0.25, shift = {-10, 0}, icon_size = 64 },
  },
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "lifesupport-canister-coal",
  ingredients = {
    { data_util.mod_prefix .. "empty-lifesupport-canister", 2},
    { "coal", 2},
    { type = "fluid", name = "water" , amount = 100},
  },
  results = {
    { data_util.mod_prefix .. "lifesupport-canister", 2},
  },
  energy_required = 10,
  category = "lifesupport",
  enabled = false,
  icons = {
    { icon = data.raw.item[data_util.mod_prefix .. "lifesupport-canister"].icon, scale = 1, icon_size = 32 },
    { icon = data.raw.item["coal"].icon, scale = 0.25, shift = {-10, 10}, icon_size = 64 },
  },
  allow_as_intermediate = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "lifesupport-canister-specimen",
  ingredients = {
    { data_util.mod_prefix .. "empty-lifesupport-canister", 1},
    { data_util.mod_prefix .. "specimen", 1},
    { type = "fluid", name = data_util.mod_prefix .. "space-water" , amount = 10},
  },
  results = {
    { data_util.mod_prefix .. "lifesupport-canister", 1},
  },
  energy_required = 10,
  category = "lifesupport",
  icons = {
    { icon = data.raw.item[data_util.mod_prefix .. "empty-lifesupport-canister"].icon, scale = 1, icon_size = 32 },
    { icon = data.raw.item[data_util.mod_prefix .. "specimen"].icon, scale = 0.5, shift = {-10, 10}, icon_size = 32 },
  },
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "used-lifesupport-canister-cleaning",
  ingredients = {
    { data_util.mod_prefix .. "used-lifesupport-canister", 1},
    { type = "fluid", name = "water", amount = 100},
  },
  results = {
    { data_util.mod_prefix .. "empty-lifesupport-canister", 1},
  },
  energy_required = 10,
  localised_name = {"recipe-name."..data_util.mod_prefix .. "used-lifesupport-canister-cleaning"},
  main_product = data_util.mod_prefix .. "empty-lifesupport-canister",
  allow_as_intermediate = false,
  category = "lifesupport",
  icon = "__space-exploration-graphics__/graphics/icons/used-lifesupport-canister.png",
  enabled = false,
  always_show_made_in = true,
})

make_recipe({
  name = data_util.mod_prefix .. "medpack",
  ingredients = {
    { "raw-fish", 5},
    { "wood", 5},
    { "iron-plate", 1},
  },
  results = {
    { data_util.mod_prefix .. "medpack", 1},
  },
  order = "a-a-a",
  energy_required = 10,
  category = "crafting",
  enabled = false,
  always_show_made_in = true,
})
make_recipe({
  name = data_util.mod_prefix .. "medpack-plastic",
  ingredients = {
    { "iron-plate", 1},
    { "plastic-bar", 5},
    { type = "fluid", name =  "water" , amount = 100},
    { type = "fluid", name =  "heavy-oil" , amount = 100},
  },
  results = {
    { data_util.mod_prefix .. "medpack", 1},
  },
  order = "a-a-b",
  energy_required = 10,
  category = "lifesupport",
  enabled = false,
  always_show_made_in = true,
})
make_recipe({
  name = data_util.mod_prefix .. "medpack-2",
  ingredients = {
    { data_util.mod_prefix .. "medpack", 1},
    { data_util.mod_prefix .. "canister", 1},
    { type = "fluid", name =  "petroleum-gas" , amount = 100},
  },
  results = {
    { data_util.mod_prefix .. "medpack-2", 1},
  },
  order = "a-b",
  energy_required = 10,
  category = "lifesupport",
  enabled = false,
  always_show_made_in = true,
})
make_recipe({
  name = data_util.mod_prefix .. "medpack-3",
  ingredients = {
    { data_util.mod_prefix .. "medpack-2", 1},
    { data_util.mod_prefix .. "specimen", 1},
    { type = "fluid", name =  data_util.mod_prefix .. "chemical-gel" , amount = 10},
  },
  results = {
    { data_util.mod_prefix .. "medpack-3", 1},
  },
  order = "a-c",
  energy_required = 10,
  category = "lifesupport",
  enabled = false,
  always_show_made_in = true,
})
make_recipe({
  name = data_util.mod_prefix .. "medpack-4",
  ingredients = {
    { data_util.mod_prefix .. "medpack-3", 1},
    { data_util.mod_prefix .. "significant-specimen", 1},
    { data_util.mod_prefix .. "self-sealing-gel", 1},
    { type = "fluid", name =  data_util.mod_prefix .. "neural-gel-2" , amount = 10},
  },
  results = {
    { data_util.mod_prefix .. "medpack-4", 1},
  },
  order = "a-d",
  energy_required = 10,
  category = "lifesupport",
  enabled = false,
  always_show_made_in = true,
})
