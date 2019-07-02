function addExcludedEntityToSqueakThrough(in_exclusions, name, category)
	table.insert(in_exclusions, 
	{	
		{		   
			apply_when_object_exists = 
			{
				type = category,
				name = name,
			},
			excluded_prototype_names = 
			{
				name
			}
		}
	})
end

if mods["Squeak Through"] then
	require "__Squeak Through__/config"
	
	exclusions_to_add =
	{	
		-- medium storehouse	
		["storage-tank"] =
		{
			"duct-small", 
			"duct", 
			"duct-long", 
			"duct-t-junction", 
			"duct-curve", 
			"duct-cross", 
			"duct-underground"
		},
		["pump"] =
		{
			"duct-intermediate-point",
			"duct-end-point-intake-south",
			"duct-end-point-intake-west",
			"duct-end-point-intake-north",
			"duct-end-point-intake-east",
			"duct-end-point-outtake-south",
			"duct-end-point-outtake-west",
			"duct-end-point-outtake-north",
			"duct-end-point-outtake-east"
		}
	}
	
	for category_name, items in pairs(exclusions_to_add) do
		for _, item_name in pairs(items) do
			addExcludedEntityToSqueakThrough(exclusions, item_name, category_name)
		end
	end
	
end
	

