-- Placed Equipment
script.on_event(defines.events.on_player_placed_equipment, function(event)

	local player = game.players[event.player_index]

	-- Return if the player character does not exist
	if player.character == nil then return end

	local inventorySlots = player.character_inventory_slots_bonus
	local armor = player.get_inventory(defines.inventory.character_armor)

	-- check if we are adding an armor pocket
	if event.equipment.name == "armor-pocket-equipment" then	

		-- add the inventory bonus
		if not armor.is_empty() then
			local grid = armor[1].grid
			if grid == event.grid then
				player.character_inventory_slots_bonus = inventorySlots + settings.startup["armor_pockets_slot_amount"].value
			end
    	end
    	-- log the inventory slot count to console
		--log_inventory_slot_count(player)

    end

	-- check if we are adding an armor pocket mk2
	if event.equipment.name == "armor-pocket-mk2-equipment" then	

		-- add the inventory bonus
		if not armor.is_empty() then
			local grid = armor[1].grid
			if grid == event.grid then
				player.character_inventory_slots_bonus = inventorySlots + math.floor(settings.startup["armor_pockets_slot_amount"].value * settings.startup["armor_pockets_mk2_mult"].value)
			end
    	end
    	--log the inventory slot count to console
		--log_inventory_slot_count(player)

    end

end
)

-- Removed Equipment
script.on_event(defines.events.on_player_removed_equipment, function(event)
 
 	local player = game.players[event.player_index]

	-- Return if the player character does not exist
	if player.character == nil then return end

	local inventory_slots_bonus = player.character_inventory_slots_bonus
	local armor = player.get_inventory(defines.inventory.character_armor)	

	-- check if we are removing an armor pocket
  	if event.equipment == "armor-pocket-equipment" then
		if not armor.is_empty() then
			local grid = armor[1].grid	
			if grid == event.grid then		
		  		if event.count >= 0 then

			  		local slotCount = inventory_slots_bonus - (settings.startup["armor_pockets_slot_amount"].value * event.count)

			  		if slotCount >= 0 then
				  		-- subtract the inventory bonus multiplied by the number of equipment items removed
						inventory_slots_bonus = slotCount

						-- set the player's inventory slot bonus count
						player.character_inventory_slots_bonus = inventory_slots_bonus
					end
				end			
			end
		end
    	-- log the inventory slot count to console
		--log_inventory_slot_count(player)
	end	

	-- check if we are removing an armor pocket mk2
  	if event.equipment == "armor-pocket-mk2-equipment" then
		if not armor.is_empty() then
			local grid = armor[1].grid	
			if grid == event.grid then		
		  		if event.count >= 0 then

			  		local slotCount = inventory_slots_bonus - (math.floor(settings.startup["armor_pockets_slot_amount"].value * settings.startup["armor_pockets_mk2_mult"].value) * event.count)
			  		if slotCount >= 0 then
				  		-- subtract the inventory bonus multiplied by the number of equipment items removed
						inventory_slots_bonus = slotCount

						-- set the player's inventory slot bonus count
						player.character_inventory_slots_bonus = inventory_slots_bonus
					end
				end			
			end
		end
    	-- log the inventory slot count to console
		--log_inventory_slot_count(player)
	end

end
)

-- Changed Armor
script.on_event(defines.events.on_player_armor_inventory_changed, function(event)
 
	local player = game.players[event.player_index]
	-- Return if the player character does not exist
	if player.character == nil then return end

	local armor = player.get_inventory(defines.inventory.character_armor)
	
	-- check if an armor is equiped, before we do anything
	-- else we set the players inventory bonus count to zero
	if not armor.is_empty() then
		
		local total_slots = 0
		local total_reach = 0
		
		local grid =  armor[1].grid

		-- check if the armor has a grid
		if grid ~= nil then

			-- loop through the equipment in the grid
			for i = 1, #grid.equipment do
			
				-- if the equipment item at index is a pocket, we add bonus slots to the total
				if grid.equipment[i].name == "armor-pocket-equipment" then
					total_slots = total_slots + settings.startup["armor_pockets_slot_amount"].value
				end
				
				-- if the equipment item at index is an armor pocket mk2, we add bonus slots to the total
				if grid.equipment[i].name == "armor-pocket-mk2-equipment" then
					total_slots = total_slots + math.floor(settings.startup["armor_pockets_slot_amount"].value * settings.startup["armor_pockets_mk2_mult"].value)
				end

			end

			set_inventory(player, total_slots)

		else
			clear_bonuses(player)			

		end	

	else
		clear_bonuses(player)
	end

	-- log the inventory slot count to console
	--log_inventory_slot_count(player)
end
)

function clear_bonuses(player)
-- Return if the player character does not exist
	if player.character == nil then return end
	player.character_inventory_slots_bonus = 0

end

function set_inventory(player, count)
	-- Return if the player character does not exist
	if player.character == nil then return end
	-- set the player's inventory slot bonus count to total_slots
	player.character_inventory_slots_bonus = count

end

function log_inventory_slot_count(player)
	player.print("Bonus inventory slots: +" .. player.character_inventory_slots_bonus)	
end
