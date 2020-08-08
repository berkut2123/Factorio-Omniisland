local Launchpad = {}
-- launchpad, cargo rockeet, and rocket landing / crashing sequences

--custon event
Launchpad.on_cargo_rocket_launched_event = script.generate_event_name()

-- constants
Launchpad.name_rocket_launch_pad = mod_prefix.."rocket-launch-pad"
Launchpad.name_rocket_launch_pad_settings = mod_prefix.."rocket-launch-pad-settings"
Launchpad.name_rocket_launch_pad_section_input = mod_prefix.."rocket-launch-pad-_-section-input"
Launchpad.name_rocket_launch_pad_tank = mod_prefix.."rocket-launch-pad-tank"
Launchpad.name_rocket_launch_pad_combinator = mod_prefix.."rocket-launch-pad-combinator"
Launchpad.name_rocket_launch_pad_silo = mod_prefix.."rocket-launch-pad-silo"
Launchpad.name_rocket_launch_pad_silo_dummy = mod_prefix.."rocket-launch-pad-silo-dummy-ingredient-item"
Launchpad.name_rocket_launch_pad_seat = mod_prefix.."rocket-launch-pad-_-seat"
Launchpad.name_rocket_launch_pad_gui_root = mod_prefix.."rocket-launch-pad-gui"
Launchpad.name_rocket_section = mod_prefix.."cargo-rocket-section"

Launchpad.name_cargo_rocket = mod_prefix.."cargo-rocket"
Launchpad.name_cargo_pod = mod_prefix.."cargo-rocket-cargo-pod"

Launchpad.name_tech_rocket_cargo_safety = mod_prefix.."rocket-cargo-safety"
Launchpad.name_tech_rocket_reusability = mod_prefix.."rocket-reusability"
Launchpad.name_tech_rocket_survivability = mod_prefix.."rocket-survivability"

Launchpad.rocket_capacity = 500
Launchpad.fuel_per_delta_v = 8 -- maybe this should be an energy value?
Launchpad.rocket_sections_per_rocket = 100
Launchpad.crew_capsules_per_rocket = 1
Launchpad.signal_for_launch = {type = "virtual", name = "signal-green"}
Launchpad.signal_for_rocket_complete = {type = "virtual", name = mod_prefix.."cargo-rocket"}

Launchpad.trigger_options = {
  { name = "none", display = {"space-exploration.trigger-none"}},
  { name = "fuel-full", display = {"space-exploration.trigger-fuel-full"}},
  { name = "cargo-full", display = {"space-exploration.trigger-cargo-full"}},
  { name = "fuel-full-signal", display = {"space-exploration.trigger-fuel-full-signal"}},
  { name = "cargo-full-signal", display = {"space-exploration.trigger-cargo-full-signal"}},
  { name = "cargo-full-or-signal", display = {"space-exploration.trigger-cargo-full-or-signal"}},
}

Launchpad.name_window_close = "launchpad_close_button"

Launchpad.time_takeoff = 440 -- the delay before the rocket gets going
Launchpad.time_takeoff_finish_ascent = 1100 --1164 -- just before the rocket launch event would fire

Launchpad.time_landing_capsule_touchdown = 6 * 60 -- when the capsule lands
Launchpad.time_landing_cargopod_first = 3 * 60 -- when the first cargopod lands
Launchpad.time_landing_cargopod_last = 5 * 60 -- when the last cargopod lands
Launchpad.time_landing_debris_first = 2 * 60 -- when the first debris lands
Launchpad.time_landing_debris_last = 7 * 60 -- when the last debris lands
Launchpad.landing_start_altitude = 128

Launchpad.safety_delta_v_base = 1000
Launchpad.safety_delta_v_factor = 100000

Launchpad.names_cargo_fragment = { -- these are the base names, actual names are "se-falling-"
  "cargo-fragment-a",
  "cargo-fragment-b",
  "cargo-fragment-c",
  "cargo-fragment-d",
}

Launchpad.rocket_fragments_large = 4
Launchpad.names_rocket_fragments_large = {
  "rocket-fragment-big-d",
  "rocket-fragment-big-a",
  "rocket-fragment-big-b",
  "rocket-fragment-big-c"
}
Launchpad.rocket_fragments_medium = 6
Launchpad.names_rocket_fragments_medium = {
  "rocket-fragment-medium-a",
  "rocket-fragment-medium-b",
  "rocket-fragment-medium-c"
}
Launchpad.rocket_fragments_small = 20
Launchpad.names_rocket_fragments_small = {
  "rocket-fragment-small-a",
  "rocket-fragment-small-b",
  "rocket-fragment-small-c",
  "rocket-fragment-small-d",
  "rocket-fragment-small-e",
  "rocket-fragment-small-f",
  "rocket-fragment-small-g",
  "rocket-fragment-small-h",
  "rocket-fragment-small-i",
  "rocket-fragment-small-j"
}
Launchpad.rocket_fragments_tiny = 20
Launchpad.names_rocket_fragments_tiny = {
  "rocket-fragment-tiny-a",
  "rocket-fragment-tiny-b",
  "rocket-fragment-tiny-c",
  "rocket-fragment-tiny-d",
  "rocket-fragment-tiny-e",
  "rocket-fragment-tiny-f"
}

function Launchpad.get_cargo_loss(force, delta_v) -- percentage of cargo lost
  delta_v = (delta_v or Launchpad.safety_delta_v_factor) + Launchpad.safety_delta_v_base -- 50%
  local researched_levels = 0
  local i = 1
  local current_level = force.technologies[Launchpad.name_tech_rocket_cargo_safety.."-"..i]
  while current_level and (current_level.researched or current_level.level > i)  do
    local more_levels = (current_level.level or i) - i
    i = i + 1 + more_levels
    researched_levels = researched_levels + (1 + more_levels)
    current_level = force.technologies[Launchpad.name_tech_rocket_cargo_safety.."-"..i]
  end
  local loss = delta_v/(delta_v+Launchpad.safety_delta_v_factor)
  --local loss = 0.5 * global.forces[force.name].cargo_rockets_launched / (global.forces[force.name].cargo_rockets_launched + 500)
  return loss * 0.9^researched_levels
end

function Launchpad.get_reusability(force) -- percentage of parts not recoverable (all at start)
  local recovery = 0.2
  local i = 1
  local current_level = force.technologies[Launchpad.name_tech_rocket_reusability.."-"..i]
  while current_level and (current_level.researched or current_level.level > i)  do
    local more_levels = (current_level.level or i) - i
    i = i + 1 + more_levels
    recovery = recovery + 0.04 * (1 + more_levels)
    current_level = force.technologies[Launchpad.name_tech_rocket_reusability.."-"..i]
  end
  return recovery
end

function Launchpad.get_survivability_loss(force, delta_v) -- chance to fail to land on rocket launch pad
  delta_v = (delta_v or Launchpad.safety_delta_v_factor) + Launchpad.safety_delta_v_base -- 50%
  local multiplier = 1
  local i = 1
  while force.technologies[Launchpad.name_tech_rocket_survivability.."-"..i]
  and force.technologies[Launchpad.name_tech_rocket_survivability.."-"..i].researched do
    i = i + 1
    multiplier = multiplier * 0.9
  end
  if force.technologies[Launchpad.name_tech_rocket_survivability.."-"..i] then
    local tech = force.technologies[Launchpad.name_tech_rocket_survivability.."-"..i]
    if tech.prototype.max_level > 10 then  -- infinite
      for j = i, tech.level do
        multiplier = multiplier * 0.9
      end
    end
  end
  local loss = delta_v/(delta_v+Launchpad.safety_delta_v_factor)
  --local loss = 0.5 * global.forces[force.name].cargo_rockets_launched / (global.forces[force.name].cargo_rockets_launched + 500)
  return loss * multiplier
end

function Launchpad.from_unit_number (unit_number)
  unit_number = tonumber(unit_number)
  -- NOTE: only suppors container as the entity
  return global.rocket_launch_pads[unit_number]
end

function Launchpad.from_entity (entity)
  if not(entity and entity.valid) then
    Log.trace("Launchpad.from_entity: invalid entity")
    return
  end
  -- NOTE: only suppors container as the entity
  return Launchpad.from_unit_number(entity.unit_number)
end

function Launchpad.get_fuel_cost(origin, destination)
  if origin and destination then
    return Launchpad.fuel_per_delta_v * (Zone.get_launch_delta_v(origin) + Zone.get_travel_delta_v(origin, destination))
  end
end

function Launchpad.gui_close (player)
  if player.gui.left[Launchpad.name_rocket_launch_pad_gui_root] then
    player.gui.left[Launchpad.name_rocket_launch_pad_gui_root].destroy()
  end
end


