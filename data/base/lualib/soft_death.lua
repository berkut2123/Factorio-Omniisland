local cutscene = require(mod_name .. ".lualib.cutscene")

local soft_death_data = {
  active = true
}

local generate_death_cutscene = function(player)
  local new_scene = {
  type=defines.controllers.cutscene,
  waypoints={
    {
      position=player.position,
      transition_time=60*3,
      time_to_wait=0,
      zoom=2
    },
  },
  final_transition_time = 60
  }
  return new_scene
end

local on_player_died = function(event)
  if soft_death_data.active then
    if not game.is_multiplayer() then
      game.set_game_state({game_finished = false})
    end
    local player = game.players[event.player_index]
    if not (player and player.valid) then return end
    local death_scene = generate_death_cutscene(player)
    player.ticks_to_respawn = death_scene.waypoints[1].transition_time + 120
    cutscene.play(death_scene,{player})
  end
end

local soft_death = {}

soft_death.active = function(state)
  soft_death_data.active = state
end

soft_death.init = function()
  global.soft_death_data = soft_death_data
end

soft_death.on_load = function()
  soft_death_data = global.soft_death_data or soft_death_data
end

soft_death.events =
{
  [defines.events.on_player_died] = on_player_died,
}

return soft_death
