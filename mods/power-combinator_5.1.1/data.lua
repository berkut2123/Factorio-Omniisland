
local function times(n,v)
    local r = {} for i = 1,n do r[i] = v end return r
end

local function deepmerge(t,o)
    for k,v in pairs(o) do
        if type(v) == 'table' and type(t[k]) == 'table' then
            v = deepmerge(t[k], v)
        end
        t[k] = v
    end
    return t
end

local function set(t,k,v) t[k] = v return t end

local function rm_prop(key, entity)
    return set(entity,key,nil)
end

local function rm_icon(entity)
    return rm_prop('icon', rm_prop('icon_size', entity))
end

local function iter_layers(entity, f)
    for _, sprite in pairs(entity.sprites or {}) do
        if sprite.layers then
            iter_layers({sprites=sprite.layers}, f)
        else
            f(sprite)
            if sprite.hr_version then
                f(sprite.hr_version)
            end
        end
    end
    return entity
end

local function tint_hint(entity, tint)
    return iter_layers(entity, function (sprite)
        sprite.tint = tint
    end)
end

local function rescale(entity, scale)
    for _,offset in pairs(entity.activity_led_light_offsets or {}) do
        for k,v in pairs(offset) do
            offset[k] = v * scale
        end
    end
    for _,connection in pairs(entity.circuit_wire_connection_points or {}) do
        for _,point in pairs(connection) do
            for _,vector in pairs(point) do
                for k,v in pairs(vector) do
                    vector[k] = v * scale
                end
            end
        end
    end
    iter_layers({sprites={{layers=entity.activity_led_sprites}}}, function (sprite)
        sprite.scale = (sprite.scale or 1) * scale
        for k,v in pairs(sprite.shift or {}) do
            sprite.shift[k] = v * scale
        end
    end)
    return iter_layers(entity, function (sprite)
        sprite.scale = (sprite.scale or 1) * scale
    end)
end

--------------------------------------------------------------------------------

local color = {
    yellow = {r=1,g=1,b=0,a=1},
    dark   = {r=0,g=0,b=0,a=1},
}

local hidden = {"placeable-neutral", "not-deconstructable", "not-blueprintable", "not-on-map", "hide-alt-info", "hidden", "no-copy-paste", "not-in-kill-statistics"}

local transparent = {
    filename = "__power-combinator__/graphics/transparent.png",
    priority = "extra-high",
    width = 1,
    height = 1,
    frame_count = 1,
    axially_symmetrical = false,
    direction_count = 1,
}
local transparent4 = set(table.deepcopy(transparent),'direction_count',4)

local function fix_copper(point)
    point = table.deepcopy(point)
    for _,layer in pairs(point) do
        layer.copper = layer.red
    end
    return times(4,point)
end


local steam = data.raw['fluid']['steam']
local lamp = data.raw['lamp']['small-lamp']
local pole = data.raw['electric-pole']['small-electric-pole']
local cc = data.raw["constant-combinator"]["constant-combinator"]


local icons = {
    internal = {
        {icon = steam.icon, icon_size = steam.icon_size, tint = color.yellow},
        {icon = "__power-combinator__/graphics/power-production.png", icon_size = 64, scale = 0.5, tint = color.dark},
    },
    combinator = {
        {icon = cc.icon, icon_size = cc.icon_size, tint = color.yellow},
        {icon = "__power-combinator__/graphics/power-production.png", icon_size = 64, scale = 0.5},
    },
    combinator2 = {
        {icon = cc.icon, icon_size = cc.icon_size, tint = color.yellow},
        {icon = "__power-combinator__/graphics/power-production.png", icon_size = 64, scale = 0.5},
        {
            icon = "__core__/graphics/icons/search-white.png",
            icon_size = 32,
            shift = {-10, 10},
            scale = 0.4,
        },
    },
}


