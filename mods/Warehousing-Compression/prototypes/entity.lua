local non_logistic_tint = { r = 255, g = 255, b = 255, a = 0.05 }
local active_tint = { r = 140, g = 0, b = 210, a = 0.05 }
local passive_tint = { r = 255, g = 0, b = 0, a = 0.05 }
local storage_tint = { r = 255, g = 255, b = 0, a = 0.05 }
local buffer_tint = { r = 0, g = 255, b = 0, a = 0.05 }
local requester_tint = { r = 0, g = 0, b = 255, a = 0.05 }

local function shift(modifier, value)
    return modifier + value
end

-- cnc = circuit_network_connection
local warehouse_basic_cnc_shift_x = 1.6
local warehouse_basic_cnc_shift_y = 0.6
local warehouse_small_cnc_shift_x = 1.05
local warehouse_small_cnc_shift_y = 0.35
local warehouse_tiny_cnc_shift_x = 0.6
local warehouse_tiny_cnc_shift_y = 0.1
local storehouse_basic_cnc_shift_x = 0.15
local storehouse_basic_cnc_shift_y = -0.35
local storehouse_small_cnc_shift_x = -0.3
local storehouse_small_cnc_shift_y = -0.55
local storehouse_tiny_cnc_shift_x = -0.55
local storehouse_tiny_cnc_shift_y = -0.75

local function circuitConnectorSprites(shift_x, shift_y)
    local ccs = table.deepcopy(data.raw["container"]["steel-chest"].circuit_connector_sprites)
    ccs.led_light = { intensity = 0.8, size = 0.9 }
    ccs.blue_led_light_offset = { 0.609375, 0.890625 }
    ccs.red_green_led_light_offset = { 0.59375, 0.78125 }
    ccs.connector_main =
    {
        filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04a-base-sequence.png",
        height = 50,
        priority = "low",
        scale = 0.5,
        shift = { shift(shift_x, 0.578125), shift(shift_y, 0.625) },
        width = 52,
        x = 364,
        y = 50,
    }
    ccs.connector_shadow =
    {
        draw_as_shadow = true,
        filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04b-base-shadow-sequence.png",
        height = 46,
        priority = "low",
        scale = 0.5,
        shift = { shift(shift_x, 0.71875), shift(shift_y, 0.875) },
        width = 62,
        x = 434,
        y = 46,
    }
    ccs.led_red =
    {
        filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04i-red-LED-sequence.png",
        height = 46,
        priority = "low",
        scale = 0.5,
        shift = { shift(shift_x, 0.578125), shift(shift_y, 0.59375) },
        width = 48,
        x = 336,
        y = 46,
    }
    ccs.led_green =
    {
        filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04h-green-LED-sequence.png",
        height = 46,
        priority = "low",
        scale = 0.5,
        shift = { shift(shift_x, 0.578125), shift(shift_y, 0.59375) },
        width = 48,
        x = 336,
        y = 46,
    }
    ccs.led_blue =
    {
        filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04e-blue-LED-on-sequence.png",
        height = 60,
        priority = "low",
        scale = 0.5,
        shift = { shift(shift_x, 0.578125), shift(shift_y, 0.59375) },
        width = 60,
        x = 420,
        y = 60,
    }
    ccs.led_blue_off =
    {
        filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04f-blue-LED-off-sequence.png",
        height = 44,
        priority = "low",
        scale = 0.5,
        shift = { shift(shift_x, 0.578125), shift(shift_y, 0.59375) },
        width = 46,
        x = 322,
        y = 44,
    }
    ccs.wire_pins =
    {
        filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04c-wire-sequence.png",
        height = 58,
        priority = "low",
        scale = 0.5,
        shift = { shift(shift_x, 0.578125), shift(shift_y, 0.59375) },
        width = 62,
        x = 434,
        y = 58,
    }
    ccs.wire_pins_shadow =
    {
        draw_as_shadow = true,
        filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04d-wire-shadow-sequence.png",
        height = 54,
        priority = "low",
        scale = 0.5,
        shift = { shift(shift_x, 0.734375), shift(shift_y, 0.71875) },
        width = 70,
        x = 490,
        y = 54,
    }
    return ccs
end

local warehouse_basic_cs = circuitConnectorSprites(warehouse_basic_cnc_shift_x, warehouse_basic_cnc_shift_y)
local storehouse_basic_cs = circuitConnectorSprites(storehouse_basic_cnc_shift_x, storehouse_basic_cnc_shift_y)
local warehouse_small_cs = circuitConnectorSprites(warehouse_small_cnc_shift_x, warehouse_small_cnc_shift_y)
local storehouse_small_cs = circuitConnectorSprites(storehouse_small_cnc_shift_x, storehouse_small_cnc_shift_y)
local warehouse_tiny_cs = circuitConnectorSprites(warehouse_tiny_cnc_shift_x, warehouse_tiny_cnc_shift_y)
local storehouse_tiny_cs = circuitConnectorSprites(storehouse_tiny_cnc_shift_x, storehouse_tiny_cnc_shift_y)

