require "LSlib.lib"

--------------------------------------------------------------------------------
-- Reinforced gate                                                            --
--------------------------------------------------------------------------------
local reinforcedGate = util.table.deepcopy(data.raw["item"]["gate"])
reinforcedGate.name = "reinforced-gate"

reinforcedGate.icon      = nil
reinforcedGate.icon_size = nil
reinforcedGate.icons     = LSlib.item.getIcons("item", "gate", 1, {0,0}, require("prototypes/prototype-settings")[reinforcedGate.name]["wall-tint"])

reinforcedGate.order = reinforcedGate.order .. "-b[Reinforced-Walls]-a[" .. reinforcedGate.name .. "]"

reinforcedGate.place_result = reinforcedGate.name

data:extend{reinforcedGate}
