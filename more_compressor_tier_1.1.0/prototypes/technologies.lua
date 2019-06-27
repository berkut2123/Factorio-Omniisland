-------------------------------------------------------------------------------
--[[Create Technologies]]--
-------------------------------------------------------------------------------
local tech12 = {
    type = "technology",
    name = "compressor-tier-1",
    icon = "__omnimatter_compression__/graphics/compress-tech.png",
    icon_size = 128,
    order = "z",
    effects = {{type = "unlock-recipe",recipe="auto-compressor-1"}},
    upgrade = true,
    prerequisites = {"compression-initial"},
    unit =
    {
        count = 2000,
        ingredients =
        {
            {"automation-science-pack",1},
            {"logistic-science-pack",1},
            {"chemical-science-pack",1},
            {"production-science-pack",1},
        },
        time = 30
    }
}local tech13 = {
    type = "technology",
    name = "compressor-tier-2",
    icon = "__omnimatter_compression__/graphics/compress-tech.png",
    icon_size = 128,
    order = "z",
    effects = {{type = "unlock-recipe",recipe="auto-compressor-2"}},
    upgrade = true,
    prerequisites = {"compressor-tier-1"},
    unit =
    {
        count = 1500,
        ingredients =
        {
            {"automation-science-pack",2},
            {"logistic-science-pack",2},
            {"chemical-science-pack",2},
            {"production-science-pack",1},
        },
        time = 45
    }
}local tech14 = {
    type = "technology",
    name = "compressor-tier-3",
    icon = "__omnimatter_compression__/graphics/compress-tech.png",
    icon_size = 128,
    order = "z",
    effects = {{type = "unlock-recipe",recipe="auto-compressor-3"}},
    upgrade = true,
    prerequisites = {"compressor-tier-2"},
    unit =
    {
        count = 4000,
        ingredients =
        {
            {"automation-science-pack",1},
            {"logistic-science-pack",1},
            {"chemical-science-pack",1},
            {"production-science-pack",1},
            {"utility-science-pack",1},
        },
        time = 60
    }
}
data:extend({tech12,tech13,tech14})