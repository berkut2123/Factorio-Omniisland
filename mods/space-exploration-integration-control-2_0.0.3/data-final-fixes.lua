local data_util = require("data_util")

if settings.startup["se-restore-personal-roboport-mk2"].value then
	-- personal-roboport-equipment
	data_util.tech_remove_prerequisites("personal-roboport-equipment", {"utility-science-pack"})
	data_util.tech_remove_ingredients_recursive("personal-roboport-equipment", {"utility-science-pack"})
		
	-- personal-roboport-mk2-equipment
	data_util.tech_remove_prerequisites("personal-roboport-mk2-equipment", {"utility-science-pack"})
	data_util.tech_remove_prerequisites("personal-roboport-mk2-equipment", {data_util.mod_prefix .. "material-science-pack"})
	data_util.tech_remove_ingredients_recursive("personal-roboport-mk2-equipment", {data_util.mod_prefix .. "material-science-pack"})
end

if settings.startup["se-restore-robot-cargo-capacity"].value then
	-- robot cargo capacity
	data_util.tech_remove_ingredients_recursive("worker-robots-storage-1", {"production-science-pack" })
	data_util.tech_remove_prerequisites("worker-robots-storage-1", {"utility-science-pack", "space-science-pack"})

	data_util.tech_remove_prerequisites("worker-robots-storage-2", {"utility-science-pack", "space-science-pack", data_util.mod_prefix .. "material-science-pack"})
	data_util.tech_remove_ingredients_recursive("worker-robots-storage-2", {"utility-science-pack" })

	data_util.tech_remove_ingredients_recursive("worker-robots-storage-3", {"space-science-pack", data_util.mod_prefix .. "deep-space-science-pack", data_util.mod_prefix .. "material-science-pack"})
	data_util.tech_remove_prerequisites("worker-robots-storage-3", {"utility-science-pack", "space-science-pack", data_util.mod_prefix .. "material-science-pack", data_util.mod_prefix .. "deep-space-science-pack"})
end

if settings.startup["se-restore-robot-speed"].value then
	-- robot speed
	data_util.tech_remove_prerequisites("worker-robots-speed-3", {"production-science-pack"})
	data_util.tech_add_ingredients_with_prerequisites("worker-robots-speed-3", {"utility-science-pack"})

	data_util.tech_remove_ingredients_recursive("worker-robots-speed-4", {"production-science-pack"})
	data_util.tech_remove_prerequisites("worker-robots-speed-4", {"space-science-pack"})

	data_util.tech_remove_ingredients_recursive("worker-robots-speed-5", {"space-science-pack"})
	data_util.tech_remove_prerequisites("worker-robots-speed-5", {"space-science-pack", data_util.mod_prefix .. "energy-science-pack", "utility-science-pack"})

	data_util.tech_remove_ingredients_recursive("worker-robots-speed-6", {data_util.mod_prefix .. "energy-science-pack", data_util.mod_prefix .. "material-science-pack", data_util.mod_prefix .. "deep-space-science-pack"})
	data_util.tech_remove_prerequisites("worker-robots-speed-6", { data_util.mod_prefix .. "deep-space-science-pack"})
end

if settings.startup["se-restore-logistic-robot-tech"].value then
	-- beacons
	data_util.tech_remove_prerequisites("logistic-robotics", { "utility-science-pack"})
	data_util.tech_remove_ingredients_recursive("logistic-robotics", { "utility-science-pack"})
end

if settings.startup["se-restore-personal-energy-shield-mk2"].value then
	-- energy shield mk1
	data_util.remove_ingredient_sub(data.raw.recipe["energy-shield-equipment"] , 'copper-cable')
	data_util.remove_ingredient_sub(data.raw.recipe["energy-shield-equipment"], data_util.mod_prefix .. 'plasma-electrodynamics-data')

	-- energy shield mk2
	data_util.remove_ingredient_sub(data.raw.recipe["energy-shield-mk2-equipment"], data_util.mod_prefix .. 'plasma-thermodynamics-data')
	data_util.remove_ingredient_sub(data.raw.recipe["energy-shield-mk2-equipment"], data_util.mod_prefix .. 'subatomic-data')
	
	data_util.tech_remove_prerequisites("energy-shield-mk2-equipment", {data_util.mod_prefix .. "space-catalogue-energy-2"})
	data_util.tech_remove_prerequisites("energy-shield-mk2-equipment", {data_util.mod_prefix .. "material-science-pack"})
