
--------------------------------------------------------------------------------
-- Damage reflect gate                                                        --
--------------------------------------------------------------------------------
local damageReflectGate = util.table.deepcopy(data.raw["gate"]["gate"])
damageReflectGate.name = "damage-reflect-gate"
damageReflectGate.minable.result = damageReflectGate.name

damageReflectGate.icon = data.raw["item"][damageReflectGate.minable.result].icon
damageReflectGate.icon_size = data.raw["item"][damageReflectGate.minable.result].icon_size
damageReflectGate.icons = util.table.deepcopy(data.raw["item"][damageReflectGate.minable.result].icons)

-- modifiers
local resistanceModifier = require("prototypes/prototype-settings")[damageReflectGate.name]["resistance-modifiers"]
damageReflectGate.max_health = damageReflectGate.max_health * (resistanceModifier["health"] or 1)
damageReflectGate.repair_speed_modifier = (damageReflectGate.repair_speed_modifier or 1)
                                     * ((resistanceModifier["repair_speed_modifier"] and resistanceModifier["repair_speed_modifier"].percent) or 1)
for i,resist in pairs(damageReflectGate.resistances) do
  resist.percent  = (resist.percent  or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].percent ) or 1)
  resist.decrease = (resist.decrease or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].decrease) or 0)
end
damageReflectGate.attack_reaction = resistanceModifier["attack_reaction"]

-- color
local tint = require("prototypes/prototype-settings")[damageReflectGate.name]["wall-tint"]
for _,animationName in pairs{
  "vertical_animation"             ,
  "horizontal_animation"           ,

  "vertical_rail_base"             ,
  --"vertical_rail_base_mask"        ,
  "horizontal_rail_base"           ,
  --"horizontal_rail_base_mask"      ,

  "horizontal_rail_animation_left" ,
  "horizontal_rail_animation_right",
  "vertical_rail_animation_left"   ,
  "vertical_rail_animation_right"  ,
} do
  damageReflectGate[animationName] = LSlib.entity.addTintToAnimation(damageReflectGate[animationName], tint)
end
for _,spriteName in pairs{
  "vertical_rail_base"  ,
  "horizontal_rail_base",
} do
  damageReflectGate[spriteName] = LSlib.entity.addTintToSprite(damageReflectGate[spriteName], tint)
end
for _,sprite4WayName in pairs{
  "wall_patch",
} do
  damageReflectGate[sprite4WayName] = LSlib.entity.addTintToSprite4Way(damageReflectGate[sprite4WayName], tint)
end

data:extend{damageReflectGate}
