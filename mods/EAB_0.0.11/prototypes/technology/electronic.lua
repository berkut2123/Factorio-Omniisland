data:extend(
  {
    {
      type = "technology",
      name = "advanced-electronics-4",
      icon = "__bobelectronics__/graphics/icons/technology/advanced-electronics-3.png",
      icon_size = 128,
      prerequisites = {
        "advanced-electronics-3"
      },
      effects = {
        {type = "unlock-recipe", recipe = "platin-trace-circuit-board"},
        {type = "unlock-recipe", recipe = "platin-processing-unit"}
      },
      unit = {
        count = 100,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"utility-science-pack", 1}
        },
        time = 30
      },
      order = "eab-c"
    }
  }
)
