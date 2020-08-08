data:extend({
	{
		type = "double-setting",
		name = "mc-robot_charge_speed",
		setting_type = "startup",
		default_value = 3,
		minimum_value = 0.01,
		maximum_value = 100,
		order = "a-a-a"
	},
	{
		type = "double-setting",
		name = "mc-robot_capacity",
		setting_type = "startup",
		default_value = 2,
		minimum_value = 0.01,
		maximum_value = 100,
		order = "a-a-b"
	},
})