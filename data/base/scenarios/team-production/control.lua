local team_production = require "team_production"

script.on_init(function ()
  team_production.on_init()
end)

script.on_event(defines.events.on_player_created, function(event)
  team_production.on_player_created(event)
end)

script.on_event(defines.events.on_player_joined_game, function(event)
  team_production.on_player_joined_game(event)
end)

script.on_event(defines.events.on_tick, function(event)
  team_production.on_tick(event)
end)

script.on_event(defines.events.on_built_entity, function(event)
  team_production.on_built_entity(event)
end)

script.on_event(defines.events.on_gui_click, function(event)
  team_production.on_gui_click(event)
end)

script.on_event(defines.events.on_gui_closed, function(event)
  team_production.on_gui_closed(event)
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(event)
  team_production.on_marked_for_deconstruction(event)
end)
