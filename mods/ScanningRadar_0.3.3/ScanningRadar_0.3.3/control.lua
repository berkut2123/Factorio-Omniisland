local tau = 6.2831853071796
local INSIDE = 0 -- 0000
local LEFT   = 1 -- 0001
local RIGHT  = 2 -- 0010
local BOTTOM = 4 -- 0100
local TOP    = 8 -- 1000

function OnEntityCreated(event)
	if event.created_entity.name == "scanning-radar" then
		local connection = event.created_entity.surface.create_entity{name = "scanning-radar-connection", position = event.created_entity.position, force = event.created_entity.force}
		table.insert(global.ScanningRadars, {connection = connection, radar=event.created_entity, dump = {}, state = InitializeState(event.created_entity)})
		-- register to events after placing the first
		if #global.ScanningRadars == 1 then
			script.on_event(defines.events.on_tick, OnTick)
			script.on_event({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined}, OnEntityMined)
			script.on_event({defines.events.on_entity_died}, OnEntityDied)
		end
	end
end

function OnEntityMined(event)
	local index = -1
	if event.entity.name == "scanning-radar-connection" then
		for i=#global.ScanningRadars, 1, -1 do
			if global.ScanningRadars[i].connection.unit_number == event.entity.unit_number then
				index = i
				--game.print("mined connection")
				break
			end
		end
	elseif event.entity.name == "scanning-radar" then
		for i=#global.ScanningRadars, 1, -1 do
			if global.ScanningRadars[i].radar.unit_number == event.entity.unit_number then
				index = i
				--game.print("mined radar")
				break
			end
		end
	elseif event.entity.name == "scanning-radar-powerdump" then
		for i=#global.ScanningRadars, 1, -1 do
			for j=1, #global.ScanningRadars[i].dump, 1 do
				if global.ScanningRadars[i].dump[j].unit_number == event.entity.unit_number then
					index = i
					--game.print("mined power")
					break
				end
			end
			if index ~= -1 then
				break
			end
		end
	end
	if index ~= -1 then
		for j=1, #global.ScanningRadars[index].dump, 1 do
			global.ScanningRadars[index].dump[j].destroy()
		end
		global.ScanningRadars[index].radar.destroy()
		table.remove(global.ScanningRadars, index)
		-- unregister when the last is removed
		if #global.ScanningRadars == 0 then
			script.on_event(defines.events.on_tick, nil)
			script.on_event({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined}, nil)
			script.on_event({defines.events.on_entity_died}, nil)
		end
	end
end

function OnEntityDied(event)
	local index = -1
	if event.entity.name == "scanning-radar-connection" then
		for i=#global.ScanningRadars, 1, -1 do
			if global.ScanningRadars[i].connection.unit_number == event.entity.unit_number then
				index = i
				--game.print("killed connection")
				break
			end
		end
	elseif event.entity.name == "scanning-radar" then
		for i=#global.ScanningRadars, 1, -1 do
			if global.ScanningRadars[i].radar.unit_number == event.entity.unit_number then
				index = i
				--game.print("killed radar")
				break
			end
		end
	elseif event.entity.name == "scanning-radar-powerdump" then
		for i=#global.ScanningRadars, 1, -1 do
			for j=1, #global.ScanningRadars[i].dump, 1 do
				if global.ScanningRadars[i].dump[j].unit_number == event.entity.unit_number then
					index = i
					--game.print("killed power")
					break
				end
			end
			if index ~= -1 then
				break
			end
		end
	end
	if index ~= -1 then
		for j=1, #global.ScanningRadars[index].dump, 1 do
			global.ScanningRadars[index].dump[j].destroy()
		end
		global.ScanningRadars[index].radar.destroy()
		global.ScanningRadars[index].connection.destroy()
		table.remove(global.ScanningRadars, index)
		-- unregister when the last is removed
		if #global.ScanningRadars == 0 then
			script.on_event(defines.events.on_tick, nil)
			script.on_event({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined}, nil)
			script.on_event({defines.events.on_entity_died}, nil)
		end
	end
end

-- Stepping from tick modulo, with stride
function OnTick(event)
	local update_interval = 3
	local offset = game.tick % update_interval
	for i=#global.ScanningRadars - offset, 1, -1 * update_interval do
		read_signals(global.ScanningRadars[i])
		scan_next(global.ScanningRadars[i])
	end
end

