--recipe.lua
data:extend({
	{
		type = "recipe",
		name = "waterore",
		energy_required = 4,
		enabled = true,
		ingredients = {
			{type="fluid", name="omnic-water", amount=500},
		},
		results = {
			{type="item", name="omni-scrap", amount=2},
			{type="item", name="omnite", amount=3},
		},
		icon = "__omniIsland__/graphics/icons/recipe-waterore.png",
		icon_size = 32,
		subgroup = "omniphlog",
		category = "omniphlog"
	},
	
	
	
{
		type = "recipe",
		name = "waterwood",
		energy_required = 2,
		enabled = true,
		ingredients = {
			{type="item", name="omni-scrap", amount=6},
		},
		results = {
			{type="item", name="omniwood", amount=3},
			{type="item", name="stone-crushed", amount=3},
		},
		icon = "__omniIsland__/graphics/icons/recipe-waterwood.png",
		icon_size = 32,
		subgroup = "omniphlog",
		category = "omnite-extraction-both"
	},
	
	
	
{
		type = "recipe",
		name = "waterstone",
		energy_required = 0.5,
		enabled = true,
		ingredients = {
			{type="item", name="omni-scrap", amount=7},
		},
		results = {
			{type="item", name="stone-crushed", amount=5},
		},
		icon = "__omniIsland__/graphics/icons/recipe-waterstone.png",
		icon_size = 32,
		subgroup = "omniphlog",
		category = "omnite-extraction-both"
	},
	
	
{
		type = "recipe",
		name = "Htf-mineral",
		energy_required = 2,
		enabled = true,
		ingredients = {
			{type="item", name="omni-scrap", amount=3},
		},
		results = {
			{type="item", name="omnite", amount=1},
			{type="item", name="stone-crushed", amount=1},
		},
		icon = "__omniIsland__/graphics/icons/recipe-Htf-mineral.png",
		icon_size = 32,
		subgroup = "omniphlog",
		category = "omnite-extraction-both"
	},
	
	
})
