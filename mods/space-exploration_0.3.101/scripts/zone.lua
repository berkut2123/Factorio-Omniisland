local Zone = {}

-- constants
Zone.solar_multiplier = 1

Zone.discovery_scan_radius = 32
Zone.clear_enemies_radius = 512

Zone.travel_cost_interstellar = 400 -- stellar position distance, roughly 50 distance between stars, can be up to 300 apart
Zone.travel_cost_star_gravity = 500 -- roughly 10-20 base for a star
Zone.travel_cost_planet_gravity = 100 -- roughly 10-20 base for a planet
Zone.travel_cost_space_distortion = Zone.travel_cost_interstellar * 25 -- based on 0-1 range

Zone.name_tech_discover_random = mod_prefix.."zone-discovery-random"
Zone.name_tech_discover_targeted = mod_prefix.."zone-discovery-targeted"
Zone.name_tech_discover_deep = mod_prefix.."zone-discovery-deep"

-- based on alien biomes, unsure as to how ti make this more dynamic
-- biome name = {tilenames}
Zone.biome_tiles = {
  ["out-of-map"] = {"out-of-map"}, -- always allowed
  ["water"] = {"water", "deepwater", "water-green", "deepwater-green", "water-shallow", "water-mud"},

  ["dirt-purple"] = {"mineral-purple-dirt-1", "mineral-purple-dirt-2", "mineral-purple-dirt-3", "mineral-purple-dirt-4", "mineral-purple-dirt-5", "mineral-purple-dirt-6"},
  ["dirt-violet"] = {"mineral-violet-dirt-1", "mineral-violet-dirt-2", "mineral-violet-dirt-3", "mineral-violet-dirt-4", "mineral-violet-dirt-5", "mineral-violet-dirt-6"},
  ["dirt-red"] = {"mineral-red-dirt-1", "mineral-red-dirt-2", "mineral-red-dirt-3", "mineral-red-dirt-4", "mineral-red-dirt-5", "mineral-red-dirt-6"},
  ["dirt-brown"] = {"mineral-brown-dirt-1", "mineral-brown-dirt-2", "mineral-brown-dirt-3", "mineral-brown-dirt-4", "mineral-brown-dirt-5", "mineral-brown-dirt-6"},
  ["dirt-tan"] = {"mineral-tan-dirt-1", "mineral-tan-dirt-2", "mineral-tan-dirt-3", "mineral-tan-dirt-4", "mineral-tan-dirt-5", "mineral-tan-dirt-6"},
  ["dirt-aubergine"] = {"mineral-aubergine-dirt-1", "mineral-aubergine-dirt-2", "mineral-aubergine-dirt-3", "mineral-aubergine-dirt-4", "mineral-aubergine-dirt-5", "mineral-aubergine-dirt-6"},
  ["dirt-dustyrose"] = {"mineral-dustyrose-dirt-1", "mineral-dustyrose-dirt-2", "mineral-dustyrose-dirt-3", "mineral-dustyrose-dirt-4", "mineral-dustyrose-dirt-5", "mineral-dustyrose-dirt-6"},
  ["dirt-beige"] = {"mineral-beige-dirt-1", "mineral-beige-dirt-2", "mineral-beige-dirt-3", "mineral-beige-dirt-4", "mineral-beige-dirt-5", "mineral-beige-dirt-6"},
  ["dirt-cream"] = {"mineral-cream-dirt-1", "mineral-cream-dirt-2", "mineral-cream-dirt-3", "mineral-cream-dirt-4", "mineral-cream-dirt-5", "mineral-cream-dirt-6"},
  ["dirt-black"] = {"mineral-black-dirt-1", "mineral-black-dirt-2", "mineral-black-dirt-3", "mineral-black-dirt-4", "mineral-black-dirt-5", "mineral-black-dirt-6"},
  ["dirt-grey"] = {"mineral-grey-dirt-1", "mineral-grey-dirt-2", "mineral-grey-dirt-3", "mineral-grey-dirt-4", "mineral-grey-dirt-5", "mineral-grey-dirt-6"},
  ["dirt-white"] = {"mineral-white-dirt-1", "mineral-white-dirt-2", "mineral-white-dirt-3", "mineral-white-dirt-4", "mineral-white-dirt-5", "mineral-white-dirt-6"},

  ["sand-purple"] = {"mineral-purple-sand-1", "mineral-purple-sand-2", "mineral-purple-sand-3"},
  ["sand-violet"] = {"mineral-violet-sand-1", "mineral-violet-sand-2", "mineral-violet-sand-3"},
  ["sand-red"] = {"mineral-red-sand-1", "mineral-red-sand-2", "mineral-red-sand-3"},
  ["sand-brown"] = {"mineral-brown-sand-1", "mineral-brown-sand-2", "mineral-brown-sand-3"},
  ["sand-tan"] = {"mineral-tan-sand-1", "mineral-tan-sand-2", "mineral-tan-sand-3"},
  ["sand-aubergine"] = {"mineral-aubergine-sand-1", "mineral-aubergine-sand-2", "mineral-aubergine-sand-3"},
  ["sand-dustyrose"] = {"mineral-dustyrose-sand-1", "mineral-dustyrose-sand-2", "mineral-dustyrose-sand-3"},
  ["sand-beige"] = {"mineral-beige-sand-1", "mineral-beige-sand-2", "mineral-beige-sand-3"},
  ["sand-cream"] = {"mineral-cream-sand-1", "mineral-cream-sand-2", "mineral-cream-sand-3"},
  ["sand-black"] = {"mineral-black-sand-1", "mineral-black-sand-2", "mineral-black-sand-3"},
  ["sand-grey"] = {"mineral-grey-sand-1", "mineral-grey-sand-2", "mineral-grey-sand-3"},
  ["sand-white"] = {"mineral-white-sand-1", "mineral-white-sand-2", "mineral-white-sand-3"},

  ["vegetation-green"] = {"vegetation-green-grass-1", "vegetation-green-grass-2", "vegetation-green-grass-3", "vegetation-green-grass-4"},
  ["vegetation-olive"] = {"vegetation-olive-grass-1", "vegetation-olive-grass-2"},
  ["vegetation-yellow"] = {"vegetation-yellow-grass-1", "vegetation-yellow-grass-2"},
  ["vegetation-orange"] = {"vegetation-orange-grass-1", "vegetation-orange-grass-2"},
  ["vegetation-red"] = {"vegetation-red-grass-1", "vegetation-red-grass-2"},
  ["vegetation-violet"] = {"vegetation-violet-grass-1", "vegetation-violet-grass-2"},
  ["vegetation-purple"] = {"vegetation-purple-grass-1", "vegetation-purple-grass-2"},
  ["vegetation-mauve"] = {"vegetation-mauve-grass-1", "vegetation-mauve-grass-2"},
  ["vegetation-blue"] = {"vegetation-blue-grass-1", "vegetation-blue-grass-2"},
  ["vegetation-turquoise"] = {"vegetation-turquoise-grass-1", "vegetation-turquoise-grass-2"},

  ["volcanic-orange"] = {"volcanic-orange-heat-1", "volcanic-orange-heat-2", "volcanic-orange-heat-3", "volcanic-orange-heat-4"},
  ["volcanic-green"] = {"volcanic-green-heat-1", "volcanic-green-heat-2", "volcanic-green-heat-3", "volcanic-green-heat-4"},
  ["volcanic-blue"] = {"volcanic-blue-heat-1", "volcanic-blue-heat-2", "volcanic-blue-heat-3", "volcanic-blue-heat-4"},
  ["volcanic-purple"] = {"volcanic-purple-heat-1", "volcanic-purple-heat-2", "volcanic-purple-heat-3", "volcanic-purple-heat-4"},

  ["frozen-snow"] = {"frozen-snow-0", "frozen-snow-1", "frozen-snow-2", "frozen-snow-3", "frozen-snow-4"},
  ["frozen-ice"] = {"frozen-snow-5", "frozen-snow-6", "frozen-snow-7", "frozen-snow-8", "frozen-snow-9"},
}
Zone.biome_collections = {
  ["all-sand"] = {"sand-purple", "sand-violet", "sand-red", "sand-brown", "sand-tan", "sand-aubergine", "sand-dustyrose", "sand-beige", "sand-cream", "sand-black", "sand-grey", "sand-white"},
  ["all-dirt"] = {"dirt-purple", "dirt-violet", "dirt-red", "dirt-brown", "dirt-tan", "dirt-aubergine", "dirt-dustyrose", "dirt-beige", "dirt-cream", "dirt-black", "dirt-grey", "dirt-white"},
  ["all-vegetation"] = {"vegetation-green", "vegetation-olive", "vegetation-yellow", "vegetation-orange", "vegetation-red",
                        "vegetation-violet", "vegetation-purple", "vegetation-mauve", "vegetation-blue", "vegetation-turquoise" },
  ["all-volcanic"] = {"volcanic-orange", "volcanic-green", "volcanic-blue", "volcanic-purple"},
  ["all-frozen"] = {"frozen-snow", "frozen-ice"},
}
Zone.signal_to_zone_type = {
  [mod_prefix.."planet"] = "planet",
  [mod_prefix.."moon"] = "moon",
  [mod_prefix.."planet-orbit"] = "orbit",
  [mod_prefix.."moon-orbit"] = "orbit",
  [mod_prefix.."star"] = "orbit",
  [mod_prefix.."asteroid-belt"] = "asteroid-belt",
  [mod_prefix.."asteroid-field"] = "asteroid-field",
  [mod_prefix.."anomaly"] = "anomaly",
}
Zone.controls_without_frequency_multiplier = {
  "trees",
  "enemy-base"
}
-- NOTE: cliff and base terrain sliders have special settings,

