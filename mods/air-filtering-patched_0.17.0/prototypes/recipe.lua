data:extend({
  {
    type = "recipe-category",
    name = "crafting-air-filter"
  },
  {
    type = "recipe",
    name = "air-filter-machine-mk1",
    icon = "__air-filtering-patched__/graphics/icons/air-filter-machine-mk1.png",
	icon_size = 32,
    energy_required = 10.0,
    enabled = "false",
    ingredients =
    {
      {"assembling-machine-2", 1},
      {"electronic-circuit", 5},
      {"steel-plate", 10}
    },
    result = "air-filter-machine-mk1"
  },
  {
    type = "recipe",
    name = "air-filter-machine-mk2",
    icon = "__air-filtering-patched__/graphics/icons/air-filter-machine-mk2.png",
	icon_size = 32,
    energy_required = 10.0,
    enabled = "false",
    ingredients =
    {
      {"air-filter-machine-mk1", 2},
      {"advanced-circuit", 10}
    },
    result = "air-filter-machine-mk2"
  },
  {
    type = "recipe",
    name = "air-filter-machine-mk3",
    icon = "__air-filtering-patched__/graphics/icons/air-filter-machine-mk3.png",
	icon_size = 32,
    energy_required = 10.0,
    enabled = "false",
    ingredients =
    {
      {"air-filter-machine-mk2", 2},
      {"processing-unit", 10}
    },
    result = "air-filter-machine-mk3"
  },
  {
    type = "recipe",
    name = "air-filter-machine-mk4",
    icon = "__air-filtering-patched__/graphics/icons/air-filter-machine-mk4.png",
	icon_size = 32,
    energy_required = 10.0,
    enabled = "false",
    ingredients =
    {
      {"air-filter-machine-mk3", 2},
      {"processing-unit", 100},
	  {"engine-unit", 1}
    },
    result = "air-filter-machine-mk4"
  },
  {
    type = "recipe",
    name = "air-filter-machine-mk5",
    icon = "__air-filtering-patched__/graphics/icons/air-filter-machine-mk5.png",
	icon_size = 32,
    energy_required = 10.0,
    enabled = "false",
    ingredients =
    {
      {"air-filter-machine-mk4", 2},
      {"processing-unit", 200},
	  {"electric-engine-unit", 5}
    },
    result = "air-filter-machine-mk5"
  },
  {
    type = "recipe",
    name = "air-filter-machine-mk6",
    icon = "__air-filtering-patched__/graphics/icons/air-filter-machine-mk6.png",
	icon_size = 32,
    energy_required = 10.0,
    enabled = "false",
    ingredients =
    {
      {"air-filter-machine-mk5", 2},
      {"processing-unit", 200},
	  {"steel-plate", 50},
	  {"electric-engine-unit", 25}
    },
    result = "air-filter-machine-mk6"
  },
  {
    type = "recipe",
    name = "unused-air-filter",
    icon = "__air-filtering-patched__/graphics/icons/unused-air-filter.png",
	icon_size = 32,
    category = "crafting",
    subgroup = "raw-material",
    order = "f[plastic-bar]-f[unused-air-filter]",
    energy_required = 5,
    enabled = "false",
    ingredients =
    {
      {"coal", 10},
      {"plastic-bar", 4},
      {"steel-plate", 2}
    },
    result = "unused-air-filter"
  },
  {
    type = "recipe",
    name = "filter-air",
    icon = "__air-filtering-patched__/graphics/icons/filter-air.png",
	icon_size = 32,
    category = "crafting-air-filter",
    order = "f[plastic-bar]-f[filter-air]",
    energy_required = 100,
    enabled = "false",
    ingredients =
    {
      {"unused-air-filter", 1}
    },
    result = "used-air-filter"
  },
  {
    type = "recipe",
    name = "air-filter-recycling",
    icon = "__air-filtering-patched__/graphics/icons/air-filter-recycling.png",
	icon_size = 32,
    category = "crafting",
    subgroup = "raw-material",
    order = "f[unused-air-filter]-f[air-filter-recycling]",
    energy_required = 5,
    enabled = "false",
    ingredients =
    {
      {"used-air-filter", 1},
      {"coal", 5}
    },
    result = "unused-air-filter"
  },
  {
    type = "recipe",
    name = "advanced-air-filter-recycling",
    icon = "__air-filtering-patched__/graphics/icons/advanced-air-filter-recycling.png",
	icon_size = 32,
    category = "advanced-crafting",
    subgroup = "raw-material",
    order = "f[unused-air-filter]-f[air-filter-recycling]",
    energy_required = 20,
    enabled = "false",
    ingredients =
    {
      {"used-air-filter", 5},
      {"coal", 20}
    },
    result = "unused-air-filter",
    result_count = 5,
  }
})
