Util = require("scripts/util") util = Util
Event = require('scripts/event')

Jetpack = require('scripts/jetpack')

function raise_event(event_name, event_data)
  local responses = {}
  for interface_name, interface_functions in pairs(remote.interfaces) do
      if interface_functions[event_name] then
          responses[interface_name] = remote.call(interface_name, event_name, event_data)
      end
  end
  return responses
end

remote.add_interface(
  "jetpack",
  {
    get_jetpacks = function(data)
      if data.surface_index then
        local jetpacks = {}
        for _, jetpack in pairs(global.jetpacks) do
          if jetpack and jetpack.character and jetpack.character.valid then
            if data.surface_index == jetpack.character.surface.index then
              jetpacks[jetpack.character.unit_number] = jetpack
            end
          end
        end
        return jetpacks
      end
      return global.jetpacks
    end,
--/c remote.call("jetpack", "block_jetpack", {character=game.player.character})
    block_jetpack = function(data) -- prevents activation on character
      if data.character and data.character.valid then
        global.disabled_on = global.disabled_on or {}
        global.disabled_on[data.character.unit_number] = data.character.unit_number
      end
    end,
--/c remote.call("jetpack", "unblock_jetpack", {character=game.player.character})
    unblock_jetpack = function(data) -- allows activation on character
      if data.character and data.character.valid then
        global.disabled_on[data.character.unit_number] = nil
      end
    end,
    stop_jetpack_immediate = function(data) -- returns the new character.
      if data.character then
        if string.find(data.character.name, Jetpack.name_character_suffix, 1, true) then
          return Jetpack.swap_character(data.character, util.replace(data.character.name, Jetpack.name_character_suffix, ""))
          -- Note: other jetpack data will be cleaned up automatically
        end
      end
    end,
    set_velocity = function(data)
      if data.unit_number and global.jetpacks[data.unit_number] and data.velocity and data.velocity.x and data.velocity.y then
        global.jetpacks[data.unit_number].velocity = data.velocity
      end
    end
  }
)
