local function deepmerge(t,o)
    for k,v in pairs(o) do
        if type(v) == 'table' and type(t[k]) == type(v) then
            v = deepmerge(t[k], v)
        end
        t[k] = v
    end
    return t
end


local function rm_icon(entity)
    entity.icon_size = nil
    entity.icon = nil
    return entity
end

local function tint_hint(entity, tint)
    for _, sprite in pairs(entity.sprites) do
        if sprite.layers then
            tint_hint({sprites=sprite.layers}, tint)
        else
            sprite.tint = tint
            if sprite.hr_version then
                sprite.hr_version.tint = tint
            end
        end
    end
    return entity
end

--------------------------------------------------------------------------------


local cc = data.raw["constant-combinator"]["constant-combinator"]
data:extend({


    -- entity --------------------------------------------------------------


    tint_hint(rm_icon(deepmerge(table.deepcopy(cc), {
        name = "power-combinator",
        minable = {result = "power-combinator"},
        item_slot_count = 2,
        icons = {
            {icon = cc.icon, icon_size = cc.icon_size, tint = {r=1,g=1,b=0,a=1}},
            {icon = "__power-combinator__/graphics/power-production.png", icon_size = 64, scale = 0.5},
        },
    })), {r=1,g=1,b=0,a=1}),


    -- item ----------------------------------------------------------------


    rm_icon(deepmerge(table.deepcopy(data.raw.item["constant-combinator"]), {
        name = "power-combinator",
        place_result = "power-combinator",
        order = "power-combinator",
        icons = {
            {icon = cc.icon, icon_size = cc.icon_size, tint = {r=1,g=1,b=0,a=1}},
            {icon = "__power-combinator__/graphics/power-production.png", icon_size = 64, scale = 0.5},
        },
    })),


    -- recipe --------------------------------------------------------------


    {   type = "recipe",
        name = "power-combinator",
        energy_required = 5,
        ingredients = {
            {"advanced-circuit", 5},
            {"constant-combinator", 2},
        },
        result = "power-combinator",
        enabled = false,
    },


    -- technology ----------------------------------------------------------


    {   type = "technology",
        name = "power-combinator",
        prerequisites = {
            "circuit-network",
            "advanced-electronics",
            "electric-energy-distribution-2",
            "production-science-pack",
        },
        icon = "__power-combinator__/graphics/technology.png",
        icon_size = 128,
        order = "a-h-d",
        effects = {
            {type = "unlock-recipe", recipe = "power-combinator"},
        },
        unit = {
            time = 50,
            count = 500,
            ingredients = {
                {"automation-science-pack", 4},
                {  "logistic-science-pack", 3},
                {  "chemical-science-pack", 2},
                {"production-science-pack", 1},
            },
        },
    },


    -- signal --------------------------------------------------------------


    {   type = "virtual-signal",
        name = "power-consumption",
        order = "power-consumption",
        subgroup = "virtual-signal-special",
        icon = "__power-combinator__/graphics/power-consumption.png",
        icon_size = 64,
    },

    {   type = "virtual-signal",
        name = "power-production",
        order = "power-production",
        subgroup = "virtual-signal-special",
        icon = "__power-combinator__/graphics/power-production.png",
        icon_size = 64,
    },



})
