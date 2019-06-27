require "LSlib.lib"

--------------------------------------------------------------------------------
-- Acid resist wall                                                           --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "acid-resist-walls",
    --icon = "__Reinforced-Walls__/graphics/icons/tech-tree1.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("stone-walls", nil, nil, require("prototypes/prototype-settings")["acid-resist-wall"]["wall-tint"]),
    prerequisites = {"reinforced-walls", "plastics", "military-3"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "acid-resist-wall",
      },
    },
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 45,
    },
    order = "a-k-c",
  },
}
