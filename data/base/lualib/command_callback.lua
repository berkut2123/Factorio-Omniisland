local function_save = require(mod_name .. ".lualib.function_save")

local command_callback = {}
local command_callback_data =
{
  callbacks = {},
  commandables = {}
}

command_callback.add_callback = function(name, callback)
  function_save.add_function("COMMAND_CALLBACK_" .. name, callback)
end

local get_commandable_id_number = function(commandable)
  local unit_number

  -- A LuaEntity (unit) will throw if we try to access group_number, and a LuaUnitGroup will
  -- throw if we try to access unit_number, so, we use this hack for now.
  pcall(function() unit_number = commandable.unit_number end) -- TODO: get rid of this mess

  if unit_number == nil then
    unit_number = commandable.group_number
  end
  assert(unit_number ~= nil)

  return unit_number
end

command_callback.set_command = function(target, command, callback_name)
  callback_name = "COMMAND_CALLBACK_" .. callback_name
  assert(function_save.exists(callback_name))

  target.set_command(command)

  local unit_number = get_commandable_id_number(target)
  command_callback_data.callbacks[unit_number] = callback_name
  command_callback_data.commandables[unit_number] = target
end

local function on_ai_command_completed(event)
  if command_callback_data.commandables[event.unit_number] ~= nil then
    local callback = command_callback_data.callbacks[event.unit_number]
    local commandable = command_callback_data.commandables[event.unit_number]

    command_callback_data.callbacks[event.unit_number] = nil
    command_callback_data.commandables[event.unit_number] = nil
    function_save.run(callback, event.result, commandable)
  end
end

command_callback.init = function()
  global.command_callback_data = command_callback_data
end

command_callback.on_load = function()
  command_callback_data = global.command_callback_data or command_callback_data
end

command_callback.events = {
  [defines.events.on_ai_command_completed] = on_ai_command_completed
}

return command_callback
