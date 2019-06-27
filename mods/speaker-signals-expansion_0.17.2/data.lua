local signals_increment_current = 0;
local subgroup_current = 0;

function signals_increment() 
	signals_increment_current = signals_increment_current + 1
	local prefix =""
	if signals_increment_current < 100 then
		if signals_increment_current < 10 then
			prefix = "00"
		else
			prefix = "0"
		end
	end
	return "b-" .. prefix .. tostring(signals_increment_current)
end
local insert_table={	
	{
		type = "item-group",
		name = "speaker-signals",
		order = "gz",
		icon_size = 64,
		icon = "__core__/graphics/warning-icon.png",
	}	
}

if not data.raw["item-subgroup"]["speaker-signals"] then 
	table.insert(insert_table,{
		type = "item-subgroup",
		name = "speaker-signals",
		group = "speaker-signals",
		order = "d-a-z",
	})
else
	data.raw["item-subgroup"]["speaker-signals"].group = "speaker-signals"
end

--function custom_subgroup()
--	local prefix = ""
--	if math.floor((signals_increment_current)/8) < 100 then
--		if math.floor((signals_increment_current)/8) < 10 then
--			prefix = "00"
--		else
--			prefix = "0"
--		end
--	end
--	if (signals_increment_current)%8==0 then
--
--		table.insert(insert_table,			{
--			type = "item-subgroup",
--			name = "speaker-signals"..prefix..tostring(math.floor((signals_increment_current)/8)),
--			group = "speaker-signals",
--			order = "d-a-z"..prefix..tostring((signals_increment_current)/8),
--		})
--	end
--	return "speaker-signals"..prefix..tostring(math.floor((signals_increment_current)/8))
--end
		table.insert(insert_table,			{
			type = "item-subgroup",
			name = "speaker-signals0",
			group = "speaker-signals",
			order = "d-a-z"..0,
		})
function custom_subgroup()

	if signals_increment_current==999 then
		subgroup_current = subgroup_current +1
		table.insert(insert_table,			{
			type = "item-subgroup",
			name = "speaker-signals"..tostring(subgroup_current),
			group = "speaker-signals",
			order = "d-a-z"..tostring(subgroup_current),
		})
	end
	return "speaker-signals"..tostring(subgroup_current)
end


local signals = {
"biohazard-blue",
"biohazard-green",
"biohazard-yellow",
"biohazard-red",
"biohazard-zredwhite",
--"battery-blue",
--"battery-green",
--"battery-yellow",
--"battery-red",
--"battery-zredwhite",
"brokenbattery-blue",
"brokenbattery-green",
"brokenbattery-yellow",
"brokenbattery-red",
"brokenbattery-zredwhite",
"burning-blue",
"burning-green",
"burning-yellow",
"burning-red",
"burning-zredwhite",
--"explosion-blue",
--"explosion-green",
--"explosion-yellow",
--"explosion-red",
--"explosion-zredwhite",
"explosion2-blue",
"explosion2-green",
"explosion2-yellow",
"explosion2-red",
"explosion2-zredwhite",
"fire-blue",
"fire-green",
"fire-yellow",
"fire-red",
"fire-zredwhite",
"fire2-blue",
"fire2-green",
"fire2-yellow",
"fire2-red",
"fire2-zredwhite",
"gears-blue",
"gears-green",
"gears-yellow",
"gears-red",
"gears-zredwhite",
"heat-blue",
"heat-green",
"heat-yellow",
"heat-red",
"heat-zredwhite",
--"laser-blue",
--"laser-green",
--"laser-yellow",
--"laser-red",
--"laser-zredwhite",
"laser2-blue",
"laser2-green",
"laser2-yellow",
"laser2-red",
"laser2-zredwhite",
"magnet-blue",
"magnet-green",
"magnet-yellow",
"magnet-red",
"magnet-zredwhite",
--"magnet2-blue",
--"magnet2-green",
--"magnet2-yellow",
--"magnet2-red",
--"magnet2-zredwhite",
"nuclear-blue",
"nuclear-green",
"nuclear-yellow",
"nuclear-red",
"nuclear-zredwhite",
"radio-blue",
"radio-green",
"radio-yellow",
"radio-red",
"radio-zredwhite",
--"skull-blue",
--"skull-green",
--"skull-yellow",
--"skull-red",
--"skull-zredwhite",
"skull2-blue",
"skull2-green",
"skull2-yellow",
"skull2-red",
"skull2-zredwhite",
"temperature-blue",
"temperature-green",
"temperature-yellow",
"temperature-red",
"temperature-zredwhite",
"train-blue",
"train-green",
"train-yellow",
"train-red",
"train-zredwhite",
"truck-blue",
"truck-green",
"truck-yellow",
"truck-red",
"truck-zredwhite",
"bomb-blue",
"bomb-green",
"bomb-yellow",
"bomb-red",
"bomb-zredwhite",
"creep-blue",
"creep-green",
"creep-yellow",
"creep-red",
"creep-zredwhite",

"bot-blue",
"bot-green",
"bot-yellow",
"bot-red",
"bot-zredwhite",
"bricks-blue",
"bricks-green",
"bricks-yellow",
"bricks-red",
"bricks-zredwhite",
"brokengear-blue",
"brokengear-green",
"brokengear-yellow",
"brokengear-red",
"brokengear-zredwhite",
--"bug-blue",
--"bug-green",
--"bug-yellow",
--"bug-red",
--"bug-zredwhite",
"drilling-blue",
"drilling-green",
"drilling-yellow",
"drilling-red",
"drilling-zredwhite",
"fuel-blue",
"fuel-green",
"fuel-yellow",
"fuel-red",
"fuel-zredwhite",
"oilrig-blue",
"oilrig-green",
"oilrig-yellow",
"oilrig-red",
"oilrig-zredwhite",
"rocket-blue",
"rocket-green",
"rocket-yellow",
"rocket-red",
"rocket-zredwhite",
"zzz-blue",
"zzz-green",
"zzz-yellow",
"zzz-red",
"zzz-zredwhite",


"bottle-blue",
"bottle-green",
"bottle-yellow",
"bottle-red",
"bottle-purple",
"bottle-black",
"bottle-white", --
"bottle-zredwhite",

"restraint-fire",
"restraint-smoking",
--"restraint-photograph",
"firstaid-blue",
"firstaid-green",
"firstaid-red",
"exit-blue",
"exit-green",
"exit-red",
"gather-blue",
"gather-green",
"gather-red",
"restraint",
"battery-0",
"battery-1",
"battery-2",
"battery-3",
"battery-4",
"battery-5",

"zcrossing-red",
"zcrossing-blue",

"radioactive-special1",
"radioactive-special2",
}


for i, signal in ipairs(signals) do
	table.insert(insert_table,	{
		type = "virtual-signal",
		name = signal,
		icon = "__speaker-signals-expansion__/graphics/"..signal..".png",
		subgroup = custom_subgroup(),
		icon_size = 64,
		order = signals_increment(),
	})
end

data:extend(insert_table)
