local Migrate = {}

function Migrate.migrations()
  if not global.version then global.version = 0 end

  if global.version < version then
    if global.version < 000138 then Migrate.v0_1_38() end
    if global.version < 0001065 then Migrate.v0_1_65() end
    if global.version < 0001086 then Migrate.v0_1_86() end
    if global.version < 0001089 then Migrate.v0_1_89() end
    if global.version < 0001096 then Migrate.v0_1_96() end
    if global.version < 0001101 then Migrate.v0_1_101() end
    if global.version < 0001126 then Migrate.v0_1_126() end
    if global.version < 0001130 then Migrate.v0_1_130() end
    if global.version < 0003001 then Migrate.v0_3_1() end
    if global.version < 0003011 then Migrate.v0_3_11() end
    if global.version < 0003039 then Migrate.v0_3_39() end
    if global.version < 0003040 then global.delivery_cannons = {} end
    if global.version < 0003054 then Migrate.v0_3_54() end
    if global.version < 0003059 then Migrate.v0_3_59() end
    if global.version < 0003061 then Migrate.v0_3_61() end
    if global.version < 0003069 then Migrate.v0_3_69() end
    if global.version < 0003071 then Migrate.v0_3_71() end
    if global.version < 0003088 then Migrate.v0_3_88() end
    if global.version < 0003099 then Migrate.v0_3_99() end
  end
  -- general cleaning
  for _, zone in pairs(global.zone_index) do
    if zone.is_homeworld or zone.name == "Nauvis" then
      zone.tags = nil
    end
    if zone.tags then
      if zone.tags.moisture and zone.tags.moisture == "moisture_very_low" then
        -- was incorrect in universe.raw, if surface is genrated it is incorrect but don't change the terrain if already settled
        zone.tags.moisture = "moisture_low"
        Zone.delete_surface(zone) -- remove if unsettled
        log("Changed moisture tag from moisture_very_low to moisture_low.")
      end
    end
    Zone.set_solar_and_daytime(zone)
  end
  Ancient.update_unlocks()
  global.version = version
end

function Migrate.v0_1_38_zone(zone)
  zone.core_miners = nil
  local surface = Zone.get_make_surface(zone)
  for _, miner in pairs(surface.find_entities_filtered{name = mod_prefix.."core-miner"}) do
    Coreminer.on_entity_created({entity = miner})
  end
end

function Migrate.v0_1_38 ()
  if global.universe then

    for _, star in pairs(global.universe.stars) do
      for _, planet in pairs(star.children) do
        if planet.core_miners then
          Migrate.v0_1_38_zone(planet)
        end
        if planet.children then -- could be an asteroid-belt
          for _, moon in pairs(planet.children) do
            if moon.core_miners then
              Migrate.v0_1_38_zone(moon)
            end
          end
        end
      end
    end
  end

end

function Migrate.v0_1_65 ()
  if global.universe then
    for _, zone in pairs(global.zone_index) do
      if zone.controls and zone.controls["enemy"] then
        zone.controls["enemy-base"] = zone.controls["enemy"]
        zone.controls["enemy"] = nil
        if zone.name ~= "Nauvis" then
          local surface = Zone.get_surface(zone)
          if surface then
            local map_gen_settings = surface.map_gen_settings
            map_gen_settings.autoplace_controls["enemy-base"].size = zone.controls["enemy-base"].size
            map_gen_settings.autoplace_controls["enemy-base"].frequency = zone.controls["enemy-base"].frequency
            surface.map_gen_settings = map_gen_settings
            if zone.controls["enemy-base"].size == 0  then
              local enemies = surface.find_entities_filtered{force={"enemy"}}
              for _, enemy in pairs(enemies) do
                enemy.destroy()
              end
            end
          end
        end
      end
    end
  end

end

function Migrate.v0_1_86()
  if global.universe then
    for _, zone in pairs(global.zone_index) do
      if Zone.is_solid(zone) then
        -- nauvis is 25000
        if zone.inflated and not zone.ticks_per_day then
          zone.ticks_per_day = 25000 -- nauvis
          if zone.name ~= "Nauvis" then
            if math.random() < 0.5 then
              zone.ticks_per_day = 60*60 + math.random(60*60*59) -- 1 - 60 minutes
            else
              zone.ticks_per_day = 60*60 + math.random(60*60*19) -- 1 - 20 minutes
            end
            local surface = Zone.get_surface(zone)
            if surface then
              surface.ticks_per_day = zone.ticks_per_day
            end
          end
        end
      end
    end
  end
end

function Migrate.v0_1_89()
  --global.rocket_landing_pads = global.rocket_landing_pads or {}
  for _, struct in pairs(global.rocket_landing_pads) do
    Landingpad.rename(struct, struct.name)
  end
