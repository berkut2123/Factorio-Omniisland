local data_util = require("data_util")

data_util.tech_lock_recipes("rocket-fuel", {data_util.mod_prefix .."liquid-rocket-fuel", data_util.mod_prefix .. "vulcanite-rocket-fuel"})

local function auto() return {"automation-science-pack", 1} end
local function logi() return {"logistic-science-pack", 1} end
local function chem() return {"chemical-science-pack", 1} end
local function mili() return {"military-science-pack", 1} end
local function util() return {"utility-science-pack", 1} end
local function prod() return {"production-science-pack", 1} end
local function rock() return {data_util.mod_prefix .. "rocket-science-pack", 1} end
local function spac() return {"space-science-pack", 1} end
local function deep() return {data_util.mod_prefix .."deep-space-science-pack", 1} end

data.raw.technology["logistic-science-pack"].icon = "__space-exploration-graphics__/graphics/technology/beaker/teal.png"
data.raw.technology["chemical-science-pack"].icon = "__space-exploration-graphics__/graphics/technology/beaker/cyan.png"
data.raw.technology["military-science-pack"].icon = "__space-exploration-graphics__/graphics/technology/beaker/grey.png"
data.raw.technology["production-science-pack"].icon = "__space-exploration-graphics__/graphics/technology/beaker/purple.png"
data.raw.technology["utility-science-pack"].icon = "__space-exploration-graphics__/graphics/technology/beaker/yellow.png"
data.raw.technology["space-science-pack"].icon = "__space-exploration-graphics__/graphics/technology/beaker/white.png"

data.raw.tool["automation-science-pack"].icon = "__space-exploration-graphics__/graphics/icons/beaker/red.png"
data.raw.tool["automation-science-pack"].icon_size = 64
data.raw.tool["logistic-science-pack"].icon = "__space-exploration-graphics__/graphics/icons/beaker/teal.png"
data.raw.tool["logistic-science-pack"].icon_size = 64
data.raw.tool["chemical-science-pack"].icon = "__space-exploration-graphics__/graphics/icons/beaker/cyan.png"
data.raw.tool["chemical-science-pack"].icon_size = 64
data.raw.tool["military-science-pack"].icon = "__space-exploration-graphics__/graphics/icons/beaker/grey.png"
data.raw.tool["military-science-pack"].icon_size = 64
data.raw.tool["production-science-pack"].icon = "__space-exploration-graphics__/graphics/icons/beaker/purple.png"
data.raw.tool["production-science-pack"].icon_size = 64
data.raw.tool["utility-science-pack"].icon = "__space-exploration-graphics__/graphics/icons/beaker/yellow.png"
data.raw.tool["utility-science-pack"].icon_size = 64
data.raw.tool["space-science-pack"].icon = "__space-exploration-graphics__/graphics/icons/beaker/white.png"
data.raw.tool["space-science-pack"].icon_size = 64

--data_util.tech_remove_prerequisites("space-science-pack", {"rocket-silo"})
--data_util.tech_add_prerequisites("space-science-pack", {data_util.mod_prefix .."space-science-lab"})
--data.raw.technology["space-science-pack"].prerequisites = {"production-science-pack", data_util.mod_prefix .. "processing-cryonite"}
--data.raw.technology["space-science-pack"].unit.ingredients = {auto(), logi(), chem(), prod()}
data_util.tech_lock_recipes("space-science-pack", {"space-science-pack"})
data_util.tech_remove_ingredients("space-science-pack", {"utility-science-pack"})

data_util.tech_add_prerequisites("rocket-fuel", {"chemical-science-pack"})
data_util.tech_add_prerequisites("rocket-fuel", {data_util.mod_prefix .. "fuel-refining"})
data.raw.technology["rocket-fuel"].unit.ingredients = {auto(), logi(), chem()}
data_util.tech_lock_recipes("rocket-fuel", {data_util.mod_prefix .."liquid-rocket-fuel"})

data.raw.technology["rocket-silo"].unit.count = 500
data.raw.technology["rocket-silo"].unit.time = 30
data.raw.technology["rocket-silo"].unit.ingredients = {auto(), logi(), chem()}
data_util.tech_lock_recipes("rocket-silo", {"satellite"})
data.raw.technology['rocket-silo'].prerequisites = {"concrete", "low-density-structure", "rocket-control-unit", "rocket-fuel", "solar-energy" }
if data.raw.technology['radar'] then
  data_util.tech_add_prerequisites('rocket-silo', {'radar'})
  data.raw.technology['radar'].enabled = true
  data_util.tech_lock_recipes("radar", {"radar"})
