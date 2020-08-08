controls = {}
controls.resetKey = {
    type = "custom-input",
    name = "ammo-loader-key-reset",
    key_sequence = "CONTROL + SHIFT + ALT + BACKSPACE",
    consuming = "game-only"
}
controls.toggleEnabledKey = {
    type = "custom-input",
    name = "ammo-loader-key-toggle-enabled",
    key_sequence = "CONTROL + SHIFT + ALT + EQUALS",
    consuming = "game-only"
}
-- controls.upgradeKey = {
--     type = "custom-input",
--     name = "ammo-loader-key-upgrade",
--     key_sequence = "CONTROL + SHIFT + Y",
--     consuming = "game-only"
-- }
controls.returnKey = {
    type = "custom-input",
    name = "ammo-loader-key-return",
    key_sequence = "CONTROL + SHIFT + ALT + HOME",
    consuming = "game-only"
}
controls.filterWindowKey = {
    type = "custom-input",
    name = "ammo-loader-key-filter-window",
    key_sequence = "SHIFT + E",
    consuming = "game-only"
}
controls.toggleRangesKey = {
    type = "custom-input",
    name = "ammo-loader-key-toggle-chest-ranges",
    key_sequence = "CONTROL + SHIFT + ALT + SLASH"
}
for key, val in pairs(controls) do
    data:extend {val}
end
