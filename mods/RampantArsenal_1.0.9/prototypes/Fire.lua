local fire = {}

local technologyUtils = require("utils/TechnologyUtils")
local ammoUtils = require("utils/AmmoUtils")
local streamUtils = require("utils/StreamUtils")
local recipeUtils = require("utils/RecipeUtils")
local oilUtils = require("utils/OilUtils")

local makeStream = streamUtils.makeStream
local makeAmmo = ammoUtils.makeAmmo
local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local addFluid = oilUtils.addFluid

function fire.enable()

    local napalm = addFluid({
            name = "napalm",
            tint = { r=0.97, g = 0.77, b = 0.77, a = 1 },
            baseColor = { r=0.97, g = 0.77, b = 0.77, a = 1 },
            flowColor = { r=0.97, g = 0.77, b = 0.77, a = 1 },
            emissionsMultiplier = 2.5,
            fuelValue = "0.85MJ",
            order = "e[napalm]"
    })

    local napalmAmmo = makeAmmo({
            name = "napalm",
            icon = "__RampantArsenal__/graphics/icons/napalm-ammo.png",
            order = "e[napalm]",
            ammoType = {
                {
                    source_type = "default",
                    category = "flamethrower",
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStream({
                                            name = "napalm-handheld",
                                            bufferSize = 65,
                                            spawnInterval = 2,
                                            particleTimeout = 2,
                                            particleVerticalAcceleration = 0.005,
                                            particleHoizontalSpeed = 0.25,
                                            actions = {
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "create-fire",
                                                                        entity_name = "fire-flame",
                                                                        initial_ground_flame_count = 6,
                                                                    },
                                                                    {
                                                                        type = "destroy-decoratives",
                                                                        from_render_layer = "decorative",
                                                                        to_render_layer = "object",
                                                                        include_soft_decoratives = true,
                                                                        include_decals = false,
                                                                        invoke_decorative_trigger = true,
                                                                        decoratives_with_trigger_only = false,
                                                                        radius = 1
                                                                    }
                                                                }
                                                        }
                                                },
                                                {
                                                    type = "area",
                                                    radius = 2.5,
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "create-sticker",
                                                                        sticker = "small-fire-sticker-rampant-arsenal"
                                                                    },
                                                                    {
                                                                        type = "create-fire",
                                                                        entity_name = "fire-flame",
                                                                        initial_ground_flame_count = 6,
                                                                    },
                                                                    {
                                                                        type = "damage",
                                                                        damage = { amount = 9, type = "fire" },
                                                                        apply_damage_to_trees = false
                                                                    }
                                                                }
                                                        }
                                                }
                                            }
                                    }),
                                    max_length = 15,
                                    duration = 160,
                                }
                        }
                },
                {
                    source_type = "vehicle",
                    consumption_modifier = 1.125,
                    category = "flamethrower",
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStream({
                                            name = "napalm-tank",
                                            bufferSize = 65,
                                            spawnInterval = 2,
                                            particleTimeout = 2,
                                            particleVerticalAcceleration = 0.015,
                                            particleHoizontalSpeed = 0.45,
                                            particleHoizontalSpeedDeviation = 0.0035,
                                            particleSize = 1.5,
                                            actions = {
                                                {
                                                    type = "area",
                                                    radius = 6,
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "damage",
                                                                        damage = { amount = 25, type = "fire" },
                                                                        apply_damage_to_trees = true
                                                                    }
                                                                }
                                                        }
                                                }
                                            }
                                    }),
                                    max_length = 9,
                                    duration = 160,
                                }
                        }
                }
            }
    })

    makeRecipe({
            name = napalmAmmo,
            icon = "__RampantArsenal__/graphics/icons/napalm-ammo.png",
            enabled = false,
            category = "crafting-with-fluid",
            ingredients = {
                {"steel-plate", 5},
                {"copper-plate", 2},
                {type="fluid", name=napalm, amount=100}
            },
            result = napalmAmmo,
    })

    makeRecipe({
            name = napalm,
            icon = "__base__/graphics/icons/fluid/light-oil.png",
            iconSize = 64,
            iconMipmaps = 4,
            tint = { r=0.97, g = 0.77, b = 0.77, a = 1 },
            enabled = false,
            category = "chemistry",
            subgroup = "fluid-recipes",
            ingredients = {
                {"plastic-bar", 3},
                {type="fluid", name="petroleum-gas", amount=30},
                {type="fluid", name="sulfuric-acid", amount=20}
            },
            results = {
                {type="fluid", name=napalm, amount=50}
            }
    })

    addEffectToTech("incendiary-napalm",
                    {
                        {
                            type = "unlock-recipe",
                            recipe = napalmAmmo,
                        },
                        {
                            type = "unlock-recipe",
                            recipe = napalm,
                        }
    })

    -- data.raw["fire"]["fire-flame"].maximum_damage_multiplier = 10
    -- data.raw["fire"]["fire-flame"].damage_multiplier_increase_per_added_fuel = 1.35
    data.raw["fire"]["fire-flame"].initial_lifetime = 5 * 60
    data.raw["fire"]["fire-flame"].lifetime_increase_by = 2.5 * 60
    data.raw["fire"]["fire-flame"].maximum_lifetime = 10 * 60
    data.raw["fire"]["fire-flame"].burnt_patch_lifetime = 10 * 60

    local fluids = data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.fluids
    fluids[#fluids+1] = {type=napalm, damage_modifier=1.5}
end

return fire
