-- Version 5

local _sprites_builder      = {}

-- -- picture
-- mandatory
local _filename             = "__core__/graphics/empty.png"
local _priority             = "high"	
local _width                = 1
local _height               = 1
local _scale                = 1
-- optional
local _shift                = nil
local _draw_as_shadow       = nil
local _apply_runtime_tint   = nil
local _tint                 = nil
local _blend_mode           = nil
local _load_in_minimal_mode = nil
local _premul_alpha         = nil
-- -- shadow
local _shadow_filename      = nil
local _shadow_shift         = nil
-- -- animation
local _frame_count          = nil
local _line_length          = nil
local _animation_speed      = nil

local empty_sprite =
{
	filename    = "__core__/graphics/empty.png",
	priority    = "extra-high",
	width       = 1,
	height      = 1,
	frame_count = 1
}

-- -- -- Setting methods for builder

function _sprites_builder.setFilename(filename)
	if type(filename) == 'string' then
		_filename = filename
	end
end

function _sprites_builder.setShadow(filename)
	_shadow_filename = filename
end

function _sprites_builder.setPriority(priority)
	if type(priority) == 'string' then
		_priority = priority
	end
end

function _sprites_builder.setWidth(width)
	if type(width) == 'number' then
		_width = width
	end
end

function _sprites_builder.setHeight(height)
	if type(height) == 'number' then
		_height = height
	end
end

function _sprites_builder.setScale(scale)
	if type(scale) == 'number' then
		_scale = scale
	end
end

function _sprites_builder.setShift(in_shift)
	_shift = in_shift	
end

function _sprites_builder.setShadowShift(in_shadow_shift)
	_shadow_shift = in_shadow_shift	
end

function _sprites_builder.setDrawAsShadow(draw_as_shadow)
	if type(draw_as_shadow) == 'bool' then
		_draw_as_shadow = draw_as_shadow
	end
end

function _sprites_builder.setApplyRuntimeTint(apply_runtime_tint)
	if type(apply_runtime_tint) == 'bool' then
		_apply_runtime_tint = apply_runtime_tint
	end
end

function _sprites_builder.setTint(tint)
	if type(tint) == 'Color' then
		_tint = tint
	end
end

function _sprites_builder.setBlendMode(blend_mode)
	if type(blend_mode) == 'string' then
		_blend_mode = blend_mode
	end
end

function _sprites_builder.setLoadInMinimalMode(load_in_minimal_mode)
	if type(load_in_minimal_mode) == 'string' then
		_load_in_minimal_mode = load_in_minimal_mode
	end
end

function _sprites_builder.setPremulAlpha(premul_alpha)
	if type(premul_alpha) == 'bool' then
		_premul_alpha = premul_alpha
	end
end

function _sprites_builder.setFrameCount(frame_count)
	if type(frame_count) == 'number' then
		_frame_count = frame_count
	end
end

function _sprites_builder.setLineLength(line_length)
	if type(line_length) == 'number' then
		_line_length = line_length
	end
end

function _sprites_builder.setAnimationSpeed(animation_speed)
	if type(animation_speed) == 'number' then
		_animation_speed = animation_speed
	end
end

function _sprites_builder.restoreDefaultParameters()
	_filename             = "__core__/graphics/empty.png"
	_shadow_filename      = nil
	_priority             = "high"	
	_width                = 1
	_height               = 1
	_scale                = 1
	_shift                = nil
	_shadow_shift         = nil
	_draw_as_shadow       = nil
	_apply_runtime_tint   = nil
	_tint                 = nil
	_blend_mode           = nil
	_load_in_minimal_mode = nil
	_premul_alpha         = nil
	_frame_count          = nil
	_line_length          = nil
	_animation_speed      = nil
end

-- -- -- Build methods

