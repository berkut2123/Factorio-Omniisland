if settings.startup["nuclear-fuel-kovarex-enabled"].value then
  data.raw.technology["kovarex-enrichment-process"].enabled = true
  data.raw.recipe["kovarex-enrichment-process"].hidden = false
else
  data.raw.technology["kovarex-enrichment-process"].enabled = false
  data.raw.recipe["kovarex-enrichment-process"].hidden = true
end

data:extend({
  {
    type = "technology",
    name = "nuclear-rocket-fuel",
    icon_size = 128,
    icon = "__Nuclear Fuel__/graphics/technology/nuclear-rocket-fuel.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "nuclear-fuel"
      },
      {
        type = "unlock-recipe",
        recipe = "nuclear-fuel-pu"
      }
    },
    prerequisites = { "production-science-pack", "nuclear-fuel-reprocessing", "rocket-fuel" },
    unit =
    {
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 30,
      count = 100
    },
    order = "e-p-b-c"
  },
  {
    type = "technology",
    name = "mox-fuel",
    icon_size = 128,
    icon = "__Nuclear Fuel__/graphics/technology/plutonium-mox.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "mox-fuel-cell"
      }
    },
    prerequisites = { "nuclear-fuel-reprocessing" },
    unit =
    {
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 30,
      count = 500
    },
    order = "e-p-b-c"
  },
  {
    type = "technology",
    name = "plutonium-breeding",
    icon_size = 128,
    icon = "__Nuclear Fuel__/graphics/technology/plutonium-breeding.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "breeder-fuel-cell"
      },
      {
        type = "unlock-recipe",
        recipe = "breeder-fuel-reprocessing"
      }
    },
    prerequisites = { "nuclear-fuel-reprocessing", "utility-science-pack" },
    unit =
    {
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 30,
      count = 1000
    }
  }
})

data.raw["technology"]["atomic-bomb"].prerequisites =
  { "military-4", "nuclear-fuel-reprocessing", "rocket-control-unit", "rocketry" }
if settings.startup["nuclear-fuel-bomb-ingredient"].value == "both" then
  table.insert(
    data.raw["technology"]["atomic-bomb"].effects,
    {type = "unlock-recipe",recipe = "atomic-bomb-pu"})
end