
--------------------------------------------------------------------------------
-- Damage reflect wall                                                        --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "damage-reflect-wall",
    --icon = "__Reinforced-wall__/graphics/icons/tech-tree2.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("stone-wall", nil, nil, require("prototypes/prototype-settings")["damage-reflect-wall"]["wall-tint"]),
    prerequisites = {"acid-resist-wall", "defender", "military-4"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "damage-reflect-wall"
      }
    },
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 60,
    },
    order = "a-k-c",
  },
}
