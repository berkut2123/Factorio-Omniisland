-- Copyright (c) 2021 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.mining.entities) then return end

-- Set input parameters
local inputs = {
    type = "mining-drill",
    icon_name = "pumpjack",
    base_entity = "pumpjack",
    mod = "bobs",
    group = "mining",
    particles = {["small"] = 3},
}

local tier_map = {
    ["pumpjack"] = {1},
    ["bob-pumpjack-1"] = {2},
    ["bob-pumpjack-2"] = {3},
    ["bob-pumpjack-3"] = {4},
    ["bob-pumpjack-4"] = {5},
    ["water-miner-1"] = {1, true},
    ["water-miner-2"] = {2, true},
    ["water-miner-3"] = {3, true},
    ["water-miner-4"] = {4, true},
    ["water-miner-5"] = {5, true},
}

local function base_picture_base_layer(variant)
    if variant ~= true then
        return
        {
            filename = "__base__/graphics/entity/pumpjack/pumpjack-base.png",
            priority = "extra-high",
            width = 131,
            height = 137,
            shift = util.by_pixel(-2.5, -4.5),
            hr_version = {
                filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-base.png",
                priority = "extra-high",
                width = 261,
                height = 273,
                shift = util.by_pixel(-2.25, -4.75),
                scale = 0.5
            }
        }
    else
        return
        {
            filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/water-pumpjack-base.png",
            priority = "extra-high",
            width = 131,
            height = 137,
            shift = util.by_pixel(-2.5, -4.5),
            hr_version = {
                filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/hr-water-pumpjack-base.png",
                priority = "extra-high",
                width = 261,
                height = 273,
                shift = util.by_pixel(-2.25, -4.75),
                scale = 0.5
            }
        }
    end
end

local function animations_base_layer(variant, playback_speed)
    if variant ~= true then
        return
        {
            priority = "high",
            filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead.png",
            line_length = 8,
            width = 104,
            height = 102,
            frame_count = 40,
            shift = util.by_pixel(-4, -24),
            animation_speed = playback_speed,
            repeat_count = 6,
            hr_version = {
                priority = "high",
                filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-horsehead.png",
                animation_speed = playback_speed,
                repeat_count = 6,
                scale = 0.5,
                line_length = 8,
                width = 206,
                height = 202,
                frame_count = 40,
                shift = util.by_pixel(-4, -24)
            }
        }
    else
        return
        {
            priority = "high",
            filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/water-pumpjack-horsehead.png",
            line_length = 8,
            width = 104,
            height = 102,
            frame_count = 40,
            shift = util.by_pixel(-4, -24),
            animation_speed = playback_speed,
            repeat_count = 6,
            hr_version = {
                priority = "high",
                filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/hr-water-pumpjack-horsehead.png",
                animation_speed = playback_speed,
                repeat_count = 6,
                scale = 0.5,
                line_length = 8,
                width = 206,
                height = 202,
                frame_count = 40,
                shift = util.by_pixel(-4, -24)
            }
        }
    end
end

-- Rescale pumpjack animation playback speed to something visually appealing
local max_playback = 2   -- Maximum animation playback speed
local min_playback = 0.5 -- Minimum animation playback speed

local pumpjack_speeds = {}
local index = 1

-- Loop through all the pumpjacks, figure out the mining speeds
for name, tier in pairs(tier_map) do
    -- Fetch entity
    local entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then goto continue end

    -- Fetch mining speed
    pumpjack_speeds[index] = data.raw[inputs.type][name].mining_speed
    index = index + 1

    -- Label to skip to next iteration
    ::continue::
end

