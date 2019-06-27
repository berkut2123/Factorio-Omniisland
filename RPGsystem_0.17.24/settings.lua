data:extend({

{
	type = "int-setting",
	name = "charxpmod_xpinilevel",
	setting_type = "startup",
	default_value = 600,
	minimum_value = 2,
	maximum_value = 10000,
	order = "ba"
}, 

{
	type = "double-setting",
	name = "charxpmod_xpmult",
	setting_type = "startup",
	default_value = 1.6,
	minimum_value = 1.5,
	maximum_value = 10,
	order = "ba"
}, 

  {
    type = "int-setting",
    name = "charxpmod_afk",
    setting_type = "runtime-global",
	default_value = 15,
	minimum_value = 0,
	maximum_value = 180,
	order = "ba"
  },

  {
    type = "int-setting",
    name = "charxpmod_death_penal",
    setting_type = "runtime-global",
	default_value = 10,
	minimum_value = 0,
	maximum_value = 100,
	order = "ba"
  },
  
  {
    type = "bool-setting",
    name = "charxpmod_time_ratio_xp",
    setting_type = "runtime-global",
    default_value = true,
	order = "ba"
  },  
  
  {
    type = "bool-setting",
    name = "charxpmod_time_ratio_xp",
    setting_type = "runtime-global",
    default_value = true,
	order = "ba"
  },  
  
   {
    type = "bool-setting",
    name = "charxpmod_print_xp_user",
    setting_type = "runtime-per-user",
    default_value = false,
	order = "ba"
  },  
   
{
	type = "double-setting",
	name = "charxpmod_xp_multiplier_bonus",
	setting_type = "startup",
	default_value = 1,
	minimum_value = 0.2,
	maximum_value = 100,
	order = "cz"
}, 
  
  
})