local data_util = require("data_util")
--[[

layer-10 through layer-15 that can be used.
wall-block-splitters layer is layer-13
space layer is layer-14
spaceship layer  is layer-15

empty space is space-layer, resource-layer, object-layer
space platform is space-layer
spaceship tiles are space-layer and resource-layer
ground tiles are ground-tile
water-tiles are water-tile and floor-layer

Space structures can't go on ground-tile
ground structrues can go on space_collision_layer
structures that can't go on spaceships are but can go on space platform need resource-layer collision

player AND car collision is
"player-layer",
"train-layer",

train collision is
"train-layer",


water collision is
"water-tile",
"item-layer",
"resource-layer",
"player-layer", -- remove this so
"doodad-layer"

belt collision is
"water-tile",
"floor-layer",

typical object is
"water-tile",
"item-layer",
"object-layer",
"player-layer",

Plan:
empty space should be:
"object-layer", -- to prevent structures, belts
"item-layer", -- to prevent vehicles
"resource-layer", -- to prevent resources
"doodad-layer", -- to prevent decoratives
"layer-14",

air should be
"object-layer",-- to prevent structures, belts
"floor-layer" -- to prevent space platform
"item-layer", -- to prevent vehicles
"resource-layer", -- to prevent resources
"doodad-layer", -- to prevent decoratives
"layer-14",

platform should be
"ground-tile"
"layer-14", -- to prevent non-space structures

non-space structures add
"layer-14",

space-only structures
"water-tile",
"ground-tile",
"item-layer",
"object-layer",
"player-layer",

vehicles add to block from space:
"item-layer",
]]--

local collision_structure = {
  "item-layer",
  "object-layer",
  "player-layer",
  "water-tile",
}

local collision_floor = {
  --"item-layer", -- stops player from dropping items on belts.
  "floor-layer",
  "object-layer",
  "water-tile",
}


-- prototype types and thier collision mask defaults
-- only ones listed are blocked from space
-- certain ones are excluded
local block_from_space = {
  --"arrow",
  --"entity-ghost",
  --"accumulator",
  --"artillery-turret",
  "beacon",
  --"boiler",
  --"player",
  --"arithmetic-combinator",
  --"decider-combinator",
  --"constant-combinator",
  --"container", -- handle seperatly
  --"smart-container",
  --"logistic-container",
  --"infinity-container",
  "assembling-machine", -- chemical planets, etc
  --"rocket-silo",
  "furnace",
  --"electric-energy-interface",
  --"electric-pole",
  "unit-spawner",
  --"fish",
  --"combat-robot",
  --"construction-robot",
  --"logistic-robot",
  --"gate",
  --"generator",
  --"heat-pipe",
  --"inserter",
  "lab",
  --"lamp",
  --"land-mine",
  "market",
  --"mining-drill",
  "offshore-pump",
  "pipe",
  "pipe-to-ground",
  --"player-port", -- maybe players respawn from here?",
  --"power-switch",
  --"programmable-speaker",
  --"pump",
  --"radar",
  "curved-rail",
  "straight-rail",
  --"rail-chain-signal",
  --"rail-signal",
  --"reactor",
  --"roboport",
  --"simple-entity",
  --"simple-entity-with-owner",
  --"simple-entity-with-force",
  --"solar-panel",
  "storage-tank",
  --"train-stop",
  --"loader",
  "splitter",
  "transport-belt",
  "underground-belt",
  "tree",
  "turret",
  --"ammo-turret",
  --"electric-turret",
  "fluid-turret",
  --"unit",
  --"car",
  --"artillery-wagon",
  --"cargo-wagon",
  --"fluid-wagon",
  --"locomotive",
  --"wall",
  --"explosion",
  --"flame-thrower-explosion",
  --"fire",
  --"stream",
  --"flying-text",
  --"item-entity",
  --"item-request-proxy",
  --"particle",
  --"artillery-flare",
  --"particle-source",
  --"projectile",
  --"resource",
  --"rocket-silo-rocket",
  --"rocket-silo-rocket-shadow",
  --"smoke",
  --"smoke-with-trigger",
  --"sticker",
  --"tile-ghost",
  --"optimised-decorative",
}

