if mods["angelsrefining"] then
	data:extend(
  {
    {
      type = "recipe",
      name = "water-mineralization",
      category = "liquifying",
      subgroup = "water-treatment",
      energy_required = 1,
      enabled = "false",
      ingredients =
      {
        {type = "fluid", name = "water-purified", amount = 100},
      },
      results =
      {
        {type = "fluid", name = "water-mineralized", amount = 100}
      },
      main_product = "water-mineralized",
      always_show_products = "true",
      order = "d[water-mineralization]"
    },
	{
      type = "technology",
      name = "water-treatment-2",
      icon = "__angelsrefining__/graphics/technology/water-treatment.png",
      icon_size = 128,
      prerequisites = {
        "water-treatment"
      },
      effects = {
		{
          type = "unlock-recipe",
          recipe = "hydro-plant-2"
        },
        {
          type = "unlock-recipe",
          recipe = "water-mineralization"
        },
        {
          type = "unlock-recipe",
          recipe = "yellow-waste-water-purification"
        },
        {
          type = "unlock-recipe",
          recipe = "greenyellow-waste-water-purification"
        },
        {
          type = "unlock-recipe",
          recipe = "green-waste-water-purification"
        },
        {
          type = "unlock-recipe",
          recipe = "red-waste-water-purification"
        },
      },
      unit = {
        count = 30,
        ingredients = {
          {"automation-science-pack", 1}
        },
        time = 15
      },
      order = "c-a"
    },
  }
)
end

if mods ["angelspetrochem"] then
data.raw.item["solid-sodium"].stack_size = 500
data.raw.item["solid-sodium-hydroxide"].stack_size = 500
end
