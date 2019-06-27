require "LSlib.lib"

--------------------------------------------------------------------------------
-- Acid resist wall                                                           --
--------------------------------------------------------------------------------
local acidResistWall = util.table.deepcopy(data.raw["wall"]["stone-wall"])
acidResistWall.name = "acid-resist-wall"
acidResistWall.minable.result = acidResistWall.name

acidResistWall.icon = data.raw["item"][acidResistWall.minable.result].icon
acidResistWall.icon_size = data.raw["item"][acidResistWall.minable.result].icon_size
acidResistWall.icons = util.table.deepcopy(data.raw["item"][acidResistWall.minable.result].icons)

-- modifiers
local resistanceModifier = require("prototypes/prototype-settings")[acidResistWall.name]["resistance-modifiers"]
acidResistWall.max_health = acidResistWall.max_health * (resistanceModifier["health"] or 1)
acidResistWall.repair_speed_modifier = (acidResistWall.repair_speed_modifier or 1)
                                     * ((resistanceModifier["repair_speed_modifier"] and resistanceModifier["repair_speed_modifier"].percent) or 1)
for i,resist in pairs(acidResistWall.resistances) do
  resist.percent  = (resist.percent  or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].percent ) or 1)
  resist.decrease = (resist.decrease or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].decrease) or 0)
end
acidResistWall.attack_reaction = resistanceModifier["attack_reaction"]

-- color
local tint = require("prototypes/prototype-settings")[acidResistWall.name]["wall-tint"]
for pictureName,picture in pairs(acidResistWall.pictures) do
  -- https://wiki.factorio.com/Prototype/Wall#pictures
  if pictureName == "water_connection_patch" or pictureName == "gate_connection_patch" then
    acidResistWall.pictures[pictureName] = LSlib.entity.addTintToSprite4Way(picture, tint)
  else
    acidResistWall.pictures[pictureName] = LSlib.entity.addTintToSpriteVariation(picture, tint)
  end
end

data:extend{acidResistWall}
