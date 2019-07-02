--[[
--libs
local sprites_builder = require("__FluidMustFlow__/linver-lib/sprites-builder")
local pipes_overlay   = require("__FluidMustFlow__/prototypes/scripts/pipes-overlay")

-- -- -- Sprites 
--Initializing sprites

empty_sprite = sprites_builder.getEmptySprite() -- for replace missing graphic

-- Ducts Intermediate Point

sprites_builder.setScale(0.5)
sprites_builder.setPriority("high")	
sprites_builder.setWidth(256)
sprites_builder.setHeight(128)

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_intermediate_point_horizontal.png")
local duct_intermediate_point_north = sprites_builder.buildImage()
local duct_intermediate_point_south = sprites_builder.buildImage() -- is the same perspective

sprites_builder.setWidth(128)
sprites_builder.setHeight(256)

sprites_builder.setFilename("__FluidMustFlow__/graphics/entity/duct/duct_intermediate_point_vertical.png")
local duct_intermediate_point_east = sprites_builder.buildImage()
local duct_intermediate_point_west = sprites_builder.buildImage()

duct_intermediate_point_picture = sprites_builder.getPicture4Parts
(
	duct_intermediate_point_north, 
	duct_intermediate_point_east, 
	duct_intermediate_point_south, 
	duct_intermediate_point_west
)

-- -- -- Entities
--Initializing entities

-- Duct Intermediate Point

--base setting
duct_intermediate_point = util.table.deepcopy(data.raw["storage-tank"]["storage-tank"])
duct_intermediate_point.name = "duct-intermediate-point"
duct_intermediate_point.icon = "__FluidMustFlow__/graphics/icon/duct-intermediate-point.png"
duct_intermediate_point.icon_size = 32
duct_intermediate_point.minable = {mining_time = 0.4, result = "duct-intermediate-point"}
duct_intermediate_point.max_health = 100 * settings.startup["fmf-duct-health-multiplier"].value
duct_intermediate_point.resistances = data.raw["pipe"]["pipe"].resistances
duct_intermediate_point.corpse = "small-remnants"
-- boxes (collision, selection, fluid)
duct_intermediate_point.collision_box = {{-0.9, -0.4}, {0.9, 0.4}}
duct_intermediate_point.selection_box = {{-1.2, -0.6}, {1.2, 0.6}}
duct_intermediate_point.fluid_box =
{
	base_area = settings.startup["fmf-duct-base-level-multiplier"].value,
	base_level = 0,
	pipe_covers = nil,
	pipe_picture = pipes_overlay.getDuctFixedPipePictures(),
	pipe_connections =
	{
		{ position = {0.8, -0.9} },
		{ position = {-0.8, -0.9} },
		{ position = {-0.8, 0.9} },
		{ position = {0.8, 0.9} },
		{ position = {-1.5, 0}, type="output" },
        { position = {1.5, 0}, type="output" }
	}
}
duct_intermediate_point.pumping_speed = 100
duct_intermediate_point.pictures =
{
	picture = duct_intermediate_point_picture,
	gas_flow = empty_sprite,
	fluid_background = empty_sprite,
	window_background = empty_sprite,
	flow_sprite = empty_sprite
}
duct_intermediate_point.circuit_wire_max_distance = 0
duct_intermediate_point.working_sound =
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
duct_intermediate_point.vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }

-- Adding entities
data:extend({duct_intermediate_point})
--]]