--[[
Input the destination as either:
  { type = "zone", zone_index = name }
  { type = "landing-pad", zone_index = name, landing_pad_name = name }
Output the destination as:
  { type = "zone", zone_index = name, zone = Zone, position = {x=#,y=#} }
  { type = "landing-pad", landing_pad_name = name, landing_pad = rocket_landing_pad}
]]--
function Launchpad.lock_destination (struct, allow_non_empty)
  -- force launch can go to non-empty landings

  if struct.destination then
    if struct.destination.zone then
      -- can't have people changing destination mid-launch
      local force_name = struct.force_name
      -- destination to locked destination
      local locked_destination = { -- don't use deepcopy be
        zone = struct.destination.zone,
        landing_pad_name = struct.destination.landing_pad_name,
      }

      local zone = locked_destination.zone
      if not zone then return false end

      if locked_destination.landing_pad_name then

        local landing_pads = Landingpad.get_zone_landing_pads_availability(force_name, zone, locked_destination.landing_pad_name)

        if #landing_pads.empty_landing_pads > 0 then
          local landing_pad = landing_pads.empty_landing_pads[math.random(#landing_pads.empty_landing_pads)]
          locked_destination.landing_pad = landing_pad
          Zone.get_make_surface(zone)
          return locked_destination
        elseif allow_non_empty and #landing_pads.filled_landing_pads > 0 then
          local landing_pad = landing_pads.filled_landing_pads[math.random(#landing_pads.filled_landing_pads)]
          locked_destination.landing_pad = landing_pad
          Zone.get_make_surface(zone)
          return locked_destination
        end

      else -- not landing pad name

        Zone.get_make_surface(zone)
        locked_destination.position = Zone.find_zone_landing_position(zone)

        --this is the first cargo rocket to space, go to the space platform satellite
        if (zone.type == "orbit" and zone.parent.name == "Nauvis") then
          if (global.forces[force_name].cargo_rockets_launched or 0) == 0 and global.forces[force_name].nauvis_satellite then
            local satellite_blueprint = Ruin.ruins["satellite"]
            locked_destination.position = {
              x = global.forces[force_name].nauvis_satellite.x
                + (satellite_blueprint.landing_offset.x or satellite_blueprint.landing_offset[1])
                - (satellite_blueprint.center.x or satellite_blueprint.center[1]),
              y = global.forces[force_name].nauvis_satellite.y
                + (satellite_blueprint.landing_offset.y or satellite_blueprint.landing_offset[2])
                - (satellite_blueprint.center.y or satellite_blueprint.center[2])
            }
          end
        end
        return locked_destination
      end
    elseif struct.destination.landing_pad_name then
      -- can't have people changing destination mid-launch
      local force_name = struct.force_name

      local locked_destination = { -- don't use deepcopy be
        landing_pad_name = struct.destination.landing_pad_name,
      }

      local landing_pads = Landingpad.get_force_landing_pads_availability(force_name, locked_destination.landing_pad_name)

      if #landing_pads.empty_landing_pads > 0 then
        local landing_pad = landing_pads.empty_landing_pads[math.random(#landing_pads.empty_landing_pads)]
        locked_destination.zone = landing_pad.zone
        locked_destination.landing_pad = landing_pad
        return locked_destination
      elseif allow_non_empty and #landing_pads.filled_landing_pads > 0 then
        local landing_pad = landing_pads.filled_landing_pads[math.random(#landing_pads.filled_landing_pads)]
        locked_destination.zone = landing_pad.zone
        locked_destination.landing_pad = landing_pad
        return locked_destination
      end

    end
  end
  return false
end

function Launchpad.add_section_input(struct)
    -- spawn section input
    struct.section_input = struct.container.surface.create_entity{
      name = Launchpad.name_rocket_launch_pad_section_input,
      force = struct.container.force,
      position = {struct.container.position.x, struct.container.position.y}}
    local inv = struct.section_input.get_inventory(defines.inventory.car_trunk)
    inv.set_filter(1, Launchpad.name_rocket_section)
    inv.set_filter(2, Capsule.name_space_capsule)
end

function Launchpad.update_combinator(struct, main_inv)
  if struct.combinator then
    local comb = struct.combinator.get_or_create_control_behavior()
      -- comb.set_signal(1, {signal={type="fluid", name=name_fluid_rocket_fuel}, count=struct.total_fuel})
    comb.set_signal(1, {signal={type="fluid", name=name_fluid_rocket_fuel}, count=struct.lua_fuel})
    comb.set_signal(2, {signal={type="item", name=Launchpad.name_rocket_section}, count=struct.rocket_sections})
    comb.set_signal(3, {signal={type="item", name=Capsule.name_space_capsule}, count=struct.crew_capsules})
    if struct.rocket_sections >= Launchpad.rocket_sections_per_rocket and struct.crew_capsules >= Launchpad.crew_capsules_per_rocket then
      comb.set_signal(4, {signal=Launchpad.signal_for_rocket_complete, count=1})
    else
      comb.set_signal(4, {signal=Launchpad.signal_for_rocket_complete, count=0})
    end
    local slots_used = count_inventory_slots_used(main_inv)

    comb.set_signal(5, {signal={type = "virtual", name = "signal-E"}, count= Launchpad.rocket_capacity - slots_used})
    comb.set_signal(6, {signal={type = "virtual", name = "signal-F"}, count= slots_used})
    comb.set_signal(7, {signal={type = "virtual", name = "signal-L"}, count= struct.required_fuel or 0})
  end
end

function Launchpad.prep(struct)

  --local profiler = game.create_profiler()

  if not (struct.container and struct.container.valid) then
    return Launchpad.destroy(struct)
  end


  struct.required_fuel = nil -- invalid
  if struct.destination then
    local origin_zone = struct.zone
    if struct.destination.landing_pad_name and not struct.destination.zone then

      if global.forces[struct.force_name]
      and global.forces[struct.force_name].rocket_landing_pad_names
      and global.forces[struct.force_name].rocket_landing_pad_names[struct.destination.landing_pad_name] then
        local required_fuel_max = 0
        local landing_pads_list = global.forces[struct.force_name].rocket_landing_pad_names[struct.destination.landing_pad_name]
        for _, landing_pad in pairs(landing_pads_list) do
          required_fuel_max = math.max(required_fuel_max, Launchpad.get_fuel_cost(origin_zone, landing_pad.zone))
        end
        if required_fuel_max > 0 then
          struct.required_fuel = required_fuel_max
        end
      end
    else
      local destination_zone = struct.destination.zone
      struct.required_fuel = Launchpad.get_fuel_cost(origin_zone, destination_zone); -- self-validates
    end
  else
    struct.required_fuel = nil -- invalid
  end

  -- balance tank fuel and lua fuel
  -- fuel tank % should match total %
  local fluidbox
  local effective_required_fuel = (struct.required_fuel or 0) + 1000
  if not (struct.tank and struct.tank.valid) then
    struct.tank = struct.container.surface.create_entity{
      name = Launchpad.name_rocket_launch_pad_tank,
      force = struct.container.force,
      position = {struct.container.position.x, struct.container.position.y + 1}} -- 1 tile down to be in front of silo
    struct.tank.fluidbox.set_filter(1, {name = name_fluid_rocket_fuel, force = true})
    struct.container.connect_neighbour({wire = defines.wire_type.red, target_entity = struct.tank})
    struct.container.connect_neighbour({wire = defines.wire_type.green, target_entity = struct.tank})
    struct.tank.destructible = false
  end
  if struct.tank and #struct.tank.fluidbox > 0 then
    fluidbox = struct.tank.fluidbox[1] or {name = name_fluid_rocket_fuel, amount = 0}
    struct.total_fuel = (struct.lua_fuel or 0) + fluidbox.amount
    if struct.total_fuel > 0 then
      local percent_of_required = 1 -- overflow
      percent_of_required = struct.total_fuel / effective_required_fuel -- leave 10% available to fill faster
      if percent_of_required < 1 then
        percent_of_required = percent_of_required * 0.5
      end
      fluidbox.amount = math.min(struct.total_fuel, math.min(1, percent_of_required) * struct.tank.fluidbox.get_capacity(1))
      if fluidbox.amount < 1 then
        fluidbox.amount = 1
      end
      struct.lua_fuel = struct.total_fuel - fluidbox.amount
      struct.tank.fluidbox[1] = fluidbox
    end
  end

  local main_inv = struct.container.get_inventory(defines.inventory.chest)
  local main_contents

  struct.crew_capsules = struct.crew_capsules or 0
  struct.rocket_sections = struct.rocket_sections or 0

  -- take from section input first
  if (struct.crew_capsules or 0) < Launchpad.crew_capsules_per_rocket and struct.section_input and struct.section_input.valid then
      local inv = struct.section_input.get_inventory(defines.inventory.car_trunk)
      local contents = inv.get_contents()
      if contents[Capsule.name_space_capsule] and contents[Capsule.name_space_capsule] > 0 then
        local take = 1
        inv.remove({name=Capsule.name_space_capsule, count=take})
        struct.crew_capsules = struct.crew_capsules + take
      end
  end

  -- otherwise take from main container
  if (struct.crew_capsules or 0) < Launchpad.crew_capsules_per_rocket then
    if not main_contents then main_contents = main_inv.get_contents() end
    if main_contents[Capsule.name_space_capsule] and main_contents[Capsule.name_space_capsule] > 0 then
      local take = math.min(main_contents[Capsule.name_space_capsule], Launchpad.crew_capsules_per_rocket - struct.crew_capsules)
      main_inv.remove({name=Capsule.name_space_capsule, count=take})
      struct.crew_capsules = struct.crew_capsules + take
    end
  end

  -- take from section input first
  if struct.rocket_sections < Launchpad.rocket_sections_per_rocket and struct.section_input and struct.section_input.valid then
      local inv = struct.section_input.get_inventory(defines.inventory.car_trunk)
      local contents = inv.get_contents()
      if contents[Launchpad.name_rocket_section] and contents[Launchpad.name_rocket_section] > 0 then
        local take = math.min(contents[Launchpad.name_rocket_section], Launchpad.rocket_sections_per_rocket - struct.rocket_sections)
        inv.remove({name=Launchpad.name_rocket_section, count=take})
        struct.rocket_sections = struct.rocket_sections + take
      end
  end

  -- otherwise take from main container
  if struct.rocket_sections < Launchpad.rocket_sections_per_rocket then
    if not main_contents then main_contents = main_inv.get_contents() end
    if main_contents[Launchpad.name_rocket_section] and main_contents[Launchpad.name_rocket_section] > 0 then
      local take = math.min(main_contents[Launchpad.name_rocket_section], Launchpad.rocket_sections_per_rocket - struct.rocket_sections)
      main_inv.remove({name=Launchpad.name_rocket_section, count=take})
      struct.rocket_sections = struct.rocket_sections + take
    end
  end

  -- not enough parts, add a section input to collect parts
  -- this will probably prevent input of other parts.
  if struct.rocket_sections < Launchpad.rocket_sections_per_rocket
    and not main_inv.can_insert{name = Launchpad.name_rocket_section, count = 1} then
      if not(struct.section_input and struct.section_input.valid) then
        Launchpad.add_section_input(struct)
      end
  else
    Launchpad.destroy_sub(struct, "section_input")
  end

  Launchpad.update_combinator(struct, main_inv)

  if struct.rocket_sections >= Launchpad.rocket_sections_per_rocket and struct.crew_capsules >= Launchpad.crew_capsules_per_rocket
    and not struct.has_inserted_dummy then
      local inserted = struct.silo.insert{name = Launchpad.name_rocket_launch_pad_silo_dummy, count = 1}
      if inserted == 1 then
        struct.has_inserted_dummy = true
      end
  end

  --game.print(profiler)

end

function Launchpad.launch(struct, skip_prep, allow_non_empty)

  if struct.launch_status > -1 then return end -- already launching
  if skip_prep ~= true then
    Launchpad.prep(struct)
  end

  local destination = Launchpad.lock_destination(struct, allow_non_empty)

  if destination then
    local current_zone = struct.zone
    local destination_zone = destination.zone
    struct.launching_to_destiantion = destination

    local required_fuel = Launchpad.get_fuel_cost(current_zone, destination_zone)
    struct.required_fuel = required_fuel

    -- the destination is locked so let's go
    if destination.landing_pad then
      destination.position = Util.vectors_add(destination.landing_pad.container.position, {x = 0, y = 2})
      destination.landing_pad.inbound_rocket = true
    end

    -- set the contents
    local main_inv = struct.container.get_inventory(defines.inventory.chest)
    main_contents = main_inv.get_contents()
    struct.launched_contents = main_contents
    main_inv.clear()

    -- consume the fuel
    local lua_fuel_consumed = math.min(struct.lua_fuel, required_fuel)
    struct.lua_fuel = struct.lua_fuel - lua_fuel_consumed
    if lua_fuel_consumed < required_fuel then
      local fluidbox = struct.tank.fluidbox[1]
      local tank_fuel_consumed = math.min(required_fuel - lua_fuel_consumed, fluidbox.amount)
      fluidbox.amount = math.max(1, fluidbox.amount - tank_fuel_consumed)
      struct.tank.fluidbox[1] = fluidbox
      struct.total_fuel = struct.lua_fuel + fluidbox.amount
    end
    if struct.tank and struct.tank.fluidbox and struct.tank.fluidbox[1] and struct.tank.fluidbox[1].name then
      struct.container.force.fluid_production_statistics.on_flow(struct.tank.fluidbox[1].name, -required_fuel)
    end

    -- consume rocket parts
    struct.rocket_sections = struct.rocket_sections - Launchpad.rocket_sections_per_rocket
    struct.container.force.item_production_statistics.on_flow(Launchpad.name_rocket_section, -Launchpad.rocket_sections_per_rocket)

    -- consume crew capsule
    struct.crew_capsules = struct.crew_capsules - Launchpad.crew_capsules_per_rocket
    struct.container.force.item_production_statistics.on_flow(Capsule.name_space_capsule, -Launchpad.crew_capsules_per_rocket)

    -- start charting the landing
    if destination_zone.type ~= "spaceship" then
      local range = Zone.discovery_scan_radius
      struct.container.force.chart(Zone.get_make_surface(destination_zone), {
        {destination.position.x - range, destination.position.y - range - Launchpad.landing_start_altitude},
        {destination.position.x + range, destination.position.y + range}
      })
    end
    -- set launch status
    struct.launch_status = 1

  	script.raise_event(Launchpad.on_cargo_rocket_launched_event, {struct = struct})

    Launchpad.update_combinator(struct, main_inv)
  end
end


function Launchpad.tick(struct)
  -- this should only be called once per 60 ticks during prep and every tick during launch
  -- actually, launch should be handles seperatly.
  -- make launches and capsule launches in to tick tasks
  -- Launchpad.prep can be called every tick for gui updates
  if not (struct.container and struct.container.valid) then
    return Launchpad.destroy(struct)
  end

  if struct.launch_status < 1 then

    Launchpad.prep(struct)

    -- if struct.required_fuel then the destination must be valid
    if struct.required_fuel and struct.total_fuel >= struct.required_fuel
     and struct.rocket_sections >= Launchpad.rocket_sections_per_rocket
     and struct.crew_capsules >= Launchpad.crew_capsules_per_rocket then
      -- can launch
      -- TRIGGERS

      local destination = nil
      if struct.launch_trigger == "fuel-full" then
        -- we already know fuel is full so launch
        Launchpad.launch(struct, true)
      elseif struct.launch_trigger == "cargo-full" then
        local main_inv = struct.container.get_inventory(defines.inventory.chest)
        if main_inv then
          if not main_inv.can_insert({name = Launchpad.name_rocket_section, count = 1}) then
            -- cargo is full so try launch
            Launchpad.launch(struct, true)
          end
        end
      elseif struct.launch_trigger == "fuel-full-signal" then
        if struct.container.get_circuit_network(defines.wire_type.red).get_signal(Launchpad.signal_for_launch) > 0
        or struct.container.get_circuit_network(defines.wire_type.green).get_signal(Launchpad.signal_for_launch) > 0
        then
          Launchpad.launch(struct, true)
        end
      elseif struct.launch_trigger == "cargo-full-signal" then
        local main_inv = struct.container.get_inventory(defines.inventory.chest)
        if main_inv then
          if not main_inv.can_insert({name = Launchpad.name_rocket_section, count = 1}) then
            if struct.container.get_circuit_network(defines.wire_type.red).get_signal(Launchpad.signal_for_launch) > 0
            or struct.container.get_circuit_network(defines.wire_type.green).get_signal(Launchpad.signal_for_launch) > 0
            then
              Launchpad.launch(struct, true)
            end
          end
        end
      elseif struct.launch_trigger == "cargo-full-or-signal" then
        local main_inv = struct.container.get_inventory(defines.inventory.chest)
        if main_inv then
          if not main_inv.can_insert({name = Launchpad.name_rocket_section, count = 1}) then
            -- cargo is full so try launch
            Launchpad.launch(struct, true)
          else
            if struct.container.get_circuit_network(defines.wire_type.red).get_signal(Launchpad.signal_for_launch) > 0
            or struct.container.get_circuit_network(defines.wire_type.green).get_signal(Launchpad.signal_for_launch) > 0
            then
              -- signal so try launch
              Launchpad.launch(struct, true)
            end
          end
        end
      end

    end
  elseif struct.launch_status == 1 then
    -- the rocket should be ready
    if struct.silo.launch_rocket() then
      --Log.trace("launching")
      struct.launch_status = 2
      struct.rocket_entity = struct.container.surface.find_entities_filtered{name=Launchpad.name_cargo_rocket, area=util.position_to_area(struct.container.position, 0.5)}[1]
      -- the launch pad could get removed at this point and the rocket would need to keep going.
      local tick_task = new_tick_task("launchpad-journey")
      tick_task.struct = struct
      tick_task.force_name = struct.force_name
      tick_task.rocket_entity = struct.rocket_entity
      tick_task.launch_timer = 0
      tick_task.launched_contents = struct.launched_contents
      tick_task.launching_to_destiantion = struct.launching_to_destiantion
      tick_task.delta_v = Zone.get_travel_delta_v(tick_task.struct.zone, tick_task.launching_to_destiantion.zone)

      local target_surface = Zone.get_make_surface(tick_task.launching_to_destiantion.zone)
      target_surface.request_to_generate_chunks(Util.vectors_add(tick_task.launching_to_destiantion.position, {x = 0, y = Launchpad.landing_start_altitude}),
         Launchpad.landing_start_altitude / 32 / 2)
      -- start the launch animation
      -- move the player seats over the rocket
      -- follow rocket launch
      -- if not landing_pad clear destination: remove biters
      -- teleport over landing zone
      -- if not landing_pad start descent / crash sequence
      -- place landfill, place scaffold, place cargo Pods
      -- place recoverable sections
      -- destroy the seats to release the players
    end
  else
    -- stays at struct.launch_status 2 until tick_task sets it back to -1
  end
end


function Launchpad.drop_rocket_fragment(zone, size, name, position, start_position_x_offset)
  local target_surface = Zone.get_make_surface(zone)
    local falling_time
    if math.random() < 0.5 then -- biggest first
      falling_time = Launchpad.time_landing_debris_first
        + (size - math.random()) / 4 * (Launchpad.time_landing_debris_last - Launchpad.time_landing_debris_first)
    else -- or just random
      falling_time = Launchpad.time_landing_debris_first + math.random() * (Launchpad.time_landing_debris_last - Launchpad.time_landing_debris_first)
    end
    local landing_start_altitude = Launchpad.landing_start_altitude
    if Zone.is_space(zone) then
      landing_start_altitude = landing_start_altitude * 0.5
    end
    local random_start_offset = {x = 8 * (math.random() - 0.5), y = 8 * (math.random() - 0.5)}
    local start_position = Util.vectors_add(position, {
      x = random_start_offset.x + start_position_x_offset,
      y = random_start_offset.y - landing_start_altitude})
    local start_position_shadow = Util.vectors_add(position, {
      x = random_start_offset.x + landing_start_altitude + start_position_x_offset,
      y = random_start_offset.y})

    local land_position = Util.vectors_add(position, {
        x = random_start_offset.x + 32 * (math.random() - 0.5),
        y = random_start_offset.y + 32 * (math.random() - 0.5)})

    local flat_distance = Util.vectors_delta_length(start_position, land_position)
    local flat_distance_shadow = Util.vectors_delta_length(start_position_shadow, land_position)
    local speed = flat_distance / falling_time
    local speed_shadow = flat_distance_shadow / falling_time

    if Zone.is_space(zone) then
      target_surface.create_entity{
        name = mod_prefix .. "space-" ..name,
        position = start_position,
        target = land_position,
        speed = speed,
        --max_rage = flat_distance,
      }
    else
      target_surface.create_entity{
        name = mod_prefix .. "falling-" ..name,
        position = start_position,
        target = land_position,
        speed = speed,
        max_rage = flat_distance,
      }
      target_surface.create_entity{
        name = mod_prefix .. "shadow-" ..name,
        position = start_position_shadow,
        target = land_position,
        speed = speed_shadow,
        max_rage = flat_distance_shadow,
      }
    end
end

function Launchpad.tick_journey(tick_task)
  -- from tick_task.type = "launchpad-journey"
  if tick_task.launch_timer then
    tick_task.launch_timer = tick_task.launch_timer + 1

    local struct = tick_task.struct
    if struct and struct.valid then
      if tick_task.launch_timer <= Launchpad.time_takeoff then
        -- collect passengers while rocket is low
        tick_task.passengers = tick_task.passengers or {} -- characters not players
        for _, seat in pairs(struct.seats) do
          if seat.get_driver() then
            table.insert(tick_task.passengers, seat.get_driver())
            seat.set_driver(nil)
          end
          if seat.get_passenger() then
            table.insert(tick_task.passengers, seat.get_passenger())
            seat.set_passenger(nil)
          end
        end
      end
    end

    if tick_task.rocket_entity and tick_task.rocket_entity.valid then
      -- move passengers with the rocket
      if tick_task.passengers then
        for _, passenger in pairs(tick_task.passengers) do
          if passenger and passenger.valid then
            if remote.interfaces["jetpack"] and remote.interfaces["jetpack"]["block_jetpack"] then
              remote.call("jetpack", "block_jetpack", {character=passenger})
            end
            local target_position = {
              x = tick_task.rocket_entity.position.x,
              y = tick_task.rocket_entity.position.y - 2 - math.max(0, tick_task.launch_timer - Launchpad.time_takeoff) / 64}
            passenger.teleport(target_position)
            passenger.destructible = false
            --passenger.teleport(Util.move_to(passenger.position, target_position, tick_task.launch_timer / 100) )
          end
        end
      end

      if tick_task.launch_timer >= Launchpad.time_takeoff_finish_ascent then
        -- skip to next phase
        tick_task.launch_timer = nil
      end

    else
      -- skip to next phase
      tick_task.launch_timer = nil
    end

  else
    if not tick_task.land_timer then
      tick_task.land_timer = 0
      -- setup next landing sequence

      if tick_task.rocket_entity and tick_task.rocket_entity.valid then
        tick_task.rocket_entity.destroy()
        tick_task.rocket_entity = nil
      end
      -- reset the landing pad
      local struct = tick_task.struct
      if struct and struct.valid then
        struct.launched_contents = nil
        struct.launch_status = -1
        struct.launching_to_destiantion = nil
        struct.has_inserted_dummy = nil
        global.forces[tick_task.force_name].cargo_rockets_launched = (global.forces[tick_task.force_name].cargo_rockets_launched or 0) + 1
      end

      --game.print("Dev note: Show capsule landing sequence and discarded rocket part debris falling from the sky.")

      -- determine success rate

      -- for landing pad:
      -- show capsule descent over the pad, then put capsule inside the pad and player outside.
      -- show up to 10 cargo pods the fly past to the landing pad first.
      -- failed cargo pods are added to crash debris.
      -- crash debris based on recovery tech.
      -- put some recovered parts in the landing pad based on recovery tech.
      -- no fire from spilt fuel

      --for general location or guidance failure
      -- show capsule descent at random locaiton then put player outside.
      -- show up to 10 cargo pods the fly past to random locations
      -- failed cargo pods are added to crash debris.
      -- all rocket parts added to crash debris regardless of recovery tech.
      -- add fire from spilt fuel
      -- add some wider area explosive damage

      local is_landingpad = (tick_task.launching_to_destiantion.landing_pad and tick_task.launching_to_destiantion.landing_pad.container and tick_task.launching_to_destiantion.landing_pad.container.valid)
      if is_landingpad then
        local error_chance = Launchpad.get_survivability_loss(game.forces[tick_task.force_name], tick_task.delta_v)
        if math.random() < error_chance then
          -- off course
          is_landingpad = false
          tick_task.launching_to_destiantion.landing_pad.inbound_rocket = nil
          tick_task.launching_to_destiantion.attempted_position = tick_task.launching_to_destiantion.landing_pad.container.position
          tick_task.launching_to_destiantion.attempted_landing_pad = tick_task.launching_to_destiantion.landing_pad
          tick_task.launching_to_destiantion.landing_pad = nil
          local new_pos = tick_task.launching_to_destiantion.position
          new_pos.x = new_pos.x + (math.random() - 0.5) * 150
          new_pos.y = new_pos.y + (math.random() - 0.5) * 128
          tick_task.launching_to_destiantion.position = Zone.find_zone_landing_position(tick_task.launching_to_destiantion.zone, new_pos)
          game.forces[tick_task.force_name].print({"space-exploration.rocket_survivability_fail"})
        end
      end

      local cargo_loss = Launchpad.get_cargo_loss(game.forces[tick_task.force_name], tick_task.delta_v)
      if is_landingpad then
        cargo_loss = cargo_loss / 2
      end
      local keep_percent = 1 - cargo_loss
      tick_task.safe_contents = {}
      for item_type, item_count in pairs(tick_task.launched_contents) do
        if item_count > 1 then
          local loss = 2 * cargo_loss * math.random() -- +/- 100%
          -- keep 10% at a minimum
          tick_task.safe_contents[item_type] = math.max(math.ceil(item_count / 10), item_count - item_count * loss)
        else
          tick_task.safe_contents[item_type] = item_count
        end
      end

      -- cargo loss should never go above 90%, it can be below 10% round up for number of crashing pods.
      local total_pods = 10
      local crashing_pods = math.floor(total_pods * cargo_loss + 0.49)
      local safe_pods = total_pods - crashing_pods
      local pods = {}

      local target_surface = Zone.get_make_surface(tick_task.launching_to_destiantion.zone)
      Zone.apply_markers(tick_task.launching_to_destiantion.zone) -- in case the surface exists

      for i = 1, safe_pods do
        table.insert(pods, {type = "safe"})
      end
      for i = 1, crashing_pods do
        table.insert(pods, {type = "crash"})
      end
      pods = Util.shuffle(pods)

      local landing_start_altitude = Launchpad.landing_start_altitude
      if Zone.is_space(tick_task.launching_to_destiantion.zone) then
        landing_start_altitude = landing_start_altitude * 0.5
      end
      local start_position_x_offset = landing_start_altitude * (math.random() - 0.5) -- gives an angle to all pieces
      local start_position = Util.vectors_add(tick_task.launching_to_destiantion.position, {
        x = start_position_x_offset,
        y = - landing_start_altitude})
      local start_position_shadow = Util.vectors_add(tick_task.launching_to_destiantion.position, {
        x = start_position_x_offset + landing_start_altitude,
        y = 0})

      tick_task.safe_pods = {}
      for i, pod in pairs(pods) do

        local falling_time = Launchpad.time_landing_cargopod_first
          + (Launchpad.time_landing_cargopod_last - Launchpad.time_landing_cargopod_first) * (i - 1) / (total_pods - 1)
        local land_position
        if pod.type == "safe" and is_landingpad then
          land_position = tick_task.launching_to_destiantion.position
        else
          land_position = Util.vectors_add(tick_task.launching_to_destiantion.position, {x = 32 * (math.random() - 0.5), y = 32 * (math.random() - 0.5)})
        end
        local flat_distance = Util.vectors_delta_length(start_position, land_position)
        local flat_distance_shadow = Util.vectors_delta_length(start_position_shadow, land_position)
        local speed = flat_distance / falling_time
        local speed_shadow = flat_distance_shadow / falling_time

        if pod.type == "safe" then
          -- track the safe ones for adding items
          local entity = target_surface.create_entity{
            name = mod_prefix .. "falling-cargo-pod",
            position = start_position,
            target = land_position,
            speed = speed,
            max_rage = flat_distance,
          }
          entity.orientation = 0
          table.insert(tick_task.safe_pods, {falling_entity=entity, land_position = land_position})
          target_surface.create_entity{
            name = mod_prefix .. "shadow-cargo-pod",
            position = start_position_shadow,
            target = land_position,
            speed = speed_shadow,
            max_rage = flat_distance_shadow,
          }
        else
          target_surface.create_entity{
            name = mod_prefix .. "falling-" .. Launchpad.names_cargo_fragment[(i % #Launchpad.names_cargo_fragment) + 1],
            position = start_position,
            target = land_position,
            speed = speed,
            max_rage = flat_distance,
          }
          target_surface.create_entity{
            name = mod_prefix .. "shadow-" .. Launchpad.names_cargo_fragment[(i % #Launchpad.names_cargo_fragment) + 1],
            position = start_position_shadow,
            target = land_position,
            speed = speed_shadow,
            max_rage = flat_distance_shadow,
          }
        end
      end

      if not is_landingpad then
        for i = 1, Launchpad.rocket_fragments_large do
          Launchpad.drop_rocket_fragment(tick_task.launching_to_destiantion.zone, 4, Launchpad.names_rocket_fragments_large[(i % #Launchpad.names_rocket_fragments_large) + 1],
            tick_task.launching_to_destiantion.position,
            start_position_x_offset)
        end
        for i = 1, Launchpad.rocket_fragments_medium do
          Launchpad.drop_rocket_fragment(tick_task.launching_to_destiantion.zone, 3, Launchpad.names_rocket_fragments_medium[(i % #Launchpad.names_rocket_fragments_medium) + 1],
            tick_task.launching_to_destiantion.position,
            start_position_x_offset)
        end
        for i = 1, Launchpad.rocket_fragments_small do
          Launchpad.drop_rocket_fragment(tick_task.launching_to_destiantion.zone, 2, Launchpad.names_rocket_fragments_small[(i % #Launchpad.names_rocket_fragments_small) + 1],
            tick_task.launching_to_destiantion.position,
            start_position_x_offset)
        end
        for i = 1, Launchpad.rocket_fragments_tiny do
          Launchpad.drop_rocket_fragment(tick_task.launching_to_destiantion.zone, 1, Launchpad.names_rocket_fragments_tiny[(i % #Launchpad.names_rocket_fragments_tiny) + 1],
            tick_task.launching_to_destiantion.position,
            start_position_x_offset)
        end
      end

      -- capsule
      tick_task.capsule = target_surface.create_entity{
        name = Capsule.name_space_capsule_vehicle,
        position=start_position,
        force = tick_task.force_name
      }
      tick_task.capsule.destructible = false
      tick_task.capsule_shadow = target_surface.create_entity{name = Capsule.name_space_capsule_vehicle_shadow, position=start_position_shadow, force = "neutral"}
      tick_task.capsule_light = target_surface.create_entity{name = Capsule.name_space_capsule_vehicle_light, position=start_position,
        speed = 0, target = tick_task.capsule}

      if tick_task.passengers then
        for _, passenger in pairs(tick_task.passengers) do
          if passenger and passenger.valid then
            -- this disassociates the character
            if passenger.player then
              Launchpad.gui_close(passenger.player)
            end
            tick_task.passengers[_] = teleport_character_to_surface(passenger, target_surface, tick_task.capsule.position)
            if tick_task.passengers[_] then
              tick_task.passengers[_].destructible = false
            end
          end
        end
      end
      -- end landing sequence setup
    else
      -- continuation for landing sqequence
      tick_task.land_timer = tick_task.land_timer + 1

      local time_remaining = math.max(1, Launchpad.time_landing_capsule_touchdown - tick_task.land_timer)
      local target_pos = tick_task.launching_to_destiantion.position
      local capsule_target_pos = tick_task.launching_to_destiantion.attempted_position or target_pos

      --local travel = Util.vector_multiply(Util.vectors_delta(tick_task.capsule.position, target_pos), 1 / time_remaining)
      --local travel_shadow = Util.vector_multiply(Util.vectors_delta(tick_task.capsule_shadow.position, target_pos), 1 / time_remaining)

      if not(tick_task.capsule and tick_task.capsule.valid) then
        local target_surface = Zone.get_make_surface(tick_task.launching_to_destiantion.zone)
        tick_task.capsule = target_surface.create_entity{
          name = Capsule.name_space_capsule_vehicle,
          position={x = capsule_target_pos.x, y = capsule_target_pos.y - Launchpad.landing_start_altitude * time_remaining / Launchpad.time_landing_capsule_touchdown},
          force = tick_task.force_name
        }
      end
      tick_task.capsule.destructible = true

      local travel = Util.vector_multiply(Util.vectors_delta(tick_task.capsule.position, capsule_target_pos), math.min(0.9, 2 / time_remaining))
      local animation_speed = 1/3
      local animation_frames = 24
      local animation_frame = math.max(math.min(math.floor(time_remaining * animation_speed), animation_frames), 1)

      tick_task.capsule.teleport(Util.vectors_add(tick_task.capsule.position, travel))
      tick_task.capsule.orientation = (animation_frame - 1) / animation_frames

      if tick_task.capsule_light and tick_task.capsule_light.valid then
        tick_task.capsule_light.teleport(tick_task.capsule.position)
      end

      if tick_task.capsule_shadow and tick_task.capsule_shadow.valid then
        local travel_shadow = Util.vector_multiply(Util.vectors_delta(tick_task.capsule_shadow.position, capsule_target_pos), math.min(0.9, 2 / time_remaining))
        tick_task.capsule_shadow.teleport(Util.vectors_add(tick_task.capsule_shadow.position, travel_shadow))
        tick_task.capsule_shadow.graphics_variation = animation_frame
      end

      if tick_task.passengers then
        for _, passenger in pairs(tick_task.passengers) do
          if passenger and passenger.valid then
            passenger.teleport({x = tick_task.capsule.position.x, y = tick_task.capsule.position.y - 0.2})
          end
        end
      end

      for _, safe_pod in pairs(tick_task.safe_pods) do
        if safe_pod.falling_entity then
          if not safe_pod.falling_entity.valid then
            safe_pod.falling_entity = nil
            if tick_task.launching_to_destiantion.landing_pad and tick_task.launching_to_destiantion.landing_pad.valid then
              tick_task.launching_to_destiantion.landing_pad.container.insert{name = Launchpad.name_cargo_pod, count = 1}
              tick_task.launching_to_destiantion.landing_pad.container.force.item_production_statistics.on_flow(Launchpad.name_cargo_pod, 1)
            else
              safe_pod.cargo_entity = tick_task.capsule.surface.create_entity{
                name = Launchpad.name_cargo_pod,
                position = safe_pod.land_position,
                force = tick_task.force_name
              }
            end
          end

        end
      end

      if tick_task.land_timer > Launchpad.time_landing_capsule_touchdown then

        if tick_task.launching_to_destiantion.landing_pad and tick_task.launching_to_destiantion.landing_pad.valid then
          -- going to a landing pad
          tick_task.launching_to_destiantion.landing_pad.container.insert{name = Capsule.name_space_capsule, count = 1}
          tick_task.launching_to_destiantion.landing_pad.container.force.item_production_statistics.on_flow(Capsule.name_space_capsule, 1)
          tick_task.capsule.destroy()

          if tick_task.capsule_light and tick_task.capsule_light.valid then
            tick_task.capsule_light.destroy()
          end

          if tick_task.capsule_shadow and tick_task.capsule_shadow.valid then
            tick_task.capsule_shadow.destroy()
          end

          for name, count in pairs(tick_task.safe_contents) do
            tick_task.launching_to_destiantion.landing_pad.container.insert{name=name, count=count}
          end

          local reusability = Launchpad.get_reusability(game.forces[tick_task.force_name])
          local reusable_parts = math.floor(math.min(Launchpad.rocket_sections_per_rocket, Launchpad.rocket_sections_per_rocket * reusability * ( 0.9 + 0.2 * math.random())))
          if reusable_parts > 0 then
            tick_task.launching_to_destiantion.landing_pad.container.insert{name = Launchpad.name_rocket_section, count = reusable_parts}
            tick_task.launching_to_destiantion.landing_pad.container.force.item_production_statistics.on_flow(Launchpad.name_rocket_section, reusable_parts)
          end

          tick_task.launching_to_destiantion.landing_pad.inbound_rocket = nil
        else

          local i = 1
          for name, count in pairs(tick_task.safe_contents) do
            local remaining =  count
            for _, pod in pairs(tick_task.safe_pods) do
              if remaining >= 1 then
                remaining = remaining - pod.cargo_entity.insert{name=name, count=remaining}
              end
            end
          end

          for _, pod in pairs(tick_task.safe_pods) do
            -- HERE
            if pod and pod.cargo_entity and pod.cargo_entity.valid then
              pod.cargo_entity.order_deconstruction(tick_task.force_name)
            end
          end

          if tick_task.launching_to_destiantion.attempted_landing_pad and tick_task.launching_to_destiantion.attempted_landing_pad.valid then
            tick_task.launching_to_destiantion.attempted_landing_pad.container.insert{name = Capsule.name_space_capsule, count = 1}
            tick_task.launching_to_destiantion.attempted_landing_pad.container.force.item_production_statistics.on_flow(Capsule.name_space_capsule, 1)
            tick_task.capsule.destroy()

            if tick_task.capsule_light and tick_task.capsule_light.valid then
              tick_task.capsule_light.destroy()
            end

            if tick_task.capsule_shadow and tick_task.capsule_shadow.valid then
              tick_task.capsule_shadow.destroy()
            end
          end

        end

        if tick_task.passengers then
          for _, passenger in pairs(tick_task.passengers) do
            if passenger and passenger.valid then
              teleport_non_colliding(passenger, capsule_target_pos)
              passenger.destructible = true
              if passenger.player then
                local playerdata = get_make_playerdata(passenger.player)
                playerdata.zero_velocity = true
                passenger.player.print({"space-exploration.respawn-if-stranded"})
              end
              if remote.interfaces["jetpack"] and remote.interfaces["jetpack"]["unblock_jetpack"] then
                remote.call("jetpack", "unblock_jetpack", {character=passenger}) -- last otherwise the teleport breacks the chatacter reference
              end
            end
          end
        end

        if tick_task.capsule and tick_task.capsule.valid then tick_task.capsule.destructible = false end
        tick_task.launched_contents = nil
        tick_task.safe_contents = nil

        tick_task.valid = false -- close tick task
      end
    end

  end

end

function Launchpad.gui_update(player)
  local root = player.gui.left[Launchpad.name_rocket_launch_pad_gui_root]
  if root then
    local struct = Launchpad.from_unit_number(root.unit_number.children_names[1])
    if struct then
      Launchpad.prep(struct)

      local inv = struct.container.get_inventory(defines.inventory.chest)
      local inv_used = count_inventory_slots_used(inv)
      struct.crew_capsules = struct.crew_capsules or 0
      struct.rocket_sections = struct.rocket_sections or 0

      if root["crew_capsules"] then
        root["crew_capsules"].caption="Space Capsule: " .. struct.crew_capsules .. " / " .. Launchpad.crew_capsules_per_rocket
        root["crew_capsules_progress"].value = struct.crew_capsules / Launchpad.crew_capsules_per_rocket
      end

      root["rocket_sections"].caption="Cargo Rocket Sections: " .. struct.rocket_sections .. " / " .. Launchpad.rocket_sections_per_rocket
      root["rocket_sections_progress"].value = struct.rocket_sections / Launchpad.rocket_sections_per_rocket

      if struct.required_fuel then
        --root["fuel_capacity"].caption="Liquid Rocket Fuel: " .. math.floor(math.min(struct.total_fuel, struct.required_fuel)) .. " / " .. math.floor(struct.required_fuel)
        root["fuel_capacity"].caption="Liquid Rocket Fuel: " .. Util.format_fuel(math.min(struct.total_fuel, struct.required_fuel)) .. " / " ..  Util.format_fuel(struct.required_fuel)
        root["fuel_capacity_progress"].value=math.min(struct.total_fuel, struct.required_fuel) / (struct.required_fuel)
      else
        root["fuel_capacity"].caption="Liquid Rocket Fuel: " .. math.floor(struct.total_fuel) .. " / ?"
        root["fuel_capacity_progress"].value=0
      end

      root["cargo_capacity"].caption="Cargo: " .. math.min(inv_used, Launchpad.rocket_capacity) .. " / " .. Launchpad.rocket_capacity
      root["cargo_capacity_progress"].value=math.min(inv_used, Launchpad.rocket_capacity) / Launchpad.rocket_capacity

      local message = ""
      local ready = "disabled"
      if not (global.forces[player.force.name] and global.forces[player.force.name].satellites_launched > 0) then
        message = "No navigation data, launch a satellite from the Satellite rocket silo."
      elseif struct.launch_status > -1 then
        message = "Launching Rocket!"
      elseif struct.rocket_sections < Launchpad.rocket_sections_per_rocket then
        message = "Constructing Rocket"
      elseif struct.crew_capsules < Launchpad.crew_capsules_per_rocket then
        message = "Space Capsule Required"
      elseif not struct.required_fuel then
        message = "Invalid Destination"
      elseif struct.total_fuel < struct.required_fuel then
        message = "Loading Fuel"
      elseif inv_used < Launchpad.rocket_capacity then
        message = "Ready - Loading Cargo"
        ready = "ready"
      else
        message = "Ready - Cargo Full"
        ready = "ready"
      end
      if ready == "ready" and struct.destination.landing_pad_name then
        if struct.destination.zone then
          local landing_pads = Landingpad.get_zone_landing_pads_availability(struct.force_name, struct.destination.zone, struct.destination.landing_pad_name)
          if #landing_pads.empty_landing_pads == 0 then
            message = "Waiting for available empty landing pad."
            ready = "delayed"
            if #landing_pads.filled_landing_pads == 0 then
              message = "Waiting for available landing pad."
              ready = "disabled"
              if #landing_pads.blocked_landing_pads == 0 then
                message = "No landing pads found matching name."
              end
            end
          end
        else
          local landing_pads = Landingpad.get_force_landing_pads_availability(struct.force_name, struct.destination.landing_pad_name)
          if #landing_pads.empty_landing_pads == 0 then
            message = "Waiting for available empty landing pad."
            ready = "delayed"
            if #landing_pads.filled_landing_pads == 0 then
              message = "Waiting for available landing pad."
              ready = "disabled"
              if #landing_pads.blocked_landing_pads == 0 then
                message = "No landing pads found matching name."
              end
            end
          end
        end
      end

      local delta_v = Zone.get_travel_delta_v(struct.zone, struct.destination.zone)
      if root.cargo_loss then
        local cargo_loss = Launchpad.get_cargo_loss(game.forces[struct.force_name], delta_v)
        if struct.destination and struct.destination.landing_pad_name then
          cargo_loss = cargo_loss / 2
        end
        root.cargo_loss.caption = "Cargo safety: " .. string.format("%.2f", (1-cargo_loss)*100).."%"
        root.cargo_loss.tooltip = "Surviving stacks numbers are rounded up, unique items are never lost."
      end
      if root.survivability_loss then
        local survivability_loss = Launchpad.get_survivability_loss(game.forces[struct.force_name], delta_v)
        if struct.destination and struct.destination.landing_pad_name then
          root.survivability_loss.caption = "Landing chance: " .. string.format("%.2f", (1-survivability_loss)*100).."%"
          root.survivability_loss.tooltip = "Failure results in loss of all rocket sections. Cargo is still delivered in cargo pods with minimal damage."
        else
          root.survivability_loss.caption = "Landing chance: Requires landing pad."
          root.survivability_loss.tooltip = "All rocket sections will be lost but cargo is still delivered in cargo pods with minimal damage."
        end
      end

      root["status"].caption="Status: " .. message

      if ready == "ready" or ready == "delayed" then
        if root["launch-disabled"] then root["launch-disabled"].destroy() end
        if not root["launch"] then
          local launch_button
          if ready == "delayed" then
            launch_button = root.add{ type="button", name="launch", caption="Launch (Delayed)", style="confirm_button", tooltip="Waiting for target launch pad to empty. Manual launch can override."}
          else
            launch_button = root.add{ type="button", name="launch", caption={"space-exploration.button-launch"}, style="confirm_button"}
          end
          launch_button.style.top_margin = 10
          launch_button.style.horizontally_stretchable  = true
          launch_button.style.horizontal_align = "left"
        end
      else
        if root["launch"] then root["launch"].destroy() end
        if not root["launch-disabled"] then
          local launch_button = root.add{ type="button", name="launch-disabled", caption={"space-exploration.button-launch-disabled"}, style="red_confirm_button"}
          launch_button.style.top_margin = 10
          launch_button.style.horizontally_stretchable  = true
          launch_button.style.horizontal_align = "left"
        end
        local launch_button = root["launch-disabled"]
        if struct.launch_status > -1 then
          launch_button.caption = "Launch in progress"
        else
          launch_button.caption = {"space-exploration.button-launch-disabled"}
        end
      end

    end
  end
end


function Launchpad.gui_open(player, launch_pad)
  if not launch_pad then
    Log.trace('launch_pad not found')
    return
  end
  local struct = launch_pad
  local gui = player.gui.left
  close_own_guis(player)
  local playerdata = get_make_playerdata(player)

  local container = gui.add{ type = "frame", name = Launchpad.name_rocket_launch_pad_gui_root, style="space_platform_container", direction="vertical"}

  local title_table = container.add{type="table", name="unit_number", column_count=2, draw_horizontal_lines=false}
  title_table.style.horizontally_stretchable = true
  title_table.style.column_alignments[1] = "left"
  title_table.style.column_alignments[2] = "right"

  -- NOTE: [Launchpad.name_rocket_launch_pad_gui_root].unit_number.child_names()[1] gets unit number
  local title_frame = title_table.add{type="frame", name=struct.unit_number,
    caption = {"space-exploration.simple-a-b", "[img=entity/"..Launchpad.name_rocket_launch_pad.."] ", {"entity-name." .. Launchpad.name_rocket_launch_pad}},
    style="informatron_title_frame"}
  title_frame.style.right_padding = -5

  local right_flow = title_table.add{type="flow", name="title_flow_right"}
  --local close = right_flow.add{type="button", name=Lifesupport.name_window_close, caption="✖", style="informatron_close_button"}
  local close = right_flow.add{type="sprite-button", name=Launchpad.name_window_close, sprite = "utility/close_white", style="informatron_close_button"}
  close.style.width = 28
  close.style.height = 28

  --local title_flow = container.add{ type="flow", name="unit_number", direction="horizontal"}
  --local title = title_flow.add{ type="label", name=struct.unit_number, caption={"entity-name." .. Launchpad.name_rocket_launch_pad}, style="space_platform_title"}

  --local name_flow = container.add{ type="flow", name="name-flow", direction="horizontal"}
  --local name_label = name_flow.add{ type = "label", name="show-name", caption=struct.name, style="space_platform_title_short"}
  --local rename_button = name_flow.add{ type = "sprite-button", name="rename", sprite="utility/rename_icon_normal", tooltip={"space-exploration.rename-something", {"entity-name.rocket-launch-pad"}}, style="space_platform_sprite_button_small"}

  local bar

  container.add{ type="label", name="crew_capsules", caption="Space Capsule: "}
  bar = container.add{ type="progressbar", name="crew_capsules_progress", size = 300, value=0, style="space_platform_progressbar_capsule"}
  bar.style.horizontally_stretchable  = true

  container.add{ type="label", name="rocket_sections", caption="Rocket Sections: "}
  bar = container.add{ type="progressbar", name="rocket_sections_progress", size = 300, value=0, style="space_platform_progressbar_sections"}
  bar.style.horizontally_stretchable  = true

  container.add{ type="label", name="fuel_capacity", caption="Liquid Rocket Fuel: "}
  bar = container.add{ type="progressbar", name="fuel_capacity_progress", size = 300, value=0, style="space_platform_progressbar_fuel"}
  bar.style.horizontally_stretchable  = true

  container.add{ type="label", name="cargo_capacity", caption="Cargo: "}
  bar = container.add{ type="progressbar", name="cargo_capacity_progress", size = 300, value=0, style="space_platform_progressbar_cargo"}
  bar.style.horizontally_stretchable  = true

  container.add{ type="label", name="trigger-label", caption="Launch Trigger"}

  local list, selected_index = dropdown_from_preset(Launchpad.trigger_options, struct.launch_trigger)
  local trigger_dropdown = container.add{ type="drop-down", name="trigger", items=list, selected_index = selected_index}
  trigger_dropdown.style.horizontally_stretchable  = true

  container.add{ type="label", name="destination-label", caption="Destination:"}
  container.add{type="checkbox", name="list-zones-alphabetical", caption="List destinations alphabetically", state=playerdata.zones_alphabetical and true or false}

  local filter_container = container.add{ type="flow", name="filter_flow", direction="horizontal"}
  local filter_field = filter_container.add{ type="textfield", name="filter_list"}
  filter_field.style.width = 275
  local filter_button = filter_container.add{ type = "sprite-button", name="clear_filter", sprite="utility/search_icon", tooltip={"space-exploration.clear-filter"},}
  filter_button.style.left_margin = 5
  filter_button.style.width = 28
  filter_button.style.height = 28

  local destination_zone = struct.destination.zone
  local list, selected_index, values = Zone.dropdown_list_zone_destinations(struct.force_name, destination_zone, playerdata.zones_alphabetical, nil,
    {list = "Any landing pad with name", value = {type = "any"}} -- wildcard
  )
  if selected_index == 1 then selected_index = 2 end
  local zones_dropdown = container.add{ type="drop-down", name="launchpad-list-zones", items=list, selected_index=selected_index or 2}
  zones_dropdown.style.horizontally_stretchable  = true
  player_set_dropdown_values(player, "launchpad-list-zones", values)

  container.add{ type="label", name="destination-location-label", caption="Destination Position:"}
  local destination_pad_name = struct.destination.landing_pad_name
  local list, selected_index, values, landingpads_dropdown
  if destination_zone then
    list, selected_index, values = Landingpad.dropdown_list_zone_landing_pad_names(struct.force_name, destination_zone, destination_pad_name)
    landingpads_dropdown = container.add{ type="drop-down", name="launchpad-list-landing-pad-names", items=list, selected_index=selected_index}
    player_set_dropdown_values(player, "launchpad-list-landing-pad-names", values)
  else
    list, selected_index, values = Landingpad.dropdown_list_force_landing_pad_names(struct.force_name, destination_pad_name)
    landingpads_dropdown = container.add{ type="drop-down", name="launchpad-list-landing-pad-names", items=list, selected_index=selected_index}
    player_set_dropdown_values(player, "launchpad-list-landing-pad-names", values)
  end
  landingpads_dropdown.style.horizontally_stretchable  = true

  container.add{ type="label", name="cargo_loss", caption="Cargo safety:"}
  container.add{ type="label", name="survivability_loss", caption="Landing chance:"}

  container.add{ type="label", name="status", caption="Status: "}

  Launchpad.gui_update(player)

end

function Launchpad.on_gui_click(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  root = gui_element_or_parent(element, Launchpad.name_rocket_launch_pad_gui_root)
  if not root then return end
  struct = Launchpad.from_unit_number(root.unit_number.children_names[1])
  if not struct then return end
  if element.name == "trigger" then

    struct.launch_trigger = selected_name_from_dropdown_preset(element, Launchpad.trigger_options) or "none"

  elseif element.name == "launchpad-list-zones" then

    local value = player_get_dropdown_value(player, element.name, element.selected_index)
    if type(value) == "table" then
      if value.type == "zone" then
        local zone_index = value.index
        local zone = Zone.from_zone_index(zone_index)
        if zone then
          struct.destination.zone = zone
          Log.trace("set destination to location: " .. zone.name )
        end
        local pad_names = element.parent["launchpad-list-landing-pad-names"]
        local destination_pad_name = struct.destination.landing_pad_name
        local list, selected_index, values = Landingpad.dropdown_list_zone_landing_pad_names(struct.force_name, struct.destination.zone, destination_pad_name)
        pad_names.items = list
        pad_names.selected_index = selected_index
        player_set_dropdown_values(player, "launchpad-list-landing-pad-names", values)
      elseif value.type == "spaceship" then
        local spaceship_index = value.index
        local spaceship = Spaceship.from_index(spaceship_index)
        if spaceship then
          struct.destination.zone = spaceship
          Log.trace("set destination to spaceship : " .. spaceship.name )
        end
        local pad_names = element.parent["launchpad-list-landing-pad-names"]
        local destination_pad_name = struct.destination.landing_pad_name
        local list, selected_index, values = Landingpad.dropdown_list_zone_landing_pad_names(struct.force_name, struct.destination.zone, destination_pad_name)
        pad_names.items = list
        pad_names.selected_index = selected_index
        player_set_dropdown_values(player, "launchpad-list-landing-pad-names", values)
      elseif value.type == "any" then
        struct.destination.zone = nil
        Log.trace("set destination to location: any")
        local pad_names = element.parent["launchpad-list-landing-pad-names"]
        local destination_pad_name = struct.destination.landing_pad_name
        local list, selected_index, values = Landingpad.dropdown_list_force_landing_pad_names(struct.force_name, destination_pad_name)
        pad_names.items = list
        pad_names.selected_index = selected_index
        player_set_dropdown_values(player, "launchpad-list-landing-pad-names", values)
      end
      Launchpad.gui_update(player)
    else
      Launchpad.gui_close(player)
      Log.trace("Error: Non-table value ")
    end

  elseif element.name == "launchpad-list-landing-pad-names" then

    local value = player_get_dropdown_value(player, element.name, element.selected_index)
    local landing_pad_name = value
    if landing_pad_name and landing_pad_name ~= "" then
      struct.destination.landing_pad_name = landing_pad_name
      Log.trace("set destination to landing_pad " .. landing_pad_name )
    else
      struct.destination.landing_pad_name = nil
    end

  elseif element.name == "launch" then
    Launchpad.launch(struct, false, true)
  elseif element.name == "clear_filter" then
    element.parent.filter_list.text = ""
    Launchpad.gui_update_destinations_list(player)
  elseif element.name == Launchpad.name_window_close then
    Launchpad.gui_close(player)
  end
end
Event.addListener(defines.events.on_gui_click, Launchpad.on_gui_click)
Event.addListener(defines.events.on_gui_selection_state_changed, Launchpad.on_gui_click)

function Launchpad.gui_update_destinations_list(player)
  local playerdata = get_make_playerdata(player)
  local root = player.gui.left[Launchpad.name_rocket_launch_pad_gui_root]
  if root then

    local filter = nil
    if root.filter_flow and root.filter_flow.filter_list then
      filter = string.trim(root.filter_flow.filter_list.text)
      if filter == "" then
        filter = nil
      end
    end

    -- update the list
    local destination_zone = struct.destination.zone
    local list, selected_index, values = Zone.dropdown_list_zone_destinations( struct.force_name, destination_zone, playerdata.zones_alphabetical, filter,
      {list = "Any landing pad with name", value = {type = "any"}} -- wildcard
    )
    if selected_index == 1 then selected_index = 2 end
    root["launchpad-list-zones"].items = list
    root["launchpad-list-zones"].selected_index = selected_index or 2
    player_set_dropdown_values(player, "launchpad-list-zones", values)

  end
end

function Launchpad.on_gui_checked_state_changed(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  local root = gui_element_or_parent(element, Launchpad.name_rocket_launch_pad_gui_root)
  if not root then return end
  struct = Launchpad.from_unit_number(root.unit_number.children_names[1])
  if not struct then return end
  if element.name == "list-zones-alphabetical" then
    local playerdata = get_make_playerdata(player)
    playerdata.zones_alphabetical = element.state
    Launchpad.gui_update_destinations_list(player)
  end
end
Event.addListener(defines.events.on_gui_checked_state_changed, Launchpad.on_gui_checked_state_changed)

function Launchpad.on_gui_text_changed(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  local root = gui_element_or_parent(element, Launchpad.name_rocket_launch_pad_gui_root)
  if root then -- remote view
    if element.name == "filter_list" then
      Launchpad.gui_update_destinations_list(player)
    end
  end
end
Event.addListener(defines.events.on_gui_text_changed, Launchpad.on_gui_text_changed)

function Launchpad.on_player_driving_changed_state(event)
  local player = game.players[event.player_index]
  if player then
    if player.vehicle and player.vehicle.name == Launchpad.name_rocket_launch_pad_seat then

      local armor_inv = player.get_inventory(defines.inventory.character_armor)
      if not(armor_inv and armor_inv[1] and armor_inv[1].valid_for_read and Util.table_contains(name_thruster_suits, armor_inv[1].name)) then
        player.print({"space-exploration.launch-suit-warning"})
      end

      local launch_pad_entity = player.surface.find_entities_filtered{
        limit = 1,
        area = util.position_to_area(util.vectors_add(player.position, {x = 0, y = -5}), 5),
        name = Launchpad.name_rocket_launch_pad
      }[1]
      if launch_pad_entity then
        Launchpad.gui_open(player, Launchpad.from_entity(launch_pad_entity))
      end
    end
  end
end
Event.addListener(defines.events.on_player_driving_changed_state, Launchpad.on_player_driving_changed_state)

function Launchpad.on_entity_created(event)  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.name == Launchpad.name_rocket_launch_pad then
    local fn = entity.force.name

    local zone = Zone.from_surface(entity.surface)

    if not zone then
      return cancel_entity_creation(entity, event.player_index, "Invalid launch pad location")
    end

    local default_name = zone.name
    local default_destination_zone = zone
    if zone.orbit then
      default_destination_zone = zone.orbit
    elseif zone.parent and zone.parent.type ~= "star" then
      default_destination_zone = zone.parent
    end
    local struct = {
      type = Launchpad.name_rocket_launch_pad,
      valid = true,
      force_name = fn,
      unit_number = entity.unit_number,
      container = entity,
      name = default_name,
      rocket_sections = 0,
      crew_capsules = 0,
      launch_trigger = "none",
      lua_fuel = 0,
      total_fuel = 0,
      zone = zone,
      destination = {
        zone = default_destination_zone
      },
      launch_status = -1
    }
    global.rocket_launch_pads[entity.unit_number] = struct

    Launchpad.name(struct) -- assigns to zone_assets

    Launchpad.add_section_input(struct)

    -- spawn combinator
    struct.combinator = entity.surface.create_entity{
      name = Launchpad.name_rocket_launch_pad_combinator,
      force = entity.force,
      position = {entity.position.x, entity.position.y}}
    entity.connect_neighbour({wire = defines.wire_type.red, target_entity = struct.combinator})
    entity.connect_neighbour({wire = defines.wire_type.green, target_entity = struct.combinator})
    struct.combinator.destructible = false

    -- spawn silo
    struct.silo = entity.surface.create_entity{
      name = Launchpad.name_rocket_launch_pad_silo,
      force = entity.force,
      position = {entity.position.x, entity.position.y + 1/32}} -- 1 px down to be in front of container
    struct.silo.destructible = false

    -- spawn settings
    struct.settings = entity.surface.create_entity{
      name = Launchpad.name_rocket_launch_pad_settings,
      force = entity.force,
      position = {entity.position.x, entity.position.y}}
    struct.settings.destructible = false

    -- spawn storage tank
    struct.tank = entity.surface.create_entity{
      name = Launchpad.name_rocket_launch_pad_tank,
      force = entity.force,
      position = {entity.position.x, entity.position.y + 1}} -- 1 tile down to be in front of silo
    struct.tank.fluidbox.set_filter(1, {name = name_fluid_rocket_fuel, force = true})
    entity.connect_neighbour({wire = defines.wire_type.red, target_entity = struct.tank})
    entity.connect_neighbour({wire = defines.wire_type.green, target_entity = struct.tank})
    struct.tank.destructible = false

    struct.seats = {}
    -- spawn passenger seats
    for i = -2, 2, 1 do
      local seat = entity.surface.create_entity{
        name = Launchpad.name_rocket_launch_pad_seat,
        force = entity.force,
        position = {entity.position.x + i, entity.position.y + 5.9}}
      seat.destructible = false
      table.insert(struct.seats, seat)
    end

    if event.player_index and game.players[event.player_index] and game.players[event.player_index].connected then
      Launchpad.gui_open(game.players[event.player_index], struct)
    end
  end
end
Event.addListener(defines.events.on_built_entity, Launchpad.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, Launchpad.on_entity_created)
Event.addListener(defines.events.script_raised_built, Launchpad.on_entity_created)
Event.addListener(defines.events.script_raised_revive, Launchpad.on_entity_created)


function Launchpad.get_struct_type_table(struct)
  local zone_assets = Zone.get_force_assets(struct.force_name, struct.zone.index)
  if struct.type == Launchpad.name_rocket_launch_pad then
    zone_assets.rocket_launch_pad_names = zone_assets.rocket_launch_pad_names or {}
    return zone_assets.rocket_launch_pad_names
  end
end

function Launchpad.remove_struct_from_table(struct)
  local type_table = Launchpad.get_struct_type_table(struct)
  if not type_table[struct.name] then return end
  type_table[struct.name][struct.unit_number] = nil
  local count_remaining = 0
  for _, remaining in pairs(type_table[struct.name]) do
    count_remaining = count_remaining + 1
  end
  if count_remaining == 0 then
    type_table[struct.name] = nil
  end
end

function Launchpad.destroy_sub(struct, key)
  if struct[key] and struct[key].valid then
    struct[key].destroy()
    struct[key] = nil
  end
end

function Launchpad.destroy(struct, player_index)
  if not struct then
    Log.trace("struct_destroy: no struct")
    return
  end

  struct.valid = false

  local capsules = struct.crew_capsules or 0
  local sections = struct.rocket_sections or 0

  if player_index then
    local player = game.players[player_index]
    if player and player.connected then
      if capsules > 0 then
          local inserted = player.insert{name = Capsule.name_space_capsule, count = capsules}
          capsules = capsules - inserted
      end
      if sections > 0 then
          local inserted = player.insert{name = Launchpad.name_rocket_section, count = sections}
          sections = sections - inserted
      end
    end
  end

  if struct.container and struct.container.valid then

    local position = struct.container.position
    local surface = struct.container.surface

    if capsules > 0 then
      surface.spill_item_stack(position, {name = Capsule.name_space_capsule, count = capsules}, true, struct.container.force, false)
    end

    if sections > 0 then
      surface.spill_item_stack(position, {name = Launchpad.name_rocket_section, count = sections}, true, struct.container.force, false)
    end
  end

  Launchpad.destroy_sub(struct, 'container')
  Launchpad.destroy_sub(struct, 'section_input')
  Launchpad.destroy_sub(struct, 'tank')
  Launchpad.destroy_sub(struct, 'silo')
  Launchpad.destroy_sub(struct, 'combinator')
  Launchpad.destroy_sub(struct, 'settings')
  for _, seat in pairs(struct.seats or {}) do
    if seat and seat.valid then seat.destroy() end
  end
  struct.seats = nil
  Launchpad.remove_struct_from_table(struct)
  global.rocket_launch_pads[struct.unit_number] = nil

  -- if a player has this gui open then close it
  local gui_name = Launchpad.name_rocket_launch_pad_gui_root
  for _, player in pairs(game.connected_players) do
    if player.gui.left[gui_name]
      and player.gui.left[gui_name].unit_number.children_names[1] == ""..struct.unit_number
    then
      player.gui.left[gui_name].destroy()
    end
  end


end

function Launchpad.name(struct, new_name)
    struct.name = (new_name or struct.name)
    local type_table = Launchpad.get_struct_type_table(struct)
    type_table[struct.name] = type_table[struct.name] or {}
    type_table[struct.name][struct.unit_number] = struct
end

function Launchpad.rename(struct, new_name)
    local old_name = struct.name
    Launchpad.remove_struct_from_table(struct)
    Launchpad.name(struct, new_name)
end

function Launchpad.on_entity_removed(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == Launchpad.name_rocket_launch_pad then
    Launchpad.destroy(Launchpad.from_entity(entity), event.player_index )
  end
end
Event.addListener(defines.events.on_entity_died, Launchpad.on_entity_removed)
Event.addListener(defines.events.on_robot_mined_entity, Launchpad.on_entity_removed)
Event.addListener(defines.events.on_player_mined_entity, Launchpad.on_entity_removed)
Event.addListener(defines.events.script_raised_destroy, Launchpad.on_entity_removed)

function Launchpad.on_gui_opened(event)
  local player = game.players[event.player_index]
  if event.entity and event.entity.valid and event.entity.name == Launchpad.name_rocket_launch_pad then
    Launchpad.gui_open(player, Launchpad.from_entity(event.entity))
  else
    -- the trick here is opeining the craft menu to cancel the other menu, then exiting the craft menu
    -- means that pressing e exits the custom gui
    if event.gui_type and event.gui_type ~= defines.gui_type.none then
      if player.gui.left[Launchpad.name_rocket_launch_pad_gui_root] then
          if player.opened_self then
            player.opened = nil
          end
          Launchpad.gui_close(player)
      end
    end
  end
end
Event.addListener(defines.events.on_gui_opened, Launchpad.on_gui_opened)


function Launchpad.on_tick(struct)
  --local profiler = game.create_profiler()
  for _, struct in pairs(global.rocket_launch_pads) do
    if (struct.launch_status and struct.launch_status > 0) or (game.tick + struct.unit_number) % 60 == 0 then
      Launchpad.tick(struct, force_name)
    end
  end
  if game.tick % 60 == 0 then
    for _, player in pairs(game.connected_players) do
      Launchpad.gui_update(player)
    end
  end
  --game.print(profiler)
end
Event.addListener(defines.events.on_tick, Launchpad.on_tick)


function Launchpad.on_init(event)
    global.rocket_launch_pads = {}
end
Event.addListener("on_init", Launchpad.on_init, true)


return Launchpad