function read_signals(radar)
	local entity = radar.connection
	local values = { r = 0,
	                 b = 0,
	                 e = 0,
	                 d = 0,
	                 n = 0,
	                 s = 0
	}
	-- read red signals
	local network = entity.get_circuit_network(defines.wire_type.red)
	if network then
		values = get_siganls(network, values)
	end
	-- sum with green signals
	local network = entity.get_circuit_network(defines.wire_type.green)
	if network then
		values = get_siganls(network, values)
	end
	-- apply signals
	-- set inside radius and push the outside radius out if needed
	if values.n < 0 then
		values.n = 0
	end
	if values.n > 19999 then
		values.n = 19999
	end
	radar.state.inner = values.n
	if radar.state.radius < values.n or (values.r > 0 and values.r < values.n) then
		values.r = values.n + 1
	end
	-- set outside radius and max step size
	if values.r <= 0 and radar.state.radius ~= settings.global["ScanningRadar_radius"].value then
		values.r = settings.global["ScanningRadar_radius"].value
	end
	-- Ok, thats big enough.
	if values.r > 20000 then
		values.r = 20000
	end
	if values.r > 0 then
		radar.state.radius = values.r
		radar.state.step = 1 / (values.r / 32)
	end
	-- constrain angle
	if values.b ~= 0 or values.e ~= 0 then
		radar.state.constrained = true
		radar.state.oscillate = true
		radar.state.start = tau * values.b / 360 
		radar.state.stop = tau * values.e / 360
	-- otherwise clear constraint
	else
		radar.state.constrained = false
		radar.state.oscillate = false
		radar.state.start = 0
		radar.state.stop = 0
	end
	-- force direction even if constrained
	if values.d > 0 then 
		radar.state.direction = 1
		radar.state.oscillate = false
	elseif values.d < 0 then
		radar.state.direction = -1
		radar.state.oscillate = false
	elseif radar.state.constrained then
		radar.state.oscillate = true
	end
	-- set speed
	if values.s <= 0 then
		radar.state.speed = settings.global["ScanningRadar_speed"].value
	elseif values.s >= 1 and values.s <= 10 then
		radar.state.speed = values.s
	elseif values.s > 10 then
		radar.state.speed = 10
	end
end

function get_siganls(network, values)
	if network then
		local signals = network.signals
		if signals then 
			for _, signal in pairs(signals) do
				if signal.signal.name then
					if signal.signal.name == "signal-R" or signal.signal.name == "signal-F" then
						values.r = values.r + signal.count
					elseif signal.signal.name == "signal-D" then
						values.d = values.d + signal.count
					elseif signal.signal.name == "signal-B" then
						values.b = values.b + signal.count
						values.b = values.b % 360
					elseif signal.signal.name == "signal-E" then
						values.e = values.e + signal.count
						values.e = values.e % 360
					elseif signal.signal.name == "signal-N" then
						values.n = values.n + signal.count
					elseif signal.signal.name == "signal-S" then
						values.s = values.s + signal.count
					end
				end
			end
		end
	end
	return values
end

function is_pump_enabled(pump)
	local control = pump.get_control_behavior()
	if control and control.valid then
		if control.connect_to_logistic_network then
			if control.logistic_condition then
				if not control.logistic_condition.fulfilled then
					return false
				end
			else
				return false
			end
		end
		if control.get_circuit_network(defines.wire_type.red, defines.circuit_connector_id.pump) or control.get_circuit_network(defines.wire_type.green, defines.circuit_connector_id.pump) then
			if control.disabled then
				return false
			end
		end
	end
	return true
end

