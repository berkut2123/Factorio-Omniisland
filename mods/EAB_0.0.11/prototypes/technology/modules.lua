data:extend(
  {
    {
      type = "technology",
      name = "rich-productivity-module-1",
      icon = "__EAB__/graphics/icons/rich-productivity-module-1.png",
      icon_size = 32,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "rich-productivity-module-1"
        }
      },
      prerequisites = {"raw-productivity-module-8"},
      unit = {
        count = 250000,
        ingredients = {
          {"effectivity-processor", 6},
          {"productivity-processor", 6},
          {"pollution-clean-processor", 6},
          {"module-circuit-board", 3},
          {"module-case", 2}
        },
        time = 120
      },
      upgrade = true,
      order = "eab-d"
    },
    {
      type = "technology",
      name = "rich-productivity-module-2",
      icon = "__EAB__/graphics/icons/rich-productivity-module-2.png",
      icon_size = 32,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "rich-productivity-module-2"
        }
      },
      prerequisites = {"rich-productivity-module-1"},
      unit = {
        count = 300000,
        ingredients = {
          {"effectivity-processor", 6},
          {"productivity-processor", 6},
          {"pollution-clean-processor", 6},
          {"module-circuit-board", 3},
          {"module-case", 2}
        },
        time = 120
      },
      upgrade = true,
      order = "eab-e"
    },
    {
      type = "technology",
      name = "rich-productivity-module-3",
      icon = "__EAB__/graphics/icons/rich-productivity-module-3.png",
      icon_size = 32,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "rich-productivity-module-3"
        }
      },
      prerequisites = {"rich-productivity-module-2"},
      unit = {
        count = 400000,
        ingredients = {
          {"effectivity-processor", 6},
          {"productivity-processor", 6},
          {"pollution-clean-processor", 6},
          {"module-circuit-board", 3},
          {"module-case", 2}
        },
        time = 120
      },
      upgrade = true,
      order = "eab-f"
    }
  }
)
