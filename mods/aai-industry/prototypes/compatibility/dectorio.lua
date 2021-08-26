--[[
Try to keep the dectorio brick wall texture.
Progression is then:
Stone
Concrete Block
Refined Concrete
Steel
]]
local util = require("data-util")
local original_wall = require("__aai-industry__/prototypes/entity/vanilla-wall")
if data.raw.wall["dect-concrete-wall"] then
  local original_wall_pictures = table.deepcopy(original_wall.pictures) -- concrete
  local dectorio_wall_pictures = table.deepcopy(data.raw.wall["stone-wall"].pictures)
  local stone_wall_pictures = table.deepcopy(original_wall_pictures)
  util.replace_filenames_recursive(stone_wall_pictures, "__base__", "__aai-industry__")
  util.replace_filenames_recursive(stone_wall_pictures, "entity/wall", "entity/stone-wall")

  local stone_wall = data.raw.wall["stone-wall"]
  stone_wall.pictures = stone_wall_pictures
  stone_wall.icon = "__aai-industry__/graphics/icons/stone-wall.png"
  stone_wall.icon_size = 64
  stone_wall.icon_mipmaps = 1
  stone_wall.next_upgade = "dect-concrete-wall"
  stone_wall.max_health = 250
  local stone_wall_item = data.raw.item["stone-wall"]
  stone_wall_item.icon = "__aai-industry__/graphics/icons/stone-wall.png"
  stone_wall_item.icon_size = 64
  stone_wall_item.icon_mipmaps = 1

  local dectorio_wall = data.raw.wall["dect-concrete-wall"]
  dectorio_wall.pictures = dectorio_wall_pictures
  dectorio_wall.icon = "__Dectorio__/graphics/icons/stone-brick-wall.png"
  dectorio_wall.icon_size = 64
  dectorio_wall.icon_mipmaps = 1
  dectorio_wall.next_upgade = "concrete-wall"
  dectorio_wall.localised_name = {"entity-name.concrete-block-wall"}
  dectorio_wall.max_health = 400
  local dectorio_wall_item = data.raw.item["dect-concrete-wall"]
  dectorio_wall_item.icon = "__Dectorio__/graphics/icons/stone-brick-wall.png"
  dectorio_wall_item.icon_size = 64
  dectorio_wall_item.icon_mipmaps = 1
  dectorio_wall_item.localised_name = {"entity-name.concrete-block-wall"}

  data.raw.recipe["dect-concrete-wall"].ingredients = {
    {"stone-wall", 1},
    {"concrete", 4}
  }

  data.raw.recipe["dect-concrete-wall-from-stone-wall"] = nil
  util.remove_recipe_from_effects(data.raw.technology["dect-advanced-wall"].effects, "dect-concrete-wall-from-stone-wall")
  util.tech_remove_ingredients ("dect-advanced-wall", {"military-science-pack"})

  util.tech_add_ingredients ("concrete-walls", {"military-science-pack"})
  util.tech_remove_prerequisites("concrete-walls", {"stone-wall"})
  util.tech_add_prerequisites("concrete-walls", {"dect-advanced-wall"})


  local concrete_wall = data.raw.wall["concrete-wall"]
  concrete_wall.max_health = 600
  concrete_wall.localised_name = {"entity-name.refined-concrete-wall"}
  data.raw.recipe["concrete-wall"].normal.ingredients = {
    {"dect-concrete-wall", 1},
    {"iron-stick", 4},
    {"refined-concrete", 4}
  }
  data.raw.recipe["concrete-wall"].expensive.ingredients = {
    {"dect-concrete-wall", 1},
    {"iron-stick", 4},
    {"refined-concrete", 4}
  }

end
