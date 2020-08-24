if not RampantFixes then RampantFixes = {} end
RampantFixes.RampantPresent = false
RampantFixes.SlowdownFix = false
RampantFixes.AngelsExploration = false
RampantFixes.EnableHook = false
if (mods["Rampant"]) then
	RampantFixes.RampantPresent = true
	if (settings.startup["rampant-newEnemies"].value == true) then
		RampantFixes.SlowdownFix = true
	end
	if (mods["angelsexploration"] and settings.startup["rampant-fixes-angels-exploration"] == true) then
		RampantFixes.AngelsExploration = true
	end
	if (RampantFixes.SlowdownFix == true or RampantFixes.AngelsExploration == true) then
		RampantFixes.EnableHook = true
	end
end