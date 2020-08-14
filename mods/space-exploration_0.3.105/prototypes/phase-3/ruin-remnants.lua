local data_util = require("data_util")

local base_remnants = {
  --"small-scorchmark",

  "1x2-remnants",
  "small-remnants",
  "small-generic-remnants",
  "medium-small-remnants",
  "medium-remnants",
  "big-remnants",

  "wooden-chest-remnants",
  "iron-chest-remnants",
  "active-provider-chest-remnants",
  "buffer-chest-remnants",
  "passive-provider-chest-remnants",
  "requester-chest-remnants",
  "steel-chest-remnants",
  "storage-chest-remnants",

  "arithmetic-combinator-remnants",
  "constant-combinator-remnants",
  "decider-combinator-remnants",
  "programmable-speaker-remnants",

  "big-electric-pole-remnants",
  "medium-electric-pole-remnants",
  "small-electric-pole-remnants",
  "substation-remnants",

  "accumulator-remnants",
  "artillery-turret-remnants",
  "boiler-remnants",
  "burner-mining-drill-remnants",
  "centrifuge-remnants",
  "chemical-plant-remnants",
  "electric-furnace-remnants",
  "heat-exchanger-remnants",
  "heat-pipe-remnants",
  "lab-remnants",
  "nuclear-reactor-remnants",
  "oil-refinery-remnants",
  "pumpjack-remnants",
  "radar-remnants",
  "roboport-remnants",
  "rocket-silo-generic-remnants",
  "solar-panel-remnants",
  "steam-engine-remnants",
  "steam-turbine-remnants",
  "steel-furnace-remnants",
  "stone-furnace-remnants",

  "train-stop-remnants",
  "rail-chain-signal-remnants",
  "rail-signal-remnants",

  "transport-belt-remnants",
  "underground-belt-remnants",
  "splitter-remnants",
  "express-splitter-remnants",
  "express-transport-belt-remnants",
  "express-underground-belt-remnants",
  "fast-splitter-remnants",
  "fast-transport-belt-remnants",
  "fast-underground-belt-remnants",

  "pipe-remnants",
  "pipe-to-ground-remnants",
  "pump-remnants",
  "storage-tank-remnants",

  "wall-remnants",
  "gate-remnants",
  "gun-turret-remnants",
  "flamethrower-turret-remnants",
  "laser-turret-remnants",

  "artillery-wagon-remqnants",
  "car-remnants",
  "tank-remnants",
  "cargo-wagon-remnants",
  "fluid-wagon-remnants",
  "locomotive-remnants",

  "burner-inserter-remnants",
  "fast-inserter-remnants",
  "filter-inserter-remnants",
  "inserter-remnants",
  "long-handed-inserter-remnants",
  "stack-filter-inserter-remnants",
  "stack-inserter-remnants",
}
-- remnants and corpses tha can be used for ruins decoration.
for _, corpse_name in pairs(base_remnants) do
  local corpse = data.raw.corpse[corpse_name]
  if corpse then
    local ruin = table.deepcopy(corpse)
    ruin.name = "ruin-"..corpse.name
    ruin.localised_name = corpse.localised_name or {"entity-name."..corpse.name}
    ruin.type = "simple-entity-with-force"
    ruin.time_before_removed = nil
    ruin.animations = corpse.animation
    ruin.collision_mask = {"object-layer", "player-layer"}
    ruin.minable = {
      mining_time = 0.1,
      results={
        {name=data_util.mod_prefix .. "scrap", amount = 1},
      }
    }
    ruin.order = "r[ruin]-" .. (corpse.order or "")
    ruin.collision_box = corpse.collision_box or {{-0.45,-0.45},{0.45,0.45}}
    ruin.selectable_in_game = true
    ruin.flags = ruin.flags or {}
    data_util.remove_from_table(ruin.flags, "placeable-neutral")
    if not data_util.table_contains(ruin.flags, "placeable-player") then
      table.insert(ruin.flags, "placeable-player")
    end
    if not data_util.table_contains(ruin.flags, "player-creation") then
      table.insert(ruin.flags, "player-creation")
    end
    data:extend({
      {
        type = "item",
        name = ruin.name,
        icon = ruin.icon,
        icons = ruin.icons,
        icon_size = ruin.icon_size,
        order = ruin.order,
        stack_size = 50,
        subgroup = "ruins",
        place_result = ruin.name,
        flags = { "hidden" },
        localised_name = ruin.localised_name
      },
      ruin
    })
  end
end

--[[
-- TODO: corpses that don't time out
local base_corpses = {
  "behemoth-biter-corpse", "behemoth-spitter-corpse", "behemoth-worm-corpse",
  "big-biter-corpse", "big-spitter-corpse", "big-worm-corpse",
  "medium-biter-corpse", "medium-spitter-corpse", "medium-worm-corpse",
  "small-biter-corpse", "small-spitter-corpse", "small-worm-corpse",
  "biter-spawner-corpse", "spiter-spawner-corpse"
}]]--

data:extend({
  {
    type = "item",
    name = data_util.mod_prefix .. "blueprint-registration-point",
    icon = "__core__/graphics/too-far.png",
    icon_size = 32,
    stack_size = 50,
    subgroup = "ruins",
    order = "a",
    flags = { "hidden" },
    place_result = data_util.mod_prefix .. "blueprint-registration-point",
  },
  {
    type = "simple-entity-with-force",
    name = data_util.mod_prefix .. "blueprint-registration-point",
    collision_box = {{-0.45,-0.45}, {0.45,0.45}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = {{-0.45,-0.45}, {0.45,0.45}},
    selection_priority = 200,
    icon = "__core__/graphics/too-far.png",
    icon_size = 32,
    animations = {
      filename = "__core__/graphics/too-far.png",
      width = 32,
      height = 32,
    },
    flags = { "hidden" },
    minable = {mining_time = 0.2, result = data_util.mod_prefix .. "blueprint-registration-point"},
  },
})
