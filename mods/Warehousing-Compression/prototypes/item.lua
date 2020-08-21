local non_logistic_tint = { r = 255, g = 255, b = 255, a = 0.05 }
local active_tint = { r = 140, g = 0, b = 210, a = 0.05 }
local passive_tint = { r = 255, g = 0, b = 0, a = 0.05 }
local storage_tint = { r = 255, g = 255, b = 0, a = 0.05 }
local buffer_tint = { r = 0, g = 255, b = 0, a = 0.05 }
local requester_tint = { r = 0, g = 0, b = 255, a = 0.05 }

local function createItem(name, size, order, mask_tint)
    local i = table.deepcopy(data.raw["item"][name .. "-basic"])
    i.order = order
    i.name = name .. "-" .. size
    i.icons = {
        { icon = "__Warehousing__/graphics/icons/" .. name .. "-basic.png" },
        { icon = "__Warehousing-Compression__/graphics/icons/" .. size .. "-mask.png", tint = mask_tint },
    }
    i.subgroup = "warehousing"
    i.place_result = name .. "-" .. size
    return i
end

local function createLogisticItem(name, logistic_type, size, order, mask_tint)
    local li = table.deepcopy(data.raw["item"][name .. "-" .. logistic_type])
    li.order = order
    li.name = name .. "-" .. logistic_type .. "-" .. size
    li.icons = {
        { icon = "__Warehousing__/graphics/icons/" .. name .. "-" .. logistic_type .. ".png" },
        { icon = "__Warehousing-Compression__/graphics/icons/" .. size .. "-mask.png", tint = mask_tint },
    }
    li.subgroup = "logistic-warehousing"
    li.place_result = name .. "-" .. logistic_type .. "-" .. size
    return li
end

local storehouse_small = createItem("storehouse", "small", "a[storehouse-small]-b", non_logistic_tint)
local storehouse_active_provider_small = createLogisticItem("storehouse", "active-provider", "small", "d[logistic-storehouse-small]", active_tint)
local storehouse_buffer_small = createLogisticItem("storehouse", "buffer", "small", "d[logistic-storehouse-small]", buffer_tint)
local storehouse_passive_provider_small = createLogisticItem("storehouse", "passive-provider", "small", "d[logistic-storehouse-small]", passive_tint)
local storehouse_requester_small = createLogisticItem("storehouse", "requester", "small", "d[logistic-storehouse-small]", requester_tint)
local storehouse_storage_small = createLogisticItem("storehouse", "storage", "small", "d[logistic-storehouse-small]", storage_tint)

local storehouse_tiny = createItem("storehouse", "tiny", "a[storehouse-tiny]-c", non_logistic_tint)
local storehouse_active_provider_tiny = createLogisticItem("storehouse", "active-provider", "tiny", "f[logistic-storehouse-tiny]", active_tint)
local storehouse_buffer_tiny = createLogisticItem("storehouse", "buffer", "tiny", "f[logistic-storehouse-tiny]", buffer_tint)
local storehouse_passive_provider_tiny = createLogisticItem("storehouse", "passive-provider", "tiny", "f[logistic-storehouse-tiny]", passive_tint)
local storehouse_requester_tiny = createLogisticItem("storehouse", "requester", "tiny", "f[logistic-storehouse-tiny]", requester_tint)
local storehouse_storage_tiny = createLogisticItem("storehouse", "storage", "tiny", "f[logistic-storehouse-tiny]", storage_tint)

local warehouse_small = createItem("warehouse", "small", "b[warehouse-small]-b", non_logistic_tint)
local warehouse_active_provider_small = createLogisticItem("warehouse", "active-provider", "small", "e[logistic-warehouse-small]", active_tint)
local warehouse_buffer_small = createLogisticItem("warehouse", "buffer", "small", "e[logistic-warehouse-small]", buffer_tint)
local warehouse_passive_provider_small = createLogisticItem("warehouse", "passive-provider", "small", "e[logistic-warehouse-small]", passive_tint)
local warehouse_requester_small = createLogisticItem("warehouse", "requester", "small", "e[logistic-warehouse-small]", requester_tint)
local warehouse_storage_small = createLogisticItem("warehouse", "storage", "small", "e[logistic-warehouse-small]", storage_tint)

local warehouse_tiny = createItem("warehouse", "tiny", "b[warehouse-tiny]-c", non_logistic_tint)
local warehouse_active_provider_tiny = createLogisticItem("warehouse", "active-provider", "tiny", "g[logistic-warehouse-tiny]", active_tint)
local warehouse_buffer_tiny = createLogisticItem("warehouse", "buffer", "tiny", "g[logistic-warehouse-tiny]", buffer_tint)
local warehouse_passive_provider_tiny = createLogisticItem("warehouse", "passive-provider", "tiny", "g[logistic-warehouse-tiny]", passive_tint)
local warehouse_requester_tiny = createLogisticItem("warehouse", "requester", "tiny", "g[logistic-warehouse-tiny]", requester_tint)
local warehouse_storage_tiny = createLogisticItem("warehouse", "storage", "tiny", "g[logistic-warehouse-tiny]", storage_tint)

data:extend({
    storehouse_small,
    storehouse_active_provider_small,
    storehouse_buffer_small,
    storehouse_passive_provider_small,
    storehouse_requester_small,
    storehouse_storage_small,
    storehouse_tiny,
    storehouse_active_provider_tiny,
    storehouse_buffer_tiny,
    storehouse_passive_provider_tiny,
    storehouse_requester_tiny,
    storehouse_storage_tiny,
    warehouse_small,
    warehouse_active_provider_small,
    warehouse_buffer_small,
    warehouse_passive_provider_small,
    warehouse_requester_small,
    warehouse_storage_small,
    warehouse_tiny,
    warehouse_active_provider_tiny,
    warehouse_buffer_tiny,
    warehouse_passive_provider_tiny,
    warehouse_requester_tiny,
    warehouse_storage_tiny,
    {
        type = "item-subgroup",
        name = "warehousing",
        group = "logistics",
        order = "b-a",
    },
    {
        type = "item-subgroup",
        name = "logistic-warehousing",
        group = "logistics",
        order = "b-b",
    },
})
