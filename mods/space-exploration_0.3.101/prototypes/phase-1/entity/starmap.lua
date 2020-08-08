local data_util = require("data_util")

data:extend({
  {
    type = "sprite",
    name = data_util.mod_prefix .. "starmap-star",
    filename = "__space-exploration-graphics__/graphics/entity/starmap/star.png",
    priority = "extra-high",
    width = 512,
    height = 512,
    shift = {0,0}
  },
  {
    type = "animation",
    name = data_util.mod_prefix .. "starmap-star-cloud",
    animation_speed = 0.5,
    filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
    flags = {
      "compressed"
    },
    frame_count = 45,
    height = 256,
    line_length = 7,
    priority = "low",
    scale = 3,
    width = 256,
    apply_runtime_tint = true,
    blend_mode = "additive", --"additive-soft"
  },
})
