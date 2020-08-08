local data_util = require("data_util")

data:extend{
    {
        type = 'custom-input',
        name = data_util.mod_prefix .. 'remote-view',
        key_sequence = 'N',
        enabled_while_spectating = true,
    },
    {
        type = 'custom-input',
        name = data_util.mod_prefix .. 'universe-explorer',
        key_sequence = 'U',
        enabled_while_spectating = true,
    },
    {
        type = 'custom-input',
        name = data_util.mod_prefix .. 'respawn',
        key_sequence = "HOME",
        enabled_while_spectating = true,
    }
}
