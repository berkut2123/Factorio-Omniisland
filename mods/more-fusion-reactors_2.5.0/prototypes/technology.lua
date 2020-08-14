local fusion2 = "fusion-reactor-equipment-mk2"
local fusion3 ="fusion-reactor-equipment-mk3"
local fusion4 ="fusion-reactor-equipment-mk4"
local fusion5 ="fusion-reactor-equipment-mk5"
local fusion6 ="fusion-reactor-equipment-mk6"



data:extend(
{
  {
    type = "technology",
    name = "fusion-reactor-equipment-2",
    icon = "__more-fusion-reactors__/graphics/technology/fusion-reactor-equipment-2.png",
	icon_size = 384,
	localised_description = {"technology-description.fusion-reactor-equipment-2"},
    prerequisites = {"fusion-reactor-equipment", "effectivity-module"},
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = fusion2
      }
    },
    unit =
    {
      count = 300,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}, {"utility-science-pack", 1}, {"military-science-pack", 1}},
      time = 50
    },
    order = "a-f-c"
  },
  {
    type = "technology",
    name = "fusion-reactor-equipment-3",
    icon = "__more-fusion-reactors__/graphics/technology/fusion-reactor-equipment-3.png",
	icon_size = 384,
	localised_description = {"technology-description.fusion-reactor-equipment-3"},
    prerequisites = {"fusion-reactor-equipment-2", "productivity-module-2"},
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = fusion3
      }
    },
    unit =
    {
      count = 500,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}, {"utility-science-pack", 1}, {"military-science-pack", 1}},
      time = 150
    },
    order = "a-f-c"
  },
  {
    type = "technology",
    name = "fusion-reactor-equipment-4",
    icon = "__more-fusion-reactors__/graphics/technology/fusion-reactor-equipment-4.png",
	icon_size = 384,
	localised_description = {"technology-description.fusion-reactor-equipment-4"},
    prerequisites = {"fusion-reactor-equipment-3", "speed-module-3"},
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = fusion4
      }
    },
    unit =
    {
      count = 800,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}, {"utility-science-pack", 1}, {"military-science-pack", 1}, {"production-science-pack", 1}},
      time = 300
    },
    order = "a-f-c"
  },
  {
    type = "technology",
    name = "fusion-reactor-equipment-5",
    icon = "__more-fusion-reactors__/graphics/technology/fusion-reactor-equipment-5.png",
	icon_size = 384,
	localised_description = {"technology-description.fusion-reactor-equipment-5"},
    prerequisites = {"fusion-reactor-equipment-4", "effectivity-module-3", "productivity-module-3"},
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = fusion5
      }
    },
    unit =
    {
      count = 1000,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}, {"utility-science-pack", 1}, {"military-science-pack", 1}, {"production-science-pack", 1}, {"space-science-pack", 1}},
      time = 500
    },
    order = "a-f-c"
  },
  {
    type = "technology",
    name = "fusion-reactor-equipment-6",
    icon = "__more-fusion-reactors__/graphics/technology/fusion-reactor-equipment-6.png",
	icon_size = 384,
	localised_description = {"technology-description.fusion-reactor-equipment-6"},
    prerequisites = {"fusion-reactor-equipment-5"},
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = fusion6
      }
    },
    unit =
    {
      count = 1500,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}, {"utility-science-pack", 1}, {"military-science-pack", 1}, {"production-science-pack", 1}, {"space-science-pack", 1}},
      time = 1000
    },
    order = "a-f-c"
  },
  })