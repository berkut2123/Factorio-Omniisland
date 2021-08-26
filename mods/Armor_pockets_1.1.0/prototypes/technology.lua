data:extend({
    {
      type = "technology",
      name = "armor-pocket-equipment",
      icon = "__Armor_pockets__/graphics/icons/armor-pocket-technology.png",
      icon_size = 128,
      prerequisites = {"modular-armor"},
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "armor-pocket-equipment"
        }
      },
      unit =
      {
        count = 100,
        ingredients = 
		  {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
			      --{ "military-science-pack", 1 },
          },
        time = 15
      },
      order = "g-g"
    }
})