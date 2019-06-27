--control.lua

script.on_event(defines.events.on_pre_player_died, function(event)
--script.on_event(defines.events.on_player_died, function(event)
	local player = game.players[event.player_index]
	local position = player.position
	local surface = event.surface 
	local force = player.force
	local deceased = player.name
  
	local seconds = math.floor(game.tick / 60)
	local minutes = math.floor(seconds / 60)
	local hours = math.floor(minutes / 60)
	local days = math.floor(hours / 24)
	local hourday = math.floor (hours-(days*24))
	local minday = math.floor (minutes-((hourday*60)+(days*24*60)))
	
	local text = player.name .. " RIP Day: " .. days ..", ".. hourday .. ":" .. minday

	force.add_chart_tag(game.players[event.player_index].surface,{position=position,text=text,icon={type="item",name="power-armor-mk2"}})

	for index,player in pairs(game.players) do  --loop through all players on the server
		player.print(deceased .. " killed at Day:" .. days .. ", " .. hourday .. ":" .. minday)
		player.print(deceased .. " death location marked on the map.")
	end
end)
