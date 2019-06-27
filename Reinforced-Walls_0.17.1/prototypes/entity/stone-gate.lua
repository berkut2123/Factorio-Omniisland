require "LSlib.lib"

--------------------------------------------------------------------------------
-- Stone gate                                                                 --
--------------------------------------------------------------------------------
local stoneWall = data.raw["wall"]["stone-wall"]
local stoneGate = data.raw["gate"]["gate"]

-- make sure it has icons, and not icon/icon_size
stoneGate.icons     = LSlib.item.getIcons(stoneGate.type, stoneGate.name)
stoneGate.icon      = nil
stoneGate.icon_size = nil

-- add new resistance types that do not appear in vanilla (same as for the walls)
for _,resistanceType in pairs(stoneWall.resistances) do
  resistanceType = resistanceType.type or ""
  local alreadyPresent = false
  for _,resistance in pairs(stoneGate.resistances) do
    if resistance.type == resistanceType then
      alreadyPresent = true
    end
  end
  if not alreadyPresent then
    table.insert(stoneGate.resistances, {
      type     = resistanceType,
      decrease = 0             ,
      percent  = 0             ,
    })
  end
end
