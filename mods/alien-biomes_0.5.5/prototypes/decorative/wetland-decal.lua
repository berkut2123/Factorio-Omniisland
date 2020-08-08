data:extend({
  {
    type = "noise-layer",
    name = "wetland-decal"
  },
  {
    name = "wetland-decal",
    type = "optimized-decorative",
    subgroup = "grass",
    order = "b[decorative]-b[puddle-decal]",
    collision_box = {{-4, -4}, {4, 4}},
    collision_mask = {"doodad-layer", "water-tile", "not-colliding-with-itself"},
    render_layer = "decals",
    tile_layer = default_decal_layer,
    autoplace = {
      max_probability = 0.1,
      order = "a[doodad]-b[decal]",
      peaks = {
        {
          influence = -1.2
        },
        {
          influence = 0.1,
          noise_layer = "wetland-decal",
          noise_octaves_difference = -2,
          noise_persistence = 0.8,
        },
        {
          influence = 1,
          water_optimal = 1,
          water_range = 0.2,
          water_max_range = 0.4,
        }
      },
      sharpness = 0.1,
      tile_restriction = alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), {"dirt", "grass"}))
    },
    pictures =
    {
      --decalDark
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-00.png",
        width = 305,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-00.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-01.png",
        width = 307,
        height = 219,
        shift = util.by_pixel(-0.5, -0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-01.png",
          width = 613,
          height = 438,
          shift = util.by_pixel(-0.25, 0),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-02.png",
        width = 307,
        height = 219,
        shift = util.by_pixel(-0.5, -0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-02.png",
          width = 612,
          height = 438,
          shift = util.by_pixel(0, 0),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-03.png",
        width = 305,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-03.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-04.png",
        width = 305,
        height = 219,
        shift = util.by_pixel(-0.5, -0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-04.png",
          width = 612,
          height = 438,
          shift = util.by_pixel(0, 0),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-05.png",
        width = 306,
        height = 217,
        shift = util.by_pixel(-1, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-05.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-06.png",
        width = 307,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-06.png",
          width = 613,
          height = 434,
          shift = util.by_pixel(-0.25, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-07.png",
        width = 306,
        height = 218,
        shift = util.by_pixel(0, 1),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-07.png",
          width = 612,
          height = 435,
          shift = util.by_pixel(0, 1.25),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-08.png",
        width = 305,
        height = 218,
        shift = util.by_pixel(-0.5, 0),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-08.png",
          width = 612,
          height = 436,
          shift = util.by_pixel(0, 0.5),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-09.png",
        width = 306,
        height = 218,
        shift = util.by_pixel(-1, 0),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-09.png",
          width = 612,
          height = 437,
          shift = util.by_pixel(0, 0.25),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-10.png",
        width = 305,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-10.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-11.png",
        width = 306,
        height = 217,
        shift = util.by_pixel(0, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-11.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-12.png",
        width = 306,
        height = 219,
        shift = util.by_pixel(0, -0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-12.png",
          width = 612,
          height = 439,
          shift = util.by_pixel(0, 0.25),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-13.png",
        width = 307,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-13.png",
          width = 612,
          height = 435,
          shift = util.by_pixel(0, 1.25),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-14.png",
        width = 306,
        height = 217,
        shift = util.by_pixel(0, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-14.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-15.png",
        width = 305,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-15.png",
          width = 612,
          height = 435,
          shift = util.by_pixel(0, 0.75),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-16.png",
        width = 305,
        height = 218,
        shift = util.by_pixel(-0.5, 0),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-16.png",
          width = 612,
          height = 437,
          shift = util.by_pixel(0, 0.25),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-17.png",
        width = 307,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-17.png",
          width = 612,
          height = 435,
          shift = util.by_pixel(0, 0.75),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-18.png",
        width = 305,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-18.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-19.png",
        width = 307,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-19.png",
          width = 612,
          height = 435,
          shift = util.by_pixel(0, 0.75),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-20.png",
        width = 305,
        height = 219,
        shift = util.by_pixel(-0.5, -0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-20.png",
          width = 612,
          height = 438,
          shift = util.by_pixel(0, 0),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-21.png",
        width = 307,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-21.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-22.png",
        width = 305,
        height = 218,
        shift = util.by_pixel(-0.5, 1),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-22.png",
          width = 612,
          height = 435,
          shift = util.by_pixel(0, 1.25),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-23.png",
        width = 306,
        height = 217,
        shift = util.by_pixel(0, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-23.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-24.png",
        width = 305,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-24.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-25.png",
        width = 305,
        height = 217,
        shift = util.by_pixel(-0.5, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-25.png",
          width = 612,
          height = 434,
          shift = util.by_pixel(0, 1),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-26.png",
        width = 305,
        height = 218,
        shift = util.by_pixel(-0.5, 0),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-26.png",
          width = 612,
          height = 435,
          shift = util.by_pixel(0, 0.75),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-27.png",
        width = 306,
        height = 217,
        shift = util.by_pixel(-1, 0.5),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-27.png",
          width = 612,
          height = 435,
          shift = util.by_pixel(0, 1.25),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-28.png",
        width = 305,
        height = 218,
        shift = util.by_pixel(-0.5, 0),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-28.png",
          width = 612,
          height = 436,
          shift = util.by_pixel(0, 0.5),
          scale = 0.5
        },
      },
      {
        filename = "__alien-biomes__/graphics/decorative/wetland/wetland-decal-29.png",
        width = 307,
        height = 218,
        shift = util.by_pixel(-0.5, 0),
        hr_version = {
          filename = "__alien-biomes__/graphics/decorative/wetland/hr-wetland-decal-29.png",
          width = 612,
          height = 436,
          shift = util.by_pixel(0, 0.5),
          scale = 0.5
        },
      },
    },
  }})
