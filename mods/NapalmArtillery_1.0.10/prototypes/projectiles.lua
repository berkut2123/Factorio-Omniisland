local sounds = require("__base__/prototypes/entity/sounds.lua")

local napalmFire = table.deepcopy(data.raw["fire"]["fire-flame"])
napalmFire.name = "napalm-art-flame"
napalmFire.initial_lifetime = 1000
napalmFire.damage_per_tick = {amount = 200 / 60, type = "fire"}
napalmFire.on_fuel_added_action = nil
napalmFire.damage_multiplier_decrease_per_tick = 0.0005
napalmFire.maximum_damage_multiplier = 1
napalmFire.fade_out_duration = 100
napalmFire.lifetime_increase_by = 0

local boss_scale = 3.5

function fire_stream(data)
    return {
        type = "stream",
        name = data.name,
        flags = {"not-on-map"},
        stream_light = {intensity = 1, size = 6}, -----
        ground_light = {intensity = 0.8, size = 6}, ---
        particle_buffer_size = 90,
        particle_spawn_interval = data.particle_spawn_interval,
        particle_spawn_timeout = data.particle_spawn_timeout,
        particle_vertical_acceleration = 0.005 * 0.60 * 1.5, -- x
        particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5, -- x
        particle_horizontal_speed_deviation = 0.005 * 0.70,
        particle_start_alpha = 0.5,
        particle_end_alpha = 1,
        particle_alpha_per_part = 0.8,
        particle_scale_per_part = 0.8,
        particle_loop_frame_count = 15,
        -- particle_fade_out_threshold = 0.95,
        particle_fade_out_duration = 2,
        particle_loop_exit_threshold = 0.25,
        special_neutral_target_damage = {amount = 1, type = "acid"},
        initial_action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "play-sound",
                            sound = {
                                {
                                    filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
                                    volume = 0.8
                                }, {
                                    filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
                                    volume = 0.8
                                }, {
                                    filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
                                    volume = 0.8
                                }, {
                                    filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
                                    volume = 0.8
                                }
                            }
                        },
                        {
                            type = "create-fire",
                            entity_name = data.splash_fire_name
                        }, {
                            type = "create-fire",
                            entity_name = "napalm-art-flame",
                            initial_ground_flame_count = 30
                        }

                    }
                }
            }, {
                type = "area",
                radius = data.spit_radius,
                force = "enemy",
                ignore_collision_condition = true,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {type = "create-sticker", sticker = data.sticker_name},
                        {type = "damage", damage = {amount = 30, type = "fire"}}
                    }
                }
            }
        },
        particle = {
            filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
            line_length = 5,
            width = 22,
            height = 84,
            frame_count = 15,
            shift = util.mul_shift(util.by_pixel(-2, 30), data.scale),
            tint = data.tint,
            priority = "high",
            scale = data.scale,
            animation_speed = 1,
            hr_version = {
                filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-head.png",
                line_length = 5,
                width = 42,
                height = 164,
                frame_count = 15,
                shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
                tint = data.tint,
                priority = "high",
                scale = 0.5 * data.scale,
                animation_speed = 1
            }
        },
        spine_animation = {
            filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
            line_length = 5,
            width = 66,
            height = 12,
            frame_count = 15,
            shift = util.mul_shift(util.by_pixel(0, -2), data.scale),
            tint = data.tint,
            priority = "high",
            scale = data.scale,
            animation_speed = 1,
            hr_version = {
                filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-tail.png",
                line_length = 5,
                width = 132,
                height = 20,
                frame_count = 15,
                shift = util.mul_shift(util.by_pixel(0, -1), data.scale),
                tint = data.tint,
                priority = "high",
                scale = 0.5 * data.scale,
                animation_speed = 1
            }
        },
        shadow = {
            filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
            line_length = 15,
            width = 22,
            height = 84,
            frame_count = 15,
            priority = "high",
            shift = util.mul_shift(util.by_pixel(-2, 30), data.scale),
            draw_as_shadow = true,
            scale = data.scale,
            animation_speed = 1,
            hr_version = {
                filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-shadow.png",
                line_length = 15,
                width = 42,
                height = 164,
                frame_count = 15,
                shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
                draw_as_shadow = true,
                priority = "high",
                scale = 0.5 * data.scale,
                animation_speed = 1
            }
        },

        oriented_particle = true,
        shadow_scale_enabled = true
    }
end

