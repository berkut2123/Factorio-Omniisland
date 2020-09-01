aai_industry = true
if not logged_mods_once then logged_mods_once = true log("Log mods once: "..serpent.block(mods)) end

data:extend({
  {
    type = "fuel-category",
    name = "processed-chemical",
  }
})

require("prototypes/item/item")
require("prototypes/recipe/recipe")
require("prototypes/entity/resources")
require("prototypes/entity/entity")
require("prototypes/entity/entity-ship-wreck")
require("prototypes/entity/entity-walls")
require("prototypes/entity/entity-burner-lab")
require("prototypes/entity/entity-offshore-pump")
require("prototypes/entity/entity-burner-turbine")
require("prototypes/entity/entity-burner-assembling-machine")

require("prototypes/combined/processed-fuel")

require("prototypes/technology/technology")

require("prototypes/combined/industrial-furnace")

require("prototypes/combined/area-mining-drill")