end


data.raw.technology["rocket-control-unit"].unit.ingredients = {auto(), logi(), chem()}
data_util.tech_remove_prerequisites("rocket-control-unit", {"utility-science-pack", "speed-module", "speed-module-1"})
data_util.tech_add_prerequisites("rocket-control-unit", {"advanced-electronics-2", "battery"})

data_util.tech_add_prerequisites("basic-optics", {"glass-processing"})

data_util.tech_add_prerequisites("chemical-science-pack", {"optics"})

data_util.tech_remove_prerequisites("advanced-material-processing-2", {"chemical-science-pack"})
data_util.tech_add_prerequisites("advanced-material-processing-2", {data_util.mod_prefix .. "heat-shielding"})

--data_util.tech_add_prerequisites("logistic-robotics", {"utility-science-pack"})
--data_util.tech_add_ingredients("logistic-robotics", { "chemical-science-pack", "utility-science-pack"}, true)
data_util.tech_add_ingredients("logistic-robotics", { "chemical-science-pack"}, true)

--data_util.tech_remove_prerequisites("logistic-system", {"utility-science-pack"})

data_util.tech_add_ingredients_with_prerequisites("worker-robots-storage-1", {"utility-science-pack", "space-science-pack"})
data_util.tech_add_ingredients_with_prerequisites("worker-robots-storage-2", {data_util.mod_prefix .. "material-science-pack-1"})


data_util.tech_remove_prerequisites("worker-robots-speed-3", {"utility-science-pack"})
data_util.tech_remove_ingredients_recursive ("worker-robots-speed-5", {"utility-science-pack"}) -- forces prereq at later step

data_util.tech_add_ingredients_with_prerequisites("worker-robots-speed-3", {"production-science-pack", "space-science-pack"})
data_util.tech_add_ingredients_with_prerequisites("worker-robots-speed-4", {data_util.mod_prefix .. "rocket-science-pack"})
data_util.tech_add_ingredients_with_prerequisites("worker-robots-speed-5", {"utility-science-pack",  data_util.mod_prefix .. "energy-science-pack-1"})

--data_util.tech_add_ingredients_with_prerequisites("speed-module-2", {"production-science-pack"})
--data_util.tech_add_ingredients_with_prerequisites("productivity-module-2", {"production-science-pack"})
--data_util.tech_add_ingredients_with_prerequisites("effectivity-module-2", {"production-science-pack"})

--data_util.tech_remove_prerequisites("speed-module-3", {"production-science-pack"})
--data_util.tech_add_prerequisites("speed-module-3", {"space-science-pack", data_util.mod_prefix .. "material-science-pack-1"})
--data_util.tech_add_ingredients("speed-module-3", { "space-science-pack", data_util.mod_prefix .. "material-science-pack-1" }, true)

--data_util.tech_remove_prerequisites("productivity-module-3", {"production-science-pack"})
--data_util.tech_add_prerequisites("productivity-module-3", {"space-science-pack", data_util.mod_prefix .. "biological-science-pack-1"})
--data_util.tech_add_ingredients("productivity-module-3", { "space-science-pack", data_util.mod_prefix .. "biological-science-pack-1" }, true)

--data_util.tech_remove_prerequisites("effectivity-module-3", {"production-science-pack"})
--data_util.tech_add_prerequisites("effectivity-module-3", {"space-science-pack", data_util.mod_prefix .. "energy-science-pack-1"})
--data_util.tech_add_ingredients("effectivity-module-3", { "space-science-pack", data_util.mod_prefix .. "energy-science-pack-1" }, true)

--data_util.tech_add_prerequisites("effect-transmission", { "utility-science-pack", data_util.mod_prefix .. "energy-science-pack-1"})
--data_util.tech_add_ingredients("effect-transmission", { "utility-science-pack", "space-science-pack", data_util.mod_prefix .. "energy-science-pack-1"}, true)
data_util.tech_add_prerequisites("effect-transmission", { "production-science-pack"})
data_util.tech_add_ingredients("effect-transmission", { "production-science-pack"}, true)

