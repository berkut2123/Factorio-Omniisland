if settings.startup["bobmods-power-steam"].value == true then

data.raw.item["heat-pipe"].order = "f[nuclear-energy]-c[heat-pipe-1]"

data:extend(
{
  {
    type = "item",
    name = "heat-pipe-2",
    icon = "__bobpower__/graphics/icons/heat-pipe-2.png",
    icon_size = 32,
    subgroup = "energy",
    order = "f[nuclear-energy]-c[heat-pipe-2]",
    place_result = "heat-pipe-2",
    stack_size = 50
  },
  {
    type = "item",
    name = "heat-pipe-3",
    icon = "__bobpower__/graphics/icons/heat-pipe-3.png",
    icon_size = 32,
    subgroup = "energy",
    order = "f[nuclear-energy]-c[heat-pipe-3]",
    place_result = "heat-pipe-3",
    stack_size = 50
  }
}
)

end

if settings.startup["bobmods-power-nuclear"].value == true then

data.raw.item["nuclear-reactor"].order = "f[nuclear-energy]-a[reactor-1]"

data:extend(
{
  {
    type = "item",
    name = "nuclear-reactor-2",
    icon = "__base__/graphics/icons/nuclear-reactor.png",
    icon_size = 32,
    subgroup = "energy",
    order = "f[nuclear-energy]-a[reactor-2]",
    place_result = "nuclear-reactor-2",
    stack_size = 10
  },
  {
    type = "item",
    name = "nuclear-reactor-3",
    icon = "__base__/graphics/icons/nuclear-reactor.png",
    icon_size = 32,
    subgroup = "energy",
    order = "f[nuclear-energy]-a[reactor-3]",
    place_result = "nuclear-reactor-3",
    stack_size = 10
  }
}
)

end
