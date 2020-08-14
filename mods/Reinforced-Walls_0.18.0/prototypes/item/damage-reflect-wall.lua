
--------------------------------------------------------------------------------
-- Damage reflect wall                                                        --
--------------------------------------------------------------------------------
local damageReflectWall = util.table.deepcopy(data.raw["item"]["stone-wall"])
damageReflectWall.name = "damage-reflect-wall"

damageReflectWall.icon      = nil
damageReflectWall.icon_size = nil
damageReflectWall.icons     = LSlib.item.getIcons("item", "stone-wall", nil, nil, require("prototypes/prototype-settings")[damageReflectWall.name]["wall-tint"])

damageReflectWall.order = damageReflectWall.order .. "-b[Reinforced-Walls]-c[" .. damageReflectWall.name .. "]"

damageReflectWall.place_result = damageReflectWall.name

data:extend{damageReflectWall}
