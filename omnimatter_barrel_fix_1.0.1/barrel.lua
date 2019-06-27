-- The code in this file is based on 
-- https://github.com/wube/factorio-data/blob/master/base/data-updates.lua

local kEmptyBarrelName = "empty-barrel" 

-- Alpha used for barrel masks
local kSideAlpha = 0.75
local kTopHoopAlpha = 0.75

local kFluidPerBarrel = 50
local kEnergyPerFill = 0.2
local kEnergyPerEmpty = 0.2

-- Item icon masks
local kBarrelSideMask = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png"
local kBarrelHoopTopMask = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png"

-- Recipe icon masks
local kBarrelEmptySideMask = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png"
local kBarrelEmptyTopMask = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png"
local kBarrelFillSideMask = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png"
local kBarrelFillTopMask = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png"

local function GenerateBarrelItemIcons(fluid, empty_barrel_item)
    local side_tint = util.table.deepcopy(fluid.base_color)
    side_tint.a = kSideAlpha

    local top_hoop_tint = util.table.deepcopy(fluid.flow_color)
    top_hoop_tint.a = kTopHoopAlpha

    return {
        { icon = empty_barrel_item.icon },
        { icon = kBarrelSideMask, tint = side_tint },
        { icon = kBarrelHoopTopMask, tint = top_hoop_tint }
    }
end

local function CreateBarrelItem(name, fluid, empty_barrel_item)
    local barrel_item = {
        type = "item",
        name = name,
        localised_name = {"item-name.filled-barrel", {"fluid-name." .. fluid.name}},
        icons = GenerateBarrelItemIcons(fluid, empty_barrel_item),
        icon_size = 32,
        subgroup = "fill-barrel",
        order = "b[" .. name .. "]",
        stack_size = empty_barrel_item.stack_size
    }

    data:extend({barrel_item})
    return barrel_item
end

local function GetOrCreateBarrelItem(name, fluid, empty_barrel_item)
    return data.raw.item[name] or CreateBarrelItem(name, fluid, empty_barrel_item)
end

-- Omnifluids use fluid.icons, so merge them with the new icon.
local function MergeOmniIconForBarrelRecipe(icon, fluid, shift)
    -- TODO(szuend): This is still buggy for omnide-solution fluids.
    for _, icon_data in ipairs(fluid.icons) do
        local new_icon = util.table.deepcopy(icon_data)
        new_icon.scale = 0.5
        new_icon.shift = shift

        table.insert(icon, new_icon)
    end
end

