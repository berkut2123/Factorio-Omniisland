local powerUtils = {}

function powerUtils.makeOilBurner(attributes)
    local name = attributes.name .. "-fluid-generator-rampant-arsenal"
    
    data:extend({
            {
                type = "item",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/steam-turbine.png",
                icon_size = 32,
                flags = {},
                subgroup = attributes.subgroup or "energy",
                order = attributes.order or "b[steam-power]-c[steam-turbine]",
                place_result = name,
                stack_size = 10
            },
            {
                type = "generator",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/steam-turbine.png",
                icon_size = 32,
                flags = {"placeable-neutral","player-creation"},
                minable = {mining_time = 1, result = name },
                max_health = attributes.health or 300,
                corpse = "big-remnants",
                dying_explosion = "medium-explosion",
                alert_icon_shift = util.by_pixel(0, -12),
                effectivity = attributes.effectivity or 1,
                fluid_usage_per_tick = attributes.fluidPerTick or 0.25,
                maximum_temperature = attributes.maxTemp or 500,
                max_power_output = attributes.maxPower or "16MW",
                burns_fluid = attributes.burnFluid,
                scale_fluid_usage = attributes.scaleFluidUsage,
                
                resistances =
                    {
                        {
                            type = "fire",
                            percent = 70
                        }
                    },
                fast_replaceable_group = "oil-burner",
                collision_box = {{attributes.scale * -2.7, attributes.scale * -4.7}, {attributes.scale * 2.7, attributes.scale * 4.7}},
                selection_box = {{attributes.scale * -3, attributes.scale * -5}, {attributes.scale * 3, attributes.scale * 5}},
                fluid_box =
                    {
                        base_area = 1,
                        height = 2,
                        base_level = -1,
                        pipe_covers = pipecoverspictures(),
                        pipe_connections =
                            {
                                { type = "input-output", position = {0.5, attributes.scale * 5.5} },
                                { type = "input-output", position = {0.5, -(attributes.scale * 5.5)} },
                                { type = "input-output", position = {-0.5, attributes.scale * 5.5} },
                                { type = "input-output", position = {-0.5, -(attributes.scale * 5.5)} }
                            },
                        production_type = "input-output"
                    },
                energy_source =
                    {
                        type = "electric",
                        usage_priority = "secondary-output",
                        emissions_per_minute = attributes.emissions
                    },
                horizontal_animation =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/steam-turbine/steam-turbine-H.png",
                                    width = 160,
                                    height = 123,
                                    frame_count = 8,
                                    line_length = 4,
                                    scale = attributes.scale * 2,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(0, attributes.scale * -5),
                                    hr_version =
                                        {
                                            filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-H.png",
                                            width = 320,
                                            height = 245,
                                            frame_count = 8,
                                            line_length = 4,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(0, attributes.scale * -5),
                                            scale = attributes.scale * 1
                                        }
                                },
                                {
                                    filename = "__base__/graphics/entity/steam-turbine/steam-turbine-H-shadow.png",
                                    width = 217,
                                    height = 74,
                                    repeat_count = 8,
                                    frame_count = 1,
                                    line_length = 1,
                                    draw_as_shadow = true,
                                    scale = attributes.scale * 2,
                                    shift = util.by_pixel(attributes.scale * 57.5, attributes.scale * 36),
                                    hr_version =
                                        {
                                            filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-H-shadow.png",
                                            width = 435,
                                            height = 150,
                                            repeat_count = 8,
                                            frame_count = 1,
                                            line_length = 1,
                                            draw_as_shadow = true,
                                            shift = util.by_pixel(attributes.scale * 57, attributes.scale * 36),
                                            scale = attributes.scale * 1
                                        }
                                }
                            }
                    },
                vertical_animation =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/steam-turbine/steam-turbine-V.png",
                                    width = 108,
                                    height = 173,
                                    frame_count = 8,
                                    line_length = 4,
                                    scale = attributes.scale * 2,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(attributes.scale * 10, attributes.scale * 13),
                                    hr_version =
                                        {
                                            filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-V.png",
                                            width = 217,
                                            height = 347,
                                            frame_count = 8,
                                            line_length = 4,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(attributes.scale * 9.5, attributes.scale * 13.5),
                                            scale = attributes.scale * 1
                                        }
                                },
                                {
                                    filename = "__base__/graphics/entity/steam-turbine/steam-turbine-V-shadow.png",
                                    width = 151,
                                    height = 131,
                                    repeat_count = 8,
                                    frame_count = 1,
                                    line_length = 1,
                                    draw_as_shadow = true,
                                    scale = attributes.scale * 2,
                                    shift = util.by_pixel(attributes.scale * 79, attributes.scale * 49),
                                    hr_version =
                                        {
                                            filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-V-shadow.png",
                                            width = 302,
                                            height = 260,
                                            repeat_count = 8,
                                            frame_count = 1,
                                            line_length = 1,
                                            draw_as_shadow = true,
                                            shift = util.by_pixel(attributes.scale * 79, attributes.scale * 49),
                                            scale = attributes.scale * 1
                                        }
                                }
                            }
                    },
                smoke =
                    {
                        {
                            name = "turbine-smoke",
                            north_position = {1.75, -2},
                            east_position = {1.75, -2.2},
                            frequency = 10 / 32,
                            starting_vertical_speed = 0.08,
                            slow_down_factor = 1,
                            scale = 1,
                            tint = {r=0,g=0,b=0,a=1},
                            starting_frame_deviation = 60
                        }
                    },
                vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
                working_sound =
                    {
                        sound =
                            {
                                filename = "__base__/sound/steam-engine-90bpm.ogg",
                                volume = 0.6
                            },
                        match_speed_to_activity = true
                    },
                min_perceived_performance = 0.25,
                performance_to_sound_speedup = 0.5
            }
    })
    
    return name
end

return powerUtils
