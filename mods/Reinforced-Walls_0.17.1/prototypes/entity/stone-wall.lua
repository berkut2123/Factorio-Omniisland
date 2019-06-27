require "LSlib.lib"

--------------------------------------------------------------------------------
-- Stone wall                                                                 --
--------------------------------------------------------------------------------
local stoneWall = data.raw["wall"]["stone-wall"]

-- make sure it has icons, and not icon/icon_size
stoneWall.icons     = LSlib.item.getIcons(stoneWall.type, stoneWall.name)
stoneWall.icon      = nil
stoneWall.icon_size = nil

-- add new resistance types that do not appear in vanilla
for _,resistanceType in pairs{
  "physical" ,
  "impact"   ,
  "explosion",
  "fire"     ,
  "acid"     ,
  "laser"    ,
} do
  local alreadyPresent = false
  for _,resistance in pairs(stoneWall.resistances) do
    if resistance.type == resistanceType then
      alreadyPresent = true
    end
  end
  if not alreadyPresent then
    table.insert(stoneWall.resistances, {
      type     = resistanceType,
      decrease = 0             ,
      percent  = 0             ,
    })
  end
end
