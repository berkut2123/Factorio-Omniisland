
local costMult = settings.startup['bigger-batteries-cost-mult'].value
local costAmount = settings.startup['bigger-batteries-cost-amount'].value
local capacityMult = settings.startup['bigger-batteries-capacity-mult'].value
local technologyMult = settings.startup['bigger-batteries-technology-mult'].value
local tierAmount = settings.startup['bigger-batteries-tier-amount'].value
local packPerTiers = settings.startup['bigger-batteries-pack-per-tiers'].value
local existingTierAmount = 2

--[[ Returns the 'unit' field of a technology at a given tier ]]
local function getTechnologyCost(tier, prev)
    local packs = {
        'automation-science-pack',
        'logistic-science-pack',
        'chemical-science-pack',
        'production-science-pack',
        'utility-science-pack',
        'space-science-pack',
    }
    tier = tier - existingTierAmount

    local costs = {}
    for i, pack in ipairs(packs) do
        if (4 + (tier / packPerTiers)) > i then
            table.insert(costs, { pack, 1 })
        end
    end

    return {
        count = math.floor(prev.count * technologyMult),
        ingredients = costs,
        time = prev.time,
    }
end

local tiers = {
    [1] = {
        item = "battery-equipment",
        equipment = "battery-equipment",
        recipe = "battery-equipment",
        technology = "battery-equipment",
        capacity = 20000000, -- 20MJ
        flow = 200000000, -- 200MW (capacity * 10)
    },
    [2] = {
        item = "battery-mk2-equipment",
        equipment = "battery-mk2-equipment",
        recipe = "battery-mk2-equipment",
        technology = "battery-mk2-equipment",
        capacity = 100000000, -- 100MJ
        flow = 1000000000, -- 1GW
    },
}

-- Start at 2+1 since 2 tiers already exist
for curTier = existingTierAmount+1, existingTierAmount+tierAmount, 1 do


    -- item icon = 32x32
    -- equipment = 32x64
    -- technology = 128x128

    local name = 'battery-mk' .. tostring(curTier) .. '-equipment'

    local iconItem = '__Bigger Batteries__/graphics/item/' .. curTier .. '.png'
    local iconTechnology = '__Bigger Batteries__/graphics/technology/' .. curTier .. '.png'
    local iconEquipment = '__Bigger Batteries__/graphics/equipment/' .. curTier .. '.png'

    local prevTier = tiers[curTier - 1]
    local newTier = {
        item = name,
        equipment = name,
        recipe = name,
        technology = name,
        capacity = prevTier.capacity * capacityMult,
        flow = prevTier.flow * capacityMult,
    }
    tiers[curTier] = newTier

    -- Item prototype
    local item = util.table.deepcopy(data.raw['item'][prevTier.item])
    item.name = name
    item.icon = iconItem
    item.placed_as_equipment_result = name
    item.order = 'c[battery]-c[battery-equipment-mk' .. curTier .. ']'

    -- Recipe prototype
    local recipe = util.table.deepcopy(data.raw['recipe'][prevTier.recipe])
    recipe.name = name
    --recipe.energy_required = recipe.energy_required * costMult
    recipe.result = name

    local ingredients = {}
    for _, stack in pairs(recipe.ingredients or {}) do
        local name = stack.name or stack[1]
        local amount = stack.amount or stack[2]
        if name == tiers[curTier - 2].item then
            name = prevTier.item
            amount = costAmount
        else
            amount = math.floor(amount * costMult)
        end
        table.insert(ingredients, { name, amount })
    end
    recipe.ingredients = ingredients

    -- Technology prototype
    local technology = util.table.deepcopy(data.raw['technology'][prevTier.technology])
    technology.name = name
    technology.icon = iconTechnology
    technology.icon_size = 128
    technology.prerequisites = { prevTier.technology }
    technology.effects = {
        {
            type = "unlock-recipe",
            recipe = name,
        }
    }
    technology.unit = getTechnologyCost(curTier, technology.unit)
    technology.order = 'g-i-b' .. curTier

    -- Equipment prototype
    local equipment = util.table.deepcopy(data.raw['battery-equipment'][prevTier.equipment])
    equipment.name = name
    equipment.sprite.filename = iconEquipment
    equipment.energy_source.buffer_capacity = tostring(math.floor(newTier.capacity)) .. 'J'
    equipment.energy_source.input_flow_limit = tostring(math.floor(newTier.flow)) .. 'W'
    equipment.energy_source.output_flow_limit = tostring(math.floor(newTier.flow)) .. 'W'

    -- Registering prototypes
    data:extend({
        item,
        recipe,
        technology,
        equipment,
    })
end
