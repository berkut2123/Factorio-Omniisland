-- resources.lua

local resource_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
    variation_count = 1,
}

local asteroid_resource_patch = {
    type = "resource",
    name = "asteroid-dust-resource",
    category = "asteroid-mining",
    collision_box = { { -1.4, -1.4  }, { 1.4, 1.4 } },
    flags = { "placeable-neutral" },
    highlight = false,
    icon_size = 32,
    icons = 
    {
        {
            icon = "__space-exploration-bridge-mod__/graphics/icons/asteroid_dust.png",
            icon_size = 32
        }
    },
    infinite = true,
    infinite_depletion_amount = 1,
    map_color = { b = 0, g = 0, r = 0, a = 0 },
    map_grid = false,
    minable = {
        mining_time = 1,
        results = {
            {
                amount_max = 1,
                amount_min = 1,
                name = "asteroid-dust",
                probability = 1,
            }
        }
    },
    minimum = 800,
    normal = 1000,
    order = "a-b-a",
    resource_patch_search_radius = 0,
    selection_box = {{ -0.0, -0.0 },{ 0.0, 0.0 }},
    stage_counts = { 0 },
    stages = { sheet = resource_image },
    localised_name = "asteroid-dust-source"
}

data:extend({asteroid_resource_patch})