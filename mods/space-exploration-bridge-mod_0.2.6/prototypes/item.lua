--item.lua

data:extend({
    {
        type = "item",
        name = "asteroid-dust",
        icons = {
            {
                icon = "__space-exploration-bridge-mod__/graphics/icons/asteroid_dust.png",
                icon_size = 32
            }
        },
        subgroup = "raw-resource",
        order = "i-a",
        stack_size = 200
        },
        {
        type = "item",
        name = "asteroid-miner-placeholder",
        place_result = "asteroid-miner-placeholder",
        icons = {
            {
                icon = "__space-exploration-graphics__/graphics/icons/core-miner.png",
                icon_size = 32
            },
            {
                icon = "__space-exploration-bridge-mod__/graphics/icons/asteroid_dust_small.png",
                icon_size = 32,
            }
        },
        subgroup = "space-structures",
        order = "b-".."asteroid-miner-placeholder",
        stack_size = 1
    }
})