data:extend{


    -- entity --------------------------------------------------------------


    tint_hint(rm_icon(deepmerge(table.deepcopy(cc), {
        name = "power-combinator",
        minable = {result = "power-combinator"},
        flags = {"not-rotatable", unpack(cc.flags)},
        fast_replaceable_group = "power-combinator",
        item_slot_count = 5,
        icons = icons.combinator,
        order = "z-c[combinator]-c[constant-combinator]-p[power-combinator]-a[MK1]",
    })), color.yellow),

    rescale(tint_hint(rm_icon(deepmerge(table.deepcopy(cc), {
        name = "power-combinator-MK2",
        minable = {result = "power-combinator-MK2"},
        flags = {"not-rotatable", unpack(cc.flags)},
        fast_replaceable_group = "power-combinator",
        item_slot_count = 6,
        icons = icons.combinator2,
        collision_box = {{-0.75, -0.75}, {0.75, 0.75}},
        selection_box = {{-1, -1}, {1, 1}},
        order = "z-c[combinator]-c[constant-combinator]-p[power-combinator]-b[MK2]",
    })), color.yellow), 2),

    {   type = "lamp", -- has energy satisfaction
        name = "power-combinator-meter-satisfaction",
        collision_mask = {"ghost-layer"},
        max_health = lamp.max_health,
        selectable_in_game = false,
        light = {intensity = 0, size = 0},
        flags = {"not-selectable-in-game", unpack(hidden)},
        order = "z",
        glow_size = 0,
        glow_color_intensity = 0,
        signal_to_color_mapping = {},
        collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
--         selection_box = {{-1, -1}, {0, 0}},
        icons = icons.internal,
        picture_on  = {layers={transparent}},
        picture_off = {layers={transparent}},
        energy_usage_per_tick = "0.00000000001W",
        energy_source = {
            type = "electric",
            usage_priority = "primary-input",
            render_no_power_icon = false,
        },
        circuit_wire_connection_point = table.deepcopy(lamp.circuit_wire_connection_point),
        circuit_connector_sprites = table.deepcopy(lamp.circuit_connector_sprites),
        circuit_wire_max_distance = 0.5,
    },

    {   type = "electric-pole", -- has electric_network_statistics
        name = "power-combinator-meter-network",
        collision_mask = {"ghost-layer"},
        max_health = pole.max_health,
        flags = hidden,
        order = "z",
        supply_area_distance = 0.5,
        maximum_wire_distance = 9,
        track_coverage_during_build_by_moving = false,
        draw_circuit_wires = false,
        collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
        selection_box = {{-0.2, 0.1}, {0.7, 0.7}},
        connection_points = fix_copper(lamp.circuit_wire_connection_point),
        radius_visualisation_picture = table.deepcopy(pole.radius_visualisation_picture),
        water_reflection = {pictures = transparent},
        icons = icons.internal,
        pictures = {layers = {
            transparent4,
            set(table.deepcopy(transparent4),'draw_as_shadow',true),
        }},
    },


    -- item ----------------------------------------------------------------


    rm_icon(deepmerge(table.deepcopy(data.raw.item["constant-combinator"]), {
        name = "power-combinator",
        place_result = "power-combinator",
        order = "c[combinators]-c[constant-combinator]-p[power-combinator]-a[MK1]",
        icons = icons.combinator,
    })),

    rm_icon(deepmerge(table.deepcopy(data.raw.item["constant-combinator"]), {
        name = "power-combinator-MK2",
        place_result = "power-combinator-MK2",
        order = "c[combinators]-c[constant-combinator]-p[power-combinator]-b[MK2]",
        icons = icons.combinator2,
    })),


    -- recipe --------------------------------------------------------------


    {   type = "recipe",
        name = "power-combinator",
        energy_required = 15,
        ingredients = {
            {"red-wire", 1},
            {"small-lamp", 2},
            {"constant-combinator", 2},
        },
        result = "power-combinator",
        enabled = false,
    },

    {   type = "recipe",
        name = "power-combinator-MK2",
        energy_required = 30,
        ingredients = {
            {"red-wire", 2},
            {"power-combinator", 2},
            {"constant-combinator", 2},
            {"advanced-circuit", 4},
        },
        result = "power-combinator-MK2",
        enabled = false,
    },


    -- technology ----------------------------------------------------------


    {   type = "technology",
        name = "power-combinator",
        prerequisites = {
            "circuit-network",
            "electric-energy-distribution-1",
            "optics",
        },
        icon = "__power-combinator__/graphics/technology.png",
        icon_size = 128,
        order = "a-h-d-a",
        effects = {
            {type = "unlock-recipe", recipe = "power-combinator"},
        },
        unit = {
            time = 30,
            count = 50,
            ingredients = {
                {"automation-science-pack", 1},
                {  "logistic-science-pack", 1},
            },
        },
    },

    {   type = "technology",
        name = "power-combinator-MK2",
        prerequisites = {
            "power-combinator",
            "electric-energy-distribution-2",
        },
        icon = "__power-combinator__/graphics/technology2.png",
        icon_size = 128,
        order = "a-h-d-a",
        effects = {
            {type = "unlock-recipe", recipe = "power-combinator-MK2"},
        },
        unit = {
            time = 45,
            count = 100,
            ingredients = {
                {"automation-science-pack", 1},
                {  "logistic-science-pack", 1},
                {  "chemical-science-pack", 1},
            },
        },
    },


    -- achievement ---------------------------------------------------------


    {   type = "research-achievement",
        name = "power-combinator-research",
        technology = "power-combinator",
        order = "a[progress]-o[combinator]-p[power]-[MK1]",
        icon = "__power-combinator__/graphics/research-achievement.png",
        icon_size = 128,
    },

    {   type = "research-achievement",
        name = "power-combinator-research2",
        technology = "power-combinator-MK2",
        order = "a[progress]-o[combinator]-p[power]-[MK2]",
        icon = "__power-combinator__/graphics/research2-achievement.png",
        icon_size = 128,
    },


    -- signal --------------------------------------------------------------


    {   type = "virtual-signal",
        name = "power-consumption",
        order = "a[power]-a[cur]-a[consumption]",
        subgroup = "virtual-signal-special",
        icon = "__power-combinator__/graphics/power-consumption.png",
        icon_size = 64,
    },

    {   type = "virtual-signal",
        name = "power-production",
        order = "a[power]-a[cur]-b[production]",
        subgroup = "virtual-signal-special",
        icon = "__power-combinator__/graphics/power-production.png",
        icon_size = 64,
    },

    {   type = "virtual-signal",
        name = "power-max-consumption",
        order = "a[power]-m[max]-a[consumption]",
        subgroup = "virtual-signal-special",
        icon = "__power-combinator__/graphics/power-max-consumption.png",
        icon_size = 64,
    },

    {   type = "virtual-signal",
        name = "power-max-production",
        order = "a[power]-m[max]-b[production]",
        subgroup = "virtual-signal-special",
        icon = "__power-combinator__/graphics/power-max-production.png",
        icon_size = 64,
    },


    -- tips and tricks -----------------------------------------------------


    {   type = "tips-and-tricks-item",
        name = "power-combinator",
        tag = "[item=power-combinator]",
        category = "circuit-network",
        dependencies = {"circuit-network"},
        order = "b",
        indent = 1,
        trigger = {
            type = "sequence",
            triggers = {
                {
                    type = "research",
                    technology = "power-combinator",
                },
                {
                    type = "time-elapsed",
                    ticks = 60 * 60 * 5,
                },
            },
        },
        simulation = {
            save = "__power-combinator__/scripts/simulation.zip",
            init_file = "__power-combinator__/scripts/simulation.lua",
            generate_map = false,
            checkboard = true,
        },
    },

    {
        type = "flying-text",
        name = "power-combinator-text",
        flags = {"not-on-map", "placeable-off-grid"},
        time_to_live = 31,
        speed = 0,
    },

}


    -- shared with capacity-combinator -------------------------------------


 do local circuit = data.raw["tips-and-tricks-item"]["circuit-network"]
    circuit.category = "circuit-network"
    circuit.order = "a"
    circuit.is_title = true
end

if not data.raw["tips-and-tricks-item-category"]["circuit-network"] then data:extend{
    {   type = "tips-and-tricks-item-category",
        name = "circuit-network",
        order = "z-[circuit-network]",
    },
} end

if not data.raw["virtual-signal"]["power-factor"] then data:extend{
    {   type = "virtual-signal",
        name = "power-factor",
        order = "a[power]-z[factor]",
        subgroup = "virtual-signal-special",
        icon = "__power-combinator__/graphics/power-factor.png",
        icon_size = 64,
    },
} end
