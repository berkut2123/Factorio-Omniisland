
-- require "config" -- obsolet by settings.lua

local freq = 16
local freq2 = freq ^ 2
local totalgen = 0
local chunksize = 32
local original_tree_count = 0
local last_status="-"
local debug_text1="-"
local debug_text2="-"
local tile_whitelist= {"grass","dirt","landfill"} -- this should find any tile that has grass or dirt in the name, so "grass", "grass-dry" and "dirt-dark" etc.

local tree_names = {
	"tree-01",
	"tree-02",
	"tree-02-red",
	"tree-03",
	"tree-04",
	"tree-05",
	"tree-06",
	"tree-06-brown",
	"tree-07",
	"tree-08",
	"tree-08-brown",
	"tree-08-red",
	"tree-09",
	"tree-09-brown",
	"tree-09-red"
}

local function fmod(a,m)
	return a - math.floor(a / m) * m
end

local function log(msg)
	if settings.global["enable_debug_window"].value then
		print("NaturalTree mod:" .. msg)
	end
end

-- Pollution was too high to spawn a tree at thepos, so kill up to 3 surrounding trees
local function kill_surrounding_trees(thepos)
	bounds={{thepos[1]-5, thepos[2]-5}, {thepos[1]+5, thepos[2]+5}}
	strees=game.surfaces[1].find_entities_filtered{area = bounds, type="tree", limit= 3}
	for i=1,#strees do
		log("Killed tree due to pollution at "..strees[i].position.x..","..strees[i].position.y)
		strees[i].destroy()
	end
end

-- search area for specified entity names, return true if there are any.
local function test_entity(surface,area,names)
	for i = 1,#names do
		if 0 ~= surface.count_entities_filtered{area = area, type = names[i]} then
			return false
		end
	end
	return true
end

-- is the tile at newpos valid and a white-listed tile and pollution low enough (true)
local function test_tile(surface,newpos)
	tile = surface.get_tile(newpos[1],newpos[2])
	if not tile.valid then
		return false
	end
	for i = 1,#tile_whitelist do
		if string.find(tile.name, tile_whitelist[i]) then
			if surface.get_pollution({newpos[1],newpos[2]}) < settings.global["pollution_threshold"].value then
				return true
			else
				kill_surrounding_trees(newpos)
			end
		end
	end
	return false
end

-- is parameter a equal to any of the b's
local function eqany(a,b)
	for i = 1,#b do
		if a == b[i] then
			return true
		end
	end
	return false
end

-----------------------------------------
local shuffle_src = {}
local shuffle = {}
local shuffled = false

