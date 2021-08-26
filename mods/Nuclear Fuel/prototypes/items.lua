data:extend({
  {
    type = "item",
    name = "plutonium",
    icon = "__Nuclear Fuel__/graphics/icons/plutonium.png",
    icon_size = 64, icon_mipmaps = 4,
    pictures =
    {
      layers =
      {
        {
          size = 64,
          filename = "__Nuclear Fuel__/graphics/icons/plutonium.png",
          scale = 0.25,
          mipmap_count = 4
        },
        {
          draw_as_light = true,
          blend_mode = "additive",
          size = 64,
          filename = "__Nuclear Fuel__/graphics/icons/plutonium.png",
          scale = 0.25,
          tint = {r = 0.6, g = 0.6, b = 0.6, a = 0.3},
          mipmap_count = 4
        }
      }
    },
    subgroup = "intermediate-product",
    order = "g[uranium-238]z",
    stack_size = 100
  },
  {
    type = "item",
    name = "breeder-fuel-cell",
    icon = "__Nuclear Fuel__/graphics/icons/breeder-fuel-cell.png",
    icon_size = 64, icon_mipmaps = 4,
    pictures =
    {
      layers =
      {
        {
          size = 64,
          filename = "__Nuclear Fuel__/graphics/icons/breeder-fuel-cell.png",
          scale = 0.25,
          mipmap_count = 4
        },
        {
          draw_as_light = true,
          flags = {"light"},
          size = 64,
          filename = "__base__/graphics/icons/uranium-fuel-cell-light.png",
          scale = 0.25,
          mipmap_count = 4
        }
      }
    },
    subgroup = "intermediate-product",
    order = "r[uranium-processing]-a[uranium-fuel-cell]z",
    fuel_category = "nuclear",
    burnt_result = "used-up-breeder-fuel-cell",
    fuel_value = "4GJ",
    stack_size = 50
  },
  {
    type = "item",
    name = "used-up-breeder-fuel-cell",
    icon = "__Nuclear Fuel__/graphics/icons/used-up-breeder-fuel-cell.png",
    icon_size = 64, icon_mipmaps = 4,
    pictures =
    {
      layers =
      {
        {
          size = 64,
          filename = "__Nuclear Fuel__/graphics/icons/used-up-breeder-fuel-cell.png",
          scale = 0.25,
          mipmap_count = 4
        },
        {
          draw_as_light = true,
          flags = {"light"},
          size = 64,
          filename = "__base__/graphics/icons/uranium-fuel-cell-light.png",
          scale = 0.25,
          mipmap_count = 4
        }
      }
    },
    subgroup = "intermediate-product",
    order = "i[used-up-uranium-fuel-cell]z",
    stack_size = 50
  }
})