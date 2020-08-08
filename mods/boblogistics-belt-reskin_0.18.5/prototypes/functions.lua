-- Copyright (c) 2020 Kirazy
-- Part of Bob's Logistics Belt Reskin
--     
-- See LICENSE.md in the project directory for license information.

-- Set mod directory
local modDir = "__boblogistics-belt-reskin__"

-- Initialize function storage
if not beltReskin then beltReskin = {} end

-- Store tint values for use with particle creation, format is ["entityPrefix"] = {{transport-belt},{underground-belt},{splitter}}
beltReskin.particleTint = {
    ["basic"] = {util.color("bbbbbb"), util.color("c5c5c5"), util.color("c0c0c0")},
    ["turbo"] = {util.color("ba00a0"), util.color("e71fd6"), util.color("dd1dcf")},
    ["ultimate"] = {util.color("3bd600"), util.color("6ae825"), util.color("6ae237")}
}

-- This function creates corpses for splitter entities
function beltReskin.createRemnants(entityName, entityType)
    local remnant = table.deepcopy(data.raw["corpse"][entityType.."-remnants"])
    remnant.name = entityName.."-remnants"
    remnant.icon = modDir.."/graphics/icons/"..entityName..".png"

    if entityType == "transport-belt" then
        remnant.animation[1].filename = modDir.."/graphics/entity/"..entityName.."/remnants/"..entityName.."-remnants.png"
        remnant.animation[1].hr_version.filename = modDir.."/graphics/entity/"..entityName.."/remnants/hr-"..entityName.."-remnants.png"
        remnant.animation[2].filename = modDir.."/graphics/entity/"..entityName.."/remnants/"..entityName.."-remnants.png"
        remnant.animation[2].hr_version.filename = modDir.."/graphics/entity/"..entityName.."/remnants/hr-"..entityName.."-remnants.png"
    else
        remnant.animation.filename = modDir.."/graphics/entity/"..entityName.."/remnants/"..entityName.."-remnants.png"
        remnant.animation.hr_version.filename = modDir.."/graphics/entity/"..entityName.."/remnants/hr-"..entityName.."-remnants.png"
    end
    data:extend({remnant})
end

-- This function patches sprites for transport belts
function beltReskin.patchTransport(entityName)
    local entity = data.raw["transport-belt"][entityName.."-transport-belt"]
	entity.belt_animation_set = _G[entityName.."_transport_belt_animation_set"]
	entity.icon = modDir.."/graphics/icons/"..entityName.."-transport-belt.png"
	entity.icon_size = 64
    entity.corpse = entityName.."-transport-belt-remnants"
    entity.dying_explosion = entityName.."-transport-belt-explosion"
end

-- This function patches sprites for underground belts
function beltReskin.patchUnderground(entityName)
    local entity = data.raw["underground-belt"][entityName.."-underground-belt"]
    
	entity.belt_animation_set = _G[entityName.."_transport_belt_animation_set"]
	entity.icon = modDir.."/graphics/icons/"..entityName.."-underground-belt.png"
	entity.icon_size = 64
    entity.corpse = entityName.."-underground-belt-remnants"
    entity.dying_explosion = entityName.."-underground-belt-explosion"
	entity.structure.direction_in.sheet.filename = modDir.."/graphics/entity/"..entityName.."-underground-belt/"..entityName.."-underground-belt-structure.png"
	entity.structure.direction_in.sheet.hr_version.filename = modDir.."/graphics/entity/"..entityName.."-underground-belt/hr-"..entityName.."-underground-belt-structure.png"
	entity.structure.direction_out.sheet.filename = modDir.."/graphics/entity/"..entityName.."-underground-belt/"..entityName.."-underground-belt-structure.png"
	entity.structure.direction_out.sheet.hr_version.filename = modDir.."/graphics/entity/"..entityName.."-underground-belt/hr-"..entityName.."-underground-belt-structure.png"
	entity.structure.direction_in_side_loading.sheet.filename = modDir.."/graphics/entity/"..entityName.."-underground-belt/"..entityName.."-underground-belt-structure.png"
	entity.structure.direction_in_side_loading.sheet.hr_version.filename = modDir.."/graphics/entity/"..entityName.."-underground-belt/hr-"..entityName.."-underground-belt-structure.png"
	entity.structure.direction_out_side_loading.sheet.filename = modDir.."/graphics/entity/"..entityName.."-underground-belt/"..entityName.."-underground-belt-structure.png"
    entity.structure.direction_out_side_loading.sheet.hr_version.filename = modDir.."/graphics/entity/"..entityName.."-underground-belt/hr-"..entityName.."-underground-belt-structure.png"
