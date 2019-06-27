data:extend({
	{
		type = "technology",
		name = "orecompresstech",
		icon = "__OreCompress__/graphics/compress.png",
    icon_size = 64,
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "compress-iron-ore"
			},
      {
				type = "unlock-recipe",
				recipe = "uncompress-iron-ore"
			},
      {
				type = "unlock-recipe",
				recipe = "compress-copper-ore"
			},
      {
				type = "unlock-recipe",
				recipe = "uncompress-copper-ore"
			},
      {
				type = "unlock-recipe",
				recipe = "compress-uranium-ore"
			},
      {
				type = "unlock-recipe",
				recipe = "uncompress-uranium-ore"
			},
      {
				type = "unlock-recipe",
				recipe = "compress-coal"
			},
      {
				type = "unlock-recipe",
				recipe = "uncompress-coal"
			},
      {
				type = "unlock-recipe",
				recipe = "compress-stone"
			},
      {
				type = "unlock-recipe",
				recipe = "uncompress-stone"
			},
      -- Smelting recipes
      {
				type = "unlock-recipe",
				recipe = "smelt-compressed-iron-ore"
			},
      {
				type = "unlock-recipe",
				recipe = "smelt-compressed-copper-ore"
			},
      {
				type = "unlock-recipe",
				recipe = "smelt-compressed-stone"
			}
		},
		prerequisites = {"logistic-science-pack"},
		unit =
		{
			count = 200,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1}
			},
			time = 20
		}
	}
})
			