data:extend(
{
  {
    type = "technology",
    name = "logistic-beacon",
	icon = "__logtech-beacon__/graphics/technology/logistic-beacon.png",
	icon_size = 128,
    prerequisites = {"logistic-robotics", "construction-robotics"},
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "logistic-beacon"
      }
    },
    unit =
    {
      count = 75,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "c-k-f-f"
  }
}
)
