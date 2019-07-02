-- -- -- Tecnologies Effects

iron_ducts_effect = 
{
	{
		type = "unlock-recipe",
		recipe = "duct-small",
	},
	{
		type = "unlock-recipe",
		recipe = "duct-t-junction",
	},
	{
		type = "unlock-recipe",
		recipe = "duct-curve",
	},
	{
		type = "unlock-recipe",
		recipe = "duct-cross",
	},
	{
		type = "unlock-recipe",
		recipe = "duct-underground",
	},
	--[[
	{
		type = "unlock-recipe",
		recipe = "duct-intermediate-point",
	},
	--]]
	{
		type = "unlock-recipe",
		recipe = "duct-end-point-intake",
	},
	{
		type = "unlock-recipe",
		recipe = "duct-end-point-outtake",
	}
}

if not settings.startup["fmf-enable-duct-auto-join"].value then
	table.insert(iron_ducts_effect, 
		{
			type = "unlock-recipe",
			recipe = "duct",
		}
	)
	table.insert(iron_ducts_effect,
		{
			type = "unlock-recipe",
			recipe = "duct-long",
		}
	)
end


-- -- -- Tecnologies 

iron_ducts =	
{
	type = "technology",
	name = "Ducts",
	icon_size = 128,
	icon = "__FluidMustFlow__/graphics/icon/technologies/iron_duct_tecnology.png",
	upgrade = false,
	effects = iron_ducts_effect,
	prerequisites = {"fluid-handling", "chemical-science-pack"},
	unit = 
	{
		count = 30,
		ingredients = {{"automation-science-pack", 2}, {"logistic-science-pack", 2}, {"chemical-science-pack", 1}},
		time = 20,
	}
}

data:extend({iron_ducts})