local data_util = require("data_util")

data.raw.gun.railgun.flags = nil -- remove hidden
data.raw.gun.railgun.attack_parameters.range = 100
data.raw.gun.railgun.attack_parameters.cooldown = 150
data.raw.gun.railgun.attack_parameters.movement_slow_down_factor = 0.4
data.raw.ammo["railgun-dart"].flags = nil -- remove hidden
data.raw.ammo["railgun-dart"].ammo_type.action.range = 100
data.raw.ammo["railgun-dart"].ammo_type.action.action_delivery.target_effects.damage.amount = 250
