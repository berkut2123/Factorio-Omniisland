
--------------------------------------------------------------------------------
-- Reinforced wall                                                            --
--------------------------------------------------------------------------------
local reinforcedWall = util.table.deepcopy(data.raw["wall"]["stone-wall"])
reinforcedWall.name = "reinforced-wall"
reinforcedWall.minable.result = reinforcedWall.name

reinforcedWall.icon = data.raw["item"][reinforcedWall.minable.result].icon
reinforcedWall.icon_size = data.raw["item"][reinforcedWall.minable.result].icon_size
reinforcedWall.icons = util.table.deepcopy(data.raw["item"][reinforcedWall.minable.result].icons)

-- modifiers
local resistanceModifier = require("prototypes/prototype-settings")[reinforcedWall.name]["resistance-modifiers"]
reinforcedWall.max_health = reinforcedWall.max_health * (resistanceModifier["health"] or 1)
reinforcedWall.repair_speed_modifier = (reinforcedWall.repair_speed_modifier or 1)
                                     * ((resistanceModifier["repair_speed_modifier"] and resistanceModifier["repair_speed_modifier"].percent) or 1)
for i,resist in pairs(reinforcedWall.resistances) do
  resist.percent  = (resist.percent  or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].percent ) or 1)
  resist.decrease = (resist.decrease or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].decrease) or 0)
end
reinforcedWall.attack_reaction = resistanceModifier["attack_reaction"]

-- color
local tint = require("prototypes/prototype-settings")[reinforcedWall.name]["wall-tint"]
for pictureName,picture in pairs(reinforcedWall.pictures) do
  -- https://wiki.factorio.com/Prototype/Wall#pictures
  if pictureName == "water_connection_patch" or pictureName == "gate_connection_patch" then
    reinforcedWall.pictures[pictureName] = LSlib.entity.addTintToSprite4Way(picture, tint)
  else
    reinforcedWall.pictures[pictureName] = LSlib.entity.addTintToSpriteVariation(picture, tint)
  end
end

data:extend{reinforcedWall}
