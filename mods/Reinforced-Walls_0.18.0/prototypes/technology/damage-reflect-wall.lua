
--------------------------------------------------------------------------------
-- Damage reflect wall                                                        --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "damage-reflect-walls",
    --icon = "__Reinforced-Walls__/graphics/icons/tech-tree2.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("stone-walls", nil, nil, require("prototypes/prototype-settings")["damage-reflect-wall"]["wall-tint"]),
    prerequisites = {"acid-resist-walls", "combat-robotics", "military-4"},
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
