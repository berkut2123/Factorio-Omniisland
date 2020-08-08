data:extend(
{
  {
    type = "recipe",
    name = "energy-shield-mk3-equipment",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {"energy-shield-mk2-equipment", 10},
	    {"low-density-structure", 50},
      {"processing-unit", 100}
    },
    result = "energy-shield-mk3-equipment"
  },
  {
    type = "recipe",
    name = "battery-mk3-equipment",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
	    {"low-density-structure", 50},
      {"battery-mk2-equipment", 10},
	    {"processing-unit", 150}
    },
    result = "battery-mk3-equipment"
  },
  {
    type = "recipe",
    name = "fusion-reactor-mk2-equipment",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
	    {"low-density-structure", 500},
      {"fusion-reactor-equipment", 10},
	    {"processing-unit", 1000}
    },
    result = "fusion-reactor-mk2-equipment"
  },
  {
    type = "recipe",
    name = "exoskeleton-mk2-equipment",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {"exoskeleton-equipment", 10},
	    {"low-density-structure", 100},
      {"processing-unit", 100},
      {"electric-engine-unit", 150}
    },
    result = "exoskeleton-mk2-equipment"
  },
})