local function createItem(name, size, order)
    local i = table.deepcopy(data.raw["item"][name .. "-basic"])
    i.order = order
    i.name = name .. "-" .. size
    i.icons = {
        { icon = "__Warehousing__/graphics/icons/" .. name .. "-basic.png" },
        { icon = "__Warehousing-Compression__/graphics/icons/" .. size .. "-mask.png" },
    }
    i.subgroup = "warehousing"
    i.place_result = name .. "-" .. size
    return i
end

local function createLogisticItem(name, logistic_type, size, order)
    local li = table.deepcopy(data.raw["item"][name .. "-" .. logistic_type])
    li.order = order
    li.name = name .. "-" .. logistic_type .. "-" .. size
    li.icons = {
        { icon = "__Warehousing__/graphics/icons/" .. name .. "-" .. logistic_type .. ".png" },
        { icon = "__Warehousing-Compression__/graphics/icons/" .. size .. "-mask.png" },
    }
    li.subgroup = "logistic-warehousing"
    li.place_result = name .. "-" .. logistic_type .. "-" .. size
    return li
end

local storehouse_small = createItem("storehouse", "small", "a[storehouse-small]-b")
local storehouse_active_provider_small = createLogisticItem("storehouse", "active-provider", "small", "d[logistic-storehouse-small]")
local storehouse_buffer_small = createLogisticItem("storehouse", "buffer", "small", "d[logistic-storehouse-small]")
local storehouse_passive_provider_small = createLogisticItem("storehouse", "passive-provider", "small", "d[logistic-storehouse-small]")
local storehouse_requester_small = createLogisticItem("storehouse", "requester", "small", "d[logistic-storehouse-small]")
local storehouse_storage_small = createLogisticItem("storehouse", "storage", "small", "d[logistic-storehouse-small]")

local storehouse_tiny = createItem("storehouse", "tiny", "a[storehouse-tiny]-c")
local storehouse_active_provider_tiny = createLogisticItem("storehouse", "active-provider", "tiny", "f[logistic-storehouse-tiny]")
local storehouse_buffer_tiny = createLogisticItem("storehouse", "buffer", "tiny", "f[logistic-storehouse-tiny]")
local storehouse_passive_provider_tiny = createLogisticItem("storehouse", "passive-provider", "tiny", "f[logistic-storehouse-tiny]")
local storehouse_requester_tiny = createLogisticItem("storehouse", "requester", "tiny", "f[logistic-storehouse-tiny]")
local storehouse_storage_tiny = createLogisticItem("storehouse", "storage", "tiny", "f[logistic-storehouse-tiny]")

local warehouse_small = createItem("warehouse", "small", "b[warehouse-small]-b")
local warehouse_active_provider_small = createLogisticItem("warehouse", "active-provider", "small", "e[logistic-warehouse-small]")
local warehouse_buffer_small = createLogisticItem("warehouse", "buffer", "small", "e[logistic-warehouse-small]")
local warehouse_passive_provider_small = createLogisticItem("warehouse", "passive-provider", "small", "e[logistic-warehouse-small]")
local warehouse_requester_small = createLogisticItem("warehouse", "requester", "small", "e[logistic-warehouse-small]")
local warehouse_storage_small = createLogisticItem("warehouse", "storage", "small", "e[logistic-warehouse-small]")

local warehouse_tiny = createItem("warehouse", "tiny", "b[warehouse-tiny]-c")
local warehouse_active_provider_tiny = createLogisticItem("warehouse", "active-provider", "tiny", "g[logistic-warehouse-tiny]")
local warehouse_buffer_tiny = createLogisticItem("warehouse", "buffer", "tiny", "g[logistic-warehouse-tiny]")
local warehouse_passive_provider_tiny = createLogisticItem("warehouse", "passive-provider", "tiny", "g[logistic-warehouse-tiny]")
local warehouse_requester_tiny = createLogisticItem("warehouse", "requester", "tiny", "g[logistic-warehouse-tiny]")
local warehouse_storage_tiny = createLogisticItem("warehouse", "storage", "tiny", "g[logistic-warehouse-tiny]")

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
