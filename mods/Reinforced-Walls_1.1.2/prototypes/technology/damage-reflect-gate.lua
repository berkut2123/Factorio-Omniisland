
--------------------------------------------------------------------------------
-- Damage reflect gate                                                       --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "damage-reflect-gate",
    --icon = "__Reinforced-wall__/graphics/icons/tech-tree2.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("gate", nil, nil, require("prototypes/prototype-settings")["damage-reflect-gate"]["wall-tint"]),
    prerequisites = {"acid-resist-gate", "damage-reflect-wall"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "damage-reflect-gate"
      }
    },
    unit  = data.raw["technology"]["damage-reflect-wall"].unit,
    order = data.raw["technology"]["damage-reflect-wall"].order,
  },
}
