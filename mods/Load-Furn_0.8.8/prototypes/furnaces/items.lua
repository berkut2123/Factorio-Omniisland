function add_furnace_item(data)
	local name = data.name
	local subgroup = data.subgroup or "pro-furnace"
	local order = data.order
	local icon = data.icon
	local icons = data.icons
	return {
		type = "item",
		name = name,
		icon = icon,
		icons = icons,
		icon_size = 64,
		order = order,
		subgroup = subgroup,
		place_result = name,
		stack_size = 50
	}
end

local items = 
{
	add_furnace_item
		{
			name = 'furnace-pro-01',
			order = "c[furnace-pro]-d1[01]",
			icon = "__Load-Furn__/graphics/icons/ico_1_64.png",
		},
	add_furnace_item
		{
			name = 'furnace-pro-02',
			order = "c[furnace-pro]-d2[02]",
			icon = "__Load-Furn__/graphics/icons/ico_2_64.png",
		},
	add_furnace_item
		{
			name = 'furnace-pro-03',
			order = "c[furnace-pro]-d3[03]",
			icon = "__Load-Furn__/graphics/icons/ico_3_64.png",
		},
	add_furnace_item
		{
			name = 'furnace-pro-04',
			order = "c[furnace-pro]-d4[04]",
			icon = "__Load-Furn__/graphics/icons/ico_4_64.png",
		},
	add_furnace_item
		{
			name = 'furnace-pro-05',
			order = "c[furnace-pro]-d5[05]",
			icon = "__Load-Furn__/graphics/icons/ico_5_64.png",
		}
}

data:extend(items)

if settings.startup["load-furn-legacy"].value == true then

local steel = table.deepcopy(data.raw['item']['steel-plate'])
steel.name = "steel-plate2"
steel.localised_name = {"recipe-name.steel-plate"}
steel.stack_size = 200


data:extend({steel})


local wood_cool = table.deepcopy(data.raw['item']['coal'])
wood_cool.name = "wood-cool"
wood_cool.localised_name = {"item-name.coal"}

data:extend({wood_cool})

end