end

-- This function patches sprites for splitters
function beltReskin.patchSplitter(entityName)	
	local entity = data.raw["splitter"][entityName.."-splitter"]
	entity.belt_animation_set = _G[entityName.."_transport_belt_animation_set"]
	entity.icon = modDir.."/graphics/icons/"..entityName.."-splitter.png"
	entity.icon_size = 64
	entity.corpse = entityName.."-splitter-remnants"
    entity.dying_explosion = entityName.."-splitter-explosion"
	entity.structure.north =
	{
		filename = modDir.."/graphics/entity/"..entityName.."-splitter/"..entityName.."-splitter-north.png",
		frame_count = 32,
		line_length = 8,
		priority = "extra-high",
		width = 82,
		height = 36,
		shift = util.by_pixel(6, 0),
		hr_version =
		{
			filename = modDir.."/graphics/entity/"..entityName.."-splitter/hr-"..entityName.."-splitter-north.png",
			frame_count = 32,
			line_length = 8,
			priority = "extra-high",
			width = 160,
			height = 70,
			shift = util.by_pixel(7, 0),
			scale = 0.5
		}
	}
	entity.structure.east =
	{
		filename = modDir.."/graphics/entity/"..entityName.."-splitter/"..entityName.."-splitter-east.png",
		frame_count = 32,
		line_length = 8,
		priority = "extra-high",
		width = 46,
		height = 44,
		shift = util.by_pixel(4, 12),
		hr_version =
		{
		filename = modDir.."/graphics/entity/"..entityName.."-splitter/hr-"..entityName.."-splitter-east.png",
		frame_count = 32,
		line_length = 8,
		priority = "extra-high",
		width = 90,
		height = 84,
		shift = util.by_pixel(4, 13),
		scale = 0.5
		}
	}
	entity.structure.south =
	{
        filename = modDir.."/graphics/entity/"..entityName.."-splitter/"..entityName.."-splitter-south.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 82,
        height = 32,
        shift = util.by_pixel(4, 0),
        hr_version =
        {
			filename = modDir.."/graphics/entity/"..entityName.."-splitter/hr-"..entityName.."-splitter-south.png",
			frame_count = 32,
			line_length = 8,
			priority = "extra-high",
			width = 164,
			height = 64,
			shift = util.by_pixel(4, 0),
			scale = 0.5
        }
	}
	entity.structure.west =
	{
		filename = modDir.."/graphics/entity/"..entityName.."-splitter/"..entityName.."-splitter-west.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 46,
        height = 44,
        shift = util.by_pixel(6, 12),
		hr_version =
		{
		filename = modDir.."/graphics/entity/"..entityName.."-splitter/hr-"..entityName.."-splitter-west.png",
			frame_count = 32,
			line_length = 8,
			priority = "extra-high",
			width = 94,
			height = 86,
			shift = util.by_pixel(5, 12),
			scale = 0.5
		}
	}
	entity.structure_patch = 
	{
		north = util.empty_sprite(),
		east =
		{
			filename = modDir.."/graphics/entity/"..entityName.."-splitter/"..entityName.."-splitter-east-top_patch.png",
			frame_count = 32,
			line_length = 8,
			priority = "extra-high",
			width = 46,
			height = 52,
			shift = util.by_pixel(4, -20),
			hr_version =
			{
				filename = modDir.."/graphics/entity/"..entityName.."-splitter/hr-"..entityName.."-splitter-east-top_patch.png",
				frame_count = 32,
				line_length = 8,
				priority = "extra-high",
				width = 90,
				height = 104,
				shift = util.by_pixel(4, -20),
				scale = 0.5
			}
		},	
		south = util.empty_sprite(),
		west =
		{
			filename = modDir.."/graphics/entity/"..entityName.."-splitter/"..entityName.."-splitter-west-top_patch.png",
			frame_count = 32,
			line_length = 8,
			priority = "extra-high",
			width = 46,
			height = 48,
			shift = util.by_pixel(6, -18),
			hr_version =
			{
				filename = modDir.."/graphics/entity/"..entityName.."-splitter/hr-"..entityName.."-splitter-west-top_patch.png",
				frame_count = 32,
				line_length = 8,
				priority = "extra-high",
				width = 94,
				height = 96,
				shift = util.by_pixel(5, -18),
				scale = 0.5
			}
		}
	}
end

