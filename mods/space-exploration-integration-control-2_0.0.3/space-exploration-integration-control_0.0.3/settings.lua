data:extend
{
    -- robots
	{
		type = "bool-setting",
		name = "se-restore-logistic-robot-tech",
		setting_type = "startup",
        order = "1-1",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = "se-restore-robot-speed",
		setting_type = "startup",
        order = "1-2",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = "se-restore-robot-cargo-capacity",
		setting_type = "startup",
        order = "1-3",
		default_value = false,
	},
    
    -- beacons
	{
		type = "bool-setting",
		name = "se-restore-beacons",
		setting_type = "startup",
        order = "2-1",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = "se-restore-productivity-modules",
		setting_type = "startup",
        order = "2-2",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = "se-restore-speed-modules",
		setting_type = "startup",
        order = "2-3",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = "se-restore-efficiency-modules",
		setting_type = "startup",
        order = "2-4",
		default_value = false,
	},
    
    -- personal equipment
	{
		type = "bool-setting",
		name = "se-restore-power-armors",
		setting_type = "startup",
        order = "3-1",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "se-restore-personal-roboport-mk2",
		setting_type = "startup",
        order = "3-2",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "se-restore-personal-energy-shield-mk2",
		setting_type = "startup",
        order = "3-3",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "se-restore-battery-mk2-equipment",
		setting_type = "startup",
        order = "3-4",
		default_value = true,
	},
}
