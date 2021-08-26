local gc = {}

local entity_path = "__Warehousing__/graphics/entity/"

gc.connector_sprite = function(scale, hr_scale, shift, shift_shadow)
    local connector_sprite_data = {
        connector_main = {
            filename = entity_path .. "connector.png",
            width = 42,
            height = 68,
            shift = shift,
            scale = scale,
            hr_version = {
                filename = entity_path .. "hr-connector.png",
                width = 84,
                height = 136,
                shift = shift,
                scale = hr_scale,
            }
        },
        connector_shadow = {
            filename = entity_path .. "connector-shadow.png",
            width = 34,
            height = 17,
            draw_as_shadow = true,
            shift = shift_shadow,
            scale = scale,
            hr_version = {
                filename = entity_path .. "hr-connector-shadow.png",
                width = 68,
                height = 33,
                draw_as_shadow = true,
                shift = shift_shadow,
                scale = hr_scale,
            }
        },
        led_blue = { filename = "__core__/graphics/empty.png", size = 1 },
        led_green = { filename = "__core__/graphics/empty.png", size = 1 },
        led_red = { filename = "__core__/graphics/empty.png", size = 1 },
        led_light = { type = "basic", intensity = 0, size = 0 }
    }
    return connector_sprite_data
end

gc.warehouse_basic_picture = function(scale, hr_scale, shift_shadow)
    local picture = {
        layers = {
            {
                filename = entity_path .. "warehouse/warehouse-basic.png",
                width = 260,
                height = 240,
                scale = scale,
                hr_version = {
                    filename = entity_path .. "warehouse/hr-warehouse-basic.png",
                    width = 520,
                    height = 480,
                    scale = hr_scale,
                }
            },
            {
                filename = entity_path .. "warehouse/warehouse-basic-shadow.png",
                width = 260,
                height = 240,
                scale = scale,
                shift = shift_shadow,
                draw_as_shadow = true,
                hr_version = {
                    filename = entity_path .. "warehouse/hr-warehouse-basic-shadow.png",
                    width = 520,
                    height = 480,
                    shift = shift_shadow,
                    scale = hr_scale,
                    draw_as_shadow = true,
                }
            },
        }
    }
    return picture
end

gc.storehouse_basic_picture = function(scale, hr_scale, shift_shadow)
    local picture = {
        layers = {
            {
                filename = entity_path .. "storehouse/storehouse-basic.png",
                width = 128,
                height = 128,
                scale = scale,
                hr_version = {
                    filename = entity_path .. "storehouse/hr-storehouse-basic.png",
                    width = 256,
                    height = 256,
                    scale = hr_scale,
                }
            },
            {
                filename = entity_path .. "storehouse/storehouse-basic-shadow.png",
                width = 128,
                height = 128,
                scale = scale,
                shift = shift_shadow,
                draw_as_shadow = true,
                hr_version = {
                    filename = entity_path .. "storehouse/hr-storehouse-basic-shadow.png",
                    width = 256,
                    height = 256,
                    shift = shift_shadow,
                    scale = hr_scale,
                    draw_as_shadow = true,
                }
            },
        }
    }
    return picture
end

gc.chest_animation_warehouse = function(logistic_type, scale, hr_scale, chest_animation_scale, hr_chest_animation_scale, chest_shift, shadow_shift)
    local warehouse_animation = {
        layers = {
            {
                filename = "__Warehousing__/graphics/entity/warehouse/warehouse-" .. logistic_type .. ".png",
                width = 520 / 2,
                height = 480 / 2,
                repeat_count = 7,
                scale = scale,
                hr_version = {
                    filename = "__Warehousing__/graphics/entity/warehouse/hr-warehouse-" .. logistic_type .. ".png",
                    width = 520,
                    height = 480,
                    repeat_count = 7,
                    scale = hr_scale,
                }
            },
            {
                filename = "__Warehousing__/graphics/entity/warehouse/warehouse-chest-anim.png",
                width = 44 / 2,
                height = 44 / 2,
                frame_count = 7,
                shift = chest_shift,
                scale = chest_animation_scale,
                hr_version = {
                    filename = "__Warehousing__/graphics/entity/warehouse/hr-warehouse-chest-anim.png",
                    width = 44,
                    height = 44,
                    frame_count = 7,
                    shift = chest_shift,
                    scale = hr_chest_animation_scale,
                }
            },
            {
                filename = "__Warehousing__/graphics/entity/warehouse/warehouse-basic-shadow.png",
                width = 520 / 2,
                height = 480 / 2,
                shift = shadow_shift,
                repeat_count = 7,
                draw_as_shadow = true,
                scale = scale,
                hr_version = {
                    filename = "__Warehousing__/graphics/entity/warehouse/hr-warehouse-basic-shadow.png",
                    width = 520,
                    height = 480,
                    shift = shadow_shift,
                    scale = hr_scale,
                    repeat_count = 7,
                    draw_as_shadow = true,
                }
            },
        },
    }
    return warehouse_animation
end

gc.chest_animation_storehouse = function(logistic_type, scale, hr_scale, chest_animation_scale, hr_chest_animation_scale, chest_shift, shadow_shift)
    local storehouse_animation = {
        layers = {
            {
                filename = "__Warehousing__/graphics/entity/storehouse/storehouse-" .. logistic_type .. ".png",
                width = 256 / 2,
                height = 256 / 2,
                repeat_count = 7,
                scale = scale,
                hr_version = {
                    filename = "__Warehousing__/graphics/entity/storehouse/hr-storehouse-" .. logistic_type .. ".png",
                    width = 256,
                    height = 256,
                    repeat_count = 7,
                    scale = hr_scale,
                }
            },
            {
                filename = "__Warehousing__/graphics/entity/storehouse/storehouse-chest-anim.png",
                width = 74 / 2,
                height = 74 / 2,
                frame_count = 7,
                shift = chest_shift,
                scale = chest_animation_scale,
                hr_version = {
                    filename = "__Warehousing__/graphics/entity/storehouse/hr-storehouse-chest-anim.png",
                    width = 74,
                    height = 74,
                    frame_count = 7,
                    shift = chest_shift,
                    scale = hr_chest_animation_scale,
                }
            },
            {
                filename = "__Warehousing__/graphics/entity/storehouse/storehouse-basic-shadow.png",
                width = 256 / 2,
                height = 256 / 2,
                shift = shadow_shift,
                repeat_count = 7,
                draw_as_shadow = true,
                scale = scale,
                hr_version = {
                    filename = "__Warehousing__/graphics/entity/storehouse/hr-storehouse-basic-shadow.png",
                    width = 256,
                    height = 256,
                    shift = shadow_shift,
                    scale = hr_scale,
                    repeat_count = 7,
                    draw_as_shadow = true,
                }
            },
        },
    }
    return storehouse_animation
end

return gc