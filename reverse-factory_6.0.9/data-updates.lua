--Adjust for bobs intermediates
if bobmods then
	if bobmods.plates then
		--Add bronze plate and its prereq technology to tier 1 recycler
		bobmods.lib.tech.add_prerequisite("reverse-factory-1", "alloy-processing-1")
		bobmods.lib.recipe.add_new_ingredient("reverse-factory-1", {"bronze-alloy", 25})
		--Add steel gear and invar plate to tier 2 recycler
		bobmods.lib.recipe.replace_ingredient("reverse-factory-2", "steel-plate", "steel-gear-wheel")
		bobmods.lib.recipe.add_new_ingredient("reverse-factory-2", {"invar-alloy", 25})
		--With angels smelting, use angels advanced smelting tech, otherwise use bobs alloy processing tech
		if angelsmods then
			if angelsmods.smelting then
				bobmods.lib.tech.add_prerequisite("reverse-factory-2", "angels-invar-smelting-1")
			end
		else 
			bobmods.lib.tech.add_prerequisite("reverse-factory-2", "invar-processing")
		end
		
		if bobmods.logistics then
			--No reason to add more steel or iron to the recipe; stone makes an interesting addition
			bobmods.lib.recipe.replace_ingredient("reverse-factory-2", "pipe", "stone-pipe")
		end
	end
end