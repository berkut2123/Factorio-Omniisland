--settings.lua

data:extend(
{
	-- Startup
	
	-- Global
	{
		type = "bool-setting",
		name = "enable_debug_window",
		setting_type = "runtime-global",
		default_value = false,
		order = "a-a"
	},
	{
		type = "int-setting",
		name = "tree_expansion_frequency",
		setting_type = "runtime-global", 
		minimum_value = 60,
		default_value = 120,
		maximum_value = 360,
		order = "a-b",
	},
	{
		type = "int-setting",
		name = "max_trees",
		setting_type = "runtime-global", 
		--minimum_value = 60,
		default_value = 800000,
		--maximum_value = 360,
		order = "a-c",
	},
	{
		type = "double-setting",
		name = "tree_decrease_start",
		setting_type = "runtime-global",
		minimum_value = 0.1,
		default_value = 0.8,
		maximum_value = 1,
		order = "a-d",
	},
	{
		type = "int-setting",
		name = "pollution_threshold",
		setting_type = "runtime-global", 
		minimum_value = 0,
		default_value = 1500,
		--maximum_value = x,
		order = "a-e",
	},

	-- Per user

--[[
Types of settings:
	• startup - game must be restarted if changed (such a setting may affect prototypes' changes)
	• runtime-global - per-world setting
	• runtime-per-user - per-user setting

Types of values:
	• bool-setting
	• double-setting
	• int-setting
	• string-setting

Files being processed by the game:
	• settings.lua
	• settings-updates.lua
	• settings-final-fixes.lua
	
Using in DATA.lua:
data:extend({
   {
      type = "int-setting",
      name = "setting-name1",
      setting_type = "runtime-per-user",
      default_value = 25,
      minimum_value = -20,
      maximum_value = 100,
      per_user = true,
   },
   {
      type = "bool-setting",
      name = "setting-name2",
      setting_type = "runtime-per-user",
      default_value = true,
      per_user = true,
   },
   {
      type = "double-setting",
      name = "setting-name3",
      setting_type = "runtime-per-user",
      default_value = -23,
      per_user = true,
   },
   {
      type = "string-setting",
      name = "setting-name4",
      setting_type = "runtime-per-user",
      default_value = "Hello",
      allowed_values = {"Hello", "foo", "bar"},
      per_user = true,
   },
})

The order property is a simple string. When the game compares 2 like prototypes if the order strings aren't equal they're lexicographical compared to determine if a given prototype comes before or after another. When the order strings are equal the game then falls back to comparing the prototype names to determine order.
Example: The second item is shown before the first one (in the crafting grid/inventory etc)
 {
   type = "item",
   name = "item-1",
   order = "a-d",
 },
 {
   type = "item",
   name = "item-2",
   order = "a-b",
 },

Using in LOCALE.cfg:
	[mod-setting-name]
	setting-name1=Setting name
	[mod-setting-description]
	setting-name1=Setting description

Using in CONTROL.lua and in other code for reading:
	EVENT: on_runtime_mod_setting_changed - called when a player changed its setting
		event.player_index
		event.setting
	GET: settings.startup["setting-name"].value - current value of startup setting; can be used in DATA.lua
	GET: settings.global["setting-name"].value - current value of per-world setting
	GET: set = settings.get_player_settings(LuaPlayer) - current values for per-player settings; then use set["setting-name"].value
	GET: settings.player - default values
]]

}
)
