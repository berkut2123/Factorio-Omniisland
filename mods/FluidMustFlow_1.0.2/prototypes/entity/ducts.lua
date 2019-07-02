-- paths
local fmf_icons_path = "__FluidMustFlow__/graphics/icon/entities/"

--libs
local sprites_builder = require("__FluidMustFlow__/linver-lib/sprites-builder")
local pipes_overlay   = require("__FluidMustFlow__/prototypes/scripts/pipes-overlay")

-- -- -- Sprites 
--Initializing sprites

empty_sprite = sprites_builder.getEmptySprite() -- for replace missing graphic

-- Small Ducts picture

sprites_builder.setScale(0.5)
sprites_builder.setPriority("high")	
sprites_builder.setWidth(128)
sprites_builder.setHeight(256)

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_small_straight_horizontal.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_small_straight_horizontal_shadow.png")
sprites_builder.setShadowShift({0.5, 0})
local duct_small_east = sprites_builder.buildImage()
local duct_small_west = sprites_builder.buildImage() -- is the same perspective
sprites_builder.setShadowShift(nil)

sprites_builder.setWidth(256)
sprites_builder.setHeight(160)

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_small_straight_vertical.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_small_straight_vertical_shadow.png")
local duct_small_north = sprites_builder.buildImage()
local duct_small_south = sprites_builder.buildImage()


duct_small_picture = sprites_builder.getPicture4Parts(duct_small_north, duct_small_east, duct_small_south, duct_small_west)

-- Long Duct picture

sprites_builder.setHeight(360)

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_long_horizontal.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_long_horizontal_shadow.png")
local duct_long_north = sprites_builder.buildImage()
local duct_long_south = sprites_builder.buildImage() -- is the same perspective

sprites_builder.setWidth(512)
sprites_builder.setHeight(256)

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_long_vertical.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_long_vertical_shadow.png")
local duct_long_east = sprites_builder.buildImage()
local duct_long_west = sprites_builder.buildImage() -- is the same perspective

duct_long_picture = sprites_builder.getPicture4Parts(duct_long_north, duct_long_east, duct_long_south, duct_long_west)

-- Duct picture

sprites_builder.setWidth(256)

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_horizontal.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_horizontal_shadow.png")
local duct_north = sprites_builder.buildImage()
local duct_south = sprites_builder.buildImage() -- is the same perspective

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_vertical.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_vertical_shadow.png")
local duct_east = sprites_builder.buildImage()
local duct_west = sprites_builder.buildImage() -- is the same perspective

duct_picture = sprites_builder.getPicture4Parts(duct_north, duct_east, duct_south, duct_west)

-- Duct_T_junction picture

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_T_up.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_T_up_shadow.png")
local duct_t_junction_north = sprites_builder.buildImage()

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_T_right.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_T_right_shadow.png")
local duct_t_junction_east = sprites_builder.buildImage()

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_T_down.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_T_down_shadow.png")
local duct_t_junction_south = sprites_builder.buildImage()

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_T_left.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_T_left_shadow.png")
local duct_t_junction_west = sprites_builder.buildImage()

duct_t_junction_picture = sprites_builder.getPicture4Parts(duct_t_junction_north, duct_t_junction_east, duct_t_junction_south, duct_t_junction_west)

-- Curved Duct

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_corner_up_left.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_corner_up_left_shadow.png")
local duct_curve_north = sprites_builder.buildImage()

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_corner_up_right.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_corner_up_right_shadow.png")
local duct_curve_east = sprites_builder.buildImage()

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_corner_down_right.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_corner_down_right_shadow.png")
local duct_curve_south = sprites_builder.buildImage()

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_corner_down_left.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_corner_down_left_shadow.png")
local duct_curve_west = sprites_builder.buildImage()

duct_curve_picture = sprites_builder.getPicture4Parts(duct_curve_north, duct_curve_east, duct_curve_south, duct_curve_west)
	
-- Cross Duct

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_cross.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct_cross_shadow.png")
local duct_cross_all = sprites_builder.buildImage()

duct_cross_picture = sprites_builder.getPicture4Parts(duct_cross_all, duct_cross_all, duct_cross_all, duct_cross_all)

-- Underground duct

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct-ground-up.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct-ground-up_shadow.png")
local duct_underground_north = sprites_builder.buildImage()

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct-ground-left.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct-ground-left_shadow.png")
local duct_underground_east = sprites_builder.buildImage()

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct-ground-down.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct-ground-down_shadow.png")
local duct_underground_south = sprites_builder.buildImage()

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct-ground-right.png")
sprites_builder.setShadow("__FluidMustFlow__/graphics/entity/duct/duct-ground-right_shadow.png")
local duct_underground_west = sprites_builder.buildImage()

duct_underground_picture = 
{
	up = duct_underground_north, 	 
	left = duct_underground_east, 
	down = duct_underground_south,
	right = duct_underground_west
}
	
-- -- -- Entities
--Initializing entities

-- Duct Small

