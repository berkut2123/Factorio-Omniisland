local names = require("prototypes.names")
local util = require("prototypes.util")

local recipes = {}
local startEnabled = settings.startup["ammo_loader_bypass_research"].value
recipes.ammoLoader = {
    type = "recipe",
    name = names.loaderChest,
    ingredients = {
        {"electronic-circuit", 20},
        {"iron-chest", 2},
        {"burner-inserter", 3}
    },
    enabled = startEnabled,
    energy_required = 2,
    result = names.loaderChest
}
recipes.requester1 =
    util.modifiedEnt(
    data.raw["recipe"]["logistic-chest-requester"],
    {
        type = "recipe",
        name = names.requesterChest,
        enabled = startEnabled,
        ingredients = {
            {"electronic-circuit", 30},
            {"steel-chest", 2},
            {"fast-inserter", 3}
        },
        energy_required = 2,
        result = names.requesterChest
    }
)
recipes.storage = {
    type = "recipe",
    name = names.storageChest,
    enabled = startEnabled,
    ingredients = {
        {"iron-chest", 3},
        {"electronic-circuit", 30},
        {"filter-inserter", 2}
    },
    result = names.storageChest
}

for k, v in pairs(recipes) do
    data:extend {v}
end