-- Determine max and min mining speeds
table.sort(pumpjack_speeds)
local max_speed = pumpjack_speeds[#pumpjack_speeds]
local min_speed = pumpjack_speeds[1]

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
    -- Fetch entity
    local entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then goto continue end

    -- Parse map
    local tier = map[1]
    local variant = map[2] or false

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index[tier]

    -- Setup icon base details
    if variant then
        inputs.icon_base = "water-pumpjack"
    else
        inputs.icon_base = "pumpjack"
    end

    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- Calculate new animation playback speed
    local playback_speed
    if max_speed - min_speed == 0 then
        playback_speed = entity.mining_speed
    else
        playback_speed = ((entity.mining_speed/(max_speed-min_speed)) - (min_speed/(max_speed-min_speed)))*max_playback
                        + ((max_speed/(max_speed-min_speed)) - (entity.mining_speed/(max_speed-min_speed)))*min_playback
    end

    -- Reskin base particles if we're a water pump
    if variant then
        reskins.lib.create_particle(name, inputs.base_entity, reskins.lib.particle_index["big"], 1, util.color("3083bf"))
        reskins.lib.create_particle(name, inputs.base_entity, reskins.lib.particle_index["medium"], 2, util.color("3083bf"))
    end

    -- Fetch remnants
    local remnant = data.raw["corpse"][name.."-remnants"]

    -- Reskin remnants
    remnant.animation = make_rotated_animation_variations_from_sheet(2, {
        layers = {
            -- Base
            {
                filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/remnants/"..inputs.icon_base.."-remnants-base.png",
                line_length = 1,
                width = 138,
                height = 142,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(0, 3),
                hr_version = {
                    filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/remnants/hr-"..inputs.icon_base.."-remnants-base.png",
                    line_length = 1,
                    width = 274,
                    height = 284,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(0, 3.5),
                    scale = 0.5,
                }
            },
            -- Mask
            {
                filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/remnants/pumpjack-remnants-mask.png",
                line_length = 1,
                width = 138,
                height = 142,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(0, 3),
                tint = inputs.tint,
                hr_version = {
                    filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/remnants/hr-pumpjack-remnants-mask.png",
                    line_length = 1,
                    width = 274,
                    height = 284,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(0, 3.5),
                    tint = inputs.tint,
                    scale = 0.5,
                }
            },
            -- Highlights
            {
                filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/remnants/pumpjack-remnants-highlights.png",
                line_length = 1,
                width = 138,
                height = 142,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(0, 3),
                blend_mode = reskins.lib.blend_mode, -- "additive",
                hr_version = {
                    filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/remnants/hr-pumpjack-remnants-highlights.png",
                    line_length = 1,
                    width = 274,
                    height = 284,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(0, 3.5),
                    blend_mode = reskins.lib.blend_mode, -- "additive",
                    scale = 0.5,
                }
            }
        }
    })

    -- Reskin entities
    entity.base_picture = {
        sheets = {
            -- Base
            base_picture_base_layer(variant),
            -- Shadow
            {
                filename = "__base__/graphics/entity/pumpjack/pumpjack-base-shadow.png",
                priority = "extra-high",
                width = 110,
                height = 111,
                draw_as_shadow = true,
                shift = util.by_pixel(6, 0.5),
                hr_version = {
                  filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-base-shadow.png",
                  width = 220,
                  height = 220,
                  scale = 0.5,
                  draw_as_shadow = true,
                  shift = util.by_pixel(6, 0.5)
                }
            }

        }
    }

    entity.animations = {
        north = {
            layers = {
                animations_base_layer(variant, playback_speed),
                -- Mask
                {
                    priority = "high",
                    filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/pumpjack-horsehead-mask.png",
                    line_length = 8,
                    width = 104,
                    height = 102,
                    frame_count = 40,
                    shift = util.by_pixel(-4, -24),
                    tint = inputs.tint,
                    animation_speed = playback_speed,
                    repeat_count = 6,
                    hr_version = {
                        priority = "high",
                        filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/hr-pumpjack-horsehead-mask.png",
                        animation_speed = playback_speed,
                        repeat_count = 6,
                        scale = 0.5,
                        line_length = 8,
                        width = 206,
                        height = 202,
                        frame_count = 40,
                        shift = util.by_pixel(-4, -24),
                        tint = inputs.tint,
                    }
                },
                -- Highlights
                {
                    priority = "high",
                    filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/pumpjack-horsehead-highlights.png",
                    line_length = 8,
                    width = 104,
                    height = 102,
                    frame_count = 40,
                    shift = util.by_pixel(-4, -24),
                    blend_mode = reskins.lib.blend_mode, -- "additive",
                    animation_speed = playback_speed,
                    repeat_count = 6,
                    hr_version = {
                        priority = "high",
                        filename = reskins.bobs.directory.."/graphics/entity/mining/pumpjack/hr-pumpjack-horsehead-highlights.png",
                        animation_speed = playback_speed,
                        repeat_count = 6,
                        scale = 0.5,
                        line_length = 8,
                        width = 206,
                        height = 202,
                        frame_count = 40,
                        shift = util.by_pixel(-4, -24),
                        blend_mode = reskins.lib.blend_mode, -- "additive",
                    }
                },
                -- Shadow
                {
                    priority = "high",
                    filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead-shadow.png",
                    animation_speed = playback_speed,
                    repeat_count = 6,
                    draw_as_shadow = true,
                    line_length = 8,
                    width = 155,
                    height = 41,
                    frame_count = 40,
                    shift = util.by_pixel(17.5, 14.5),
                    hr_version = {
                        priority = "high",
                        filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-horsehead-shadow.png",
                        animation_speed = playback_speed,
                        repeat_count = 6,
                        draw_as_shadow = true,
                        line_length = 8,
                        width = 309,
                        height = 82,
                        frame_count = 40,
                        scale = 0.5,
                        shift = util.by_pixel(17.75, 14.5)
                    }
                }
            }
        }
    }

    -- Label to skip to next iteration
    ::continue::
end