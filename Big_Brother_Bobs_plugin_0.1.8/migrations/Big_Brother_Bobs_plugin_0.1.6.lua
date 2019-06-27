global.scanned_map = false

for _, surface in pairs(game.surfaces) do
	for _,entity in pairs(surface.find_entities_filtered{name="big_brother-surveillance-small"}) do entity.destroy() end 
	end