--[[ eg:
biome_replacements = {
  {replace={"all-dirt", "all-sand", "all-volcanic"}, with="sand-red"},
  {replace={"all-vegetation", "all-frozen"}, with="vegetation-red"}
} ]]--

function Zone.get_default()
  return Zone.from_name("Nauvis")
end

function Zone.get_force_home_zone(force_name)
  if global.forces[force_name] and global.forces[force_name].homeworld_index then
    return Zone.from_zone_index(global.forces[force_name].homeworld_index)
  end
end

function Zone.type_title(zone)
  if zone.type == "planet" then
    return "Planet"
  elseif zone.type == "moon" then
    return "Moon"
  elseif zone.type == "star" then
    return "Star"
  elseif zone.type == "asteroid-field" then
    return "Asteroid Field"
  elseif zone.type == "asteroid-belt" then
    return "Asteroid Belt"
  elseif zone.type == "anomaly" then
    return "Anomaly"
  elseif zone.type == "spaceship" then
    return "Spaceship"
  elseif zone.type == "orbit" then
    return (Zone.type_title(zone.parent) .. " Orbit")
  end
end

function Zone.get_signal_name(zone)
  -- used for rich text
  if zone.type == "orbit" and zone.parent.type == "star" then
    return mod_prefix.."star"
  elseif zone.type == "orbit" and zone.parent.type == "planet" then
    return mod_prefix.."planet-orbit"
  elseif zone.type == "orbit" and zone.parent.type == "moon" then
    return mod_prefix.."moon-orbit"
  else
    return mod_prefix..zone.type
  end
end

function Zone.get_icon(zone)
  -- used for rich text
  return "virtual-signal/" .. Zone.get_signal_name(zone)
end

function Zone.is_solid(zone)
  return zone.type == "planet" or zone.type == "moon"
end

function Zone.is_space(zone)
  return not Zone.is_solid(zone)
end

function Zone.from_zone_index(zone_index)
  return global.zone_index[zone_index]
end

function Zone.from_name(name)
    return global.zones_by_name[name]
end

function Zone.from_surface_index(surface_index)
  return global.zones_by_surface[surface_index]
end

function Zone.from_surface(surface)
  local from_index = Zone.from_surface_index(surface.index)
  if from_index then return from_index end
  -- maybe a spaceship
  return Spaceship.from_own_surface_index(surface.index)
end

function Zone.get_stellar_position(zone)
  if not zone then return nil end
  if zone.type == "anomaly" then return {x = 0, y = 0} end
  -- everything else should have a stellar position
  return zone.stellar_position or Zone.get_stellar_position(zone.parent)
end

function Zone.get_star_gravity_well(zone)
  if zone.type == "orbit" then
      return Zone.get_star_gravity_well(zone.parent)
  end
  return zone.star_gravity_well or 0
end

function Zone.get_planet_gravity_well(zone)
  if zone.type == "orbit" then
    if zone.parent.type == "planet" then
      return Zone.get_planet_gravity_well(zone.parent) - 1
    else
      return Zone.get_planet_gravity_well(zone.parent) - 0.5
    end
  end
  return zone.planet_gravity_well or 0
end

function Zone.get_space_distortion(zone) -- anomaly
  if zone.space_distortion then
    return zone.space_distortion
  end
  return zone.type == "anomaly" and 1 or 0
end

function Zone.apply_markers(zone)
  for force_name, force_data in pairs(global.forces) do
    if force_data.zones_discovered[zone.name] then
      if not force_data.zones_discovered[zone.name].marker and force_data.zones_discovered[zone.name].marker.valid then
        local surface = Zone.get_surface(zone)
        if surface then
          force_data.zones_discovered[zone.name].marker = force.add_chart_tag(surface, {
            icon = {type = "virtual", name = mod_prefix .. (zone.type == "orbit" and zone.parent.type or zone.type)},
            position = tag.position,
            text = zone.name
          })
        end
      end
    end
  end
end

function Zone.validate_controls_and_error(controls)
  if controls then
    for name, control in pairs(controls) do
      if type(name) ~= "string" then
        error(serpent.block(name))
      end
    end
  end
end

function Zone.validate_controls(controls)
  if controls then
    for name, control in pairs(controls) do
      if type(name) ~= "string" then
        controls[name] = nil
      end
    end
  end
end

function Zone.apply_controls_to_mapgen(zone, controls, mapgen)
  Zone.validate_controls(controls)
  local frequency_multiplier = Zone.get_frequency_multiplier(zone)
  for name, control in pairs(controls) do
    if type(name) == "string" then
      if name == "moisture" then
        mapgen.property_expression_names = mapgen.property_expression_names or {}
        if control.frequency then
          mapgen.property_expression_names["control-setting:moisture:frequency:multiplier"] = control.frequency
        end
        if control.bias then
          mapgen.property_expression_names["control-setting:moisture:bias"] = control.bias
        end
      elseif name == "aux" then
        mapgen.property_expression_names = mapgen.property_expression_names or {}
        if control.frequency then
          mapgen.property_expression_names["control-setting:aux:frequency:multiplier"] = control.frequency
        end
        if control.bias then
          mapgen.property_expression_names["control-setting:aux:bias"] = control.bias
        end
      elseif name == "water" then
        if control.frequency then
          mapgen.terrain_segmentation = control.frequency
        end
        if control.size then
          mapgen.water = control.size
        end
      elseif name == "cliff" then
        mapgen.cliff_settings = mapgen.cliff_settings or {
    			name="cliff",
    			cliff_elevation_0=10, -- default
    			cliff_elevation_interval=400, -- when set from the GUI the value is 40 / frequency.
    			richness=0, -- 0.17 to 6.
        }
        if control.frequency then
          mapgen.cliff_settings.cliff_elevation_interval = 40 / control.frequency
          mapgen.cliff_settings.cliff_elevation_0 = mapgen.cliff_settings.cliff_elevation_interval / 4
        end
        if control.richness then
          mapgen.cliff_settings.richness = richness
        end
      else
        if game.autoplace_control_prototypes[name] then
          mapgen.autoplace_controls[name] = table.deepcopy(control)
          if mapgen.autoplace_controls[name].frequency and not Util.table_contains(Zone.controls_without_frequency_multiplier, name) then
            mapgen.autoplace_controls[name].frequency = mapgen.autoplace_controls[name].frequency * frequency_multiplier
          end
        else
          log("Zone.apply_controls_to_mapgen: Attempt to apply invalid control name to mapgen: "..name)
          controls[name] = nil
        end
      end
    end
  end
end

function Zone.get_frequency_multiplier(zone)
  if zone.radius then
    return 5000 / zone.radius
  end
  return 1
end

