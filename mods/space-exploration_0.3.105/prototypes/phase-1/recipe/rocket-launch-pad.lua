local data_util = require("data_util")
local make_recipe = data_util.make_recipe

data:extend({
  {
    -- the dummy recipe for ethe rcoket silo section, required for launch
    -- the component is inserted then the launch pad has the required parts.
    type = "recipe",
    name = data_util.mod_prefix .. "rocket-launch-pad-silo-dummy-recipe",
    result = data_util.mod_prefix .. "rocket-launch-pad-silo-dummy-result-item",
    category = "rocket-building",
    enabled = false,
    energy_required = 0.01,
    hidden = true,
    ingredients = {
      { data_util.mod_prefix .. "rocket-launch-pad-silo-dummy-ingredient-item", 1 } -- could be anything really
    },
    always_show_made_in = true,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "rocket-launch-pad",
      result = data_util.mod_prefix .. "rocket-launch-pad",
      enabled = false,
      energy_required = 30,
      ingredients = {
        {
          "steel-plate",
          1000
        },
        {
          "concrete",
          1000
        },
        {
          "pipe",
          100
        },
        {
          "storage-tank",
          10
        },
        {
          "radar",
          10
        },
        {
          "steel-chest",
          10
        },
        {
          "processing-unit",
          200
        },
        {
          "electric-engine-unit",
          200
        }
      },
      requester_paste_multiplier = 1,
    },
    always_show_made_in = true,
})
