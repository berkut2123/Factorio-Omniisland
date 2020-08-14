-- test map seed: 2682915831
local util = require("data-util")
local default_decal_layer = 183 -- should be replaced in data-final-fixes

--[[
Use this to make critical tiles a priortiy over placeable decorative tiles:
alien_biomes_priority_tiles = alien_biomes_priority_tiles or {}
table.insert(alien_biomes_priority_tiles, "my-tile-name")
]]
alien_biomes_priority_tiles = alien_biomes_priority_tiles or {}
-- Factorissimo2
table.insert(alien_biomes_priority_tiles, "factory-floor-1")
table.insert(alien_biomes_priority_tiles, "factory-entrance-1")
table.insert(alien_biomes_priority_tiles, "factory-pattern-1")
table.insert(alien_biomes_priority_tiles, "factory-wall-1")
table.insert(alien_biomes_priority_tiles, "factory-floor-2")
table.insert(alien_biomes_priority_tiles, "factory-entrance-2")
table.insert(alien_biomes_priority_tiles, "factory-pattern-2")
table.insert(alien_biomes_priority_tiles, "factory-wall-2")
table.insert(alien_biomes_priority_tiles, "factory-floor-3")
table.insert(alien_biomes_priority_tiles, "factory-entrance-3")
table.insert(alien_biomes_priority_tiles, "factory-pattern-3")
table.insert(alien_biomes_priority_tiles, "factory-wall-3")

local biomes = require("prototypes/biome/biomes")

-- global
alien_biomes = {}
alien_biomes.all_tiles = biomes.all_tiles
alien_biomes.require_tag = biomes.require_tag
alien_biomes.require_tags = biomes.require_tags
alien_biomes.exclude_tags = biomes.exclude_tags
alien_biomes.list_tiles = biomes.list_tiles
alien_biomes.axes = biomes.axes
alien_biomes.spec = biomes.spec
alien_biomes.tile_alias = biomes.tile_alias


require("prototypes/styles")
require("prototypes/disables")
require("prototypes/noise-layers")
require("prototypes/noise-programs")
require("prototypes/decorative/decoratives")
require("prototypes/decorative/puddle-decal")
require("prototypes/decorative/wetland-decal")
require("prototypes/decorative/rocks")
require("prototypes/decorative/lava")
require("prototypes/decorative/vegetation")
require("prototypes/decorative/vegetation-bush")
require("prototypes/decorative/vegetation-cane")
require("prototypes/decorative/crater")
require("prototypes/entity/trees")

for _, cliff in pairs(data.raw.cliff) do
  util.replace_filenames_recursive(cliff.orientations, "__base__", "__alien-biomes__")
end
