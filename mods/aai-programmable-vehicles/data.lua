if not logged_mods_once then logged_mods_once = true log("Log mods once: "..serpent.block(mods)) end
local data_util = require("data-util")
collision_mask_util_extended = require("collision-mask-util-extended/data/collision-mask-util-extended")
require("prototypes/phase-1/init-named-collision-layers")

aai_vehicles = true

require("prototypes/input")
require("prototypes/shortcut")
require("prototypes/styles")
require("prototypes/animation")
require("prototypes/technology/technology")
require("prototypes/entity/entity")
require("prototypes/entity/entity-structures")
require("prototypes/entity/entity-deployer")
require("prototypes/entity/entity-depot")
require("prototypes/entity/entity-position-beacon")
require("prototypes/entity/projectiles")
require("prototypes/entity/entity-indicator")
require("prototypes/item-groups")
require("prototypes/item/item")
require("prototypes/item/ammo")
require("prototypes/recipe/recipe")
require("prototypes/recipe/ammo")
require("prototypes/sprites")
require("prototypes/signal")

aai_vehicle_exclusions = {"logicart", "nixie-tube"}

if settings.startup["exclude-vehicles"] and settings.startup["exclude-vehicles"].value then
  local vehicles_string = settings.startup["exclude-vehicles"].value
  local vehicle_words = data_util.just_words(vehicles_string)
  if vehicle_words then
    for _, vehicle in pairs(vehicle_words) do
      table.insert(aai_vehicle_exclusions, vehicle)
      log("Exclude vehicle name: " .. vehicle)
    end
  end
end
