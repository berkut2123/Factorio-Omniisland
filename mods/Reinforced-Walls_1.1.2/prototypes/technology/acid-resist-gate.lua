
--------------------------------------------------------------------------------
-- Acid resist gate                                                          --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "acid-resist-gate",
    --icon = "__Reinforced-wall__/graphics/icons/tech-tree1.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("gate", nil, nil, require("prototypes/prototype-settings")["acid-resist-gate"]["wall-tint"]),
    prerequisites = {"reinforced-gate", "acid-resist-wall"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "acid-resist-gate",
      },
    },
    unit  = data.raw["technology"]["acid-resist-wall"].unit,
    order = data.raw["technology"]["acid-resist-wall"].order,
  },
}
