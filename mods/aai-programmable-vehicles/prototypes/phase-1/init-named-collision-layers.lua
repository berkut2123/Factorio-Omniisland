local collision_mask_util_extended = require("collision-mask-util-extended/data/collision-mask-util-extended")

local flying_layer = collision_mask_util_extended.get_make_named_collision_mask("flying-layer")

local projectile_layer = collision_mask_util_extended.get_make_named_collision_mask("projectile-layer")

local vehicle_layer = collision_mask_util_extended.get_make_named_collision_mask("vehicle-layer")

log("collision_mask: flying-layer = " .. flying_layer)

log("collision_mask: projectile-layer = " .. projectile_layer)

log("collision_mask: vehicle-layer = " .. vehicle_layer)
