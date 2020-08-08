-- technology.lua

data:extend({
    {
        type = "technology",
        name = "asteroid-mining",
        effects = {
            { type = "unlock-recipe", recipe = "asteroid-miner-placeholder" },
            { type = "unlock-recipe", recipe = "asteroid-dust-hydration" }
        },
        icons = {
            {
                icon = "__space-exploration-graphics__/graphics/technology/core-miner.png",
                icon_size = 128
            },
            {            
                icon = "__space-exploration-bridge-mod__/graphics/icons/asteroid_dust_for_tech.png",
                icon_size = 128
            }
        },
        order = "e-g",
        prerequisites = {
            "se-core-miner",
            "se-space-manufactory"
        },
        unit = {
            count = 100,
            time = 10,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "space-science-pack", 1 }
            }
        }
    }
})