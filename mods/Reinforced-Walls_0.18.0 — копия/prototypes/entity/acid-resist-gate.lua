
--------------------------------------------------------------------------------
-- Acid resist gate                                                           --
--------------------------------------------------------------------------------
local acidResistGate = util.table.deepcopy(data.raw["gate"]["gate"])
acidResistGate.name = "acid-resist-gate"
acidResistGate.minable.result = acidResistGate.name

acidResistGate.icon = data.raw["item"][acidResistGate.minable.result].icon
acidResistGate.icon_size = data.raw["item"][acidResistGate.minable.result].icon_size
acidResistGate.icons = util.table.deepcopy(data.raw["item"][acidResistGate.minable.result].icons)

-- modifiers
local resistanceModifier = require("prototypes/prototype-settings")[acidResistGate.name]["resistance-modifiers"]
acidResistGate.max_health = acidResistGate.max_health * (resistanceModifier["health"] or 1)
acidResistGate.repair_speed_modifier = (acidResistGate.repair_speed_modifier or 1)
                                     * ((resistanceModifier["repair_speed_modifier"] and resistanceModifier["repair_speed_modifier"].percent) or 1)
for i,resist in pairs(acidResistGate.resistances) do
  resist.percent  = (resist.percent  or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].percent ) or 1)
  resist.decrease = (resist.decrease or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].decrease) or 0)
end
acidResistGate.attack_reaction = resistanceModifier["attack_reaction"]

-- color
local tint = require("prototypes/prototype-settings")[acidResistGate.name]["wall-tint"]
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
  acidResistGate[animationName] = LSlib.entity.addTintToAnimation(acidResistGate[animationName], tint)
end
for _,spriteName in pairs{
  "vertical_rail_base"  ,
  "horizontal_rail_base",
} do
  acidResistGate[spriteName] = LSlib.entity.addTintToSprite(acidResistGate[spriteName], tint)
end
for _,sprite4WayName in pairs{
  "wall_patch",
} do
  acidResistGate[sprite4WayName] = LSlib.entity.addTintToSprite4Way(acidResistGate[sprite4WayName], tint)
end

data:extend{acidResistGate}
