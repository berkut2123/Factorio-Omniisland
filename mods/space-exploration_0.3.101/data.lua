is_debug_mode = false
debug_log = is_debug_mode and log or function()end
space_collision_layer = "layer-14"
spaceship_collision_layer = "layer-15"
rocket_capacity = 500
local min_postprocess_version = "0.3.20"
local data_util = require("data_util")
if not logged_mods_once then logged_mods_once = true log("Log mods once: "..serpent.block(mods)) end
--log(serpent.block( mods, {comment = false, numformat = '%1.8g' } ))

-- SURFACE RESOURCE VALUES -------------------------------------------------------------
se_resources = se_resources or {}
se_resources["iron-ore"] = se_resources["iron-ore"] or {  order = "c-a", base_density = 14, starting_rq_factor_multiplier = 1.5}
se_resources["copper-ore"] = se_resources["copper-ore"] or {order = "c-b", base_density = 12, starting_rq_factor_multiplier = 1.5}
se_resources["stone"] = se_resources["stone"] or {order = "c-c", base_density = 12, starting_rq_factor_multiplier = 1.5}
se_resources["coal"] = se_resources["coal"] or {order = "c-e", base_density = 9, starting_rq_factor_multiplier = 1.5,}
se_resources["uranium-ore"] = se_resources["uranium-ore"] or {
  order = "c-d",
  has_starting_area_placement = false,
  base_density = 1,
  base_spots_per_km2 = 2,
  random_spot_size_minimum = 2,
  random_spot_size_maximum = 4,
}
se_resources["crude-oil"] = se_resources["crude-oil"] or {
  order = "e-a",
  has_starting_area_placement = false,
  base_density = 8,
  base_spots_per_km2 = 2,
  random_probability = 1/48,
  random_spot_size_minimum = 1,
  random_spot_size_maximum = 1, -- don't randomize spot size
  additional_richness = 220000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
  regular_rq_factor_multiplier = 1,
  starting_rq_factor_multiplier = 1.5,
}
se_resources[data_util.mod_prefix.."vulcanite"] = se_resources[data_util.mod_prefix.."vulcanite"] or { order = "b-v", base_density = 10, base_spots_per_km2 = 5 }
se_resources[data_util.mod_prefix.."cryonite"] = se_resources[data_util.mod_prefix.."cryonite"] or { order = "b-c", base_density = 10, base_spots_per_km2 = 5 }
se_resources[data_util.mod_prefix.."vitamelange"] = se_resources[data_util.mod_prefix.."vitamelange"] or { order = "a-a", base_density = 10 }
se_resources[data_util.mod_prefix.."iridium-ore"] = se_resources[data_util.mod_prefix.."iridium-ore"] or { order = "a-b" }
se_resources[data_util.mod_prefix.."holmium-ore"] = se_resources[data_util.mod_prefix.."holmium-ore"] or { order = "a-b" }
se_resources[data_util.mod_prefix.."beryllium-ore"] = se_resources[data_util.mod_prefix.."beryllium-ore"] or { order = "a-b" }
se_resources[data_util.mod_prefix.."naquium-ore"] = se_resources[data_util.mod_prefix.."naquium-ore"] or { order = "a-a", base_density = 1 }
se_resources[data_util.mod_prefix.."water-ice"] = se_resources[data_util.mod_prefix.."water-ice"] or { order = "f-a" }
se_resources[data_util.mod_prefix.."methane-ice"] = se_resources[data_util.mod_prefix.."methane-ice"] or { order = "f-b" }

