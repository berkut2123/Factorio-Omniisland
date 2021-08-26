if not global.surfaces then
	global.surfaces = {}
	for index, surface in pairs(game.surfaces) do
		global.surfaces[surface.index] = {ticks_per_day = surface.ticks_per_day, frozen = false}
		global.surfaces[1].ticks_per_day = 25000
	end
end
global.permanight_surfaces = global.permanight_surfaces or {}