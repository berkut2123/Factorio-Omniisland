local energy = settings.startup["load-furn-energy"].value
local crafting = settings.startup["load-furn-crafting-speed"].value
function assemblerpictures()
  return
  {
    north =
      {
        filename = "__Load-Furn__/graphics/entity/hr-assembling-machine-3-pipe-N.png",
        priority = "extra-high",
        width = 71,
        height = 38,
        shift = util.by_pixel(2.25, 15),
        scale = 0.5
      },
    east =
      {
        filename = "__Load-Furn__/graphics/entity/hr-assembling-machine-3-pipe-E.png",
        priority = "extra-high",
        width = 42,
        height = 76,
        shift = util.by_pixel(-24.5, 1),
        scale = 0.5
      },
    south =
      {
        filename = "__Load-Furn__/graphics/entity/hr-assembling-machine-3-pipe-S.png",
        priority = "extra-high",
        width = 88,
        height = 61,
        shift = util.by_pixel(0, -30),
        scale = 0.5
      },
    west =
      {
        filename = "__Load-Furn__/graphics/entity/hr-assembling-machine-3-pipe-W.png",
        priority = "extra-high",
        width = 39,
        height = 73,
        shift = util.by_pixel(25.75, 1.25),
        scale = 0.5
      }
  }
end

function add_furnace(data)
local name = data.name
local crafting_speed = data.crafting_speed
local energy_usage = data.energy_usage
local next_upgrade = data.next_upgrade
local module_specification = data.module_specification
local icon = data.icon
local icons = data.icons

if mods["angelssmelting"] and not mods["bobelectronics"] then
	crafting_categories = {"smelting", "AdvFurn", "strand-casting", "induction-smelting", "chemical-smelting", "casting", "blast-smelting", "mixing-furnace", "chemical-furnace"}
elseif mods["angelssmelting"] and mods["bobelectronics"] then
	crafting_categories = {"smelting", "AdvFurn", "strand-casting", "induction-smelting", "chemical-smelting", "casting", "blast-smelting", "mixing-furnace"}
elseif mods["bobelectronics"] and not mods["bobplates"] and not mods["angelssmelting"] then
	crafting_categories = {"smelting", "AdvFurn", "mixing-furnace"}
elseif mods["bobplates"] and not mods["angelssmelting"] then
	crafting_categories = {"smelting", "AdvFurn", "mixing-furnace", "chemical-furnace"}
else
	crafting_categories = {"smelting", "AdvFurn", "mixing-furnace", "chemical-furnace"}
end