-- CORE FRAGMENT RESOURCE VALUES -------------------------------------------------------------
-- allows other mods to alter core fragment resources
se_core_fragment_resources = se_core_fragment_resources or {}
se_core_fragment_resources["water"] = se_core_fragment_resources["water"] or { multiplier = 0, omni_multiplier = 0.1}
se_core_fragment_resources["crude-oil"] = se_core_fragment_resources["crude-oil"] or { multiplier = 1, omni_multiplier = 0.1}
se_core_fragment_resources["stone"] = se_core_fragment_resources["stone"] or { multiplier = 1, omni_multiplier = 1}
se_core_fragment_resources["iron-ore"] = se_core_fragment_resources["iron-ore"] or { multiplier = 1.2, omni_multiplier = 1.2}
se_core_fragment_resources["copper-ore"] = se_core_fragment_resources["copper-ore"] or { multiplier = 1, omni_multiplier = 1}
se_core_fragment_resources["coal"] = se_core_fragment_resources["coal"] or { multiplier = 1, omni_multiplier = 0.5}
se_core_fragment_resources["uranium-ore"] = se_core_fragment_resources["uranium-ore"] or { multiplier = 0.2, omni_multiplier = 0.01}

-- Depreciated, don't do this. Add se_allow_in_space =true to the prototype directly instead. --------------------------------------------------------------
se_allow_in_space = se_allow_in_space or {}
se_allow_in_space[data_util.mod_prefix.."lifesupport-facility"] = true
se_allow_in_space[data_util.mod_prefix.."recycling-facility"] = true
se_allow_in_space[data_util.mod_prefix.."delivery-cannon"] = true

-- EXCLUDE FROM PROCEDURAL TECHNOLOGY INGREDIENT FUNCTIONS ---------------------
-- These techs won't have science packs dynamically added.
-- If additional technologies are specified your mod should add the appropriate specialist science packs for that stage of the game
se_prodecural_tech_exclusions = se_prodecural_tech_exclusions or {}
table.insert(se_prodecural_tech_exclusions, "productivity-module")
table.insert(se_prodecural_tech_exclusions, "speed-module")
table.insert(se_prodecural_tech_exclusions, "effectivity-module")
table.insert(se_prodecural_tech_exclusions, "nano-speed")
table.insert(se_prodecural_tech_exclusions, "nano-range")
table.insert(se_prodecural_tech_exclusions, "mining-productivity")

-- DELIVERY CANNON: Should ONLY deliver homogenous resources, nothing manufactured.
-- defaults to stack size for items
se_delivery_cannon_recipes = se_delivery_cannon_stacks_recipes or {}
se_delivery_cannon_recipes["water"] = {name="water-barrel"}
se_delivery_cannon_recipes["crude-oil"] = {name="crude-oil-barrel"}
se_delivery_cannon_recipes["heavy-oil"] = {name="heavy-oil-barrel"}
se_delivery_cannon_recipes["light-oil"] = {name="light-oil-barrel"}
se_delivery_cannon_recipes["petroleum-gas"] = {name="petroleum-gas-barrel"}
se_delivery_cannon_recipes["lubricant"] = {name="lubricant-barrel"}
se_delivery_cannon_recipes["sulfuric-acid"] = {name="sulfuric-acid-barrel"}

se_delivery_cannon_recipes["iron-ore"] = {name="iron-ore"}
se_delivery_cannon_recipes["iron-plate"] = {name="iron-plate"}
se_delivery_cannon_recipes["copper-ore"] = {name="copper-ore"}
se_delivery_cannon_recipes["copper-plate"] = {name="copper-plate"}
se_delivery_cannon_recipes["uranium-ore"] = {name="uranium-ore"}
se_delivery_cannon_recipes["uranium-238"] = {name="uranium-238"}
se_delivery_cannon_recipes["uranium-235"] = {name="uranium-235"}
se_delivery_cannon_recipes["steel-plate"] = {name="steel-plate"}
se_delivery_cannon_recipes["stone"] = {name="stone"}
se_delivery_cannon_recipes["stone-brick"] = {name="stone-brick"}
se_delivery_cannon_recipes["coal"] = {name="coal"}
se_delivery_cannon_recipes["concrete"] = {name="concrete"}
se_delivery_cannon_recipes["plastic-bar"] = {name="plastic-bar"}
se_delivery_cannon_recipes["sulfur"] = {name="sulfur"}
se_delivery_cannon_recipes["wood"] = {name="wood"}
se_delivery_cannon_recipes["fish"] = {name="fish"}
se_delivery_cannon_recipes["rocket-fuel"] = {name="rocket-fuel"}
se_delivery_cannon_recipes["solid-fuel"] = {name="solid-fuel"}
se_delivery_cannon_recipes["processed-fuel"] = {name="processed-fuel"}
se_delivery_cannon_recipes["sand"] = {name="sand"}
se_delivery_cannon_recipes["glass"] = {name="glass"}
se_delivery_cannon_recipes["explosives"] = {name="explosives"}
se_delivery_cannon_recipes["low-density-structure"] = {name="low-density-structure"}
se_delivery_cannon_recipes[data_util.mod_prefix.."heat-shielding"] = {name=data_util.mod_prefix.."heat-shielding"}
se_delivery_cannon_recipes[data_util.mod_prefix.."scrap"] = {name=data_util.mod_prefix.."scrap"}
se_delivery_cannon_recipes[data_util.mod_prefix.."contaminated-scrap"] = {name=data_util.mod_prefix.."contaminated-scrap"}