local function shuffle_it()
	for i = 1,freq do
		for j = 1,freq do
			shuffle_src[i * freq + j] = i * freq + j
		end
	end

	while 0 < #shuffle_src do
		local p = math.random(1,#shuffle_src)
		table.insert(shuffle, shuffle_src[p])
		table.remove(shuffle_src, p)
	end
end

-- Playermap is a 2-D map that indicates approximate location of player owned
-- entities. It is used for optimizing the algorithm to quickly determine proximity
-- of the player's properties which would be of player's interest.
-- Because LuaSurface.count_entities_filtered() is slow for large area, we want
-- to call it as few times as possible.
-- This is similar in function as chunks, but playermap element is greater than
-- chunks, because it's not good idea to make scripting languages like Lua
-- calculating large set of data. Also we only need very rough estimation, so
-- chunk granularity is too fine for us.
local playermap_freq = 4
local playermap = {}

local function update_player_map(m, surface)
	local mm = m % #shuffle + 1
	local mx = shuffle[mm] % freq
	local my = math.floor(shuffle[mm] / freq)
	for chunk in surface.get_chunks() do
		if fmod(chunk.x + mx, freq) == 0 and fmod(chunk.y + my, freq) == 0 and
			0 < surface.count_entities_filtered{area = {{chunk.x * chunksize, chunk.y * chunksize}, {(chunk.x + 1) * chunksize, (chunk.y + 1) * chunksize}}, force = "player"} then
			local px = math.floor(chunk.x / 4)
			local py = math.floor(chunk.y / 4)
			if playermap[py] == nil then
				playermap[py] = {}
			end
			playermap[py][px] = m
		end
	end
	
	if settings.global["enable_debug_window"].value then			
		local pp=game.players[1].position
		local ptile = surface.get_tile(pp.x, pp.y)
		local ppol=surface.get_pollution({pp.x, pp.y})
		debug_text1="Player is on " .. ptile.name
		debug_text2="Pollution:" .. math.floor(ppol)
	end
end

function on_tick(event)
	if not shuffled then
		shuffle_it()
		shuffled = true
	end
	-- LuaSurface.count_entities_filtered() is slow, LuaForce.get_entity_count() is much faster, but
	-- it needs entity name argument, not type. So we must repeat it for all types of trees.
	local function count_trees()
		local c=0
		for i=1,#tree_names do
			c = c + game.forces.neutral.get_entity_count(tree_names[i])
		end
		return c
	end

	local function grow_trees(m)
		local num = 0
		local allnum = 0
		local str = ""
		local mm = m % #shuffle + 1
		local mx = shuffle[mm] % freq
		local my = math.floor(shuffle[mm] / freq)
		local surface = game.surfaces[1]
		local totalc = 0
		for chunk in surface.get_chunks() do
			allnum = allnum + 1

			-- Check if any of player's entity is in proximity of this chunk.
			local function checkPlayerMap()
				local px = math.floor(chunk.x / 4)
				local py = math.floor(chunk.y / 4)
				for y=-1,1 do
					if playermap[py + y] then
						for x=-1,1 do
							if playermap[py + y][px + x] and m < playermap[py + y][px + x] + freq2 then
								return true
							end
						end
					end
				end
				return false
			end

			-- Grow trees on only the player's proximity since the player is not
			-- interested nor has means to observe deep in the unknown region.
			if fmod(chunk.x + mx, freq) == 0 and fmod(chunk.y + my, freq) == 0 and
				checkPlayerMap() then
				local area = {{chunk.x * chunksize, chunk.y * chunksize}, {(chunk.x + 1) * chunksize, (chunk.y + 1) * chunksize}}
				local c = surface.count_entities_filtered{area = area, type = "tree"}
				totalc = totalc + c
				if 0 < c then
					local trees = surface.find_entities_filtered{area = area, type = "tree"}
					if 0 < #trees then
						local nondeadtree = false
						local tree = trees[math.random(#trees)]
						-- Draw trees until we get a non-dead tree.
						for try = 1,10 do
							if not eqany(tree.name, {"dead-tree", "dry-tree", "dead-grey-trunk", "dry-hairy-tree", "dead-dry-hairy-tree"}) then
								nondeadtree = true
								break
							end
						end
						if nondeadtree then
							local newpos
							local success = false
							-- Try until randomly generated position does not block something.
							for try = 1,10 do
								if tree.valid then
									newpos = {tree.position.x + (math.random(-5,5)), tree.position.y + (math.random(-5,5))}
									local newarea = {{newpos[1] - 1, newpos[2] - 1}, {newpos[1] + 1, newpos[2] + 1}}
									local newarea2 = {{newpos[1] - 2, newpos[2] - 2}, {newpos[1] + 2, newpos[2] + 2}}
									if 0 == surface.count_entities_filtered{area = newarea, type = "tree"} and
									test_tile(surface, newpos) and
									0 == surface.count_entities_filtered{area = newarea2, force = "player"} and
									surface.can_place_entity{name = tree.name, position = newpos, force = tree.force} then
										success = true
										break
									end
								end
							end
							
							if success then
								num = num + 1
								surface.create_entity{name = tree.name, position = newpos, force = tree.force}
								log("Created new tree '" .. tree.name .. "' at "..newpos[1]..","..newpos[2])
							end
						end
					end
				end
			end
		end
		totalgen = totalgen + num
	end

	-- First, cache player map data by searching player owned entities.
	if game.tick % settings.global["tree_expansion_frequency"].value == 0 then
		local m = math.floor(game.tick / settings.global["tree_expansion_frequency"].value)
		update_player_map(m, game.surfaces[1])

	end

	-- Delay the loop as half a phase of update_player_map to reduce
	-- 'petit-freeze' duration as possible.
	if math.floor(game.tick + settings.global["tree_expansion_frequency"].value / 2) % settings.global["tree_expansion_frequency"].value == 0 then
		local m = math.floor(game.tick / settings.global["tree_expansion_frequency"].value)

		-- As number of trees grows, the growth rate decreases, maxes at settings.global["max_trees"].value.
		local numTrees = count_trees()
		if numTrees < settings.global["max_trees"].value * settings.global["tree_decrease_start"].value or
			numTrees < settings.global["max_trees"].value * (settings.global["tree_decrease_start"].value + math.random() * (1 - settings.global["tree_decrease_start"].value)) then
			grow_trees(m)
		end

		if settings.global["enable_debug_window"].value == true then -- ==true hinzugefügt
			-- Return [rows,active,visited] playermap chunks
			local function countPlayerMap()
				local ret = {0,0,0}
				for i,v in pairs(playermap) do
					ret[1] = ret[1] + 1
					for j,w in pairs(v) do
						if m < w + freq2 then
							ret[2] = ret[2] + 1
						end
						ret[3] = ret[3] + 1
					end
				end
				return ret
			end

			if not game.players[1].gui.left.trees then -- create GUI
				game.players[1].gui.left.add{type="frame", name="trees", caption="Debug Tree Info", direction="vertical"}
				game.players[1].gui.left.trees.add{type="label",name="m",caption="Cycle: " .. m % #shuffle .. "/" .. #shuffle}
				game.players[1].gui.left.trees.add{type="label",name="total",caption="Total trees: " .. count_trees()}
				game.players[1].gui.left.trees.add{type="label",name="count",caption="Added trees: " .. totalgen}
				game.players[1].gui.left.trees.add{type="label",name="playermap",caption="info goes here"}
				game.players[1].gui.left.trees.add{type="label",name="status1",caption="debug_text1 goes here"}
				game.players[1].gui.left.trees.add{type="label",name="status2",caption="debug_text2 goes here"}
			else -- Update GUI
				game.players[1].gui.left.trees.m.caption = "Cycle: " .. m % #shuffle .. "/" .. #shuffle
				game.players[1].gui.left.trees.total.caption = "Total trees: " .. count_trees()
				game.players[1].gui.left.trees.count.caption = "Added trees: " .. totalgen
				game.players[1].gui.left.trees.status1.caption = "status1=" .. debug_text1
				game.players[1].gui.left.trees.status2.caption = "status2=" .. debug_text2
				local cc = countPlayerMap()
				game.players[1].gui.left.trees.playermap.caption = "Playermap: (rows/active/visited) " .. cc[1] .. "/" .. cc[2] .. "/" .. cc[3]
			end
			
		else -- close GUI
			if game.players[1].gui.left["trees"] ~=nil then
				game.players[1].gui.left["trees"].destroy()
			end
		end
	end
end

-- Register event handlers
script.on_event(defines.events.on_tick, function(event) on_tick(event) end)