--base setting
duct_small = util.table.deepcopy(data.raw["storage-tank"]["storage-tank"])
duct_small.name = "duct-small"
duct_small.fast_replaceable_group = "ducts"
duct_small.icon = fmf_icons_path .. "duct-small.png"
duct_small.icon_size = 32
duct_small.minable = {mining_time = 0.4, result = "duct-small"}
duct_small.max_health = 100 * settings.startup["fmf-duct-health-multiplier"].value
duct_small.resistances = data.raw["pipe"]["pipe"].resistances
duct_small.corpse = "small-remnants"
-- boxes (collision, selection, fluid)
duct_small.collision_box = {{-0.7, -0.4}, {0.7, 0.4}}
duct_small.selection_box = {{-1.2, -0.6}, {1.2, 0.6}}
duct_small.fluid_box =
{
	base_area = settings.startup["fmf-duct-base-level-multiplier"].value,
	base_level = 0,
	pipe_covers = nil,
	pipe_connections =
	{
		{ position = {0.6, -0.9} },
		{ position = {-0.6, -0.9} },
		{ position = {-0.6, 0.9} },
		{ position = {0.6, 0.9} }
	}
}
duct_small.pictures =
{
	picture = duct_small_picture,
	gas_flow = empty_sprite,
	fluid_background = empty_sprite,
	window_background = empty_sprite,
	flow_sprite = empty_sprite
}
duct_small.circuit_wire_max_distance = 0
duct_small.working_sound =
{
	sound = 
	{
		{
			filename = "__base__/sound/pipe.ogg",
			volume = 1
		}
	},
	match_volume_to_activity = true,
	max_sounds_per_type = 3
}
duct_small.vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }

-- Duct

--base setting
duct = util.table.deepcopy(data.raw["storage-tank"]["storage-tank"])
duct.name = "duct"
duct.fast_replaceable_group = "ducts"
duct.icon = fmf_icons_path .. "duct.png"
duct.icon_size = 32
if settings.startup["fmf-enable-duct-auto-join"].value then
	duct.minable = {mining_time = 0.6, result = "duct-small", count = 2}
else
	duct.minable = {mining_time = 0.6, result = "duct", count = 1}
end
duct.max_health = 200 * settings.startup["fmf-duct-health-multiplier"].value
duct.resistances = data.raw["pipe"]["pipe"].resistances
duct.corpse = "small-remnants"
--duct.fast_replaceable_group = No
-- boxes (collision, selection, fluid)
duct.collision_box = {{-0.7, -0.9}, {0.7, 0.9}}
duct.selection_box = {{-1.1, -1.1}, {1.1, 1.1}}
duct.fluid_box =
{
	base_area = 2*settings.startup["fmf-duct-base-level-multiplier"].value,
	base_level = 0,
	pipe_covers = nil, -- for debug: pipecoverspictures()
	pipe_connections =
	{
		{ position = {0.5, -1.5} },
		{ position = {-0.5, -1.5} },
		{ position = {0.5, 1.5} },
		{ position = {-0.5, 1.5} }
	}
}
duct.pictures =
{
	picture = duct_picture,
	gas_flow = empty_sprite,
	fluid_background = empty_sprite,
	window_background = empty_sprite,
	flow_sprite = empty_sprite
}
duct.circuit_wire_max_distance = 0
duct.working_sound =
{
	sound = 
	{
		{
			filename = "__base__/sound/pipe.ogg",
			volume = 1
		}
	},
	match_volume_to_activity = true,
	max_sounds_per_type = 3
}
duct.vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }

-- Duct Long

duct_long = util.table.deepcopy(duct)
duct_long.name = "duct-long"
duct_long.fast_replaceable_group = "ducts"
duct_long.icon = fmf_icons_path .. "duct-long.png"
if settings.startup["fmf-enable-duct-auto-join"].value then
	duct_long.minable = {mining_time = 0.8, result = "duct-small", count = 4}
else
	duct_long.minable = {mining_time = 0.8, result = "duct-long", count = 1}
end
duct_long.max_health = 400 * settings.startup["fmf-duct-health-multiplier"].value
duct_long.collision_box = {{-0.7, -1.8}, {0.7, 1.8}}
duct_long.selection_box = {{-1.1, -2.2}, {1.1, 2.2}}
duct_long.fluid_box =
{
	base_area = 4*settings.startup["fmf-duct-base-level-multiplier"].value,
	base_level = 0,
	pipe_covers = nil, -- for debug pipecoverspictures()
	pipe_connections =
	{
		{ position = {0.5, -2.5} },
		{ position = {-0.5, -2.5} },
		{ position = {0.5, 2.5} },
		{ position = {-0.5, 2.5} }
	}
}
duct_long.pictures =
{
	picture = duct_long_picture,
	gas_flow = empty_sprite,
	fluid_background = empty_sprite,
	window_background = empty_sprite,
	flow_sprite = empty_sprite
}

-- Duct T junction

