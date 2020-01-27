local function convert_bp_to_qb(player)
	local bp_rows = {}
	local bp_rows_by_y = {}
	local bp_entities = player.cursor_stack.get_blueprint_entities()
	for i,entity in ipairs(bp_entities) do
		if entity.control_behavior then
			local name = entity.control_behavior.filters[1].signal.name
			if name:sub(1,7) == 'signal-' and tonumber(name:sub(8,8)) ~= nil then
				local j = tonumber(name:sub(8,8))
				local row = {j = j, x = entity.position.x, y = entity.position.y}
				bp_rows[j] = row
				bp_rows_by_y[row.y] = row
			end
		end
	end

	for i,entity in ipairs(bp_entities) do
		if entity.control_behavior then
			local name = entity.control_behavior.filters[1].signal.name
			local row = bp_rows_by_y[entity.position.y]
			if row then
				local i = entity.position.x - row.x
				if i > 1 then
					i = i - 1
				end
				if i > 6 then
					i = i - 1
				end
				row[i] = name
			end
		end
	end

	bp_rows[10] = bp_rows[0]
	for i=1,10 do
		local row = bp_rows[i]
		if row then
			for j=1,10 do
				player.set_quick_bar_slot((i-1)*10+j, row[j])
			end
		end
	end
end

local function convert_qb_to_bp(player)	
	local y = 0
	local id = 0
	local bp = {}

	for i=1,10 do
		local n = 0
		for j=1,10 do
			if player.get_quick_bar_slot((i-1)*10+j) then
				n = n + 1
			end
		end
		if n > 0 then
			y = y - 1
			local signal = 'signal-'..i
			if i == 10 then signal = 'signal-0' end

			id = id + 1
			local entity = {entity_number=id, name='constant-combinator', position={x=0,y=y}, control_behavior={filters={{signal={type='virtual',name=signal},count=1,index=1}}}}
			table.insert(bp, entity)

			for j=1,10 do
				local x = j + 1
				if x > 6 then x = x + 1 end
				local entity = {entity_number=id, name='constant-combinator', position={x=x,y=y}}
				local slot = player.get_quick_bar_slot((i-1)*10+j)
				if slot then
					entity.control_behavior = {filters={{signal={type='item',name=slot.name},count=1,index=1}}}
				end
				table.insert(bp, entity)
			end
		end
	end

	player.cursor_stack.set_blueprint_entities(bp)
end

local function has_valid_bp(player)
	return player and player.valid 
		and player.cursor_stack and player.cursor_stack.valid
		and (player.cursor_stack.is_blueprint
			or (player.cursor_stack.is_blueprint_book 
				and not player.cursor_stack.get_inventory(defines.inventory.item_main).is_empty())
			)
end

local function has_empty_bp(event)
	local player = game.players[event.player_index]
	return has_valid_bp(player) and not player.cursor_stack.is_blueprint_setup()
end

local function has_qb_bp(event)
	local player = game.players[event.player_index]
	if has_valid_bp(player) and player.cursor_stack.is_blueprint_setup() then
		local bp_entities = player.cursor_stack.get_blueprint_entities()
		if bp_entities == nil then
			return false
		end
		for i,entity in ipairs(bp_entities) do
			if entity.name ~= 'constant-combinator' then
				return false
			end
		end
		return true
	end
	return false
end


local function on_player_cursor_stack_changed(event)
	local player = game.players[event.player_index]
	local gui = player.gui.top
	if gui["quick-bar-blueprint"] then
		gui["quick-bar-blueprint"].destroy()
	end


	if has_empty_bp(event) or has_qb_bp(event) then
		if not gui["quick-bar-blueprint"] then
			local button = gui.add({type = "sprite-button", name = "quick-bar-blueprint", sprite = "virtual-signal/signal-Q"})
			button.style.minimal_height = 38
			button.style.minimal_width = 38
		end
	else
		if gui["quick-bar-blueprint"] then
			gui["quick-bar-blueprint"].destroy()
		end
	end

end
script.on_event(defines.events.on_player_cursor_stack_changed, on_player_cursor_stack_changed)


local function on_gui_click(event)
	local gui = event.element
	local player = game.players[event.player_index]
	if not (player and player.valid and gui and gui.valid) then return end
	if gui.name ~= "quick-bar-blueprint" then return end

	if has_empty_bp(event) then
		convert_qb_to_bp(player)
		player.print('[color=cyan]Quckbar build was saved to blueprint[/color]')
		player.print('[color=cyan]Please note that BP library links are not supported[/color]')
	else 
		if has_qb_bp(event) then
			convert_bp_to_qb(player)
			player.print('[color=cyan]Quckbar build was loaded from blueprint[/color]')
		end 
	end

end
script.on_event(defines.events.on_gui_click, on_gui_click)


