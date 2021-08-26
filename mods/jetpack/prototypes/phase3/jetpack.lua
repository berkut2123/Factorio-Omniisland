local data_util = require("data_util")

local char_list = {}

local function remove_shadows_recursive(table)
  for k, v in pairs(table) do
    if type(v) == "table" then
      if v.draw_as_shadow or k == "flipped_shadow_running_with_gun" then
        table[k] = nil
      else
        remove_shadows_recursive(v)
      end
    end
  end
end

local function set_render_layer_recursive(table, render_layer)
  for k, v in pairs(table) do
    if type(v) == "table" then
      if v.filename then
        v.render_layer = render_layer
      end
      set_render_layer_recursive(v, render_layer)
    end
  end
end

for name, character in pairs(data.raw.character) do
  table.insert(char_list, name)
end

for _, name in pairs(char_list) do
  local copy = table.deepcopy(data.raw.character[name])
  copy.name = copy.name .."-jetpack"
  copy.running_speed = copy.running_speed / 10
  copy.collision_mask = {"not-colliding-with-itself"}
  remove_shadows_recursive(copy)
  set_render_layer_recursive(copy.animations, "air-object")
  copy.render_layer = "air-object"
  copy.footstep_particle_triggers = nil
  copy.enter_vehicle_distance = 0
  copy.localised_name = {"entity-name.jetpack-character", {"entity-name."..name}}
  copy.flags = copy.flags or {}
  copy.has_belt_immunity = true
  if copy.water_reflection then
    --copy.water_reflection.pictures.shift = {0,6} -- looks weird
    copy.water_reflection = nil
  end
  if not data_util.table_contains(copy.flags, "hidden") then
    table.insert(copy.flags, "hidden")
  end
  --log( serpent.block(copy, {comment = false, numformat = '%1.8g' } ) )
  data:extend({copy})
end

data:extend({
  {
    type = "sprite",
    name = "jetpack-shadow",
    priority = "extra-high-no-scale",
    filename = "__jetpack__/graphics/entity/character/character-shadow.png",
    width = 73,
    height = 23,
    draw_as_shadow = true,
    hr_version = {
      filename = "__jetpack__/graphics/entity/character/hr-character-shadow.png",
      width = 73*2,
      height = 23*2,
      draw_as_shadow = true,
      scale = 0.5
    }
  }
})

if data.raw.technology["fuel-processing"] and data.raw.technology["fuel-processing"].enabled then
  if data.raw.technology["jetpack-1"].prerequisites[2] == "rocket-fuel" then
    data.raw.technology["jetpack-1"].prerequisites[2] = "fuel-processing"
  end
elseif data.raw.technology["rocket-booster-1"] and data.raw.technology["rocket-booster-1"].enabled ~= false then
  -- Angels
  if data.raw.technology["jetpack-1"].prerequisites[2] == "rocket-fuel" then
    data.raw.technology["jetpack-1"].prerequisites[2] = "rocket-booster-1"
  end
end

for _, armor in pairs (data.raw.armor) do
  if armor.equipment_grid then
    local found = 0
    local grid = data.raw['equipment-grid'][armor.equipment_grid]
    --log (serpent.block (grid))
    if type (grid.equipment_categories) == 'string' and grid.equipment_categories == 'armor' then
      found = 1
      --log ('found string type')
    elseif type (grid.equipment_categories) == 'table' and #grid.equipment_categories > 0 then
      for _, category in pairs (grid.equipment_categories) do
        if category == "armor" and found ~= 2 then
          found = 1
          --log ('found table type')
        elseif category == 'armor-jetpack' then
          found = 2 -- measure to ensure that it doesn't add the category if it's already there
        end
      end
    end
    if found == 1 then
      grid.equipment_categories = grid.equipment_categories and grid.equipment_categories[1] and grid.equipment_categories or {grid.equipment_categories}
      table.insert (grid.equipment_categories, "armor-jetpack")
      --log ('second log: '..serpent.block (grid))
    end
  end
end
