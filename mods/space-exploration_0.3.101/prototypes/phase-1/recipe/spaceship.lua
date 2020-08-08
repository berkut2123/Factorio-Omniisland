local data_util = require("data_util")

data:extend({
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-console",
    energy_required = 30,
    category = "crafting",
    ingredients =
    {
      {data_util.mod_prefix .. "aeroframe-pole", 20},
      {"glass", 20},
      {"low-density-structure", 20},
      {"processing-unit", 200},
      {data_util.mod_prefix .. "astronomic-catalogue-3", 1},
    },
    result = data_util.mod_prefix .. "spaceship-console",
    result_count = 1,
    enabled = false,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-floor",
    energy_required = 10,
    category = "crafting",
    ingredients =
    {
      {data_util.mod_prefix .. "aeroframe-bulkhead", 1},
      {data_util.mod_prefix .. "space-platform-plating", 1},
    },
    result = data_util.mod_prefix .. "spaceship-floor",
    result_count = 1,
    enabled = false,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-wall",
    energy_required = 10,
    category = "crafting",
    ingredients =
    {
      {data_util.mod_prefix .. "aeroframe-bulkhead", 1},
      {"glass", 8},
      {"low-density-structure", 4},
      {data_util.mod_prefix .. "heat-shielding", 4}
    },
    result = data_util.mod_prefix .. "spaceship-wall",
    result_count = 1,
    enabled = false,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-gate",
    energy_required = 10,
    category = "crafting",
    ingredients =
    {
      {data_util.mod_prefix .. "spaceship-wall", 1},
      {"electric-engine-unit", 6},
      {data_util.mod_prefix .. "aeroframe-bulkhead", 1},
      {data_util.mod_prefix .. "heat-shielding", 1}
      -- TODO: add forcefield projector here
    },
    result = data_util.mod_prefix .. "spaceship-gate",
    result_count = 1,
    enabled = false,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-rocket-engine",
    energy_required = 20,
    category = "crafting",
    ingredients =
    {
      {data_util.mod_prefix .. "aeroframe-scaffold", 4},
      {"steel-plate", 20},
      {data_util.mod_prefix .. "heat-shielding", 20},
      {data_util.mod_prefix .. "space-pipe", 20},
      {"electric-engine-unit", 10},
    },
    result = data_util.mod_prefix .. "spaceship-rocket-engine",
    result_count = 1,
    enabled = false,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-rocket-engine-burn",
    icon = "__space-exploration-graphics__/graphics/icons/spaceship-rocket-engine.png",
    icon_size = 32,
    order = "a",
    subgroup = "spaceship-process",
    energy_required = 0.1,
    category = "spaceship-rocket-engine",
    ingredients =
    {
      {type="fluid", name=data_util.mod_prefix .. "liquid-rocket-fuel", amount=5},
    },
    results = {},
    flags = {"hidden"},
    hidden = true,
    enabled = true,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-rocket-booster-tank",
    energy_required = 10,
    category = "crafting",
    ingredients =
    {
      {data_util.mod_prefix .. "aeroframe-scaffold", 4},
      {"steel-plate", 10},
      {"storage-tank", 10},
      {data_util.mod_prefix .. "heat-shielding", 10},
      {data_util.mod_prefix .. "space-pipe", 4},
      {"electric-engine-unit", 4},
    },
    result = data_util.mod_prefix .. "spaceship-rocket-booster-tank",
    result_count = 1,
    enabled = false,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-antimatter-engine",
    energy_required = 30,
    category = "crafting",
    ingredients =
    {
      {data_util.mod_prefix .. "lattice-pressure-vessel", 10},
      {data_util.mod_prefix .. "aeroframe-scaffold", 10},
      {data_util.mod_prefix .. "spaceship-rocket-engine", 1},
      {"low-density-structure", 100},
      {data_util.mod_prefix .. "heat-shielding", 100},
      {data_util.mod_prefix .. "superconductive-cable", 100},
      {data_util.mod_prefix .. "naquium-processor", 1},
    },
    result = data_util.mod_prefix .. "spaceship-antimatter-engine",
    result_count = 1,
    enabled = false,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-antimatter-engine-burn",
    icon = "__space-exploration-graphics__/graphics/icons/spaceship-antimatter-engine.png",
    icon_size = 32,
    order = "a",
    subgroup = "spaceship-process",
    energy_required = 0.5,
    category = "spaceship-antimatter-engine",
    ingredients =
    {
      {type="fluid", name=data_util.mod_prefix .. "antimatter-stream", amount=1},
      -- 10x energy density, 5 burn would be the same thrust, 25 is 5x faster
    },
    results = {},
    flags = {"hidden"},
    hidden = true,
    enabled = true,
    always_show_made_in = true,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "spaceship-antimatter-booster-tank",
    energy_required = 20,
    category = "crafting",
    ingredients =
    {
      {data_util.mod_prefix .. "lattice-pressure-vessel", 10},
      {data_util.mod_prefix .. "aeroframe-scaffold", 10},
      {data_util.mod_prefix .. "spaceship-rocket-booster-tank", 1},
      {"low-density-structure", 50},
      {data_util.mod_prefix .. "heat-shielding", 50},
      {data_util.mod_prefix .. "superconductive-cable", 100},
      {data_util.mod_prefix .. "naquium-processor", 1},
    },
    result = data_util.mod_prefix .. "spaceship-antimatter-booster-tank",
    result_count = 1,
    enabled = false,
    always_show_made_in = false,
  },
})
