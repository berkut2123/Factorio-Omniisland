local tiles = {
	["Arci-marking-white-dl-straight"] = true,
	["Arci-marking-white-dl-diagonal"] = true,
	["Arci-marking-white-dl-left-turn"] = true,
	["Arci-marking-white-dl-right-turn"] = true,
	["Arci-marking-yellow-dl-straight"] = true,
	["Arci-marking-yellow-dl-diagonal"] = true,
	["Arci-marking-yellow-dl-left-turn"] = true,
	["Arci-marking-yellow-dl-right-turn"] = true}

for k,force in pairs(game.forces) do
	for tile, _ in pairs(tiles) do
		-- check for disabled tiles and add the others
		if force.recipes[tile] ~= nil and force.technologies["Arci-asphalt"].researched then 
			force.recipes[tile].enabled = force.technologies["Arci-asphalt"].researched
		end
	end
end