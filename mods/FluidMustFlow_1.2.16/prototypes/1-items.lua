-- paths
local fmf_icons_path = "__FluidMustFlow__/graphics/icon/entities/"

-- -- -- Items

data:extend
({   
    {
        type = "item",
        name = "duct-small",
        icon = fmf_icons_path .. "duct-small.png",
		icon_size = 64,
	    place_result = "duct-small",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-b[duct]-a[duct-small]a",
        stack_size = 50
    },	
	{
		type = "item",
		name = "duct",
		icon = fmf_icons_path .. "duct.png",
		icon_size = 64,
		place_result = "duct",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-b[duct]-b[duct]a",
		stack_size = 50
	},	
	{
		type = "item",
		name = "duct-long",
		icon = fmf_icons_path .. "duct-long.png",
		icon_size = 64,
		place_result = "duct-long",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-b[duct]-c[duct-long]a",
		stack_size = 50
	},
	{
        type = "item",
        name = "duct-t-junction",
        icon = fmf_icons_path .. "duct-t-junction.png",
		icon_size = 64,
	    place_result = "duct-t-junction",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-b[duct]-e[duct-t-junction]a",
        stack_size = 50
    },	
	{
        type = "item",
        name = "duct-curve",
        icon = fmf_icons_path .. "duct-curve.png",
		icon_size = 64,
	    place_result = "duct-curve",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-b[duct]-f[duct-curve]a",
        stack_size = 50
    },	
	{
        type = "item",
        name = "duct-cross",
        icon = fmf_icons_path .. "duct-cross.png",
		icon_size = 64,
	    place_result = "duct-cross",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-b[duct]-g[duct-cross]a",
        stack_size = 50
    },
	{
        type = "item",
        name = "duct-underground",
        icon = fmf_icons_path .. "duct-to-ground.png",
		icon_size = 64,
	    place_result = "duct-underground",
		subgroup = "energy-pipe-distribution",
		order = "b[pipe]-b[duct]-d[duct-underground]a",
        stack_size = 50
    },
	{
        type = "item",
        name = "non-return-duct",
        icon = fmf_icons_path .. "non-return-duct.png",
		icon_size = 64,
	    place_result = "non-return-duct",
		subgroup = "energy-pipe-distribution",
		order = "c[pipe]-b[pump]-h[non-return-duct]a",
        stack_size = 10
    },	
	{
        type = "item",
        name = "duct-end-point-intake",
        icon = fmf_icons_path .. "duct-end-point-intake.png",
		icon_size = 64,
	    place_result = "duct-end-point-intake",
		subgroup = "energy-pipe-distribution",
		order = "c[pipe]-b[pump]-i[duct-end-point-intake]a",
        stack_size = 10
    },
	{
        type = "item",
        name = "duct-end-point-outtake",
        icon = fmf_icons_path .. "duct-end-point-outtake.png",
		icon_size = 64,
	    place_result = "duct-end-point-outtake",
		subgroup = "energy-pipe-distribution",
		order = "c[pipe]-b[pump]-l[duct-end-point-outtake]a",
        stack_size = 10
    }
})
