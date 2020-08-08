--recipe.lua

local asteroid_dust_bottom_right = 

data:extend({
    {
        type = "recipe",
        name = "asteroid-dust-hydration",
        category = "washing-plant",
        energy_required = 1,
        ingredients =
        {
          {"asteroid-dust", 1},
          {type="fluid", name= "water", amount = 10}
        },
        result = "solid-mud",
        enabled = false
    },
    {
        type = "recipe",
        name = "asteroid-miner-placeholder",
        category = "space-manufacturing",
        enabled = false,
        energy_required = 5,
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
        ingredients = 
        {
            {"electric-mining-drill", 1},
            {"se-heat-shielding", 5},
            {"low-density-structure", 10},
            {"electric-engine-unit", 8},
            {"processing-unit", 5},
        },
        results = 
        {
          {type = "item", name = "asteroid-miner-placeholder", amount = 1}
        },
        order = "zzz-asteroid-miner",
        always_show_made_in = true
    }
})