require "LSlib.lib"

--------------------------------------------------------------------------------
-- Acid resist gates                                                          --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "acid-resist-gates",
    --icon = "__Reinforced-Walls__/graphics/icons/tech-tree1.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("gates", nil, nil, require("prototypes/prototype-settings")["acid-resist-gate"]["wall-tint"]),
    prerequisites = {"reinforced-gates", "acid-resist-walls"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "acid-resist-gate",
      },
    },
    unit  = data.raw["technology"]["acid-resist-walls"].unit,
    order = data.raw["technology"]["acid-resist-walls"].order,
  },
}
