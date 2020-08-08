data:extend{
    {
        type = "int-setting",
        name = "aai-structs-tick_limit",
        setting_type = "startup",
        default_value = 6,
        minimum_value = 0,
        maximum_value = 900,
    },
    {
        type = "bool-setting",
        name = "aai-structs-output_pulse",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "int-setting",
        name = "aai-max-structs-per-tick",
        setting_type = "runtime-global",
        default_value = 0,
        minimum_value = 0,
        maximum_value = 1000,
    }
}
