local ssm = {}
ssm.colors = {	{"red",		false},
				{"yellow",	false},
				{"green",	false},
				{"blue",	false},
				{"purple",	false},
				{"black",	true},
				{"gray",	false},
				{"white",	false},
				{"none",	false},
				{"none",	true}
}
ssm.icons = {	{"danger", "Danger"},
				{"energy", "Energy"},
				{"unplugged", "Unplugged"},
				{"destroyed", "Destroyed"},
				{"fluid", "Fluid"},
				{"fuel", "Fuel"},
				{"no-storage-space", "No storage space"},
				{"no-building-material", "No building material"},
				{"not-enough-construction-robots", "Not enough construction robots"},
				{"not-enough-repair-packs", "Not enough repair packs"},
				{"robot-material", "Robot material"},
				{"recharge", "Recharge"},
				{"too-far-from-roboport", "Too far from roboport"},
				{"module", "Module"},
				{"ammo", "Ammo"},
				{"gun", "Gun"},
				{"armor", "Armor"},
				{"misaligned", "Misaligned"},
				{"train", "Train"},
				{"plus", "Plus"},
				{"marker", "Marker"},
}

local a = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}


for i,y in ipairs(ssm.icons) do
	data:extend({{
		type = "item-subgroup",
		name = "speaker-signals-2-" .. y[1],
		group = "signals",
		order = "z-z-z-"..a[i],
	}})
	for j,v in ipairs(ssm.colors) do
		if v[2] == true then
			data:extend({{
				type = "virtual-signal",
				name = "speaker-signals-2-" .. y[1] .. "-".. v[1],
				icons = {	{icon = "__speaker-signals-2__/backgrounds/" .. v[1] .. ".png", scale = 1},
							{icon = "__speaker-signals-2__/icons/" .. y[1] .. "n.png", scale = 1}},
				subgroup = "speaker-signals-2-" .. y[1],
				localised_name = y[2],
				icon_size = 64,
				order = a[j]
			}})
		else
			data:extend({{
				type = "virtual-signal",
				name = "speaker-signals-2-" .. y[1] .. "-".. v[1],
				icons = {	{icon = "__speaker-signals-2__/backgrounds/" .. v[1] .. ".png", scale = 1},
							{icon = "__speaker-signals-2__/icons/" .. y[1] .. ".png", scale = 1}},
				subgroup = "speaker-signals-2-" .. y[1],
				localised_name = y[2],
				icon_size = 64,
				order = a[j]
			}})
			if v[1] == "none" then
				data.raw["virtual-signal"]["speaker-signals-2-" .. y[1] .. "-".. v[1]].name = "speaker-signals-2-" .. y[1] .. "-".. v[1] .. "_"
				data.raw["virtual-signal"]["speaker-signals-2-" .. y[1] .. "-".. v[1] .. "_"] = data.raw["virtual-signal"]["speaker-signals-2-" .. y[1] .. "-".. v[1]]
			end
		end
	end
end
