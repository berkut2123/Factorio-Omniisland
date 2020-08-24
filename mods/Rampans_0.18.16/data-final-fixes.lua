RampantFixes.RampantAddAngels = function ()
	if settings.startup["rampant-unitSpawnerBreath"].value then
		for _, unitSpawner in pairs(data.raw["unit-spawner"]) do
			if (string.find(unitSpawner.name, "scarab") or string.find(unitSpawner.name, "psyker")) then
				if not unitSpawner.flags then
					unitSpawner.flags = {}
				end
				unitSpawner.flags[#unitSpawner.flags+1] = "breaths-air"
			end
		end
	end
	for k, unit in pairs(data.raw["unit"]) do
		if (string.find(k, "scarab") or string.find(k, "psyker")) and unit.collision_box then
			if settings.startup["rampant-enableSwarm"].value then
				unit.collision_box = {
					{unit.collision_box[1][1] * 0.20, unit.collision_box[1][2] * 0.20},
					{unit.collision_box[2][1] * 0.20, unit.collision_box[2][2] * 0.20}
				}
			end
			unit.affected_by_tiles = settings.startup["rampant-unitsAffectedByTiles"].value
			unit.ai_settings = {
				destroy_when_commands_fail = false,
				allow_try_return_to_spawner = true,
				path_resolution_modifier = -5,
				do_seperation = true
			}
		end
	end
	if settings.startup["rampant-enableShrinkNestsAndWorms"].value then
		for k, unit in pairs(data.raw["unit-spawner"]) do
			if (string.find(k, "scarab") or string.find(k, "psyker")) and unit.collision_box then
				unit.collision_box = {
					{unit.collision_box[1][1] * 0.50, unit.collision_box[1][2] * 0.50},
					{unit.collision_box[2][1] * 0.50, unit.collision_box[2][2] * 0.50}
				}
			end
		end
	end
end

RampantFixes.HookRampant = function ()
	local FuncInfo = debug.getinfo(2, "nS")
	if (FuncInfo.source == "@__Rampant__/prototypes/SwarmUtils.lua") then
		--The slowdown fix code happens before anything relevant to Angel's
		--stuff, so it's fine to use an if statement like this.
		if (RampantFixes.SlowdownFix == true) then
			if (FuncInfo.name == "buildAttack") then
				local TestName, TestValue = debug.getlocal(3, 3)
				if (TestValue ~= nil) then
					if (TestValue.stickerAnimation ~= nil) then
						TestValue.stickerAnimation = data.raw["sticker"]["slowdown-sticker"].animation
						debug.setlocal(3, 3, TestValue)
					end
				end
			elseif (FuncInfo.name == "processFactions") then
				RampantFixes.SlowdownFix = false
				if (RampantFixes.AngelsExploration == false) then
					debug.sethook()
				end
			end
		--This part should only end up being reached if Angel's Exploration
		--is enabled.
		elseif (FuncInfo.name == "generateSpawnerProxy") then
			RampantFixes.RampantAddAngels()
			debug.sethook()
		end
	end
end

if (RampantFixes.RampantPresent == true and RampantFixes.EnableHook == true) then
	local HookFunc = debug.gethook()
	assert(HookFunc == nil, "Rampant Fixes is incompatible with other mods using debug.sethook during data-final-fixes!")
	debug.sethook(RampantFixes.HookRampant, "r")
end