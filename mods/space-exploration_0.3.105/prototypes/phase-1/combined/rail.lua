local data_util = require("data_util")

local collision_floor = {
  --"item-layer", -- stops player from dropping items on belts.
  "floor-layer",
  --"object-layer",
  "water-tile",
}

--data.raw["curved-rail"]["curved-rail"].fast_replaceable_group = "curved-rail" -- makes crossing placement overwrite instead of cross
--data.raw["straight-rail"]["straight-rail"].fast_replaceable_group = "straight-rail" -- makes crossing placement overwrite instead of cross

data.raw["rail-signal"]["rail-signal"].collision_mask = collision_floor
data.raw["rail-chain-signal"]["rail-chain-signal"].collision_mask = collision_floor

local curved_rail = table.deepcopy(data.raw["curved-rail"]["curved-rail"])
curved_rail.name = data_util.mod_prefix .. "space-curved-rail"
curved_rail.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
curved_rail.icon_size = 32
curved_rail.minable = { mining_time = 0.2, count = 4, result = data_util.mod_prefix .. "space-rail"}
curved_rail.placeable_by = { count = 4, item = data_util.mod_prefix .. "space-rail"}
curved_rail.collision_mask = collision_floor
curved_rail.fast_replaceable_group = "space-curved-rail"
curved_rail.next_upgrade = nil
--data.raw["curved-rail"]["curved-rail"].next_upgrade = curved_rail.name

data_util.replace_filenames_recursive(curved_rail.pictures, "__base__/graphics/entity/curved-rail/hr-", "__space-exploration-graphics__/graphics/entity/space-rail/hr/")
data_util.replace_filenames_recursive(curved_rail.pictures, "__base__/graphics/entity/rail-endings/hr-rail-endings-background.png",
  "__space-exploration-graphics__/graphics/entity/space-rail/hr/rail-endings-background.png")
data_util.replace_filenames_recursive(curved_rail.pictures, "__base__/graphics/entity/curved-rail/", "__space-exploration-graphics__/graphics/entity/space-rail/sr/")
data_util.replace_filenames_recursive(curved_rail.pictures, "__base__/graphics/entity/rail-endings/rail-endings-background.png",
  "__space-exploration-graphics__/graphics/entity/space-rail/sr/rail-endings-background.png")

local straight_rail = table.deepcopy(data.raw["straight-rail"]["straight-rail"])
straight_rail.name = data_util.mod_prefix .. "space-straight-rail"
straight_rail.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
straight_rail.icon_size = 32
straight_rail.minable = {
  mining_time = 0.2,
  result = data_util.mod_prefix .. "space-rail"
}
straight_rail.placeable_by = { count = 1, item = data_util.mod_prefix .. "space-rail"}
straight_rail.collision_mask = collision_floor
straight_rail.fast_replaceable_group = "space-rail"
straight_rail.next_upgrade = nil
--data.raw["straight-rail"]["straight-rail"].next_upgrade = straight_rail.name

data_util.replace_filenames_recursive(straight_rail.pictures, "__base__/graphics/entity/straight-rail/hr-", "__space-exploration-graphics__/graphics/entity/space-rail/hr/")
data_util.replace_filenames_recursive(straight_rail.pictures, "__base__/graphics/entity/rail-endings/hr-rail-endings-background.png",
  "__space-exploration-graphics__/graphics/entity/space-rail/hr/rail-endings-background.png")
data_util.replace_filenames_recursive(straight_rail.pictures, "__base__/graphics/entity/straight-rail/", "__space-exploration-graphics__/graphics/entity/space-rail/sr/")
data_util.replace_filenames_recursive(straight_rail.pictures, "__base__/graphics/entity/rail-endings/rail-endings-background.png",
  "__space-exploration-graphics__/graphics/entity/space-rail/sr/rail-endings-background.png")

local rail_planner = table.deepcopy(data.raw["rail-planner"]["rail"])
rail_planner.name = data_util.mod_prefix .. "space-"..rail_planner.name
rail_planner.curved_rail = curved_rail.name
rail_planner.straight_rail = straight_rail.name
rail_planner.place_result = straight_rail.name
rail_planner.localised_name = { "item-name.".. data_util.mod_prefix .. "space-rail"}
rail_planner.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
rail_planner.icon_size = 32
rail_planner.subgroup = "rail"

data:extend({
  rail_planner,
  straight_rail,
  curved_rail
})
