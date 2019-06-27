-- Quadruple uranium fuel reprocessing time and products
data.raw["recipe"]["nuclear-fuel-reprocessing"].energy_required = 120
data.raw["recipe"]["nuclear-fuel-reprocessing"].ingredients = {
  {"used-up-uranium-fuel-cell", 10}
}
data.raw["recipe"]["nuclear-fuel-reprocessing"].results = {
  {"plutonium", 1},
  {"uranium-238", 4}
}

-- Change atomic bomb to use plutonium
data.raw["recipe"]["atomic-bomb"].ingredients = {
  {"rocket-control-unit", 10},
  {"explosives", 10},
  {"plutonium", 5}
}

-- Change nuclear rocket fuel icon for original recipe
data.raw["recipe"]["nuclear-fuel"].icon = "__Nuclear Fuel__/graphics/icons/nuclear-fuel-u-235.png"

data:extend({
  {
    type = "recipe",
    name = "mox-fuel-cell",
    icon = "__Nuclear Fuel__/graphics/icons/mox-fuel-cell.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "r[uranium-processing]-a[uranium-fuel-cell]y",
    energy_required = 10,
    enabled = false,
    main_product = "",
    ingredients =
    {
      {"iron-plate", 10},
      {"plutonium", 1},
      {"uranium-238", 9}
    },
    results = {{"uranium-fuel-cell", 10}},
    allow_decomposition = false
  },
  {
    type = "recipe",
    name = "breeder-fuel-cell",
    energy_required = 10,
    enabled = false,
    ingredients =
    {
      {"iron-plate", 10},
      {"plutonium", 1},
      {"uranium-238", 19}
    },
    result = "breeder-fuel-cell",
    result_count = 10
  },
  {
    type = "recipe",
    name = "nuclear-fuel-pu",
    energy_required = 90,
    enabled = false,
    category = "centrifuging",
    ingredients = {{"plutonium", 1}, {"rocket-fuel", 1}},
    icon = "__Nuclear Fuel__/graphics/icons/nuclear-fuel-pu.png",
    icon_size = 32,
    result = "nuclear-fuel"
  },
  {
    type = "recipe",
    name = "breeder-fuel-reprocessing",
    energy_required = 100,
    enabled = false,
    category = "centrifuging",
    ingredients = {{"used-up-breeder-fuel-cell", 10}},
    icon = "__Nuclear Fuel__/graphics/icons/breeder-fuel-reprocessing.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "r[uranium-processing]-b[nuclear-fuel-reprocessing]z",
    allow_decomposition = false,
    main_product = "",
    results =
    {
      {
        name = "plutonium",
        amount = 6
      },
      -- {
        -- name = "uranium-238",
        -- amount = 1
      -- }
    }
  }
})