data:extend(
{
  {
    type = "recipe",
    name = "iron-smelting-hydroxide",
    category = "liquifying",
    subgroup = "angels-iron",
    energy_required = 4,
    enabled = "false",
    ingredients =
    {
      {type="item", name="pellet-iron", amount=2},
      {type="fluid", name="liquid-sulfuric-acid", amount=20},
    },
    results =
    {
      {type="item", name="solid-iron-hydroxide", amount=6},
    },
    icon_size = 32,
    order = "d[solid-iron-hydroxide]",
  },
  {
    type = "technology",
    name = "angels-iron-smelting-3",
    icon = "__angelssmelting__/graphics/technology/smelting-iron.png",
    icon_size = 128,
    upgrade = true,
    prerequisites =
    {
      "angels-iron-smelting-2",
      "ore-processing-2",
      "water-washing-2",
      "angels-coolant-1",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "iron-processed-processing"
      },
      {
        type = "unlock-recipe",
        recipe = "pellet-iron-smelting"
      },
      {
        type = "unlock-recipe",
        recipe = "iron-smelting-hydroxide"
      },
      {
        type = "unlock-recipe",
        recipe = "molten-iron-smelting-4"
      },
      {
        type = "unlock-recipe",
        recipe = "molten-iron-smelting-5"
      },
      {
        type = "unlock-recipe",
        recipe = "roll-iron-casting-fast"
      },
      {
        type = "unlock-recipe",
        recipe = "rod-stack-iron-casting-fast"
      },
    },
    unit =
    {
      count = 50,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "c-a"
  },
}
)