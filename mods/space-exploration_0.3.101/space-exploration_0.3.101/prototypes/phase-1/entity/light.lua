local data_util = require("data_util")
-- use projectile for light becuase they are can be positioned, moved, and removed at a specific time.
local function make_light(name, light)
  data:extend( {
    {
      type = "projectile",
      name = name,
      acceleration = 0,
      animation = {
        filename = "__space-exploration-graphics__/graphics/blank.png",
        frame_count = 1,
        height = 1,
        line_length = 1,
        priority = "high",
        width = 1
      },
      flags = { "not-on-map", "placeable-off-grid" },
      light = light,
    }
  })
end

make_light(data_util.mod_prefix .."light-space-capsule", {
  intensity = 0.4,
  size = 16,
  color = {r = 255, g = 225, b = 195}
})

make_light(data_util.mod_prefix .. "light-space-capsule-launch", {
  intensity = 2,
  size = 8,
  color = {r = 255, g = 50, b = 0}
})

make_light(data_util.mod_prefix .. "gate-light", {
  intensity = 0.15,
  size = 40,
  color = {r = 255, g = 250, b = 255}
})
make_light(data_util.mod_prefix .. "gate-light-middle", {
  intensity = 1,
  size = 64,
  color = {r = 255, g = 250, b = 255}
})
