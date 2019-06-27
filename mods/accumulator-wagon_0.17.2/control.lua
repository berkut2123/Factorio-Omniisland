require('util')

-- wagon is parked, verify that it has a proxy accumulator created
local function ensure_proxy(entity, proxy_type)
  if not global.wagons[entity.unit_number] then
    global.wagons[entity.unit_number] = {}
  end
  local config = global.wagons[entity.unit_number]
  if config.proxy and config.proxy.valid then
    -- already a proxy, bail
    return
  else
    -- create entity of the right type
    local proxy = entity.surface.create_entity({
      name = proxy_type,
      position = entity.position,
      force = entity.force,
    })
    if not proxy then
      -- it didn't create for some reason
      return
    end
    if config.energy then
      -- set the proxy's energy to the prior energy state
      proxy.energy = config.energy
    end
    -- track the proxy
    config.proxy = proxy
    -- mark as active for on_nth_tick
    global.active_wagons[entity.unit_number] = entity
  end
end

-- wagon is moving, the proxy should go away.
local function ensure_no_proxy(entity)
  if global.wagons[entity.unit_number] and global.wagons[entity.unit_number].proxy then
    if global.wagons[entity.unit_number].proxy.valid then
      global.wagons[entity.unit_number].proxy.destroy()
    end
    global.wagons[entity.unit_number].proxy = nil
  end
end

-- entity removed, see if we need to remove any proxies
local function on_entity_gone(event)
  if event.entity and event.entity.valid and event.entity.name == "accumulator-wagon" then
    local unit_number = event.entity.unit_number
    if global.wagons[unit_number] then
      if global.wagons[unit_number].proxy and global.wagons[unit_number].proxy.valid then
        global.wagons[unit_number].proxy.destroy()
      end
      global.wagons[unit_number] = nil
    end
  end
end
script.on_event(defines.events.on_pre_player_mined_item, on_entity_gone)
script.on_event(defines.events.on_entity_died, on_entity_gone)
script.on_event(defines.events.script_raised_destroy, on_entity_gone)

local function get_proxy_type(train)
  local station = train.station
  -- first thing is to figure out which type - if we're just parked, always passive, if we're at a station, look for signals
  local proxy_type = "accumulator-wagon-proxy-passive"
  if station and station.valid then
    -- at a station, check for signals
    local signals = station.get_merged_signals()
    if signals then
      -- some signals present, check them.
      local charge = false
      local discharge = false
      for _, signal_table in ipairs(signals) do
        if signal_table.signal.name == "accumulator-wagon-charge" and signal_table.count > 0 then
          charge = true
        elseif signal_table.signal.name == "accumulator-wagon-discharge" and signal_table.count > 0 then
          discharge = true
        end
      end
      -- if one and not the other is positive, set the entity type
      if charge and not discharge then
        proxy_type = "accumulator-wagon-proxy-input"
      elseif discharge and not charge then
        proxy_type = "accumulator-wagon-proxy-output"
      end
    end
  end
  return proxy_type
end

