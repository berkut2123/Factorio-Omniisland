local gc = require("prototypes.graphic-calls")
local sounds = require("__base__/prototypes/entity/sounds")

local scale_s_wh = 0.8
local hr_scale_s_wh = 0.4
local entity_shadow_shift_s_wh = { 0.8, 0 }
local shift_s_wh = { 1.5, 0.2 }
local shift_shadow_s_wh = { 3.5, 2 }
local s_wh_wire_connection_red = { 1.75, 0.2 }
local s_wh_wire_connection_green = { 1.25, 0.2 }
local s_wh_wire_connection_shadow_red = { 3.75, 2 }
local s_wh_wire_connection_shadow_green = { 3.25, 2 }
local s_wh_collision_box = { { -2.1, -2.1 }, { 2.1, 2.1 } }
local s_wh_selection_box = { { -2.4, -2.4 }, { 2.4, 2.4 } }

local scale_t_wh = 0.6
local hr_scale_t_wh = 0.3
local entity_shadow_shift_t_wh = { 0.6, 0 }
local shift_t_wh = { 1.1, 0.1 }
local shift_shadow_t_wh = { 2.5, 1.5 }
local t_wh_wire_connection_red = { 1.25, 0.1 }
local t_wh_wire_connection_green = { 0.925, 0.1 }
local t_wh_wire_connection_shadow_red = { 2.7, 1.5 }
local t_wh_wire_connection_shadow_green = { 2.45, 1.5 }
local t_wh_collision_box = { { -1.6, -1.6 }, { 1.6, 1.6 } }
local t_wh_selection_box = { { -1.9, -1.9 }, { 1.9, 1.9 } }

local scale_s_sh = 0.55
local hr_scale_s_sh = 0.275
local entity_shadow_shift_s_sh = { 0, 0 }
local shift_s_sh = { 0.4, -0.25 }
local shift_shadow_s_sh = { 1.2, 0.5 }
local s_sh_wire_connection_red = { 0.535, -0.25 }
local s_sh_wire_connection_green = { 0.235, -0.25 }
local s_sh_wire_connection_shadow_red = { 1.35, 0.5 }
local s_sh_wire_connection_shadow_green = { 1.15, 0.5 }
local s_sh_collision_box = { { -0.65, -0.65 }, { 0.65, 0.65 } }
local s_sh_selection_box = { { -0.95, -0.95 }, { 0.95, 0.95 } }

local scale_t_sh = 0.3
local hr_scale_t_sh = 0.15
local entity_shadow_shift_t_sh = { 0, 0 }
local shift_t_sh = { 0.2, -0.15 }
local shift_shadow_t_sh = { 0.675, 0.2 }
local t_sh_wire_connection_red = { 0.3, -0.15 }
local t_sh_wire_connection_green = { 0.1, -0.15 }
local t_sh_wire_connection_shadow_red = { 0.8, 0.2 }
local t_sh_wire_connection_shadow_green = { 0.6, 0.2 }
local t_sh_collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } }
local t_sh_selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

