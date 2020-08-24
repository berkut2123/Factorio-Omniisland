function unlockRecipe(event)
	for i, force in pairs(game.forces) do
		for _, tech in pairs(force.technologies) do
			if tech.researched then
				for _, effect in pairs(tech.effects) do
					if effect.type == "unlock-recipe" then
						force.recipes[effect.recipe].enabled = true
					end
				end
			end
		end
			global.wagons = {}
			global.loader_wagon_map = {}
	end
end

unlockRecipe()
