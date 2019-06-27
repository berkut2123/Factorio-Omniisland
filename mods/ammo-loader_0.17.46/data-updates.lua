require("prototypes.entity")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.technology")
-- require("prototypes.FuelLoaderChest")

-- local startEnabled = settings.startup["ammo_loader_bypass_research"].value
-- data.raw.recipe["ammo-loader-chest"].enabled = startEnabled
-- data.raw.recipe["fuel-loader-chest"].enabled = startEnabled
-- data.raw.recipe["ammo-loader-storage-loader-chest"].enabled = startEnabled
-- data.raw.recipe["logistic-requester-loader-chest"].enabled = false

controls = {}
-- controls.upgradeKey = {
--     type = "custom-input",
--     name = "ammo-loader-key-upgrade",
--     key_sequence = "CONTROL + SHIFT + Y",
--     consuming = "game-only"
-- }
controls.returnKey = {
    type = "custom-input",
    name = "ammo-loader-key-return",
    key_sequence = "CONTROL + SHIFT + R",
    consuming = "game-only"
}
-- controls.chestGUIKey = {
--     type = "custom-input",
--     name = "ammo-loader-key-chest-filter-GUI",
--     key_sequence = "ALT + W",
--     consuming = "game-only"
-- }
controls.toggleRanges = {
    type = "custom-input",
    name = "ammo-loader-key-toggle-chest-ranges",
    key_sequence = "CONTROL + SHIFT + X",
    consuming = "game-only"
}
for key, val in pairs(controls) do
    data:extend {val}
end
