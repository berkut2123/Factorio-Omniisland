--- Cutscene Module
-- @script cutscene
-- Container module for cutscenes available in the game

local locations = require(mod_name .. ".lualib.locations")
local util = require("util")

local cutscene = {}

-- This data is saved in global
local cutscene_data =
{
  playing = false,
  last_waypoint = -1,
  last_waypoints = nil
}

function cutscene.play(scene, players)
  players = players or game.forces['player'].players

  scene = util.table.deepcopy(scene)
  scene.darkness_multiplier = scene.darkness_multiplier or 0.8

  cutscene_data.last_waypoints = scene.waypoints
  cutscene_data.playing = true

  game.autosave_enabled = false

  --convert string waypoints
  for _, waypoint in pairs(scene.waypoints) do
    if type(waypoint.position) == 'string' then
      waypoint.position = locations.get_pos(waypoint.position)
    end
  end
  for _, player in pairs(players) do
    assert(player.controller_type ~= defines.controllers.cutscene)
    if player.controller_type == defines.controllers.character or player.controller_type == defines.controllers.ghost then
      player.walking_state = {walking = false, direction = defines.direction.south}
      if player.character then
        player.character.destructible = false
      end
      player.set_controller(scene)
    end
  end
end

local refresh_cutscene_playing = function()
  if not cutscene_data.playing then
    return
  end

  local playing_cutscene = false
  for _, player in pairs(game.players) do
    if player.controller_type == defines.controllers.cutscene then
      playing_cutscene = true
      break
    end
  end

  if not playing_cutscene then
    game.autosave_enabled = true
    cutscene_data.playing = false
    cutscene_data.last_waypoint = -1

    for _, player in pairs(game.connected_players) do
      if player.controller_type == defines.controllers.character then
        player.character.destructible = true
      end
    end
  end
end

cutscene.is_any_cutscene_playing = function()
  refresh_cutscene_playing()
  return cutscene_data.playing
end

cutscene.init = function()
  global.cutscene_data = cutscene_data
end

cutscene.on_load = function()
  cutscene_data = global.cutscene_data or cutscene_data
end

cutscene.get_last_waypoint_reached = function()
  refresh_cutscene_playing()
  return cutscene_data.last_waypoint
end

cutscene.get_last_waypoint_reached_name = function()
  local last_index = cutscene.get_last_waypoint_reached()

  if cutscene_data.last_waypoints[last_index + 1] then
    return cutscene_data.last_waypoints[last_index + 1].name -- could be nil!
  end

  return nil
end

cutscene.cancel = function()
  for _, player in pairs(game.players) do
    if player.controller_type == defines.controllers.cutscene then
      player.exit_cutscene()

      if player.controller_type == defines.controllers.character then
        player.character.destructible = true
      end
    end
  end

  refresh_cutscene_playing()
  game.autosave_enabled = true
end

local on_cutscene_waypoint_reached = function(event)
  cutscene_data.last_waypoint = event.waypoint_index
end

local on_tick = function()
  if game.tick % (60 * 2) == 0 then
    -- make sure we always clean up (autosaves, indestructible, etc)
    refresh_cutscene_playing()
  end
end

cutscene.events =
{
  [defines.events.on_cutscene_waypoint_reached] = on_cutscene_waypoint_reached,
  [defines.events.on_tick] = on_tick
}

return cutscene