function make_power_dump(radar)
	-- =9.824379*(PI()*$N$8^2-PI()*$M$8^2)*P9/5/1000
	local constant = .00617283937849
	local dump_size = 2.5
	local i = radar.state.inner / 32
	local o = radar.state.radius / 32
	local s = radar.state.speed
	local extra = (constant * (o * o - i * i) * s - 10) / dump_size
	if extra < 0 or not settings.global["ScanningRadar_power"].value then
		extra = 0
	end
	extra = extra + .5 - (extra + .5) % 1
	-- try not to stall the game too badly. Caps power usage at 10GW
	if extra > 4000 then
		extra = 4000
	end
	if extra > #radar.dump then
		--game.print( "need " .. extra - #radar.dump .. " more entities")
		for i=1, extra - #radar.dump, 1 do
			local sink = radar.radar.surface.create_entity{name = "scanning-radar-powerdump", position = radar.radar.position, force = radar.radar.force}
			table.insert(radar.dump, sink)
		end
	elseif extra < #radar.dump then
		--game.print( "need " .. #radar.dump - extra .. " fewer entities")
		for i=#radar.dump, extra + 1, -1 do
			radar.dump[i].destroy()
			table.remove(radar.dump, i)
		end
	end
end

function point_region( p, tl, br )
	local region = INSIDE
	if p.x < tl.x then
		region = bit32.bor(region, LEFT)
	elseif p.x > br.x then
		region = bit32.bor(region, RIGHT)
	end
	if p.y < tl.y then
		region = bit32.bor(region, TOP)
	elseif p.y > br.y then
		region = bit32.bor(region, BOTTOM)
	end
	return region
end

function clip_line( p1, p2, tl, br )
	p1_region = point_region(p1, tl, br)
	p2_region = point_region(p2, tl, br)
	local inbound = false
	while true do
		if p1_region == 0 and p2_region == 0 then
			inbound = true
			break
		elseif bit32.band(p1_region, p2_region) ~= 0 then
			break
		else
			local region_out = INSIDE
			local point = {x=0,y=0}
			if p1_region ~= INSIDE then
				region_out = p1_region
			else
				region_out = p2_region
			end
			if bit32.band(region_out, TOP) ~= 0 then
        point.x = p1.x + (p2.x - p1.x) * (tl.y - p1.y) / (p2.y - p1.y)
        point.y = tl.y
			elseif bit32.band(region_out, BOTTOM) ~= 0 then
        point.x = p1.x + (p2.x - p1.x) * (br.y - p1.y) / (p2.y - p1.y)
        point.y = br.y
			elseif bit32.band(region_out, RIGHT) ~= 0 then
				point.x = br.x
				point.y = p1.y + (p2.y - p1.y) * (br.x - p1.x) / (p2.x - p1.x)
			elseif bit32.band(region_out, LEFT) ~= 0 then
				point.x = tl.x
				point.y = p1.y + (p2.y - p1.y) * (tl.x - p1.x) / (p2.x - p1.x)
			end
			if region_out == p1_region then
				p1 = point
				p1_region = point_region(p1, tl, br)
			else
				p2 = point
				p2_region = point_region(p2, tl, br)
			end
		end
	end
	--	game.print("=: (" .. string.format("%0.1f",start_p1.x) .. "," .. string.format("%0.1f",start_p1.y) .. ") to (" .. string.format("%0.1f",start_p2.x) .. "," .. string.format("%0.1f",start_p2.y) .. ")")
	return { inbound=inbound, p1=p1, p2=p2 }
end

function line_length( p1, p2 )
	local dx = math.abs(p2.x - p1.x)
	local dy = math.abs(p2.y - p1.y)
	return math.sqrt( dx * dx + dy * dy )
end

function scan_next(radar)
	local entity = radar.radar
	local state = radar.state
	local enabled = is_pump_enabled(radar.connection)
	
	-- requested feature, return to start when enabled
	if not state.enabled and state.speed > 0 then
		if state.constrained then
			state.angle = state.start
			if state.oscillate then
				state.direction = -1
				if settings.global["ScanningRadar_direction"].value == "Clockwise" then
					state.direction = 1
				end
			end
		else
			state.angle = 0
		end
		state.previous = state.angle + state.step
		if state.direction == 1 then 
			state.previous = state.angle - state.step
		end
		radar.state.enabled = true
	elseif state.enabled and state.speed == 0 then
		radar.state.enabled = false
	end
	if not radar.state.enabled then
		enabled = false
	end
	
	for i=1, #radar.dump, 1 do
		radar.dump[i].active = enabled
	end
	entity.active = enabled

	-- don't scan if the power is low
	-- check now so the dump still draws power
	if entity.energy < 160000 then
		enabled = false
	end

	-- Remove generated chunks from the backlog
	if radar.state.uncharted == nil then
		radar.state.uncharted = {}
	end
	for k, position in pairs(radar.state.uncharted) do
		if entity.surface.is_chunk_generated(position) then
			radar.state.uncharted[k] = nil
		end
	end

	if entity.is_connected_to_electric_network() and enabled then
		-- plot only when we've rotated far enough to pick up next chunk on outside circumference
		local fullstep = state.previous + (state.step - .00000001) * state.direction
		if #radar.state.uncharted <= 10 then
			if (state.direction == -1 and state.angle <= fullstep) or (state.direction == 1 and state.angle >= fullstep) then
				local coa = math.cos(state.angle)
				local soa = math.sin(state.angle)
				local near = { x = state.cx + state.inner * coa,
				               y = state.cy + state.inner * soa}
				local far = { x = state.cx + state.radius * coa,
				              y = state.cy + state.radius * soa}
				
				-- Clip to surface limits
				local max_width = entity.surface.map_gen_settings.width / 2
				local max_height = entity.surface.map_gen_settings.height / 2
				line = clip_line( near, far, {x = -max_width, y = -max_height}, {x = max_width, y = max_height} )
				
				if line.inbound then
					local uncharted = scan_line(entity.force, entity.surface, line.p1, line.p2)
					for _, position in pairs(uncharted) do
						table.insert(radar.state.uncharted, position)
					end
					--game.print( string.format("%05.1f",line_length(line.p1, line.p2)) .. "m @ " ..string.format("%05.1f",state.angle * 360 / tau) .. "°, backlog: " .. #radar.state.uncharted )
				end
			end
			-- move at speed
			local magnitude = 10
			magnitude = (magnitude + 1) - state.speed / 10 * magnitude
			magnitude = magnitude * magnitude
			local step = state.step / magnitude
			local new_angle = state.angle + step * state.direction
			-- is the angle constrained?
			if state.constrained then
				local a = state.direction > 0 -- is clockwise
				local b = state.start > state.stop
				local c = new_angle < state.start -- is before start
				local d = new_angle > state.stop -- is after stop
				if state.oscillate then
					local e = settings.global["ScanningRadar_direction"].value == "Clockwise"
					if     e     and b     and a     and d     and c     then
						radar.state.direction = -1
						new_angle = state.stop
						radar.state.previous = new_angle + state.step
					elseif e     and b     and not a and c     and d     then
						radar.state.direction = 1
						new_angle = state.start
						radar.state.previous = new_angle - state.step
					elseif e     and not b and a     and d               then
						radar.state.direction = -1
						new_angle = state.stop
						radar.state.previous = new_angle + state.step
					elseif e     and not b and not a and c               then
						radar.state.direction = 1
						new_angle = state.start
						radar.state.previous = new_angle - state.step
					elseif not e and b     and a     and not c           then
						radar.state.direction = -1
						new_angle = state.start
						radar.state.previous = new_angle + state.step
					elseif not e and b     and not a and not d           then
						radar.state.direction = 1
						new_angle = state.stop
						radar.state.previous = new_angle - state.step
					elseif not e and not b and a     and not c and not d then
						radar.state.direction = -1
						new_angle = state.start
						radar.state.previous = new_angle + state.step
					elseif not e and not b and not a and not d and not c then
						radar.state.direction = 1
						new_angle = state.stop
						radar.state.previous = new_angle - state.step
					end
				else 
					if (a and b and c and d) or (a and not b and (c or d)) then -- clockwise, out of bounds
						new_angle = state.start
						radar.state.previous = new_angle - state.step
					elseif (not a and not b and not c and not d) or (not a and b and (not c or not d)) then -- counterclockwise, out of bounds
						new_angle = state.start
						radar.state.previous = new_angle + state.step
					end
				end
			end
			-- wrap around at Tau and zero
			if new_angle >= tau then
				new_angle = new_angle - tau
				radar.state.previous = state.previous - tau
			elseif new_angle < 0 then
				new_angle = new_angle + tau
				radar.state.previous = state.previous + tau
			end
			-- save back new angle
			radar.state.angle = new_angle
		else
			--game.print( "waiting for " .. #radar.state.uncharted .. " chunks" )
			--entity.surface.force_generate_chunk_requests()
		end
	else
		--game.print( "Not enough power!" )
	end
	-- once every ten updates, refresh dump entities. Better UPS and more certain execution
	if state.counter >= 10 then
		make_power_dump(radar)
		radar.state.counter = 0
	else
		radar.state.counter = state.counter + 1
	end
end

function scan_line(force, surface, p1, p2)
	if math.abs(p2.y - p1.y) < math.abs(p2.x - p1.x) then
		if p1.x > p2.x then
			-- 135-180,180-225, O-I
			return plotLineH(force, surface, p2, p1)
		else
			-- 000-045,315-360, I-O
			return plotLineH(force, surface, p1, p2)
		end
	else
		if p1.y > p2.y then
			-- 225-270,270-315, O-I
			return plotLineV(force, surface, p2, p1)
		else
			-- 045-090,090-135, I-O
			return plotLineV(force, surface, p1, p2)
		end
	end
end

function plotLineH(force, surface, p1, p2)
	local uncharted = {}
	local dx = p2.x - p1.x
	local dy = p2.y - p1.y
	local yi = 1
	if dy < 0 then
		yi = -1
		dy = -dy
	end
	local D = 2*dy - dx
	local y = p1.y
	local xlow = 1
	local ylow = 1
	local xhigh = -1
	local yhigh = -1
	for x = p1.x, p2.x, 1 do
		if not (x >= xlow and x < xhigh and y >= ylow and y < yhigh) then
			local chunk_x = math.floor(x/32)
			local tile_x = chunk_x * 32
			local chunk_y = math.floor(y/32)
			local tile_y = chunk_y * 32
			if not force.is_chunk_charted(surface, {chunk_x,chunk_y}) then
				table.insert(uncharted, {x=chunk_x,y=chunk_y})
			end
			force.chart(surface, {{tile_x,tile_y}, {tile_x,tile_y}})
			xlow = tile_x
			ylow = tile_y
			xhigh = tile_x + 32
			yhigh = tile_y + 32
		end
		if D > 0 then
			y = y + yi
			D = D - 2*dx
		end
		D = D + 2*dy
	end
	return uncharted
end

function plotLineV(force, surface, p1, p2)
	local uncharted = {}
	local dx = p2.x - p1.x
	local dy = p2.y - p1.y
	local xi = 1
	if dx < 0 then
		xi = -1
		dx = -dx
	end
	local D = 2 * dx - dy
	local x = p1.x
	local xlow = 1
	local ylow = 1
	local xhigh = -1
	local yhigh = -1
	for y=p1.y, p2.y, 1 do
		if not (x >= xlow and x < xhigh and y >= ylow and y < yhigh) then
			local chunk_x = math.floor(x/32)
			local tile_x = chunk_x * 32
			local chunk_y = math.floor(y/32)
			local tile_y = chunk_y * 32
			if not force.is_chunk_charted(surface, {chunk_x,chunk_y}) then
				table.insert(uncharted, {x=chunk_x,y=chunk_y})
			end
			force.chart(surface, {{tile_x,tile_y}, {tile_x,tile_y}})
			xlow = tile_x
			ylow = tile_y
			xhigh = tile_x + 32
			yhigh = tile_y + 32
		end
		if D > 0 then
			x = x + xi
			D = D - 2 * dy
		end
		D = D + 2 * dx
	end
	return uncharted
end

function InitializeState(radar)
	-- build state of new radar with defaults
	local state = {
	    cx = radar.position.x,
	    cy = radar.position.y,
	    radius = settings.global["ScanningRadar_radius"].value,
	    inner = 0,
	    angle = 0,
	    previous = 0,
	    step = 1 / (settings.global["ScanningRadar_radius"].value / 32),
	    direction = -1,
	    constrained = false,
	    oscillate = false,
	    start = 0,
	    stop = 0,
	    speed = settings.global["ScanningRadar_speed"].value,
	    counter = 0,
	    uncharted = {},
	    enabled = 1
	}
	if settings.global["ScanningRadar_direction"].value == "Clockwise" then
		state.direction = 1
		state.previous = -state.step
	else
		state.previous = state.step
	end
	if state.speed == 0 then
		state.enabled = false
	end
	return state
end

do---- Init ----
local function init_radars()
	global.ScanningRadars = {}
	-- Pick up any orphaned scanning radars
	for _, surface in pairs(game.surfaces) do
		radars = surface.find_entities_filtered {
			name = "scanning-radar",
		}
		for _, radar in pairs(radars) do
			local connection = surface.find_entity("scanning-radar-connection", radar.position)
			if connection == nil then
				connection = surface.create_entity{name = "scanning-radar-connection", position = radar.position, force = radar.force}
			end
			local dump = surface.find_entities_filtered{name="scanning-radar-powerdump", position = radar.position, force = radar.force}
			table.insert(global.ScanningRadars, {connection = connection, radar=radar, dump=dump, state=InitializeState(radar)})
		end
	end
end

local function init_events()
	script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, OnEntityCreated)
	if global.ScanningRadars and next(global.ScanningRadars) then
		script.on_event(defines.events.on_tick, OnTick)
		script.on_event({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined}, OnEntityMined)
		script.on_event({defines.events.on_entity_died}, OnEntityDied)
	end
end

script.on_load(function()
	init_events()
end)

script.on_init(function()
	init_radars()
	init_events()
end)

script.on_configuration_changed(function(data)
	init_radars()
	init_events()
end)

end