function Zone.create_surface(zone)

    if not zone.surface_index then

      Universe.inflate_climate_controls(zone, false)

      -- TODO planets should have customised controls

      local map_gen_settings = table.deepcopy(game.default_map_gen_settings)
      if not zone.seed then zone.seed = math.random(4294967295) end
      map_gen_settings.seed = zone.seed

      local autoplace_controls = map_gen_settings.autoplace_controls
      zone.controls = zone.controls or {}

      local frequency_multiplier = Zone.get_frequency_multiplier(zone) -- increase for small planets and moons

      -- For all possible controls set values so it can be regenreated consistently.
      for control_name, control_prototype in pairs(game.autoplace_control_prototypes) do
        if control_name ~= "planet-size" and game.autoplace_control_prototypes[control_name] then
          zone.controls[control_name] = zone.controls[control_name] or {}
          zone.controls[control_name].frequency = (zone.controls[control_name].frequency or (0.17 + math.random() * math.random() * 2))
          zone.controls[control_name].size = zone.controls[control_name].size or (0.1 + math.random() * 0.8)
          zone.controls[control_name].richness = zone.controls[control_name].richness or (0.1 + math.random() * 0.8)
        end
      end

      zone.controls.moisture = zone.controls.moisture or {}
      zone.controls.moisture.frequency = (zone.controls.moisture.frequency or (0.17 + math.random() * math.random() * 2))
      zone.controls.moisture.bias = zone.controls.moisture.bias or (math.random() - 0.5)

      zone.controls.aux = zone.controls.aux or {}
      zone.controls.aux.frequency = (zone.controls.aux.frequency or (0.17 + math.random() * math.random() * 2))
      zone.controls.aux.bias = zone.controls.aux.bias or (math.random() - 0.5)

      zone.controls.cliff = zone.controls.cliff or {}
      zone.controls.cliff.frequency = (zone.controls.cliff.frequency or (0.17 + math.random() * math.random() * 10)) --
      zone.controls.cliff.richness  = zone.controls.cliff.richness  or (math.random() * 1.25)

      --[[
      map_gen_settings.property_expression_names = {
        ["control-setting:moisture:frequency:multiplier"] = zone.controls.moisture.frequency * frequency_multiplier,
        ["control-setting:moisture:bias"] = zone.controls.moisture.bias,
        ["control-setting:aux:frequency:multiplier"] = zone.controls.aux.frequency * frequency_multiplier,
        ["control-setting:aux:bias"] = zone.controls.aux.bias,
      }
      zone.controls.water = zone.controls.water or {}
      zone.controls.water.size = zone.controls.water.size or 0.01 -- high is 6, low is 0
      zone.controls.water.frequency = (zone.controls.water.frequency or 1) -- low is 0.17
      zone.controls.water.frequency = 0.5 + zone.controls.water.frequency / 2
      map_gen_settings.water = zone.controls.water.size
      map_gen_settings.terrain_segmentation = zone.controls.water.frequency
      ]]--
      Zone.apply_controls_to_mapgen(zone, zone.controls, map_gen_settings)

      autoplace_controls["planet-size"] = { frequency = 1, size = 1 } -- default
      -- planet_radius = 10000 / 6 * (6 + log(1/planet_frequency/6, 2))
      -- planet_frequency = 1 / 6 / 2 ^ (planet_radius * 6 / 10000 - 6)
      local planet_size_frequency = 1/6 -- 10000 radius planet
      if Zone.is_solid(zone) then
        -- planet or moon
        --planet_size_frequency = 1 / (zone.radius / 10000)
        planet_size_frequency = 1 / 6 / 2 ^ (zone.radius * 6 / 10000 - 6)
        local penalty = -100000
        if zone.tags and util.table_contains(zone.tags, "water_none") then
          map_gen_settings.property_expression_names["tile:deepwater:probability"] = penalty
          map_gen_settings.property_expression_names["tile:water:probability"] = penalty
          map_gen_settings.property_expression_names["tile:water-shallow:probability"] = penalty
          map_gen_settings.property_expression_names["tile:water-mud:probability"] = penalty
        end
        map_gen_settings.property_expression_names["decorative:se-crater3-huge:probability"] = penalty
        if not zone.is_homeworld then
          map_gen_settings.starting_area = 0.5
        end
      else
        if zone.type == "orbit" then
          autoplace_controls["planet-size"].size = zone.parent.radius and (zone.parent.radius / 200) or 50
        elseif zone.type == "asteroid-belt" then
          autoplace_controls["planet-size"].size = 200
        elseif zone.type == "asteroid-field" then
          autoplace_controls["planet-size"].size = 10000
        end

        planet_size_frequency = 1/1000
        map_gen_settings.cliff_settings={
    			name="cliff",
    			cliff_elevation_0=10, -- default
    			cliff_elevation_interval=400, -- when set from the GUI the value is 40 / frequency.
    			richness=0, -- 0.17 to 6.
    		}
        map_gen_settings.property_expression_names = {
          ["control-setting:moisture:frequency:multiplier"] = 10,
          ["control-setting:moisture:bias"] = -1,
          ["control-setting:aux:frequency:multiplier"] = 0,
          ["control-setting:aux:bias"] = 0,
        }
        map_gen_settings.starting_area = 0
      end
      autoplace_controls["planet-size"].frequency = planet_size_frequency

      Log.debug_log("Creating surface " .. zone.name .. " with map_gen_settings:")
      Log.debug_log(util.table_to_string(map_gen_settings))
      if Zone.is_space(zone) then
        -- Speed up terrain generation by excluding everything not specifically allowed to spawn
        --map_gen_settings.default_enable_all_autoplace_controls = false
        map_gen_settings.autoplace_settings={
          ["decorative"]={
            treat_missing_as_default=false,
            settings={
              ["se-crater3-huge"] ={},
              ["se-crater1-large-rare"] ={},
              ["se-crater1-large"] ={},
              ["se-crater2-medium"] ={},
              ["se-crater4-small"] ={},
              ["se-sand-decal-space"] ={},
              ["se-stone-decal-space"] ={},
              ["se-rock-medium-asteroid"] ={},
              ["se-rock-small-asteroid"] ={},
              ["se-rock-tiny-asteroid"] ={},
              ["se-sand-rock-medium-asteroid"] ={},
              ["se-sand-rock-small-asteroid"] ={}
            }
          },
          --[[["entity"]={
            treat_missing_as_default=false,
            settings={
              ["se-rock-huge-asteroid"] ={},
              ["se-rock-big-asteroid"] ={},
              ["se-sand-rock-big-asteroid"] ={},
              ["se-rock-huge-space"] ={},
              ["se-rock-big-space"] ={},
            }
          },]]--
          ["tile"]={
            treat_missing_as_default=false,
            settings={
              ["se-asteroid"]={},
              ["se-space"]={}
            }
          },
        }
      else
        -- speed up terrain generation by specifying specific things not to spawn
        local penalty = -100000
        map_gen_settings.property_expression_names["decorative:se-crater3-huge:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-crater1-large-rare:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-crater1-large:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-crater2-medium:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-crater4-small:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-sand-decal-space:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-stone-decal-space:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-rock-medium-asteroid:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-rock-small-asteroid:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-rock-tiny-asteroid:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-sand-rock-medium-asteroid:probability"] = penalty
        map_gen_settings.property_expression_names["decorative:se-sand-rock-small-asteroid:probability"] = penalty

        map_gen_settings.property_expression_names["entity:se-rock-huge-asteroid:probability"] = penalty
        map_gen_settings.property_expression_names["entity:se-rock-big-asteroid:probability"] = penalty
        map_gen_settings.property_expression_names["entity:se-sand-rock-big-asteroid:probability"] = penalty
        map_gen_settings.property_expression_names["entity:se-rock-huge-space:probability"] = penalty
        map_gen_settings.property_expression_names["entity:se-rock-big-space:probability"] = penalty

        map_gen_settings.property_expression_names["tile:se-asteroid:probability"] = penalty
        map_gen_settings.property_expression_names["tile:se-space:probability"] = penalty
      end

      local surface
      if not game.surfaces[zone.name] then
        surface = game.create_surface(zone.name, map_gen_settings)
        surface.force_generate_chunk_requests()

      else
        -- this happens if the mod was uninstalled and reinstalled. The surface will be invalid and unfaxable.
        -- game.delete_surface(zone.name) -- does not work in time to re make the surface
        surface = game.surfaces[zone.name]
        surface.clear(false)

      end


      zone.surface_index = surface.index
      global.zones_by_surface = global.zones_by_surface or {}
      global.zones_by_surface[surface.index] = zone

      Zone.set_solar_and_daytime(zone)

      if zone.type == "planet" then
        if not zone.glyph then
          Ancient.assign_zone_next_glyph(zone)
        end
        Ancient.make_vault_exterior(zone) -- only makes the vault if glyph exists
      end

      if zone.type == "anomaly" then
        Ancient.make_gate(Ancient.gate_default_position)
        Ruin.build({ruin_name = "galaxy-ship", surface_index = surface.index,  position = Ancient.galaxy_ship_default_position})
      end

    end
end


function Zone.get_star_from_child(zone)
  if zone.type == "star" then
    return zone
  elseif zone.parent then
    return Zone.get_star_from_child(zone.parent)
  end
end

