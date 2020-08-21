script.on_init(function(event)
	setsettings()
	setsettings_permanight()
	if game.tick == 0 then
		game.surfaces[1].daytime = settings.global["Clockwork-starttime"].value
	end
end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
	if string.find(event.setting, "Clockwork") then
		setsettings()
		if event.setting == "Clockwork-permanight"
			or event.setting == "Clockwork-permanight-grace"
		then
			setsettings_permanight()
		end
	end
end)

script.on_event(defines.events.on_tick, function(event)
	if global.permanight then
		local tick = event.tick
		if global.grace and tick == global.grace_ticks then 
			game.surfaces[1].freeze_daytime = false
			game.surfaces[1].print({"description.grace-end-prelude"})
			game.surfaces[1].print({"description.grace-end"}, {r=1.0, g=0.0, b=0.0})
			global.grace = false
		end
		if game.surfaces[1].daytime >= global.midnight then
			game.surfaces[1].freeze_daytime = true
			-- we're not actually turning off permanight
			-- but since we have no more work to do, this keeps on_tick minimal
			global.permanight = false
		end
	end
end)

function setsettings_permanight()
	-- If these settings are changed in the middle of a session, it essentially counts as a reset.
	global.grace = fif(settings.global["Clockwork-permanight-grace"].value > 0, true, false)
	global.grace_ticks = game.tick + settings.global["Clockwork-permanight-grace"].value * 60 * 60
	global.permanight = settings.global["Clockwork-permanight"].value
	
	if global.permanight and global.grace then
		-- freeze daytime to allow the grace period to pass
		-- In case this is added to an existing save, make sure it's day too.
		game.surfaces[1].freeze_daytime = true
		game.surfaces[1].daytime = settings.global["Clockwork-starttime"].value
	end
	if global.permanight then else
		game.surfaces[1].freeze_daytime = false
	end
end

function setsettings()
	
	-- defaults: 25,000 ticks per day, dusk 0.25, evening 0.45, morning 0.55, dawn 0.75
	local cycle_ticks = math.floor(25000 * settings.global["Clockwork-cycle-length"].value)
	local dusk = settings.global["Clockwork-dusk"].value or 0.25
	local evening = settings.global["Clockwork-evening"].value or 0.45
	local morning = settings.global["Clockwork-morning"].value or 0.55
	local dawn = settings.global["Clockwork-dawn"].value or 0.75
	local warning = false
	-- safety checks
	if dawn <= dusk then
		dawn = dusk + 0.005
		warning = true
	end
	if morning >= dawn then
		morning = dawn - 0.005
		warning = true
	end
	if evening >= morning then
		evening = morning - 0.005
		warning = true
	end
	if dusk >= evening then
		dusk = evening - 0.005
		warning = true
	end
	if warning then
		-- note: ipairs() does not work here. (same for game.players)
		for _, surface in pairs(game.surfaces) do
			surface.print("WARNING: Invalid day/night settings detected. Values have been internally corrected.")
		end
	end
	
	global.midnight = (evening + morning) / 2
	
	for _, surface in pairs(game.surfaces) do
		-- skip surfaces that may represent special situations, such as being in a building.
		if surface.always_day then else
			surface.ticks_per_day = cycle_ticks
			
			-- RIP min brightness.
			-- surface.min_brightness = settings.global["Clockwork-minbrightness"].value
			
			-- assumes brightness is 0.15. We might need to include migration code.
			if settings.global["Clockwork-darknight"].value then
				surface.brightness_visual_weights = { 1 / 0.85, 1 / 0.85, 1 / 0.85 } 
			else
				surface.brightness_visual_weights = { 0, 0, 0} 
			end
			
			
			local retry
			local cnt = 0
			repeat 
				retry = false
				
				-- Checks that values are within range in the same order as:
				-- dusk 0.25, evening 0.45, morning 0.55, dawn 0.75
				-- second round of checks are necessary as the game will crash if, for example, dawn is less than
				-- surface.morning, even though the 'morning' we want to apply after is valid.
				
				if dawn <= surface.morning then
					retry = true
				else
					surface.dawn = dawn
				end
				
				if morning >= surface.dawn or morning <= surface.evening then
					retry = true
				else
					surface.morning = morning
				end
				
				if evening >= surface.morning or evening <= surface.dusk then
					retry = true
				else
					surface.evening = evening
				end
				
				if dusk >= surface.evening then
					retry = true
				else
					surface.dusk = dusk
				end
				
				cnt = cnt + 1
				if cnt > 4 then
					break
				end
			until retry == false
			--game.surfaces[1].print("dusk: " .. surface.dusk .. " evening: " .. surface.evening .. " morning: " .. surface.morning ..
			--	" dawn: " .. surface.dawn)
		end
		
		if settings.global["Clockwork-multisurface"].value == false then
			break
		end
	end
	

end

--[[function convert(input)
	
	if input.len() ~= 5 then
		return nil
	end
	local hours = tonumber(string.sub(1, 2))
	if hours == nil then 
		return nil 
	end
	local minutes = tonumber(string.sub(4, 5))
	if minutes == nil then
		return nil 
	end
	
	local cycle_minutes = minutes + hours * 60
	--math.floor(day_time * 24 * 60)

end]]

function fif(condition, if_true, if_false)
  if condition then return if_true else return if_false end
end

