data:extend({
  {
    type = "technology",
    name = "advanced-material-processing-3",
    icon = "__base__/graphics/technology/advanced-material-processing.png",
	icon_size = 128,
    effects ={
      {
        type = "unlock-recipe",
        recipe = "advanced-electric-furnace"
      }
    },
    prerequisites = { "advanced-material-processing-2", "advanced-electronics-2"},
    unit ={
      count = 250,
      ingredients ={
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 60
    },
    order = "c-c-c"
  },
  {
    type = "technology",
    name = "effect-transmission-2",
    icon = "__base__/graphics/technology/effect-transmission.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "advanced-beacon"
      }
    },
    prerequisites = {"modules", "effectivity-module", "speed-module", "productivity-module", "effect-transmission"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
		
      },
      time = 60
    },
    order = "i-kw"
  },
  {
    type = "technology",
    name = "speed-module-4",
    icon = "__base__/graphics/technology/speed-module.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "speed-module-4"
      }
    },
    prerequisites = {"speed-module-3"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
        
      },
      time = 60
    },
    upgrade = true,
    order = "i-c-d"
  },
  {
    type = "technology",
    name = "speed-module-5",
    icon = "__base__/graphics/technology/speed-module.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "speed-module-5"
      }
    },
    prerequisites = {"speed-module-4"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
        
      },
      time = 60
    },
    upgrade = true,
    order = "i-c-e"
  },
  {
    type = "technology",
    name = "productivity-module-4",
    icon = "__base__/graphics/technology/productivity-module.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "productivity-module-4"
      }
    },
    prerequisites = {"productivity-module-3"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
       
      },
      time = 60
    },
    upgrade = true,
    order = "i-e-d"
  },
  {
    type = "technology",
    name = "productivity-module-5",
    icon = "__base__/graphics/technology/productivity-module.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "productivity-module-5"
      }
    },
    prerequisites = {"productivity-module-4"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
       
      },
      time = 60
    },
    upgrade = true,
    order = "i-e-e"
  },
  {
    type = "technology",
    name = "effectivity-module-4",
    icon = "__base__/graphics/technology/effectivity-module.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "effectivity-module-4"
      }
    },
    prerequisites = {"effectivity-module-3"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      
      },
      time = 60
    },
    upgrade = true,
    order = "i-g-d"
  },
  {
    type = "technology",
    name = "effectivity-module-5",
    icon = "__base__/graphics/technology/effectivity-module.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "effectivity-module-5"
      }
    },
    prerequisites = {"effectivity-module-4"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      
      },
      time = 60
    },
    upgrade = true,
    order = "i-g-e"
  },
  {
    type = "technology",
    name = "advanced-oil-processing-2",
    icon = "__base__/graphics/technology/oil-processing.png",
	icon_size = 128,
    prerequisites = {"advanced-oil-processing", "advanced-electronics-2", "fluid-handling" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "extreme-oil-processing"
      },
      {
        type = "unlock-recipe",
        recipe = "extreme-heavy-oil-cracking"
      },
	  {
        type = "unlock-recipe",
        recipe = "advanced-chemical-plant"
      }
    },
	unit =
    {
      count = 1000,
      ingredients = {
	  {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1}
	},				
      time = 60
    },
    order = "d-c"
  },

})