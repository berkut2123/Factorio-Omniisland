-- Copyright (c) 2020 Kirazy
-- Part of Bob's Logistics Belt Reskin
--     
-- See LICENSE.md in the project directory for license information.

-- Import transport belt animation sets
require("prototypes.entity.transport-belt-pictures")	

-- Patch basic belt entities
if data.raw["transport-belt"]["basic-transport-belt"] then
	beltReskin.patchTransport("basic")
	beltReskin.patchUnderground("basic")
	beltReskin.patchSplitter("basic")

	-- Replace the express belt sound with the standard belt sound
	data.raw["transport-belt"]["basic-transport-belt"]["working_sound"]["sound"].filename = "__base__/sound/transport-belt.ogg"
end
		
-- Patch turbo belt entities
if data.raw["transport-belt"]["turbo-transport-belt"] then
	beltReskin.patchUnderground("turbo")
	beltReskin.patchTransport("turbo")
	beltReskin.patchSplitter("turbo")
end
	
-- Patch ultimate belt entities
if data.raw["transport-belt"]["ultimate-transport-belt"] then
	beltReskin.patchTransport("ultimate")
	beltReskin.patchUnderground("ultimate")
	beltReskin.patchSplitter("ultimate")
end

-- Patch loader entities
if data.raw["loader"]["basic-loader"] then
	data.raw["loader"]["basic-loader"].belt_animation_set = basic_transport_belt_animation_set
end

if data.raw["loader"]["purple-loader"] then
	data.raw["loader"]["purple-loader"].belt_animation_set = turbo_transport_belt_animation_set
end

if data.raw["loader"]["green-loader"] then
	data.raw["loader"]["green-loader"].belt_animation_set = ultimate_transport_belt_animation_set
end