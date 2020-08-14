data:extend({
	{
		type = "string-setting",
		name = "nuclear-fuel-cycle-type",
		setting_type = "startup",
    default_value = "classic",
    allowed_values = {"classic", "alternative"},
    order = "a"
	},
  {
    type = "string-setting",
    name = "nuclear-fuel-bomb-ingredient",
    setting_type = "startup",
    default_value = "plutonium",
    allowed_values = {"uranium", "plutonium", "both"},
    order = "b"
  },
  {
    type = "bool-setting",
    name = "nuclear-fuel-geiger-tick",
    setting_type = "startup",
    default_value = false,
    order = "c"
  }
})