-- This function creates particle entities
function beltReskin.createParticles(entityName)
    
    -- transport-belt-metal-particle-medium
    local mediumBeltParticle = table.deepcopy(data.raw["optimized-particle"]["transport-belt-metal-particle-medium"])
    mediumBeltParticle.name = entityName.."-transport-belt-metal-particle-medium"
    mediumBeltParticle.pictures.sheet.tint = beltReskin.particleTint[entityName][1]
    mediumBeltParticle.pictures.sheet.hr_version.tint = beltReskin.particleTint[entityName][1]
    data:extend({mediumBeltParticle})
        
    -- transport-belt-metal-particle-small
    local smallBeltParticle = table.deepcopy(data.raw["optimized-particle"]["transport-belt-metal-particle-small"])
    smallBeltParticle.name = entityName.."-transport-belt-metal-particle-small"
    smallBeltParticle.pictures.sheet.tint = beltReskin.particleTint[entityName][1]
    smallBeltParticle.pictures.sheet.hr_version.tint = beltReskin.particleTint[entityName][1]
    data:extend({smallBeltParticle})

    -- underground-belt-metal-particle-small
    local smallUndergroundParticle = table.deepcopy(data.raw["optimized-particle"]["underground-belt-metal-particle-small"])
    smallUndergroundParticle.name = entityName.."-underground-belt-metal-particle-small"
    smallUndergroundParticle.pictures.sheet.tint = beltReskin.particleTint[entityName][2]
    smallUndergroundParticle.pictures.sheet.hr_version.tint = beltReskin.particleTint[entityName][2]
    data:extend({smallUndergroundParticle})

    -- underground-belt-metal-particle-tinted
    local tintedUndergroundParticle = table.deepcopy(data.raw["optimized-particle"]["underground-belt-metal-particle-medium-yellow"])
    tintedUndergroundParticle.name = entityName.."-underground-belt-metal-particle-medium-tinted"
    tintedUndergroundParticle.pictures.sheet.tint = beltReskin.particleTint[entityName][2]
    tintedUndergroundParticle.pictures.sheet.hr_version.tint = beltReskin.particleTint[entityName][2]
    data:extend({tintedUndergroundParticle})

    -- splitter-metal-particle-medium
    local mediumSplitterParticle = table.deepcopy(data.raw["optimized-particle"]["splitter-metal-particle-medium"])
    mediumSplitterParticle.name = entityName.."-splitter-metal-particle-medium"
    mediumSplitterParticle.pictures.sheet.tint = beltReskin.particleTint[entityName][3]
    mediumSplitterParticle.pictures.sheet.hr_version.tint = beltReskin.particleTint[entityName][3]
    data:extend({mediumSplitterParticle})

    -- splitter-metal-particle-big
    local bigSplitterParticle = table.deepcopy(data.raw["optimized-particle"]["splitter-metal-particle-big"])
    bigSplitterParticle.name = entityName.."-splitter-metal-particle-big"
    bigSplitterParticle.pictures.sheet.tint = beltReskin.particleTint[entityName][3]
    bigSplitterParticle.pictures.sheet.hr_version.tint = beltReskin.particleTint[entityName][3]
    data:extend({bigSplitterParticle})
end

-- This function creates explosion entities
function beltReskin.createExplosions(entityName,entityType)
    local explosion = table.deepcopy(data.raw["explosion"][entityType.."-explosion"])
    explosion.name = entityName.."-"..entityType.."-explosion"
    explosion.icon = modDir.."/graphics/icons/"..entityName.."-"..entityType..".png"

    -- Transport belt explosions
    if entityType == "transport-belt" then
        explosion.created_effect.action_delivery.target_effects[1].particle_name = entityName.."-transport-belt-metal-particle-medium"
        explosion.created_effect.action_delivery.target_effects[2].particle_name = entityName.."-transport-belt-metal-particle-small"
    end

    -- Underground belt explosions
    if entityType == "underground-belt" then
        explosion.created_effect.action_delivery.target_effects[2].particle_name = entityName.."-underground-belt-metal-particle-small"
        explosion.created_effect.action_delivery.target_effects[3].particle_name = entityName.."-underground-belt-metal-particle-medium-tinted"
    end

    -- Splitter explosions
    if entityType == "splitter" then
        explosion.created_effect.action_delivery.target_effects[1].particle_name = entityName.."-splitter-metal-particle-medium"
        explosion.created_effect.action_delivery.target_effects[4].particle_name = entityName.."-splitter-metal-particle-big"
    end

    data:extend({explosion})
end

-- This function replaces the icons
function beltReskin.patchIcon(entityName)
    data.raw["item"][entityName].icon = modDir.."/graphics/icons/"..entityName..".png"
	data.raw["item"][entityName].icon_size = 64
end