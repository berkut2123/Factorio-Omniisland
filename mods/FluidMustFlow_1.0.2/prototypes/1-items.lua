-- paths
local fmf_icons_path = "__FluidMustFlow__/graphics/icon/entities/"

-- -- -- Items

data:extend
({   
    {
        type = "item",
        name = "duct-small",
        icon = fmf_icons_path .. "duct-small.png",
		icon_size = 32,
	    place_result = "duct-small",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-c[pump]a",
        stack_size = 50
    },	
	{
		type = "item",
		name = "duct",
		icon = fmf_icons_path .. "duct.png",
		icon_size = 32,
		place_result = "duct",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-c[pump]a",
		stack_size = 50
	},	
	{
		type = "item",
		name = "duct-long",
		icon = fmf_icons_path .. "duct-long.png",
		icon_size = 32,
		place_result = "duct-long",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-c[pump]a",
		stack_size = 50
	},
	{
        type = "item",
        name = "duct-t-junction",
        icon = fmf_icons_path .. "duct-t-junction.png",
		icon_size = 32,
	    place_result = "duct-t-junction",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-c[pump]a",
        stack_size = 50
    },	
	{
        type = "item",
        name = "duct-curve",
        icon = fmf_icons_path .. "duct-curve.png",
		icon_size = 32,
	    place_result = "duct-curve",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-c[pump]a",
        stack_size = 50
    },	
	{
        type = "item",
        name = "duct-cross",
        icon = fmf_icons_path .. "duct-cross.png",
		icon_size = 32,
	    place_result = "duct-cross",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-c[pump]a",
        stack_size = 50
    },
	{
        type = "item",
        name = "duct-underground",
        icon = fmf_icons_path .. "duct-to-ground.png",
		icon_size = 32,
	    place_result = "duct-underground",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-c[pump]a",
        stack_size = 50
    },	 
	--[[
	{ 
        type = "item",
        name = "duct-intermediate-point",
        icon = "__FluidMustFlow__/graphics/icon/duct-intermediate-point.png",
		icon_size = 32,
	    place_result = "duct-intermediate-point",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-c[pump]a",
        stack_size = 50
    },	
	--]]
	{
        type = "item",
        name = "duct-end-point-intake",
        icon = fmf_icons_path .. "duct-end-point-intake.png",
		icon_size = 32,
	    place_result = "duct-end-point-intake-south",
		subgroup = "energy-pipe-distribution",
		order = "c[pipe]-c[pump]a",
        stack_size = 10
    },
	{
        type = "item",
        name = "duct-end-point-outtake",
        icon = fmf_icons_path .. "duct-end-point-outtake.png",
		icon_size = 32,
	    place_result = "duct-end-point-outtake-south",
		subgroup = "energy-pipe-distribution",
		order = "c[pipe]-c[pump]a",
        stack_size = 10
    }
})