-- on_nth_tick function for updating all currently parked accumulator wagons
local function check_active_wagons(event)
  -- track which trains have a state change so that we can bump their state later, for inactivity conditions
  local refresh_trains = {}
  for unit_number, entity in pairs(global.active_wagons) do
    if entity.valid then
      local config = global.wagons[entity.unit_number]
      if config and config.proxy and config.proxy.valid then
        -- train's still here, sync up the indicator fluid
        local fluidbox = entity.fluidbox[1]

        -- compare against last recorded level
        local prior_level = config.fluid_level or 0
        local current_level = (fluidbox and fluidbox.amount) or 0
        -- each point in fluid is 20kJ
        local energy_change = (current_level - prior_level) * 20000.0
        -- determine new energy level to set to
        local target_energy = config.proxy.energy + energy_change

        -- bound it just in case something crazy happened
        if target_energy < 0 then
          target_energy = 0
        elseif target_energy > 500000000 then
          target_energy = 500000000
        end

        -- set it back to the proxy
        config.proxy.energy = target_energy

        -- now we need to change the fluid level based on the current energy level
        local new_level = config.proxy.energy / 20000.0
        -- round it up if it's extremely close to full, to avoid floating point not-quite-full issues
        if new_level >= 24999.999 then
          new_level = 25000
        end
        config.fluid_level = new_level
        -- check difference between old and new level
        if math.abs(new_level - current_level) >= 0.5 then
          -- it's changed by at least half a percent, bump the train to refresh inactivity conditions
          refresh_trains[entity.train] = true
        end
        
        if new_level > 0.001 then
          -- at least some charge, set the fluid
          entity.fluidbox[1] = {
            name = "battery-fluid",
            amount = new_level,
          }
        else
          -- completely discharged, remove the fluid
          entity.fluidbox[1] = nil
        end

        -- if the signal situation has changed, swap for a proxy of a different type.
        local proxy_type = get_proxy_type(entity.train)
        if proxy_type ~= config.proxy.prototype.name then
          ensure_no_proxy(entity)
          ensure_proxy(entity, proxy_type)
          config.proxy.energy = target_energy
        end
      else
        -- proxy went away or config otherwise messed up, remove
        global.active_wagons[unit_number] = nil
      end
    else
      -- wagon went away, remove
      global.active_wagons[unit_number] = nil
    end
  end

  if settings.global["accumulator-wagon-update-inactivity-conditions"].value then
    -- bump all marked trains
    for train in pairs(refresh_trains) do
      if train.manual_mode == false then
        train.manual_mode = false
      end
    end
  end
  -- unregister if none left
  if not next(global.active_wagons) then
    script.on_nth_tick(30, nil)
  end
end

local function check_train(train)
  if train.state == defines.train_state.wait_station or train.state == defines.train_state.manual_control_stop or (train.state == defines.train_state.manual_control and train.speed == 0) then
    -- we're stopped, make sure we have accumulators
    local proxy_type = get_proxy_type(train)
    -- scan the train for any wagons to add proxies for
    for _, carriage in ipairs(train.fluid_wagons) do
      if carriage.name == "accumulator-wagon" then
        local config = global.wagons[carriage.unit_number]
        if not config then
          global.wagons[carriage.unit_number] = {}
          config = global.wagons[carriage.unit_number]
        end
        if not config.proxy then
          ensure_proxy(carriage, proxy_type)
        end
      end
    end
    -- enable the on_nth_tick handler to update the wagons if it isn't.
    if next(global.active_wagons) then
      script.on_nth_tick(30, check_active_wagons)
    end
  elseif train.state == defines.train_state.on_the_path or train.state == defines.train_state.manual_control then
    -- not at station, ensure no proxies
    for _, carriage in ipairs(train.fluid_wagons) do
      if carriage.name == "accumulator-wagon" then
        if global.active_wagons[carriage.unit_number] then
          local config = global.wagons[carriage.unit_number]
          if not config then
            global.wagons[carriage.unit_number] = {}
            config = global.wagons[carriage.unit_number]
          end
          -- save the energy level
          if config.proxy and config.proxy.valid then
            config.energy = config.proxy.energy
          end
          -- remove the proxy
          ensure_no_proxy(carriage)
        end
      end
    end
  end
end

local function on_train_changed_state(event)
  check_train(event.train)
end
script.on_event(defines.events.on_train_changed_state, on_train_changed_state)

local function on_built_entity(event)
  if event.created_entity and event.created_entity.valid and event.created_entity.name == "accumulator-wagon" then
    check_train(event.created_entity.train)
  end
end
script.on_event(defines.events.on_built_entity, on_built_entity)
script.on_event(defines.events.on_robot_built_entity, on_built_entity)
script.on_event(defines.events.script_raised_built, on_built_entity)

local function on_init()
  global.wagons = {}
  global.active_wagons = {}
end
script.on_init(on_init)

-- re-attach on_nth_tick for wagons active when save is loaded
local function on_load()
  if next(global.active_wagons) then
    script.on_nth_tick(30, check_active_wagons)
  end
end
script.on_load(on_load)
