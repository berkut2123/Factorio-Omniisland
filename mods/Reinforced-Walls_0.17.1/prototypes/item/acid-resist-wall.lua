require "LSlib.lib"

--------------------------------------------------------------------------------
-- Acid resist wall                                                           --
--------------------------------------------------------------------------------
local acidResistWall = util.table.deepcopy(data.raw["item"]["stone-wall"])
acidResistWall.name = "acid-resist-wall"

acidResistWall.icon      = nil
acidResistWall.icon_size = nil
acidResistWall.icons     = LSlib.item.getIcons("item", "stone-wall", nil, nil, require("prototypes/prototype-settings")[acidResistWall.name]["wall-tint"])

acidResistWall.order = acidResistWall.order .. "-b[Reinforced-Walls]-b[" .. acidResistWall.name .. "]"

acidResistWall.place_result = acidResistWall.name

data:extend{acidResistWall}
