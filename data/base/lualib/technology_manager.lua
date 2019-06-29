local technology_manager = {}
local technology_manager_data =
{
  current_technology_level = nil
}
local technology_levels

technology_manager.init = function()
  global.technology_manager_data = technology_manager_data
end

technology_manager.on_load = function(_technology_levels)
  technology_levels = _technology_levels
  technology_manager_data = global.technology_manager_data or technology_manager_data
end

technology_manager.tech_level_exists = function(level_name)
  for _, level in pairs(technology_levels) do
    if level.name == level_name then
      return true
    end
  end

  return false
end

technology_manager.discover_tech_level = function(level_name)
  if not technology_manager.tech_level_exists(level_name) then
    error("Tech level " .. level_name .. " does not exist!")
  end
  for _, level in pairs(technology_levels) do
    if level.name == level_name then
      for _, tech_name in pairs(level.techs) do
        game.forces.player.technologies[tech_name].visible_when_disabled = true
      end
    end
  end
end

technology_manager.discover_all_tech_levels = function()
  for _, level in pairs(technology_levels) do
    for _, tech_name in pairs(level.techs) do
      game.forces.player.technologies[tech_name].visible_when_disabled = true
    end
  end
end

technology_manager.set_tech_level = function(level_name)
  if not technology_manager.tech_level_exists(level_name) then
    error("Tech level " .. level_name .. " does not exist!")
  end

  technology_manager_data.current_technology_level = level_name

  for _, technology in pairs(game.forces.player.technologies) do
    technology.enabled = false
  end

  for _, level in pairs(technology_levels) do
    for _, technology in pairs(level.techs) do
      game.forces.player.technologies[technology].enabled = true
    end

    if level.name == level_name then
      break
    end
  end
end

technology_manager.research_up_to = function (level_name)
  if not technology_manager.tech_level_exists(level_name) then
    error("Tech level " .. level_name .. " does not exist!")
  end

  local found = false

  if technology_manager_data.current_technology_level then
    for _, level in pairs(technology_levels) do
      if level.name == level_name then
        found = true
        break
      end

      if level.name == technology_manager_data.current_technology_level then
        break
      end
    end
  end

  assert(found) -- make sure we are on a tech level at or above the one we are researching up to

  for _, level in pairs(technology_levels) do
    for _, technology in pairs(level.techs) do
      game.forces.player.technologies[technology].researched = true
    end

    if level.name == level_name then
      break
    end
  end
end

technology_manager.reset = function()
  technology_manager.set_tech_level(technology_manager_data.current_technology_level)
end

technology_manager.migrate_old_npe_save = function(storytable, current_node)
  print("Migrating from pre-technology manager NPE save")

  technology_manager.init()

  local check_level = function(story_node_name, tech_level)
    if story_node_name == tech_level and technology_manager.tech_level_exists(tech_level) then
      technology_manager.set_tech_level(tech_level)
    end
  end

  for _, node in pairs(storytable) do
    check_level(node.name,'explore')
    check_level(node.name,'load-lab')
    check_level(node.name,'build-radar')
    check_level(node.name,'scan-wreck')
    check_level(node.name,'rebuild')
    check_level(node.name,'military')
    check_level(node.name,'entrench')
    check_level(node.name,'fortify')
    check_level(node.name,'survive')
    check_level(node.name,'freeplay')

    if node.name == current_node then
      break
    end
  end
end

return technology_manager