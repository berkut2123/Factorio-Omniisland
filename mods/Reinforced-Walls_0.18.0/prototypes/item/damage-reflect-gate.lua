
--------------------------------------------------------------------------------
-- Damage reflect gate                                                        --
--------------------------------------------------------------------------------
local damageReflectGate = util.table.deepcopy(data.raw["item"]["gate"])
damageReflectGate.name = "damage-reflect-gate"

damageReflectGate.icon      = nil
damageReflectGate.icon_size = nil
damageReflectGate.icons     = LSlib.item.getIcons("item", "gate", nil, nil, require("prototypes/prototype-settings")[damageReflectGate.name]["wall-tint"])

damageReflectGate.order = damageReflectGate.order .. "-b[Reinforced-Walls]-c[" .. damageReflectGate.name .. "]"

damageReflectGate.place_result = damageReflectGate.name

data:extend{damageReflectGate}
