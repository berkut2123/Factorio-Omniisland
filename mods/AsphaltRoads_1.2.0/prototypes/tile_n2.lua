local config = require "config"
local tile_transitions = require("util/tile-transitions")

local path = "__AsphaltRoads__/graphics/terrain/"
local type1_tilesets = {"asphalt-zebra-crossing"}
local type2_tilesets = {"asphalt-triangle-white"}
local type3a_tilesets = {"asphalt-hazard-white"}
local type3b_tilesets = {"asphalt-hazard-yellow", "asphalt-hazard-red", "asphalt-hazard-blue", "asphalt-hazard-green"}
local type4a_tileset = {"marking-white"}
local type4b_tileset = {"marking-white-dl"}
local type5a_tileset = {"marking-yellow"}
local type5b_tileset = {"marking-yellow-dl"}
local mining_sound = "__base__/sound/deconstruct-bricks.ogg"
local mining_result = "Arci-asphalt"
local mapcolours = {{"white", config.asphalt_colour_marking_white}, {"yellow", config.asphalt_colour_marking_yellow}, {"blue", config.asphalt_colour_marking_blue}, {"red", config.asphalt_colour_marking_red}, {"green", config.asphalt_colour_marking_green}}
local walking_sounds = {
    {
        filename = "__base__/sound/walking/concrete-01.ogg",
        volume = 1.2
    },
    {
        filename = "__base__/sound/walking/concrete-02.ogg",
        volume = 1.2
    },
    {
        filename = "__base__/sound/walking/concrete-03.ogg",
        volume = 1.2
    },
    {
        filename = "__base__/sound/walking/concrete-04.ogg",
        volume = 1.2
}}

local func = {}
local gOrderIndex = {}
function func.default_value(suffix)
	local cnt = 0
    if suffix == "o" then cnt = 1 else cnt = 8 end   
    return {picture = path.."asphalt/asphalt-"..suffix..".png", count = cnt}
end

function func.diagonal_value(tileset, dir)
    local cnt = 8   
    return {picture = path..tileset.."/"..tileset..dir.."-inner-corner.png", count = cnt}
end

function func.setMainVariant(levels, cnt, path)
    local temp = {}
    for i=1, levels do
        local s = math.floor(2^(i-1))
        table.insert(temp, {
                        picture = path.."-"..s..".png",
                        count = cnt[i],
                        size = s,
                    })
        if i == 2 then
            temp[i]["probability"] = 0.3
        elseif i == 3 then
            temp[i]["probability"] = 0.8
        end
    end
    return temp
end

function func.assignMapColour(tileset)
    local colours = mapcolours
    for i=1, #colours do
        if string.find(tileset, colours[i][1]) ~= nil then
            return colours[i][2]
        end
    end
    return config.asphalt_colour_marking_white
end

function func.assignOrderPosition(subgrp)
    if gOrderIndex[subgrp] == nil then
        gOrderIndex[subgrp] = 1
    else 
        gOrderIndex[subgrp] = gOrderIndex[subgrp] + 1
    end
    return string.char(gOrderIndex[subgrp] + 96) -- get the ASCII character from numeric index (e.g. 97 = "a") 
end

