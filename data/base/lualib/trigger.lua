local math2d = require("math2d")
local popup = require(mod_name .. '.lualib.popup')

-- This module is responsible for setting up trigger areas.
-- You add a trigger with add_trigger, then check if it has been entered with is_trigger_done.
-- When you are done with the trigger, you remove it with remove_trigger.
-- What makes this a little more complicated, is that it handles multiplayer. When a p[layer enters the trigger zone,
-- they will be frozen in place until the other players also arrive. There is a countdown displayed on all player's
-- screens, and if this expires and they still haven't arrived, they are teleported.

local trigger = {}

local trigger_data =  {
  triggers = {},
  current_trigger_data = nil
}

trigger.init = function()
  trigger_data = global.trigger_data or trigger_data
  global.trigger_data = trigger_data
end

trigger.on_load = function()
  trigger_data = global.trigger_data or trigger_data
end

-- essential measn whether to activate the teleport logic.
-- TODO: currently the code ignores essential, and always activates the teleport logic
trigger.add_trigger = function(name, bounding_box, essential)
  essential = essential or false

  assert(trigger_data.triggers[name] == nil)

  trigger_data.triggers[name] = {
    bounding_box = bounding_box,
    essential = essential,
    name = name,
    done = false
  }
end

trigger.is_trigger_done = function(name, remove_if_done)
  assert(trigger_data.triggers[name])

  local done = trigger_data.triggers[name].done

  if remove_if_done and done then
    trigger.remove_trigger(name)
  end

  return done
end

trigger.remove_trigger = function(name)
  print(serpent.block(trigger_data))

  assert(trigger_data.triggers[name])
  trigger_data.triggers[name] = nil

  -- Make sure we remove all effects of the trigger from all players
  if trigger_data.current_trigger_data and name == trigger_data.current_trigger_data.trigger.name then
    for _, player in pairs(game.players) do
      player.character_running_speed_modifier = 0
      popup.clear(player)
    end
    trigger_data.current_trigger_data = nil
  end
end

trigger.exists = function (name)
  return trigger_data.triggers[name] ~= nil
end

local check_triggers = function()
  for _, check_trigger in pairs(trigger_data.triggers) do
    if not check_trigger.done then
      local any_present = false

      for _, player in pairs(game.players) do
        if player.connected and math2d.bounding_box.contains_point(check_trigger.bounding_box, player.position) then
          any_present = true
          break
        end
      end

      if any_present then
        trigger_data.current_trigger_data = {
          trigger = check_trigger,
          ticks_left = 60 * 20
        }
        break
      end
    end
  end
end

local update_current_trigger = function()
  local present = {}
  local absent = {}

  for _, player in pairs(game.players) do
    if player.connected then
      if math2d.bounding_box.contains_point(trigger_data.current_trigger_data.trigger.bounding_box, player.position) then
        table.insert(present, player)
      else
        table.insert(absent, player)
      end
    end
  end

  if absent[1] then -- some players absent
    local seconds_left = math.floor(trigger_data.current_trigger_data.ticks_left / 60)

    for _, player in pairs(present) do
      popup.clear(player)
      player.character_running_speed_modifier = -1
      popup.create(player, {'campaign-trigger.waiting-for-other-players', seconds_left})
    end

    for _, player in pairs(absent) do
      popup.clear(player)

      if (trigger_data.current_trigger_data.ticks_left == 0) then
        local position = player.surface.find_non_colliding_position_in_box(player.character.prototype.name,
                                                                           trigger_data.current_trigger_data.trigger.bounding_box,
                                                                           0.2)
        player.teleport(position)
      else
        popup.create(player, {'campaign-trigger.go-to-checkpoint', seconds_left})
      end
    end

    trigger_data.current_trigger_data.ticks_left = trigger_data.current_trigger_data.ticks_left - 1
  else -- all players present
    popup.clear_all()

    trigger_data.triggers[trigger_data.current_trigger_data.trigger.name].done = true
    trigger_data.current_trigger_data = nil

    for _, player in pairs(present) do
      player.character_running_speed_modifier = 0
    end
  end
end

local on_tick = function()
  if trigger_data.current_trigger_data then
    update_current_trigger()
  else
    check_triggers()
  end
end

trigger.events = { [defines.events.on_tick] = on_tick }

return trigger