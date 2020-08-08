if settings.startup["nuclear-fuel-cycle-type"].value == "classic" then
  -- Quadruple uranium fuel reprocessing time and products
  data.raw["recipe"]["nuclear-fuel-reprocessing"].energy_required = 240
  data.raw["recipe"]["nuclear-fuel-reprocessing"].ingredients = {
    {"used-up-uranium-fuel-cell", 20}
  }
  data.raw["recipe"]["nuclear-fuel-reprocessing"].results = {
    {"plutonium", 1},
    {"uranium-238", 12}
  }
  
  data:extend({
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
          amount = 4
        },
        {
          name = "uranium-235",
          amount = 1
        }
      }
    }
  })
else
  -- Double uranium fuel reprocessing time and products
  data.raw["recipe"]["nuclear-fuel-reprocessing"].energy_required = 120
  data.raw["recipe"]["nuclear-fuel-reprocessing"].ingredients = {
    {"used-up-uranium-fuel-cell", 10}
  }
  data.raw["recipe"]["nuclear-fuel-reprocessing"].results = {
    {"plutonium", 1},
    {"uranium-238", 4}
  }
  
  data:extend({
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
        }
      }
    }
  })
end

if settings.startup["nuclear-fuel-bomb-ingredient"].value == "plutonium" then
  -- Change atomic bomb to use plutonium
  data.raw["recipe"]["atomic-bomb"].icon = "__Nuclear Fuel__/graphics/icons/atomic-bomb-pu.png"
  data.raw["recipe"]["atomic-bomb"].icon_size = 32
  data.raw["recipe"]["atomic-bomb"].ingredients = {
    {"rocket-control-unit", 10},
    {"explosives", 10},
    {"plutonium", 5}
  }
elseif settings.startup["nuclear-fuel-bomb-ingredient"].value == "both" then
  -- Change atomic bomb recipe icon to indicate uranium
  data.raw["recipe"]["atomic-bomb"].icon = "__Nuclear Fuel__/graphics/icons/atomic-bomb-u-235.png"
  data.raw["recipe"]["atomic-bomb"].icon_size = 32
  data:extend({
    {
      type = "recipe",
      name = "atomic-bomb-pu",
      icon = "__Nuclear Fuel__/graphics/icons/atomic-bomb-pu.png",
      icon_size = 32,
      enabled = false,
      energy_required = 50,
      ingredients =
      {
        {"rocket-control-unit", 10},
        {"explosives", 10},
        {"plutonium", 5}
      },
      result = "atomic-bomb"
    }
  })
end -- No change from vanilla needed if "uranium" option is selected

-- Change nuclear rocket fuel icon for original recipe
data.raw["recipe"]["nuclear-fuel"].icon = "__Nuclear Fuel__/graphics/icons/nuclear-fuel-u-235.png"
data.raw["recipe"]["nuclear-fuel"].icon_size = 32
data.raw["recipe"]["nuclear-fuel"].icon_mipmaps = nil

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
  }
})