function func.createTileSetB(tileset, numDirections, dirNames, mainVariants, mainVariantsCnt, diagonalTile)
    local thispath = path..tileset.."/"
    
    -- part 1: tile definition
    for k=1, numDirections do
        local thisdir = dirNames[k]
        local nextdir = dirNames[k+1-math.floor(k/numDirections)*k]
        local ic = {} -- inner-corner parameter
        local tilelayer = config.asphalt_base_layer
        if diagonalTile ~= nil and diagonalTile == true then 
            ic = func.diagonal_value(tileset, thisdir) 
            tilelayer = config.asphalt_priority_layer
        else 
            ic = func.default_value("inner-corner") 
        end
        data:extend({{            
            type = "tile",
            name = "Arci-"..tileset..thisdir,
            next_direction = "Arci-"..tileset..nextdir,
            needs_correction = false,
            transition_merges_with_tile = "Arci-asphalt",
            minable = {mining_time = config.asphalt_mining_speed, result = mining_result},
            mined_sound = { filename = mining_sound },
            collision_mask = {"ground-tile"},
            walking_speed_modifier = config.asphalt_walking_speed_modifier,
            layer = tilelayer,
            shift_layer_if_asphald_roads_is_present = false,
            decorative_removal_probability = 0.97,
            variants =
            {
                main = func.setMainVariant(mainVariants, mainVariantsCnt, thispath..tileset..thisdir),
                inner_corner = ic,
                outer_corner = func.default_value("outer-corner"),
                side = func.default_value("side"),
                u_transition = func.default_value("u"),
                o_transition = func.default_value("o"),
            },
            walking_sound = walking_sounds,
            map_color = func.assignMapColour(tileset),
            pollution_absorption_per_second = 0,
            vehicle_friction_modifier = config.asphalt_vehicle_speed_modifier,
            transitions = tile_transitions.asphalt_transitions(),
            transitions_between_transitions = tile_transitions.asphalt_transitions_between_transitions()
        }})
    end
end

function func.createIRTentries(tileset, defaultDir, subgrp)
    data:extend({
    -- part 1: recipe definition
    {
        type = "recipe",
        name = "Arci-"..tileset,
        energy_required = 0.25,
        enabled = false,
        category = "crafting",
        ingredients =
        {
            {"Arci-asphalt", 10}
        },
        result= "Arci-"..tileset,
        result_count = 10
    },
    -- part 2: item definition
    {
        type = "item",
        name = "Arci-"..tileset,
        icon = "__AsphaltRoads__/graphics/icons/"..tileset..".png",
        icon_size = 32,
        flags = {},
        subgroup = subgrp,
        order = func.assignOrderPosition(subgrp),
        stack_size = config.asphalt_stack_size,
        place_as_tile =
        {
            result = "Arci-"..tileset..defaultDir,
            condition_size = 1,
            condition = { "water-tile" }
        }
    }	         
    })
    -- part 3: tech entry
    table.insert(data.raw["technology"]["Arci-asphalt"].effects, {type = "unlock-recipe", recipe = "Arci-"..tileset})
end

if config.enable_basic_tiles then
	for i=1, #type1_tilesets do
		func.createTileSetB(type1_tilesets[i], 2, {"-horizontal","-vertical"}, 3, {16, 4, 4})
		func.createIRTentries(type1_tilesets[i], "-vertical", "Arci-asphalt-1")
	end
	for i=1, #type2_tilesets do
		func.createTileSetB(type2_tilesets[i], 4, {"-up","-right","-down","-left"}, 1, {8})
		func.createIRTentries(type2_tilesets[i], "-up", "Arci-asphalt-1")
	end
	for i=1, #type3a_tilesets do
		func.createTileSetB(type3a_tilesets[i], 2, {"-right","-left"}, 3, {16, 4, 4})
		func.createIRTentries(type3a_tilesets[i], "-left", "Arci-asphalt-1")
	end
end
if config.enable_cl_hazard_marking then
	for i=1, #type3b_tilesets do
		func.createTileSetB(type3b_tilesets[i], 2, {"-right","-left"}, 3, {16, 4, 4})
		func.createIRTentries(type3b_tilesets[i], "-left", "Arci-asphalt-1")
	end
