data:extend({
    -- A new beacon that is invisible and automatically placed on top of
    -- every crystallizer. Cannot be used on any other machines or manually
    -- interacted with.
    {
        type = "beacon",
        name = "seablock-mining-prod-provider",
        energy_usage = "10W",
        flags = { "hide-alt-info", "not-blueprintable", "not-deconstructable", "not-on-map", "not-flammable", "not-repairable", "no-automated-item-removal", "no-automated-item-insertion" },
        animation = {
            filename = "__seablock-mining__/graphics/empty.png",
            width = 1,
            height = 1,
            line_length = 8,
            frame_count = 1,
        },
        animation_shadow = {
            filename = "__seablock-mining__/graphics/empty.png",
            width = 1,
            height = 1,
            line_length = 8,
            frame_count = 1,
        },
        energy_source =
        {
            type = "void",
        },
        base_picture =
        {
            filename = "__seablock-mining__/graphics/empty.png",
            width = 1,
            height = 1,
        },
        supply_area_distance = 0,
        radius_visualisation_picture =
        {
            filename = "__seablock-mining__/graphics/empty.png",
            width = 1,
            height = 1
        },
        distribution_effectivity = 1,
        module_specification =
        {
            module_slots = 65535,
        },
        allowed_effects = { "productivity" },
        selection_box = nil,
        collision_box = nil,
		collision_mask = { },
    },
    -- Modules that add 2% productivity with no drawback. Can only be created by
    -- a script adding them to the invisible beacons as mining productivity research
    -- progresses.
    {
        type = "module",
        name = "seablock-mining-prod-module",
        icon = "__seablock-mining__/graphics/empty.png",
        icon_size = 1,
        flags = { "hidden", "hide-from-bonus-gui" },
        subgroup = "module",
        category = "productivity",
        tier = 0,
        stack_size = 1,
        effect = { productivity = {bonus = 0.02}}
    },
})