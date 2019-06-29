--- Pollution setup
-- @module pollution
-- NPE Scripts to track pollution and control biter evolution

local pollution = {}

pollution.get_unspent_pollution = function()
  return global.pollution_unspent
end

pollution.spend_pollution = function(amount)
  global.pollution_unspent = global.pollution_unspent - amount
end

pollution.check_pollution = function()
  --calculate pollution from pollution statistics
  local new_pollution = (pollution.total_pollution_output() - global.last_pollution)
  global.last_pollution = pollution.total_pollution_output()

  global.pollution_unspent = global.pollution_unspent + new_pollution
  pollution.cap_evo_at_max('enemy')
end

pollution.total_pollution_output = function()
  local total_pollution = 0
  local polluters = game.pollution_statistics.input_counts
  for _, count in pairs(polluters) do
    total_pollution = total_pollution + count
  end
  return total_pollution
end

pollution.cap_evo_at_max = function(force_name)
  if global.max_evo == nil then global.max_evo = 1 end
  assert(game.forces[force_name], "pollution.cap_evo_at_max: force does not exist")
  if game.forces[force_name].evolution_factor > global.max_evo then
    game.forces[force_name].evolution_factor = global.max_evo
  end
end

pollution.set_max_evo = function(value)
  assert(value > 1 or value < 0, "pollution.set_max_evolution: value given must be between 0 and 1")
  global.max_evo = value
end

pollution.reset = function()
  global.pollution_unspent = 0
end

pollution.init = function(time,destroy,pollute,max_evo,disable_vanilla)
  --configure evolution
  global.pollution = {}
  game.map_settings.enemy_evolution.time_factor = time or 0.000004
  game.map_settings.enemy_evolution.destroy_factor = destroy or 0.002
  game.map_settings.enemy_evolution.pollution_factor = pollute or 0.0000009
  game.map_settings.enemy_evolution.enabled = true

  global.last_biter = 0
  global.biter_time = 1500
  global.hurry_radius = 5
  global.max_evo = max_evo or 1
  global.last_pollution = 0
  global.pollution_unspent = 0

  if disable_vanilla then
    game.forces.enemy.ai_controllable = false
  end
end

return pollution