-- build and return an image with the setted parameters
function _sprites_builder.buildImage()
	-- mandatory parameters
	local sprite =
	{
		filename = _filename,
		priority = _priority,	
		width    = _width,
		height   = _height,
		scale    = _scale
	}	
	
	-- adding optional parameters if setted
	if _shift then
		sprite.shift = _shift
	end
	
	if _draw_as_shadow then
		sprite.draw_as_shadow = _draw_as_shadow
	end
	
	if _apply_runtime_tint then
		sprite.apply_runtime_tint = _apply_runtime_tint
	end
	
	if _blend_mode then
		sprite.blend_mode = _blend_mode
	end
	
	if _load_in_minimal_mode then
		sprite.load_in_minimal_mode = _load_in_minimal_mode
	end
	
	if _premul_alpha then
		sprite.premul_alpha = _premul_alpha
	end
	
	if _tint then
		sprite.tint = _tint
	end	
	
	-- animation parameters
	
	if _frame_count then
		sprite.frame_count = _frame_count
	end	
	
	if _line_length then
		sprite.line_length = _line_length
	end	
	
	if _animation_speed then
		sprite.animation_speed = _animation_speed
	end	
	
	if _shadow_filename then	
		shadow_sprite = 
		{
			filename       = _shadow_filename,
			priority       = _priority,	
			width          = _width,
			height         = _height,
			scale          = _scale,
			draw_as_shadow = true
		}	
		
		-- adding optional parameters if setted to shadow
		if _shift and _shadow_shift == nil then
			shadow_sprite.shift = _shift
		elseif _shadow_shift then
			shadow_sprite.shift = _shadow_shift
		end
		
		if _apply_runtime_tint then
			shadow_sprite.apply_runtime_tint = _apply_runtime_tint
		end
		
		if _blend_mode then
			shadow_sprite.blend_mode = _blend_mode
		end
		
		if _load_in_minimal_mode then
			shadow_sprite.load_in_minimal_mode = _load_in_minimal_mode
		end
		
		if _premul_alpha then
			shadow_sprite.premul_alpha = _premul_alpha
		end
		
		if _tint then
			shadow_sprite.tint = _tint
		end	
		
		-- animation parameters
		
		if _frame_count then
			shadow_sprite.frame_count = _frame_count
		end	
		
		if _line_length then
			shadow_sprite.line_length = _line_length
		end	
		
		if _animation_speed then
			shadow_sprite.animation_speed = _animation_speed
		end			
			
		sprite =
		{
			layers =
			{
				sprite,
				shadow_sprite
			}
		}	
	end
	
	return sprite
end 

-- -- -- Secondary build methods

-- return a picture with 4 images(sprites) like factorio standard
function _sprites_builder.getPicture4Parts
	(
		in_north,
		in_east,
		in_south,
		in_west
	)
	return
	{
		north = in_north,
		east = in_east,
		south = in_south,
		west = in_west
	}
end

-- return a picture with 16 images(sprites) like factorio standard
function _sprites_builder.getPicture16Parts
	(
		in_straight_vertical,
		in_straight_horizontal,
		in_corner_right_down,
		in_corner_left_down,
		in_corner_right_up,
		in_corner_left_up,
		in_t_up,
		in_t_right,
		in_t_down,
		in_t_left,
		in_ending_up,
		in_ending_right,
		in_ending_down,
		in_ending_left,
		in_cross,
		in_single	
	)
	return 
	{
		straight_vertical = in_straight_vertical,
		straight_horizontal = in_straight_horizontal,
		corner_right_down = in_corner_right_down,
		corner_left_down = in_corner_left_down,
		corner_right_up = in_corner_right_up,
		corner_left_up = in_corner_left_up,
		t_up = sprite,
		t_right = in_t_right,
		t_down = in_t_down,
		t_left = in_t_left,
		ending_up = in_ending_up,
		ending_right = in_ending_right,
		ending_down = in_ending_down,
		ending_left = in_ending_left,
		cross = in_cross,
		single = in_single		
	}
end

-- return an empty sprite
function _sprites_builder.getEmptySprite()
	return empty_sprite
end

return _sprites_builder