--data_util.tech_add_ingredients_with_prerequisites("modular-armor", {"chemical-science-pack"})
--data_util.tech_add_ingredients_with_prerequisites("power-armor", {"utility-science-pack"})
--data_util.tech_add_prerequisites("power-armor-mk2", {data_util.mod_prefix.."processing-iridium"})
--data_util.tech_add_ingredients("power-armor-mk2", { "space-science-pack"}, true)

data_util.tech_add_ingredients_with_prerequisites("battery-mk2-equipment", { "space-science-pack"})

--data_util.tech_add_ingredients_with_prerequisites("personal-roboport-equipment", {"utility-science-pack"})
--data_util.tech_remove_prerequisites("personal-roboport-mk2-equipment", {"utility-science-pack"})
data_util.tech_add_ingredients_with_prerequisites("personal-roboport-mk2-equipment", {data_util.mod_prefix .. "material-science-pack-1"})

data_util.tech_add_prerequisites("fusion-reactor-equipment", { data_util.mod_prefix .. "deep-space-science-pack", data_util.mod_prefix .. "rtg-equipment-2",})


data_util.tech_lock_recipes(data_util.mod_prefix.."fuel-refining", {"solid-fuel-from-heavy-oil", "solid-fuel-from-light-oil", "solid-fuel-from-petroleum-gas"})

--data_util.tech_split_at_levels("artillery-shell-range", {3, 5})
--data_util.tech_add_ingredients_with_prerequisites("artillery-shell-range-3", { data_util.mod_prefix .. "material-science-pack-1"})
--data_util.tech_split_at_levels("artillery-shell-speed", {3, 5})
--data_util.tech_add_ingredients_with_prerequisites("artillery-shell-speed-3", { data_util.mod_prefix .. "material-science-pack-1"})

data_util.tech_remove_ingredients("mining-productivity-3", {"utility-science-pack"})
data_util.tech_remove_ingredients("mining-productivity-4", {"utility-science-pack"})
data_util.tech_split_at_levels("mining-productivity", {4, 5, 6, 7, 8, 9, 10})
data_util.tech_add_ingredients_with_prerequisites("mining-productivity-3", {"production-science-pack"})
data_util.tech_add_ingredients_with_prerequisites("mining-productivity-4", {"utility-science-pack", "space-science-pack"})
data_util.tech_add_ingredients_with_prerequisites("mining-productivity-5", {data_util.mod_prefix .. "rocket-science-pack"})
data_util.tech_add_ingredients_with_prerequisites("mining-productivity-6", {data_util.mod_prefix .. "biological-science-pack-1"})
data_util.tech_add_ingredients_with_prerequisites("mining-productivity-7", {data_util.mod_prefix .. "biological-science-pack-2"})
data_util.tech_add_ingredients_with_prerequisites("mining-productivity-8", {data_util.mod_prefix .. "biological-science-pack-3"})
data_util.tech_add_ingredients_with_prerequisites("mining-productivity-9", {data_util.mod_prefix .. "biological-science-pack-4"})
data_util.tech_add_ingredients_with_prerequisites("mining-productivity-10", {data_util.mod_prefix .. "deep-space-science-pack"})

data_util.tech_add_prerequisites("jetpack-2", { data_util.mod_prefix .. "rocket-science-pack"})
data_util.tech_add_prerequisites("jetpack-3", { data_util.mod_prefix .. "aeroframe-pole"})
data_util.tech_add_prerequisites("jetpack-4", { data_util.mod_prefix .. "naquium-cube"})
data_util.tech_add_ingredients_with_prerequisites("jetpack-2", {data_util.mod_prefix .. "rocket-science-pack"})
data_util.tech_add_ingredients_with_prerequisites("jetpack-3", {data_util.mod_prefix .. "astronomic-science-pack-1"})
data_util.tech_add_ingredients_with_prerequisites("jetpack-4", {data_util.mod_prefix .. "deep-space-science-pack"})

data_util.tech_remove_ingredients_recursive("industrial-furnace", {"production-science-pack"})

data_util.tech_remove_prerequisites("industrial-furnace", {"production-science-pack"})
data_util.tech_add_prerequisites("industrial-furnace", { "advanced-material-processing-2"})

if data.raw.technology["electric-mining"] and not data.raw.technology["electric-mining"].enabled == false then
  data_util.tech_add_prerequisites(data_util.mod_prefix .. "core-miner", {"electric-mining"})
end
