-- Copyright (c) 2021 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.equipment.equipment) then return end

local inputs = {
    type = "active-defense-equipment",
    icon_name = "laser-defense",
    mod = "bobs",
    group = "equipment",
}

-- Setup defaults
reskins.lib.parse_inputs(inputs)

local laser_defense = {
    ["personal-laser-defense-equipment"] = {tier = 0},
    ["personal-laser-defense-equipment-2"] = {tier = 1},
    ["personal-laser-defense-equipment-3"] = {tier = 2},
    ["personal-laser-defense-equipment-4"] = {tier = 3},
    ["personal-laser-defense-equipment-5"] = {tier = 4},
    ["personal-laser-defense-equipment-6"] = {tier = 5},
}

-- Reskin equipment
for name, map in pairs(laser_defense) do
    -- Fetch equipment
    local equipment = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not equipment then goto continue end

    -- Handle tier
    local tier = map.tier
    if reskins.lib.setting("reskins-lib-tier-mapping") == "progression-map" then
        tier = map.prog_tier or map.tier
    end

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index[tier]

    -- Construct icon
    reskins.lib.construct_icon(name, tier, inputs)

    -- Reskin the equipment
    equipment.sprite = {
        layers = {
            -- Base
            {
                filename = reskins.bobs.directory.."/graphics/equipment/equipment/laser-defense/laser-defense-equipment-base.png",
                size = 64,
                priority = "medium",
                flags = { "no-crop" },
                hr_version = {
                    filename = reskins.bobs.directory.."/graphics/equipment/equipment/laser-defense/hr-laser-defense-equipment-base.png",
                    size = 128,
                    priority = "medium",
                    flags = { "no-crop" },
                    scale = 0.5,
                }
            },
            -- Mask
            {
                filename = reskins.bobs.directory.."/graphics/equipment/equipment/laser-defense/laser-defense-equipment-mask.png",
                size = 64,
                priority = "medium",
                flags = { "no-crop" },
                tint = inputs.tint,
                hr_version = {
                    filename = reskins.bobs.directory.."/graphics/equipment/equipment/laser-defense/hr-laser-defense-equipment-mask.png",
                    size = 128,
                    priority = "medium",
                    flags = { "no-crop" },
                    tint = inputs.tint,
                    scale = 0.5,
                }
            },
            -- Highlights
            {
                filename = reskins.bobs.directory.."/graphics/equipment/equipment/laser-defense/laser-defense-equipment-highlights.png",
                size = 64,
                priority = "medium",
                flags = { "no-crop" },
                blend_mode = reskins.lib.blend_mode, -- "additive",
                hr_version = {
                    filename = reskins.bobs.directory.."/graphics/equipment/equipment/laser-defense/hr-laser-defense-equipment-highlights.png",
                    size = 128,
                    priority = "medium",
                    flags = { "no-crop" },
                    blend_mode = reskins.lib.blend_mode, -- "additive",
                    scale = 0.5,
                }
            }
        }
    }

    -- Label to skip to next iteration
    ::continue::
end