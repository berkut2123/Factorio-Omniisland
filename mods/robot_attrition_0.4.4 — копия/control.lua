Event = require('scripts/event')

min_attrition_rate = 0.0011
tickskip = 10

function get_attrition_rate_for_surface(surface_index)
  -- use cache
  if global.suface_attrition_rates[surface_index] then
    return global.suface_attrition_rates[surface_index]
  end
  -- or load
  local rate = nil
  local default_rate = settings.global["robot-attrition-factor"].value
  for interface, functions in pairs(remote.interfaces) do
    if functions["robot_attrition_for_surface"] then
      local returned_rate = remote.call(interface, "robot_attrition_for_surface", {default_rate = default_rate, surface_index = surface_index})
      if rate == nil or returned_rate > rate then
        rate = returned_rate
      end
    end
  end
  if rate == nil then
    rate = default_rate
  end
  global.suface_attrition_rates[surface_index] = rate
  --game.print("Robot attrition rate for surface " .. surface_index .. " ("..game.surfaces[surface_index].name..") is " .. rate)

  return rate
end

function get_bot_speed(name)
  if not global.bot_speed then global.bot_speed = {} end
  if not global.bot_speed[name] then
    global.bot_speed[name] = game.entity_prototypes[name].speed
  end
  return global.bot_speed[name]
end

function get_bot_slow_speed_multiplier(name)
  if not global.bot_slow_speed_multiplier then global.bot_slow_speed_multiplier = {} end
  if not global.bot_slow_speed_multiplier[name] then
    global.bot_slow_speed_multiplier[name] = game.entity_prototypes[name].speed_multiplier_when_out_of_energy
  end
  return global.bot_slow_speed_multiplier[name]
end

function bot_crash(bot, n_bots)

  local inventory = bot.get_inventory(defines.inventory.robot_cargo)
  local contents = inventory.get_contents()
  for name, count in pairs(contents) do
    bot.surface.spill_item_stack(bot.position, {name=name, count=count}, false, bot.force, false) --Spill, mark for decon, disallow belts
  end
  bot.get_inventory(defines.inventory.robot_cargo).clear()
  if global.forcedata and global.forcedata[bot.force.name] and global.forcedata[bot.force.name]["robot-attrition-explosion-safety"] then
    --  game.print("Skip explosion, n_bots < ".. 500 * global.forcedata[bot.force.name]["robot-attrition-explosion-safety"])
  else
    bot.surface.create_entity{name = "robot-explosion", position=bot.position}
  end
  bot.force.kill_count_statistics.on_flow(bot.name, -1) --Track bot's death.
  bot.destroy()
  global.bots_crashed = (global.bots_crashed or 0) + 1 -- used as an achievement metric

end

function process_bot(bot, n_bots)
    local force_speed_multiplier = 1 + bot.force.worker_robots_speed_modifier
    local speed = get_bot_speed(bot.name) * force_speed_multiplier
    local held_item_count = 0
    if bot.energy > 0 then
      local inventory = bot.get_inventory(defines.inventory.robot_cargo)
      held_item_count = inventory.get_item_count()
    else
      speed = 0.5 * speed * get_bot_slow_speed_multiplier(bot.name)
    end
    local speed_items = speed * (held_item_count + 0.5) -- carrying itself counts as 0.5 items
    local crash_score = speed_items
    bot_crash(bot, n_bots)
    return crash_score
end

function on_tick(event)
  --[[
  slowest funtions is by far: network.logistic_robots[i]
  so only do that once per explosion.
  which means that if a robot is selected it must die.
  but risk factors should still be speed * items carried
  so add these factors to the probability of the next selection round
  factors apply multiplier to next selection phase
  ]]--

  if game.tick % tickskip ~= 0 then return end

  --game.forces[force].logistic_networks[network].logistic_robots :: array of LuaEntity
  for _, force in pairs(game.forces) do
    local i = randint
    for surface_name, networks in pairs(force.logistic_networks) do
      local surface_attrition_rate = get_attrition_rate_for_surface(game.surfaces[surface_name].index)
      if surface_attrition_rate > min_attrition_rate then
        for _, network in pairs(networks) do
          local n_bots = network.all_logistic_robots - network.available_logistic_robots
          if n_bots > 50 then -- ignore small networks
            if not global.forces[force.name] then global.forces[force.name] = {} end
            if not global.forces[force.name][surface_name] then global.forces[force.name][surface_name] = { crash = 0, crash_rate = 0.1 } end
            local crash_rate = global.forces[force.name][surface_name].crash_rate * tickskip * surface_attrition_rate / 1000000
            local crash = global.forces[force.name][surface_name].crash + crash_rate * n_bots
            if crash > 0 then
              local logistic_robots = network.logistic_robots
              local i = math.random(math.floor((#logistic_robots + 1) * 0.8))
              crash = crash - 1
              global.forces[force.name][surface_name].crash_rate = global.forces[force.name][surface_name].crash_rate * 0.9 + 0.1 * process_bot(logistic_robots[i], n_bots)
              i = i + 1
              while crash > 100 do
                crash = crash - 1
                global.forces[force.name][surface_name].crash_rate = global.forces[force.name][surface_name].crash_rate * 0.9 + 0.1 * process_bot(logistic_robots[i], n_bots)
                i = i + 1
              end
            end
            global.forces[force.name][surface_name].crash = crash
          end
        end
      end
    end
  end
end

function on_init(event)
  global.forces = {}
  global.bot_speed = {}
  global.bot_slow_speed_multiplier = {}
  global.suface_attrition_rates = {}
end
function on_configuration_changed(event)
  global.forces = {}
  global.bot_speed = {}
  global.bot_slow_speed_multiplier = {}
  global.suface_attrition_rates = {} -- clear
end
function on_runtime_mod_setting_changed(event)
  if event.setting == "robot-attrition-factor" then
    global.suface_attrition_rates = {} -- clear
  end
end

function on_research_finished(event)
  local force = event.research.force
  if event.research.name == "robot-attrition-explosion-safety" then
    global.forcedata = global.forcedata or {}
    global.forcedata[force.name] = global.forcedata[force.name] or {}
    global.forcedata[force.name]["robot-attrition-explosion-safety"] = event.research.level - 1
  end
end

Event.addListener(defines.events.on_research_finished, on_research_finished)

-- standard events
Event.addListener(defines.events.on_tick, on_tick)
Event.addListener(defines.events.on_runtime_mod_setting_changed, on_runtime_mod_setting_changed)

Event.addListener("on_init", on_init, true)
Event.addListener("on_configuration_changed", on_configuration_changed, true)