local default_collision = {
  ["beacon"] = collision_structure,
  ["boiler"] = collision_structure,
  --"player",
  --["arithmetic-combinator"] = collision_structure,
  --["decider-combinator"] = collision_structure,
  --["constant-combinator"] = collision_structure,
  ["container"] = collision_structure,
  --"smart-container",
  --"logistic-container",
  --"infinity-container",
  ["assembling-machine"] = collision_structure, -- chemical planets, etc
  --"rocket-silo",
  ["furnace"] = collision_structure,
  --"electric-energy-interface",
  --"electric-pole",
  ["unit-spawner"] = collision_structure,
  --"fish",
  --"combat-robot",
  --"construction-robot",
  --"logistic-robot",
  --"gate",
  --"generator",
  --"heat-pipe",
  --"inserter",
  ["lab"] = collision_structure,
  --"lamp",
  --"land-mine",
  ["market"] = collision_structure,
  ["mining-drill"] = collision_structure,
  ["offshore-pump"] = collision_structure,
  ["pipe"] = collision_floor,
  ["pipe-to-ground"] = collision_floor,
  ["player-port"] = collision_structure, -- maybe players respawn from here?",
  --"power-switch",
  --"programmable-speaker",
  --"pump",
  --"radar",
  ["curved-rail"] = collision_floor,
  ["straight-rail"] = collision_floor,
  --"rail-chain-signal",
  --"rail-signal",
  --"reactor",
  --["roboport"] = collision_structure,
  --"simple-entity",
  --"simple-entity-with-owner",
  --"simple-entity-with-force",
  --"solar-panel",
  ["storage-tank"] = collision_structure,
  --"train-stop",
  --"loader",
  ["splitter"] = collision_floor,
  ["transport-belt"] = collision_floor,
  ["underground-belt"] = collision_floor,
  ["tree"] = collision_structure,
  --"turret",
  --"ammo-turret",
  --"electric-turret",
  --"fluid-turret",
  --"unit",
  --"car",
  --"artillery-wagon",
  --"cargo-wagon",
  --"fluid-wagon",
  --"locomotive",
  --"wall",
  --"explosion",
  --"flame-thrower-explosion",
  --"fire",
  --"stream",
  --"flying-text",
  --"item-entity",
  --"item-request-proxy",
  --"particle",
  --"artillery-flare",
  --"particle-source" = collision_structure,
  --"projectile",
  --"resource",
  --"rocket-silo-rocket",
  --"rocket-silo-rocket-shadow",
  --"smoke",
  --"smoke-with-trigger",
  --"sticker",
  --"tile-ghost",
  --"optimised-decorative",
}

for _, tile in pairs(data.raw.tile) do
  if string.find(tile.name, "water") then
    --table.insert(tile.collision_mask, "floor-layer")
    table.insert(tile.collision_mask, "item-layer")
  end
  --if (tile.minable and tile.name ~= "kr-creep") or tile.name == "landfill" then -- solved by using autoplace
    --table.insert(tile.collision_mask, "resource-layer")
    -- lets you remove unwanted resources with floor.
    -- IMPORTANT: flooring needs to block resource generation
  --end
end
--table.insert(data.raw.tile.landfill.collision_mask, "resource-layer") -- prevent regenerated ores from spawning on landfill

-- disable paving over space and other space platform
for _, item in pairs(data.raw.item) do

  -- space
  if item.name ~= data_util.mod_prefix.."space-platform-scaffold"
      and item.name ~= data_util.mod_prefix.."space-platform-plating"
      and item.name ~= data_util.mod_prefix.."spaceship-floor" then
    if item.place_as_tile then
      if not item.place_as_tile.condition then
        item.place_as_tile.condition = {space_collision_layer}
        item.place_as_tile.condition_size = 1
      else
        table.insert(item.place_as_tile.condition, space_collision_layer)
        item.place_as_tile.condition_size = math.max(item.place_as_tile.condition_size or 1)
      end
    end
  end
  if item.place_as_tile then
    if item.localised_description then
      item.localised_description = {"space-exploration.simple-a-b-break", item.localised_description, {"space-exploration.tile_warning"}}
    elseif item.name == data_util.mod_prefix.."space-platform-scaffold"
        or item.name == data_util.mod_prefix.."space-platform-plating"
        or item.name == data_util.mod_prefix.."spaceship-floor" then
          -- flooring with description
      item.localised_description = {"space-exploration.simple-a-b-break", {"item-description."..item.name}, {"space-exploration.tile_warning"}}
    else -- assumed without description
      item.localised_description = {"space-exploration.tile_warning"}
    end
  end