return {
		type = "assembling-machine",
		name = name,
		icon = icon,
		icons = icons,
		icon_size = 64,
		flags = {"placeable-neutral","placeable-player", "player-creation"},
		minable = {mining_time = 1, result = name},
		max_health = 500,
		base_productivity = 0,
		corpse = "big-remnants",
		dying_explosion = "medium-explosion",
		resistances = {
			{type = "fire", percent = 100},
			{type = "acid", percent = 100}
		},
		collision_box = {{-2.5, -2.5}, {2.5, 2.5}},
		selection_box = {{-2.9, -2.7}, {2.9, 2.7}},
		module_specification = module_specification,
		allowed_effects = {"consumption", "speed", "productivity", "pollution"},
		crafting_categories = crafting_categories,
		fast_replaceable_group = "furnace",
		ingredient_count = 4,
		result_count = 2,
		crafting_speed = crafting_speed,
		next_upgrade = next_upgrade,
		energy_usage = energy_usage,
		fluid_boxes = {
			{
				production_type = "input",
				--pipe_picture = assemblerpictures(),
				--pipe_covers = pipecoverspictures(),
				base_area = 10,
				base_level = -1,
				pipe_connections = {{ type="input", position = {-1, -3} }}
			},
			{
				production_type = "input",
				--pipe_picture = assemblerpictures(),
				--pipe_covers = pipecoverspictures(),
				base_area = 10,
				base_level = -1,
				pipe_connections = {{ type="input", position = {3, -1} }}
			},
			{
				production_type = "input",
				--pipe_picture = assemblerpictures(),
				--pipe_covers = pipecoverspictures(),
				base_area = 10,
				base_level = -1,
				pipe_connections = {{ type="input", position = {1, -3} }}
			},
			{
				production_type = "output",
				--pipe_picture = assemblerpictures(),
				--pipe_covers = pipecoverspictures(),
				base_level = 1,
				pipe_connections = {{ position = {-1, 3} }}
			},
			{
				production_type = "output",
				--pipe_picture = assemblerpictures(),
				--pipe_covers = pipecoverspictures(),
				base_level = 1,
				pipe_connections = {{ position = {1, 3} }}
			},
			off_when_no_fluid_recipe = true
		},
		energy_source =
		{
			type = "electric",
			usage_priority = "secondary-input",
			emissions = 0.005
		},
		vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
		working_sound = {
			sound = {filename = "__base__/sound/electric-furnace.ogg", volume = 0.7},
			apparent_volume = 1.5
		},

		animation = {
				layers =
				{
					{
						filename = "__Load-Furn__/graphics/entity/"..name..".png",
						priority = "high",
						width = 230,
						height = 230,
						frame_count = 1,
						scale = 0.9,
						shift = util.by_pixel(0,0),
					},
					{
						filename = "__Load-Furn__/graphics/entity/lab_shadow.png",
						priority = "high",
						width = 293,
						height = 230,
						frame_count = 1,
						scale = 0.9,
						shift = util.by_pixel(30,0),
						draw_as_shadow = true
					},
					{
						filename = "__Load-Furn__/graphics/entity/lab_albedo_ao.png",
						priority = "high",
						width = 230,
						height = 230,
						frame_count = 1,
						scale = 0.9,
						shift = util.by_pixel(0,-14),
					}
				}
		},
		working_visualisations = {
			{
				animation = {
					filename = "__Load-Furn__/graphics/entity/gr/1.png",
					priority = "high",
					width = 130,
					height = 130,
					frame_count = 10,
					scale =  1.56,
					blend_mode = "additive-soft",
					shift = util.by_pixel(0,0),
					animation_speed = 0.01,

				}
			},
			{
				animation = {
					filename = "__Load-Furn__/graphics/entity/gr/"..name..".png",
					priority = "high",
					width = 230,
					height = 230,
					frame_count = 1,
					scale = 0.9,
					blend_mode = "additive-soft",
					shift = util.by_pixel(0,0),
					animation_speed = 0.3,
				},
				light = {intensity = 0.4, size = 6, shift = {1.9, 2}, color = {r = 255, g = 69, b = 0}}
			},
			{
				light = {intensity = 0.4, size = 6, shift = {-1.9, 2}, color = {r = 255, g = 69, b = 0}}
			},
			{
				light = {intensity = 0.4, size = 7, shift = {0, -1}, color = {r = 255, g = 69, b = 0}}
			}
		}
	}
end

local entities = 
{
	add_furnace{
		name = "furnace-pro-01",
		crafting_speed = 48/crafting,
		energy_usage = energy * 4320 .. "kW",
		module_specification = {module_slots = 2, module_info_icon_shift = {0, 0.8}},
		icon = "__Load-Furn__/graphics/icons/ico_1_64.png",
		next_upgrade = "furnace-pro-02",
	},
	add_furnace{
		name = "furnace-pro-02",
		crafting_speed = 96/crafting,
		energy_usage = energy * 8640 .. "kW",
		module_specification = {module_slots = 3, module_info_icon_shift = {0, 0.8}},
		icon = "__Load-Furn__/graphics/icons/ico_2_64.png",
		next_upgrade = "furnace-pro-03"
	},
	add_furnace{
		name = "furnace-pro-03", 
		crafting_speed = 192/crafting,
		energy_usage = energy * 17280 .. "kW",
		module_specification = {module_slots = 4, module_info_icon_shift = {0, 0.8}},
		icon = "__Load-Furn__/graphics/icons/ico_3_64.png",
		next_upgrade = "furnace-pro-04"
	},
add_furnace{
		name = "furnace-pro-04",
		crafting_speed = 384/crafting,
		energy_usage = energy * 34560 .. "kW",
		module_specification = {module_slots = 5, module_info_icon_shift = {0, 0.8}},
		icon = "__Load-Furn__/graphics/icons/ico_4_64.png",
		next_upgrade = "furnace-pro-05"
	},
add_furnace{
		name = "furnace-pro-05",
		crafting_speed = 768/crafting,
		energy_usage = energy * 69120 .. "kW",
		module_specification = {module_slots = 6, module_info_icon_shift = {0, 0.8}},
		icon = "__Load-Furn__/graphics/icons/ico_5_64.png",
		next_upgrade = nil
	} 
}
data:extend(entities)
data.raw["assembling-machine"]["furnace-pro-01"].working_visualisations[1].animation.animation_speed = 0.03
data.raw["assembling-machine"]["furnace-pro-02"].working_visualisations[1].animation.animation_speed = 0.02
data.raw["assembling-machine"]["furnace-pro-05"].working_visualisations[1].animation.animation_speed = 0.005