end
if config.enable_w_single_line_marking then
	for i=1, #type4a_tileset do
		func.createTileSetB(type4a_tileset[i], 2, {"-straight-horizontal","-straight-vertical"}, 1, {16})
		func.createIRTentries(type4a_tileset[i].."-straight", "-vertical", "Arci-asphalt-2")
		func.createTileSetB(type4a_tileset[i], 2, {"-diagonal-left","-diagonal-right"}, 1, {16}, true)
		func.createIRTentries(type4a_tileset[i].."-diagonal", "-right", "Arci-asphalt-2")    
		func.createTileSetB(type4a_tileset[i], 4, {"-right-turn-up","-right-turn-right","-right-turn-down","-right-turn-left"}, 1, {16})
		func.createIRTentries(type4a_tileset[i].."-right-turn", "-up", "Arci-asphalt-2")
		func.createTileSetB(type4a_tileset[i], 4, {"-left-turn-up","-left-turn-right","-left-turn-down","-left-turn-left"}, 1, {16})
		func.createIRTentries(type4a_tileset[i].."-left-turn", "-up", "Arci-asphalt-2")
	end
end
if config.enable_w_double_line_marking then
	for i=1, #type4b_tileset do
		func.createTileSetB(type4b_tileset[i], 2, {"-straight-horizontal","-straight-vertical"}, 1, {16})
		func.createIRTentries(type4b_tileset[i].."-straight", "-vertical", "Arci-asphalt-2")
		func.createTileSetB(type4b_tileset[i], 2, {"-diagonal-left","-diagonal-right"}, 1, {16}, true)
		func.createIRTentries(type4b_tileset[i].."-diagonal", "-right", "Arci-asphalt-2")    
		func.createTileSetB(type4b_tileset[i], 4, {"-right-turn-up","-right-turn-right","-right-turn-down","-right-turn-left"}, 1, {16})
		func.createIRTentries(type4b_tileset[i].."-right-turn", "-up", "Arci-asphalt-2")
		func.createTileSetB(type4b_tileset[i], 4, {"-left-turn-up","-left-turn-right","-left-turn-down","-left-turn-left"}, 1, {16})
		func.createIRTentries(type4b_tileset[i].."-left-turn", "-up", "Arci-asphalt-2")
	end
end
if config.enable_y_single_line_marking then
	for i=1, #type5a_tileset do
		func.createTileSetB(type5a_tileset[i], 2, {"-straight-horizontal","-straight-vertical"}, 1, {16})
		func.createIRTentries(type5a_tileset[i].."-straight", "-vertical", "Arci-asphalt-3")
		func.createTileSetB(type5a_tileset[i], 2, {"-diagonal-left","-diagonal-right"}, 1, {16}, true)
		func.createIRTentries(type5a_tileset[i].."-diagonal", "-right", "Arci-asphalt-3")    
		func.createTileSetB(type5a_tileset[i], 4, {"-right-turn-up","-right-turn-right","-right-turn-down","-right-turn-left"}, 1, {16})
		func.createIRTentries(type5a_tileset[i].."-right-turn", "-up", "Arci-asphalt-3")
		func.createTileSetB(type5a_tileset[i], 4, {"-left-turn-up","-left-turn-right","-left-turn-down","-left-turn-left"}, 1, {16})
		func.createIRTentries(type5a_tileset[i].."-left-turn", "-up", "Arci-asphalt-3")
	end
end
if config.enable_y_double_line_marking then
	for i=1, #type5b_tileset do
		func.createTileSetB(type5b_tileset[i], 2, {"-straight-horizontal","-straight-vertical"}, 1, {16})
		func.createIRTentries(type5b_tileset[i].."-straight", "-vertical", "Arci-asphalt-3")
		func.createTileSetB(type5b_tileset[i], 2, {"-diagonal-left","-diagonal-right"}, 1, {16}, true)
		func.createIRTentries(type5b_tileset[i].."-diagonal", "-right", "Arci-asphalt-3")    
		func.createTileSetB(type5b_tileset[i], 4, {"-right-turn-up","-right-turn-right","-right-turn-down","-right-turn-left"}, 1, {16})
		func.createIRTentries(type5b_tileset[i].."-right-turn", "-up", "Arci-asphalt-3")
		func.createTileSetB(type5b_tileset[i], 4, {"-left-turn-up","-left-turn-right","-left-turn-down","-left-turn-left"}, 1, {16})
		func.createIRTentries(type5b_tileset[i].."-left-turn", "-up", "Arci-asphalt-3")
	end
end