end

function Migrate.v0_1_96()
  if global.universe then
    for _, zone in pairs(global.zone_index) do
      if Zone.is_space(zone) then
        local surface = Zone.get_surface(zone)
        if surface then
          local entities = surface.find_entities_filtered{type="offshore-pump"}
          for _, entity in pairs(entities) do
            entity.destroy()
          end
        end
      end
    end
  end
end

function Migrate.v0_1_101()
  if global.meteor_zones then
    for _, zone in pairs(global.meteor_zones) do
      if zone.meteor_defences then
        for _, defence in pairs(zone.meteor_defences) do
          if defence.charger and defence.charger.valid then
            defence.container = defence.charger.surface.find_entity(Meteor.name_meteor_defence_container, defence.charger.position)
            if defence.container then
              defence.container.active = false
              defence.container.insert({name=Meteor.name_meteor_defence_ammo, count=10})
            end
          end
        end
      end
      if zone.meteor_point_defences then
        for _, defence in pairs(zone.meteor_point_defences) do
          if defence.charger and defence.charger.valid then
            defence.container = defence.charger.surface.find_entity(Meteor.name_meteor_point_defence_container, defence.charger.position)
            if defence.container then
              defence.container.active = false
              defence.container.insert({name=Meteor.name_meteor_point_defence_ammo, count=20})
            end
          end
        end
      end
    end
  end
end

function Migrate.v0_1_126()
  for _, surface in pairs(game.surfaces) do
    local zone = Zone.from_surface(surface)
    if zone then
      if zone.type == "spaceship" then
        local map_gen_settings = surface.map_gen_settings
        map_gen_settings.autoplace_settings={
          ["decorative"]={
            treat_missing_as_default=false,
            settings={
            }
          },
          ["entity"]={
            treat_missing_as_default=false,
            settings={
            }
          },
          ["tile"]={
            treat_missing_as_default=false,
            settings={
              ["se-space"]={}
            }
          }
        }
        surface.map_gen_settings = map_gen_settings
      elseif Zone.is_space(zone) then
        local map_gen_settings = surface.map_gen_settings
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
        surface.map_gen_settings = map_gen_settings
      else
        local map_gen_settings = surface.map_gen_settings
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
        surface.map_gen_settings = map_gen_settings
      end
    end
  end
end

function Migrate.v0_1_130()
  for _, surface in pairs(game.surfaces) do
    local zone = Zone.from_surface(surface)
    if zone and zone.type == "orbit" and zone.parent and zone.parent.type == "star" then
      surface.daytime = 0 -- that's why we're here
    end
  end
end

function Migrate.v0_3_1()
  setup_util_forces()

  for _, surface in pairs(game.surfaces) do
    surface.solar_power_multiplier = surface.solar_power_multiplier / 2
  end

  for _, zone in pairs(global.zone_index) do
    zone.inflated = nil
    if zone.name == "Nauvis" then
      zone.is_homeworld = true
    end
    if zone.resources and zone.resources[1] then
      zone.primary_resource = zone.resources[1]
      zone.resources = nil
    end
    if zone.surface_index then
      Zone.delete_surface(zone) -- only works on valid ones
    end
    Universe.inflate_climate_controls(zone)
    Zone.set_solar_and_daytime(zone)
  end
  Zone.rebuild_surface_index()

  -- assign glyps and vaults
  for force_name, forcedata in pairs(global.forces) do
    forcedata.zone_priorities = forcedata.zone_priorities or {}
    for _, zone in pairs(global.zone_index) do
      if zone.is_homeworld then
        forcedata.zone_priorities[zone.index] = forcedata.zone_priorities[zone.index] or 1
      end
    end

    local delay = 100
    for zone_index, discovery_data in pairs(forcedata.zones_discovered) do
      local zone = Zone.from_zone_index(zone_index)
      if zone.type == "planet" then
        --delay = delay + 10
        Ancient.assign_zone_next_glyph(zone)

        if zone.glyph then
          if not forcedata.first_discovered_vault then
            forcedata.first_discovered_vault = zone
          end
          Ancient.make_vault_exterior(zone)
          --local tick_task = new_tick_task("force-message")
          --tick_task.force_name = force_name
          --tick_task.message = {"space-exploration.discovered-glyph-vault", zone.name}
          --tick_task.delay_until = game.tick + delay --5s
        end
      end
    end
  end

  local anomaly = global.universe.anomaly
  if anomaly.surface_index then
    local surface = game.surfaces[anomaly.surface_index]
    Ancient.make_gate(Ancient.gate_default_position)
    Ruin.build({ruin_name = "galaxy-ship", surface_index = surface.index,  position = Ancient.galaxy_ship_default_position})

    for force_name, forcedata in pairs(global.forces) do
      local tick_task = new_tick_task("force-message")
      tick_task.force_name = force_name
      tick_task.message = {"space-exploration.discovered-anomaly-additional"}
      tick_task.delay_until = game.tick + 750 --5s
    end
  end

  for _, player in pairs(game.connected_players) do
    local character = player_get_character(player)
    if character then
      if character.force.technologies[mod_prefix .. "lifesupport-facility"].researched == true then
        character.insert({name = Lifesupport.lifesupport_canisters[1].name, count = 20})
      end
    end
  end
