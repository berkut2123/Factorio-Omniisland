data:extend({
--Categories for reverse recipes
	{
		type = "recipe-category",
		name = "recycle"
	},
	{
		type = "recipe-category",
		name = "recycle-with-fluids"
	},
--For recipes with multiple outputs
	{
		type = "item-group",
		name = "rf-multiple-outputs",
		order = "f",
		inventory_order = "f",
		icon = "__core__/graphics/questionmark.png",
		icon_size = 64
	},
	{
		type = "item-subgroup",
		name = "rf-multiple-outputs",
		group = "rf-multiple-outputs",
		order = "a",
		icon_size = 64
	},
--A hidden group to store the reverse recipes
	{
		type = "item-group",
		name = "recycling",
		icon = "__core__/graphics/questionmark.png",
		icon_size = 64,
		order = "z",
	},
--Subgroup for the reverse factory itself
	{
		type = "item-subgroup",
		name = "recycling",
		group = "recycling",
		order = "z",
	}
})