se_delivery_cannon_recipes[data_util.mod_prefix.."water-ice"] = {name=data_util.mod_prefix.."water-ice"}
se_delivery_cannon_recipes[data_util.mod_prefix.."methane-ice"] = {name=data_util.mod_prefix.."methane-ice"}
se_delivery_cannon_recipes[data_util.mod_prefix.."beryllium-ore"] = {name=data_util.mod_prefix.."beryllium-ore"}
se_delivery_cannon_recipes[data_util.mod_prefix.."beryllium-ingot"] = {name=data_util.mod_prefix.."beryllium-ingot"}
se_delivery_cannon_recipes[data_util.mod_prefix.."iridium-ore"] = {name=data_util.mod_prefix.."iridium-ore"}
se_delivery_cannon_recipes[data_util.mod_prefix.."iridium-ingot"] = {name=data_util.mod_prefix.."iridium-ingot"}
se_delivery_cannon_recipes[data_util.mod_prefix.."holmium-ore"] = {name=data_util.mod_prefix.."holmium-ore"}
se_delivery_cannon_recipes[data_util.mod_prefix.."holmium-ingot"] = {name=data_util.mod_prefix.."holmium-ingot"}
se_delivery_cannon_recipes[data_util.mod_prefix.."naquium-ore"] = {name=data_util.mod_prefix.."naquium-ore"}
se_delivery_cannon_recipes[data_util.mod_prefix.."naquium-ingot"] = {name=data_util.mod_prefix.."naquium-ingot"}
se_delivery_cannon_recipes[data_util.mod_prefix.."vitamelange"] = {name=data_util.mod_prefix.."vitamelange"}
se_delivery_cannon_recipes[data_util.mod_prefix.."vitamelange-spice"] = {name=data_util.mod_prefix.."vitamelange-spice"}
se_delivery_cannon_recipes[data_util.mod_prefix.."cryonite"] = {name=data_util.mod_prefix.."cryonite"}
se_delivery_cannon_recipes[data_util.mod_prefix.."cryonite-rod"] = {name=data_util.mod_prefix.."cryonite-rod"}
se_delivery_cannon_recipes[data_util.mod_prefix.."vulcanite"] = {name=data_util.mod_prefix.."vulcanite"}
se_delivery_cannon_recipes[data_util.mod_prefix.."vulcanite-block"] = {name=data_util.mod_prefix.."vulcanite-block"}

if not mods["space-exploration-postprocess"] then
  local message = "\n\n[font=default-large-bold][color=255,200,0]Please install the Space Exploration Postprocess mod.[/color][/font]"
  message = message .. " \n\nYou have the Space Exploration mod installed but not the Space Exploration Postprocess mod. Both are required."
  message = message .. " \n\nUnfortunately the postprocess mod can't be listed as a dependency without creating a dependancy loop, sorry for the inconvenience. "
  message = message .. " \nTo install the postprocess mod you can disable Space Exploration using the 'disable listed mods' button below and reload the game,"
  message = message .. " \ndownload Space Exploration Postprocess mod using the in-game interface, then enable both mods. \nAlternatively you can download the postprocess mod directly here:"
  message = message .. " \nhttps://mods.factorio.com/mod/space-exploration-postprocess/downloads "
  error(message)