data.raw.container["warehouse-basic"].circuit_connector_sprites = warehouse_basic_cs
data.raw.container["warehouse-basic"].circuit_wire_connection_point.wire.red = { shift(warehouse_basic_cnc_shift_x, 0.675), shift(warehouse_basic_cnc_shift_y, 0.775) }
data.raw.container["warehouse-basic"].circuit_wire_connection_point.wire.green = { shift(warehouse_basic_cnc_shift_x, 0.875), shift(warehouse_basic_cnc_shift_y, 0.825) }
data.raw.container["warehouse-basic"].circuit_wire_connection_point.shadow.red = { shift(warehouse_basic_cnc_shift_x, 0.85), shift(warehouse_basic_cnc_shift_y, 0.9) }
data.raw.container["warehouse-basic"].circuit_wire_connection_point.shadow.green = { shift(warehouse_basic_cnc_shift_x, 1.05), shift(warehouse_basic_cnc_shift_y, 0.95) }
data.raw.container["storehouse-basic"].circuit_connector_sprites = storehouse_basic_cs
data.raw.container["storehouse-basic"].circuit_wire_connection_point.wire.red = { shift(storehouse_basic_cnc_shift_x, 0.675), shift(storehouse_basic_cnc_shift_y, 0.775) }
data.raw.container["storehouse-basic"].circuit_wire_connection_point.wire.green = { shift(storehouse_basic_cnc_shift_x, 0.875), shift(storehouse_basic_cnc_shift_y, 0.825) }
data.raw.container["storehouse-basic"].circuit_wire_connection_point.shadow.red = { shift(storehouse_basic_cnc_shift_x, 0.85), shift(storehouse_basic_cnc_shift_y, 0.9) }
data.raw.container["storehouse-basic"].circuit_wire_connection_point.shadow.green = { shift(storehouse_basic_cnc_shift_x, 1.05), shift(storehouse_basic_cnc_shift_y, 0.95) }

local function createContainer(name, size, connector, shift_x, shift_y, mask_tint)
    local cc = table.deepcopy(data.raw["container"][name .. "-basic"])
    cc.name = name .. "-" .. size
    cc.icons = {
        { icon = "__Warehousing__/graphics/icons/" .. name .. "-basic.png" },
        { icon = "__Warehousing-Compression__/graphics/icons/" .. size .. "-mask.png", tint = mask_tint },
    }
    if name == "warehouse" and size == "small" then
        cc.collision_box = { { -2.1, -2.1 }, { 2.1, 2.1 } }
        cc.selection_box = { { -2.4, -2.4 }, { 2.4, 2.4 } }
    elseif name == "warehouse" and size == "tiny" then
        cc.collision_box = { { -1.6, -1.6 }, { 1.6, 1.6 } }
        cc.selection_box = { { -1.9, -1.9 }, { 1.9, 1.9 } }
    elseif name == "storehouse" and size == "small" then
        cc.collision_box = { { -0.65, -0.65 }, { 0.65, 0.65 } }
        cc.selection_box = { { -0.95, -0.95 }, { 0.95, 0.95 } }
    elseif name == "storehouse" and size == "tiny" then
        cc.collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } }
        cc.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
    end
    if name == "warehouse" and size == "small" then
        cc.picture = {
            filename = "__Warehousing-Compression__/graphics/entity/" .. cc.name .. ".png",
            width = 210,
            height = 190,
            shift = { 0.75, -0.2 }
        }
    elseif name == "warehouse" and size == "tiny" then
        cc.picture = {
            filename = "__Warehousing-Compression__/graphics/entity/" .. cc.name .. ".png",
            width = 160,
            height = 140,
            shift = { 0.6, -0.1 }
        }
    elseif name == "storehouse" and size == "small" then
        cc.picture = {
            filename = "__Warehousing-Compression__/graphics/entity/" .. cc.name .. ".png",
            width = 80,
            height = 62,
            shift = { 0.25, 0.0 }
        }
    elseif name == "storehouse" and size == "tiny" then
        cc.picture = {
            filename = "__Warehousing-Compression__/graphics/entity/" .. cc.name .. ".png",
            width = 35,
            height = 27,
            shift = { 0.1, 0.0 }
        }
    end
    cc.circuit_connector_sprites = connector
    cc.circuit_wire_connection_point.wire.red = { shift(shift_x, 0.675), shift(shift_y, 0.775) }
    cc.circuit_wire_connection_point.wire.green = { shift(shift_x, 0.875), shift(shift_y, 0.825) }
    cc.circuit_wire_connection_point.shadow.red = { shift(shift_x, 0.85), shift(shift_y, 0.9) }
    cc.circuit_wire_connection_point.shadow.green = { shift(shift_x, 1.05), shift(shift_y, 0.95) }
    return cc
