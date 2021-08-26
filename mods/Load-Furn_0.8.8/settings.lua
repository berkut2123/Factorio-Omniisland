data:extend({
	{
		type = "bool-setting",
		name = "load-furn-easy-research",
		setting_type = "startup",
		default_value = false,
		order = "a"
	},
	{
		type = "bool-setting",
		name = "logist",
		setting_type = "startup",
		default_value = true,
		order = "b"
	},
	{
		type = "bool-setting",
		name = "steel-plate2",
		setting_type = "startup",
		default_value = true,
		order = "b-1"
	},
	{
		type = "bool-setting",
		name = "cool",
		setting_type = "startup",
		default_value = true,
		order = "b-2"
	},
	{
		type = "bool-setting",
		name = "load-furn-legacy",
		setting_type = "startup",
		default_value = false,
		order = "c"
	},
	{
		type = "double-setting",
		name = "load-furn-energy",
		setting_type = "startup",
		default_value = 1.0,
		minimum_value = 0.1,
		maximum_value = 5.0,
		order = "d"
	},
	{
		type = "double-setting",
		name = "load-furn-crafting-speed",
		setting_type = "startup",
		default_value = 1.0,
		minimum_value = 1.0,
		maximum_value = 5.0,
		order = "e"
	},
	{
		type = "string-setting",
		name = "loader-pro-use-trains",
		setting_type = "runtime-global",
		default_value = "disabled",
		allowed_values = {"disabled", "auto-only", "all trains"},
		order = "f"
	}
})