-- this set of functions is derived from functions found in "__base__/prototypes/tile/tiles.lua"


local default_transition_group_id = 0
local water_transition_group_id = 1
local out_of_map_transition_group_id = 2
local water_tile_type_names = { "water", "deepwater", "water-green", "deepwater-green", "water-shallow", "water-mud" }
local tile_transitions = {}

local function make_tile_transition_from_template_variation(src_x, src_y, cnt_, line_len_, is_tall, normal_res_transition, high_res_transition)
    return
    {
        picture = normal_res_transition,
        count = cnt_,
        line_length = line_len_,
        x = src_x,
        y = src_y,
        tall = is_tall,
        hr_version =
        {
            picture = high_res_transition,
            count = cnt_,
            line_length = line_len_,
            x = 2 * src_x,
            y = 2 * (src_y or 0),
            tall = is_tall,
            scale = 0.5
        }
    }
end

local function make_generic_transition_template(to_tiles, group1, group2, normal_res_transition, high_res_transition, options, base_layer, background, mask)
    local t = options.base or {}
    t.to_tiles = to_tiles
    t.transition_group = group1
    t.transition_group1 = group2 and group1 or nil
    t.transition_group2 = group2
    local default_count = options.count or 16
    for k,y in pairs({inner_corner = 0, outer_corner = 288, side = 576, u_transition = 864, o_transition = 1152}) do
        local count = options[k .. "_count"] or default_count
        if count > 0 and type(y) == "number" then
            local line_length = options[k .. "_line_length"] or count
            local is_tall = true
            if (options[k .. "_tall"] == false) then
                is_tall = false
            end
            if base_layer == true then
                t[k] = make_tile_transition_from_template_variation(0, y, count, line_length, is_tall, normal_res_transition, high_res_transition)
            end
            if background == true then
                t[k .. "_background"] = make_tile_transition_from_template_variation(544, y, count, line_length, is_tall, normal_res_transition, high_res_transition)
            end
            if mask == true then
                t[k .. "_mask"] = make_tile_transition_from_template_variation(1088, y, count, line_length, nil, normal_res_transition, high_res_transition)
            end
        end
    end
    return t
end

local function water_transition_template(to_tiles, normal_res_transition, high_res_transition, options)
    return make_generic_transition_template(to_tiles, water_transition_group_id, nil, normal_res_transition, high_res_transition, options, true, true, true)
end

local function make_out_of_map_transition_template(to_tiles, normal_res_transition, high_res_transition, options, base_layer, background, mask)
    return make_generic_transition_template(to_tiles, out_of_map_transition_group_id, nil, normal_res_transition, high_res_transition, options, base_layer, background, mask)
end

local function generic_transition_between_transitions_template(group1, group2, normal_res_transition, high_res_transition, options)
    return make_generic_transition_template(nil, group1, group2, normal_res_transition, high_res_transition, options, true, true, true)
end

local function init_transition_between_transition_common_options(base)
    local t = base or {}
    t.background_layer_offset = t.background_layer_offset or 1
    t.background_layer_group = t.background_layer_group or "zero"
    if (t.offset_background_layer_by_tile_layer == nil) then
        t.offset_background_layer_by_tile_layer = true
    end
    return t
end

local stone_path_out_of_map_transition =
    make_out_of_map_transition_template(
        { "out-of-map" },
        "__base__/graphics/terrain/out-of-map-transition/stone-path-out-of-map-transition-b.png",
        "__base__/graphics/terrain/out-of-map-transition/hr-stone-path-out-of-map-transition-b.png",
        {
            o_transition_tall = false,
            side_count = 8,
            inner_corner_count = 4,
            outer_corner_count = 4,
            u_transition_count = 1,
            o_transition_count = 1,
            base = init_transition_between_transition_common_options()
        },
        true,
        true,
        false
    )


