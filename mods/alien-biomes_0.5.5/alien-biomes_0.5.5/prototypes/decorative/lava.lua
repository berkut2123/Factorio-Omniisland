-- TODO: finish painting decals
local data_util = require("data-util")
data:extend({
{
  type = "noise-layer",
  name = "puddle-decal"
}
})
local lava_decal_base = {
  name = "lava-decal",
  type = "optimized-decorative",
  subgroup = "grass",
  order = "b[decorative]-b[lava-decal]",
  collision_box = {{-8, -8}, {8, 8}},
  collision_mask = {"doodad-layer", "water-tile", "not-colliding-with-itself"},
  render_layer = "decals",
  tile_layer = default_decal_layer,
  autoplace = {
    max_probability = 0.01,
    order = "a[doodad]-b[decal]",
    peaks = {
      {
         influence = -1
      },
      {
        infleunce = 0.1,
        noise_layer = "puddle-decal",
        noise_octaves_difference = -2,
        noise_persistence = 0.95,
      },
      {
        influence = 1,
        temperature_optimal = 150,
        temperature_range = 50,
        temperature_max_range = 60,
      }
    },
    sharpness = 0.7,
  },
  pictures =
  {
    --[[
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-00.png",
      width = 174,
      height = 134,
      shift = util.by_pixel(5, -2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-00.png",
        width = 351,
        height = 267,
        shift = util.by_pixel(4.25, -1.75),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-01.png",
      width = 151,
      height = 130,
      shift = util.by_pixel(2.5, -3),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-01.png",
        width = 305,
        height = 262,
        shift = util.by_pixel(2.25, -3),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-02.png",
      width = 163,
      height = 135,
      shift = util.by_pixel(-8.5, -0.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-02.png",
        width = 327,
        height = 270,
        shift = util.by_pixel(-8.25, -0.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-03.png",
      width = 127,
      height = 135,
      shift = util.by_pixel(10.5, -1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-03.png",
        width = 258,
        height = 268,
        shift = util.by_pixel(10, -1.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-04.png",
      width = 114,
      height = 100,
      shift = util.by_pixel(9, 3),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-04.png",
        width = 231,
        height = 201,
        shift = util.by_pixel(8.75, 3.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-05.png",
      width = 146,
      height = 116,
      shift = util.by_pixel(12, 6),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-05.png",
        width = 295,
        height = 234,
        shift = util.by_pixel(12.25, 6.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-06.png",
      width = 133,
      height = 85,
      shift = util.by_pixel(-6.5, 0.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-06.png",
        width = 271,
        height = 172,
        shift = util.by_pixel(-5.75, 0.5),
        scale = 0.5
      },
    },]]--
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-07.png",
      width = 139,
      height = 118,
      shift = util.by_pixel(-1.5, 6),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-07.png",
        width = 282,
        height = 266,
        shift = util.by_pixel(-1.5, -1.5),
        scale = 0.5
      },
    },
    --[[{
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-08.png",
      width = 188,
      height = 114,
      shift = util.by_pixel(0, -7),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-08.png",
        width = 377,
        height = 231,
        shift = util.by_pixel(-0.25, -7.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-09.png",
      width = 170,
      height = 100,
      shift = util.by_pixel(9, 6),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-09.png",
        width = 376,
        height = 202,
        shift = util.by_pixel(0, 6),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-10.png",
      width = 184,
      height = 116,
      shift = util.by_pixel(-1, 3),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-10.png",
        width = 372,
        height = 234,
        shift = util.by_pixel(-1, 3.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-11.png",
      width = 171,
      height = 111,
      shift = util.by_pixel(-1.5, 1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-11.png",
        width = 344,
        height = 224,
        shift = util.by_pixel(-1.5, 1.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-12.png",
      width = 138,
      height = 94,
      shift = util.by_pixel(-10, 4),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-12.png",
        width = 290,
        height = 189,
        shift = util.by_pixel(-8, 4.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-13.png",
      width = 159,
      height = 109,
      shift = util.by_pixel(-4.5, -3.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-13.png",
        width = 326,
        height = 228,
        shift = util.by_pixel(-3, -2),
        scale = 0.5
      },
    },]]--
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-14.png",
      width = 153,
      height = 111,
      shift = util.by_pixel(-13.5, 4.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-14.png",
        width = 312,
        height = 225,
        shift = util.by_pixel(-13.5, 4.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-15.png",
      width = 178,
      height = 92,
      shift = util.by_pixel(-5, 4),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-15.png",
        width = 359,
        height = 186,
        shift = util.by_pixel(-4.25, 4.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-16.png",
      width = 142,
      height = 117,
      shift = util.by_pixel(11, 6.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-16.png",
        width = 287,
        height = 266,
        shift = util.by_pixel(10.75, -1.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-17.png",
      width = 188,
      height = 133,
      shift = util.by_pixel(0, -1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-17.png",
        width = 377,
        height = 267,
        shift = util.by_pixel(0.25, -1.75),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-18.png",
      width = 186,
      height = 135,
      shift = util.by_pixel(1, -1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-18.png",
        width = 375,
        height = 269,
        shift = util.by_pixel(0.25, -1.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-19.png",
      width = 171,
      height = 134,
      shift = util.by_pixel(-0.5, -1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-19.png",
        width = 346,
        height = 270,
        shift = util.by_pixel(-0.5, -1),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-20.png",
      width = 129,
      height = 99,
      shift = util.by_pixel(-3.5, 0.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-20.png",
        width = 261,
        height = 198,
        shift = util.by_pixel(-3.25, 0.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-21.png",
      width = 134,
      height = 101,
      shift = util.by_pixel(3, -8.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-21.png",
        width = 270,
        height = 205,
        shift = util.by_pixel(2.5, -8.75),
        scale = 0.5
      },
    },
    --[[{
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-22.png",
      width = 131,
      height = 105,
      shift = util.by_pixel(-11.5, 5.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-22.png",
        width = 266,
        height = 212,
        shift = util.by_pixel(-11.5, 5.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-23.png",
      width = 145,
      height = 80,
      shift = util.by_pixel(13.5, -10),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-23.png",
        width = 292,
        height = 164,
        shift = util.by_pixel(13.5, -10.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-24.png",
      width = 188,
      height = 115,
      shift = util.by_pixel(0, 2.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-24.png",
        width = 377,
        height = 232,
        shift = util.by_pixel(-0.25, 2.5),
        scale = 0.5
      },
    },]]--
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-25.png",
      width = 188,
      height = 100,
      shift = util.by_pixel(0, -3),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-25.png",
        width = 376,
        height = 204,
        shift = util.by_pixel(0, -3),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-26.png",
      width = 186,
      height = 107,
      shift = util.by_pixel(-1, -12.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-26.png",
        width = 376,
        height = 214,
        shift = util.by_pixel(0, -13),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-27.png",
      width = 188,
      height = 103,
      shift = util.by_pixel(0, -5.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-27.png",
        width = 378,
        height = 209,
        shift = util.by_pixel(0, -4.75),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-28.png",
      width = 188,
      height = 95,
      shift = util.by_pixel(0, 3.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-28.png",
        width = 378,
        height = 198,
        shift = util.by_pixel(0, 5),
        scale = 0.5
      },
    },
    --[[{
      filename = "__alien-biomes__/graphics/decorative/lava/|color|/sr/lava-decal-29.png",
      width = 176,
      height = 108,
      shift = util.by_pixel(6, 0),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/lava/|color|/hr/lava-decal-29.png",
        width = 352,
        height = 218,
        shift = util.by_pixel(6, 0),
        scale = 0.5
      },
    },]]--
  },
}
local variants = { }
if settings.startup["alien-biomes-include-volcanic-orange"].value ~= "Disabled" then
  table.insert(variants, "orange")
end
if settings.startup["alien-biomes-include-volcanic-green"].value ~= "Disabled"  then
  table.insert(variants, "green")
end
if settings.startup["alien-biomes-include-volcanic-blue"].value ~= "Disabled"  then
  table.insert(variants, "blue")
end
if settings.startup["alien-biomes-include-volcanic-purple"].value ~= "Disabled"  then
  table.insert(variants, "purple")
end
local heats = {"heat-2", "heat-3", "heat-4"}
for _, variant in pairs(variants) do
  local lava = table.deepcopy(lava_decal_base)
  lava.name = lava.name .. "-" .. variant
  lava.autoplace.tile_restriction = {}
  for _, heat in pairs(heats) do
    table.insert(lava.autoplace.tile_restriction, "volcanic-" .. variant .. "-" .. heat)
  end
  data_util.replace_filenames_recursive(lava.pictures, "|color|", variant)
  data:extend({lava})
end
