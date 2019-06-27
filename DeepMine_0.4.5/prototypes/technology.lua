data:extend({
	{
		type = "technology",
		name = "deep-mine",
    icon = "__DeepMine__/graphics/icons/HR-deep-mine.png",
    icon_size = 128,
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "deep-mine"
			},
		},
		prerequisites = {"chemical-science-pack", "mining-productivity-1"},
		unit =
		{
			count = 100,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
			},
			time = 60
		},
		order = "a"
	},
  {
		type = "technology",
		name = "deep-mine-2",
    icon = "__DeepMine__/graphics/icons/HR-deep-mine-2.png",
    icon_size = 128,
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "deep-mine-2"
			},
		},
		prerequisites = {"production-science-pack", "deep-mine", "mining-productivity-2"},
		unit =
		{
			count = 200,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
        {"production-science-pack", 1},
			},
			time = 60
		},
		order = "a"
	},
})
