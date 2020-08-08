local sensor = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
sensor.name = "pollution-detector"
sensor.icon = "__pollution-detector__/graphics/icons/pollution-detector.png"
sensor.icon_size = 32
sensor.minable.result = "pollution-detector"
sensor.sprites = make_4way_animation_from_spritesheet(
  { layers =
    {
      {
        filename = "__pollution-detector__/graphics/entity/pollution-detector.png",
        width = 58,
        height = 52,
        frame_count = 1,
        shift = util.by_pixel(0, 5),
        hr_version =
        {
          scale = 0.5,
          filename = "__pollution-detector__/graphics/entity/hr-pollution-detector.png",
          width = 114,
          height = 102,
          frame_count = 1,
          shift = util.by_pixel(0, 5),
        },
      },
      {
        filename = "__base__/graphics/entity/combinator/constant-combinator-shadow.png",
        width = 50,
        height = 34,
        frame_count = 1,
        shift = util.by_pixel(9, 6),
        draw_as_shadow = true,
        hr_version =
        {
          scale = 0.5,
          filename = "__base__/graphics/entity/combinator/hr-constant-combinator-shadow.png",
          width = 98,
          height = 66,
          frame_count = 1,
          shift = util.by_pixel(8.5, 5.5),
          draw_as_shadow = true,
        },
      },
    },
  })

sensor.item_slot_count = 10
    
    
data:extend({ sensor })
