local data_util = require("data_util")

require("prototypes/phase-multi/no-recycle")

require("prototypes/phase-3/recipe")

require("prototypes/phase-3/technology")
require("prototypes/phase-3/technology-procedural")

require("prototypes/phase-3/noise-programs")

require("prototypes/phase-3/space-collision")

require("prototypes/phase-3/ruin-remnants")

require("prototypes/phase-3/resources")

require("prototypes/phase-3/core-fragments")

require("prototypes/phase-3/incompatibility")

require("prototypes/phase-3/compatibility/angels")

require("prototypes/phase-3/character")

require("prototypes/phase-3/energy-shield-equipment")

require("prototypes/phase-3/delivery-cannon")

require("prototypes/phase-multi/item-group-assign")

--require("prototypes/phase-3/compatibility")

data.raw["heat-pipe"]["heat-pipe"].heat_buffer.max_transfer = "2GW"

for _, fish in pairs(data.raw.fish) do
  if not fish.healing_per_tick then fish.healing_per_tick = 0.01 end
  fish.resistances = {
    {type = "meteor", percent = 100}
  }
end


-- undo some alien biomes changes, impotant for asteroid decals
data.raw.tile["se-space"].layer = 0
data.raw.tile["se-space"].pollution_absorption_per_second = 0.1
data.raw.tile["se-asteroid"].layer = 5

data.raw.tile["out-of-map"].pollution_absorption_per_second = 0.1

local function find_orphaned_recipes()
  local all_recipes = {}
  for _, recipe in pairs(data.raw.recipe) do
    if (recipe.enabled == false) or
      (recipe.normal and recipe.normal.enabled == false) or
      (recipe.expensive and recipe.expensive.enabled == false) then
      all_recipes[recipe.name] = true
    end
  end
  for _, tech in pairs(data.raw.technology) do
    if tech.effects then
      for _, effect in pairs(tech.effects) do
        if effect.type == "unlock-recipe" and effect.recipe then
          all_recipes[effect.recipe] = nil
        end
      end
    end
  end
  for recipe_name, valid in pairs(all_recipes) do
    log("Orphaned recipe: " .. recipe_name)
  end
end


-- stop rails from being destroyed by meteors
for _, rail_type in pairs({"straight-rail", "curved-rail"}) do
  for _, rail in pairs(data.raw[rail_type]) do
    rail.selection_priority = 1
    rail.resistances = rail.resistances or {}
    table.insert(rail.resistances, {type = "meteor", percent = 99.75})
  end
end
for _, type in pairs({"locomotive", "cargo-wagon", "fluid-wagon"}) do
  for _, prototype in pairs(data.raw[type]) do
    prototype.selection_priority = 51
  end
end

data.raw["god-controller"]["default"].item_pickup_distance = 0
data.raw["god-controller"]["default"].loot_pickup_distance = 0
data.raw["god-controller"]["default"].mining_speed = 0.0000001
data.raw["god-controller"]["default"].movement_speed = 1
data.raw["spectator-controller"]["default"].movement_speed = 1

-- this won't work, the furnace recipes are hidden
if data.raw["recipe-category"]["recycle"] then
  table.insert(data.raw["assembling-machine"][data_util.mod_prefix .. "recycling-facility"].crafting_categories, "recycle")
end
if data.raw["recipe-category"]["recycle-with-fluids"] then
  table.insert(data.raw["assembling-machine"][data_util.mod_prefix .. "recycling-facility"].crafting_categories, "recycle-with-fluids")
end

for i=4,9 do
  data.raw.module["productivity-module-" .. i].limitation = data.raw.module["productivity-module-3"].limitation
end

data.raw["map-gen-presets"].default["space-exploration"] = {
  name = "space-exploration",
  order = "a",
  basic_settings = {
    autoplace_controls = {
      hot = {size = 0.5},
      cold = {size = 0.5},
      ["se-beryllium-ore"] = {frequency = 0, richness = -1, size = 0},
      ["se-cryonite"] = {frequency = 0, richness = -1, size = 0},
      ["se-holmium-ore"] = {frequency = 0, richness = -1, size = 0},
      ["se-iridium-ore"] = {frequency = 0, richness = -1, size = 0},
      ["se-methane-ice"] = {frequency = 0, richness = -1, size = 0},
      ["se-naquium-ore"] = {frequency = 0, richness = -1, size = 0},
      ["se-vitamelange"] = {frequency = 0, richness = -1, size = 0},
      ["se-vulcanite"] = {frequency = 0, richness = -1, size = 0},
      ["se-water-ice"] = {frequency = 0, richness = -1, size = 0}
    },
    property_expression_names = {
      ["control-setting:water"] = 1.5,
      ["control-setting:moisture:bias"] = 0.05,
      ["control-setting:aux:bias"] = -0.35
    }
  },
  advanced_settings = {
    enemy_evolution = {
      time_factor = 1e-06,
      destroy_factor = 1e-05,
      pollution_factor = 1e-06,
    },
  },
}
data.raw["map-gen-presets"].default.default.order = "a-a"

--find_orphaned_recipes()

--log( serpent.block( data.raw["assembling-machine"][data_util.mod_prefix .. "spaceship-clamp"], {comment = false, numformat = '%1.8g' } ) )
