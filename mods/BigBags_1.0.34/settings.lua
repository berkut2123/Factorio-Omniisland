data:extend({
{
	type = "int-setting",
	name = "my_stack_offset",
	setting_type = "startup",
	default_value = 0,
	minimum_value = 0,
	maximum_value = 500000,
	order = "b"
},
{
	type = "int-setting",
	name = "my_stack_factor",
	setting_type = "startup",
	default_value = 10,
	minimum_value = 0,
	maximum_value = 1000,
	order = "a"
},
{
	type = "int-setting",
	name = "my_mag_offset",
	setting_type = "startup",
	default_value = 0,
	minimum_value = 0,
	maximum_value = 500000,
	order = "d"
},
{
	type = "int-setting",
	name = "my_mag_factor",
	setting_type = "startup",
	default_value = 10,
	minimum_value = 0,
	maximum_value = 1000,
	order = "c"
},
{
	type = "int-setting",
	name = "my_default_req_amount",
	setting_type = "startup",
	default_value = 10,
	minimum_value = 0,
	maximum_value = 10000,
	order = "e"
},
{
	type = "int-setting",
	name = "my_running_speed_factor",
	setting_type = "startup",
	default_value = 1,
	minimum_value = 0,
	maximum_value = 100,
	order = "f"
}
})