end

local warehouse_small = createContainer("warehouse", "small", warehouse_small_cs, warehouse_small_cnc_shift_x, warehouse_small_cnc_shift_y, non_logistic_tint)
local warehouse_tiny = createContainer("warehouse", "tiny", warehouse_tiny_cs, warehouse_tiny_cnc_shift_x, warehouse_tiny_cnc_shift_y, non_logistic_tint)
local storehouse_small = createContainer("storehouse", "small", storehouse_small_cs, storehouse_small_cnc_shift_x, storehouse_small_cnc_shift_y, non_logistic_tint)
local storehouse_tiny = createContainer("storehouse", "tiny", storehouse_tiny_cs, storehouse_tiny_cnc_shift_x, storehouse_tiny_cnc_shift_y, non_logistic_tint)

data:extend({
    warehouse_small,
    storehouse_small,
    warehouse_tiny,
    storehouse_tiny,
})

local basic_logistic_warehouse_wcp =
{
    shadow =
    {
        red = { 2.52, 0.65 },
        green = { 2.01, 0.65 },
    },
    wire =
    {
        red = { 2.22, 0.32 },
        green = { 1.71, 0.32 },
    },
}
local basic_logistic_storehouse_wcp =
{
    shadow =
    {
        red = { 0.56, -0.6 },
        green = { 0.26, -0.6 },
    },
    wire =
    {
        red = { 0.16, -0.9 },
        green = { -0.16, -0.9 },
    },
}

for k, _ in pairs(data.raw["logistic-container"]) do
    if (string.match(k, "*storehouse-*") == k) then
        table.insert(data.raw["logistic-container"][k], { circuit_wire_connection_point = basic_logistic_storehouse_wcp })
    end
    if (string.match(k, "*warehouse-*") == k) then
        table.insert(data.raw["logistic-container"][k], { circuit_wire_connection_point = basic_logistic_warehouse_wcp })
    end
end

local function createLogisticContainer(name, size, logistic_type, wire_connection, mask_tint)
    local clc = table.deepcopy(data.raw["logistic-container"][name .. "-" .. logistic_type])
    clc.name = name .. "-" .. logistic_type .. "-" .. size
    clc.minable.result = clc.name
    clc.icons = {
        { icon = "__Warehousing__/graphics/icons/" .. name .. "-" .. logistic_type .. ".png" },
        { icon = "__Warehousing-Compression__/graphics/icons/" .. size .. "-mask.png", tint = mask_tint },
    }
    if name == "warehouse" and size == "small" then
        clc.collision_box = { { -2.1, -2.1 }, { 2.1, 2.1 } }
        clc.selection_box = { { -2.4, -2.4 }, { 2.4, 2.4 } }
    elseif name == "warehouse" and size == "tiny" then
        clc.collision_box = { { -1.6, -1.6 }, { 1.6, 1.6 } }
        clc.selection_box = { { -1.9, -1.9 }, { 1.9, 1.9 } }
    elseif name == "storehouse" and size == "small" then
        clc.collision_box = { { -0.65, -0.65 }, { 0.65, 0.65 } }
        clc.selection_box = { { -0.95, -0.95 }, { 0.95, 0.95 } }
    elseif name == "storehouse" and size == "tiny" then
        clc.collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } }
        clc.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
    end
    if name == "warehouse" and size == "small" then
        clc.picture = {
            filename = "__Warehousing-Compression__/graphics/entity/" .. clc.name .. ".png",
            width = 210,
            height = 190,
            shift = { 0.75, -0.2 }
        }
    elseif name == "warehouse" and size == "tiny" then
        clc.picture = {
            filename = "__Warehousing-Compression__/graphics/entity/" .. clc.name .. ".png",
            width = 160,
            height = 140,
            shift = { 0.6, -0.1 }
        }
    elseif name == "storehouse" and size == "small" then
        clc.picture = {
            filename = "__Warehousing-Compression__/graphics/entity/" .. clc.name .. ".png",
            width = 80,
            height = 62,
            shift = { 0.25, 0.0 }
        }
    elseif name == "storehouse" and size == "tiny" then
        clc.picture = {
            filename = "__Warehousing-Compression__/graphics/entity/" .. clc.name .. ".png",
            width = 35,
            height = 27,
            shift = { 0.1, 0.0 }
        }
    end
    clc.circuit_connector_sprites = nil
    clc.circuit_wire_connection_point = wire_connection
    return clc
end

