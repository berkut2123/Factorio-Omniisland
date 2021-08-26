local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.modRoot .. "/graphics/icons/"

if BI.Settings.BI_Solar_Additions then

  data:extend({
    -- Solar Farm
    {
      type = "item",
      name = "bi-bio-solar-farm",
      localised_name = {"entity-name.bi-bio-solar-farm"},
      localised_description = {"entity-description.bi-bio-solar-farm"},
      icon = ICONPATH .. "Bio_Solar_Farm_Icon.png",
      icon_size = 64,
      icons = {
        {
          icon = ICONPATH .. "Bio_Solar_Farm_Icon.png",
          icon_size = 64,
        }
      },
      subgroup = "energy",
      order = "d[solar-panel]-a[solar-panel]-a[bi-bio-solar-farm]",
      place_result = "bi-bio-solar-farm",
      stack_size = 10,
    },

    --- Solar Mat
    {
      type = "item",
      name = "bi-solar-mat",
      localised_name = {"entity-name.bi-solar-mat"},
      localised_description = {"entity-description.bi-solar-mat"},
      icon = ICONPATH .. "solar-mat.png",
      icon_size = 64,
      icons = {
        {
          icon = ICONPATH .. "solar-mat.png",
          icon_size = 64,
        }
      },
      subgroup = "energy",
      order = "d[solar-panel]-aa[solar-panel-1-a]",
      stack_size = 400,
      place_as_tile = {
        result = "bi-solar-mat",
        condition_size = 4,
        condition = { "water-tile" }
      }
    },


    --- BI Accumulator
    {
      type = "item",
      name = "bi-bio-accumulator",
      localised_name = {"entity-name.bi-bio-accumulator"},
      localised_description = {"entity-description.bi-bio-accumulator"},
      icon = ICONPATH .. "bi_LargeAccumulator.png",
      icon_size = 64,
      icons = {
        {
          icon = ICONPATH .. "bi_LargeAccumulator.png",
          icon_size = 64,
        }
      },
      subgroup = "energy",
      order = "e[accumulator]-a[bi-accumulator]",
      place_result = "bi-bio-accumulator",
      stack_size = 5
    },


    --- Large Substation
    {
      type = "item",
      name = "bi-large-substation",
      localised_name = {"entity-name.bi-large-substation"},
      localised_description = {"entity-description.bi-large-substation"},
      icon = ICONPATH .. "bi_LargeSubstation_icon.png",
      icon_size = 64,
      icons = {
        {
          icon = ICONPATH .. "bi_LargeSubstation_icon.png",
          icon_size = 64,
        }
      },
      subgroup = "energy-pipe-distribution",
      order = "a[energy]-d[substation]-b[large-substation]",
      place_result = "bi-large-substation",
      stack_size = 10
    },

    ----- Solar Boiler - Boiler
    {
      type = "item",
      name = "bi-solar-boiler",
      localised_name = {"entity-name.bi-solar-boiler"},
      localised_description = {"entity-description.bi-solar-boiler"},
      icon = ICONPATH .. "Bio_Solar_Boiler_Icon.png",
      icon_size = 64,
      icons = {
        {
          icon = ICONPATH .. "Bio_Solar_Boiler_Icon.png",
          icon_size = 64,
        }
      },
      subgroup = "energy",
      order = "b[steam-power]-c[steam-engine]",
      place_result = "bi-solar-boiler",
      stack_size = 20,
    },
  })
end
