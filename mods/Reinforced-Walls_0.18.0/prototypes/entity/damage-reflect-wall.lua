
--------------------------------------------------------------------------------
-- Damage reflect wall                                                        --
--------------------------------------------------------------------------------
local damageReflectWall = util.table.deepcopy(data.raw["wall"]["stone-wall"])
damageReflectWall.name = "damage-reflect-wall"
damageReflectWall.minable.result = damageReflectWall.name

damageReflectWall.icon = data.raw["item"][damageReflectWall.minable.result].icon
damageReflectWall.icon_size = data.raw["item"][damageReflectWall.minable.result].icon_size
damageReflectWall.icons = util.table.deepcopy(data.raw["item"][damageReflectWall.minable.result].icons)

-- modifiers
local resistanceModifier = require("prototypes/prototype-settings")[damageReflectWall.name]["resistance-modifiers"]
damageReflectWall.max_health = damageReflectWall.max_health * (resistanceModifier["health"] or 1)
damageReflectWall.repair_speed_modifier = (damageReflectWall.repair_speed_modifier or 1)
                                     * ((resistanceModifier["repair_speed_modifier"] and resistanceModifier["repair_speed_modifier"].percent) or 1)
for i,resist in pairs(damageReflectWall.resistances) do
  resist.percent  = (resist.percent  or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].percent ) or 1)
  resist.decrease = (resist.decrease or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].decrease) or 0)
end
damageReflectWall.attack_reaction = resistanceModifier["attack_reaction"]

-- color
local tint = require("prototypes/prototype-settings")[damageReflectWall.name]["wall-tint"]
for pictureName,picture in pairs(damageReflectWall.pictures) do
  -- https://wiki.factorio.com/Prototype/Wall#pictures
  if pictureName == "water_connection_patch" or pictureName == "gate_connection_patch" then
    damageReflectWall.pictures[pictureName] = LSlib.entity.addTintToSprite4Way(picture, tint)
  else
    damageReflectWall.pictures[pictureName] = LSlib.entity.addTintToSpriteVariation(picture, tint)
  end
end

data:extend{damageReflectWall}