end
if not data_util.dot_string_greater_than(mods["space-exploration-postprocess"], min_postprocess_version, true) then
  local message = "\n\n[font=default-large-bold][color=255,200,0]Please update the Space Exploration Postprocess mod.[/color][/font]"
  error(message)
end

resource_autoplace = require("prototypes/resource_autoplace_overrides") -- load the updated functions

require("prototypes/phase-1/input")
require("prototypes/phase-1/shortcut")

require("prototypes/phase-1/item/science-pack")

require("prototypes/phase-1/damage-types")
require("prototypes/phase-1/categories")
require("prototypes/phase-1/item-groups")
require("prototypes/phase-1/signal")
require("prototypes/phase-1/sound")
require("prototypes/phase-1/styles")
--require("prototypes/phase-1/space-structures")

require("prototypes/phase-1/item/armor")
require("prototypes/phase-1/item/cargo-rocket")
require("prototypes/phase-1/item/condenser-turbine")
require("prototypes/phase-1/item/core-miner")
require("prototypes/phase-1/item/items")
require("prototypes/phase-1/item/gate")
require("prototypes/phase-1/item/meteor-defence")
require("prototypes/phase-1/item/platforms")
require("prototypes/phase-1/item/resources")
require("prototypes/phase-1/item/rocket-landing-pad")
require("prototypes/phase-1/item/rocket-launch-pad")
require("prototypes/phase-1/item/spaceship")
require("prototypes/phase-1/item/structures")

require("prototypes/phase-1/item/gun")
require("prototypes/phase-1/item/weapon-tesla")
require("prototypes/phase-1/item/weapon-cryogun")
require("prototypes/phase-1/item/weapon-plague")

require("prototypes/phase-1/item/equipment")

require("prototypes/phase-1/fluid/fluid")

require("prototypes/phase-1/recipe/recipe")
require("prototypes/phase-1/recipe/structures")
require("prototypes/phase-1/recipe/astrometrics-laboratory")
require("prototypes/phase-1/recipe/biochemical-laboratory")
require("prototypes/phase-1/recipe/cargo-rocket")
require("prototypes/phase-1/recipe/condenser-turbine")
require("prototypes/phase-1/recipe/core-miner")
require("prototypes/phase-1/recipe/decontamination-facility")
require("prototypes/phase-1/recipe/electromagnetics-laboratory")
require("prototypes/phase-1/recipe/material-fabricator")
require("prototypes/phase-1/recipe/gate")
require("prototypes/phase-1/recipe/genetics-laboratory")
require("prototypes/phase-1/recipe/gravimetrics-laboratory")
require("prototypes/phase-1/recipe/growth-facility")
require("prototypes/phase-1/recipe/hypercooler")
require("prototypes/phase-1/recipe/laser-laboratory")
require("prototypes/phase-1/recipe/lifesupport-facility")
require("prototypes/phase-1/recipe/manufacturing")
require("prototypes/phase-1/recipe/mechanical-laboratory")
require("prototypes/phase-1/recipe/observation")
require("prototypes/phase-1/recipe/particle-accelerator")
require("prototypes/phase-1/recipe/particle-collider")
require("prototypes/phase-1/recipe/plasma-generator")
require("prototypes/phase-1/recipe/platforms")
require("prototypes/phase-1/recipe/resources")
require("prototypes/phase-1/recipe/radiation-laboratory")
require("prototypes/phase-1/recipe/radiator")
require("prototypes/phase-1/recipe/recycling-facility")
require("prototypes/phase-1/recipe/rocket-landing-pad")
require("prototypes/phase-1/recipe/rocket-launch-pad")
require("prototypes/phase-1/recipe/science-lab")
require("prototypes/phase-1/recipe/science")
--require("prototypes/phase-1/recipe/spectrometry-facility")
require("prototypes/phase-1/recipe/supercomputing")
require("prototypes/phase-1/recipe/thermodynamics-laboratory")
require("prototypes/phase-1/recipe/spaceship")

