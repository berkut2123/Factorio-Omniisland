data:extend(
  {
    {
      type = "module",
      name = "rich-productivity-module-1",
      -- localised_description = {"item-description.productivity-module"},
      icon = "__EAB__/graphics/icons/rich-productivity-module-1.png",
      icon_size = 32,
      subgroup = "rich-productivity-modules",
      category = "productivity",
      tier = 1,
      order = "a",
      stack_size = 50,
      default_request_amount = 10,
      effect = {
        productivity = {bonus = 0.6}, -- +0.2
        consumption = {bonus = 2.64}, -- +1.8
        pollution = {bonus = 2.84} -- +1.64
      }
      -- limitation = productivitymodulelimitation(),
      -- limitation_message_key = "production-module-usable-only-on-intermediates"
    },
    {
      type = "module",
      name = "rich-productivity-module-2",
      -- localised_description = {"item-description.productivity-module"},
      icon = "__EAB__/graphics/icons/rich-productivity-module-2.png",
      icon_size = 32,
      subgroup = "rich-productivity-modules",
      category = "productivity",
      tier = 1,
      order = "a",
      stack_size = 50,
      default_request_amount = 10,
      effect = {
        productivity = {bonus = 0.8}, -- +0.2
        consumption = {bonus = 3.04}, -- +0.8
        pollution = {bonus = 3.48} -- +0.64
      }
      -- limitation = productivitymodulelimitation(),
      -- limitation_message_key = "production-module-usable-only-on-intermediates"
    },
    {
      type = "module",
      name = "rich-productivity-module-3",
      -- localised_description = {"item-description.productivity-module"},
      icon = "__EAB__/graphics/icons/rich-productivity-module-3.png",
      icon_size = 32,
      subgroup = "rich-productivity-modules",
      category = "productivity",
      tier = 1,
      order = "a",
      stack_size = 50,
      default_request_amount = 10,
      effect = {
        productivity = {bonus = 1}, -- +0.2
        consumption = {bonus = 3.44}, -- +0.8
        pollution = {bonus = 4.12} -- +0.64
      }
      -- limitation = productivitymodulelimitation(),
      -- limitation_message_key = "production-module-usable-only-on-intermediates"
    }
  }
)