function Zone.get_solar(zone) -- can be spaceship too
  -- return the actual expected light % including daytime for space zones and spaceships.
  -- return peak expected light % space solid zones.

  if zone.type == "anomaly" then
    return 0
  end

  local star
  local star_gravity_well = 0

  if zone.type == "spaceship" then
    star = zone.near_star
    star_gravity_well = zone.star_gravity_well or 0
  else
    star = Zone.get_star_from_child(zone)
    star_gravity_well = Zone.get_star_gravity_well(zone)
  end

  local light_percent = 0.01
  if star then
    light_percent = 0.01 + 1.6 * star_gravity_well / (star.star_gravity_well + 1)
  end

  if Zone.is_space(zone) then

    if zone.type == "spaceship" then
      light_percent = light_percent + 0.09 * math.min(1, star_gravity_well) -- base of 10% only in star systems, fades out between last planet and interstellar
    elseif zone.type ~= "asteroid-field" then
      light_percent = light_percent + 0.09 -- base of 10%
    end

    if(zone.type == "orbit" and zone.parent and zone.parent.type == "star") then -- star
      light_percent = light_percent * 10 -- x20
    elseif zone.type == "asteroid-belt" then
      light_percent = light_percent * 2.5 -- x5
    else
      light_percent = light_percent * 5 -- x10
      if zone.parent and zone.parent.radius then
        light_percent = light_percent * (1 - 0.1 * zone.parent.radius / 10000)
      end
    end
  else
    if zone.radius then
      light_percent = light_percent * (1 - 0.1 * zone.radius / 10000)
      if zone.is_homeworld then
        light_percent = 1
      end
    end
  end

  if zone.space_distortion and zone.space_distortion > 0 then

    light_percent = light_percent * (1 - zone.space_distortion)

    if zone.is_homeworld then
      light_percent = 1
    end
  end

  return light_percent
end

function Zone.get_display_light_percent(zone)
  return Zone.get_solar(zone)
end

function Zone.set_solar_and_daytime(zone)
  local surface = Zone.get_surface(zone)
  if not surface then return end

  if zone.type == "anomaly" then
    surface.solar_power_multiplier = 0
    surface.daytime = 0.5
    return
  end

  local light_percent = Zone.get_solar(zone)

  if Zone.is_space(zone) then

    -- light_percent is the total output
    -- but we have most space zones daylight ranging from mid evening to night so that lights are active.
    -- so that is the main driving factor.
    -- except stars.

    surface.freeze_daytime = true

    if zone.type == "orbit" and zone.parent.type == "star" then

      surface.daytime = 0 -- very bright
      surface.solar_power_multiplier = Zone.solar_multiplier * light_percent

    else

      if light_percent >= 0.5 then
        surface.daytime = 0.35 -- half light
        surface.solar_power_multiplier = Zone.solar_multiplier * light_percent * 2 -- x2 compensate for half light
      else
        surface.daytime = 0.45 - 0.2 * light_percent
        surface.solar_power_multiplier = Zone.solar_multiplier -- x2 compensate for half light max
        -- light_percent of 1 would be 0.35 (half-light),
        -- light_percent of 0 would be 0.45 (dark)
      end

    end

  else
    -- planet or moon
    -- has daytime

    surface.daytime = (game.tick / zone.ticks_per_day) % 1
    surface.solar_power_multiplier = Zone.solar_multiplier * light_percent

    if zone.ticks_per_day then
      surface.ticks_per_day = zone.ticks_per_day
    end

  end

  if zone.type == "anomaly" then
    surface.solar_power_multiplier = 0
    surface.daytime = 0.45
  end

end

function Zone.get_flags_weight(zone, force_name, playerdata)
  local weight = (
    ((playerdata.track_glyphs and zone.glyph) and 0.96 or 0)
    + ((playerdata.visited_zone and playerdata.visited_zone[zone.index]) and 0.97 or 0)
    + ((global.forces[force_name].zone_assets and global.forces[force_name].zone_assets[zone.index] and table_size(global.forces[force_name].zone_assets[zone.index].rocket_landing_pad_names) > 0) and 0.98 or 0)
    + ((global.forces[force_name].zone_assets and global.forces[force_name].zone_assets[zone.index] and table_size(global.forces[force_name].zone_assets[zone.index].rocket_launch_pad_names) > 0) and 1 or 0)
  )
  Log.debug_log("Zone.get_flags_weight " .. zone.name.." " ..weight, "zone")
  return weight
end

function Zone.get_surface(zone) -- returns surface but does not build
  if zone.type == "spaceship" then
    return Spaceship.get_current_surface(zone)
  end
  if zone.surface_index then
    return game.get_surface(zone.surface_index)
  end
  return nil
end

function Zone.get_make_surface(zone)
  if zone.type == "spaceship" then
    return Spaceship.get_current_surface(zone)
  end
  if not zone.surface_index then Zone.create_surface(zone) end
  return game.get_surface(zone.surface_index)
end

function Zone.discover(force_name, zone, source) -- source could be "Satellite "
  global.forces[force_name] = global.forces[force_name] or {}
  global.forces[force_name].zones_discovered = global.forces[force_name].zones_discovered or {}
  global.forces[force_name].zones_discovered_count = global.forces[force_name].zones_discovered_count or 0

  if not global.forces[force_name].zones_discovered[zone.index] then

      Universe.inflate_climate_controls(zone, false)

      global.forces[force_name].zones_discovered[zone.index] = {
        discovered_at = game.tick,
        marker = nil
      }
      global.forces[force_name].zones_discovered_count = global.forces[force_name].zones_discovered_count + 1
      if zone.type == "planet" and not zone.glyph then
        Ancient.assign_zone_next_glyph(zone)
      end

      local message = nil
      if source then
        message = {"space-exploration.source-discovered-zone", source, Zone.type_title(zone), Zone.get_icon(zone), zone.name}
        --game.forces[force_name].print(source .. " discovered a new " .. Zone.type_title(zone) .. ": " .. zone.name)
      else
        message = {"space-exploration.discovered-zone", source, Zone.type_title(zone), Zone.get_icon(zone), zone.name}
        --game.forces[force_name].print("Discovered a new " .. Zone.type_title(zone) .. ": " .. zone.name)
      end
      local tick_task = new_tick_task("force-message")
      tick_task.force_name = force_name
      tick_task.message = message

      Zone.apply_markers(zone) -- in case the surface exists

      for _, player in pairs(game.connected_players) do
        if Zonelist.get_main_window(player.index) then
          Zonelist.gui_update_list(player.index)
        end
      end

      if zone.type == "anomaly" then
        local tick_task = new_tick_task("force-message")
        tick_task.force_name = force_name
        tick_task.message = {"space-exploration.discovered-anomaly-additional"}
        tick_task.delay_until = game.tick + 300 --5s
      end

      if zone.glyph then
        local force = game.forces[force_name]
        for _, player in pairs(force.players) do
          if player.connected then
            local playerdata = get_make_playerdata(player)
            if playerdata.track_glyphs then
              player.print({"space-exploration.discovered-glyph-vault", zone.name})
            end
          end
        end
      end

      return true

  end
  return false
end

function Zone.discover_next_research(force_name, source, allow_targeted)
  global.forces[force_name] = global.forces[force_name] or {}
  global.forces[force_name].zones_discovered = global.forces[force_name].zones_discovered or {}
  global.forces[force_name].zones_discovered_count = global.forces[force_name].zones_discovered_count or 0

  local target_resource = "n/a"
  if allow_targeted then
    target_resource = global.forces[force_name].search_for_resource
  end

  local can_discover = {}
  local can_discover_targeted = {}

  -- star and deep space discovery should be bias to nearer positions
  local closest_1 = nil
  local closest_stellar_distance = 1000000
  local pos1 = {x = 0, y = 0} -- focus on aeras close to the center of the star map

  for _, star in pairs(global.universe.stars) do
    if not global.forces[force_name].zones_discovered[star.index] then
      local pos2 = Zone.get_stellar_position(star)
      local distance = util.vectors_delta_length(pos1, pos2)
      if distance < closest_stellar_distance then
        closest_stellar_distance = distance
        closest_1 = star
      end
    end
  end

  if closest_1 then
    -- x5
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
  end

  for _, star in pairs(global.universe.stars) do
    if global.forces[force_name].zones_discovered[star.index] then
      for _, planet in pairs(star.children) do
        if not global.forces[force_name].zones_discovered[planet.index] then
          if planet.primary_resource == target_resource then
            table.insert(can_discover_targeted, planet)
            if planet.type == "planet" then
              --x5 bias towards planets
              table.insert(can_discover_targeted, planet)
              table.insert(can_discover_targeted, planet)
              table.insert(can_discover_targeted, planet)
              table.insert(can_discover_targeted, planet)
            end
          else
            table.insert(can_discover, planet)
            if planet.type == "planet" then
              --x5 bias towards planets
              table.insert(can_discover, planet)
              table.insert(can_discover, planet)
              table.insert(can_discover, planet)
              table.insert(can_discover, planet)
            end
          end
        else
          if planet.children then
            for _, moon in pairs(planet.children) do
              if not global.forces[force_name].zones_discovered[moon.index] then
                if moon.primary_resource == target_resource then
                  table.insert(can_discover_targeted, moon)
                else
                  table.insert(can_discover, moon)
                end
              end
            end
          end
        end
      end
    end
  end

  if #can_discover_targeted > 0 then
    return Zone.discover(force_name, Util.random_from_array(can_discover_targeted), source)
  end
  if #can_discover > 0 then
    return Zone.discover(force_name, Util.random_from_array(can_discover), source)
  end

