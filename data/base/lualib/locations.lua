--- Locations and Areas
-- @module locs

local locations = {}

local locations_data =
{
  patched_positions = {},
  patched_areas = {},
  patched_entities = {}
}

local allowed_positions
local allowed_areas

locations.init = function(main_name,template_name)
  global.main_surface = game.surfaces[main_name]
  global.template_surface = game.surfaces[template_name]
  global.main_surface.always_day = true
  global.template_surface.always_day = true

  global.locations_data = locations_data
end

locations.on_load = function()
  locations_data = global.locations_data or locations_data
end

locations.get_main_surface = function()
  return global.main_surface
end

locations.get_template_surface = function()
  return global.template_surface
end

locations.get_surface_ent_from_tag = function(surface,tag)
  local ent
  if locations_data.patched_entities[tag] then
    ent = locations_data.patched_entities[tag]
  else
    ent = game.get_entity_by_tag(tag)
  end

  if ent then
    local target = surface.find_entities_filtered
    {
      name = ent.name,
      position = ent.position
    }

    if target[1] then
      return target[1]
    end
  end

  return nil
end

locations.get_pos = function(pos_name)
  if allowed_positions then
    assert(allowed_positions[pos_name], "Please add " .. pos_name .. " to the allowed positions list")
  end

  if locations_data.patched_positions[pos_name] then
    return locations_data.patched_positions[pos_name]
  end

  if global.template_surface.get_script_positions(pos_name)[1] then
    return global.template_surface.get_script_positions(pos_name)[1].position
  end

  return nil
end

locations.get_area = function(area_name)
  if allowed_areas then
    assert(allowed_areas[area_name], "Please add " .. area_name .. " to the allowed areas list")
  end

  if locations_data.patched_areas[area_name] then
    return locations_data.patched_areas[area_name]
  end

  if global.template_surface.get_script_areas(area_name)[1] then
    return global.template_surface.get_script_areas(area_name)[1].area
  end
  return nil
end

locations.get_structure_in_area = function(structure_name,area_name)
  local area = locations.get_area(area_name)
  local structure = global.main_surface.find_entities_filtered({
      name=structure_name,
      area=area
    })
  return structure[1] or nil
end

locations.find_fixed_recipe_in_area = function(recipe_name,area_name)
  local area = locations.get_area(area_name)
  local structures = global.main_surface.find_entities_filtered({
      name='escape-pod-assembler',
      area=area
    })
  for _, structure in pairs(structures) do
    if structure.get_recipe().name == recipe_name then
      return structure
    end
  end
  return nil
end

locations.patch_pos = function(name, pos)
  locations_data.patched_positions[name] = pos
end

locations.patch_area = function(name, box)
  locations_data.patched_areas[name] = box
end

locations.patch_entity = function(name, entity)
  locations_data.patched_entities[name] = entity
end

locations.migrate = function()
  if global.CAMPAIGNS_VERSION < 4 then
    global.locations_data =
    {
      patched_positions = {},
      patched_areas = {},
      patched_entities = {}
    }
    locations_data = global.locations_data
  end
end

locations.verify_data = function(positions, areas)
  local missing_points = ''

  for _, name in pairs(positions) do
    if not locations.get_pos(name) then
      missing_points = missing_points .. '    ' .. name .. '\n'
    end
  end

  local missing_areas = ''
  for _, name in pairs(areas) do
    if not locations.get_area(name) then
      missing_areas = missing_areas .. '    ' .. name .. '\n'
    end
  end

  local error_message = ''

  if string.len(missing_points) > 0 then
    error_message = error_message .. '\nMissing points:\n' .. missing_points
  end
  if string.len(missing_areas) > 0 then
    error_message = error_message .. '\nMissing areas:\n' .. missing_areas
  end

  if string.len(error_message) > 0 then
    error(error_message)
  end

  allowed_positions = {}
  for _, name in pairs(positions) do
    allowed_positions[name] = {}
  end

  allowed_areas = {}
  for _, name in pairs(areas) do
    allowed_areas[name] = 1
  end
end


return locations
