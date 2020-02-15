--recipe.lua
data:extend({
	{
		type = "recipe",
		name = "waterore",
		energy_required = 4,
		enabled = true,
		ingredients = {
			{type="fluid", name="omnic-water", amount=200},
		},
		results = {
			{type="item", name="omni-scrap", amount=2},
			{type="item", name="omnite", amount=3},
		},
		icon = "__omniIsland__/graphics/icons/recipe-waterore.png",
		icon_size = 32,
		subgroup = "omni-basic",
		category = "omniphlog"
	},
	
	
	
{
		type = "recipe",
		name = "waterwood",
		energy_required = 2,
		enabled = true,
		ingredients = {
			{type="item", name="omni-scrap", amount=10},
		},
		results = {
			{type="item", name="omniwood", amount=2},
			{type="item", name="stone-crushed", amount=6},
		},
		icon = "__omniIsland__/graphics/icons/recipe-waterwood.png",
		icon_size = 32,
		subgroup = "omni-basic",
		category = "omnite-extraction-both"
	},
	
	
	
{
		type = "recipe",
		name = "waterstone",
		energy_required = 2,
		enabled = true,
		ingredients = {
			{type="item", name="omni-scrap", amount=11},
		},
		results = {
			{type="item", name="stone-crushed", amount=7},
		},
		icon = "__omniIsland__/graphics/icons/recipe-waterstone.png",
		icon_size = 32,
		subgroup = "omni-basic",
		category = "omnite-extraction-both"
	},
	
	
{
		type = "recipe",
		name = "Htf-mineral",
		energy_required = 2,
		enabled = true,
		ingredients = {
			{type="item", name="omni-scrap", amount=11},
		},
		results = {
			{type="item", name="omnite", amount=2},
			{type="item", name="stone-crushed", amount=3},
		},
		icon = "__omniIsland__/graphics/icons/recipe-Htf-mineral.png",
		icon_size = 32,
		subgroup = "omni-basic",
		category = "omnite-extraction-both"
	},
	
	
})