require("prototypes/phase-1/decorative/crater")
require("prototypes/phase-1/decorative/rocks")

require("prototypes/phase-1/entity/entity") -- must be first
require("prototypes/phase-1/entity/astrometric-gravimetric")
require("prototypes/phase-1/entity/wide-beacon")
require("prototypes/phase-1/entity/cargo-rocket")
require("prototypes/phase-1/entity/condenser-turbine")
require("prototypes/phase-1/entity/core-miner")
require("prototypes/phase-1/entity/decontamination-lifesupport")
require("prototypes/phase-1/entity/dimensional-anchor")
require("prototypes/phase-1/entity/explosion")
require("prototypes/phase-1/entity/fluid-burner-generator")
require("prototypes/phase-1/entity/fuel-refinery")
require("prototypes/phase-1/entity/gate")
require("prototypes/phase-1/entity/genetics-laboratory")
require("prototypes/phase-1/entity/growth-facility")
require("prototypes/phase-1/entity/laser-radi-spectro-thermo")
require("prototypes/phase-1/entity/light")
require("prototypes/phase-1/entity/meteor")
require("prototypes/phase-1/entity/meteor-defence")
require("prototypes/phase-1/entity/recycle-mechanical")
require("prototypes/phase-1/entity/resources")
require("prototypes/phase-1/entity/rocket-fragments")
require("prototypes/phase-1/entity/rocket-landing-pad")
require("prototypes/phase-1/entity/rocket-launch-pad")
require("prototypes/phase-1/entity/particle-acc-col-fab")
require("prototypes/phase-1/entity/pylons")
require("prototypes/phase-1/entity/scaffold")
require("prototypes/phase-1/entity/space-biochemical")
require("prototypes/phase-1/entity/space-capsule")
require("prototypes/phase-1/entity/space-electromagnetics")
require("prototypes/phase-1/entity/space-hypercooler")
require("prototypes/phase-1/entity/space-manufactory")
require("prototypes/phase-1/entity/space-plasma-generator")
require("prototypes/phase-1/entity/space-radiator")
require("prototypes/phase-1/entity/space-supercomputer")
require("prototypes/phase-1/entity/space-science-lab")
require("prototypes/phase-1/entity/spaceship")
require("prototypes/phase-1/entity/spaceship-obstacles")
require("prototypes/phase-1/entity/starmap")
require("prototypes/phase-1/entity/supercharger")
require("prototypes/phase-1/entity/telescopes")
require("prototypes/phase-1/entity/ancient")

require("prototypes/phase-1/technology/technology")
require("prototypes/phase-1/technology/bio-upgrades")

require("prototypes/phase-1/combined/antimatter-reactor")
require("prototypes/phase-1/combined/big-heat-exchanger")
require("prototypes/phase-1/combined/big-turbine")
require("prototypes/phase-1/combined/delivery-cannon")
require("prototypes/phase-1/combined/electric-boiler")
require("prototypes/phase-1/combined/lifesupport")
require("prototypes/phase-1/combined/pipe")
require("prototypes/phase-1/combined/rail")
require("prototypes/phase-1/combined/shield-projector")
require("prototypes/phase-1/combined/transport-belt")
require("prototypes/phase-1/combined/spaceship-clamps")
require("prototypes/phase-1/combined/weapon-bio")


require("prototypes/phase-1/tile/space")
require("prototypes/phase-1/tile/regolith")
require("prototypes/phase-1/tile/asteroid")
require("prototypes/phase-1/tile/scaffold")
require("prototypes/phase-1/tile/plating")
require("prototypes/phase-1/tile/spaceship")

require("prototypes/phase-1/compatibility/qol_research.lua")

require("prototypes/phase-multi/item-group-assign")

--log( serpent.block( data.raw["tile"], {comment = false, numformat = '%1.8g' } ) )
