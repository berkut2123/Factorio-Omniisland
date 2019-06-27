data:extend({
  {
    type = "technology",
    name = "scanning-radar-tech",
    icon_size = 128,
    icon = "__ScanningRadar__/graphics/technology_icon_scanningradar.png",
    prerequisites = {"electric-engine","advanced-electronics-2"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "scanning-radar"
      }
    },
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
    },
    order = "i-h"
  }
})
