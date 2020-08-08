local config = require "config"
local tile_transitions = require("util/tile-transitions")

data:extend(
{
    -- asphalt tile --------------------------------------------------------------------
    {
    
        type = "tile",
        name = "Arci-asphalt",
        needs_correction = false,
        minable = {mining_time = config.asphalt_mining_speed, result = "Arci-asphalt"},
        mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
        collision_mask = {"ground-tile"},
        walking_speed_modifier = config.asphalt_walking_speed_modifier,
        layer = config.asphalt_base_layer,
        shift_layer_if_asphald_roads_is_present = false,
        decorative_removal_probability = 0.97,
        variants =
        {
            main =
            {
                {
                    picture = "__AsphaltRoads__/graphics/terrain/asphalt/asphalt.png",
                    count = 16,
                    size = 1
                },
                {
                    picture = "__AsphaltRoads__/graphics/terrain/asphalt/asphalt2.png",
                    count = 4,
                    size = 2,
                    probability = 0.3,
                },
                {
                    picture = "__AsphaltRoads__/graphics/terrain/asphalt/asphalt4.png",
                    count = 4,
                    size = 4,
                    probability = 0.8,
                },
            },
            inner_corner =
            {
                picture = "__AsphaltRoads__/graphics/terrain/asphalt/asphalt-inner-corner.png",
                count = 8
            },
            outer_corner =
            {
                picture = "__AsphaltRoads__/graphics/terrain/asphalt/asphalt-outer-corner.png",
                count = 8
            },
            side =
            {
                picture = "__AsphaltRoads__/graphics/terrain/asphalt/asphalt-side.png",
                count = 8
            },
            u_transition =
            {
                picture = "__AsphaltRoads__/graphics/terrain/asphalt/asphalt-u.png",
                count = 8
            },
                o_transition =
            {
                picture = "__AsphaltRoads__/graphics/terrain/asphalt/asphalt-o.png",
                count = 1
            }
        },
        walking_sound =
        {
            {
                filename = "__base__/sound/walking/concrete-01.ogg",
                volume = 1.2
            },
            {
                filename = "__base__/sound/walking/concrete-02.ogg",
                volume = 1.2
            },
            {
                filename = "__base__/sound/walking/concrete-03.ogg",
                volume = 1.2
            },
            {
                filename = "__base__/sound/walking/concrete-04.ogg",
                volume = 1.2
            }
        },
        map_color = config.asphalt_colour,
        pollution_absorption_per_second = 0,
        vehicle_friction_modifier = config.asphalt_vehicle_speed_modifier,
        transitions = tile_transitions.asphalt_transitions(),
        transitions_between_transitions = tile_transitions.asphalt_transitions_between_transitions()
    }
})