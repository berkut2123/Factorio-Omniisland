if settings.startup["deadlock-integrations-new-bob-recipes"].value then
	-- opt-in new recipes
	if data.raw["transport-belt"]["basic-transport-belt"] then
		deadlock.add_tier({
			transport_belt      = "basic-transport-belt",
			colour              = {r=165, g=165, b=165},
			underground_belt    = "basic-underground-belt",
			splitter            = "basic-splitter",
			technology          = "logistics-0",
			order               = "0",
			loader_ingredients  = {
				{"burner-inserter",4},
				{"basic-splitter",2},
				{"wood",10}
			},
			beltbox_ingredients = {
				{"burner-inserter",10},
				{"basic-splitter",5},
				{"iron-gear-wheel",20},
				{"wood",10}
			},
		})
		if data.raw.technology["basic-transport-belt-beltbox"] then
			data.raw.furnace["basic-transport-belt-beltbox"].next_upgrade = "transport-belt-beltbox"
			data.raw.technology["basic-transport-belt-beltbox"].localised_name = nil
			table.insert(data.raw.technology["deadlock-stacking-1"].prerequisites, "basic-transport-belt-beltbox")
		end
		if data.raw["loader-1x1"]["basic-transport-belt-loader"] then
			data.raw["loader-1x1"]["basic-transport-belt-loader"].next_upgrade = "transport-belt-loader"
		end
	end

	local inserter = "fast-inserter"
	if data.raw.item["turbo-inserter"] then
		inserter = "turbo-inserter"
	end
	deadlock.add_tier({
		transport_belt      = "turbo-transport-belt",
		colour              = {r=165,g=10,b=225},
		underground_belt    = "turbo-underground-belt",
		splitter            = "turbo-splitter",
		technology          = "logistics-4",
		order               = "d",
		loader_ingredients  = {
			{"express-transport-belt-loader",1},
			{inserter,4},
			{"turbo-splitter",2},
			{"steel-plate",10}
		},
		beltbox_ingredients = {
			{"express-transport-belt-beltbox",1},
			{inserter,10},
			{"turbo-splitter",3},
			{"steel-plate",10}
		},
		beltbox_technology  = "deadlock-stacking-4",
	})

	if data.raw.technology["deadlock-stacking-4"] then
		local found = false
		for _, techname in ipairs(data.raw.technology["deadlock-stacking-4"].prerequisites) do
			if techname == "deadlock-stacking-3" then
				found = true
				break
			end
		end
		if not found then
			table.insert(data.raw.technology["deadlock-stacking-4"].prerequisites, "deadlock-stacking-3")
		end
	end
	if data.raw.furnace["turbo-transport-belt-beltbox"] then
		data.raw.furnace["express-transport-belt-beltbox"].next_upgrade = "turbo-transport-belt-beltbox"
	end
	if data.raw["loader-1x1"]["turbo-transport-belt-loader"] then
		data.raw["loader-1x1"]["express-transport-belt-loader"].next_upgrade = "turbo-transport-belt-loader"
	end

	deadlock.add_tier({
		transport_belt      = "ultimate-transport-belt",
		colour              = {r=10,g=225,b=25},
		underground_belt    = "ultimate-underground-belt",
		splitter            = "ultimate-splitter",
		technology          = "logistics-5",
		order               = "e",
		loader_ingredients  = {
			{"turbo-transport-belt-loader",1},
			{"express-inserter",4},
			{"ultimate-splitter",2},
			{"steel-plate",10}
		},
		beltbox_ingredients = {
			{"turbo-transport-belt-beltbox",1},
			{"express-inserter",10},
			{"ultimate-splitter",3},
			{"steel-plate",10}
		},
		beltbox_technology  = "deadlock-stacking-5",
	})

	if data.raw.technology["deadlock-stacking-5"] then
		local found = false
		for _, techname in ipairs(data.raw.technology["deadlock-stacking-5"].prerequisites) do
			if techname == "deadlock-stacking-4" then
				found = true
				break
			end
		end
		if not found then
			table.insert(data.raw.technology["deadlock-stacking-5"].prerequisites, "deadlock-stacking-4")
		end
	end
	if data.raw.furnace["ultimate-transport-belt-beltbox"] then
		data.raw.furnace["turbo-transport-belt-beltbox"].next_upgrade = "ultimate-transport-belt-beltbox"
	end
	if data.raw["loader-1x1"]["ultimate-transport-belt-loader"] then
		data.raw["loader-1x1"]["turbo-transport-belt-loader"].next_upgrade = "ultimate-transport-belt-loader"
	end

	-- update existing recipes to match
	if settings.startup["bobmods-logistics-beltoverhaul"].value then
		if data.raw.recipe["transport-belt-loader"] then
			data.raw.recipe["transport-belt-loader"].ingredients = {
				{"basic-transport-belt-loader",1},
				{"inserter",4},
				{"splitter",2},
				{"iron-plate",10}
			}
		end

		if data.raw.recipe["transport-belt-beltbox"] then
			data.raw.recipe["transport-belt-beltbox"].ingredients = {
				{"basic-transport-belt-beltbox",1},
				{"inserter",10},
				{"splitter",3},
				{"iron-plate",10}
			}
		end

		if data.raw.recipe["fast-transport-belt-loader"] then
			data.raw.recipe["fast-transport-belt-loader"].ingredients = {
				{"transport-belt-loader",1},
				{"long-handed-inserter",4},
				{"fast-splitter",2},
				{"steel-plate",10}
			}
		end

		if data.raw.recipe["fast-transport-belt-beltbox"] then
			data.raw.recipe["fast-transport-belt-beltbox"].ingredients = {
				{"transport-belt-beltbox",1},
				{"long-handed-inserter",10},
				{"fast-splitter",3},
				{"steel-plate",10}
			}
		end

		if data.raw.recipe["express-transport-belt-loader"] then
			data.raw.recipe["express-transport-belt-loader"].ingredients = {
				{"fast-transport-belt-loader",1},
				{"fast-inserter",4},
				{"express-splitter",2},
				{"steel-plate",10}
			}
			data.raw.recipe["express-transport-belt-loader"].category = "crafting"
		end

		if data.raw.recipe["express-transport-belt-beltbox"] then
			data.raw.recipe["express-transport-belt-beltbox"].ingredients = {
				{"fast-transport-belt-beltbox",1},
				{"fast-inserter",10},
				{"express-splitter",3},
				{"steel-plate",10}
			}
		end

		-- Update speeds if overhauled
		if settings.startup["bobmods-logistics-beltoverhaulspeed"].value then
			-- t0
			if data.raw["loader-1x1"]["basic-transport-belt-loader"] then
				data.raw["loader-1x1"]["basic-transport-belt-loader"].speed = bobmods.logistics.belt_speed(1)
			end
			if data.raw.furnace["basic-transport-belt-beltbox"] then
				data.raw.furnace["basic-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(1) * 32
			end
			-- t1
			if data.raw["loader-1x1"]["transport-belt-loader"] then
				data.raw["loader-1x1"]["transport-belt-loader"].speed = bobmods.logistics.belt_speed(2)
			end
			if data.raw.furnace["transport-belt-beltbox"] then
				data.raw.furnace["transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(2) * 32
			end
			-- t2
			if data.raw["loader-1x1"]["fast-transport-belt-loader"] then
				data.raw["loader-1x1"]["fast-transport-belt-loader"].speed = bobmods.logistics.belt_speed(3)
			end
			if data.raw.furnace["fast-transport-belt-beltbox"] then
				data.raw.furnace["fast-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(3) * 32
			end
			-- t3
			if data.raw["loader-1x1"]["express-transport-belt-loader"] then
				data.raw["loader-1x1"]["express-transport-belt-loader"].speed = bobmods.logistics.belt_speed(4)
			end
			if data.raw.furnace["express-transport-belt-beltbox"] then
				data.raw.furnace["express-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(4) * 32
			end
			-- t4
			if data.raw["loader-1x1"]["turbo-transport-belt-loader"] then
				data.raw["loader-1x1"]["turbo-transport-belt-loader"].speed = bobmods.logistics.belt_speed(5)
			end
			if data.raw.furnace["turbo-transport-belt-beltbox"] then
				data.raw.furnace["turbo-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(5) * 32
			end
			-- t5
			if data.raw["loader-1x1"]["ultimate-transport-belt-loader"] then
				data.raw["loader-1x1"]["ultimate-transport-belt-loader"].speed = bobmods.logistics.belt_speed(6)
			end
			if data.raw.furnace["ultimate-transport-belt-beltbox"] then
				data.raw.furnace["ultimate-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(6) * 32
			end
		end
	end
else
	-- default recipes
	if data.raw["transport-belt"]["basic-transport-belt"] then
		deadlock.add_tier({
			transport_belt      = "basic-transport-belt",
			colour              = {r=165, g=165, b=165},
			underground_belt    = "basic-underground-belt",
			splitter            = "basic-splitter",
			technology          = "logistics-0",
			order               = "0",
			loader_ingredients  = {
				{"basic-transport-belt",1},
				{"stone",1},
				{"wood",1}
			},
			beltbox_ingredients = {
				{"basic-transport-belt",1},
				{"stone",4},
				{"wood",4}
			},
		})
		if data.raw.technology["basic-transport-belt-beltbox"] then
			data.raw.furnace["basic-transport-belt-beltbox"].next_upgrade = "transport-belt-beltbox"
			data.raw.technology["basic-transport-belt-beltbox"].localised_name = nil
			table.insert(data.raw.technology["deadlock-stacking-1"].prerequisites, "basic-transport-belt-beltbox")
		end
		if data.raw["loader-1x1"]["basic-transport-belt-loader"] then
			data.raw["loader-1x1"]["basic-transport-belt-loader"].next_upgrade = "transport-belt-loader"
		end
	end

	local t4_loader_ingredients = {
		{"express-transport-belt-loader",1}
	}
	if data.raw.item["titanium-plate"] then
		table.insert(t4_loader_ingredients, {"titanium-plate",7})
	else
		table.insert(t4_loader_ingredients, {"steel-plate",7})
	end
	if data.raw.item["titanium-bearing"] then
		table.insert(t4_loader_ingredients, {amount = 10,name = "titanium-bearing"})
	end
	if data.raw.item["titanium-gear-wheel"] then
		table.insert(t4_loader_ingredients, {"titanium-gear-wheel",10})
	else
		table.insert(t4_loader_ingredients, {"iron-gear-wheel",10})
	end

	deadlock.add_tier({
		transport_belt      = "turbo-transport-belt",
		colour              = {r=165,g=10,b=225},
		underground_belt    = "turbo-underground-belt",
		splitter            = "turbo-splitter",
		technology          = "logistics-4",
		order               = "d",
		loader_ingredients  = t4_loader_ingredients,
		beltbox_ingredients = {
			{"express-transport-belt-beltbox",1},
			{"iron-plate",40},
			{"iron-gear-wheel",40},
			{"processing-unit",5}
		},
		beltbox_technology  = "deadlock-stacking-4",
	})
	if data.raw.technology["deadlock-stacking-4"] then
		local found = false
		for _, techname in ipairs(data.raw.technology["deadlock-stacking-4"].prerequisites) do
			if techname == "deadlock-stacking-3" then
				found = true
				break
			end
		end
		if not found then
			table.insert(data.raw.technology["deadlock-stacking-4"].prerequisites, "deadlock-stacking-3")
		end
	end
	if data.raw.furnace["turbo-transport-belt-beltbox"] then
		data.raw.furnace["express-transport-belt-beltbox"].next_upgrade = "turbo-transport-belt-beltbox"
	end
	if data.raw["loader-1x1"]["turbo-transport-belt-loader"] then
		data.raw["loader-1x1"]["express-transport-belt-loader"].next_upgrade = "turbo-transport-belt-loader"
	end

	local t5_loader_ingredients = {
		{"turbo-transport-belt-loader",1}
	}
	if data.raw.item["nitinol-alloy"] then
		table.insert(t5_loader_ingredients, {"nitinol-alloy",7})
	else
		table.insert(t5_loader_ingredients, {"steel-plate",7})
	end
	if data.raw.item["nitinol-bearing"] then
		table.insert(t5_loader_ingredients, {amount = 10,name = "nitinol-bearing"})
	end
	if data.raw.item["nitinol-gear-wheel"] then
		table.insert(t5_loader_ingredients, {"nitinol-gear-wheel",10})
	else
		table.insert(t5_loader_ingredients, {"iron-gear-wheel",10})
	end
	deadlock.add_tier({
		transport_belt      = "ultimate-transport-belt",
		colour              = {r=10,g=225,b=25},
		underground_belt    = "ultimate-underground-belt",
		splitter            = "ultimate-splitter",
		technology          = "logistics-5",
		order               = "e",
		loader_ingredients  = t5_loader_ingredients,
		beltbox_ingredients = {
			{"turbo-transport-belt-beltbox",1},
			{"iron-plate",50},
			{"iron-gear-wheel",50},
			{"processing-unit",20}
		},
		beltbox_technology  = "deadlock-stacking-5",
	})
	if data.raw.technology["deadlock-stacking-5"] then
		local found = false
		for _, techname in ipairs(data.raw.technology["deadlock-stacking-5"].prerequisites) do
			if techname == "deadlock-stacking-4" then
				found = true
				break
			end
		end
		if not found then
			table.insert(data.raw.technology["deadlock-stacking-5"].prerequisites, "deadlock-stacking-4")
		end
	end
	if data.raw.furnace["ultimate-transport-belt-beltbox"] then
		data.raw.furnace["turbo-transport-belt-beltbox"].next_upgrade = "ultimate-transport-belt-beltbox"
	end
	if data.raw["loader-1x1"]["ultimate-transport-belt-loader"] then
		data.raw["loader-1x1"]["turbo-transport-belt-loader"].next_upgrade = "ultimate-transport-belt-loader"
	end

	-- update existing recipes to match
	if settings.startup["bobmods-logistics-beltoverhaul"].value then
		if data.raw["loader-1x1"]["transport-belt-loader"] then
			local t1_loader_ingredients = {}
			if data.raw["transport-belt"]["basic-transport-belt"] then
				table.insert(t1_loader_ingredients, {"basic-transport-belt-loader",1})
			else
				table.insert(t1_loader_ingredients, {"transport-belt",1})
			end
			table.insert(t1_loader_ingredients, {"iron-gear-wheel",10})
			if data.raw.item["tin-plate"] then
				table.insert(t1_loader_ingredients, {"tin-plate",7})
			else
				table.insert(t1_loader_ingredients, {"iron-plate",7})
			end
			data.raw.recipe["transport-belt-loader"].ingredients = t1_loader_ingredients
		end

		if data.raw.recipe["fast-transport-belt-loader"] then
			local t2_loader_ingredients = {
				{"transport-belt-loader",1}
			}
			if data.raw.item["bronze-alloy"] then
				table.insert(t2_loader_ingredients, {"bronze-alloy",7})
			else
				table.insert(t2_loader_ingredients, {"steel-plate",7})
			end
			if data.raw.item["steel-gear-wheel"] then
				table.insert(t2_loader_ingredients, {"steel-gear-wheel",10})
			else
				table.insert(t2_loader_ingredients, {"iron-gear-wheel",10})
			end
			data.raw.recipe["fast-transport-belt-loader"].ingredients = t2_loader_ingredients
		end

		if data.raw.recipe["express-transport-belt-loader"] then
			local t3_loader_ingredients = {
				{"fast-transport-belt-loader",1}
			}
			if data.raw.item["aluminium-plate"] then
				table.insert(t3_loader_ingredients, {"aluminium-plate",7})
			else
				table.insert(t3_loader_ingredients, {"steel-plate",7})
			end
			if data.raw.item["cobalt-steel-gear-wheel"] then
				table.insert(t3_loader_ingredients, {"cobalt-steel-gear-wheel",10})
			else
				table.insert(t3_loader_ingredients, {"iron-gear-wheel",10})
			end
			if data.raw.item["cobalt-steel-bearing"] then
				table.insert(t3_loader_ingredients, {amount = 10,name = "cobalt-steel-bearing"})
			end
			data.raw.recipe["express-transport-belt-loader"].ingredients = t3_loader_ingredients
			data.raw.recipe["express-transport-belt-loader"].category = "crafting"
		end

		-- Update speeds if overhauled
		if settings.startup["bobmods-logistics-beltoverhaulspeed"].value then
			-- t0
			if data.raw["loader-1x1"]["basic-transport-belt-loader"] then
				data.raw["loader-1x1"]["basic-transport-belt-loader"].speed = bobmods.logistics.belt_speed(1)
			end
			if data.raw.furnace["basic-transport-belt-beltbox"] then
				data.raw.furnace["basic-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(1) * 32
			end
			-- t1
			if data.raw["loader-1x1"]["transport-belt-loader"] then
				data.raw["loader-1x1"]["transport-belt-loader"].speed = bobmods.logistics.belt_speed(2)
			end
			if data.raw.furnace["transport-belt-beltbox"] then
				data.raw.furnace["transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(2) * 32
			end
			-- t2
			if data.raw["loader-1x1"]["fast-transport-belt-loader"] then
				data.raw["loader-1x1"]["fast-transport-belt-loader"].speed = bobmods.logistics.belt_speed(3)
			end
			if data.raw.furnace["fast-transport-belt-beltbox"] then
				data.raw.furnace["fast-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(3) * 32
			end
			-- t3
			if data.raw["loader-1x1"]["express-transport-belt-loader"] then
				data.raw["loader-1x1"]["express-transport-belt-loader"].speed = bobmods.logistics.belt_speed(4)
			end
			if data.raw.furnace["express-transport-belt-beltbox"] then
				data.raw.furnace["express-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(4) * 32
			end
			-- t4
			if data.raw["loader-1x1"]["turbo-transport-belt-loader"] then
				data.raw["loader-1x1"]["turbo-transport-belt-loader"].speed = bobmods.logistics.belt_speed(5)
			end
			if data.raw.furnace["turbo-transport-belt-beltbox"] then
				data.raw.furnace["turbo-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(5) * 32
			end
			-- t5
			if data.raw["loader-1x1"]["ultimate-transport-belt-loader"] then
				data.raw["loader-1x1"]["ultimate-transport-belt-loader"].speed = bobmods.logistics.belt_speed(6)
			end
			if data.raw.furnace["ultimate-transport-belt-beltbox"] then
				data.raw.furnace["ultimate-transport-belt-beltbox"].crafting_speed = bobmods.logistics.belt_speed(6) * 32
			end
		end
	end
end
