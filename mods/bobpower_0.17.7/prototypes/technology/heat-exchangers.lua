if settings.startup["bobmods-power-steam"].value == true then

bobmods.lib.tech.add_prerequisite("nuclear-power", "bob-boiler-3")

data:extend(
{
  {
    type = "technology",
    name = "bob-heat-exchanger-2",
    icon = "__bobpower__/graphics/icons/technology/heat-exchanger.png",
    icon_size = 128,
    prerequisites =
    {
      "nuclear-power",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "heat-exchanger-2"
      },
      {
        type = "unlock-recipe",
        recipe = "heat-pipe-2"
      },
    },
    unit =
    {
      time = 30,
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
    },
    order = "[heat-exchanger]-2",
  },

  {
    type = "technology",
    name = "bob-heat-exchanger-3",
    icon = "__bobpower__/graphics/icons/technology/heat-exchanger.png",
    icon_size = 128,
    prerequisites =
    {
      "bob-heat-exchanger-2",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "heat-exchanger-3"
      },
      {
        type = "unlock-recipe",
        recipe = "heat-pipe-3"
      },
    },
    unit =
    {
      time = 30,
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
      },
    },
    order = "[heat-exchanger]-3",
  },
}
)

end

