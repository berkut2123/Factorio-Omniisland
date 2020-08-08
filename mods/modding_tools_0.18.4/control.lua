function daytime_to_clock(value)
value = value+0.5
value = value % 1
value = value * 24
local minute = math.floor((value % 1) * 60)
if minute < 10 then
minute= "0"..minute
end
value = math.floor(value)
return value..":"..minute
end

function bool2color(bool)
if bool then 
	return {r=0.1,g=1,b=0.1}
else 
	return {r=1,g=0.1,b=0.1}
end
end

function bool2darkcolor(bool)
if bool then 
	return {r=0,g=1,b=0}
else 
	return {r=1,g=0,b=0}
end
end

function create_gui (player)
	if not player.gui.left.modding_gui then
		local gui = player.gui.left.add{type = "frame", name = "modding_gui", caption = "", direction = "vertical"}
		gui.style.left_padding  = 0
		gui.style.right_padding = 0
		gui.style.bottom_padding = 0
		gui.style.top_padding = 0
		--gui.style.top_padding 		= 1
		--gui.style.right_padding 	= 4
		--gui.style.bottom_padding 	= 4
		--gui.style.left_padding 		= 4
		--gui.style.scaleable 		= false
		--init_gui_player(game.players[event.player_index])
		local tbl = gui.add{type = "table", name = "mod_table", column_count=1, direction = "vertical"}
		tbl.style.vertical_spacing = 0
		temp = tbl.add{type = "button", name = "mod_alltechs", caption = "All Techs", direction = "vertical"}
		temp.style.font = "default-small"
		--temp.style.height = 20
		temp.style.top_padding = 0
		temp.style.bottom_padding = 0
		temp.style.horizontally_stretchable=true
		temp = tbl.add{type = "button", name = "mod_instantresearch", caption = "InstantResearch", direction = "vertical"}
		temp.style.font = "default-small"
		--temp.style.height = 20
		temp.style.top_padding = 0
		temp.style.bottom_padding = 0
		temp.style.horizontally_stretchable=true
		temp.style.font_color=bool2color(false)
		temp.style.hovered_font_color =bool2darkcolor(false)
		local temp = tbl.add{type = "button", name = "mod_cheatmode", caption = "Cheatmode", direction = "vertical"}
		temp.style.font = "default-small"
		--temp.style.height = 20
		temp.style.top_padding = 0
		temp.style.bottom_padding = 0
		temp.style.horizontally_stretchable=true
		temp.style.font_color=bool2color(false)
		temp.style.hovered_font_color =bool2darkcolor(false)
		temp = tbl.add{type = "button", name = "mod_speed", caption = "GameSpeed x1", direction = "vertical"}
		temp.style.font = "default-small"
		--temp.style.height = 20
		temp.style.top_padding = 0
		temp.style.bottom_padding = 0
		temp.style.horizontally_stretchable=true
		temp.style.font_color=bool2color(false)
		temp.style.hovered_font_color =bool2darkcolor(false)
		temp = tbl.add{type = "button", name = "mod_daytime", caption = "Time: "..daytime_to_clock(player.surface.daytime), direction = "vertical"}
		temp.style.font = "default-small"
		--temp.style.height = 20
		temp.style.top_padding = 0
		temp.style.bottom_padding = 0
		temp.style.horizontally_stretchable=true
	end
end



script.on_event(defines.events.on_player_joined_game,function(event)
create_gui(game.players[event.player_index])
end)

script.on_init(function()
	for _, player in pairs(game.players) do
		create_gui(player)
	end
end)



script.on_event(defines.events.on_gui_click, function(event)
	local element = event.element
	if element.name == "mod_cheatmode" then
		game.players[event.player_index].cheat_mode = not game.players[event.player_index].cheat_mode 
		--event.element.caption = "Cheatmode "..bool2string(game.players[event.player_index].cheat_mode)
		event.element.style.font_color = bool2color(game.players[event.player_index].cheat_mode)
		event.element.style.hovered_font_color  = bool2darkcolor(game.players[event.player_index].cheat_mode)
	elseif element.name == "mod_alltechs" then
		for _, tech in pairs(game.players[event.player_index].force.technologies) do
			tech.researched = true
		end
	elseif element.name == "mod_instantresearch" then
		if game.players[event.player_index].force.current_research then
			game.players[event.player_index].force.current_research.researched = true
		end
		global.instant_research = not (global.instant_research)
		event.element.style.font_color = bool2color(global.instant_research)
		event.element.style.hovered_font_color  = bool2darkcolor(global.instant_research)
		--event.element.caption = "InstantResearch "..bool2string(global.instant_research)
	elseif element.name == "mod_speed" then
		if game.speed == 1 then
			game.speed = 10
			event.element.caption = "GameSpeed x10"
			event.element.style.font_color = bool2color(true)
			event.element.style.hovered_font_color  = bool2darkcolor(true)
		else
			game.speed = 1
			event.element.caption = "GameSpeed x1"
			event.element.style.font_color = bool2color(false)
			event.element.style.hovered_font_color  = bool2darkcolor(false)
		end
	elseif element.name == "mod_daytime" then
		local daytime = game.players[event.player_index].surface.daytime
		if daytime < 0.5 then
			game.players[event.player_index].surface.daytime = 0.5
		else
			game.players[event.player_index].surface.daytime = 1
		end
			game.players[event.player_index].gui.left.modding_gui.mod_table.mod_daytime.caption = "Time: "..daytime_to_clock(game.players[event.player_index].surface.daytime)
	end
end)
script.on_event(defines.events.on_research_started, function(event)

if global.instant_research then
	
	event.research.researched = true

end
end)



function table_length(tbl)
	if tbl == nil then
		return 0
	else
		local count = 0
		for _ in pairs(tbl) do
			count = count + 1
		end
		return count	
	end
end

script.on_nth_tick(17, function(event)
	for _,player in pairs(game.connected_players) do
		player.gui.left.modding_gui.mod_table.mod_daytime.caption = "Time: "..daytime_to_clock(player.surface.daytime)
	end
end)