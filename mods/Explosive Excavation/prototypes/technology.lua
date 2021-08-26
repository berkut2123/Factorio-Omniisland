data:extend({
  {
    type = "technology",
    name = "blasting-charges",
    icon = "__Explosive Excavation__/graphics/technology/blasting-explosives.png",
    icon_size = 128,
    prerequisites = {"cliff-explosives", "landfill", "military-science-pack"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 15
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "blasting-charge"
      }
    },
    order = "b-d"
  }
})