--- Force setup
-- @module forces
-- NPE Scripts to set up and configure forces

local locations = require(mod_name .. ".lualib.locations")

local forces = {}

forces.init = function()
  --create required forces
  game.pollution_statistics.clear()
  local bystander = game.forces['bystander'] or game.create_force('bystander')
  game.create_force('pre-placed')
  game.create_force('train-gate')
  local peaceful = game.forces['peaceful'] or game.create_force('peaceful')
  local enemy = game.forces['enemy']
  local player = game.forces['player']
  player.item_production_statistics.clear()
  player.fluid_production_statistics.clear()
  player.kill_count_statistics.clear()
  player.entity_build_count_statistics.clear()


  --configure player force
  game.forces.player.clear_chart()
  game.forces['player'].disable_all_prototypes()

  --peaceful_mode off
  locations.get_main_surface().peaceful_mode = false

  --configure cease fires
  peaceful.set_cease_fire('player',true)
  peaceful.set_friend('player',true)
  peaceful.set_friend('enemy',true)
  peaceful.set_friend('bystander',false)
  enemy.set_friend('peaceful',true)
  enemy.set_friend('player',false)
  enemy.set_cease_fire('player',false)
  player.set_friend('enemy',false)
  player.set_cease_fire('enemy',false)
  peaceful.set_cease_fire('bystander',false)
  peaceful.set_cease_fire('enemy',true)
  peaceful.set_cease_fire('neutral',true)
  bystander.set_cease_fire('player',true)
  bystander.set_friend('player',true)
  bystander.set_cease_fire('enemy',false)

  for _, technology in pairs(game.forces['player'].technologies) do
    technology.enabled = false
  end
  for _, recipe in pairs(game.forces['player'].recipes) do
    recipe.enabled = false
  end
end

local on_player_created = function(event)
  game.players[event.player_index].minimap_enabled =
    game.players[event.player_index].force.technologies['basic-mapping'] and
    game.players[event.player_index].force.technologies['basic-mapping'].researched

  if #game.forces['player'].connected_players > 1 then
    game.players[event.player_index].character = nil
    error("Only one player can play the NPE")
  end
  game.players[event.player_index].game_view_settings.show_research_info = false
  game.players[event.player_index].game_view_settings.show_side_menu = false
  game.players[event.player_index].game_view_settings.show_minimap = false
  --game.players[event.player_index].game_view_settings.show_controller_gui = false
end

forces.events =
{
  [defines.events.on_player_created] = on_player_created
}

return forces


