local data_util = require("data_util")


data:extend{
  {
    name = data_util.mod_prefix.."thruster-suit",
    type = "armor",
    subgroup = "armor",
    equipment_grid = data_util.mod_prefix.."thruster-suit-grid",
    icon = "__space-exploration-graphics__/graphics/icons/thruster-suit-orange.png",
    icon_size = 64,
    infinite = true,
    inventory_size_bonus = 20,
    order = "t-a",
    resistances = {
      {
        percent = 30,
        type = "physical"
      },
      {
        decrease = 0,
        percent = 30,
        type = "acid"
      },
      {
        decrease = 0,
        percent = 30,
        type = "explosion"
      },
      {
        decrease = 0,
        percent = 60,
        type = "fire"
      }
    },
    stack_size = 1,
  },
  {
    equipment_categories = {
      "armor"
    },
    name = data_util.mod_prefix.."thruster-suit-grid",
    type = "equipment-grid",
    height = 8,
    width = 8
  },
  {
    name = data_util.mod_prefix.."thruster-suit-2",
    type = "armor",
    subgroup = "armor",
    equipment_grid = data_util.mod_prefix.."thruster-suit-2-grid",
    icon = "__space-exploration-graphics__/graphics/icons/thruster-suit-red.png",
    icon_size = 64,
    infinite = true,
    inventory_size_bonus = 40,
    order = "t-b",
    resistances = {
      {
        percent = 30,
        type = "physical"
      },
      {
        decrease = 0,
        percent = 30,
        type = "acid"
      },
      {
        decrease = 0,
        percent = 30,
        type = "explosion"
      },
      {
        decrease = 0,
        percent = 60,
        type = "fire"
      }
    },
    stack_size = 1,
  },
  {
    equipment_categories = {
      "armor"
    },
    name = data_util.mod_prefix.."thruster-suit-2-grid",
    type = "equipment-grid",
    height = 10,
    width = 10
  },
  {
    name = data_util.mod_prefix.."thruster-suit-3",
    type = "armor",
    subgroup = "armor",
    equipment_grid = data_util.mod_prefix.."thruster-suit-3-grid",
    icon = "__space-exploration-graphics__/graphics/icons/thruster-suit-blue.png",
    icon_size = 64,
    infinite = true,
    inventory_size_bonus = 50,
    order = "t-c",
    resistances = {
      {
        percent = 30,
        type = "physical"
      },
      {
        decrease = 0,
        percent = 30,
        type = "acid"
      },
      {
        decrease = 0,
        percent = 30,
        type = "explosion"
      },
      {
        decrease = 0,
        percent = 60,
        type = "fire"
      }
    },
    stack_size = 1,
  },
  {
    equipment_categories = {
      "armor"
    },
    name = data_util.mod_prefix.."thruster-suit-3-grid",
    type = "equipment-grid",
    height = 14,
    width = 12
  },
  {
    name = data_util.mod_prefix.."thruster-suit-4",
    type = "armor",
    subgroup = "armor",
    equipment_grid = data_util.mod_prefix.."thruster-suit-4-grid",
    icon = "__space-exploration-graphics__/graphics/icons/thruster-suit-black.png",
    icon_size = 64,
    infinite = true,
    inventory_size_bonus = 60,
    order = "t-d",
    resistances = {
      {
        percent = 30,
        type = "physical"
      },
      {
        decrease = 0,
        percent = 30,
        type = "acid"
      },
      {
        decrease = 0,
        percent = 30,
        type = "explosion"
      },
      {
        decrease = 0,
        percent = 60,
        type = "fire"
      }
    },
    stack_size = 1,
  },
  {
    equipment_categories = {
      "armor"
    },
    name = data_util.mod_prefix.."thruster-suit-4-grid",
    type = "equipment-grid",
    height = 16,
    width = 16
  },
}
data.raw["character-corpse"]["character-corpse"].armor_picture_mapping[ data_util.mod_prefix .. "thruster-suit"] = 3
data.raw["character-corpse"]["character-corpse"].armor_picture_mapping[ data_util.mod_prefix .. "thruster-suit-2"] = 3
data.raw["character-corpse"]["character-corpse"].armor_picture_mapping[ data_util.mod_prefix .. "thruster-suit-3"] = 3
data.raw["character-corpse"]["character-corpse"].armor_picture_mapping[ data_util.mod_prefix .. "thruster-suit-4"] = 3

for _, animation in pairs(data.raw.character.character.animations) do
  if animation.armors then
    for _, armor in pairs(animation.armors) do
      if armor == "power-armor" then
        table.insert(animation.armors,  data_util.mod_prefix .. "thruster-suit")
        table.insert(animation.armors,  data_util.mod_prefix .. "thruster-suit-2")
        table.insert(animation.armors,  data_util.mod_prefix .. "thruster-suit-3")
        table.insert(animation.armors,  data_util.mod_prefix .. "thruster-suit-4")
      end
    end
  end
end
