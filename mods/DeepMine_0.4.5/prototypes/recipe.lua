data:extend({
  {
    type = "recipe",
    name = "deep-mine",
    enabled = false,
    ingredients =
    {
      {"electric-mining-drill", 1},
      {"steel-plate", 25},
      {"advanced-circuit", 5},
    },
    result = "deep-mine",
    energy_required = 5
  },
  {
    type = "recipe",
    name = "deep-mine-2",
    enabled = false,
    ingredients =
    {
      {"deep-mine", 1},
      {"speed-module", 4},
    },
    result = "deep-mine-2",
    energy_required = 5
  },
})