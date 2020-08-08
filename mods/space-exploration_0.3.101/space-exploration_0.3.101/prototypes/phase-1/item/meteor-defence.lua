local data_util = require("data_util")


data:extend({
  {
    type = "ammo-category",
    name = data_util.mod_prefix .. "meteor-point-defence",
    bonus_gui_order = "z-z",
  },
  {
    type = "ammo-category",
    name = data_util.mod_prefix .. "meteor-defence",
    bonus_gui_order = "z-z",
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "meteor-point-defence",
    icon = "__space-exploration-graphics__/graphics/icons/meteor-point-defence.png",
    icon_size = 64,
    order = "z[meteor-point-defence]-a[meteor-point-defence]",
    subgroup = "defensive-structure",
    stack_size = 50,
    place_result = data_util.mod_prefix .. "meteor-point-defence-container",
  },
  {
    type = "ammo",
    name = data_util.mod_prefix .. "meteor-point-defence-ammo",
    icon = "__space-exploration-graphics__/graphics/icons/meteor-point-defence-ammo.png",
    icon_size = 32,
    order = "z[meteor-point-defence]-b[meteor-point-defence-ammo]",
    subgroup = "defensive-structure",
    stack_size = 50,
    ammo_type =
    {
      category = data_util.mod_prefix .. "meteor-point-defence",
      target_type = "entity",
      action = {
        {
          type = "direct",
          action_delivery = {
            type = "instant",
            target_effects = {
              {
                damage = {
                  amount = 50,
                  type = "physical"
                },
                type = "damage"
              },
            }
          }
        },
      }
    },
    magazine_size = 1,
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "meteor-defence",
    icon = "__space-exploration-graphics__/graphics/icons/meteor-defence.png",
    icon_size = 64,
    order = "z[meteor-defence]-c[meteor-defence]",
    subgroup = "defensive-structure",
    stack_size = 1,
    place_result = data_util.mod_prefix .. "meteor-defence-container",
  },
  {
    type = "ammo",
    name = data_util.mod_prefix .. "meteor-defence-ammo",
    icon = "__space-exploration-graphics__/graphics/icons/meteor-defence-ammo.png",
    icon_size = 32,
    order = "z[meteor-defence]-d[meteor-defence-ammo]",
    subgroup = "defensive-structure",
    stack_size = 20,
    ammo_type =
    {
      category = data_util.mod_prefix .. "meteor-defence",
      target_type = "entity",
      action = {
        {
          type = "direct",
          action_delivery = {
            type = "instant",
            target_effects = {
              {
                damage = {
                  amount = 80,
                  type = "physical"
                },
                type = "damage"
              },
            }
          }
        },
      }
    },
    magazine_size = 1,
  },
})