end

if settings.startup["se-restore-power-armors"].value then
	-- power-armors
	data_util.tech_remove_prerequisites("power-armor", {"utility-science-pack"})
	data_util.tech_remove_ingredients_recursive("power-armor", {"utility-science-pack"})
	data_util.tech_remove_prerequisites("power-armor", {"production-science-pack"})
	data_util.tech_remove_ingredients_recursive("power-armor", {"production-science-pack"})
	-- integraton with Krastorio
	if mods["Krastorio"] then
		data_util.tech_remove_prerequisites("power-armor-mk3", {"production-science-pack"})
		data_util.tech_remove_ingredients_recursive("power-armor-mk3", {"production-science-pack"})
		data_util.tech_remove_prerequisites("power-armor-mk4", {"production-science-pack"})
		data_util.tech_remove_ingredients_recursive("power-armor-mk4", {"production-science-pack"})
	end
end

if settings.startup["se-restore-battery-mk2-equipment"].value then
	-- battery-mk2-equipment
	data_util.tech_remove_prerequisites("battery-mk2-equipment", {"space-science-pack"})
	data_util.tech_remove_ingredients_recursive("battery-mk2-equipment", {"space-science-pack"})
end

-- -- Modules

if settings.startup["se-restore-beacons"].value then
	-- beacons
	data_util.tech_remove_prerequisites("effect-transmission", { data_util.mod_prefix .. "energy-science-pack"})
	data_util.tech_remove_ingredients_recursive("effect-transmission", { "space-science-pack", data_util.mod_prefix .. "energy-science-pack"} )
end

if settings.startup["se-restore-productivity-modules"].value then
	-- productivity modules
	data_util.tech_remove_ingredients_recursive("productivity-module-2", {"production-science-pack"})
	data_util.tech_remove_prerequisites("productivity-module-2", {"production-science-pack"})

	data_util.tech_remove_prerequisites("productivity-module-3", {"space-science-pack", data_util.mod_prefix .. "biological-science-pack"})
	data_util.tech_add_prerequisites("productivity-module-3", {"production-science-pack"})
	data_util.tech_remove_ingredients_recursive("productivity-module-3", { "space-science-pack", data_util.mod_prefix .. "biological-science-pack" })
end

if settings.startup["se-restore-speed-modules"].value then
	-- speed modules
	data_util.tech_remove_ingredients_recursive("speed-module-2", {"production-science-pack"})
	data_util.tech_remove_prerequisites("speed-module-2", {"production-science-pack"})

	data_util.tech_remove_prerequisites("speed-module-3", {"space-science-pack", data_util.mod_prefix .. "material-science-pack"})
	data_util.tech_add_prerequisites("speed-module-3", {"production-science-pack"})
	data_util.tech_remove_ingredients_recursive("speed-module-3", { "space-science-pack", data_util.mod_prefix .. "material-science-pack" }, true)
end

if settings.startup["se-restore-efficiency-modules"].value then
	-- efficiency modules
	data_util.tech_remove_ingredients_recursive("effectivity-module-2", {"production-science-pack"})
	data_util.tech_remove_prerequisites("effectivity-module-2", {"production-science-pack"})

	data_util.tech_remove_prerequisites("effectivity-module-3", {"space-science-pack", data_util.mod_prefix .. "energy-science-pack"})
	data_util.tech_add_prerequisites("effectivity-module-3", {"production-science-pack"})
	data_util.tech_remove_ingredients_recursive("effectivity-module-3", { "space-science-pack", data_util.mod_prefix .. "energy-science-pack" }, true)
end