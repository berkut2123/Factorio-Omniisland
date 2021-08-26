require("prototypes.belt.animation_set")
function loader_pro(data)
	local name = data.name
	local localised_name = data.localised_name
	local speed = data.speed
	local icon = data.icon
	local next_upgrade = data.next_upgrade
	local order = data.order
	local belt_animation_set = data.belt_animation_set
	return {
		type = "loader-1x1",
		name = name,
		localised_name = localised_name,
		icon = icon,
		icon_size = 32,
		flags = {"placeable-neutral", "player-creation", "fast-replaceable-no-build-while-moving"},
		minable = {mining_time = 0.5, result = name},
		max_health = 300,
		filter_count = 5,
		corpse = "small-remnants",
		resistances =
		{
			{
				type = "fire",
				percent = 90
			}
		},
		collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
		collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile"},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		animation_speed_coefficient = 32,
		container_distance = 1, --Default: 1.5
		belt_distance = 0.5, --Default: 0.5
		belt_length = 0.5, -- Default: 0.5
		belt_animation_set = belt_animation_set,
		next_upgrade = next_upgrade,
		fast_replaceable_group = "loader",
		speed = speed,
		structure =
		{
			direction_in =
			{
				sheets ={
					{
						filename = "__Load-Furn__/graphics/entity/"..name..".png",
						priority = "extra-high",
						width = 128,
						height = 128,
						scale= 0.45,
						shift = util.by_pixel(2, 0),
					},
					{
						filename = "__Load-Furn__/graphics/entity/loader-pro-t.png",
						priority = "extra-high",
						width = 128,
						height = 128,
						scale= 0.45,
						shift = util.by_pixel(2, 0),
						draw_as_shadow = true
					},
				}
			},
			direction_out =
			{
				sheets ={
					{
						filename = "__Load-Furn__/graphics/entity/"..name..".png",
						priority = "extra-high",
						width = 128,
						height = 128,
						y=128,
						scale= 0.45,
						shift = util.by_pixel(2, 0),
					},
					{
						filename = "__Load-Furn__/graphics/entity/loader-pro-t.png",
						priority = "extra-high",
						width = 128,
						height = 128,
						y=128,
						scale= 0.45,
						shift = util.by_pixel(2, 0),
						draw_as_shadow = true
					},
				}
			}
		},

		order = order,
		structure_render_layer = "object",
		--ending_patch = ending_patch_prototype
	}
end

if settings.startup["logist"].value == true then
	local entities = 
	{
		
		loader_pro{
			name = 'loader-pro-001',
			localised_name = {"entity-name.loader"},
			speed = data.raw['transport-belt']['transport-belt'].speed,
			order = "d[loader]-d[loader-pro-01]", 
			icon = "__Load-Furn__/graphics/icons/loader-pro-001.png",
			next_upgrade = "loader-pro-002",
			belt_animation_set = basic_belt_animation_set,
		},
		loader_pro{
			name = 'loader-pro-002',
			localised_name = {"entity-name.fast-loader"},
			speed =	data.raw['transport-belt']['fast-transport-belt'].speed,
			order = "d[loader]-d[loader-pro-02]", 
			icon = "__Load-Furn__/graphics/icons/loader-pro-002.png",
			next_upgrade = "loader-pro-01",
			belt_animation_set = fast_belt_animation_set,
		},
		loader_pro{
			name = 'loader-pro-01',
			localised_name = {"entity-name.express-loader"},
			speed = data.raw['transport-belt']['express-transport-belt'].speed,
			order = "d[loader-pro]-c[loader-pro-01]", 
			icon = "__Load-Furn__/graphics/icons/loader-pro-01.png",
			next_upgrade = "loader-pro-02",
			belt_animation_set = express_belt_animation_set,
		},
		loader_pro{
			name = 'loader-pro-02',
			localised_name = {"",{"entity-name.express-loader"}, " PRO-1"},
			speed = data.raw['transport-belt']['transport-belt'].speed*5,
			order = "d[loader-pro]-d[loader-pro-02]", 
			icon = "__Load-Furn__/graphics/icons/loader-pro-02.png",
			next_upgrade = "loader-pro-03",
			belt_animation_set = transport_belt_pro_animation_set,
		},
		loader_pro{
			name = 'loader-pro-03', 
			localised_name = {"",{"entity-name.express-loader"}, " PRO-2"},
			speed = data.raw['transport-belt']['transport-belt'].speed*7,
			order = "d[loader-pro]-e[loader-pro-03]", 
			icon = "__Load-Furn__/graphics/icons/loader-pro-03.png",
			next_upgrade = nil,
			belt_animation_set = transport_belt_pro2_animation_set,
		},
	}

	data:extend(entities)
end