end

function Zone.discover_next_research_deep_space(force_name, source, allow_targeted)
  global.forces[force_name] = global.forces[force_name] or {}
  global.forces[force_name].zones_discovered = global.forces[force_name].zones_discovered or {}
  global.forces[force_name].zones_discovered_count = global.forces[force_name].zones_discovered_count or 0

  if game.forces[force_name].technologies[Zone.name_tech_discover_deep].level > 11 then
    -- should have discovered multiple stars at this point
    if not global.forces[force_name].zones_discovered[global.universe.anomaly.index] then
      return Zone.discover(force_name, global.universe.anomaly, source)
    end
  end

  local target_resource = "n/a"
  if allow_targeted then
    target_resource = global.forces[force_name].search_for_resource
  end

  local can_discover = {}
  local can_discover_targeted = {}
  for _, zone in pairs(global.universe.space_zones) do
    if not global.forces[force_name].zones_discovered[zone.index] then
      if zone.primary_resource == target_resource then
        table.insert(can_discover_targeted, zone)
      else
        table.insert(can_discover, zone)
      end
    end
  end

  if #can_discover_targeted > 0 then
    return Zone.discover(force_name, Util.random_from_array(can_discover_targeted), source)
  end
  if #can_discover > 0 then
    return Zone.discover(force_name, Util.random_from_array(can_discover), source)
  end
end

function Zone.discover_next_satellite(force_name, source, system_restriction)
  global.forces[force_name] = global.forces[force_name] or {}
  global.forces[force_name].zones_discovered = global.forces[force_name].zones_discovered or {}
  global.forces[force_name].zones_discovered_count = global.forces[force_name].zones_discovered_count or 0

  if system_restriction then
    local star = system_restriction
    while star.parent do
      star = star.parent
    end
    local last_valid
    if star.children then
      for _, planet in pairs(star.children) do
        if not global.forces[force_name].zones_discovered[planet.index] then
          if math.random() < 0.5 then -- skip it
            last_valid = planet
          else
            return Zone.discover(force_name, planet, source)
          end
        elseif planet.children then
          for _, moon in pairs(planet.children) do
            if not global.forces[force_name].zones_discovered[moon.index] then
              if math.random() < 0.5 then -- skip it
                last_valid = moon
              else
                return Zone.discover(force_name, moon, source)
              end
            end
          end
        end
      end
    end
    --skipped too much
    if last_valid then
      return Zone.discover(force_name, last_valid, source)
    end
    -- find stars now
    local closest_1 = nil
    local closest_stellar_distance = 1000000
    local pos1 = Zone.get_stellar_position(star)

    for _, star2 in pairs(global.universe.stars) do
      if not global.forces[force_name].zones_discovered[star2.index] then
        local pos2 = Zone.get_stellar_position(star2)
        local distance = util.vectors_delta_length(pos1, pos2)
        if distance < closest_stellar_distance then
          closest_stellar_distance = distance
          closest_1 = star2
        end
      end
    end
    if closest_1 then
      return Zone.discover(force_name, closest_1, source)
    end
    return false
  end

end

--[[
function Zone.discover_next(force_name, source, allow_targeted)
  global.forces[force_name] = global.forces[force_name] or {}
  global.forces[force_name].zones_discovered = global.forces[force_name].zones_discovered or {}
  global.forces[force_name].zones_discovered_count = global.forces[force_name].zones_discovered_count or 0

  local nauvis_zone = Zone.from_name("Nauvis")

  -- Nauvis Moons
  if global.forces[force_name].zones_discovered_count < 3 or math.random() < 0.5 then
    for _, moon in pairs(nauvis_zone.children) do
      if not global.forces[force_name].zones_discovered[moon.index] then
        if math.random() < 0.5 then -- skip it
            return Zone.discover(force_name, moon, source)
        end
      end
    end
  end

  -- Calidus planets & moons
  for _, planet in pairs(nauvis_zone.parent.children) do
    if math.random() < 0.5 then -- skip it
      if not global.forces[force_name].zones_discovered[planet.index] then
          return Zone.discover(force_name, planet, source)
      elseif planet.children then
        for _, moon in pairs(planet.children) do
          if not global.forces[force_name].zones_discovered[moon.index] then
            if math.random() < 0.5 then -- skip it
                return Zone.discover(force_name, moon, source)
            end
          end
        end
      end
    end
  end

  if global.forces[force_name].zones_discovered_count >= 99 then
    -- should have discovered multiple stars at this point
    if not global.forces[force_name].zones_discovered[global.universe.anomaly.index] then
      return Zone.discover(force_name, global.universe.anomaly, source)
    end
  end

  -- random next thing
  local can_discover = {}

  -- star and deep space discovery should be bias to nearer positions
  local closest_1 = nil
  local closest_stellar_distance = 1000000
  local nauvis_stellar_position = Zone.get_stellar_position(nauvis_zone)

  for _, star in pairs(global.universe.stars) do
    if not global.forces[force_name].zones_discovered[star.index] then
      local pos2 = Zone.get_stellar_position(star)
      local distance = util.vectors_delta_length(nauvis_stellar_position, pos2)
      if distance < closest_stellar_distance then
        closest_stellar_distance = distance
        closest_1 = star
      end
    end
  end

  for _, zone in pairs(global.universe.space_zones) do
    if not global.forces[force_name].zones_discovered[zone.index] then
      local pos2 = Zone.get_stellar_position(zone)
      local distance = util.vectors_delta_length(nauvis_stellar_position, pos2)
      if closest_1 == nil or distance < closest_stellar_distance then
        closest_stellar_distance = distance
        closest_1 = zone
      end
    end
  end

  if closest_1 then
    -- x10
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
    table.insert(can_discover, closest_1)
  end

  for _, star in pairs(global.universe.stars) do
    if global.forces[force_name].zones_discovered[star.index] then
      for _, planet in pairs(star.children) do
        if not global.forces[force_name].zones_discovered[planet.index] then
          table.insert(can_discover, planet)
          if planet.type == "planet" then
            --x5 bias towards planets
            table.insert(can_discover, planet)
            table.insert(can_discover, planet)
            table.insert(can_discover, planet)
            table.insert(can_discover, planet)
          end
        else
          if planet.children then
            for _, moon in pairs(planet.children) do
              if not global.forces[force_name].zones_discovered[moon.index] then
                table.insert(can_discover, moon)
              end
            end
          end
        end
      end
    end
  end

  local space_zones = 0
  for _, zone in pairs(global.universe.space_zones) do
    if not global.forces[force_name].zones_discovered[zone.index] then
      if space_zones < 5 then
        space_zones = space_zones + 1
        table.insert(can_discover, zone)
      end
    end
  end

  if #can_discover > 0 then
    return Zone.discover(force_name, Util.random_from_array(can_discover), source)
  end

end
]]--

function Zone.find_nearest_stellar_object(stellar_position)
  local closest_distance = math.huge
  local closest = nil

  for _, star in pairs(global.universe.stars) do
    local distance = util.vectors_delta_length(star.stellar_position, stellar_position)
    if distance < closest_distance then
      closest_distance = distance
      closest = star
    end
  end

  for _, star in pairs(global.universe.space_zones) do
    local distance = util.vectors_delta_length(star.stellar_position, stellar_position)
    if distance < closest_distance then
      closest_distance = distance
      closest = star
    end
  end
  return closest
end

function Zone.find_nearest_star(stellar_position)
  local closest_distance = math.huge
  local closest = nil

  for _, star in pairs(global.universe.stars) do
    local distance = util.vectors_delta_length(star.stellar_position, stellar_position)
    if distance < closest_distance then
      closest_distance = distance
      closest = star
    end
  end
  return closest
end

