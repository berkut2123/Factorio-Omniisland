local BioInd = require('common')('Bio_Industries')

--~ local ICONPATH = BioInd.modRoot .. "__base__/graphics/icons/"
local ICONPATH = "__base__/graphics/icons/"
--~ local BIGICONS = BioInd.check_base_version("0.18.0")

--[[
destroyed_rail_pictures_c = function()
  return rail_pictures_internal({{"metals", "metals-remnants", mipmap = true, variations = 3, priority = "high"},
         {"backplates", "backplates-remnants", mipmap = true, variations = 3, priority = "high"},
         {"ties", "ties-remnants", variations = 3, priority = "high"},
         {"stone_path", "stone-path-remnants", variations = 3, priority = "high"},
         {"stone_path_background", "stone-path-background-remnants", variations = 3, priority = "high"}})
end

]]
data:extend(
{

  {
    type = "rail-remnants",
    name = "straight-rail-remnants",
    localised_name = {"entity-name.rail-remnants"},
    localised_description = {"entity_description.rail-remnants"},
    icon = ICONPATH .. "straight-rail-remnants.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "straight-rail-remnants.png",
        icon_size = 64,
      }
    },
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    subgroup = "remnants",
    order = "d[remnants]-b[rail]-a[straight]",
    collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
    selection_box = {{-0.6, -0.8}, {0.6, 0.8}},
    selectable_in_game = false,
    tile_width = 2,
    tile_height = 2,
    bending_type = "straight",
    pictures = destroyed_rail_pictures(),
    --pictures = destroyed_rail_pictures_c(),
    time_before_removed = 60 * 60 * 45,
    time_before_shading_off = 60 * 60 * 1
  },
  {
    type = "rail-remnants",
    name = "curved-rail-remnants",
    localised_name = {"entity-name.rail-remnants"},
    localised_description = {"entity_description.rail-remnants"},
    icon = ICONPATH .. "curved-rail-remnants.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "curved-rail-remnants.png",
        icon_size = 64,
      }
    },
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    subgroup = "remnants",
    order = "d[remnants]-b[rail]-b[curved]",
    collision_box = {{-1, -1}, {1, 1}},
    selection_box = {{-1.7, -0.8}, {1.7, 0.8}},
    selectable_in_game = false,
    tile_width = 4,
    tile_height = 8,
    bending_type = "turn",
    pictures = destroyed_rail_pictures(),
    --pictures = destroyed_rail_pictures_c(),
    time_before_removed = 60 * 60 * 45,
    time_before_shading_off = 60 * 60 * 1
  },
})
