
--------------------------------------------------------------------------------
-- Reinforced wall                                                            --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "reinforced-walls",
    --icon = "__Reinforced-Walls__/graphics/icons/tech-tree.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("stone-walls", nil, nil, require("prototypes/prototype-settings")["reinforced-wall"]["wall-tint"]),
    prerequisites = {"stone-walls", "concrete", "military-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "reinforced-wall",
      }
    },
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 30,
    },
    order = "a-k-b",
  },
}
