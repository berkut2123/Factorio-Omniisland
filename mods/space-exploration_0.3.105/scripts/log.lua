Log = {}

Log.print_trace = is_debug_mode -- does trace() do game.print()?
Log.log_trace = is_debug_mode -- does trace() do log()?
Log.debug_logs = is_debug_mode -- does debug_log() do log()?
Log.debug_big_logs = is_debug_mode -- the big file oututs (astro)

function Log.debug_log(message, rel) -- use rel to filter with Log.print_trace_filter[] later
  if Log.debug_logs then log(message) end
end

function Log.trace(message, tags) -- use rel to filter with Log.print_trace_filter[] later
  if Log.log_trace then log(message) end
  if Log.print_trace then game.print("Debug: " .. message) end
end

function Log.log_global()
  game.write_file("space-exploration.global.lua", serpent.dump(global, {comment=false, sparse=true, indent = "\t", nocode=true, name="global"}), false)
end

function Log.log_universe()
  game.write_file("space-exploration.universe.lua", serpent.dump(global.universe, {comment=false, sparse=true, indent = "\t", nocode=true, name="universe"}), false)
end

function Log.log_spaceships()
  game.write_file("space-exploration.spaceships.lua", serpent.dump(global.spaceships, {comment=false, sparse=true, indent = "\t", nocode=true, name="spaceships"}), false)
end

function Log.log_universe_simplified()
  local string = ""
  for s, star in pairs(global.universe.stars) do
    string = string .. star.name .. " ("..star.stellar_position.x.." "..star.stellar_position.y..")\n"
    for p, planet in pairs(star.children) do
      if planet.orbit then
        string = string .. star.name .. " > "..planet.name ..": ".. (planet.resources and Util.values_to_string(planet.resources) or "")..
          ". Orbit: "..(planet.orbit.resources and Util.values_to_string(planet.orbit.resources) or "") .."\n"
      else
        string = string .. star.name .. " > "..planet.name ..": ".. (planet.resources and Util.values_to_string(planet.resources) or "") .."\n"
      end
      if planet.children then
        for m, moon in pairs(planet.children) do
          string = string .. star.name .. " > "..planet.name .. " > "..moon.name  ..": ".. (moon.resources and Util.values_to_string(moon.resources) or "") ..
           ". Orbit: "..(moon.orbit.resources and Util.values_to_string(moon.orbit.resources) or "") .."\n"
        end
      end
    end
  end
  for z, zone in pairs(global.universe.space_zones) do
    string = string .. zone.name .. " ("..zone.stellar_position.x.." "..zone.stellar_position.y..") "..(zone.resources and Util.values_to_string(zone.resources) or "").."\n"
  end
  game.write_file("space-exploration.universe_simplified.lua", string, false)
end

function Log.log_forces()
  game.write_file("space-exploration.forces.lua", serpent.dump(global.forces, {comment=false, sparse=true, indent = "\t", nocode=true, name="forces"}), false)
end

function Log.log_map_gen()
  local map_gens = {}
  for surface_name, surface in pairs(game.surfaces) do
    map_gens[surface_name] = surface.map_gen_settings
  end
  game.write_file("space-exploration.map_gen.lua", serpent.dump(map_gens, {comment=false, sparse=true, indent = "\t", nocode=true, name="map_gens"}), false)
end

return Log
