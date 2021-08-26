data:extend({
	{
		type = "battery-equipment",
		name = "heli-remote-equipment",
		sprite =
		{
			filename = "__HelicopterRevival__/graphics/icons/heli-remote-equipment.png",
			width = 64,
			height = 64,
			priority = "medium"
		},
		shape =
		{
			width = 2,
			height = 2,
			type = "full"
		},
		energy_source =
		{
			type = "electric",
			buffer_capacity = "2MJ",
			input_flow_limit = "1MW",
			output_flow_limit = "1MW",
			usage_priority = "tertiary"
		},
		categories = {"armor"}
	},
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	{ -- Gunship grid
		type = "equipment-grid",
		name = "heli-equipment-grid",
		width = 8,
		height = 4,
		equipment_categories = {"armor"}
	},
})