if not bobmods then bobmods = {} end
if not bobmods.revamp then bobmods.revamp = {} end

require("prototypes.rocket-fuel")
require("prototypes.rocket-parts")


data:extend(
{
  {
    type = "technology",
    name = "pumpjack",
    icon = "__base__/graphics/technology/oil-gathering.png",
    icon_size = 128,
    order = "d-a-c",
    prerequisites =
    {
      "steel-processing",
    },
    unit =
    {
      count = 30,
      time = 30,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "pumpjack"
      },
    },
  },
  {
    type = "technology",
    name = "chemical-plant",
    icon = "__bobrevamp__/graphics/icons/technology/chemical-plant.png",
    icon_size = 128,
    order = "d-a-c",
    prerequisites =
    {
    },
    unit =
    {
      count = 30,
      time = 30,
      ingredients = 
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "chemical-plant"
      },
    },
  },
  {
    type = "technology",
    name = "solid-fuel",
    icon = "__base__/graphics/icons/solid-fuel.png",
    icon_size = 32,
    order = "d-a-d",
    prerequisites =
    {
      "chemical-plant",
    },
    unit =
    {
      count = 30,
      time = 30,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "solid-fuel-from-light-oil"
      },
      {
        type = "unlock-recipe",
        recipe = "solid-fuel-from-petroleum-gas"
      },
      {
        type = "unlock-recipe",
        recipe = "solid-fuel-from-heavy-oil"
      },
    },
  },
}
)



data:extend(
{
  {
    type = "recipe",
    name = "oil-processing-with-sulfur",
    category = "oil-processing",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type = "fluid", name = "crude-oil", amount = 100}
    },
    results =
    {
      {type = "fluid", name = "heavy-oil", amount = 25},
      {type = "fluid", name = "light-oil", amount = 25},
      {type = "fluid", name = "petroleum-gas", amount = 30},
      {type = "item", name = "sulfur", amount = 2}
    },
    icon = "__bobrevamp__/graphics/icons/oil-processing-with-sulfur.png",
    icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-d[oil-processing-with-sulfur]"
  },
}
)

if data.raw.fluid["sulfur-dioxide"] then
data:extend(
{
  {
    type = "recipe",
    name = "oil-processing-with-sulfur-dioxide",
    category = "oil-processing",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type = "fluid", name = "water", amount = 50},
      {type = "fluid", name = "crude-oil", amount = 100}
    },
    results =
    {
      {type = "fluid", name = "sulfur-dioxide", amount = 40},
      {type = "fluid", name = "light-oil", amount = 30},
      {type = "fluid", name = "petroleum-gas", amount = 40}
    },
    icon = "__bobrevamp__/graphics/icons/oil-processing-with-sulfur-dioxide-1.png",
    icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-e[oil-processing-with-sulfur-dioxide-1]"
  },

  {
    type = "recipe",
    name = "oil-processing-with-sulfur-dioxide-2",
    category = "oil-processing",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type = "fluid", name = "water", amount = 40},
      {type = "fluid", name = "crude-oil", amount = 100}
    },
    results =
    {
      {type = "fluid", name = "heavy-oil", amount = 30},
      {type = "fluid", name = "sulfur-dioxide", amount = 40},
      {type = "fluid", name = "petroleum-gas", amount = 40}
    },
    icon = "__bobrevamp__/graphics/icons/oil-processing-with-sulfur-dioxide-2.png",
    icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-e[oil-processing-with-sulfur-dioxide-2]"
  },

  {
    type = "recipe",
    name = "oil-processing-with-sulfur-dioxide-3",
    category = "oil-processing",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type = "fluid", name = "water", amount = 20},
      {type = "fluid", name = "crude-oil", amount = 100}
    },
    results =
    {
      {type = "fluid", name = "heavy-oil", amount = 30},
      {type = "fluid", name = "light-oil", amount = 30},
      {type = "fluid", name = "sulfur-dioxide", amount = 50}
    },
    icon = "__bobrevamp__/graphics/icons/oil-processing-with-sulfur-dioxide-3.png",
    icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-e[oil-processing-with-sulfur-dioxide-3]"
  },
}
)
end

