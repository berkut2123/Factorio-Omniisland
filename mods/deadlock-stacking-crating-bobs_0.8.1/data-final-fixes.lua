-- item name, tech level, has custom stack icon
local items = {
    {"solid-carbon", 2, false},

    -- ores and metals not handled below
  	{"lithium", 2, false},
  	{"solid-lithium", 2, false}, -- actually lithium chloride
  	{"resin", 1, false},
  	{"rubber", 1, false},

    {"quartz", 1, true},
    {"glass", 1, false}, 
    {"silicon", 2, false},
    {"silicon-wafer", 2, false},
    {"ingot-silicon", 3, true},
    {"gem-ore", 1, true},
    {"crystal-dust", 2, false},

    {"bauxite-ore", 1, true},
    {"alumina", 2, false},
    {"aluminium-plate", 2, false},
    {"ingot-aluminium", 3, true},

    {"rutile-ore", 2, true},
    {"titanium-plate", 3, true},
    {"ingot-titanium", 3, true},

    {"thorium-ore", 2, true},
    {"phosphorus-ore", 1, false},

    {"cobalt-ore", 1, true},
    {"cobalt-plate", 2, false},
    {"ingot-cobalt", 2, true},
    {"cobalt-steel-alloy", 2, true},
    {"cobalt-oxide", 3, false},

    {"lithium-cobalt-oxide", 3, false},
    {"lithium-perchlorate", 3, false},

    {"lead-oxide", 2, false},

    {"fluorite-ore", 2, false},

    -- Nuclear
    {"fluorine-ore", 3, false},
    {"plutonium-239", 3, false},
    {"thorium-232", 3, false},

    -- Extended Industries
  	{"bauxite", 1, false},
  	{"aluminium-lithium", 2, false},
  	{"aluminium-alloy", 2, false},
  	{"silicium", 1, false},
  	{"e_engine", 2, false}, -- small electric engine

    -- Bob's gem ores
    {"amethyst-ore", 1, false},
    {"ruby-ore", 1, false},
    {"emerald-ore", 1, false},
    {"sapphire-ore", 1, false},
    {"topaz-ore", 1, false},
    {"diamond-ore", 1, false},

    -- Bob's alloys
    {"gunmetal-alloy", 2, false},
    {"invar-alloy", 2, false},
    {"nitinol-alloy", 3, true},
    {"bronze-alloy", 1, false},
    {"brass-alloy", 2, false},
    {"electrum-alloy", 3, false},
    {"copper-tungsten-alloy", 2, false},
    {"tungsten-carbide", 3, false},
    {"alien-blue-alloy", 4, false},
    {"alien-orange-alloy", 4, false},

    {"angels-plate-invar", 2, false},
    {"angels-plate-nickel", 2, false},

    {"solder", 1, false},
    {"solder-alloy", 1, false},

    -- Bob's intermediates
    {"enriched-fuel", 1, true},
    {"fertiliser", 2, false},

    {"sodium-hydroxide", 2, false},
    {"silicon-nitride", 3, false},
    {"silicon-carbide", 3, false},

    {"battery", 3, false},
    {"lithium-ion-battery", 3, false},
    {"silver-zinc-battery", 3, false},

    {"copper-cable", 1, false},
    {"tinned-copper-cable", 1, false},
    {"gilded-copper-cable", 2, false},
    {"insulated-cable", 2, false},

    {"basic-electronic-components", 1, true},
    {"electronic-components", 2, true},
    {"intergrated-electronics", 3, true}, -- sic
    {"processing-electronics", 4, true},

    {"wooden-board", 1, false},
    {"phenolic-board", 2, false},
    {"fibreglass-board", 3, false},

    {"basic-circuit-board", 1, false},
    {"circuit-board", 2, false},
    {"superior-circuit-board", 2, false},
    {"multi-layer-circuit-board", 3, false},


    -- redo vanilla chips for new icons
    {"electronic-circuit", 2, false},
    {"advanced-circuit", 2, false},
    {"processing-unit", 3, false},
    -- add Bob's chip level 4
    {"advanced-processing-unit", 4, false}, 

    -- UP
    {"up-fluorite", 2, true},
    {"up-uraninite", 2, true},

    -- Angel's solids
    {"slag", 2, false},
    {"solid-sand", 3, false},
    {"solid-limestone", 3, false},
    {"solid-clay", 3, false},
    {"solid-salt", 3, false},
    {"solid-sodium", 3, false},
    {"solid-sodium-hydroxide", 2, false},

	{"solid-cement", 3, true},
	{"solid-glass-mixture", 3, true},

    {"angels-glass-plate", 2, false},
    {"ingot-unobtainium", 4, true}
}

