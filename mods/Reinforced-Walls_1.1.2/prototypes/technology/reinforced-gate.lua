
--------------------------------------------------------------------------------
-- Reinforced wall                                                            --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "reinforced-gate",
    --icon = "__Reinforced-wall__/graphics/icons/tech-tree.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("gate", nil, nil, require("prototypes/prototype-settings")["reinforced-gate"]["wall-tint"]),
    prerequisites = {"gate", "reinforced-wall"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "reinforced-gate",
      }
    },
    unit  = data.raw["technology"]["reinforced-wall"].unit,
    order = data.raw["technology"]["reinforced-wall"].order,
  },
}
