--[[ Copyright (c) 2017 Optera
 * Part of Storage Tank mk2
 *
 * See LICENSE.md in the project directory for license information.
--]]

data:extend({
  {
    type = "technology",
    name = "adv-fluid-storage",
    icon = "__StorageTank2__/graphics/icon/storage-tank2.png",
    icon_size = 64,
    prerequisites = {"fluid-handling"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "storage-tank2"
      }
    },
    unit =
    {
      count = 200,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "d-a-a"
  }
})
