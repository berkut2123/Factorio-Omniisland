
--------------------------------------------------------------------------------
-- Acid resist wall                                                           --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "acid-resist-wall",
    --icon = "__Reinforced-wall__/graphics/icons/tech-tree1.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("stone-wall", nil, nil, require("prototypes/prototype-settings")["acid-resist-wall"]["wall-tint"]),
    prerequisites = {"reinforced-wall", "plastics", "military-3"},
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
