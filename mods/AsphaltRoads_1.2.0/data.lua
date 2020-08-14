require("prototypes.items")
require("prototypes.recipe")
require("prototypes.technology")
require("prototypes.tiles")
require("prototypes.tile_n2")
require("prototypes.item-subgroups")

data:extend({
    {
        type = "custom-input",
        name = "AR-event-revert-tiles",
        key_sequence = "J",
        consuming = "game-only"
    }
})