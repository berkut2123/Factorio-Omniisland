data:extend({
  {
    type = "item",
    name = "plutonium",
    icon = "__Nuclear Fuel__/graphics/icons/plutonium.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "g[uranium-238]z",
    stack_size = 100
  },
  {
    type = "item",
    name = "breeder-fuel-cell",
    icon = "__Nuclear Fuel__/graphics/icons/breeder-fuel-cell.png",
    icon_size = 32,
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
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "i[used-up-uranium-fuel-cell]z",
    stack_size = 50
  }
})