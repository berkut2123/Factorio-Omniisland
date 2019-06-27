require "LSlib.lib"

--------------------------------------------------------------------------------
-- Damage reflect gates                                                       --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "damage-reflect-gates",
    --icon = "__Reinforced-Walls__/graphics/icons/tech-tree2.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("gates", nil, nil, require("prototypes/prototype-settings")["damage-reflect-gate"]["wall-tint"]),
    prerequisites = {"acid-resist-gates", "damage-reflect-walls"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "damage-reflect-gate"
      }
    },
    unit  = data.raw["technology"]["damage-reflect-walls"].unit,
    order = data.raw["technology"]["damage-reflect-walls"].order,
  },
}