function fire_stream_cluster(data)
    return {
        type = "stream",
        name = data.name,
        flags = {"not-on-map"},
        stream_light = {intensity = 1, size = 4}, -----
        ground_light = {intensity = 0.8, size = 4}, ---
        particle_buffer_size = 90,
        particle_spawn_interval = data.particle_spawn_interval,
        particle_spawn_timeout = data.particle_spawn_timeout,
        particle_vertical_acceleration = 0.005 * 0.60 * 1.5, -- x
        particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5, -- x
        particle_horizontal_speed_deviation = 0.005 * 0.70,
        particle_start_alpha = 0.5,
        particle_end_alpha = 1,
        particle_alpha_per_part = 0.8,
        particle_scale_per_part = 0.8,
        particle_loop_frame_count = 15,
        -- particle_fade_out_threshold = 0.95,
        particle_fade_out_duration = 2,
        particle_loop_exit_threshold = 0.25,
        special_neutral_target_damage = {amount = 1, type = "acid"},
        initial_action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "play-sound",
                            sound = {
                                {
                                    filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
                                    volume = 0.8
                                }, {
                                    filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
                                    volume = 0.8
                                }, {
                                    filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
                                    volume = 0.8
                                }, {
                                    filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
                                    volume = 0.8
                                }
                            }
                        },
                        {
                            type = "create-fire",
                            entity_name = data.splash_fire_name
                        }, {
                            type = "create-fire",
                            entity_name = "napalm-art-flame",
                            initial_ground_flame_count = 30
                        }, {
                            type = "nested-result",
                            action = {
                                type = "cluster",
                                cluster_count = 4,
                                distance = 5,
                                distance_deviation = 20,
                                action_delivery = {
                                    type = "stream",
                                    stream = "na-fire-stream",
                                    starting_speed = 0.1,
                                    max_range = 20
                                }
                            }
                        }
                    }
                }
            }, {
                type = "area",
                radius = data.spit_radius,
                force = "enemy",
                ignore_collision_condition = true,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {type = "create-sticker", sticker = data.sticker_name},
                        {type = "damage", damage = {amount = 30, type = "fire"}}
                    }
                }
            }
        },
        particle = {
            filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
            line_length = 5,
            width = 22,
            height = 84,
            frame_count = 15,
            shift = util.mul_shift(util.by_pixel(-2, 30), data.scale),
            tint = data.tint,
            priority = "high",
            scale = data.scale,
            animation_speed = 1,
            hr_version = {
                filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-head.png",
                line_length = 5,
                width = 42,
                height = 164,
                frame_count = 15,
                shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
                tint = data.tint,
                priority = "high",
                scale = 0.5 * data.scale,
                animation_speed = 1
            }
        },
        spine_animation = {
            filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
            line_length = 5,
            width = 66,
            height = 12,
            frame_count = 15,
            shift = util.mul_shift(util.by_pixel(0, -2), data.scale),
            tint = data.tint,
            priority = "high",
            scale = data.scale,
            animation_speed = 1,
            hr_version = {
                filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-tail.png",
                line_length = 5,
                width = 132,
                height = 20,
                frame_count = 15,
                shift = util.mul_shift(util.by_pixel(0, -1), data.scale),
                tint = data.tint,
                priority = "high",
                scale = 0.5 * data.scale,
                animation_speed = 1
            }
        },
        shadow = {
            filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
            line_length = 15,
            width = 22,
            height = 84,
            frame_count = 15,
            priority = "high",
            shift = util.mul_shift(util.by_pixel(-2, 30), data.scale),
            draw_as_shadow = true,
            scale = data.scale,
            animation_speed = 1,
            hr_version = {
                filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-shadow.png",
                line_length = 15,
                width = 42,
                height = 164,
                frame_count = 15,
                shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
                draw_as_shadow = true,
                priority = "high",
                scale = 0.5 * data.scale,
                animation_speed = 1
            }
        },

        oriented_particle = true,
        shadow_scale_enabled = true
    }
end

local fire_tint = {r = 1.0, g = 0.3, b = 0.1, a = 1.000}

data:extend({

    -- FIRE ATTACKS

    acid_splash_fire({
        name = "na-fire-splash",
        scale = (boss_scale - 1),
        tint = fire_tint,
        ground_patch_scale = (boss_scale - 1) * ground_patch_scale_modifier,
        patch_tint_multiplier = patch_opacity,
        splash_damage_per_tick = 1,
        sticker_name = "napalm-art-sticker"
    }), fire_stream({
        name = "na-fire-stream",
        scale = boss_scale - 1,
        tint = fire_tint,
        corpse_name = "na-fire-splash-corpse",
        spit_radius = stream_radius_worm_behemoth, -- 2
        particle_spawn_interval = 1,
        particle_spawn_timeout = 6,
        splash_fire_name = "na-fire-splash",
        sticker_name = "napalm-art-sticker"
    }), fire_stream_cluster({
        name = "na-cluster-fire-projectile",
        scale = boss_scale,
        tint = fire_tint,
        corpse_name = "na-fire-splash-corpse",
        spit_radius = stream_radius_worm_behemoth, -- 2
        particle_spawn_interval = 1,
        particle_spawn_timeout = 6,
        splash_fire_name = "na-fire-splash",
        sticker_name = "napalm-art-sticker"
    })

})