end

for _, prototype in pairs(data.raw["rocket-silo"]) do
  local collision = prototype.collision_mask
  if not collision then
    collision = table.deepcopy(collision_structure)
  end
  table.insert(collision, spaceship_collision_layer) -- block from spaceship
  prototype.collision_mask = collision
end

for _, prototype in pairs(data.raw["mining-drill"]) do
  local type = "mining-drill"
  if prototype.resource_categories and prototype.resource_categories[1] == "basic-solid" then
    -- allow in space
  else
    local collision = prototype.collision_mask
    if not collision then
      if default_collision[type] then
          collision = table.deepcopy(default_collision[type])
      else
        collision = table.deepcopy(collision_structure)
      end
    else
      collision = table.deepcopy(collision) -- avoid altering shared tables
    end
    table.insert(collision, space_collision_layer)
    prototype.collision_mask = collision
  end
end

for _, type in pairs(block_from_space) do
  for _, prototype in pairs(data.raw[type]) do

    local collision = prototype.collision_mask
    if not collision then
      if default_collision[type] then
          collision = table.deepcopy(default_collision[type])
      else
        collision = table.deepcopy(collision_structure)
      end
    else
      collision = table.deepcopy(collision) -- avoid altering shared tables
    end
    prototype.collision_mask = collision

    if (not prototype.se_allow_in_space)
    and (not se_allow_in_space[prototype.name]) -- see data.lua for how to allow your entity in space
    and string.sub(prototype.name, 1, 8) ~= "se-space"
    and string.sub(prototype.name, 1, 13) ~= "se-deep-space"
    and (not string.find( prototype.name, "storage-tank", 1, true))
    and (not string.find( prototype.name, "valve", 1, true))
    and (
      type == "offshore-pump"
      or
      not (
        string.find( prototype.name, "pump", 1, true)
        --and not string.find( prototype.name, "water", 1, true)
      )
    ) -- not water pump
    and (not string.find(prototype.name, data_util.mod_prefix.."rocket-", 1, true))
    and prototype.name ~= data_util.mod_prefix.."big-turbine"
    and prototype.name ~= data_util.mod_prefix.."condenser-turbine"
    and prototype.name ~= data_util.mod_prefix.."meteor-defence-charger"
    and prototype.name ~= data_util.mod_prefix.."meteor-point-defence-charger"
    --and prototype.name ~= data_util.mod_prefix.."fuel-refinery"
    and prototype.name ~= data_util.mod_prefix .. "space-straight-rail"
    and prototype.name ~= data_util.mod_prefix .. "space-curved-rail"
    and prototype.name ~= data_util.mod_prefix .. "gate-tank-input"
    and prototype.name ~= data_util.mod_prefix .. "gate-tank-output"
    and prototype.name ~= data_util.mod_prefix .. "gate-platform-scaffold"
    and prototype.name ~= data_util.mod_prefix .. "wide-beacon"
    and prototype.name ~= "realistic-reactor-eccs"
    --and prototype.name ~= "barreling-pump" -- angels
    then
      log("space-collide: " .. prototype.name)
      table.insert(prototype.collision_mask, space_collision_layer)
    else
      -- is alloweed
      if prototype.allowed_effects and data_util.table_contains(prototype.allowed_effects, "productivity") then
        local spaced = table.deepcopy(prototype)
        spaced.name = spaced.name .. "-spaced"
        spaced.localised_name = {"space-exploration.structure_name_spaced", {"entity-name."..prototype.name}}
        spaced.localised_description = {"space-exploration.structure_description_spaced", {"entity-description."..prototype.name}}
        spaced.flags = spaced.flags or {}
        if not data_util.table_contains(spaced.flags, "hidden") then
          table.insert(spaced.flags, "hidden")
        end
        if not spaced.placeable_by then
          for _, item in pairs(data.raw.item) do
            if item.place_result == prototype.name then
              spaced.placeable_by = spaced.placeable_by or {item = item.name, count=1}
              break
            end
          end
        end
        local allowed_effects = {}
        for _, effect in pairs(prototype.allowed_effects) do
          if effect ~= "productivity" then
            table.insert(allowed_effects, effect)
          end
        end
        spaced.allowed_effects = allowed_effects
        data:extend({spaced})
      end
    end
    if prototype.name ~= data_util.mod_prefix.."dimensional-anchor" and type ~= "tree" then
      data_util.collision_description(prototype)
    end
    if prototype.crafting_categories and (not data_util.table_contains(prototype.collision_mask, spaceship_collision_layer)) then
      local has_space_recipe = false
      for _, category in pairs(prototype.crafting_categories) do
        if string.sub(category, 1, 6) == "space-" then
          has_space_recipe = true
          break
        end
      end
      if has_space_recipe then
        local grounded = table.deepcopy(prototype)
        grounded.name = grounded.name .. "-grounded"
        grounded.localised_name = {"space-exploration.structure_name_grounded", {"entity-name."..prototype.name}}
        grounded.localised_description = {"space-exploration.structure_description_grounded", {"entity-description."..prototype.name}}
        grounded.flags = grounded.flags or {}
        if not data_util.table_contains(grounded.flags, "hidden") then
          table.insert(grounded.flags, "hidden")
        end
        grounded.crafting_categories = {}
        for _, category in pairs(prototype.crafting_categories) do
          if string.sub(category, 1, 6) ~= "space-" then
            table.insert(grounded.crafting_categories, category)
          end
        end
        if #grounded.crafting_categories == 0 then
          grounded.crafting_categories = {"no-category"}
        end
        if not grounded.placeable_by then
          for _, item in pairs(data.raw.item) do
            if item.place_result == prototype.name then
              grounded.placeable_by = grounded.placeable_by or {item = item.name, count=1}
              break
            end
          end
        end
        data:extend({grounded})
      end
    end
  end