local function GenerateFillBarrelIcons(fluid)
    local side_tint = util.table.deepcopy(fluid.base_color)
    side_tint.a = kSideAlpha

    local top_hoop_tint = util.table.deepcopy(fluid.flow_color)
    top_hoop_tint.a = kTopHoopAlpha

    local icon = {
        { icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png" },
        { icon = kBarrelFillSideMask, tint = side_tint },
        { icon = kBarrelFillTopMask, tint = top_hoop_tint }
    }
    MergeOmniIconForBarrelRecipe(icon, fluid, {4, -8})

    return icon
end

local function GenerateEmptyBarrelIcons(fluid)
    local side_tint = util.table.deepcopy(fluid.base_color)
    side_tint.a = kSideAlpha

    local top_hoop_tint = util.table.deepcopy(fluid.flow_color)
    top_hoop_tint.a = kTopHoopAlpha

    local icon = {
        { icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png" },
        { icon = kBarrelEmptySideMask, tint = side_tint },
        { icon = kBarrelEmptyTopMask, tint = top_hoop_tint }
    }
    MergeOmniIconForBarrelRecipe(icon, fluid, {7, 8})

    return icon
end

-- If Angels Refining is installed, we use the barreling-pump
local function GetRecipeCategory()
    if angelsmods then return "barreling-pump" end
    return "carfting-with-fluid"
end

-- If Angels Refining is installed and auto_barreling enabled, we hide the recipe
local function GetHiddenStatus()
    return angelsmods and angelsmods.trigger and angelsmods.trigger.enable_auto_barreling
end

local function CreateFillBarrelRecipe(item, fluid)
    local recipe = {
        type = "recipe",
        name = "fill-" .. item.name,
        localised_name = {"recipe-name.fill-barrel", {"fluid-name." .. fluid.name }},
        category = GetRecipeCategory(),
        energy_required = kEnergyPerFill,
        subgroup = "fill-barrel",
        order = "b[fill-" ..item.name .. "]",
        enabled = false,
        hidden = GetHiddenStatus(),
        icons = GenerateFillBarrelIcons(fluid),
        icon_size = 32,
        ingredients = {
            { type = "fluid", name = fluid.name, amount = kFluidPerBarrel, catalyst_amount = kFluidPerBarrel },
            { type = "item", name = kEmptyBarrelName, amount = 1, catalyst_amount = 1 }
        },
        results = {
            { type = "item", name = item.name, amount = 1, catalyst_amount = 1 }
        },
        allow_decomposition = false
    }

    data:extend({recipe})
    return recipe
end

local function CreateEmptyBarrelRecipe(item, fluid)
    local recipe = {
        type = "recipe",
        name = "empty-" .. item.name,
        localised_name = {"recipe-name.empty-filled-barrel", {"fluid-name." .. fluid.name}},
        category = GetRecipeCategory(),
        energy_required = kEnergyPerEmpty,
        subgroup = "empty-barrel",
        order = "c[empty-" .. item.name .. "]",
        enabled = false,
        hidden = GetHiddenStatus(),
        icons = GenerateEmptyBarrelIcons(fluid),
        icon_size = 32,
        ingredients = {
            { type = "item", name = item.name, amount = 1, catalyst_amount = 1}
        },
        results = {
            { type = "fluid", name = fluid.name, amount = kFluidPerBarrel, catalyst_amount = kFluidPerBarrel },
            { type = "item", name = kEmptyBarrelName, amount = 1, catalyst_amount = 1 }
        },
        allow_decomposition = false
    }

    data:extend({recipe})
    return recipe
end

local function GetRecipesForBarrel(name)
    return data.raw.recipe["fill-" .. name],
           data.raw.recipe["empty-" .. name]
end

local function GetOrCreateBarrelRecipes(item, fluid)
    local fill_recipe, empty_recipe = GetRecipesForBarrel(item.name)

    if not fill_recipe then
        fill_recipe = CreateFillBarrelRecipe(item, fluid)
    end

    if not empty_recipe then
        empty_recipe = CreateEmptyBarrelRecipe(item, fluid)
    end

    return fill_recipe, empty_recipe
end

local function AddBarrelToTechnology(fill_recipe, empty_recipe, technology)
    local unlock_key = "unlock-recipe"
    local effects = technology.effects or {}

    local add_fill_recipe = true
    local add_empty_recipe = true

    for k,v in pairs(effects) do
        if k == unlock_key then
            local recipe = v.recipe
            if recipe == fill_recipe.name then add_fill_recipe = false
            elseif recipe == empty_recipe.name then add_empty_recipe = false end
        end
    end

    if add_fill_recipe then
        table.insert(effects, { type = unlock_key , recipe = fill_recipe.name })
    end

    if add_empty_recipe then
        table.insert(effects, { type = unlock_key , recipe = empty_recipe.name })
    end
end

function AddBarrelItemAndRecipes(fluid)
    if not fluid then return end

    local barrel_name = fluid.name .. "-barrel"
    local empty_barrel_item = data.raw.item[kEmptyBarrelName]

    local barrel_item =
        GetOrCreateBarrelItem(barrel_name, fluid, empty_barrel_item)

    local barrel_fill_recipe, barrel_empty_recipe =
        GetOrCreateBarrelRecipes(barrel_item, fluid)

    AddBarrelToTechnology(barrel_fill_recipe, barrel_empty_recipe, data.raw.technology["fluid-handling"])
end

function AddBarrelItemAndRecipesForList(fluids)
    for _, fluid_name in ipairs(fluids) do
        AddBarrelItemAndRecipes(data.raw.fluid[fluid_name])
    end
end
