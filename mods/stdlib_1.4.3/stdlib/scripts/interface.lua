--[[
    A basic interface script, with generic functions
    usage:
    local interface = require(__stdlib__/stdlib/scripts/interface)
    interface.myfunc = function() end
    remote.add_interface(script.mod_name, interface)
    interface.myfunc2 = function() end -- Can even add new functions afterwards!
]]
local interface = {}
local Table = require('__stdlib__/stdlib/utils/table')

local Event = require('__stdlib__/stdlib/event/event')
local Game = require('__stdlib__/stdlib/game')
local Changes = require('__stdlib__/stdlib/event/changes')
local Player = require('__stdlib__/stdlib/event/player')
local Force = require('__stdlib__/stdlib/event/force')

local serp_settings = {comment = false, nocode = true}

interface['get_global'] = function()
    return global
end

interface['write_global'] = function()
    game.remove_path(script.mod_name)
    game.write_file(script.mod_name .. '/global.lua', serpent.block(global, serp_settings), false)
    game.write_file(script.mod_name .. '/global.inspect.lua', inspect(global), false)
    game.write_file(script.mod_name .. '/package.loaded.lua', serpent.block(Table.keys(package.loaded, true), serp_settings), false)
    if remote.interfaces[script.mod_name] then
        game.write_file(script.mod_name .. '/interfaces.lua', serpent.block(Table.keys(remote.interfaces[script.mod_name], true, true), serp_settings))
    end
    local global_keys = {}
    for k, v in pairs(_G) do
        global_keys[k] = (type(v) == 'string' or type(v) == 'number' or type(v) == 'boolean') and v or type(v)
    end
    game.write_file(script.mod_name .. '/_G.lua', serpent.block(global_keys, serp_settings), false)
    Event.dump_data()
    Player.dump_data()
    Force.dump_data()
    Changes.dump_data()
end

interface['get_globals'] = function()
    local globals = {}
    for inter, face in pairs(remote.interfaces) do
        for func in pairs(face) do
            if func == 'get_global' then
                globals[inter] = remote.call(inter, "get_global")
            end
        end
    end
    return globals
end
local ignore_defines = Table.invert{'anticolor', 'lightcolor', 'color', 'time'}

interface['dump_all'] = function()
    game.remove_path('Interfaces')
    game.write_file('defines.lua', serpent.block(defines, {comment = false, nocode = true, name = 'defines', keyignore = ignore_defines}))
    game.write_file('interfaces.lua', inspect(remote.interfaces))
    for inter, face in pairs(remote.interfaces) do
        game.write_file('Interfaces/' .. inter .. '.lua', inspect(remote.interfaces[inter]))
        for func in pairs(face) do
            if func:find('^write%_') then
                remote.call(inter, func)
            end
        end
    end
    Game.write_mods()
    Game.write_surfaces()
    Game.write_statistics()
    game.print('Finished writing all data to script-output')
end

interface['merge_interfaces'] = function(tab)
    Table.merge(interface, tab, false)
    return interface
end

return interface
