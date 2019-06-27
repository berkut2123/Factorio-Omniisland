-- check mod state
script.on_configuration_changed(function(data)
    -- midgame installation
    if data.mod_changes ~= nil and data.mod_changes["AsphaltRoads"] ~= nil and data.mod_changes["AsphaltRoads"].old_version == nil then
        -- anounce installation
        notification({"AR-notification-midgame-update", {"AR-prefix"}, data.mod_changes["AsphaltRoads"].new_version})

    -- midgame update
    elseif data.mod_changes ~= nil and data.mod_changes["AsphaltRoads"] ~= nil and data.mod_changes["AsphaltRoads"].old_version ~= nil then
        local oldver = data.mod_changes["AsphaltRoads"].old_version
        local newver = data.mod_changes["AsphaltRoads"].new_version
        notification({"AR-notification-new-version", {"AR-prefix"}, oldver, newver})
		
		for index, force in pairs(game.forces) do
            force.reset_recipes()
			force.reset_technologies()
			force.reset_technology_effects()
        end
    
    -- if other mods changed or prototypes changes
    elseif data.mod_changes ~= nil or data.mod_startup_settings_changed then
        for index, force in pairs(game.forces) do
            --force.recipes["Arci-asphalt"].reload()
			force.reset_recipes()
			force.reset_technologies()
			force.reset_technology_effects()
        end
	end
end)

function notification(txt, force)
    if force ~= nil then
        force.print(txt)
    else
        for k, p in pairs (game.players) do
            game.players[k].print(txt)
        end
    end
end