local function createContainer(name, size)
    local cc = table.deepcopy(data.raw["container"][name .. "-basic"])
    cc.name = name .. "-" .. size
    cc.minable.result = cc.name
    cc.icons = {
        { icon = "__Warehousing__/graphics/icons/" .. name .. "-basic.png" },
        { icon = "__Warehousing-Compression__/graphics/icons/" .. size .. "-mask.png" },
    }
    if name == "warehouse" and size == "small" then
        cc.picture = gc.warehouse_basic_picture(scale_s_wh, hr_scale_s_wh, entity_shadow_shift_s_wh)
        cc.circuit_connector_sprites = gc.connector_sprite(scale_s_wh, hr_scale_s_wh, shift_s_wh, shift_shadow_s_wh)
        cc.circuit_wire_connection_point.wire.red = s_wh_wire_connection_red
        cc.circuit_wire_connection_point.wire.green = s_wh_wire_connection_green
        cc.circuit_wire_connection_point.shadow.red = s_wh_wire_connection_shadow_red
        cc.circuit_wire_connection_point.shadow.green = s_wh_wire_connection_shadow_green
        cc.collision_box = s_wh_collision_box
        cc.selection_box = s_wh_selection_box
    elseif name == "warehouse" and size == "tiny" then
        cc.picture = gc.warehouse_basic_picture(scale_t_wh, hr_scale_t_wh, entity_shadow_shift_t_wh)
        cc.circuit_connector_sprites = gc.connector_sprite(scale_t_wh, hr_scale_t_wh, shift_t_wh, shift_shadow_t_wh)
        cc.circuit_wire_connection_point.wire.red = t_wh_wire_connection_red
        cc.circuit_wire_connection_point.wire.green = t_wh_wire_connection_green
        cc.circuit_wire_connection_point.shadow.red = t_wh_wire_connection_shadow_red
        cc.circuit_wire_connection_point.shadow.green = t_wh_wire_connection_shadow_green
        cc.collision_box = t_wh_collision_box
        cc.selection_box = t_wh_selection_box
    elseif name == "storehouse" and size == "small" then
        cc.picture = gc.storehouse_basic_picture(scale_s_sh, hr_scale_s_sh, entity_shadow_shift_s_sh)
        cc.circuit_connector_sprites = gc.connector_sprite(scale_s_sh, hr_scale_s_sh, shift_s_sh, shift_shadow_s_sh)
        cc.circuit_wire_connection_point.wire.red = s_sh_wire_connection_red
        cc.circuit_wire_connection_point.wire.green = s_sh_wire_connection_green
        cc.circuit_wire_connection_point.shadow.red = s_sh_wire_connection_shadow_red
        cc.circuit_wire_connection_point.shadow.green = s_sh_wire_connection_shadow_green
        cc.collision_box = s_sh_collision_box
        cc.selection_box = s_sh_selection_box
    elseif name == "storehouse" and size == "tiny" then
        cc.picture = gc.storehouse_basic_picture(scale_t_sh, hr_scale_t_sh, entity_shadow_shift_t_sh)
        cc.circuit_connector_sprites = gc.connector_sprite(scale_t_sh, hr_scale_t_sh, shift_t_sh, shift_shadow_t_sh)
        cc.circuit_wire_connection_point.wire.red = t_sh_wire_connection_red
        cc.circuit_wire_connection_point.wire.green = t_sh_wire_connection_green
        cc.circuit_wire_connection_point.shadow.red = t_sh_wire_connection_shadow_red
        cc.circuit_wire_connection_point.shadow.green = t_sh_wire_connection_shadow_green
        cc.collision_box = t_sh_collision_box
        cc.selection_box = t_sh_selection_box
    end
    return cc
end

data:extend({
    createContainer("warehouse", "small"),
    createContainer("warehouse", "tiny"),
    createContainer("storehouse", "small"),
    createContainer("storehouse", "tiny"),
})

local chest_animation_scale_s_wh = 0.8
local hr_chest_animation_scale_s_wh = 0.4
local hr_chest_shift_s_wh = { 0.8, -1.075 }

local chest_animation_scale_t_wh = 0.6
local hr_chest_animation_scale_t_wh = 0.3
local hr_chest_shift_t_wh = { 0.6, -0.85 }

local chest_animation_scale_s_sh = 0.5
local hr_chest_animation_scale_s_sh = 0.25
local hr_chest_shift_s_sh = { 0, 0.05 }

local chest_animation_scale_t_sh = 0.3
local hr_chest_animation_scale_t_sh = 0.15
local hr_chest_shift_t_sh = { 0, 0.03 }

