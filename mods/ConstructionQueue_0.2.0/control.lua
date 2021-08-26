script.on_init(function ()
	modify_queue()	
end)

script.on_configuration_changed(function (data)
	modify_queue()		
end)

script.on_event(defines.events.on_runtime_mod_setting_changed,function ()
	modify_queue()
end)


function modify_queue()
	local settings = settings.global	
	
	game.forces["player"].max_successful_attempts_per_tick_per_construction_queue = settings["keniras-construction-queue-attempts"]["value"]
	game.forces["player"].max_failed_attempts_per_tick_per_construction_queue = settings["keniras-construction-queue-attempts"]["value"]
end