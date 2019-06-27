  if ( game.active_mods["bobswarfare"] ) then
	for index, force in pairs(game.forces) do
	local technologies = force.technologies
	local recipes = force.recipes

		if technologies["bob-bullets"].researched then
			recipes["ext-bullet-magazine"].enabled = true
			recipes["drum-bullet-magazine"].enabled = true
			recipes["saddle-bullet-magazine"].enabled = true
		end

		if technologies["bob-ap-bullets"].researched then
			recipes["ext-ap-bullet-magazine"].enabled = true
			recipes["drum-ap-bullet-magazine"].enabled = true
			recipes["saddle-ap-bullet-magazine"].enabled = true
		end

		if technologies["bob-acid-bullets"].researched then
			recipes["ext-acid-bullet-magazine"].enabled = true
			recipes["drum-acid-bullet-magazine"].enabled = true
			recipes["saddle-acid-bullet-magazine"].enabled = true
		end

		if technologies["bob-electric-bullets"].researched then
			recipes["ext-electric-bullet-magazine"].enabled = true
			recipes["drum-electric-bullet-magazine"].enabled = true
			recipes["saddle-electric-bullet-magazine"].enabled = true
		end

		if technologies["bob-flame-bullets"].researched then
			recipes["ext-flame-bullet-magazine"].enabled = true
			recipes["drum-flame-bullet-magazine"].enabled = true
			recipes["saddle-flame-bullet-magazine"].enabled = true
		end

		if technologies["bob-he-bullets"].researched then
			recipes["ext-he-bullet-magazine"].enabled = true
			recipes["drum-he-bullet-magazine"].enabled = true
			recipes["saddle-he-bullet-magazine"].enabled = true
		end

		if technologies["bob-poison-bullets"].researched then
			recipes["ext-poison-bullet-magazine"].enabled = true
			recipes["drum-poison-bullet-magazine"].enabled = true
			recipes["saddle-poison-bullet-magazine"].enabled = true
		end

	end
end