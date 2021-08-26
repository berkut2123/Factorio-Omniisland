-- Copyright (c) 2021 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.logistics.entities) then return end
if reskins.lib.setting("bobmods-logistics-trains") == false then return end

-- Set input parameters
local inputs = {
    type = "fluid-wagon",
    icon_name = "fluid-wagon",
    base_entity = "fluid-wagon",
    mod = "bobs",
    group = "logistics",
    particles = {["small"] = 3},
}

local tier_map = {
    ["fluid-wagon"] = {1, 2},
    ["bob-fluid-wagon-2"] = {2, 3},
    ["bob-fluid-wagon-3"] = {3, 4},
    ["bob-armoured-fluid-wagon"] = {1, 4},
    ["bob-armoured-fluid-wagon-2"] = {2, 5},
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
    -- Fetch entity
    local entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then goto continue end

    -- Parse map
    local tier = map[1]
    if reskins.lib.setting("reskins-lib-tier-mapping") == "progression-map" then
        tier = map[2]
    end

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index[tier]

    -- Setup icon details
    if string.find(name, "armoured") then
        inputs.icon_extras = {
            {
                icon = reskins.bobs.directory.."/graphics/icons/logistics/locomotive/armored-train-symbol.png"
            },
            {
                icon = reskins.bobs.directory.."/graphics/icons/logistics/locomotive/armored-train-symbol.png",
                tint = reskins.lib.adjust_alpha(reskins.lib.tint_index[tier], 0.75)
            }
        }
    else
        inputs.icon_extras = nil
    end

    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- TODO: Reskin remnants?

    -- TODO: Reskin entity?

    -- Label to skip to next iteration
    ::continue::
end