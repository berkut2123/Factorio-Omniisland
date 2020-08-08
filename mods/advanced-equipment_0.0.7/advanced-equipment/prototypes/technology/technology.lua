data:extend(
{
  {
    type = "technology",
    name = "power-armor-mk3",
    icon = "__advanced-equipment__/graphics/technology/power-armor-mk3.png",
	  icon_size = 128,
    prerequisites = {"power-armor-mk2", "speed-module-3", "effectivity-module-3"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "power-armor-mk3"
      }
    },
    unit =
    {
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 30
    },
    order = "g-i-b"
  },
  {
    type = "technology",
    name = "battery-mk3-equipment",
    icon = "__advanced-equipment__/graphics/technology/battery-mk3-equipment.png",
	  icon_size = 128,
    prerequisites = {"battery-mk2-equipment", "utility-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "battery-mk3-equipment"
      }
    },
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 30
    },
    order = "g-i-b"
  },
  {
    type = "technology",
    name = "energy-shield-mk3-equipment",
    icon = "__advanced-equipment__/graphics/technology/energy-shield-mk3-equipment.png",
	  icon_size = 128,
    prerequisites = {"energy-shield-mk2-equipment", "military-4"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "energy-shield-mk3-equipment"
      }
    },
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 30
    },
    order = "g-i-b"
  },
  {
    type = "technology",
    name = "fusion-reactor-mk2-equipment",
    icon = "__advanced-equipment__/graphics/technology/fusion-reactor-mk2-equipment.png",
	  icon_size = 128,
    prerequisites = {"fusion-reactor-equipment", "production-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "fusion-reactor-mk2-equipment"
      }
    },
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 30
    },
    order = "g-i-b"
  },
  {
    type = "technology",
    name = "exoskeleton-mk2-equipment",
    icon = "__advanced-equipment__/graphics/technology/exoskeleton-mk2-equipment.png",
	  icon_size = 128,
    prerequisites = {"exoskeleton-equipment", "production-science-pack", "utility-science-pack", "military-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "exoskeleton-mk2-equipment"
      }
    },
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 30
    },
    order = "g-i-b"
  }
})