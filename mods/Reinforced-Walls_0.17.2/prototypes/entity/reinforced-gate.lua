
--------------------------------------------------------------------------------
-- Reinforced gate                                                            --
--------------------------------------------------------------------------------
local reinforcedGate = util.table.deepcopy(data.raw["gate"]["gate"])
reinforcedGate.name = "reinforced-gate"
reinforcedGate.minable.result = reinforcedGate.name

reinforcedGate.icon = data.raw["item"][reinforcedGate.minable.result].icon
reinforcedGate.icon_size = data.raw["item"][reinforcedGate.minable.result].icon_size
reinforcedGate.icons = util.table.deepcopy(data.raw["item"][reinforcedGate.minable.result].icons)

-- modifiers
local resistanceModifier = require("prototypes/prototype-settings")[reinforcedGate.name]["resistance-modifiers"]
reinforcedGate.max_health = reinforcedGate.max_health * (resistanceModifier["health"] or 1)
reinforcedGate.repair_speed_modifier = (reinforcedGate.repair_speed_modifier or 1)
                                     * ((resistanceModifier["repair_speed_modifier"] and resistanceModifier["repair_speed_modifier"].percent) or 1)
for i,resist in pairs(reinforcedGate.resistances) do
  resist.percent  = (resist.percent  or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].percent ) or 1)
  resist.decrease = (resist.decrease or 0)
                  + ((resistanceModifier[resist["type"]] and resistanceModifier[resist["type"]].decrease) or 0)
end
reinforcedGate.attack_reaction = resistanceModifier["attack_reaction"]

-- color
local tint = require("prototypes/prototype-settings")[reinforcedGate.name]["wall-tint"]
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
  reinforcedGate[animationName] = LSlib.entity.addTintToAnimation(reinforcedGate[animationName], tint)
end
for _,spriteName in pairs{
  "vertical_rail_base"  ,
  "horizontal_rail_base",
} do
  reinforcedGate[spriteName] = LSlib.entity.addTintToSprite(reinforcedGate[spriteName], tint)
end
for _,sprite4WayName in pairs{
  "wall_patch",
} do
  reinforcedGate[sprite4WayName] = LSlib.entity.addTintToSprite4Way(reinforcedGate[sprite4WayName], tint)
end

data:extend{reinforcedGate}
