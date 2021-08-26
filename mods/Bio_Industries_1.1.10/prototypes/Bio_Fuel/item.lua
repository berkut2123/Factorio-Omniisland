local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.modRoot .. "/graphics/icons/"


-- Changed for 0.18.29: We always want to make advanced fertilizer, so we need to
-- unlock the bio-reactor and the most basic recipe for algae biomass even if
-- BI.Settings.BI_Bio_Fuel has been turned off!
data:extend({
  --- BioReactor
  {
    type = "item",
    name = "bi-bio-reactor",
    icon = ICONPATH .. "bioreactor.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "bioreactor.png",
        icon_size = 64,
      }
    },
    subgroup = "production-machine",
    order = "z[bi]-a[bi-bio-reactor]",
    place_result = "bi-bio-reactor",
    stack_size = 10
  },
})


if BI.Settings.BI_Bio_Fuel then
  data:extend({
    ---- Cellulose
    {
      type = "item",
      name = "bi-cellulose",
      icon = ICONPATH .. "cellulose.png",
      icon_size = 64,
      icons = {
        {
          icon = ICONPATH .. "cellulose.png",
          icon_size = 64,
        }
      },
      subgroup = "intermediate-product",
      order = "b[cellulose]",
      stack_size = 200
    },

    --~ --- BioReactor
    --~ {
      --~ type = "item",
      --~ name = "bi-bio-reactor",
      --~ icon = ICONPATH .. "bioreactor.png",
      --~ icon_size = 64,
      --~ icons = {
        --~ {
          --~ icon = ICONPATH .. "bioreactor.png",
          --~ icon_size = 64,
        --~ }
      --~ },
      --~ --flags = {"goes-to-quickbar"},
      --~ subgroup = "production-machine",
      --~ order = "z[bi]-a[bi-bio-reactor]",
      --~ place_result = "bi-bio-reactor",
      --~ stack_size = 10
    --~ },
    --- Bio Boiler
    {
      type = "item",
      name = "bi-bio-boiler",
      icon = ICONPATH .. "bio_boiler.png",
      icon_size = 64,
      icons = {
        {
          icon = ICONPATH .. "bio_boiler.png",
          icon_size = 64,
        }
      },
      subgroup = "energy",
      order = "b[steam-power]-b[boiler]",
      place_result = "bi-bio-boiler",
      stack_size = 50
    },
  })
end