local math3d = require "math3d"
local nuke_shockwave_starting_speed_deviation = 0.075

data:extend({
    napalmFire, {
        type = "sticker",
        name = "napalm-art-sticker",
        flags = {"not-on-map"},

        animation = {
            filename = "__base__/graphics/entity/fire-flame/fire-flame-13.png",
            line_length = 8,
            width = 60,
            height = 118,
            frame_count = 25,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = "normal",
            animation_speed = 1,
            scale = 0.2,
            tint = {r = 0.5, g = 0.5, b = 0.5, a = 0.18}, -- { r = 1, g = 1, b = 1, a = 0.35 },
            shift = math3d.vector2.mul({-0.078125, -1.8125}, 0.1)
        },

        duration_in_ticks = 60 * 60,
        target_movement_modifier = 0.7,
        damage_per_tick = {amount = 100 / 60, type = "fire"},
        spread_fire_entity = "fire-flame-on-tree",
        fire_spread_cooldown = 40,
        fire_spread_radius = 0.1
    }, {
        type = "artillery-projectile",
        name = "napalm-artillery-projectile",
        flags = {"not-on-map"},
        acceleration = 0,
        direction_only = true,
        reveal_map = true,
        map_color = {r = 1, g = 0, b = 0},
        picture = {
            filename = "__NapalmArtillery__/graphics/hr-napalm-shell.png",
            width = 64,
            height = 64,
            scale = 0.5
        },
        shadow = {
            filename = "__base__/graphics/entity/artillery-projectile/hr-shell-shadow.png",
            width = 64,
            height = 64,
            scale = 0.5
        },
        chart_picture = {
            filename = "__NapalmArtillery__/graphics/napalm-shoot-map.png",
            flags = {"icon"},
            frame_count = 1,
            width = 64,
            height = 64,
            priority = "high",
            scale = 0.25
        },
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {

                    {
                        type = "damage",
                        damage = {amount = 200, type = "explosion"}
                    },
                    {type = "damage", damage = {amount = 300, type = "fire"}},

                    {
                        type = "set-tile",
                        tile_name = "nuclear-ground",
                        radius = 5,
                        apply_projection = true,
                        tile_collision_mask = {"water-tile"}
                    }, {type = "create-entity", entity_name = "nuke-explosion"},
                    {
                        type = "camera-effect",
                        effect = "screen-burn",
                        duration = 40,
                        ease_in_duration = 5,
                        ease_out_duration = 60,
                        delay = 0,
                        strength = 5,
                        full_strength_max_distance = 150,
                        max_distance = 500
                    }, {
                        type = "play-sound",
                        sound = sounds.nuclear_explosion(0.5),
                        play_on_target_position = false,
                        -- min_distance = 200,
                        max_distance = 800,
                        -- volume_modifier = 1,
                        audible_distance_modifier = 2
                    }, {
                        type = "play-sound",
                        sound = sounds.nuclear_explosion_aftershock(0.4),
                        play_on_target_position = false,
                        -- min_distance = 200,
                        max_distance = 800,
                        -- volume_modifier = 1,
                        audible_distance_modifier = 2
                    }, {
                        type = "create-entity",
                        entity_name = "huge-scorchmark",
                        check_buildability = true
                    }, 
                    {
                      type = "show-explosion-on-chart",
                      scale = 1.5,
                    },

                    {
                        type = "nested-result",
                        action = {
                            type = "cluster",
                            cluster_count = settings.startup["settings-napalm-art-clusters"]
                                .value,
                            distance = 2,
                            distance_deviation = settings.startup["settings-napalm-art-area"]
                                .value,
                            action_delivery = {
                                type = "stream",
                                stream = "na-cluster-fire-projectile",
                                starting_speed = 0.1,
                                max_range = settings.startup["settings-napalm-art-area"]
                                    .value / 2
                            }
                        }
                    }

                }
            }
        },

        final_action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "medium-scorchmark-tintable",
                        check_buildability = true
                    }, {type = "invoke-tile-trigger", repeat_count = 1}, {
                        type = "destroy-decoratives",
                        from_render_layer = "decorative",
                        to_render_layer = "object",
                        include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                        include_decals = false,
                        invoke_decorative_trigger = true,
                        decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                        radius = 3.5 -- large radius for demostrative purposes
                    }
                }
            }
        }

    }, {
        type = "projectile",
        name = "napalm-fire",
        flags = {"not-on-map"},
        acceleration = 0.005,
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-fire",
                            entity_name = "napalm-art-flame",
                            initial_ground_flame_count = 30
                        }
                    }
                }
            }, {
                type = "area",
                radius = 10,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-sticker",
                            sticker = "napalm-art-sticker"
                        }
                    }
                }
            }
        },
        light = {intensity = 0.5, size = 10},
        animation = nil,
        shadow = nil
    }

})
