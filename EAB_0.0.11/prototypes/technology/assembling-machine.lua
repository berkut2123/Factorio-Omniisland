data:extend(
  {
    {
      type = "technology",
      name = "automation-7",
      icon = "__base__/graphics/technology/automation.png",
      icon_size = 128,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "assembling-machine-7"
        }
      },
      prerequisites = {"automation-6", "rocket-silo"},
      unit = {
        count = 200,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"production-science-pack", 1},
          {"utility-science-pack", 1},
          {"space-science-pack", 1}
        },
        time = 90
      },
      upgrade = true,
      order = "eab-a"
    },
    {
      type = "technology",
      name = "electronics-machine-4",
      icon = "__base__/graphics/technology/automation.png",
      icon_size = 128,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "electronics-machine-4"
        }
      },
      prerequisites = {
        "electronics-machine-3",
        "advanced-electronics-3"
      },
      unit = {
        count = 150,
        time = 60,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"utility-science-pack", 1},
          {"space-science-pack", 1}
        }
      },
      upgrade = true,
      order = "eab-b"
    }
  }
)
