-- Xander Mod
deadlock.add_tier({
	transport_belt      = "slow-transport-belt",
	colour              = {r=166, g=166, b=110},
	underground_belt    = "slow-underground-belt",
	splitter            = "slow-splitter",
	technology          = "logistics_0",
	order               = "0",
	loader_ingredients  = {
		{"slow-transport-belt",1},
		{"stone-brick",4},
		{"bronze-plate",2},
	},
	beltbox_ingredients = {
		{"slow-transport-belt",2},
		{"stone-brick",8},
		{"bronze-plate",4},
	},
})
if data.raw.technology["slow-transport-belt-beltbox"] then
	table.insert(data.raw.technology["deadlock-stacking-1"].prerequisites, "slow-transport-belt-beltbox")
end

deadlock.add_tier({
	transport_belt      = "expedited-transport-belt",
	colour              = {r=10, g=225, b=25},
	underground_belt    = "expedited-underground-belt",
	splitter            = "expedited-splitter",
	technology          = "logistics-3",
	order               = "c",
	loader_ingredients  = {
		{"fast-transport-belt-loader",1},
		{"expedited-transport-belt",1},
		{"concrete",10},
		{"forging-aluminum",1},
	},
	beltbox_ingredients = {
		{"fast-transport-belt-beltbox",1},
		{"iron-plate",30},
		{"iron-gear-wheel",30},
		{amount = 100,name = "lubricant",type = "fluid"},
	},
	beltbox_category    = "crafting-with-fluid",
	beltbox_technology  = "deadlock-stacking-3",
})

-- the logistics-3 tech has been reset, add tier 3 vanilla loader (tier 4 in xander) to the tier 4 unlock
table.insert(data.raw.technology["logistics-4"].effects, {
	type = "unlock-recipe",
	recipe = "express-transport-belt-loader",
})
-- the logistics tech has been reset, add tier 1 vanilla loader
table.insert(data.raw.technology["logistics"].effects, {
	type = "unlock-recipe",
	recipe = "transport-belt-loader",
})
-- also change the recipes of t4 express since it's still made of t2 items
data.raw.recipe["express-transport-belt-loader"].ingredients = {
	{"expedited-transport-belt-loader",1},
	{"express-transport-belt",1},
	{"fused-basalt",12},
	{"forging-stainless",2},
	{"forging-alloy",1}
}
data.raw.recipe["express-transport-belt-beltbox"].ingredients = {
	{"expedited-transport-belt-beltbox",1},
	{"iron-plate",40},
	{"iron-gear-wheel",40},
	{"processing-unit",5}
}
