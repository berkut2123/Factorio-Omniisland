local item_types={
"item",
"ammo",
"armor",
"capsule",
"deconstruction-item",
"gun",
"mining-tool",
"module",
"rail-planner",
"repair-tool",
"tool",
"upgrade-item",
}
for i, type in pairs(item_types) do
	if data.raw[type] then
		for id, data in pairs(data.raw[type]) do
			data.localised_name = data.name
		--data.localised_name = 'item-name.' .. data.name.."["..data.name.."]"
		end
	end
end

local equipment_types={
"battery-equipment",
"belt-immunity-equipment",
"active-defense-equipment",
"belt-immunity-equipment",
"energy-shield-equipment",
"generator-equipment",
"movement-bonus-equipment",
"night-vision-equipment",
"roboport-equipment",
"solar-panel-equipment",
 }
for i, type in pairs(equipment_types) do
	if data.raw[type] then
		for id, data in pairs(data.raw[type]) do
			data.localised_name = data.name
		--data.localised_name = 'item-name.' .. data.name.."["..data.name.."]"
		end
	end
end




local entity_types={
"accumulator",
"ammo-turret",
"arithmetic-combinator",
"artillery-turret",
"artillery-wagon",
"assembling-machine",
"beacon",
"boiler",
"car",
"cargo-wagon",
"character-corpse",
"combat-robot",
"constant-combinator",
"construction-robot",
"container",
--"corpse",
"curved-rail",
"decider-combinator",
"electric-energy-interface",
"electric-pole",
"electric-turret",
"fluid-turret",
"fluid-wagon",
"furnace",
"gate",
"generator",
"heat-interface",
"heat-pipe",
"infinity-container",
"infinity-pipe",
"inserter",
"item-request-proxy",
"lab",
"lamp",
"land-mine",
"loader",
"locomotive",
"logistic-container",
"logistic-robot",
"mining-drill",
"offshore-pump",
"pipe",
"pipe-to-ground",
--"player",
"player-port",
"power-switch",
"programmable-speaker",
"pump",
"radar",
"rail-chain-signal",
"rail-signal",
"reactor",
"resource",
"roboport",
"rocket-silo",
"rocket-silo-rocket",
"simple-entity",
"simple-entity-with-force",
"simple-entity-with-owner",
"solar-panel",
"splitter",
"storage-tank",
"straight-rail",
"train-stop",
"transport-belt",
"tree",
"turret",
"underground-belt",
"unit",
"unit-spawner",
"wall",
}

for i, type in pairs(entity_types) do
	if data.raw[type] then
		for id, data in pairs(data.raw[type]) do
			data.localised_name = data.name
		--data.localised_name = 'item-name.' .. data.name.."["..data.name.."]"
		end
	end
end

for id, data in pairs(data.raw["virtual-signal"]) do
data.localised_name = data.name
--data.localised_name = 'item-name.' .. data.name.."["..data.name.."]"
end

for id, data in pairs(data.raw.fluid) do
data.localised_name = data.name
--data.localised_name = 'item-name.' .. data.name.."["..data.name.."]"
end
for id, data in pairs(data.raw.technology) do
data.localised_name = data.name
--data.localised_name = 'item-name.' .. data.name.."["..data.name.."]"
end

--for id, data in pairs(data.raw.recipe) do
--data.localised_name = { "__1__ ["..data.name.."]", 
--          {'recipe-name.' .. data.name}}
----data.localised_name = 'item-name.' .. data.name.."["..data.name.."]"
--end
--??? item-with-entity-data (cargo-wagon)