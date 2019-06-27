require "LSlib.lib"

--------------------------------------------------------------------------------
-- Reinforced wall                                                            --
--------------------------------------------------------------------------------
local reinforcedWall = util.table.deepcopy(data.raw["item"]["stone-wall"])
reinforcedWall.name = "reinforced-wall"

reinforcedWall.icon      = nil
reinforcedWall.icon_size = nil
reinforcedWall.icons     = LSlib.item.getIcons("item", "stone-wall", nil, nil, require("prototypes/prototype-settings")[reinforcedWall.name]["wall-tint"])

reinforcedWall.order = reinforcedWall.order .. "-b[Reinforced-Walls]-a[" .. reinforcedWall.name .. "]"

reinforcedWall.place_result = reinforcedWall.name

data:extend{reinforcedWall}
