local util = require("data-util")
local flower_bush_base = {
  name = "flower-bush",
  type = "optimized-decorative",
  autoplace = {
    max_probability = 1,
    order = "a[doodad]-e[garballo]",
    peaks = {
      { influence = -1.4 },
      {
        noise_layer = "garballo",
        noise_octaves_difference = -2,
        noise_persistence = 0.8,
      },
      {
        temperature_optimal = 15,
        temperature_range = 15,
        temperature_max_range = 20,
        water_optimal = 1,
        water_range = 0.3,
        water_max_range = 0.35,
        aux_optimal = 0,
        aux_range = 0.25,
        aux_max_range = 0.2,
      }
    },
    random_probability_penalty = 0.75,
    sharpness = 0.8
  },
  subgroup = "grass",
  collision_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
  order = "b[decorative]-g[fluff]-b[dry]-a[brown]",
  pictures = {
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-00.png",
      frame_count = 1,
      height = 22,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-00.png",
        frame_count = 1,
        height = 44,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.1015625,
          -0.0625
        },
        width = 67
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.09375,
        -0.0625
      },
      width = 34
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-01.png",
      frame_count = 1,
      height = 29,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-01.png",
        frame_count = 1,
        height = 58,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.09375,
          -0.03125
        },
        width = 76
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.09375,
        -0.046875
      },
      width = 38
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-02.png",
      frame_count = 1,
      height = 22,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-02.png",
        frame_count = 1,
        height = 44,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.0546875,
          -0.046875
        },
        width = 75
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.046875,
        -0.0625
      },
      width = 37
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-03.png",
      frame_count = 1,
      height = 27,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-03.png",
        frame_count = 1,
        height = 54,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.0703125,
          -0.046875
        },
        width = 65
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.078125,
        -0.046875
      },
      width = 33
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-04.png",
      frame_count = 1,
      height = 27,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-04.png",
        frame_count = 1,
        height = 55,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.125,
          -0.1015625
        },
        width = 88
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.125,
        -0.109375
      },
      width = 44
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-05.png",
      frame_count = 1,
      height = 24,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-05.png",
        frame_count = 1,
        height = 49,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.0703125,
          -0.0234375
        },
        width = 63
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.078125,
        -0.03125
      },
      width = 31
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-06.png",
      frame_count = 1,
      height = 25,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-06.png",
        frame_count = 1,
        height = 50,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.109375,
          -0.078125
        },
        width = 74
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.109375,
        -0.078125
      },
      width = 37
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-07.png",
      frame_count = 1,
      height = 27,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-07.png",
        frame_count = 1,
        height = 53,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          -0.0546875,
          -0.1171875
        },
        width = 89
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        -0.046875,
        -0.109375
      },
      width = 45
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-08.png",
      frame_count = 1,
      height = 29,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-08.png",
        frame_count = 1,
        height = 58,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.046875,
          -0.046875
        },
        width = 70
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.046875,
        -0.046875
      },
      width = 35
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-09.png",
      frame_count = 1,
      height = 27,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-09.png",
        frame_count = 1,
        height = 53,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.0390625,
          -0.0078125
        },
        width = 83
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.03125,
        -0.015625
      },
      width = 42
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-10.png",
      frame_count = 1,
      height = 30,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-10.png",
        frame_count = 1,
        height = 61,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.078125,
          -0.0703125
        },
        width = 76
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.09375,
        -0.0625
      },
      width = 38
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-11.png",
      frame_count = 1,
      height = 25,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-11.png",
        frame_count = 1,
        height = 50,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.0546875,
          -0.0625
        },
        width = 71
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.046875,
        -0.046875
      },
      width = 35
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-12.png",
      frame_count = 1,
      height = 29,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-12.png",
        frame_count = 1,
        height = 57,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.1171875,
          -0.0078125
        },
        width = 79
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.125,
        -0.015625
      },
      width = 40
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-13.png",
      frame_count = 1,
      height = 25,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-13.png",
        frame_count = 1,
        height = 50,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.015625,
          -0.046875
        },
        width = 60
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.03125,
        -0.046875
      },
      width = 30
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-14.png",
      frame_count = 1,
      height = 19,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-14.png",
        frame_count = 1,
        height = 38,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.0234375,
          -0.078125
        },
        width = 65
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.015625,
        -0.078125
      },
      width = 33
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-15.png",
      frame_count = 1,
      height = 26,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-15.png",
        frame_count = 1,
        height = 51,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.0390625,
          -0.0390625
        },
        width = 65
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.046875,
        -0.03125
      },
      width = 33
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-17.png",
      frame_count = 1,
      height = 19,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-17.png",
        frame_count = 1,
        height = 38,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.0546875,
          -0.03125
        },
        width = 49
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.0625,
        -0.015625
      },
      width = 24
    },
    {
      filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/sr/flower-bush-18.png",
      frame_count = 1,
      height = 17,
      hr_version = {
        filename = "__alien-biomes__/graphics/decorative/flower-bush/flower-bush-green-pink/hr/flower-bush-18.png",
        frame_count = 1,
        height = 35,
        line_length = 1,
        priority = "extra-high",
        scale = 0.5,
        shift = {
          0.0390625,
          -0.0390625
        },
        width = 53
      },
      line_length = 1,
      priority = "extra-high",
      shift = {
        0.03125,
        -0.046875
      },
      width = 26
    },
  },
  selectable_in_game = false,
  selection_box = {
    {
      -0.5,
      -0.5
    },
    {
      0.5,
      0.5
    }
  },
}
local variants = {
  {
    name = "blue-pink",
    temperature = 0.15,
    aux = 1,
    noise_layer = "garballo"
  },
  { name = "green-pink",
    temperature = 0.15,
    aux = 0,
    noise_layer = "pita"
  },
  { name = "green-yellow",
    temperature = 0.85,
    aux = 0,
    noise_layer = "grass3"
  },
  { name = "red-blue",
    temperature = 0.85,
    aux = 1,
    noise_layer = "fluff"
  },
}
for _, variant in pairs(variants) do
  local bush = table.deepcopy(flower_bush_base)
  bush.name = bush.name .. "-" .. variant.name
  bush.autoplace.peaks[#bush.autoplace.peaks].temperature_optimal = variant.temperature * 100
  bush.autoplace.peaks[#bush.autoplace.peaks].aux_optimal = variant.aux
  bush.autoplace.peaks[2].noise_layer = variant.noise_layer
  util.replace_filenames_recursive(bush.pictures, "green-pink", variant.name)
  bush.autoplace.tile_restriction = alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), {"dirt", "grass"}))
  if table_size(bush.autoplace.tile_restriction) > 0 then
    data:extend({bush})
  end
end
