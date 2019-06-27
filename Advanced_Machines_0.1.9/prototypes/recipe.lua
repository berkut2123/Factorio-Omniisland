data:extend({
  {
    type = "recipe",
    name = "advanced-electric-furnace",
    ingredients = {
	{"electric-furnace", 1},
	{"stone-brick", 25},
	{"steel-plate", 25},
	{"advanced-circuit", 50},
	{"processing-unit", 10},
	},
    result = "advanced-electric-furnace",
    energy_required = 15,
    enabled = false
  },
  {
    type = "recipe",
    name = "advanced-chemical-plant",
    ingredients = {
	{"chemical-plant", 1},
    {"steel-plate", 15},
	{"pipe", 10},
    {"iron-gear-wheel", 10},
    {"electronic-circuit", 50},
	{"advanced-circuit", 25},
	{"processing-unit", 10},
    },
    result= "advanced-chemical-plant",
	energy_required = 30,
    enabled = false,
  },
  {
    type = "recipe",
    name = "advanced-beacon",
    enabled = false,
    energy_required = 60,
    ingredients =
    {
	  {"beacon", 1},
      {"electronic-circuit", 100},
      {"advanced-circuit", 50},
	  {"processing-unit", 50},
      {"steel-plate", 25},
      {"copper-cable", 50},
	  --Mabey add back later
	  --{"effectivity-module", 1},
	  --{"speed-module", 1},
	  --{"productivity-module", 1},
    },
    result = "advanced-beacon"
  },
  {
    type = "recipe",
    name = "speed-module-4",
    enabled = false,
    energy_required = 120,
    ingredients =
    { 
	  {"speed-module-3", 4},
	  {"advanced-circuit", 10},
	  {"processing-unit", 10},
    },
    result = "speed-module-4"
  },
  {
    type = "recipe",
    name = "speed-module-5",
    enabled = false,
    energy_required = 240,
    ingredients =
    { 
	  {"speed-module-4", 4},
	  {"advanced-circuit", 50},
	  {"processing-unit", 50},
    },
    result = "speed-module-5"
  },
  {
    type = "recipe",
    name = "effectivity-module-4",
    enabled = false,
    energy_required = 120,
    ingredients =
    {
      {"effectivity-module-3", 4},
	  {"advanced-circuit", 10},
	  {"processing-unit", 10},
    },
    result = "effectivity-module-4"
  },
  {
    type = "recipe",
    name = "effectivity-module-5",
    enabled = false,
    energy_required = 240,
    ingredients =
    {
	  {"effectivity-module-4", 4},
	  {"advanced-circuit", 50},
	  {"processing-unit", 50},
    },
    result = "effectivity-module-5"
  },
  {
    type = "recipe",
    name = "productivity-module-4",
    enabled = false,
    energy_required = 120,
    ingredients =
    {
	  {"productivity-module-3", 4},
	  {"advanced-circuit", 10},
	  {"processing-unit", 10},
    },
    result = "productivity-module-4"
  },
  {
    type = "recipe",
    name = "productivity-module-5",
    enabled = false,
    energy_required = 240,
    ingredients =
    {
	  {"productivity-module-4", 4},
	  {"advanced-circuit", 50},
	  {"processing-unit", 50},
    },
    result = "productivity-module-5"
  },
  {
    type = "recipe",
    name = "extreme-heavy-oil-cracking",
    category = "chemistry",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="fluid", name="water", amount=25},
      {type="fluid", name="heavy-oil", amount=10}
    },
    results=
    {
      {type="fluid", name="petroleum-gas", amount=5}
    },
    main_product= "",
    icon = "__Advanced_Machines__/graphics/icons/fluids/extreme-heavy-oil-cracking.png",
	icon_size = 32,
    subgroup = "fluid-recipes",
    order = "b[fluid-chemistry]-b[heavy-oil-cracking]"
  },
  {
    type = "recipe",
    name = "extreme-oil-processing",
    category = "oil-processing",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="fluid", name="water", amount=10},
      {type="fluid", name="crude-oil", amount=25}
    },
    results=
    {
      {type="fluid", name="heavy-oil", amount=2.5},
      {type="fluid", name="light-oil", amount=10},
      {type="fluid", name="petroleum-gas", amount=15}
    },
    icon = "__Advanced_Machines__/graphics/icons/fluids/extreme-oil-processing.png",
	icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-c[advanced-oil-processing]"
  },
})