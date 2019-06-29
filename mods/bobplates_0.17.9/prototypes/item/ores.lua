if not data.raw.item["gold-ore"] then
data:extend(
{
  {
    type = "item",
    name = "gold-ore",
    icon = "__bobplates__/graphics/icons/ore/gold-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[gold-ore]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["wood"] then
data:extend(
{
  {
    type = "item",
    name = "wood",
    icon = "__base__/graphics/icons/wood.png",
    icon_size = 32,
    fuel_value = "3MJ",
    fuel_category = "chemical",
    subgroup = "raw-resource",
    order = "a[wood]",
    stack_size = 100
  },
}
)
end

if not data.raw.item["coal"] then
data:extend(
{
  {
    type = "item",
    name = "coal",
    icon = "__base__/graphics/icons/mip/coal.png",
    icon_size = 64,
    icon_mipmaps = 4,
    dark_background_icon = "__base__/graphics/icons/mip/coal-dark-background.png",
    pictures =
    {
      { size = 64, filename = "__base__/graphics/icons/mip/coal.png",   scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__base__/graphics/icons/mip/coal-1.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__base__/graphics/icons/mip/coal-2.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__base__/graphics/icons/mip/coal-3.png", scale = 0.25, mipmap_count = 4 }
    },
    fuel_category = "chemical",
    fuel_value = "12MJ",
    subgroup = "raw-resource",
    order = "b[coal]",
    stack_size = 50
  },
}
)
end


if not data.raw.item["lead-ore"] then
data:extend(
{
  {
    type = "item",
    name = "lead-ore",
    icon = "__bobplates__/graphics/icons/ore/lead-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[lead-ore]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["silver-ore"] then
data:extend(
{
  {
    type = "item",
    name = "silver-ore",
    icon = "__bobplates__/graphics/icons/ore/silver-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[silver-ore]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["tin-ore"] then
data:extend(
{
  {
    type = "item",
    name = "tin-ore",
    icon = "__bobplates__/graphics/icons/ore/tin-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[tin-ore]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["tungsten-ore"] then
data:extend(
{
  {
    type = "item",
    name = "tungsten-ore",
    icon = "__bobplates__/graphics/icons/ore/tungsten-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[tungsten-ore]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["zinc-ore"] then
data:extend(
{
  {
    type = "item",
    name = "zinc-ore",
    icon = "__bobplates__/graphics/icons/ore/zinc-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[zinc-ore]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["bauxite-ore"] then
data:extend(
{
  {
    type = "item",
    name = "bauxite-ore",
    icon = "__bobplates__/graphics/icons/ore/bauxite-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[bauxite-ore]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["rutile-ore"] then
data:extend(
{
  {
    type = "item",
    name = "rutile-ore",
    icon = "__bobplates__/graphics/icons/ore/rutile-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[rutile-ore]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["quartz"] then
data:extend(
{
  {
    type = "item",
    name = "quartz",
    icon = "__bobplates__/graphics/icons/ore/quartz.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[quartz]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["nickel-ore"] then
data:extend(
{
  {
    type = "item",
    name = "nickel-ore",
    icon = "__bobplates__/graphics/icons/ore/nickel-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[nickel-ore]",
    stack_size = 200
  },
}
)
end

if not data.raw.item["cobalt-ore"] then
data:extend(
{
  {
    type = "item",
    name = "cobalt-ore",
    icon = "__bobplates__/graphics/icons/ore/cobalt-ore.png",
    icon_size = 32,
    subgroup = "bob-ores",
    order = "b-d[cobalt-ore]",
    stack_size = 200
  },
}
)
end