local function createLogisticContainer(name, size, logistic_type)
    local clc = table.deepcopy(data.raw["logistic-container"][name .. "-" .. logistic_type])
    clc.name = name .. "-" .. logistic_type .. "-" .. size
    clc.minable.result = clc.name
    clc.icons = {
        { icon = "__Warehousing__/graphics/icons/" .. name .. "-" .. logistic_type .. ".png" },
        { icon = "__Warehousing-Compression__/graphics/icons/" .. size .. "-mask.png" },
    }
    clc.animation_sound = sounds.logistics_chest_open
    clc.opened_duration = 7
    clc.picture = nil
    if logistic_type == "storage" then
        clc.max_logistic_slots = 1
    end
    if name == "warehouse" and size == "small" then
        clc.animation = gc.chest_animation_warehouse(logistic_type, scale_s_wh, hr_scale_s_wh, chest_animation_scale_s_wh, hr_chest_animation_scale_s_wh, hr_chest_shift_s_wh, entity_shadow_shift_s_wh)
        clc.circuit_connector_sprites = gc.connector_sprite(scale_s_wh, hr_scale_s_wh, shift_s_wh, shift_shadow_s_wh)
        clc.circuit_wire_connection_point.wire.red = s_wh_wire_connection_red
        clc.circuit_wire_connection_point.wire.green = s_wh_wire_connection_green
        clc.circuit_wire_connection_point.shadow.red = s_wh_wire_connection_shadow_red
        clc.circuit_wire_connection_point.shadow.green = s_wh_wire_connection_shadow_green
        clc.collision_box = s_wh_collision_box
        clc.selection_box = s_wh_selection_box
    elseif name == "warehouse" and size == "tiny" then
        clc.animation = gc.chest_animation_warehouse(logistic_type, scale_t_wh, hr_scale_t_wh, chest_animation_scale_t_wh, hr_chest_animation_scale_t_wh, hr_chest_shift_t_wh, entity_shadow_shift_t_wh)
        clc.circuit_connector_sprites = gc.connector_sprite(scale_t_wh, hr_scale_t_wh, shift_t_wh, shift_shadow_t_wh)
        clc.circuit_wire_connection_point.wire.red = t_wh_wire_connection_red
        clc.circuit_wire_connection_point.wire.green = t_wh_wire_connection_green
        clc.circuit_wire_connection_point.shadow.red = t_wh_wire_connection_shadow_red
        clc.circuit_wire_connection_point.shadow.green = t_wh_wire_connection_shadow_green
        clc.collision_box = t_wh_collision_box
        clc.selection_box = t_wh_selection_box
    elseif name == "storehouse" and size == "small" then
        clc.animation = gc.chest_animation_storehouse(logistic_type, scale_s_sh, hr_scale_s_sh, chest_animation_scale_s_sh, hr_chest_animation_scale_s_sh, hr_chest_shift_s_sh, entity_shadow_shift_s_sh)
        clc.circuit_connector_sprites = gc.connector_sprite(scale_s_sh, hr_scale_s_sh, shift_s_sh, shift_shadow_s_sh)
        clc.circuit_wire_connection_point.wire.red = s_sh_wire_connection_red
        clc.circuit_wire_connection_point.wire.green = s_sh_wire_connection_green
        clc.circuit_wire_connection_point.shadow.red = s_sh_wire_connection_shadow_red
        clc.circuit_wire_connection_point.shadow.green = s_sh_wire_connection_shadow_green
        clc.collision_box = s_sh_collision_box
        clc.selection_box = s_sh_selection_box
    elseif name == "storehouse" and size == "tiny" then
        clc.animation = gc.chest_animation_storehouse(logistic_type, scale_t_sh, hr_scale_t_sh, chest_animation_scale_t_sh, hr_chest_animation_scale_t_sh, hr_chest_shift_t_sh, entity_shadow_shift_t_sh)
        clc.circuit_connector_sprites = gc.connector_sprite(scale_t_sh, hr_scale_t_sh, shift_t_sh, shift_shadow_t_sh)
        clc.circuit_wire_connection_point.wire.red = t_sh_wire_connection_red
        clc.circuit_wire_connection_point.wire.green = t_sh_wire_connection_green
        clc.circuit_wire_connection_point.shadow.red = t_sh_wire_connection_shadow_red
        clc.circuit_wire_connection_point.shadow.green = t_sh_wire_connection_shadow_green
        clc.collision_box = t_sh_collision_box
        clc.selection_box = t_sh_selection_box
    end
    return clc
end

data:extend({
    createLogisticContainer("warehouse", "small", "active-provider"),
    createLogisticContainer("warehouse", "small", "passive-provider"),
    createLogisticContainer("warehouse", "small", "storage"),
    createLogisticContainer("warehouse", "small", "buffer"),
    createLogisticContainer("warehouse", "small", "requester"),
    createLogisticContainer("warehouse", "tiny", "active-provider"),
    createLogisticContainer("warehouse", "tiny", "passive-provider"),
    createLogisticContainer("warehouse", "tiny", "storage"),
    createLogisticContainer("warehouse", "tiny", "buffer"),
    createLogisticContainer("warehouse", "tiny", "requester"),
    createLogisticContainer("storehouse", "small", "active-provider"),
    createLogisticContainer("storehouse", "small", "passive-provider"),
    createLogisticContainer("storehouse", "small", "storage"),
    createLogisticContainer("storehouse", "small", "buffer"),
    createLogisticContainer("storehouse", "small", "requester"),
    createLogisticContainer("storehouse", "tiny", "active-provider"),
    createLogisticContainer("storehouse", "tiny", "passive-provider"),
    createLogisticContainer("storehouse", "tiny", "storage"),
    createLogisticContainer("storehouse", "tiny", "buffer"),
    createLogisticContainer("storehouse", "tiny", "requester"),
})
