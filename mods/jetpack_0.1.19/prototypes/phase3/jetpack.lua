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

if data.raw.technology["fuel-processing"] then
  if data.raw.technology["jetpack-1"].prerequisites[2] == "rocket-fuel" then
    data.raw.technology["jetpack-1"].prerequisites[2] = "fuel-processing"
  end
end