duct_t_junction = util.table.deepcopy(duct)
duct_t_junction.name = "duct-t-junction"
duct_t_junction.fast_replaceable_group = "ducts"
duct_t_junction.icon = fmf_icons_path .. "duct-t-junction.png"
duct_t_junction.minable = {mining_time = 0.4, result = "duct-t-junction"}
duct_t_junction.two_direction_only = false
duct_t_junction.collision_box = {{-0.7, -0.9}, {0.7, 0.7}}
duct_t_junction.fluid_box.pipe_connections =
{
	{ position = {0.5, -1.5} },
	{ position = {-0.5, -1.5} },
	{ position = {1.5, -0.5} },
	{ position = {1.5, 0.5} },
	{ position = {-1.5, -0.5} },
	{ position = {-1.5, 0.5} }
}
duct_t_junction.pictures =
{
	picture = duct_t_junction_picture,
	gas_flow = empty_sprite,
	fluid_background = empty_sprite,
	window_background = empty_sprite,
	flow_sprite = empty_sprite
}

-- Curved duct

duct_curve = util.table.deepcopy(duct_t_junction)
duct_curve.name = "duct-curve"
duct_curve.fast_replaceable_group = "ducts"
duct_curve.icon = fmf_icons_path .. "duct-curve.png"
duct_curve.minable.result = "duct-curve"
duct_curve.collision_box = {{-0.78, -0.78}, {0.85, 0.85}}
duct_curve.fluid_box.pipe_connections =
{
	{ position = {0.5, -1.5} },
	{ position = {-0.5, -1.5} },
	{ position = {-1.5, -0.5} },
	{ position = {-1.5, 0.5} }
}
duct_curve.pictures =
{
	picture = duct_curve_picture,
	gas_flow = empty_sprite,
	fluid_background = empty_sprite,
	window_background = empty_sprite,
	flow_sprite = empty_sprite
}

-- Cross duct

duct_cross = util.table.deepcopy(duct_t_junction)
duct_cross.name = "duct-cross"
duct_cross.fast_replaceable_group = "ducts"
duct_cross.icon = fmf_icons_path .. "duct-cross.png"
duct_cross.minable.result = "duct-cross"
duct_cross.collision_box = {{-0.85, -0.85}, {0.85, 0.85}}
duct_cross.fluid_box.pipe_connections =
{
		{ position = {0.5, -1.5} },
		{ position = {-0.5, -1.5} },
		{ position = {0.5, 1.5} },
		{ position = {-0.5, 1.5} },
		{ position = {1.5, -0.5} },
		{ position = {1.5, 0.5} },
		{ position = {-1.5, -0.5} },
		{ position = {-1.5, 0.5} }
}
duct_cross.pictures =
{
	picture = duct_cross_picture,
	gas_flow = empty_sprite,
	fluid_background = empty_sprite,
	window_background = empty_sprite,
	flow_sprite = empty_sprite
}

-- Underground duct

duct_underground =
{
	type = "pipe-to-ground",
	name = "duct-underground",
	fast_replaceable_group = "ducts",
	icon = fmf_icons_path .. "duct-to-ground.png",
	icon_size = 32,
	flags = {"placeable-neutral", "player-creation"},
	minable = {mining_time = 0.4, result = "duct-underground"},
	max_health = 200 * settings.startup["fmf-duct-health-multiplier"].value,
	corpse = "small-remnants",
	resistances = data.raw["pipe"]["pipe"].resistances,
	collision_box = {{-0.9, -0.7}, {0.9, 0.7}},
	selection_box = {{-1.1, -1.1}, {1.1, 1.1}},
	two_direction_only = false,
	fluid_box =
	{
		base_area = 2*settings.startup["fmf-duct-base-level-multiplier"].value,
		base_level = 0,
		pipe_covers = nil,
		pipe_connections =
		{
			{ position = {0.5, -1.5} },
			{
				position = {0.5, 1.5},
				max_underground_distance = settings.startup["fmf-underground-duct-max-length"].value
			},
			{ position = {-0.5, -1.5} },
			{
				position = {-0.5, 1.5},
				max_underground_distance = settings.startup["fmf-underground-duct-max-length"].value
			}
		}
	},
	underground_sprite =
	{
		filename = "__core__/graphics/arrows/underground-lines.png",
		priority = "high",
		width = 64,
		height = 64,
		scale = 0.5,
	},
	pictures = duct_underground_picture
}

-- Adding entities
data:extend({duct_small, duct, duct_long, duct_t_junction, duct_curve, duct_cross, duct_underground})

-- OLD CODE
--[[
sprites_builder.setWidth(128)
sprites_builder.setHeight(256)
duct.collision_box = {{-0.9, -0.4}, {0.9, 0.4}}
duct.selection_box = {{-1.1, -0.6}, {1.1, 0.6}}
		{ position = {0.6, -0.9} },
		{ position = {-0.6, -0.9} },
		{ position = {-0.6, 0.9} },
		{ position = {0.6, 0.9} }
--]]