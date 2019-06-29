--- Crash Site
-- @module crash-site
-- NPE Scripts to set up the NPE Crash site

local map_expand = require(mod_name .. ".lualib.map_expand")
local locations = require(mod_name .. ".lualib.locations")

local site = {}

site.init = function()
  --check the correct entities exist
  local tags_to_check = {
    "wreck-1",
    "wreck-2",
    "ship-power",
    "wreck-pole",
    "automation-science-pack-wreck",
    "iron-gear-wheel-wreck",
  }

  local missing_ents = {}
  for _, tag in ipairs(tags_to_check) do
    --check these points exist
    if not game.get_entity_by_tag(tag) then
      table.insert(missing_ents,tag)
    end
  end

  if #missing_ents > 0 then
    local message = "Missing entity tags: "
    for _, tag in pairs(missing_ents) do message = message..tag.."," end
    error(message)
  end

  local main = locations.get_main_surface()
  local template = locations.get_template_surface()

  --set all cliff proxies to be indestructable
  local proxies = template.find_entities_filtered({name='cliff-proxy'})
  for _, ent in ipairs(proxies) do
    ent.force = game.forces.neutral
    ent.destructible = false
    ent.minable = false
  end

  --copy in the starting area

  local starting_area = template.get_script_areas('starting-area')[1].area

  template.clone_area(
    {
      source_area = starting_area,
      destination_area = starting_area,
      destination_surface = main,
      expand_map = false
    })
  game.forces['player'].set_spawn_position(template.get_script_positions('crash-player-spawn')[1].position,main)

  map_expand.set_surface_bounds(locations.get_main_surface(),starting_area)
end

return site


