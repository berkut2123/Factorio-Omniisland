local names = require("prototypes.names")
local util = require("prototypes.util")

local entities = {}

local basicAmmoPic = {
    filename = util.filePath(names.loaderChest, "entity"),
    priority = "extra-high",
    width = 45,
    height = 32,
    shift = {0.1875, 0}
    --shift = {0, 0}
}
-- local basicFuelPic = {
--     filename = "__ammo-loader__/graphics/entity/FuelLoaderChest.png",
--     priority = "extra-high",
--     width = 44,
--     height = 32,
--     shift = {0.1875, 0}
--     --shift = {0, 0}
-- }
local invisInserterPic = util.invisPic
-- local platPic = data.raw["inserter"]["fast-inserter"].platform_picture

entities.hiddenInserter =
    util.modifiedEnt(
    data.raw["inserter"]["fast-inserter"],
    {
        name = names.hiddenInserter,
        filter_count = 4,
        allow_custom_vectors = true,
        flags = {
            "not-on-map",
            -- "hide-from-bonus-gui",
            "hide-alt-info",
            "not-deconstructable",
            "not-repairable",
            "not-blueprintable"
            -- "placeable-off-grid"
        },
        -- selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        -- icon = util.invisIcon,
        -- icon_size = 1,
        selection_box = {{0, 0}, {0, 0}},
        collision_box = {{0, 0}, {0, 0}},
        drawing_box = {{0, 0}, {0, 0}},
        pickup_position = {-0.5, 0.5},
        insert_position = {0.5, 0.5},
        -- energy_per_movement = 0.0001,
        -- energy_per_rotation = 0.0001,
        extension_speed = 1000,
        rotation_speed = 1000,
        -- energy_source = {
        --     type = "electric",
        --     usage_priority = "secondary-input",
        --     drain = "0kW",
        --     buffer_capacity = "1000kW",
        --     render_no_power_icon = false,
        --     render_no_network_icon = false
        -- },
        energy_source = {
            type = "void"
        },
        selectable_in_game = false,
        allow_copy_paste = false,
        next_upgrade = "",
        draw_held_item = false,
        hand_size = 0,
        corpse = nil,
        -- platform_picture = {sheet = util.invisPic},
        platform_picture = {
            sheets = {
                {
                    filename = "__ammo-loader__/graphics/entity/mask.png",
                    priority = "extra-high",
                    shift = {0.15625, 0.0703125},
                    width = 53,
                    height = 43,
                    tint = {r = 0, g = 0, b = 0, a = 0},
                    hr_version = {
                        filename = "__ammo-loader__/graphics/entity/hr-mask.png",
                        priority = "extra-high",
                        shift = {0.15625, 0.0703125},
                        width = 106,
                        height = 85,
                        y = 85,
                        scale = 0.5,
                        tint = {r = 0, g = 0, b = 0, a = 0}
                    }
                }
            }
        },
        -- platform_picture = {
        --     sheets = {
        --         {
        --             tint = {r = 0, g = 0, b = 0, a = 0},
        --             hr_version = {
        --                 tint = {r = 0, g = 0, b = 0, a = 0}
        --             }
        --         }
        --     }
        -- },
        hand_base_picture = util.invisPic,
        hand_open_picture = util.invisPic,
        hand_closed_picture = util.invisPic,
        hand_base_shadow = util.invisPic,
        hand_open_shadow = util.invisPic,
        hand_closed_shadow = util.invisPic
    },
    {
        -- minable = {mining_time = 5, result = nil},
        minable = nil,
        collision_mask = {}
    }
)

entities.basicAmmoChest =
    util.modifiedEnt(
    data.raw["container"]["iron-chest"],
    {
        name = names.loaderChest,
        minable = {result = names.loaderChest},
        picture = basicAmmoPic,
        inventory_size = 16
        -- render_not_in_network_icon = false
    }
)

entities.requesterChest =
    util.modifiedEnt(
    data.raw["logistic-container"]["logistic-chest-requester"],
    {
        name = names.requesterChest,
        minable = {result = names.requesterChest},
        picture = {
            filename = util.filePath(names.requesterChest, "entity"),
            priority = "extra-high",
            width = 45,
            height = 32,
            shift = {0.1875, 0}
            --shift = {0, 0}
        },
        inventory_size = 32,
        render_not_in_network_icon = false,
        logistic_slots_count = 4
    }
)

entities.storageChest =
    util.modifiedEnt(
    data.raw["logistic-container"]["logistic-chest-storage"],
    {
        name = names.storageChest,
        minable = {result = names.storageChest},
        picture = {
            filename = util.filePath(names.storageChest, "entity"),
            priority = "extra-high",
            width = 45,
            height = 32,
            shift = {0.1875, 0}
            --shift = {0, 0}
        },
        render_not_in_network_icon = false,
        inventory_size = 50
    }
)

-- entities.rangeIndicator = {
--     name = names.rangeIndicator,
--     type = "simple-entity",
--     flags = {
--         -- "not-on-map",
--         "not-rotatable",
--         -- "hide-from-bonus-gui",
--         "hide-alt-info",
--         "not-deconstructable",
--         "not-blueprintable",
--         "placeable-off-grid",
--         "not-flammable"
--     },
--     minable = {mining_time = 0, results = {}},
--     selectable_in_game = false,
--     tile_width = 1,
--     tile_height = 1,
--     picture = {
--         filename = util.filePath(names.rangeIndicator, "entity"),
--         priority = "extra-high",
--         width = 32,
--         height = 32
--     },
--     map_color = {r = 0.858, g = 0.301, b = 0.741, a = 0.25}
-- }

for k, v in pairs(entities) do
    data:extend {v}
end
