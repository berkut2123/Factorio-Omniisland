local research_tint = { r = 0, g = 0, b = 0, a = 1 }

data:extend({
    {
        type = "technology",
        name = "warehouse-research-tiny",
        icons = {
            { icon = "__Warehousing__/graphics/research/warehouse-research.png" },
            { icon = "__Warehousing-Compression__/graphics/research/research-mask.png", tint = research_tint },
        },
        icon_size = 128,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "warehouse-small",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-small",
            },
            {
                type = "unlock-recipe",
                recipe = "warehouse-tiny",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-tiny",
            },
        },
        prerequisites = { "steel-processing" },
        unit =
        {
            count = 100,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
            time = 30
        },
        order = "c-a"
    },
    {
        type = "technology",
        name = "warehouse-logistics-research-tiny-1",
        icons = {
            { icon = "__Warehousing__/graphics/research/warehouse-logistics-research.png" },
            { icon = "__Warehousing-Compression__/graphics/research/research-mask.png", tint = research_tint },
        },
        icon_size = 128,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "warehouse-passive-provider-small",
            },
            {
                type = "unlock-recipe",
                recipe = "warehouse-storage-small",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-passive-provider-small",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-storage-small",
            },
            {
                type = "unlock-recipe",
                recipe = "warehouse-passive-provider-tiny",
            },
            {
                type = "unlock-recipe",
                recipe = "warehouse-storage-tiny",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-passive-provider-tiny",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-storage-tiny",
            },
        },
        prerequisites = { "warehouse-research-tiny", "robotics" },
        unit =
        {
            count = 300,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
            time = 30
        },
        order = "c-k-a"
    },
    {
        type = "technology",
        name = "warehouse-logistics-research-tiny-2",
        icons = {
            { icon = "__Warehousing__/graphics/research/warehouse-logistics-research.png" },
            { icon = "__Warehousing-Compression__/graphics/research/research-mask.png", tint = research_tint },
        },
        icon_size = 128,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "warehouse-active-provider-small",
            },
            {
                type = "unlock-recipe",
                recipe = "warehouse-requester-small",
            },
            {
                type = "unlock-recipe",
                recipe = "warehouse-buffer-small",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-active-provider-small",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-requester-small",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-buffer-small",
            },
            {
                type = "unlock-recipe",
                recipe = "warehouse-active-provider-tiny",
            },
            {
                type = "unlock-recipe",
                recipe = "warehouse-requester-tiny",
            },
            {
                type = "unlock-recipe",
                recipe = "warehouse-buffer-tiny",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-active-provider-tiny",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-requester-tiny",
            },
            {
                type = "unlock-recipe",
                recipe = "storehouse-buffer-tiny",
            },
        },
        prerequisites = { "warehouse-logistics-research-tiny-1", "logistic-system" },
        unit =
        {
            count = 600,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 },
            },
            time = 30
        },
        order = "c-k-b"
    },
})
