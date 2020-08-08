data:extend({
----------------------------------------
--------------------BASIC----------------
----------------------------------------
--------------------Boltgun, HB, .75 Mk1, .100 Mk1----------------
  {
      type = "technology",
      name = "basic-bolter",
      icon = "__Wh40k_Armoury__/graphics/technology/basic-bolter.png",
	  icon_size = 128,
      effects =
      {
        {type = "unlock-recipe", recipe = "boltgun"},
		{type = "unlock-recipe", recipe = "heavy_bolter"},
		{type = "unlock-recipe", recipe = "bolt75mk1"},
		{type = "unlock-recipe", recipe = "bolt100mk1"},
      },
      prerequisites = {"military-4"},
      unit =
      {
        count = 400,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"chemical-science-pack", 1},
		  {"military-science-pack", 1},
        },
        time = 30
      }
  },
----------------------------------------
--------------------WEAPONS----------------
----------------------------------------
--------------------Stormbolter----------------
  {
      type = "technology",
      name = "stormbolter",
      icon = "__Wh40k_Armoury__/graphics/technology/stormbolter.png",
	  icon_size = 128,
      effects =
      {
        {
            type = "unlock-recipe",
            recipe = "stormbolter"
        },
      },
      prerequisites = {"basic-bolter"},
      unit =
      {
        count = 200,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"chemical-science-pack", 1},
		  {"military-science-pack", 1},
        },
        time = 30
      }
  },
--------------------Bolt Rifle----------------
  {
      type = "technology",
      name = "bolt_rifle",
      icon = "__Wh40k_Armoury__/graphics/technology/bolt_rifle.png",
	  icon_size = 128,
      effects =
      {
        {
            type = "unlock-recipe",
            recipe = "bolt_rifle"
        },
      },
      prerequisites = {"basic-bolter"},
      unit =
      {
        count = 200,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"chemical-science-pack", 1},
		  {"military-science-pack", 1},
        },
        time = 30
      }
  },
--------------------Assault Bolter----------------
  {
      type = "technology",
      name = "assault_bolter",
      icon = "__Wh40k_Armoury__/graphics/technology/assault_bolter.png",
	  icon_size = 128,
      effects =
      {
        {
            type = "unlock-recipe",
            recipe = "assault_bolter"
        },
      },
      prerequisites = {"basic-bolter"},
      unit =
      {
        count = 300,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"chemical-science-pack", 1},
		  {"military-science-pack", 1},
        },
        time = 30
      }
  },
----------------------------------------
--------------------AMMO----------------
----------------------------------------
--------------------Mk2-----------------
  {
      type = "technology",
      name = "bolt-mk2",
      icon = "__Wh40k_Armoury__/graphics/technology/bolt-mk2.png",
	  icon_size = 128,
      effects =
      {
		{type = "unlock-recipe", recipe = "bolt75mk2"},
		{type = "unlock-recipe", recipe = "bolt100mk2"},		

      },
      prerequisites = {"basic-bolter", "advanced-electronics-2"},
      unit =
      {
        count = 400,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"chemical-science-pack", 1},
		  {"military-science-pack", 1},
		  {"production-science-pack", 1},
        },
        time = 30
      }
  },
--------------------Metal Storm----------------
  {
      type = "technology",
      name = "bolt-metalstorm",
      icon = "__Wh40k_Armoury__/graphics/technology/bolt-metalstorm.png",
	  icon_size = 128,
      effects =
      {
		{type = "unlock-recipe", recipe = "bolt75metalstorm"},
		{type = "unlock-recipe", recipe = "bolt100metalstorm"},		

      },
      prerequisites = {"basic-bolter", "advanced-electronics-2"},
      unit =
      {
        count = 400,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"chemical-science-pack", 1},
		  {"military-science-pack", 1},
		  {"production-science-pack", 1},
        },
        time = 30
      }
  },
