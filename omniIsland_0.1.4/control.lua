--control.lua

research_landfill = function(force)
	if not force.technologies['landfill'].researched then
		force.technologies['landfill'].researched = true
	end
end

script.on_init(function()
	game.forces.player.set_spawn_position({x=0,y=0}, game.surfaces["nauvis"])
end)

script.on_event(defines.events.on_player_joined_game, function(e)
	research_landfill(game.players[e.player_index].force)
	game.players[e.player_index].force.set_spawn_position({x=0,y=0}, game.surfaces["nauvis"])
end)

script.on_event(defines.events.on_force_created, function(e)
	research_landfill(e.force)
	e.force.set_spawn_position({x=0,y=0}, game.surfaces["nauvis"])
end)

script.on_event(defines.events.on_chunk_generated, function(e)
	local minx = e.area.left_top.x
	local maxx = e.area.right_bottom.x
	local miny = e.area.left_top.y
	local maxy = e.area.right_bottom.y

	local radius = e.surface.map_gen_settings.starting_area * 150 -- radius of the starting circle
	local limit = (radius+64) * (radius+64) -- add some slop to catch the chunks around the circle

	if (minx*minx + miny*miny > limit) then
		return
	end

	local forced_map = {
		{
			center = {x=0, y=0},
			radius = 1.6,
			tile = "grass-1",
			remove_resources = true,
		},
		{
			center = {x=0, y=0},
			radius = 3.6,
			tile = "water",
		},
		{
			center = {x=0, y=0},
			radius = 99999999999999,
			tile = "deepwater",
		},
	}

	local function in_list (needle, haystack)
		for _,v in pairs(haystack) do
			if needle == v then
				return true
			end
		end
		return false
	end

	local starting_tile = false
	local tiles = {}
	for x=minx-1, maxx do
		for y=miny-1, maxy do
			for _,v in pairs(forced_map) do
				local dx = x - v.center.x
				local dy = y - v.center.y

				if dx*dx+dy*dy <= (v.radius * v.radius) then
					local existing = e.surface.get_tile(x,y).name
					if v.remove_resources then
						for _,r in pairs(e.surface.find_entities_filtered{area={{x-1, y-1},{x+1, y+1}}, type="resource"}) do
							r.destroy()
						end
					end
					if not v.tile_whitelist or not in_list(existing, v.tile_whitelist) then
						table.insert(tiles, {name=v.tile, position={x,y}})
						break
					end
				end
			end

			if x == 1 and y == 1 then
				starting_tile = true
			end
		end
	end

	e.surface.set_tiles(tiles)
	if starting_tile then
		local chest = e.surface.create_entity({name="iron-chest", position = {0, 0}, force=game.forces.player})
		chest.insert({name="landfill", count=200})
		chest.insert({name="offshore-pump", count=1})
		chest.insert({name="pipe", count=50})
		chest.insert({name="burner-omniphlog", count=2})
		chest.insert({name="omnite", count=250})
	end
end)

script.on_event(defines.events.on_player_created, function(e)
  local player = game.players[e.player_index]
  player.remove_item({name="burner-mining-drill"})
end)

script.on_event(defines.events.on_player_respawned, function(e)
  local player = game.players[e.player_index]
  player.remove_item({name="burner-mining-drill"})
end)
