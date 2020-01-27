
--------------------------------------------------------------------------------
-- Reinforced wall                                                            --
--------------------------------------------------------------------------------
data:extend{
  {
    type = "technology",
    name = "reinforced-gates",
    --icon = "__Reinforced-Walls__/graphics/icons/tech-tree.png",
    --icon_size = 128,
    icons = LSlib.technology.getIcons("gates", nil, nil, require("prototypes/prototype-settings")["reinforced-gate"]["wall-tint"]),
    prerequisites = {"gates", "reinforced-walls"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "reinforced-gate",
      }
    },
    unit  = data.raw["technology"]["reinforced-walls"].unit,
    order = data.raw["technology"]["reinforced-walls"].order,
  },
}
