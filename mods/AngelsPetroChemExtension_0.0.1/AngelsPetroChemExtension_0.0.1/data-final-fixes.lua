if mods["angelsrefining"] then
	data:extend(
  {
    {
    type = "recipe",
    name = "gas-acid-sulfur-dioxide",
    category = "chemistry",
    subgroup = "petrochem-sulfur",
    energy_required = 2,
    enabled = "false",
    ingredients =
    {
      {type="fluid", name="gas-acid", amount=100},
    },
    results=
    {
      {type="fluid", name="gas-sulfur-dioxide", amount=100},
    },
    always_show_products = "true",
    icons = angelsmods.functions.create_gas_recipe_icon({
      { "__angelspetrochem__/graphics/icons/molecules/sulfur-dioxide.png", 72 },
    }, "soo"),
    order = "cc[gas-acid-sulfur-dioxide]",
    },
	
	{
    type = "recipe",
    name = "gas-acid-sulfur-dioxide-sulfur",
    category = "chemistry",
    subgroup = "petrochem-sulfur",
    energy_required = 2,
    enabled = "false",
    ingredients =
    {
      {type="fluid", name="gas-acid", amount=60},
	  {type="fluid", name="gas-sulfur-dioxide", amount=30},
    },
    results=
    {
      {type="item", name="sulfur", amount=3},
    },
    always_show_products = "true",
    icons = angelsmods.functions.create_gas_recipe_icon({
      { "__angelspetrochem__/graphics/icons/solid-sulfur.png", 32 },
    }, "sss"),
    order = "c[gas-acid-sulfur-dioxide-sulfur]",
    },
	
	{
    type = "technology",
    name = "angels-sulfur-processing-3",
    icon = "__angelspetrochem__/graphics/technology/sulfur-tech.png",
    icon_size = 128,
    prerequisites = {
      "angels-sulfur-processing-2",
      "angels-nitrogen-processing-2"
    },
    effects = {
	{
        type = "unlock-recipe",
        recipe = "gas-acid-sulfur-dioxide"
      },
	  {
        type = "unlock-recipe",
        recipe = "gas-acid-sulfur-dioxide-sulfur"
      },
      {
        type = "unlock-recipe",
        recipe = "filter-lime"
      },
      {
        type = "unlock-recipe",
        recipe = "filter-lime-used"
      },
      {
        type = "unlock-recipe",
        recipe = "angels-sulfur-scrubber"
      }
    },
    unit = {
      count = 50,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 15
    },
    order = "c-a"
    },
  }
)
end