local small_logistic_warehouse_wcp =
{
    shadow =
    {
        red = { 2.0, 0.6 },
        green = { 1.6, 0.6 }
    },
    wire =
    {
        red = { 1.75, 0.3 },
        green = { 1.35, 0.3 }
    }
}
local tiny_logistic_warehouse_wcp =
{
    shadow =
    {
        red = { 1.55, 0.5 },
        green = { 1.25, 0.5 }
    },
    wire =
    {
        red = { 1.35, 0.3 },
        green = { 1.05, 0.3 }
    }
}
local small_logistic_storehouse_wcp =
{
    shadow =
    {
        red = { .56, -0.3 },
        green = { .26, -0.3 }
    },
    wire =
    {
        red = { 0.16, -0.5 },
        green = { -0.16, -0.5 }
    }
}
local tiny_logistic_storehouse_wcp =
{
    shadow =
    {
        red = { .56, -0.1 },
        green = { .26, -0.1 }
    },
    wire =
    {
        red = { 0.16, -0.2 },
        green = { -0.16, -0.2 }
    }
}

local storehouse_active_provider_small = createLogisticContainer("storehouse", "small", "active-provider", small_logistic_storehouse_wcp, active_tint)
local storehouse_passive_provider_small = createLogisticContainer("storehouse", "small", "passive-provider", small_logistic_storehouse_wcp, passive_tint)
local storehouse_storage_small = createLogisticContainer("storehouse", "small", "storage", small_logistic_storehouse_wcp, storage_tint)
local storehouse_buffer_small = createLogisticContainer("storehouse", "small", "buffer", small_logistic_storehouse_wcp, buffer_tint)
local storehouse_requester_small = createLogisticContainer("storehouse", "small", "requester", basic_logistic_storehouse_wcp, requester_tint)
local warehouse_active_provider_small = createLogisticContainer("warehouse", "small", "active-provider", small_logistic_warehouse_wcp, active_tint)
local warehouse_passive_provider_small = createLogisticContainer("warehouse", "small", "passive-provider", small_logistic_warehouse_wcp, passive_tint)
local warehouse_storage_small = createLogisticContainer("warehouse", "small", "storage", small_logistic_warehouse_wcp, storage_tint)
local warehouse_buffer_small = createLogisticContainer("warehouse", "small", "buffer", small_logistic_warehouse_wcp, buffer_tint)
local warehouse_requester_small = createLogisticContainer("warehouse", "small", "requester", small_logistic_warehouse_wcp, requester_tint)

local storehouse_active_provider_tiny = createLogisticContainer("storehouse", "tiny", "active-provider", tiny_logistic_storehouse_wcp, active_tint)
local storehouse_passive_provider_tiny = createLogisticContainer("storehouse", "tiny", "passive-provider", tiny_logistic_storehouse_wcp, passive_tint)
local storehouse_storage_tiny = createLogisticContainer("storehouse", "tiny", "storage", tiny_logistic_storehouse_wcp, storage_tint)
local storehouse_buffer_tiny = createLogisticContainer("storehouse", "tiny", "buffer", tiny_logistic_storehouse_wcp, buffer_tint)
local storehouse_requester_tiny = createLogisticContainer("storehouse", "tiny", "requester", tiny_logistic_storehouse_wcp, requester_tint)
local warehouse_active_provider_tiny = createLogisticContainer("warehouse", "tiny", "active-provider", tiny_logistic_warehouse_wcp, active_tint)
local warehouse_passive_provider_tiny = createLogisticContainer("warehouse", "tiny", "passive-provider", tiny_logistic_warehouse_wcp, passive_tint)
local warehouse_storage_tiny = createLogisticContainer("warehouse", "tiny", "storage", tiny_logistic_warehouse_wcp, storage_tint)
local warehouse_buffer_tiny = createLogisticContainer("warehouse", "tiny", "buffer", tiny_logistic_warehouse_wcp, buffer_tint)
local warehouse_requester_tiny = createLogisticContainer("warehouse", "tiny", "requester", tiny_logistic_warehouse_wcp, requester_tint)

data:extend({
    storehouse_active_provider_small,
    storehouse_passive_provider_small,
    storehouse_storage_small,
    storehouse_buffer_small,
    storehouse_requester_small,
    storehouse_active_provider_tiny,
    storehouse_passive_provider_tiny,
    storehouse_storage_tiny,
    storehouse_buffer_tiny,
    storehouse_requester_tiny,
    warehouse_active_provider_small,
    warehouse_passive_provider_small,
    warehouse_storage_small,
    warehouse_buffer_small,
    warehouse_requester_small,
    warehouse_active_provider_tiny,
    warehouse_passive_provider_tiny,
    warehouse_storage_tiny,
    warehouse_buffer_tiny,
    warehouse_requester_tiny,
})
