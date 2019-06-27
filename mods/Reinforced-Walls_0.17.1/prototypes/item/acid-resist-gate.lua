require "LSlib.lib"

--------------------------------------------------------------------------------
-- Acid resist gate                                                           --
--------------------------------------------------------------------------------
local acidResistGate = util.table.deepcopy(data.raw["item"]["gate"])
acidResistGate.name = "acid-resist-gate"

acidResistGate.icon      = nil
acidResistGate.icon_size = nil
acidResistGate.icons     = LSlib.item.getIcons("item", "gate", nil, nil, require("prototypes/prototype-settings")[acidResistGate.name]["wall-tint"])

acidResistGate.order = acidResistGate.order .. "-b[Reinforced-Walls]-b[" .. acidResistGate.name .. "]"

acidResistGate.place_result = acidResistGate.name

data:extend{acidResistGate}
