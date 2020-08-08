local data_util = require("data_util")

require("prototypes/phase-multi/no-recycle")

require("prototypes/phase-2/recipe-update")

require("prototypes/phase-2/modules")

require("prototypes/phase-2/capsules")

require("prototypes/phase-2/compatibility/general")
require("prototypes/phase-2/compatibility/krastorio2/krastorio2")

-- this is where space science pack goes now in SE, but other mods are more free to change it than when it was a critical mid-game pack.
data_util.tech_add_prerequisites("space-science-pack", {data_util.mod_prefix .. "processing-cryonite", "production-science-pack", "uranium-processing",})
data_util.tech_add_ingredients("space-science-pack", {"production-science-pack"}, true)
