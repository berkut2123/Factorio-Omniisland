-- Copyright (c) 2020 Kirazy
-- Part of Bob's Logistics Belt Reskin
--     
-- See LICENSE.md in the project directory for license information.

-- Set mod directory
local modDir = "__boblogistics-belt-reskin__"

-- Create animation sets
basic_transport_belt_animation_set = 
{
	animation_set =
	{
		filename = modDir.."/graphics/entity/basic-transport-belt/basic-transport-belt.png",
		priority = "extra-high",
		width = 64,
		height = 64,
		frame_count = 16,
		direction_count = 20,
		hr_version =
		{
			filename = modDir.."/graphics/entity/basic-transport-belt/hr-basic-transport-belt.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
			frame_count = 16,
			direction_count = 20
		}
	}
}

turbo_transport_belt_animation_set = 
{
	animation_set =
	{
		filename = modDir.."/graphics/entity/turbo-transport-belt/turbo-transport-belt.png",
		priority = "extra-high",
		width = 64,
		height = 64,
		frame_count = 32,
		direction_count = 20,
		hr_version =
		{
			filename = modDir.."/graphics/entity/turbo-transport-belt/hr-turbo-transport-belt.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
			frame_count = 32,
			direction_count = 20
		}
	}
}

ultimate_transport_belt_animation_set = 
{
	animation_set =
	{
		filename = modDir.."/graphics/entity/ultimate-transport-belt/ultimate-transport-belt.png",
		priority = "extra-high",
		width = 64,
		height = 64,
		frame_count = 32,
		direction_count = 20,
		hr_version =
		{
			filename = modDir.."/graphics/entity/ultimate-transport-belt/hr-ultimate-transport-belt.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
			frame_count = 32,
			direction_count = 20
		}
	}
}