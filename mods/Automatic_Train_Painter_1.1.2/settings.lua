data:extend({
    {
        type = "bool-setting",
        name = "paint-loco",
        order = "aa",
        setting_type = "runtime-global",
        default_value = true,
    },
    {
        type = "bool-setting",
        name = "paint-cargo-wagon",
        order = "ab",
        setting_type = "runtime-global",
        default_value = false,
    },
	{
        type = "bool-setting",
        name = "paint-fluid-wagon",
        order = "ac",
        setting_type = "runtime-global",
        default_value = false,
    },
	{
        type = "bool-setting",
        name = "unpaint-empty",
        order = "ad",
        setting_type = "runtime-global",
        default_value = true,
    },
    {
        type = "string-setting",
        name = "u-loco",
        order = "ba",
        setting_type = "runtime-global",
        default_value = "E4D1C7",
    },
    {
        type = "string-setting",
        name = "u-cargo-wagon",
        order = "bb",
        setting_type = "runtime-global",
        default_value = "6D3A00",
    },
    {
        type = "string-setting",
        name = "u-fluid-wagon",
        order = "bc",
        setting_type = "runtime-global",
        default_value = "C8C8C8",
    },
--    {
--        type = "bool-setting",
--        name = "custom-colors",
--        order = "ca",
--        setting_type = "startup",
--        default_value = false,
--    },
    {
        type = "bool-setting",
        name = "loc-eqpm-grid",
        order = "cb",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "int-setting",
        name = "loc-eqpm-grid-w",
        order = "cc",
        setting_type = "startup",
        minimum_value = 2,
        default_value = 2,
        maximum_value = 16
    },
    {
        type = "int-setting",
        name = "loc-eqpm-grid-h",
        order = "cd",
        setting_type = "startup",
        minimum_value = 2,
        default_value = 4,
        maximum_value = 16
    }
})