end

for _, type in pairs({"accumulator"}) do
  for _, prototype in pairs(data.raw[type]) do
    data_util.collision_description(prototype)
  end
end



for _, container in pairs({"container", "logistic-container"}) do
  for _, prototype in pairs(data.raw[container]) do
    if string.sub(prototype.name, 1, 8) ~= "se-space"
    and prototype.name ~= data_util.mod_prefix .. "cargo-rocket-cargo-pod"
    and prototype.name ~= data_util.mod_prefix.."meteor-defence-container"
    and prototype.name ~= data_util.mod_prefix.."meteor-point-defence-container"
    and (not string.find(prototype.name, data_util.mod_prefix.."rocket-", 1, true))
    and (not string.find(prototype.name, "silo", 1, true))
    and (not string.find(prototype.name, "chest", 1, true))
    and (not string.find(prototype.name, "warehouse", 1, true))
    and (not string.find(prototype.name, "storehouse", 1, true)) then
      --log(prototype.name)
      local collision = prototype.collision_mask
      if not collision then
        if default_collision[type] then
            collision = table.deepcopy(default_collision[type])
        else
          collision = table.deepcopy(collision_structure)
        end
      else
        collision = table.deepcopy(collision) -- avoid altering shared tables
      end
      table.insert(collision, space_collision_layer)
      prototype.collision_mask = collision
    end
  end
end

--[[ -- this prevents cars from driving over belts
for _, prototype in pairs(data.raw.car) do
  if prototype.name ~= "se-space-capsule-_-vehicle" then
    prototype.collision_mask = prototype.collision_mask or {"player-layer", "train-layer"}
    table.insert(prototype.collision_mask, space_collision_layer)
  end
end
]]--
for _, fish in pairs(data.raw.fish) do
  if not string.find(fish.name, "space", 1, true) then
    if not fish.collision_mask then
      fish.collision_mask = { "ground-tile"}
    end
    table.insert(fish.collision_mask, space_collision_layer)
  end
end

for _, leg in pairs(data.raw["spider-leg"]) do
  leg.collision_mask = {
    "item-layer",
    "object-layer",
    "player-layer",
    "water-tile"
  }
end