end

function Migrate.v0_3_11()
  if global.glyph_vaults then
    for _, g in pairs(global.glyph_vaults) do
      for _, z in pairs(g) do
        if z.surface_index and game.surfaces[z.surface_index] then
          game.delete_surface(z.surface_index)
          z.surface_index = nil
        end
      end
    end
  end
end

function Migrate.v0_3_39()
  local homeworlds = {}
  for _, zone in pairs(global.zone_index) do
    if zone.is_homeworld or zone.name == "Nauvis" then
      table.insert(homeworlds, zone)
    end
  end
  for _, homeworld in pairs(homeworlds) do
    Universe.make_validate_homesystem(homeworld)
  end
  global.resources_and_controls_compare_string = nil -- force udpate resources
end



function Migrate.v0_3_54()

  if global.spaceships then
    for _, surface in pairs(game.surfaces) do
      for _, entity in pairs(surface.find_entities_filtered{name = Spaceship.name_spaceship_console}) do
        local new_pos = {x = math.floor(entity.position.x), y = math.floor(entity.position.y)}
        local output = surface.find_entity(Spaceship.name_spaceship_console_output, entity.position)
        entity.teleport(new_pos)
        if output then output.destroy() end
        script.raise_event(defines.events.script_raised_built, {entity = entity})
      end
    end
  end

end

function Migrate.v0_3_59()

  for _, star in pairs(global.universe.stars) do
    for _, child in pairs(star.children) do
      child.parent = star
    end
    Universe.star_gravity_well_distribute(star)
  end

  for _, zone in pairs(global.zone_index) do
    Zone.set_solar_and_daytime(zone)
  end

end

function Migrate.v0_3_61()

  for _, zone in pairs(global.zone_index) do
    if Zone.is_solid(zone) and zone.tags then
      if not zone.tags.cliff then
        zone.tags.cliff = Universe.cliff_tags[math.random(#Universe.cliff_tags)]
        if zone.controls then
          local cliff_controls = Universe.apply_control_tags({}, {zone.tags.cliff})
          for _, control in pairs(cliff_controls) do
            zone.controls[_] = control
          end
        end
      end
    end
  end

end

function Migrate.v0_3_69()

  for _, surface in pairs(game.surfaces) do
    -- make sure there are no test items left in the ruin.
    for _, entity in pairs(surface.find_entities_filtered{type="infinity-pipe"}) do
      entity.destroy()
    end
    for _, entity in pairs(surface.find_entities_filtered{type="infinity-chest"}) do
      entity.destroy()
    end
    for _, entity in pairs(surface.find_entities_filtered{name="electric-energy-interface"}) do
      entity.destroy()
    end
  end

end

function Migrate.v0_3_71()

  for _, zone in pairs(global.zone_index) do
    if zone.glyph and zone.vault_pyramid then
      if zone.vault_pyramid.valid then
        zone.vault_pyramid_position = zone.vault_pyramid.position
      end
    end
  end

end

function Migrate.v0_3_88()
  if global.gtt then
    global.gtt[#global.gtt-3] = #global.gtt - 14
  end
end

function Migrate.v0_3_99()
  if not global.vgo then return end
  local r = 0
  for i, j in pairs(global.vgo) do
    if i > 40 and (Ancient.gtf(j) == 36 or Ancient.gtf(j) == 37) then
      r = r + 1
    end
  end
  if r > 0 then
    global.hcoord_old = global.hcoord
    global.gds_old = global.gds
    global.vgo_old = global.vgo
    global.gco_old = global.gco

    global.hcoord = nil
    Ancient.cryptf6()
    log("Migrate.v0_3_99")
    global.v0_3_99_fix = true
    for force_name, force_data in pairs(global.forces) do
      if force_data.coordinates_discovered then
        force_data.coordinates_discovered_old = force_data.coordinates_discovered
        local k = table_size(force_data.coordinates_discovered)
        force_data.coordinates_discovered = {}
        while k > #force_data.coordinates_discovered do
          table.insert(force_data.coordinates_discovered, global.gco[#force_data.coordinates_discovered+1])
        end
      end
    end
  end
end

return Migrate
