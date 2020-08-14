local data_util = require("data_util")
local make_recipe = data_util.make_recipe

data:extend({
  {
      type = "recipe",
      name = data_util.mod_prefix .. "space-capsule",
      result = data_util.mod_prefix .. "space-capsule",
      energy_required = 60,
      ingredients = {
        { data_util.mod_prefix .. "heat-shielding", 100 },
        { "rocket-control-unit", 100 },
        { "low-density-structure", 100 },
        { "rocket-fuel", 100 },
        { "solar-panel", 50 },
        { "accumulator", 50 },
        { "glass", 50 },
      },
      requester_paste_multiplier = 2,
      enabled = false,
      always_show_made_in = true,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "cargo-rocket-section",
      result = data_util.mod_prefix .. "cargo-rocket-section",
      energy_required = 30,
      ingredients = {
        { data_util.mod_prefix .. "heat-shielding", 4 },
        { "low-density-structure", 4 },
        { "rocket-control-unit", 4 },
        { data_util.mod_prefix .. "cargo-rocket-cargo-pod", 1 },
        { data_util.mod_prefix .. "cargo-rocket-fuel-tank", 1 }
      },
      requester_paste_multiplier = 1,
      enabled = false,
      always_show_made_in = true,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "cargo-rocket-section-beryllium",
      results = {
        { data_util.mod_prefix .. "cargo-rocket-section", 2 }
      },
      energy_required = 60,
      ingredients = {
        { data_util.mod_prefix .. "beryllium-plate", 10 },
        { data_util.mod_prefix .. "heat-shielding", 4 },
        { "low-density-structure", 4 },
        { "rocket-control-unit", 4 },
        { data_util.mod_prefix .. "cargo-rocket-cargo-pod", 1 },
        { data_util.mod_prefix .. "cargo-rocket-fuel-tank", 1 }
      },
      requester_paste_multiplier = 1,
      enabled = false,
      always_show_made_in = true,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "cargo-rocket-section-unpack",
      results = {{
        type = "item",
        name = data_util.mod_prefix .. "cargo-rocket-section",
        amount = 5,
        catalyst_amount = 5
      }},
      result_count = 5,
      energy_required = 5,
      ingredients = {
        { data_util.mod_prefix .. "cargo-rocket-section-packed", 1 }
      },
      requester_paste_multiplier = 1,
      enabled = false,
      always_show_made_in = true,
      always_show_products = true,
      category = "crafting-with-fluid", -- no hand crafting
      localised_name = {"recipe-name."..data_util.mod_prefix .. "cargo-rocket-section-unpack"},
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "cargo-rocket-section-pack",
      result = data_util.mod_prefix .. "cargo-rocket-section-packed",
      energy_required = 5,
      ingredients = {{
        type = "item",
        name = data_util.mod_prefix .. "cargo-rocket-section",
        amount = 5,
        catalyst_amount = 5
      }},
      requester_paste_multiplier = 1,
      enabled = false,
      always_show_made_in = true,
      always_show_products = true,
      category = "crafting-with-fluid", -- no hand crafting
      localised_name = {"recipe-name."..data_util.mod_prefix .. "cargo-rocket-section-pack"},
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "cargo-rocket-cargo-pod",
      result = data_util.mod_prefix .. "cargo-rocket-cargo-pod",
      energy_required = 30,
      ingredients = {
        { "steel-plate", 6 },
        { "advanced-circuit", 4 },
        { "iron-chest", 4 }, -- Bentham, at least they die in fire
        { "fast-inserter", 2},
      },
      requester_paste_multiplier = 2,
      enabled = false,
      always_show_made_in = true,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "cargo-rocket-fuel-tank",
      result = data_util.mod_prefix .. "cargo-rocket-fuel-tank",
      energy_required = 30,
      ingredients = {
        { "advanced-circuit", 2 },
        { "pipe", 2 },
        { "storage-tank", 1 },
        { "pump", 1 },
      },
      requester_paste_multiplier = 2,
      enabled = false,
      always_show_made_in = true,
  },
})
