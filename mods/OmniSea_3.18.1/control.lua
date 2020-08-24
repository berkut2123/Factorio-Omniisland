local landfill = 'landfill'
local function init()
	if game.item_prototypes['landfill-sand-3'] then
		landfill = 'landfill-sand-3'
	end
end
script.on_init(init)	
	
--More stuff to start with

script.on_event(defines.events.on_player_created, function(event)
	local player = game.players[event.player_index]
	player.insert{name="omnidensator-1", count=1}
	player.insert{name=landfill, count=150}
	player.insert{name="wind-turbine-2", count=10}
--	player.insert{name="omnitractor-1", count=1}
end)


--Unlock startup1 with Omnite ( and 3+4 if omnimatter_energy is active)

function checkCraftResultTechs(player,inventory)
    local inv = player.get_inventory(inventory)
    if inv.get_item_count("omnite") > 0 then
    player.force.technologies["sb-startup1"].researched = true
    end
    if game.active_mods["omnimatter_energy"] then
        if inv.get_item_count("omnitor") > 0 then
        player.force.technologies["sb-startup2"].researched = true
        end
        if inv.get_item_count("omnitor-lab") > 0 then
            if player.force.technologies["sct-research-t1"] then
            player.force.technologies["sct-research-t1"].researched = true
            else
            player.force.technologies["sb-startup4"].researched = true
            end
        end
    end
end

script.on_event(defines.events.on_player_main_inventory_changed, function(event)
  local player = game.players[event.player_index]
  checkCraftResultTechs(player,defines.inventory.character_main)
end)
--script.on_event(defines.events.on_player_quickbar_inventory_changed, function(event)
--  local player = game.players[event.player_index]
--  checkCraftResultTechs(player,defines.inventory.player_quickbar)
--end)


--Edit rock-chest

function adjustContent(chest)
	local inventory = chest.get_inventory(defines.inventory.chest)
	inventory.clear()
	log("hey")
	local stuff = {
		{landfill, 1600},
		{"stone", 50},
		{"small-electric-pole", 50},
		{"small-lamp", 20},
		{"iron-plate", 1200},
		{"copper-plate", 600},
		{"basic-circuit-board", 200},
		{"stone-pipe", 200},
		{"stone-pipe-to-ground", 100},
		{"stone-brick", 500},
		{"pipe", 27},
		{"copper-pipe", 5},
		--{"iron-gear-wheel", 25},
		--{"iron-stick", 96},
		{"angels-gear", 100},
		{"angels-rod-iron", 200},	
		{"pipe-to-ground", 2},
		{"electronic-circuit", 10},
		{"circuit-grey", 200},
		{"circuit-red", 200},
		{"circuit-red-loaded", 200},
		{"wind-turbine-2", 40},
		{"omnidensator-1", 2}, --already in inventory
		{"crystallizer", 2},
		{"omnitractor-1", 2},
		{"burner-omni-furnace", 1},
		--{"datacore-basic", 32},
		{"basic-transport-belt", 400},
		{"inserter", 100},
--		{"datacore-logistic-1", 32},
--		{"angels-science-pack-red", 64},
--		{"angels-processing-lab-1", 1},
--		{"angels-basic-lab", 1},
		{"storage-tank", 20},
		{"assembling-machine-1", 20},
--		{"angels-logistic-lab-1", 1}
	}
	for _,v in ipairs(stuff) do
		chest.insert{name = v[1], count = v[2]}
	end
end

script.on_nth_tick(5,function(conf)
	if not global.fixedSeablockOmni and game.tick > 0 then
		for _,surface in pairs(game.surfaces) do
			for _,force in pairs(game.forces) do
				for _,entity in pairs(surface.find_entities_filtered{force=force,name="rock-chest"}) do
					adjustContent(entity)
				end
			end
		end
		global.fixedSeablockOmni=true
	end
end)