-- TODO gate this behind a startup setting that will also affect wires/solder
-- and other stacks that go against Angel's (who adds coils for these)
-- if not data.raw.item["pellet-coke"] then
table.insert(items, {"coke", 1, false}) -- Bob's without Angel's
table.insert(items, {"solid-coke", 1, false})
-- end

-- Ores, Metals, Ingots
for i = 1,6 do
    table.insert(items, {"angels-ore"..i, 1, true})
    table.insert(items, {"angels-ore"..i.."-crushed", 1, true})
    table.insert(items, {"angels-ore"..i.."-chunk", 2, false})
    table.insert(items, {"angels-ore"..i.."-crystal", 3, false})
    table.insert(items, {"angels-ore"..i.."-pure", 4, false})
end
for i = 8,9 do
    table.insert(items, {"angels-ore"..i, 1, false})
    table.insert(items, {"angels-ore"..i.."-crushed", 1, true})
    table.insert(items, {"angels-ore"..i.."-powder", 2, false})
    table.insert(items, {"angels-ore"..i.."-dust", 3, false})
    table.insert(items, {"angels-ore"..i.."-crystal", 4, false})
end
table.insert(items, {"iron-ore-crushed", 1, true})
table.insert(items, {"copper-ore-crushed", 1, true})
table.insert(items, {"nodule-crushed", 1, true})
table.insert(items, {"stone-crushed", 1, true})


for i = 1,7 do
    table.insert(items, {"clowns-ore"..i, 1, false})
end

for _, i in ipairs({"tin", "lead"}) do
    table.insert(items, {i.."-ore", 1, true})
    table.insert(items, {i.."-plate", 1, false})
    table.insert(items, {"ingot-"..i, 2, true})
end

for _, i in ipairs({"iron", "copper", "steel"}) do
    table.insert(items, {"ingot-"..i, 2, true})
end

for _, i in ipairs({"manganese", "chrome", "platinum"}) do
    table.insert(items, {i.."-ore", 2, true})
    table.insert(items, {i.."-plate", 3, false})
    table.insert(items, {"ingot-"..i, 3, true})
end

for _, i in ipairs({"gold", "silver", "zinc", "nickel"}) do
    table.insert(items, {i.."-ore", 2, true})
    table.insert(items, {i.."-plate", 2, false})
    table.insert(items, {"ingot-"..i, 3, true})
end

for _, i in ipairs({"tungsten"}) do
    table.insert(items, {i.."-ore", 2, true})
    table.insert(items, {i.."-plate", 3, true})
    table.insert(items, {"ingot-"..i, 4, true})
end

-- Gears and bearings
for _, i in ipairs({"steel", "brass", "cobalt-steel", "titanium", "nitinol"}) do
    table.insert(items, {i.."-gear-wheel", 1, true})
    table.insert(items, {i.."-bearing", 2, false})
    table.insert(items, {i.."-bearing-ball", 2, false})
end
table.insert(items, {"tungsten-gear-wheel", 2, true})
table.insert(items, {"ceramic-bearing", 3, false})
table.insert(items, {"ceramic-bearing-ball", 3, false})


-- TODO limit tech levels to 5, not 3, if the stacking integration mod is present.
-- But think about recipe migrations between tech levels first. :/
if deadlock_stacking then
	for _, item in ipairs(items) do
		if data.raw.item[item[1]] then
            -- print(item[1])
            if item[3] then
    			deadlock_stacking.create(item[1], "__deadlock-stacking-crating-bobs__/graphics/"..item[1].."-stack.png", "deadlock-stacking-"..math.min(item[2], 3), 32)
            else
                deadlock_stacking.create(item[1], nil, "deadlock-stacking-"..math.min(item[2], 3), 32)
            end
		end
	end
end 

if deadlock_crating then
	for _, item in ipairs(items) do
		if data.raw.item[item[1]] then
			deadlock_crating.create(item[1], "deadlock-crating-"..math.min(item[2], 3))
		end
	end
end


