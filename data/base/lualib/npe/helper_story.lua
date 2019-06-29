--- Test Scenario Conditions
-- @module compistory
-- A set of triggers and actions for Compilatron to guide the player

local story_table = require('helper-branches')
local locations = require(mod_name .. ".lualib.locations")
local story = require("story_2")

local cstory = {}

-- TODOS
-- ore has been produced but not plates for 2 minutes
-- lab, radar or am has no power for 30 seconds
-- low power for 2 minutes
-- player places steam engine or boiler in first area (display X)

cstory.init = function()
  global.timers = global.timers or {}
  global.behaviors = global.behaviors or {}
  global.next_help = nil
  global.compilatron.wait_position = locations.get_pos('compi-wait-crash') or {0,0}
  global.compilatron.reset = false

  story.init('compi_story', story_table)
end

cstory.set_paused = function(value)
  global.compi_story_paused = value
end

cstory.on_load = function()
  if campaign_debug_mode then
    print("ON_LOAD: helper story")
  end
  story.on_load('compi_story', story_table)
end

local story_update_when_player = function(event)
  if active_player() and not global.compi_story_paused then
    story.update('compi_story', event)
  end
end

cstory.migrate = function()
  if global.CAMPAIGNS_VERSION < 4 then
    if story.get_current_node_name('compi_story') == 'goto_random_belt' then
      story.jump_to_node('compi_story','evaluate-crash-site')
    end
  end

  if global.CAMPAIGNS_VERSION < 5 then
    if global.helper_memory == nil then
      global.helper_memory = {}
    end
  end
end

cstory.events = {
  [defines.events.on_tick] = story_update_when_player
}

return cstory
