local rock_coverage_multiplier = 3
local rock_max_prob_multiplier = 6
return {
{
  name = "rock-huge",
  type = "simple-entity",
  flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
  icon = "__base__/graphics/icons/rock-huge.png",
  icon_size = 64, icon_mipmaps = 4,
  subgroup = "grass",
  order = "b[decorative]-l[rock]-a[huge]",
  collision_box = {{-1.5, -1.1}, {1.5, 1.1}},
  selection_box = {{-1.7, -1.3}, {1.7, 1.3}},
  minable =
  {
    mining_particle = "stone-particle",
    mining_time = 1.5,
    results = {{name = "stone", amount_min = 20, amount_max = 40}, {name = "coal", amount_min = 0, amount_max = 20}},
    --count = 200
  },
  loot =
  {
    {item = "stone", probability = 1, count_min = 10, count_max = 20}
  },
  count_as_rock_for_filtered_deconstruction = true,
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  vehicle_impact_sound =  { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 },
  render_layer = "object",
  max_health = 2000,
  resistances =
  {
    { type = "fire", percent = 100 },
    { type = "poison", percent = 100 }
  },
  autoplace = {
    coverage = 0.00125 * rock_coverage_multiplier,
    max_probability = 0.0875 * rock_max_prob_multiplier,
    order = "a[doodad]-a[rock]-a[huge]",
    peaks = {
      {
        noise_layer = "rocks",
        noise_octaves_difference = -2,
        noise_persistence = 0.9,
      }
    },
    sharpness = 0.7
  },
  pictures =
  {
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-05.png",
      width = 101,
      height = 90,
      shift = {0.25, 0.0625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-05.png",
        width = 201,
        height = 179,
        scale = 0.5,
        shift = {0.25, 0.0625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-06.png",
      width = 117,
      height = 86,
      shift = {0.4375, 0.046875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-06.png",
        width = 233,
        height = 171,
        scale = 0.5,
        shift = {0.429688, 0.046875}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-07.png",
      width = 120,
      height = 96,
      shift = {0.390625, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-07.png",
        width = 240,
        height = 192,
        scale = 0.5,
        shift = {0.398438, 0.03125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-08.png",
      width = 110,
      height = 88,
      shift = {0.140625, 0.125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-08.png",
        width = 219,
        height = 175,
        scale = 0.5,
        shift = {0.148438, 0.132812}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-09.png",
      width = 120,
      height = 104,
      shift = {0.3125, 0.0625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-09.png",
        width = 240,
        height = 208,
        scale = 0.5,
        shift = {0.3125, 0.0625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-10.png",
      width = 122,
      height = 95,
      shift = {0.1875, 0.046875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-10.png",
        width = 243,
        height = 190,
        scale = 0.5,
        shift = {0.1875, 0.046875}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-11.png",
      width = 125,
      height = 93,
      shift = {0.390625, 0.0625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-11.png",
        width = 249,
        height = 185,
        scale = 0.5,
        shift = {0.398438, 0.0546875}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-12.png",
      width = 137,
      height = 82,
      shift = {0.34375, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-12.png",
        width = 273,
        height = 163,
        scale = 0.5,
        shift = {0.34375, 0.0390625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-13.png",
      width = 138,
      height = 88,
      shift = {0.265625, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-13.png",
        width = 275,
        height = 175,
        scale = 0.5,
        shift = {0.273438, 0.0234375}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-14.png",
      width = 121,
      height = 108,
      shift = {0.203125, 0.046875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-14.png",
        width = 241,
        height = 215,
        scale = 0.5,
        shift = {0.195312, 0.0390625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-15.png",
      width = 159,
      height = 91,
      shift = {0.515625, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-15.png",
        width = 318,
        height = 181,
        scale = 0.5,
        shift = {0.523438, 0.03125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-16.png",
      width = 109,
      height = 112,
      shift = {0.046875, 0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-16.png",
        width = 217,
        height = 224,
        scale = 0.5,
        shift = {0.0546875, 0.0234375}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-17.png",
      width = 166,
      height = 114,
      shift = {0.234375, 0.046875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-17.png",
        width = 332,
        height = 228,
        scale = 0.5,
        shift = {0.226562, 0.046875}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-18.png",
      width = 145,
      height = 122,
      shift = {0.203125, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-18.png",
        width = 290,
        height = 243,
        scale = 0.5,
        shift = {0.195312, 0.0390625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-19.png",
      width = 175,
      height = 113,
      shift = {0.609375, 0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-19.png",
        width = 349,
        height = 225,
        scale = 0.5,
        shift = {0.609375, 0.0234375}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/rock-huge-20.png",
      width = 144,
      height = 125,
      shift = {0.140625, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-huge/hr-rock-huge-20.png",
        width = 287,
        height = 250,
        scale = 0.5,
        shift = {0.132812, 0.03125}
      },
    }
  }
},
{
  name = "rock-big",
  type = "simple-entity",
  flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
  icon = "__base__/graphics/icons/rock-big.png",
  icon_size = 64, icon_mipmaps = 4,
  subgroup = "grass",
  order = "b[decorative]-l[rock]-b[big]",
  collision_box = {{-1.0, -0.9}, {1.0, 1.0}},
  selection_box = {{-1.2, -1.2}, {1.2, 1.2}},
  minable =
  {
    mining_particle = "stone-particle",
    mining_time = 1,
    result = "stone",
    count = 20
  },
  loot =
  {
    {item = "stone", probability = 1, count_min = 10, count_max = 20}
  },
  count_as_rock_for_filtered_deconstruction = true,
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  vehicle_impact_sound =  { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 },
  render_layer = "object",
  max_health = 500,
  resistances =
  {
    { type = "fire", percent = 100 },
    { type = "poison", percent = 100 }
  },
  autoplace = {
    coverage = 0.002 * rock_coverage_multiplier,
    max_probability = 0.16 * rock_max_prob_multiplier,
    order = "a[doodad]-a[rock]-b[big]",
    peaks = {
      {
        noise_layer = "rocks",
        noise_octaves_difference = -2,
        noise_persistence = 0.9,
      }
    },
    sharpness = 0.7
  },
  pictures =
  {
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-01.png",
      width = 94,
      height = 64,
      shift = {-0.046875, 0.171875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-01.png",
        width = 188,
        height = 127,
        scale = 0.5,
        shift = {-0.046875, 0.171875}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-02.png",
      width = 98,
      height = 68,
      shift = {0.4375, 0.125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-02.png",
        width = 195,
        height = 135,
        scale = 0.5,
        shift = {0.445312, 0.125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-03.png",
      width = 103,
      height = 66,
      shift = {0.484375, 0.0625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-03.png",
        width = 205,
        height = 132,
        scale = 0.5,
        shift = {0.484375, 0.0546875}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-04.png",
      width = 72,
      height = 71,
      shift = {0.21875, 0.046875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-04.png",
        width = 144,
        height = 142,
        scale = 0.5,
        shift = {0.210938, 0.0390625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-05.png",
      width = 65,
      height = 54,
      shift = {0.015625, 0.21875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-05.png",
        width = 130,
        height = 107,
        scale = 0.5,
        shift = {0.0234375, 0.226562}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-06.png",
      width = 83,
      height = 55,
      shift = {0.15625, 0.234375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-06.png",
        width = 165,
        height = 109,
        scale = 0.5,
        shift = {0.15625, 0.226562}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-07.png",
      width = 75,
      height = 67,
      shift = {0.265625, 0.15625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-07.png",
        width = 150,
        height = 133,
        scale = 0.5,
        shift = {0.257812, 0.148438}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-08.png",
      width = 78,
      height = 56,
      shift = {0.09375, 0.171875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-08.png",
        width = 156,
        height = 111,
        scale = 0.5,
        shift = {0.0859375, 0.179688}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-09.png",
      width = 94,
      height = 60,
      shift = {0.078125, 0.09375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-09.png",
        width = 187,
        height = 120,
        scale = 0.5,
        shift = {0.078125, 0.0859375}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-10.png",
      width = 113,
      height = 64,
      shift = {-0.15625, 0.078125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-10.png",
        width = 225,
        height = 128,
        scale = 0.5,
        shift = {-0.15625, 0.0703125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-11.png",
      width = 92,
      height = 72,
      shift = {0.203125, 0.265625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-11.png",
        width = 183,
        height = 144,
        scale = 0.5,
        shift = {0.195312, 0.257812}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-12.png",
      width = 79,
      height = 69,
      shift = {0.046875, 0.15625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-12.png",
        width = 158,
        height = 138,
        scale = 0.5,
        shift = {0.0390625, 0.15625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-13.png",
      width = 94,
      height = 75,
      shift = {0.21875, 0.21875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-13.png",
        width = 188,
        height = 150,
        scale = 0.5,
        shift = {0.226562, 0.21875}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-14.png",
      width = 93,
      height = 80,
      shift = {0.125, 0.0625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-14.png",
        width = 186,
        height = 160,
        scale = 0.5,
        shift = {0.132812, 0.0625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-15.png",
      width = 91,
      height = 87,
      shift = {0.3125, -0.09375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-15.png",
        width = 181,
        height = 174,
        scale = 0.5,
        shift = {0.304688, -0.09375}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-16.png",
      width = 106,
      height = 75,
      shift = {0.34375, 0.125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-16.png",
        width = 212,
        height = 150,
        scale = 0.5,
        shift = {0.335938, 0.117188}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-17.png",
      width = 78,
      height = 59,
      shift = {0.25, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-17.png",
        width = 155,
        height = 117,
        scale = 0.5,
        shift = {0.25, 0.0390625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-18.png",
      width = 71,
      height = 64,
      shift = {0.3125, 0.046875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-18.png",
        width = 141,
        height = 128,
        scale = 0.5,
        shift = {0.304688, 0.0390625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-19.png",
      width = 88,
      height = 57,
      shift = {0.390625, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-19.png",
        width = 176,
        height = 114,
        scale = 0.5,
        shift = {0.390625, 0.0234375}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/rock-big-20.png",
      width = 60,
      height = 63,
      shift = {0.140625, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-big/hr-rock-big-20.png",
        width = 120,
        height = 125,
        scale = 0.5,
        shift = {0.148438, 0.03125}
      },
    },
  }
},
{
  name = "rock-medium",
  type = "optimized-decorative",
  subgroup = "grass",
  order = "b[decorative]-l[rock]-c[medium]",
  selectable_in_game = false,
  collision_box = {{-1.1, -1.1}, {1.1, 1.1}},
  --selection_box = {{-1.3, -1.3}, {1.3, 1.3}},
  render_layer = "decorative",
  autoplace = {
    coverage = 0.005 * rock_coverage_multiplier,
    max_probability = 0.35 * rock_max_prob_multiplier,
    order = "a[doodad]-a[rock]-c[medium]",
    peaks = {
      {
        noise_layer = "rocks",
        noise_octaves_difference = -2,
        noise_persistence = 0.9,
      }
    },
    sharpness = 0.7
  },
  pictures =
  {
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-01.png",
      priority = base_decorative_sprite_priority,
      width = 45,
      height = 32,
      shift = {0.078125, 0.109375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-01.png",
        priority = base_decorative_sprite_priority,
        width = 89,
        height = 63,
        scale = 0.5,
        shift = {0.078125, 0.109375}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-02.png",
      priority = base_decorative_sprite_priority,
      width = 39,
      height = 33,
      shift = {0.015625, 0.125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-02.png",
        priority = base_decorative_sprite_priority,
        width = 77,
        height = 66,
        scale = 0.5,
        shift = {0.015625, 0.132812}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-03.png",
      priority = base_decorative_sprite_priority,
      width = 46,
      height = 32,
      shift = {0.140625, 0.171875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-03.png",
        priority = base_decorative_sprite_priority,
        width = 92,
        height = 63,
        scale = 0.5,
        shift = {0.148438, 0.179688}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-04.png",
      priority = base_decorative_sprite_priority,
      width = 46,
      height = 30,
      shift = {0, 0.1875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-04.png",
        priority = base_decorative_sprite_priority,
        width = 91,
        height = 59,
        scale = 0.5,
        shift = {-0.0078125, 0.1875}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-05.png",
      priority = base_decorative_sprite_priority,
      width = 52,
      height = 36,
      shift = {0.203125, 0.171875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-05.png",
        priority = base_decorative_sprite_priority,
        width = 104,
        height = 72,
        scale = 0.5,
        shift = {0.203125, 0.179688}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-06.png",
      priority = base_decorative_sprite_priority,
      width = 42,
      height = 41,
      shift = {0.015625, 0.21875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-06.png",
        priority = base_decorative_sprite_priority,
        width = 83,
        height = 82,
        scale = 0.5,
        shift = {0.015625, 0.21875}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-07.png",
      priority = base_decorative_sprite_priority,
      width = 56,
      height = 33,
      shift = {0.0625, 0.3125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-07.png",
        priority = base_decorative_sprite_priority,
        width = 111,
        height = 65,
        scale = 0.5,
        shift = {0.0625, 0.3125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-08.png",
      priority = base_decorative_sprite_priority,
      width = 40,
      height = 41,
      shift = {0.109375, 0.140625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-08.png",
        priority = base_decorative_sprite_priority,
        width = 79,
        height = 81,
        scale = 0.5,
        shift = {0.109375, 0.148438}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-09.png",
      priority = base_decorative_sprite_priority,
      width = 49,
      height = 28,
      shift = {0.015625, 0.140625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-09.png",
        priority = base_decorative_sprite_priority,
        width = 98,
        height = 56,
        scale = 0.5,
        shift = {0.015625, 0.140625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-10.png",
      priority = base_decorative_sprite_priority,
      width = 46,
      height = 34,
      shift = {0, 0.140625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-10.png",
        priority = base_decorative_sprite_priority,
        width = 91,
        height = 68,
        scale = 0.5,
        shift = {0, 0.132812}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-11.png",
      priority = base_decorative_sprite_priority,
      width = 53,
      height = 36,
      shift = {-0.03125, 0.125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-11.png",
        priority = base_decorative_sprite_priority,
        width = 105,
        height = 71,
        scale = 0.5,
        shift = {-0.0234375, 0.125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/rock-medium-12.png",
      priority = base_decorative_sprite_priority,
      width = 39,
      height = 40,
      shift = {0.078125, -0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-medium/hr-rock-medium-12.png",
        priority = base_decorative_sprite_priority,
        width = 78,
        height = 80,
        scale = 0.5,
        shift = {0.078125, -0.015625}
      },
    }
  }
},
{
  name = "rock-small",
  type = "optimized-decorative",
  subgroup = "grass",
  order = "b[decorative]-l[rock]-d[small]",
  selectable_in_game = false,
  collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
  render_layer = "decorative",
  autoplace = {
    coverage = 0.01 * rock_coverage_multiplier,
    max_probability = 0.7 * rock_max_prob_multiplier,
    order = "a[doodad]-a[rock]-d[small]",
    peaks = {
      {
        noise_layer = "rocks",
        noise_octaves_difference = -2,
        noise_persistence = 0.9,
      }
    },
    sharpness = 0.7
  },
  pictures =
  {
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-01.png",
      priority = base_decorative_sprite_priority,
      width = 26,
      height = 19,
      shift = {0.0625, 0.125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-01.png",
        priority = base_decorative_sprite_priority,
        width = 51,
        height = 37,
        scale = 0.5,
        shift = {0.0546875, 0.117188}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-02.png",
      priority = base_decorative_sprite_priority,
      width = 26,
      height = 18,
      shift = {0.046875, 0.078125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-02.png",
        priority = base_decorative_sprite_priority,
        width = 52,
        height = 35,
        scale = 0.5,
        shift = {0.0390625, 0.078125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-03.png",
      priority = base_decorative_sprite_priority,
      width = 23,
      height = 21,
      shift = {-0.015625, 0.140625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-03.png",
        priority = base_decorative_sprite_priority,
        width = 46,
        height = 42,
        scale = 0.5,
        shift = {-0.0078125, 0.148438}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-04.png",
      priority = base_decorative_sprite_priority,
      width = 27,
      height = 17,
      shift = {0.015625, 0.15625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-04.png",
        priority = base_decorative_sprite_priority,
        width = 53,
        height = 33,
        scale = 0.5,
        shift = {0.0234375, 0.15625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-05.png",
      priority = base_decorative_sprite_priority,
      width = 24,
      height = 23,
      shift = {0.046875, 0.140625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-05.png",
        priority = base_decorative_sprite_priority,
        width = 47,
        height = 46,
        scale = 0.5,
        shift = {0.0390625, 0.140625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-06.png",
      priority = base_decorative_sprite_priority,
      width = 31,
      height = 21,
      shift = {-0.03125, 0.09375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-06.png",
        priority = base_decorative_sprite_priority,
        width = 62,
        height = 41,
        scale = 0.5,
        shift = {-0.03125, 0.09375}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-07.png",
      priority = base_decorative_sprite_priority,
      width = 32,
      height = 18,
      shift = {-0.015625, 0.078125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-07.png",
        priority = base_decorative_sprite_priority,
        width = 64,
        height = 36,
        scale = 0.5,
        shift = {-0.015625, 0.0703125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-08.png",
      priority = base_decorative_sprite_priority,
      width = 33,
      height = 16,
      shift = {-0.71875, -0.171875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-08.png",
        priority = base_decorative_sprite_priority,
        width = 65,
        height = 31,
        scale = 0.5,
        shift = {-0.71875, -0.164062}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-09.png",
      priority = base_decorative_sprite_priority,
      width = 23,
      height = 17,
      shift = {-0.09375, 0.109375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-09.png",
        priority = base_decorative_sprite_priority,
        width = 46,
        height = 34,
        scale = 0.5,
        shift = {-0.0859375, 0.101562}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-10.png",
      priority = base_decorative_sprite_priority,
      width = 24,
      height = 17,
      shift = {0, 0.125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-10.png",
        priority = base_decorative_sprite_priority,
        width = 48,
        height = 34,
        scale = 0.5,
        shift = {0.0078125, 0.125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-11.png",
      priority = base_decorative_sprite_priority,
      width = 26,
      height = 17,
      shift = {-0.09375, 0.078125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-11.png",
        priority = base_decorative_sprite_priority,
        width = 51,
        height = 33,
        scale = 0.5,
        shift = {-0.0859375, 0.078125}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-12.png",
      priority = base_decorative_sprite_priority,
      width = 24,
      height = 20,
      shift = {0.078125, 0.109375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-12.png",
        priority = base_decorative_sprite_priority,
        width = 47,
        height = 39,
        scale = 0.5,
        shift = {0.078125, 0.117188}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-13.png",
      priority = base_decorative_sprite_priority,
      width = 22,
      height = 17,
      shift = {0, 0.09375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-13.png",
        priority = base_decorative_sprite_priority,
        width = 43,
        height = 33,
        scale = 0.5,
        shift = {0, 0.09375}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-14.png",
      priority = base_decorative_sprite_priority,
      width = 22,
      height = 15,
      shift = {0.046875, 0.140625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-14.png",
        priority = base_decorative_sprite_priority,
        width = 43,
        height = 30,
        scale = 0.5,
        shift = {0.046875, 0.140625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-15.png",
      priority = base_decorative_sprite_priority,
      width = 21,
      height = 19,
      shift = {0, 0.140625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-15.png",
        priority = base_decorative_sprite_priority,
        width = 41,
        height = 37,
        scale = 0.5,
        shift = {0, 0.140625}
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-16.png",
      priority = base_decorative_sprite_priority,
      width = 23,
      height = 17,
      shift = {0.015625, 0.125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-small/hr-rock-small-16.png",
        priority = base_decorative_sprite_priority,
        width = 46,
        height = 33,
        scale = 0.5,
        shift = {0.0234375, 0.125}
      },
    }
  }
},
{
  name = "rock-tiny",
  type = "optimized-decorative",
  subgroup = "grass",
  order = "b[decorative]-l[rock]-e[tiny]",
  selectable_in_game = false,
  collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
  render_layer = "decorative",
  autoplace = {
    coverage = 0.011000000000000001 * rock_coverage_multiplier,
    max_probability = 0.77000000000000002 * rock_max_prob_multiplier,
    order = "a[doodad]-a[rock]-e[tiny]",
    peaks = {
      {
        noise_layer = "rocks",
        noise_octaves_difference = -2,
        noise_persistence = 0.9,
      }
    },
    sharpness = 0.7
  },
  pictures =
  {
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-01.png",
      priority = base_decorative_sprite_priority,
      width = 15,
      height = 11,
      shift = {0.03125, 0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-01.png",
        priority = base_decorative_sprite_priority,
        width = 29,
        height = 21,
        scale = 0.5,
        shift = {0.0390625, 0.0234375}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-02.png",
      priority = base_decorative_sprite_priority,
      width = 15,
      height = 10,
      shift = {0, 0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-02.png",
        priority = base_decorative_sprite_priority,
        width = 30,
        height = 19,
        scale = 0.5,
        shift = {0.0078125, 0.0234375}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-03.png",
      priority = base_decorative_sprite_priority,
      width = 15,
      height = 12,
      shift = {0.015625, 0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-03.png",
        priority = base_decorative_sprite_priority,
        width = 29,
        height = 24,
        scale = 0.5,
        shift = {0.0234375, 0.0234375}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-04.png",
      priority = base_decorative_sprite_priority,
      width = 16,
      height = 10,
      shift = {0.03125, 0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-04.png",
        priority = base_decorative_sprite_priority,
        width = 32,
        height = 20,
        scale = 0.5,
        shift = {0.03125, 0.015625}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-05.png",
      priority = base_decorative_sprite_priority,
      width = 15,
      height = 13,
      shift = {0, -0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-05.png",
        priority = base_decorative_sprite_priority,
        width = 29,
        height = 25,
        scale = 0.5,
        shift = {0, -0.0078125}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-06.png",
      priority = base_decorative_sprite_priority,
      width = 18,
      height = 12,
      shift = {0, -0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-06.png",
        priority = base_decorative_sprite_priority,
        width = 36,
        height = 24,
        scale = 0.5,
        shift = {0, -0.0234375}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-07.png",
      priority = base_decorative_sprite_priority,
      width = 39,
      height = 17,
      shift = {-0.34375, -0.140625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-07.png",
        priority = base_decorative_sprite_priority,
        width = 78,
        height = 34,
        scale = 0.5,
        shift = {-0.34375, -0.132812}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-08.png",
      priority = base_decorative_sprite_priority,
      width = 18,
      height = 10,
      shift = {-0.03125, 0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-08.png",
        priority = base_decorative_sprite_priority,
        width = 35,
        height = 19,
        scale = 0.5,
        shift = {-0.03125, 0}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-09.png",
      priority = base_decorative_sprite_priority,
      width = 14,
      height = 10,
      shift = {0.015625, 0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-09.png",
        priority = base_decorative_sprite_priority,
        width = 28,
        height = 20,
        scale = 0.5,
        shift = {0.0234375, 0.015625}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-10.png",
      priority = base_decorative_sprite_priority,
      width = 15,
      height = 10,
      shift = {0.015625, -0.03125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-10.png",
        priority = base_decorative_sprite_priority,
        width = 29,
        height = 20,
        scale = 0.5,
        shift = {0.0078125, -0.0234375}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-11.png",
      priority = base_decorative_sprite_priority,
      width = 15,
      height = 10,
      shift = {0.046875, 0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-11.png",
        priority = base_decorative_sprite_priority,
        width = 29,
        height = 20,
        scale = 0.5,
        shift = {0.046875, 0.0078125}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-12.png",
      priority = base_decorative_sprite_priority,
      width = 15,
      height = 11,
      shift = {0.015625, 0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-12.png",
        priority = base_decorative_sprite_priority,
        width = 29,
        height = 22,
        scale = 0.5,
        shift = {0.015625, 0}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-13.png",
      priority = base_decorative_sprite_priority,
      width = 14,
      height = 10,
      shift = {0.03125, 0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-13.png",
        priority = base_decorative_sprite_priority,
        width = 27,
        height = 19,
        scale = 0.5,
        shift = {0.03125, 0.015625}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-14.png",
      priority = base_decorative_sprite_priority,
      width = 14,
      height = 10,
      shift = {0.015625, 0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-14.png",
        priority = base_decorative_sprite_priority,
        width = 27,
        height = 19,
        scale = 0.5,
        shift = {0.0078125, 0.0078125}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-15.png",
      priority = base_decorative_sprite_priority,
      width = 13,
      height = 11,
      shift = {0, 0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-15.png",
        priority = base_decorative_sprite_priority,
        width = 26,
        height = 22,
        scale = 0.5,
        shift = {0.0078125, 0.015625}
      }
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/rock-tiny-16.png",
      priority = base_decorative_sprite_priority,
      width = 14,
      height = 10,
      shift = {0.03125, 0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/rock-tiny/hr-rock-tiny-16.png",
        priority = base_decorative_sprite_priority,
        width = 27,
        height = 20,
        scale = 0.5,
        shift = {0.03125, 0.0078125}
      }
    }
  }
},
{
  name = "sand-rock-big",
  type = "simple-entity",
  flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
  icon = "__base__/graphics/icons/rock-big.png",
  icon_size = 64, icon_mipmaps = 4,
  subgroup = "wrecks",
  order = "b[decorative]-l[rock]-b[big]",
  collision_box = {{-0.75, -0.75}, {0.75, 0.75}},
  selection_box = {{-1.0, -1.0}, {1.0, 0.75}},
  render_layer = "object",
  max_health = 500,
  autoplace = {
    coverage = 0.0025 * rock_coverage_multiplier,
    max_probability = 0.175 * rock_max_prob_multiplier,
    order = "a[doodad]-a[rock]-b[big]",
    peaks = {
      {
        noise_layer = "rocks",
        noise_octaves_difference = -2,
        noise_persistence = 0.9,
      }
    },
    sharpness = 0.7
  },
  minable =
  {
    mining_particle = "stone-particle",
    mining_time = 1,
    results = {{name = "stone", amount_min = 10, amount_max = 20}},
  },
  loot =
  {
    {item = "stone", probability = 1, count_min = 0, count_max = 10}
  },
  resistances =
  {
    { type = "fire", percent = 100 },
    { type = "poison", percent = 100 }
  },
  count_as_rock_for_filtered_deconstruction = true,
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  vehicle_impact_sound =  { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 },
  pictures =
  {
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-01.png",
      width = 105,
      height = 69,
      shift = {0.296875, -0.4},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-01.png",
        width = 209,
        height = 138,
        shift = {0.304688, -0.4},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-02.png",
      width = 82,
      height = 65,
      shift = {0.0, 0.046875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-02.png",
        width = 165,
        height = 129,
        shift = {0.0, 0.0390625},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-03.png",
      width = 76,
      height = 69,
      shift = {0.14375, 0.0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-03.png",
        width = 151,
        height = 139,
        shift = {0.151562, 0.0},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-04.png",
      width = 108,
      height = 55,
      shift = {0.398438, 0.0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-04.png",
        width = 216,
        height = 110,
        shift = {0.390625, 0.0},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-05.png",
      width = 77,
      height = 74,
      shift = {0.328125, 0.0625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-05.png",
        width = 154,
        height = 147,
        shift = {0.328125, 0.0703125},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-06.png",
      width = 77,
      height = 66,
      shift = {0.16875, -0.1},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-06.png",
        width = 154,
        height = 132,
        shift = {0.16875, -0.1},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-07.png",
      width = 96,
      height = 65,
      shift = {0.3, -0.2},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-07.png",
        width = 193,
        height = 130,
        shift = {0.3, -0.2},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-08.png",
      width = 68,
      height = 59,
      shift = {0.0, 0.0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-08.png",
        width = 136,
        height = 117,
        shift = {0.0, 0.0},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-09.png",
      width = 78,
      height = 58,
      shift = {0.2, 0.0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-09.png",
        width = 157,
        height = 115,
        shift = {0.1, 0.0},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-10.png",
      width = 99,
      height = 77,
      shift = {0.325, -0.1},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-10.png",
        width = 198,
        height = 153,
        shift = {0.325, -0.1},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-11.png",
      width = 95,
      height = 58,
      shift = {0.453125, 0.0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-11.png",
        width = 190,
        height = 115,
        shift = {0.453125, 0.0},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-12.png",
      width = 115,
      height = 63,
      shift = {0.546875, -0.015625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-12.png",
        width = 229,
        height = 126,
        shift = {0.539062, -0.015625},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-13.png",
      width = 75,
      height = 63,
      shift = {0.0625, 0.171875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-13.png",
        width = 151,
        height = 125,
        shift = {0.0703125, 0.179688},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-14.png",
      width = 69,
      height = 59,
      shift = {0.153125, 0.0},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-14.png",
        width = 137,
        height = 117,
        shift = {0.160938, 0.0},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-15.png",
      width = 100,
      height = 71,
      shift = {0.234375, -0.203125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-15.png",
        width = 201,
        height = 141,
        shift = {0.242188, -0.195312},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-big-16.png",
      width = 104,
      height = 77,
      shift = {0.359375, -0.1},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-big-16.png",
        width = 209,
        height = 154,
        shift = {0.351562, -0.1},
        scale = 0.5,
      },
    },
  },
},
{
  name = "sand-rock-medium",
  type = "optimized-decorative",
  subgroup = "wrecks",
  order = "d[remnants]-d[ship-wreck-grass]-b[small]",
  collision_box = {{-1.5, -0.5}, {1.5, 0.5}},
  selection_box = {{-1.7, -0.6}, {1.7, 0.6}},
  selectable_in_game = false,
  render_layer = "floor",
  autoplace = {
    coverage = 0.004 * rock_coverage_multiplier,
    max_probability = 0.27999999999999998 * rock_max_prob_multiplier,
    order = "a[doodad]-a[rock]-c[medium]",
    peaks = {
      {
        noise_layer = "rocks",
        noise_octaves_difference = -2,
        noise_persistence = 0.9,
      }
    },
    sharpness = 0.7
  },
  pictures =
  {
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-01.png",
      priority = base_decorative_sprite_priority,
      width = 67,
      height = 41,
      shift = {0.328125, 0.515625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-01.png",
        priority = base_decorative_sprite_priority,
        width = 134,
        height = 82,
        shift = {0.328125, 0.515625},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-02.png",
      priority = base_decorative_sprite_priority,
      width = 55,
      height = 40,
      shift = {0.15625, 0.5625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-02.png",
        priority = base_decorative_sprite_priority,
        width = 110,
        height = 79,
        shift = {0.15625, 0.570312},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-03.png",
      priority = base_decorative_sprite_priority,
      width = 44,
      height = 30,
      shift = {0.34375, 0.484375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-03.png",
        priority = base_decorative_sprite_priority,
        width = 90,
        height = 60,
        shift = {0.34375, 0.484375},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-04.png",
      priority = base_decorative_sprite_priority,
      width = 55,
      height = 45,
      shift = {0.296875, 0.484375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-04.png",
        priority = base_decorative_sprite_priority,
        width = 110,
        height = 89,
        shift = {0.296875, 0.476562},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-05.png",
      priority = base_decorative_sprite_priority,
      width = 53,
      height = 38,
      shift = {0.359375, 0.25},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-05.png",
        priority = base_decorative_sprite_priority,
        width = 106,
        height = 76,
        shift = {0.359375, 0.25},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-06.png",
      priority = base_decorative_sprite_priority,
      width = 50,
      height = 46,
      shift = {0.4375, 0.296875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-06.png",
        priority = base_decorative_sprite_priority,
        width = 100,
        height = 92,
        shift = {0.4375, 0.296875},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-07.png",
      priority = base_decorative_sprite_priority,
      width = 41,
      height = 41,
      shift = {0.59375, 0.40625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-07.png",
        priority = base_decorative_sprite_priority,
        width = 82,
        height = 83,
        shift = {0.59375, 0.398438},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-08.png",
      priority = base_decorative_sprite_priority,
      width = 62,
      height = 46,
      shift = {0.59375, 0.328125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-08.png",
        priority = base_decorative_sprite_priority,
        width = 123,
        height = 92,
        shift = {0.601562, 0.328125},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-09.png",
      priority = base_decorative_sprite_priority,
      width = 73,
      height = 38,
      shift = {0.5625, 0.3125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-09.png",
        priority = base_decorative_sprite_priority,
        width = 146,
        height = 76,
        shift = {0.5625, 0.3125},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-10.png",
      priority = base_decorative_sprite_priority,
      width = 56,
      height = 39,
      shift = {0.46875, 0.453125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-10.png",
        priority = base_decorative_sprite_priority,
        width = 112,
        height = 77,
        shift = {0.46875, 0.460938},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-11.png",
      priority = base_decorative_sprite_priority,
      width = 46,
      height = 30,
      shift = {0.4375, 0.515625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-11.png",
        priority = base_decorative_sprite_priority,
        width = 91,
        height = 61,
        shift = {0.445312, 0.507812},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-12.png",
      priority = base_decorative_sprite_priority,
      width = 53,
      height = 42,
      shift = {0.390625, 0.453125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-12.png",
        priority = base_decorative_sprite_priority,
        width = 105,
        height = 84,
        shift = {0.398438, 0.453125},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-13.png",
      priority = base_decorative_sprite_priority,
      width = 46,
      height = 36,
      shift = {0.375, 0.640625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-13.png",
        priority = base_decorative_sprite_priority,
        width = 94,
        height = 73,
        shift = {0.375, 0.632812},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-14.png",
      priority = base_decorative_sprite_priority,
      width = 61,
      height = 45,
      shift = {0.359375, 0.578125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-14.png",
        priority = base_decorative_sprite_priority,
        width = 122,
        height = 89,
        shift = {0.359375, 0.570312},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-15.png",
      priority = base_decorative_sprite_priority,
      width = 49,
      height = 33,
      shift = {0.1875, 0.765625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-15.png",
        priority = base_decorative_sprite_priority,
        width = 98,
        height = 65,
        shift = {0.1875, 0.773438},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-medium-16.png",
      priority = base_decorative_sprite_priority,
      width = 72,
      height = 38,
      shift = {0.109375, 0.71875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-medium-16.png",
        priority = base_decorative_sprite_priority,
        width = 144,
        height = 76,
        shift = {0.109375, 0.71875},
        scale = 0.5,
      },
    },
  }
},

{
  name = "sand-rock-small",
  type = "optimized-decorative",
  subgroup = "wrecks",
  order = "d[remnants]-d[ship-wreck-grass]-b[small]",
  collision_box = {{-1.5, -0.5}, {1.5, 0.5}},
  selection_box = {{-1.7, -0.6}, {1.7, 0.6}},
  selectable_in_game = false,
  render_layer = "floor",
  autoplace = {
    coverage = 0.011000000000000001 * rock_coverage_multiplier,
    max_probability = 0.77000000000000002 * rock_max_prob_multiplier,
    order = "a[doodad]-a[rock]-d[small]",
    peaks = {
      {
        noise_layer = "rocks",
        noise_octaves_difference = -2,
        noise_persistence = 0.9,
      }
    },
    sharpness = 0.7
  },
  pictures =
  {
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-01.png",
      priority = base_decorative_sprite_priority,
      width = 28,
      height = 23,
      shift = {0.40625, 0.484375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-01.png",
        priority = base_decorative_sprite_priority,
        width = 56,
        height = 45,
        shift = {0.40625, 0.476562},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-02.png",
      priority = base_decorative_sprite_priority,
      width = 27,
      height = 22,
      shift = {0.296875, 0.484375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-02.png",
        priority = base_decorative_sprite_priority,
        width = 54,
        height = 45,
        shift = {0.296875, 0.476562},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-03.png",
      priority = base_decorative_sprite_priority,
      width = 22,
      height = 20,
      shift = {0.328125, 0.53125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-03.png",
        priority = base_decorative_sprite_priority,
        width = 44,
        height = 40,
        shift = {0.328125, 0.53125},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-04.png",
      priority = base_decorative_sprite_priority,
      width = 30,
      height = 22,
      shift = {0.265625, 0.59375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-04.png",
        priority = base_decorative_sprite_priority,
        width = 60,
        height = 43,
        shift = {0.265625, 0.601562},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-05.png",
      priority = base_decorative_sprite_priority,
      width = 26,
      height = 24,
      shift = {0.296875, 0.46875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-05.png",
        priority = base_decorative_sprite_priority,
        width = 52,
        height = 48,
        shift = {0.296875, 0.46875},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-06.png",
      priority = base_decorative_sprite_priority,
      width = 29,
      height = 20,
      shift = {0.546875, 0.53125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-06.png",
        priority = base_decorative_sprite_priority,
        width = 57,
        height = 39,
        shift = {0.554688, 0.523438},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-07.png",
      priority = base_decorative_sprite_priority,
      width = 36,
      height = 21,
      shift = {0.578125, 0.546875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-07.png",
        priority = base_decorative_sprite_priority,
        width = 73,
        height = 41,
        shift = {0.570312, 0.539062},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-08.png",
      priority = base_decorative_sprite_priority,
      width = 25,
      height = 23,
      shift = {0.640625, 0.390625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-08.png",
        priority = base_decorative_sprite_priority,
        width = 50,
        height = 46,
        shift = {0.640625, 0.390625},
        scale = 0.5,
      },
     },
     {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-09.png",
      priority = base_decorative_sprite_priority,
      width = 26,
      height = 22,
      shift = {0.671875, 0.34375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-09.png",
        priority = base_decorative_sprite_priority,
        width = 52,
        height = 43,
        shift = {0.671875, 0.335938},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-10.png",
      priority = base_decorative_sprite_priority,
      width = 32,
      height = 20,
      shift = {0.625, 0.40625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-10.png",
        priority = base_decorative_sprite_priority,
        width = 63,
        height = 39,
        shift = {0.632812, 0.398438},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-11.png",
      priority = base_decorative_sprite_priority,
      width = 29,
      height = 21,
      shift = {0.453125, 0.609375},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-11.png",
        priority = base_decorative_sprite_priority,
        width = 57,
        height = 41,
        shift = {0.460938, 0.617188},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-12.png",
      priority = base_decorative_sprite_priority,
      width = 34,
      height = 26,
      shift = {0.46875, 0.5625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-12.png",
        priority = base_decorative_sprite_priority,
        width = 67,
        height = 51,
        shift = {0.460938, 0.570312},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-13.png",
      priority = base_decorative_sprite_priority,
      width = 35,
      height = 19,
      shift = {0.484375, 0.796875},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-13.png",
        priority = base_decorative_sprite_priority,
        width = 70,
        height = 37,
        shift = {0.484375, 0.789062},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-14.png",
      priority = base_decorative_sprite_priority,
      width = 32,
      height = 24,
      shift = {0.1875, 0.90625},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-14.png",
        priority = base_decorative_sprite_priority,
        width = 63,
        height = 48,
        shift = {0.179688, 0.90625},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-15.png",
      priority = base_decorative_sprite_priority,
      width = 28,
      height = 24,
      shift = {0.140625, 0.78125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-15.png",
        priority = base_decorative_sprite_priority,
        width = 56,
        height = 48,
        shift = {0.140625, 0.78125},
        scale = 0.5,
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/sand-rock-small-16.png",
      priority = base_decorative_sprite_priority,
      width = 37,
      height = 23,
      shift = {-0.03125, 0.78125},
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-rock/hr-sand-rock-small-16.png",
        priority = base_decorative_sprite_priority,
        width = 74,
        height = 46,
        shift = {-0.03125, 0.78125},
        scale = 0.5,
      },
    },
  },
},
{
  name = "sand-decal",
  type = "optimized-decorative",
  subgroup = "grass",
  order = "b[decorative]-b[red-desert-decal]",
  collision_box = {{-6, -6}, {6, 6}},
  collision_mask = {"doodad-layer", "water-tile", "not-colliding-with-itself"},
  render_layer = "decals",
  tile_layer = default_decal_layer, -- despite the name, this is not sand exclusive decal; draw under stone path and concrete
  autoplace = {
    max_probability = 0.05,
    order = "a[doodad]-b[decal]",
    peaks = {
      {
        influence = 0.2,
        noise_layer = "sand-decal",
        --noise_octaves_difference = -2,
        noise_octaves_difference = -4,
        noise_persistence = 0.9
      },
      {
        influence = 0.05,
      }
    },
    sharpness = 0.1
  },
  pictures =
  {
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-01.png",
      width = 488,
      height = 322,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-01.png",
        width = 975,
        height = 664,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-02.png",
      width = 314,
      height = 239,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-02.png",
        width = 628,
        height = 477,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-03.png",
      width = 260,
      height = 166,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-03.png",
        width = 519,
        height = 331,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-04.png",
      width = 435,
      height = 391,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-04.png",
        width = 870,
        height = 781,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-05.png",
      width = 115,
      height = 81,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-05.png",
        width = 230,
        height = 161,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-06.png",
      width = 70,
      height = 55,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-06.png",
        width = 140,
        height = 110,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-07.png",
      width = 143,
      height = 122,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-07.png",
        width = 285,
        height = 243,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-08.png",
      width = 78,
      height = 43,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-08.png",
        width = 156,
        height = 85,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-09.png",
      width = 106,
      height = 76,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-09.png",
        width = 212,
        height = 152,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-10.png",
      width = 117,
      height = 99,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-10.png",
        width = 233,
        height = 197,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-11.png",
      width = 162,
      height = 207,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-11.png",
        width = 324,
        height = 413,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-12.png",
      width = 252,
      height = 244,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-12.png",
        width = 504,
        height = 488,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-13.png",
      width = 165,
      height = 153,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-13.png",
        width = 329,
        height = 305,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-14.png",
      width = 406,
      height = 362,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-14.png",
        width = 811,
        height = 724,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-15.png",
      width = 133,
      height = 131,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-15.png",
        width = 266,
        height = 262,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-16.png",
      width = 461,
      height = 356,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-16.png",
        width = 921,
        height = 712,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-17.png",
      width = 361,
      height = 198,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-17.png",
        width = 722,
        height = 395,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-18.png",
      width = 94,
      height = 145,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-18.png",
        width = 187,
        height = 289,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-19.png",
      width = 500,
      height = 187,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-19.png",
        width = 999,
        height = 374,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-20.png",
      width = 392,
      height = 200,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-20.png",
        width = 783,
        height = 399,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-21.png",
      width = 334,
      height = 203,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-21.png",
        width = 668,
        height = 406,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-22.png",
      width = 219,
      height = 159,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-22.png",
        width = 437,
        height = 318,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-23.png",
      width = 197,
      height = 123,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-23.png",
        width = 394,
        height = 246,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-24.png",
      width = 181,
      height = 146,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-24.png",
        width = 361,
        height = 291,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-25.png",
      width = 645,
      height = 641,
      slice_y = 4,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-25.png",
        width = 1290,
        height = 1281,
        slice_y = 4,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-26.png",
      width = 157,
      height = 87,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-26.png",
        width = 314,
        height = 174,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-27.png",
      width = 174,
      height = 132,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-27.png",
        width = 348,
        height = 264,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-28.png",
      width = 244,
      height = 179,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-28.png",
        width = 488,
        height = 357,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-29.png",
      width = 297,
      height = 317,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-29.png",
        width = 594,
        height = 634,
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/sand-decal-30.png",
      width = 98,
      height = 108,
      hr_version =
      {
        filename = "__alien-biomes__/graphics/decorative/rock/base/sand-decal/hr-sand-decal-30.png",
        width = 195,
        height = 215,
        scale = 0.5
      },
    },
  },
},
{
  name = "sand-dune-decal",
  type = "optimized-decorative",
  subgroup = "grass",
  order = "b[decorative]-b[red-desert-decal]",
  collision_box = {{-4, -4}, {4, 4}},
  collision_mask = {"doodad-layer", "water-tile", "not-colliding-with-itself"},
  render_layer = "decals",
  tile_layer = default_decal_layer,
  autoplace =
  {
    order = "a[doodad]-b[decal]",
    sharpness = 0.2,
    max_probability = 0.04,
    peaks =
    {
      peak,
      {
        influence = 0.5,
      },
      {
        influence = 1,
        noise_layer = "sand-dune-decal",
        noise_octaves_difference = -3,
        noise_persistence = 0.7,
      }
    },
    tile_restriction = { "sand-1" }
  },
  pictures =
  {
    --dune
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-00.png",
      width = 105,
      height = 84,
      shift = util.by_pixel(-8.5, 0),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-00.png",
        width = 212,
        height = 168,
        shift = util.by_pixel(-8, 0),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-01.png",
      width = 88,
      height = 73,
      shift = util.by_pixel(-3, -3.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-01.png",
        width = 211,
        height = 148,
        shift = util.by_pixel(5.75, -3.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-02.png",
      width = 130,
      height = 91,
      shift = util.by_pixel(3, 1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-02.png",
        width = 260,
        height = 184,
        shift = util.by_pixel(3, 1),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-03.png",
      width = 61,
      height = 90,
      shift = util.by_pixel(0.5, 2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-03.png",
        width = 129,
        height = 181,
        shift = util.by_pixel(0.75, 1.75),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-04.png",
      width = 95,
      height = 92,
      shift = util.by_pixel(-3.5, -1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-04.png",
        width = 196,
        height = 184,
        shift = util.by_pixel(-3.5, -1.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-05.png",
      width = 107,
      height = 92,
      shift = util.by_pixel(-1.5, -1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-05.png",
        width = 215,
        height = 184,
        shift = util.by_pixel(-1.25, -1),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-06.png",
      width = 108,
      height = 89,
      shift = util.by_pixel(6, 4.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-06.png",
        width = 218,
        height = 179,
        shift = util.by_pixel(6.5, 4.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-07.png",
      width = 125,
      height = 91,
      shift = util.by_pixel(17.5, 3.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-07.png",
        width = 250,
        height = 183,
        shift = util.by_pixel(17.5, 3.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-08.png",
      width = 130,
      height = 86,
      shift = util.by_pixel(5, 1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-08.png",
        width = 260,
        height = 176,
        shift = util.by_pixel(5, 0.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-09.png",
      width = 129,
      height = 92,
      shift = util.by_pixel(-5.5, -1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-09.png",
        width = 260,
        height = 184,
        shift = util.by_pixel(-5.5, -1),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-10.png",
      width = 115,
      height = 91,
      shift = util.by_pixel(-14.5, 1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-10.png",
        width = 233,
        height = 183,
        shift = util.by_pixel(-13.75, 1.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-11.png",
      width = 85,
      height = 92,
      shift = util.by_pixel(-9.5, 2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-11.png",
        width = 172,
        height = 184,
        shift = util.by_pixel(-9.5, 2),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-12.png",
      width = 129,
      height = 82,
      shift = util.by_pixel(2.5, -7),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-12.png",
        width = 260,
        height = 166,
        shift = util.by_pixel(2.5, -6.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-13.png",
      width = 129,
      height = 85,
      shift = util.by_pixel(4.5, -0.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-13.png",
        width = 259,
        height = 172,
        shift = util.by_pixel(4.75, -1),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-14.png",
      width = 98,
      height = 92,
      shift = util.by_pixel(-3, -2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-14.png",
        width = 199,
        height = 184,
        shift = util.by_pixel(-2.25, -2),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-15.png",
      width = 104,
      height = 92,
      shift = util.by_pixel(9, -3),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-15.png",
        width = 214,
        height = 184,
        shift = util.by_pixel(8.5, -3),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-16.png",
      width = 80,
      height = 91,
      shift = util.by_pixel(-8, -4.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-16.png",
        width = 162,
        height = 182,
        shift = util.by_pixel(-8, -4.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-17.png",
      width = 110,
      height = 76,
      shift = util.by_pixel(-3, 0),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-17.png",
        width = 222,
        height = 153,
        shift = util.by_pixel(-3, -0.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-18.png",
      width = 122,
      height = 92,
      shift = util.by_pixel(4, -3),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-18.png",
        width = 247,
        height = 184,
        shift = util.by_pixel(4.25, -2.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-19.png",
      width = 103,
      height = 92,
      shift = util.by_pixel(-6.5, -3),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-19.png",
        width = 211,
        height = 184,
        shift = util.by_pixel(-5.75, -3),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-20.png",
      width = 121,
      height = 91,
      shift = util.by_pixel(-0.5, 2.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-20.png",
        width = 248,
        height = 183,
        shift = util.by_pixel(-1.5, 2.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-21.png",
      width = 87,
      height = 91,
      shift = util.by_pixel(6.5, 1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-21.png",
        width = 176,
        height = 184,
        shift = util.by_pixel(6.5, 1.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-22.png",
      width = 104,
      height = 92,
      shift = util.by_pixel(9, -2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-22.png",
        width = 208,
        height = 185,
        shift = util.by_pixel(9, -1.75),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-23.png",
      width = 113,
      height = 91,
      shift = util.by_pixel(-3.5, -1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-23.png",
        width = 227,
        height = 184,
        shift = util.by_pixel(-3.75, -1.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-24.png",
      width = 78,
      height = 92,
      shift = util.by_pixel(5, -1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-24.png",
        width = 158,
        height = 186,
        shift = util.by_pixel(4.5, -1),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-25.png",
      width = 129,
      height = 91,
      shift = util.by_pixel(1.5, -1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-25.png",
        width = 260,
        height = 184,
        shift = util.by_pixel(1.5, -1.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-26.png",
      width = 66,
      height = 92,
      shift = util.by_pixel(-1, -1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-26.png",
        width = 134,
        height = 184,
        shift = util.by_pixel(-0.5, -1),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-27.png",
      width = 63,
      height = 82,
      shift = util.by_pixel(26.5, 1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-27.png",
        width = 127,
        height = 165,
        shift = util.by_pixel(26.25, 1.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-28.png",
      width = 129,
      height = 79,
      shift = util.by_pixel(-2.5, -4.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-28.png",
        width = 258,
        height = 158,
        shift = util.by_pixel(-2.5, -4.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/sand-dune-decal-29.png",
      width = 89,
      height = 92,
      shift = util.by_pixel(-3.5, -2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/dune/|color|/sand-dune-decal/hr-sand-dune-decal-29.png",
        width = 180,
        height = 184,
        shift = util.by_pixel(-3.5, -2),
        scale = 0.5
      },
    },
  },
},
{
  name = "stone-decal",
  type = "optimized-decorative",
  subgroup = "grass",
  order = "b[decorative]-b[red-desert-decal]",
  collision_box = {{-4, -4}, {4, 4}},
  collision_mask = {"doodad-layer", "water-tile", "not-colliding-with-itself"},
  render_layer = "decals",
  tile_layer = default_decal_layer, -- under stone-path
  autoplace =
  {
    max_probability = 0.01,
    order = "a[doodad]-b[decal]",
    peaks = {
      {
        noise_layer = "stone-decal",
        noise_octaves_difference = -2,
        noise_persistence = 0.9
      }
    },
    sharpness = 0.3
  },
  pictures =
  {
    --lightDecal
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-00.png",
      width = 199,
      height = 149,
      shift = util.by_pixel(4.5, -2.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-00.png",
        width = 400,
        height = 299,
        shift = util.by_pixel(4.5, -2.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-01.png",
      width = 210,
      height = 160,
      shift = util.by_pixel(-1, 2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-01.png",
        width = 419,
        height = 320,
        shift = util.by_pixel(-0.75, 2),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-02.png",
      width = 208,
      height = 142,
      shift = util.by_pixel(-1, 2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-02.png",
        width = 417,
        height = 287,
        shift = util.by_pixel(-1.25, 1.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-03.png",
      width = 211,
      height = 149,
      shift = util.by_pixel(-0.5, 5.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-03.png",
        width = 421,
        height = 298,
        shift = util.by_pixel(-0.25, 5.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-04.png",
      width = 198,
      height = 151,
      shift = util.by_pixel(6, 3.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-04.png",
        width = 396,
        height = 302,
        shift = util.by_pixel(6, 4),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-05.png",
      width = 205,
      height = 147,
      shift = util.by_pixel(-2.5, 7.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-05.png",
        width = 408,
        height = 295,
        shift = util.by_pixel(-2.5, 7.75),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-06.png",
      width = 208,
      height = 158,
      shift = util.by_pixel(-1, 3),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-06.png",
        width = 417,
        height = 317,
        shift = util.by_pixel(-1.25, 3.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-07.png",
      width = 209,
      height = 155,
      shift = util.by_pixel(0.5, 2.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-07.png",
        width = 419,
        height = 312,
        shift = util.by_pixel(0.75, 2.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-08.png",
      width = 206,
      height = 158,
      shift = util.by_pixel(-2, 2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-08.png",
        width = 413,
        height = 317,
        shift = util.by_pixel(-2.25, 2.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-09.png",
      width = 201,
      height = 155,
      shift = util.by_pixel(0.5, 1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-09.png",
        width = 403,
        height = 310,
        shift = util.by_pixel(0.25, 1.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-10.png",
      width = 206,
      height = 153,
      shift = util.by_pixel(-1, 1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-10.png",
        width = 411,
        height = 307,
        shift = util.by_pixel(-0.75, 1.75),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-11.png",
      width = 210,
      height = 147,
      shift = util.by_pixel(0, -0.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-11.png",
        width = 421,
        height = 295,
        shift = util.by_pixel(-0.25, -0.75),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-12.png",
      width = 210,
      height = 140,
      shift = util.by_pixel(-1, -7),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-12.png",
        width = 420,
        height = 280,
        shift = util.by_pixel(-0.5, -7),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-13.png",
      width = 201,
      height = 156,
      shift = util.by_pixel(0.5, 3),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-13.png",
        width = 403,
        height = 311,
        shift = util.by_pixel(0.75, 3.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-14.png",
      width = 209,
      height = 152,
      shift = util.by_pixel(0.5, 2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-14.png",
        width = 418,
        height = 304,
        shift = util.by_pixel(0, 2),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-15.png",
      width = 199,
      height = 142,
      shift = util.by_pixel(-3.5, 6),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-15.png",
        width = 398,
        height = 284,
        shift = util.by_pixel(-3.5, 6.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-16.png",
      width = 204,
      height = 154,
      shift = util.by_pixel(4, -1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-16.png",
        width = 406,
        height = 313,
        shift = util.by_pixel(4, 0.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-17.png",
      width = 210,
      height = 147,
      shift = util.by_pixel(1, 4.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-17.png",
        width = 420,
        height = 294,
        shift = util.by_pixel(0.5, 4.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-18.png",
      width = 189,
      height = 145,
      shift = util.by_pixel(0.5, 5.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-18.png",
        width = 379,
        height = 289,
        shift = util.by_pixel(0.25, 5.75),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-19.png",
      width = 201,
      height = 155,
      shift = util.by_pixel(-5.5, 1.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-19.png",
        width = 401,
        height = 311,
        shift = util.by_pixel(-5.25, 1.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-20.png",
      width = 209,
      height = 158,
      shift = util.by_pixel(0.5, 1),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-20.png",
        width = 418,
        height = 315,
        shift = util.by_pixel(0.5, 1.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-21.png",
      width = 208,
      height = 157,
      shift = util.by_pixel(1, 3.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-21.png",
        width = 418,
        height = 314,
        shift = util.by_pixel(1, 3),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-22.png",
      width = 211,
      height = 135,
      shift = util.by_pixel(-0.5, 0.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-22.png",
        width = 421,
        height = 270,
        shift = util.by_pixel(-0.25, 1),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-23.png",
      width = 202,
      height = 145,
      shift = util.by_pixel(2, -2.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-23.png",
        width = 403,
        height = 290,
        shift = util.by_pixel(2.25, -2.5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-24.png",
      width = 209,
      height = 158,
      shift = util.by_pixel(-0.5, 2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-24.png",
        width = 418,
        height = 315,
        shift = util.by_pixel(-0.5, 2.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-25.png",
      width = 207,
      height = 155,
      shift = util.by_pixel(-2.5, 4.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-25.png",
        width = 414,
        height = 310,
        shift = util.by_pixel(-2, 4),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-26.png",
      width = 201,
      height = 154,
      shift = util.by_pixel(-3.5, 5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-26.png",
        width = 403,
        height = 306,
        shift = util.by_pixel(-3.75, 5),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-27.png",
      width = 208,
      height = 151,
      shift = util.by_pixel(1, 0.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-27.png",
        width = 416,
        height = 303,
        shift = util.by_pixel(1, 0.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-28.png",
      width = 211,
      height = 155,
      shift = util.by_pixel(-0.5, 2.5),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-28.png",
        width = 422,
        height = 311,
        shift = util.by_pixel(0, 2.25),
        scale = 0.5
      },
    },
    {
      filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/stone-decal-29.png",
      width = 203,
      height = 146,
      shift = util.by_pixel(-3.5, 2),
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/rock/base/stone-decal/hr-stone-decal-29.png",
        width = 406,
        height = 292,
        shift = util.by_pixel(-3.5, 2),
        scale = 0.5
      },
    },
  },
},
}
