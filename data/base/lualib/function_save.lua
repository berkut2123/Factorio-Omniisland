local function_save = {}

local tick_functions = {}
local functions = {}
local init_done = false

function_save.add_function = function(name, func)
  assert(not init_done) -- functions must not be added after init, otherwise they wouldn't be save/load stable
  assert(functions[name] == nil)
  functions[name] = func
end

function_save.run = function(name, ...)
  functions[name](...)
end

function_save.exists = function(name)
  return functions[name] ~= nil
end

function_save.run_at_tick = function(tick, name, params)
  assert(functions[name])

  if tick_functions[tick] == nil then
    tick_functions[tick] = {}
  end

  table.insert(tick_functions[tick], {name, params})
end

function_save.init = function()
  global.function_save_tick_functions = tick_functions
end

function_save.on_load = function()
  init_done = true
  tick_functions = global.function_save_tick_functions or tick_functions
end

local on_tick = function()
  if tick_functions[game.tick] ~= nil then
    for _, function_data in pairs(tick_functions[game.tick]) do
      function_save.run(function_data[1], function_data[2])
    end

    tick_functions[game.tick] = nil
  end
end

function_save.events = { [defines.events.on_tick] = on_tick }


return function_save