function Zone.find_nearest_zone(space_distortion, stellar_position, star_gravity_well, planet_gravity_well)

  if space_distortion > 0.4 then return global.universe.anomaly end -- default from the anomaly

  local star = Zone.find_nearest_stellar_object(stellar_position) -- can be asteroid field
  if star_gravity_well > 0 then
    local closest_zone = star
    local closest_distance =  math.abs((star.star_gravity_well or 0) - star_gravity_well)
    if closest_zone.type == "star" then
      for _, planet in pairs(star.children) do
        local distance = math.abs(planet.star_gravity_well - star_gravity_well)
        if distance < closest_distance then
          closest_distance = distance
          closest_zone = planet
        end
      end
    end

    if closest_zone.type == "planet" then
      local closest_zone2 = closest_zone
      closest_distance =  math.abs(closest_zone.planet_gravity_well - planet_gravity_well)
      for _, moon in pairs(closest_zone.children) do
        if moon.type == "moon" then
          local distance = math.abs(moon.planet_gravity_well - planet_gravity_well)
          if distance < closest_distance then
            closest_distance = distance
            closest_zone2 = moon
          end
        end
      end
      return closest_zone2
    end
    return closest_zone
  else
    if not star then return global.universe.anomaly end
    if not star.children then return star end
    local last_child = star.children[#star.children]
    if last_child.children then
      last_child = last_child.children[#last_child.children]
    end
    return last_child
  end
  return Zone.get_default()

end

function Zone.find_nearest_solid_zone(space_distortion, stellar_position, star_gravity_well, planet_gravity_well, allow_moon)
  if space_distortion == 1 then return Zone.get_default() end -- default from the anomaly

  if planet_gravity_well == 0 then -- if no moon
    planet_gravity_well = 100000 -- high to land on planet
  end

  if star_gravity_well == 0 then -- if no planet
    star_gravity_well = 100000 -- high to land on planet with high solar
  end

  local star = Zone.find_nearest_star(stellar_position)
  if not star then return Zone.get_default() end

  local closest_planet = nil
  local closest_distance = math.huge
  for _, planet in pairs(star.children) do
    if planet.type == "planet" then -- not an asteroid belt
      local distance = math.abs(planet.star_gravity_well - star_gravity_well)
      if distance < closest_distance then
        closest_distance = distance
        closest_planet = planet
      end
    end
  end

  if not closest_planet then return Zone.get_default() end

  local closest_body = closest_planet -- default to planet

  if allow_moon then
    closest_distance =  math.abs(closest_body.planet_gravity_well - planet_gravity_well)
    -- see if a moon is closer
    for _, moon in pairs(closest_planet.children) do
      if moon.type == "moon" then
        local distance = math.abs(moon.planet_gravity_well - planet_gravity_well)
        if distance < closest_distance then
          closest_distance = distance
          closest_body = moon
        end
      end
    end
  end

  return closest_body

end

function Zone.find_nearest_solid_zone_from_zone(zone)
  -- typically used for escape pod
  if Zone.is_solid(zone) then return nil end -- already there

  if zone.type == "orbit" and Zone.is_solid(zone.parent) then
    return zone.parent -- drop to planet / moon
  end

  return Zone.find_nearest_solid_zone(
    Zone.get_space_distortion(zone),
    Zone.get_stellar_position(zone),
    Zone.get_star_gravity_well(zone),
    Zone.get_planet_gravity_well(zone),
    true
  )
end

function Zone.get_force_assets(force_name, zone_index)
  if not global.forces[force_name] then
    if game.forces[force_name] then
      setup_force(game.forces[force_name])
    else
      return
    end
  end
  if not global.forces[force_name] then
    if game.forces[force_name] then
      game.forces[force_name].print("Error getting force data for invalid player force " .. force_name)
    else
      game.forces[force_name].print("Error getting force data for invalid force " .. force_name)
    end
    return -- invalid force
  end
  if not global.forces[force_name].zone_assets then
    global.forces[force_name].zone_assets = {}
  end
  if not global.forces[force_name].zone_assets[zone_index] then
    global.forces[force_name].zone_assets[zone_index] = {
      rocket_launch_pad_names = {},
      rocket_landing_pad_names = {},
    }
  end
  --Log.debug_log("Zone.get_force_assets: " .. util.table_to_string(global.forces[force_name].zone_assets[zone_index]))
  return global.forces[force_name].zone_assets[zone_index]
end

function Zone.get_travel_delta_v_sub(origin, destination)
  -- expected ranges:
    -- 1500 planetary system
    -- 15000 solar system
    -- 50000 interstellarsystem
    -- 50000 to/from anomaly
  if origin == destination then return 0 end

  local origin_space_distorion = Zone.get_space_distortion(origin)
  local origin_stellar_position = Zone.get_stellar_position(origin)
  local origin_star_gravity_well = Zone.get_star_gravity_well(origin)
  local origin_planet_gravity_well = Zone.get_planet_gravity_well(origin)

  local destination_space_distorion = Zone.get_space_distortion(destination)
  local destination_stellar_position = Zone.get_stellar_position(destination)
  local destination_star_gravity_well = Zone.get_star_gravity_well(destination)
  local destination_planet_gravity_well = Zone.get_planet_gravity_well(destination)

  if origin_space_distorion > 0 then
    return Zone.travel_cost_space_distortion
      + Zone.travel_cost_star_gravity * destination_star_gravity_well
      + Zone.travel_cost_planet_gravity * destination_planet_gravity_well
  elseif destination_space_distorion > 0 then
    return Zone.travel_cost_space_distortion
      + Zone.travel_cost_star_gravity * origin_star_gravity_well
      + Zone.travel_cost_planet_gravity * origin_planet_gravity_well
  end

  if origin_stellar_position.x == destination_stellar_position.x and origin_stellar_position.y == destination_stellar_position.y then
    -- same solar system
    if origin_star_gravity_well == destination_star_gravity_well then
      -- same planetary system
      return Zone.travel_cost_planet_gravity * math.abs(origin_planet_gravity_well - destination_planet_gravity_well) -- the planet_gravity_well difference
    else
      -- different planetary systems
      return Zone.travel_cost_star_gravity * math.abs(destination_star_gravity_well - origin_star_gravity_well) -- the star_gravity_well difference
        + Zone.travel_cost_planet_gravity * origin_planet_gravity_well
        + Zone.travel_cost_planet_gravity * destination_planet_gravity_well
    end
  else
    -- interstellar
    return Zone.travel_cost_interstellar * util.vectors_delta_length(origin_stellar_position, destination_stellar_position)
      + Zone.travel_cost_star_gravity * origin_star_gravity_well
      + Zone.travel_cost_planet_gravity * origin_planet_gravity_well
      + Zone.travel_cost_star_gravity * destination_star_gravity_well
      + Zone.travel_cost_planet_gravity * destination_planet_gravity_well
  end

end

function Zone.get_travel_delta_v(origin, destination)
  if origin and destination then
    if origin.type == "spaceship" or destination.type == "spaceship" then
      return Zone.get_travel_delta_v_sub(origin, destination)
    end
    global.cache_travel_delta_v = global.cache_travel_delta_v or {}
    global.cache_travel_delta_v[origin.index] = global.cache_travel_delta_v[origin.index] or {}
    if not global.cache_travel_delta_v[origin.index][destination.index] then
      global.cache_travel_delta_v[origin.index][destination.index] = Zone.get_travel_delta_v_sub(origin, destination)
    end
    return global.cache_travel_delta_v[origin.index][destination.index]
  end
end

function Zone.get_launch_delta_v(zone)
  -- 10000 to 800 for planets, 0 for in space
  return 500 + (zone.radius or 50)
end

function Zone.find_zone_landing_position(zone, try_position)
  Log.debug_log("Zone.find_zone_landing_position: " ..zone.name)
  local surface = Zone.get_make_surface(zone)

  if not try_position then
    if zone.type == "spaceship" then
      try_position = Spaceship.get_boarding_position(zone)
    elseif Zone.is_solid(zone) then
      local try_angle = math.random() * math.pi * 2 -- rad
      local try_distance = math.random() * (zone.radius / 4 or 512)
      try_position = {x = math.cos(try_angle) * try_distance, y = math.sin(try_angle) * try_distance}
    else
      try_position = {x = math.random(-512, 512), y = math.random(-128, 128)}
    end
  end
  surface.request_to_generate_chunks(try_position, 2)
  surface.force_generate_chunk_requests()
  local safe_position
  if Zone.is_solid(zone) then
    safe_position = surface.find_non_colliding_position(collision_rocket_destination_surface, try_position, 64, 1)
  else
    safe_position = surface.find_non_colliding_position(collision_rocket_destination_orbit, try_position, 64, 1)
  end
  if not safe_position then
    local try_position_2 = {x = 64 * (math.random() - 0.5), y = 64 * (math.random() - 0.5)}
    surface.request_to_generate_chunks(try_position_2, 2)
    surface.force_generate_chunk_requests()
    if Zone.is_solid(zone) then
      safe_position = surface.find_non_colliding_position(collision_rocket_destination_surface, try_position_2, 64, 1)
    else
      safe_position = surface.find_non_colliding_position(collision_rocket_destination_orbit, try_position_2, 64, 1)
    end
  end
  if safe_position then
    Log.debug_log("Zone.find_zone_landing_position: safe_position found")
    return safe_position
  else
    Log.debug_log("Zone.find_zone_landing_position: safe_position not found, falling back to try_position")
    return try_position
  end
end

function Zone.dropdown_name_from_zone(zone, no_indent)
  local i1 = "    "
  local i2 = "        "
  local i3 = "              "
  if no_indent then
    i1 = ""
    i2 = ""
    i3 = ""
  end
  if zone.type == "orbit" then
    if zone.parent.type == "star" then
      return "[img=virtual-signal/se-star] " .. zone.name -- star orbit
    elseif zone.parent.type == "planet" then
      return i2.."[img=virtual-signal/se-planet-orbit] " .. zone.name  -- planet orbit
    elseif zone.parent.type == "moon" then
      return i3.."[img=virtual-signal/se-moon-orbit] " .. zone.name -- moon orbit
    end
  elseif zone.type == "asteroid-belt" then
    return i1 .. "[img=virtual-signal/se-asteroid-belt] " .. zone.name
  elseif zone.type == "planet" then
    return i1 .. "[img=virtual-signal/se-planet] " ..  zone.name
  elseif zone.type == "moon" then
    return i2 .. "[img=virtual-signal/se-moon] " ..  zone.name
  elseif zone.type == "asteroid-field" then
    return "[img=virtual-signal/"..mod_prefix..zone.type .. "] " .. zone.name .. " [color=black](Asteroid Field)[/color]"
  elseif zone.type == "anomaly" then
    return "[img=virtual-signal/"..mod_prefix..zone.type .. "] " .. zone.name .. " [color=black](Anomaly)[/color]"
  elseif zone.type == "sapceship" then
    return "[img=virtual-signal/"..mod_prefix..zone.type .. "] " .. zone.name .. " [color=black](Spaceship)[/color]"
  end
  return "[img=virtual-signal/"..mod_prefix..zone.type .. "] " .. zone.name
end

function Zone.get_alphabetised()
  local zones_alphabetised = {}
  for _, zone in pairs(global.zone_index) do
    table.insert(zones_alphabetised, zone)
  end
  for _, spaceship in pairs(global.spaceships) do
    table.insert(zones_alphabetised, spaceship)
  end
  table.sort(zones_alphabetised, function(a,b) return a.name < b.name end)
  return zones_alphabetised
end

function Zone.is_visible_to_force(zone, force_name)
  if global.debug_view_all_zones then return true end
  if zone.type == "spaceship" then return zone.force_name == force_name end
  if not global.forces[force_name].zones_discovered then return false end
  return global.forces[force_name].zones_discovered[zone.index] or (zone.type == "orbit" and global.forces[force_name].zones_discovered[zone.parent.index]) and true or false
end
function Zone.insert_if_visible_to_force(target_table, zone, force_name)
  if Zone.is_visible_to_force(zone, force_name) then table.insert(target_table, zone) end
end

function Zone.dropdown_list_zone_destinations(force_name, current, alphabetical, filter, wildcard, star_restriction)
  -- wildcard = {list = "display", value={type = "any"}}
  local selected_index = 1
  local list = {""}
  local values = {{type = "nil", index = nil}} -- zone indexes
  local forcedata = global.forces[force_name]

  if wildcard then
    table.insert(list, wildcard.list)
    table.insert(values, wildcard.value)
  end

  function conditional_add_zone_to_list(forcedata, current, zone)
    if global.debug_view_all_zones
     or (zone.type == "spaceship" and forcedata.force_name == zone.force_name)
     or (zone.type ~= "spaceship" and (forcedata.zones_discovered[zone.index] or (zone.type == "orbit" and forcedata.zones_discovered[zone.parent.index]))) then
      local allowed_system = true
      if star_restriction then
        allowed_system = false
        if zone == star_restriction
        or zone.parent == star_restriction
        or (zone.parent and zone.parent.parent == star_restriction) then
          allowed_system = true
        end
      end
      if allowed_system then
        if zone.type == "star" then
          table.insert(list, Zone.dropdown_name_from_zone(zone.orbit, alphabetical or filter))
          table.insert(values, {type = "zone", index = zone.orbit.index})
          if current and zone.orbit.index == current.index then selected_index = #list end
        elseif zone.type == "spaceship" then
          table.insert(list, Zone.dropdown_name_from_zone(zone, alphabetical or filter))
          table.insert(values, {type = "spaceship", index = zone.index})
          if current and zone.type == current.type and zone.index == current.index then selected_index = #list end
        else
          table.insert(list, Zone.dropdown_name_from_zone(zone, alphabetical or filter))
          table.insert(values, {type = "zone", index = zone.index})
          if current and zone.type == current.type and zone.index == current.index then selected_index = #list end
        end
      end
    end
  end

  if alphabetical == true or filter then
    for _, zone in pairs(Zone.get_alphabetised()) do
      if not(zone.type == "orbit" and zone.parent.type == "star") then
        if (not filter) or string.find(string.lower(zone.name), string.lower(filter), 1, true) then
          conditional_add_zone_to_list(forcedata, current, zone)
        end
      end
    end
  else
    conditional_add_zone_to_list(forcedata, current, global.universe.anomaly)

    for _, star in pairs(global.universe.stars) do
      conditional_add_zone_to_list(forcedata, current, star)
      for _, planet in pairs(star.children) do
        conditional_add_zone_to_list(forcedata, current, planet)
        if planet.children then
          conditional_add_zone_to_list(forcedata, current, planet.orbit)
          for _, moon in pairs(planet.children) do
            conditional_add_zone_to_list(forcedata, current, moon)
            conditional_add_zone_to_list(forcedata, current, moon.orbit)
          end
        end
      end
    end

    for _, zone in pairs(global.universe.space_zones) do
      conditional_add_zone_to_list(forcedata, current, zone)
    end

    for _, spaceship in pairs(global.spaceships) do
      conditional_add_zone_to_list(forcedata, current, spaceship)
    end
  end

  if star_restriction then
    if filter then
      list[1] = (#list - 1) .. " matching locations in system"
    else
      list[1] = (#list - 1) .. " known locations in system"
    end
  else
    if filter then
      list[1] = (#list - 1) .. " matching locations"
    else
      list[1] = (#list - 1) .. " known locations"
    end
  end

  return list, selected_index, values
end

function Zone.build_tile_replacements(zone)
    -- replaces biome_collections in replace specifications with the full biome names
    --[[
  convert :
  biome_replacement = {
    {replace={"all-dirt", "all-sand", "all-volcanic"}, with="sand-red"},
    {replace={"all-vegetation", "all-frozen"}, with="vegetation-red"}
  }
  to
    {
      ["tile-from-1"] = "tile-to-1",
      ["tile-from-2"] = "tile-to-1",
    }
  ]]--
  if zone.biome_replacements then

    -- expand replacement collections
    local biome_replacements_expanded = {}
    for _, replacement in pairs(zone.biome_replacements) do
      local replace_biomes = {}
      for _, replace in pairs(replacement.replace) do
        if Zone.biome_collections[replace] then -- this is a collection name
          for _, biome_name in pairs(Zone.biome_collections[replace]) do
            if biome_name ~= replacement.with then -- don't replace to iteself
              table.insert(replace_biomes, biome_name)
            end
          end
        elseif replace ~= replacement.with then -- this is a biome name
          table.insert(replace_biomes, replace)
        end
      end
      table.insert(biome_replacements_expanded, {replace = replace_biomes, with = replacement.with})
    end
    -- biome_replacements_expanded now has all of the replace names being all biome names
    -- build tile map
    local tile_replacements = {}
    for _, replacement in pairs(biome_replacements_expanded) do
      local to_tiles = Zone.biome_tiles[replacement.with]
      local i = 0
      for _, replace in pairs(replacement.replace) do
        for _, replace_tile in pairs(Zone.biome_tiles[replace]) do
          tile_replacements[replace_tile] = to_tiles[(i % #to_tiles) + 1]
          i = i + 1
        end
      end
    end

    zone.tile_replacements = tile_replacements
  end

end

function Zone.on_chunk_generated(event)
  local area = event.area
  local surface = event.surface
  local zone = Zone.from_surface(surface)
  if zone and Zone.is_solid(zone) then
    if zone.biome_replacements then
      if not zone.tile_replacements then
        Zone.build_tile_replacements(zone)
      end
      local set_tiles = {} -- by tile name, array of positions, for the surface.set_tiles function
      for x = area.left_top.x, area.right_bottom.x do
        for y = area.left_top.y, area.right_bottom.y do
          local tile = surface.get_tile(x, y)
          if zone.tile_replacements[tile.name] then
            table.insert(set_tiles, {
               name = zone.tile_replacements[tile.name],
               position = tile.position
            })
          end
        end
      end
      if #set_tiles > 0 then
        surface.set_tiles(set_tiles, true)
        surface.destroy_decoratives{area = area}
        surface.regenerate_decorative(nil, {{x = math.floor((area.left_top.x+16)/32), y = math.floor((area.left_top.y+16)/32)}})
      end
    end
  end
end
Event.addListener(defines.events.on_chunk_generated, Zone.on_chunk_generated)

function Zone.export_zone(zone)
  if not zone then return end
  -- not safe to deepcopy
  local export_zone = Util.shallow_copy(zone)
  if export_zone.orbit then
    export_zone.orbit_index = export_zone.orbit.index
    export_zone.orbit = nil
  end
  if export_zone.parent then
    export_zone.parent_index = export_zone.parent.index
    export_zone.parent = nil
  end
  if export_zone.children then
    export_zone.child_indexes = {}
    for i, child in pairs(export_zone.children) do
      export_zone.child_indexes[i] = child.index
    end
    export_zone.children = nil
  end
  -- should be safe to deepcopy now
  export_zone = Util.deep_copy(export_zone)
  return export_zone
end

function Zone.get_threat(zone)
  if Zone.is_solid(zone) then
    if zone.is_homeworld and zone.surface_index then
      local surface = Zone.get_surface(zone)
      local mapgen = surface.map_gen_settings
      if mapgen.autoplace_controls["enemy-base"] and mapgen.autoplace_controls["enemy-base"].size then
        return math.max(0, math.min(3, mapgen.autoplace_controls["enemy-base"].size) / 3) -- 0-1
      end
    end
    if zone.controls and zone.controls["enemy-base"] and zone.controls["enemy-base"].size then
      return math.max(0, math.min(3, zone.controls["enemy-base"].size) / 3) -- 0-1
    end
  end
  return 0
end

function Zone.get_priority(zone, forcename)
  if global.forces[forcename] then
    if zone.type ~= "spaceship" and global.forces[forcename].zone_priorities and global.forces[forcename].zone_priorities[zone.index] then
      return global.forces[forcename].zone_priorities[zone.index]
    end
    if zone.type == "spaceship" and global.forces[forcename].spaceship_priorities and global.forces[forcename].spaceship_priorities[zone.index] then
      return global.forces[forcename].spaceship_priorities[zone.index]
    end
  end
  return 0
end

function Zone.get_attrition(zone, default_rate)
  if default_rate == nil then default_rate = settings.global["robot-attrition-factor"].value end
  if zone then
    if zone.type == "spaceship" then
      return 0 -- default
    elseif zone.type == "anomaly" then
      return 10 + default_rate * 2
    elseif Zone.is_solid(zone) then -- planet or moon
      if zone.name == "Nauvis" or zone.is_homeworld then
        return default_rate
      end
      local enemy = 0
      if zone.controls and zone.controls["enemy-base"] and zone.controls["enemy-base"].size then
        enemy = math.max(0, math.min(3, zone.controls["enemy-base"].size) / 3) -- 0-1
      end
      local rate = 0.5 * (1 - enemy * 0.9)
      rate = rate + 0.5 * zone.radius / 10000
      if enemy == 0 then
        rate = rate + 10
      end
      if enemy >= 3 then
        rate = rate / 2
      end
      return rate * (0.5 + 0.5 * default_rate)
    else -- space
      local star_gravity_well = Zone.get_star_gravity_well(zone)
      local planet_gravity_well = Zone.get_planet_gravity_well(zone)
      local base_rate = star_gravity_well / 20 + planet_gravity_well / 200
      local rate = 10 * (0.01 + 0.99 * base_rate) -- 0-1
      return rate * (0.5 + 0.5 * default_rate)
    end
  end
end

function Zone.rebuild_surface_index()
  global.zones_by_surface = {}
  for _, zone in pairs(global.zone_index) do
    if zone.surface_index then
      if game.surfaces[zone.surface_index] then
        global.zones_by_surface[zone.surface_index] = zone
      else
        zone.surface_index = nil
      end
    end
  end
end

function Zone.delete_surface(zone, player_index)
  local player
  if player_index then
    player = game.players[player_index]
  end
  if zone.surface_index == 1 then
    if player then player.print("Game cannot delete surface 1.") end
    return
  end
  if zone.is_homeworld then
    if player then player.print("Cannot delete homeworlds.") end
    return
  end
  if zone.type == "anomaly" then
    if player then player.print("Cannot delete anomalies.") end
    return
  end
  if zone.type == "spaceship" then
    if player then player.print("Cannot delete spaceships. They must be landed and dismantled.") end
    return
  end
  if not zone.surface_index then
    if player then player.print("Zone has no surface.") end
    return
  end
  local surface = Zone.get_surface(zone)
  if not surface then
    --error(Zone.name.." has a surface but it was missing.")
    zone.surface_index = nil
    Zone.rebuild_surface_index()
    return
  end
  local force_names = {}
  for force_name, force in pairs(global.forces) do
    if force_name ~= "enemy" and force_name ~= "enemy" then
      table.insert(force_names, force_name)
    end
  end
  local entities = surface.find_entities_filtered{force=force_names}
  if #entities > 0 then
    if player then  player.print("Cannot delete a zone with player entities.") end
  else
    local entities = surface.find_entities_filtered{name=Ancient.vault_entrance_structures}
    if #entities > 0 then
      -- if player then player.print("Cannot delete a zone with ancient artifacts.") end
      -- return

    end
    log("Deleting surface for zone: " .. zone.name)
    -- find all players viewing that surface
    for _, player in pairs(game.connected_players) do
      if player.surface == surface then
        local force = player.force
        local home_zone
        if global.forces[force.name] and global.forces[force.name].homeworld_index then
          home_zone = Zone.from_zone_index(global.forces[force.name].homeworld_index)
        end
        if not home_zone then home_zone = Zone.from_name("Nauvis") end
        player.teleport({0,0}, Zone.get_make_surface(home_zone))
      end
    end
    game.delete_surface(surface)
    zone.surface_index = nil
    zone.deleted_surface = {tick = game.tick, player_index = player_index}
    Zone.rebuild_surface_index()
  end
end


function Zone.on_surface_created(surface_index)
  local zone = Zone.from_surface_index(surface_index)
  if not zone then
    game.surfaces[surface_index].solar_power_multiplier = Zone.solar_multiplier * 0.5
  end
end
Event.addListener(defines.events.on_surface_created, on_surface_created)

function Zone.on_research_finished(event)

  local force = event.research.force

  if event.research.name == Zone.name_tech_discover_random then
    local dicovered_something = Zone.discover_next_research(force.name, "Telescope data analysis", false)
    if not dicovered_something then
      force.print({"space-exploration.tech-discovered-nothing"})
    end
  elseif  event.research.name == Zone.name_tech_discover_targeted then
    local dicovered_something = Zone.discover_next_research(force.name, "Telescope data analysis", true)
    if not dicovered_something then
      force.print({"space-exploration.tech-discovered-nothing"})
    end
  elseif  event.research.name == Zone.name_tech_discover_deep then
    local dicovered_something = Zone.discover_next_research_deep_space(force.name, "Telescope data analysis", false)
    if not dicovered_something then
      force.print({"space-exploration.tech-deep-discovered-nothing"})
    end
  end
end
Event.addListener(defines.events.on_research_finished, Zone.on_research_finished)

function Zone.set_zone_as_homeworld(data)
  local zone = Zone.from_name(data.zone_name)
  local nauvis = Zone.from_name("Nauvis")
  if not zone then
    game.print("No zone found")
  else
    if zone.type ~= "planet" then
      game.print("Zone type must be planet, selected zone is: " .. zone.type)
    else
      zone.is_homeworld = true
      zone.inflated = true
      zone.resources = {}
      zone.ticks_per_day = 25000
      zone.fragment_name = "se-core-fragment-omni"
      zone.radius = nauvis.radius

      local surface = Zone.get_make_surface(zone)

      local seed = surface.map_gen_settings.seed
      local nauvis_map_gen = game.surfaces[1].map_gen_settings
      if data.match_nauvis_seed ~= true then
        nauvis_map_gen.seed = seed
      end
      surface.map_gen_settings = nauvis_map_gen
      if reset_surface ~= false then
        surface.clear(true)
      end
    end
  end
  Universe.make_validate_homesystem(zone)

  global.resources_and_controls_compare_string = nil -- force udpate resources
  Universe.load_resource_data()

  return Zone.export_zone(Zone.from_name(data.zone_name))
end

return Zone
