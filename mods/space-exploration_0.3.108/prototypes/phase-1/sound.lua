local data_util = require("data_util")

-- use projectile for sounds becuase they are can be positioned, moved, and removed at a specific time.
-- the entity MUST be removed otherwise it will loop forever
local function make_sound_continous(name, path, volume)
  data:extend( {
    {
      type = "projectile",
      name = data_util.mod_prefix .. "sound-continous-" .. name,
      acceleration = 0,
      animation = {
        filename = "__space-exploration-graphics__/graphics/blank.png",
        frame_count = 1,
        height = 1,
        line_length = 1,
        priority = "high",
        width = 1
      },
      flags = { "not-on-map" },
      working_sound = {
        apparent_volume = volume or 1,
        sound = {
          {
            filename = path,
            volume = volume or 1
          }
        }
      }
    }
  })
end

-- use an explosion because it if fire and forget
local function make_sound(name, path, volume)
  data:extend( {
    {
      type = "explosion",
      name = data_util.mod_prefix .. "sound-" .. name,
      animations = { {
          filename = "__space-exploration-graphics__/graphics/blank.png",
          frame_count = 1,
          height = 1,
          line_length = 1,
          priority = "high",
          width = 1
      }},
      flags = { "not-on-map" },
      sound = {
        aggregation = { max_count = 1, remove = true },
        variations = {
          {
            filename = path,
            volume = volume or 1
          },
        }
      },
    }
  })
end

make_sound("machine-close", "__base__/sound/machine-close.ogg", 1)
make_sound("machine-open", "__base__/sound/machine-open.ogg", 1)
make_sound("silo-clamps-off", "__base__/sound/silo-clamps-off.ogg", 1.5)
make_sound("silo-clamps-on", "__base__/sound/silo-clamps-on.ogg", 1.5)
make_sound("silo-doors", "__base__/sound/silo-doors.ogg", 1)
make_sound("silo-raise-rocket", "__base__/sound/silo-raise-rocket.ogg", 1)
make_sound("silo-rocket", "__base__/sound/silo-rocket.ogg", 1)
make_sound_continous("silo-rocket", "__base__/sound/silo-rocket.ogg", 1)
make_sound("train-breaks", "__base__/sound/train-breaks.ogg", 1)

data:extend({
  {
    type = "sound",
    name = data_util.mod_prefix .. "meteor-woosh",
    aggregation = { max_count = 1, remove = true },
    variations = {
      {
        filename = "__space-exploration__/sound/meteor-woosh.ogg",
        volume = 1
      },
    }
  },
  {
    type = "sound",
    name = data_util.mod_prefix .. "spaceship-woosh",
    aggregation = { max_count = 1, remove = true },
    variations = {
      {
        filename = "__space-exploration__/sound/spaceship-woosh.ogg",
        volume = 1
      },
    }
  }
})


make_sound_continous("gate-turning", "__space-exploration__/sound/gate-turning.ogg", 1)
make_sound_continous("gate-power-on", "__space-exploration__/sound/gate-power-on.ogg", 1.2)
make_sound("gate-power-up", "__space-exploration__/sound/gate-power-up.ogg", 1)
make_sound("gate-power-down", "__space-exploration__/sound/gate-power-down.ogg", 0.9)
make_sound("gate-button", "__space-exploration__/sound/gate-button.ogg", 1)
make_sound("gate-lock", "__space-exploration__/sound/gate-lock.ogg", 1)