function tile_transitions.asphalt_transitions() -- === stone_path_transitions
	return
	{
		water_transition_template(
			water_tile_type_names,
			"__base__/graphics/terrain/water-transitions/stone-path.png",
			"__base__/graphics/terrain/water-transitions/hr-stone-path.png",
			{
				o_transition_tall = false,
				u_transition_count = 4,
				o_transition_count = 4,
				side_count = 8,
				outer_corner_count = 8,
				inner_corner_count = 8,
				--base = { layer = 40 }
			}
		),
		stone_path_out_of_map_transition
	}
end

function tile_transitions.asphalt_transitions_between_transitions() -- === stone_path_transitions_between_transitions
	return
	{
		generic_transition_between_transitions_template(
			default_transition_group_id, 
			water_transition_group_id,
			"__base__/graphics/terrain/water-transitions/stone-path-transitions.png",
			"__base__/graphics/terrain/water-transitions/hr-stone-path-transitions.png",
			{
				inner_corner_tall = true,
				inner_corner_count = 3,
				outer_corner_count = 3,
				side_count = 3,
				u_transition_count = 1,
				o_transition_count = 0
			}
		),
		make_generic_transition_template(
			nil,
			default_transition_group_id, 
			out_of_map_transition_group_id,
			"__base__/graphics/terrain/out-of-map-transition/stone-path-out-of-map-transition-b.png",
			"__base__/graphics/terrain/out-of-map-transition/hr-stone-path-out-of-map-transition-b.png",
			{
				inner_corner_tall = true,
				inner_corner_count = 3,
				outer_corner_count = 3,
				side_count = 3,
				u_transition_count = 1,
				o_transition_count = 0,
				base = init_transition_between_transition_common_options()
			},
			true,
			false,
			false
		),
	}
end


---
--[[
function tile_transitions.water_transition_template(to_tiles, normal_res_transition, high_res_transition, options)
  local function make_transition_variation(src_x, src_y, cnt_, line_len_, is_tall)
    return
    {
      picture = normal_res_transition,
      count = cnt_,
      line_length = line_len_,
      x = src_x,
      y = src_y,
      tall = is_tall,
      hr_version=
      {
        picture = high_res_transition,
        count = cnt_,
        line_length = line_len_,
        x = 2 * src_x,
        y = 2 * (src_y or 0),
        tall = is_tall,
        scale = 0.5,
      }
    }
  end

  local t = options.base or {}
  t.to_tiles = to_tiles
  local default_count = options.count or 16
  for k,y in pairs({inner_corner = 0, outer_corner = 288, side = 576, u_transition = 864, o_transition = 1152}) do
    local count = options[k .. "_count"] or default_count
    if count > 0 and type(y) == "number" then
      local line_length = options[k .. "_line_length"] or count
      local is_tall = true
      if (options[k .. "_tall"] == false) then
        is_tall = false
      end
      t[k] = make_transition_variation(0, y, count, line_length, is_tall)
      t[k .. "_background"] = make_transition_variation(544, y, count, line_length, is_tall)
      t[k .. "_mask"] = make_transition_variation(1088, y, count, line_length)
    end
  end

  return t
end

function tile_transitions.asphalt_transitions() -- === stone_path_transitions
    return {
      tile_transitions.water_transition_template
      (
          water_tile_type_names,
          "__base__/graphics/terrain/water-transitions/stone-path.png",
          "__base__/graphics/terrain/water-transitions/hr-stone-path.png",
          {
            o_transition_tall = false,
            u_transition_count = 4,
            o_transition_count = 4,
            side_count = 8,
            outer_corner_count = 8,
            inner_corner_count = 8,
            --base = { layer = 40 }
          }
      ),
    }
end

function tile_transitions.asphalt_transitions_between_transitions() -- === stone_path_transitions_between_transitions
    return {
      tile_transitions.water_transition_template
      (
          water_tile_type_names,
          "__base__/graphics/terrain/water-transitions/stone-path-transitions.png",
          "__base__/graphics/terrain/water-transitions/hr-stone-path-transitions.png",
          {
            inner_corner_tall = true,
            inner_corner_count = 3,
            outer_corner_count = 3,
            side_count = 3,
            u_transition_count = 1,
            o_transition_count = 0,
          }
      ),
    }
end
]]
return tile_transitions