--------------------Kraken----------------
  {
      type = "technology",
      name = "bolt-kraken",
      icon = "__Wh40k_Armoury__/graphics/technology/bolt-kraken.png",
	  icon_size = 128,
      effects =
      {
		{type = "unlock-recipe", recipe = "bolt75kraken"},
		{type = "unlock-recipe", recipe = "bolt100kraken"},

      },
      prerequisites = {"bolt-mk2", "bolt-metalstorm"},
      unit =
      {
        count = 500,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"chemical-science-pack", 1},
		  {"military-science-pack", 1},
		  {"production-science-pack", 1},
        },
        time = 30
      }
  },
--------------------Hellfire----------------
  {
      type = "technology",
      name = "bolt-hellfire",
      icon = "__Wh40k_Armoury__/graphics/technology/bolt-hellfire.png",
	  icon_size = 128,
      effects =
      {
		{type = "unlock-recipe", recipe = "bolt75hellfire"},
		{type = "unlock-recipe", recipe = "bolt100hellfire"},

      },
      prerequisites = {"bolt-mk2", "bolt-metalstorm"},
      unit =
      {
        count = 500,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"chemical-science-pack", 1},
		  {"military-science-pack", 1},
		  {"production-science-pack", 1},
        },
        time = 30
      }
  },
--------------------Inferno----------------
  {
      type = "technology",
      name = "bolt-inferno",
      icon = "__Wh40k_Armoury__/graphics/technology/bolt-inferno.png",
	  icon_size = 128,
      effects =
      {
		{type = "unlock-recipe", recipe = "bolt75inferno"},
		{type = "unlock-recipe", recipe = "bolt100inferno"},

      },
      prerequisites = {"bolt-mk2", "bolt-metalstorm"},
      unit =
      {
        count = 500,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"chemical-science-pack", 1},
		  {"military-science-pack", 1},
		  {"production-science-pack", 1},
        },
        time = 30
      }
  },
----------------------------------------
--------------------UPGRADES----------------
----------------------------------------
--------------------Tips from refined local metals
  {
    type = "technology",
    name = "bolt-damage-A",
    icon = "__Wh40k_Armoury__/graphics/technology/bolt-damage-A.png",
    icon_size = 128,
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bolt75",
        modifier = "0.5"
      },
	  {
        type = "ammo-damage",
        ammo_category = "bolt100",
        modifier = "0.5"
      }
    },
    prerequisites = {"basic-bolter"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
		{"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"military-science-pack", 1},
		{"production-science-pack", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "e-z-a"
  },
--------------------Tips from synthesized Diamantine
  {
    type = "technology",
    name = "bolt-damage-B",
    icon = "__Wh40k_Armoury__/graphics/technology/bolt-damage-B.png",
    icon_size = 128,
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bolt75",
        modifier = "1.0"
      },
	  {
        type = "ammo-damage",
        ammo_category = "bolt100",
        modifier = "1.0"
      }
    },
    prerequisites = {"bolt-damage-A"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
		{"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"military-science-pack", 1},
		{"production-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "e-z-b"
  },
--------------------Tips from pure Adamantium
 {
    type = "technology",
    name = "bolt-damage-C",
    icon = "__Wh40k_Armoury__/graphics/technology/bolt-damage-C.png",
    icon_size = 128,
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bolt75",
        modifier = "1.5"
      },
	  {
        type = "ammo-damage",
        ammo_category = "bolt100",
        modifier = "1.5"
      }
    },
    prerequisites = {"bolt-damage-B"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
		{"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"military-science-pack", 1},
		{"production-science-pack", 1},
        {"utility-science-pack", 1},
		{"space-science-pack", 1}
	  },
      time = 30
    },
    upgrade = true,
    order = "e-z-c"
  },
--------------------Warp Burst Upgrade
 {
    type = "technology",
    name = "bolt-speed",
    icon = "__Wh40k_Armoury__/graphics/technology/bolt-speed.png",
    icon_size = 128,
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "bolt75",
        modifier = "1.0"
      },
	  {
        type = "gun-speed",
        ammo_category = "bolt100",
        modifier = "1.0"
      }
    },
    prerequisites = {"bolt-damage-C"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
		{"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"military-science-pack", 1},
		{"production-science-pack", 1},
        {"utility-science-pack", 1},
		{"space-science-pack", 1}
	  },
      time = 30
    },
    upgrade = true,
    order = "e-z-c"
  },  
})

