local data_util = require("data_util")
--[[
original plan for space pipes and belts:
more of a spagetti problem.
underground distance for both is 2.
The can't span a void (space tiles or underlay) -- via script
pipes are floor layer
pipes have automatic flow control
All
straight: h, v,
corner: ne, nw, se, sw
t: n, s, w, e
X


]]--
local pipe_span = 5
local long_versions = {
  {junction = true, length = 3},
  {junction = true, length = 5},
  {junction = false, length = 9},
}

local collision_floor = {
  "item-layer", -- stops player from dropping items on belts.
  "floor-layer",
  "object-layer",
  "water-tile",
}
local collision_floor_platform = {
  "item-layer", -- stops player from dropping items on belts.
  "floor-layer",
  "object-layer",
  "water-tile",
}

local blank_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
}

local shift_sprite = data_util.shift_sprite

local pipe_h = {
  filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-straight-horizontal.png",
  height = 64,
  hr_version = {
    filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-straight-horizontal.png",
    height = 128,
    priority = "extra-high",
    scale = 0.5,
    width = 128
  },
  priority = "extra-high",
  width = 64
}
local pipe_h_window = {
  filename = "__space-exploration-graphics__/graphics/entity/pipe-long/pipe-straight-horizontal-window.png",
  height = 64,
  hr_version = {
    filename = "__space-exploration-graphics__/graphics/entity/pipe-long/hr-pipe-straight-horizontal-window.png",
    height = 128,
    priority = "extra-high",
    scale = 0.5,
    width = 128
  },
  priority = "extra-high",
  width = 64
}
local pipe_v = {
  filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-straight-vertical.png",
  height = 64,
  hr_version = {
    filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-straight-vertical.png",
    height = 128,
    priority = "extra-high",
    scale = 0.5,
    width = 128
  },
  priority = "extra-high",
  width = 64
}
local pipe_v_window = {
  filename = "__space-exploration-graphics__/graphics/entity/pipe-long/pipe-straight-vertical-window.png",
  height = 64,
  hr_version = {
    filename = "__space-exploration-graphics__/graphics/entity/pipe-long/hr-pipe-straight-vertical-window.png",
    height = 128,
    priority = "extra-high",
    scale = 0.5,
    width = 128
  },
  priority = "extra-high",
  width = 64
}

data:extend({
  {
    icon = "__space-exploration-graphics__/graphics/icons/space-pipe.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "space-pipe",
    order = "a[pipe]-s[space]-a",
    place_result = data_util.mod_prefix .. "space-pipe",
    stack_size = 100,
    subgroup = "pipe",
    type = "item"
  },

  {
    icon = "__space-exploration-graphics__/graphics/icons/space-pipe-to-ground.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "space-pipe-to-ground",
    order = "a[pipe]-s[space]-b",
    place_result = data_util.mod_prefix .. "space-pipe-to-ground",
    stack_size = 50,
    subgroup = "pipe",
    type = "item"
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "space-pipe",
    expensive = {
      ingredients = {
        { name = "copper-cable", amount = 4 },
        { name = "steel-plate", amount = 2 },
        { name = "plastic-bar", amount = 2 },
        { name = "glass", amount = 2 },
      },
      result = data_util.mod_prefix .. "space-pipe",
      energy_required = 10,
      enabled = false,
    },
    normal = {
      ingredients = {
        { name = "copper-cable", amount = 2 },
        { name = "steel-plate", amount = 1 },
        { name = "plastic-bar", amount = 1 },
        { name = "glass", amount = 1 },
      },
      result = data_util.mod_prefix .. "space-pipe",
      energy_required = 10,
      enabled = false,
    },
    always_show_made_in = true,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "space-pipe-to-ground",
    ingredients = {
      { data_util.mod_prefix .. "space-pipe", 10 },
    },
    result = data_util.mod_prefix .. "space-pipe-to-ground",
    energy_required = 10,
    result_count = 1,
    enabled = false,
    always_show_made_in = true,
  },
  {
    name = data_util.mod_prefix .. "space-pipe",
    collision_box = {
      { -0.29, -0.29 },
      { 0.29, 0.29 }
    },
    collision_mask = collision_floor,
    corpse = "small-remnants",
    fast_replaceable_group = "pipe",
    flags = { "placeable-neutral", "player-creation" },
    fluid_box = {
      base_area = settings.startup["se-space-pipe-capacity"].value/100,
      pipe_connections = {
        { position = { 0, -1 } },
        { position = { 1, 0 } },
        { position = { 0, 1 } },
        { position = { -1, 0 } }
      }
    },
    horizontal_window_bounding_box = {
      { -0.25, -0.28125 },
      { 0.25, 0.15625 }
    },
    icon = "__space-exploration-graphics__/graphics/icons/space-pipe.png",
    icon_size = 64,
    max_health = 100,
    minable = {
      mining_time = 0.1,
      result = data_util.mod_prefix .. "space-pipe"
    },
    pictures = {
      corner_down_left = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-corner-down-left.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-corner-down-left.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      corner_down_right = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-corner-down-right.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-corner-down-right.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      corner_up_left = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-corner-up-left.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-corner-up-left.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      corner_up_right = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-corner-up-right.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-corner-up-right.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      cross = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-cross.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-cross.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      ending_down = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-ending-down.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-ending-down.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      ending_left = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-ending-left.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-ending-left.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      ending_right = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-ending-right.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-ending-right.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      ending_up = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-ending-up.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-ending-up.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      fluid_background = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/fluid-background.png",
        height = 20,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-fluid-background.png",
          height = 40,
          priority = "extra-high",
          scale = 0.5,
          width = 64
        },
        priority = "extra-high",
        width = 32
      },
      gas_flow = {
        axially_symmetrical = false,
        direction_count = 1,
        filename = "__space-exploration-graphics__/graphics/entity/pipe/steam.png",
        frame_count = 60,
        height = 15,
        hr_version = {
          axially_symmetrical = false,
          direction_count = 1,
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-steam.png",
          frame_count = 60,
          height = 30,
          line_length = 10,
          priority = "extra-high",
          width = 48
        },
        line_length = 10,
        priority = "extra-high",
        width = 24
      },
      high_temperature_flow = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/fluid-flow-high-temperature.png",
        height = 18,
        priority = "extra-high",
        width = 160
      },
      horizontal_window_background = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-horizontal-window-background.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-horizontal-window-background.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      low_temperature_flow = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/fluid-flow-low-temperature.png",
        height = 18,
        priority = "extra-high",
        width = 160
      },
      middle_temperature_flow = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/fluid-flow-medium-temperature.png",
        height = 18,
        priority = "extra-high",
        width = 160
      },
      straight_horizontal = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-straight-horizontal.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-straight-horizontal.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      straight_horizontal_window = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-straight-horizontal-window.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-straight-horizontal-window.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      straight_vertical = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-straight-vertical.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-straight-vertical.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      straight_vertical_single = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-straight-vertical-single.png",
        height = 80,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-straight-vertical-single.png",
          height = 160,
          priority = "extra-high",
          scale = 0.5,
          width = 160
        },
        priority = "extra-high",
        width = 80
      },
      straight_vertical_window = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-straight-vertical-window.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-straight-vertical-window.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      t_down = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-t-down.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-t-down.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      t_left = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-t-left.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-t-left.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      t_right = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-t-right.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-t-right.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      t_up = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-t-up.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-t-up.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      },
      vertical_window_background = {
        filename = "__space-exploration-graphics__/graphics/entity/pipe/pipe-vertical-window-background.png",
        height = 64,
        hr_version = {
          filename = "__space-exploration-graphics__/graphics/entity/pipe/hr-pipe-vertical-window-background.png",
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          width = 128
        },
        priority = "extra-high",
        width = 64
      }
    },
    resistances = {
      {
        percent = 80,
        type = "fire"
      },
      {
        percent = 30,
        type = "impact"
      }
    },
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
    type = "pipe",
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    vertical_window_bounding_box = {
      {
        -0.28125,
        -0.5
      },
      {
        0.03125,
        0.125
      }
    },
    working_sound = {
      match_volume_to_activity = true,
      max_sounds_per_type = 3,
      sound = {
        {
          filename = "__base__/sound/pipe.ogg",
          volume = 0.85
        }
      }
    }
  },
  {
    type = "pipe-to-ground",
    name = data_util.mod_prefix .. "space-pipe-to-ground",
    icon = "__space-exploration-graphics__/graphics/icons/space-pipe-to-ground.png",
    icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = data_util.mod_prefix .. "space-pipe-to-ground"},
    max_health = 150,
    fast_replaceable_group = "pipe",
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 80
      },
      {
        type = "impact",
        percent = 40
      }

    },
    collision_box = {{-0.29, -0.29}, {0.29, 0.2}},
    collision_mask = collision_floor_platform,
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    fluid_box =
    {
      base_area = settings.startup["se-space-pipe-capacity"].value/100,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { position = {0, -1} },
        {
          position = {0, 1},
          max_underground_distance = pipe_span + 1
        }
      }
    },
    underground_sprite =
    {
      filename = "__core__/graphics/arrows/underground-lines.png",
      priority = "extra-high-no-scale",
      width = 64,
      height = 64,
      scale = 0.5
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    pictures =
    {
      up =
      {
        filename = "__space-exploration-graphics__/graphics/entity/pipe-to-ground/pipe-to-ground-up.png",
        priority = "high",
        width = 64,
        height = 64, --, shift = {0.10, -0.04}
        hr_version =
        {
           filename = "__space-exploration-graphics__/graphics/entity/pipe-to-ground/hr-pipe-to-ground-up.png",
           priority = "extra-high",
           width = 128,
           height = 128,
           scale = 0.5
        }
      },
      down =
      {
        filename = "__space-exploration-graphics__/graphics/entity/pipe-to-ground/pipe-to-ground-down.png",
        priority = "high",
        width = 64,
        height = 64, --, shift = {0.05, 0}
        hr_version =
        {
           filename = "__space-exploration-graphics__/graphics/entity/pipe-to-ground/hr-pipe-to-ground-down.png",
           priority = "extra-high",
           width = 128,
           height = 128,
           scale = 0.5
        }
      },
      left =
      {
        filename = "__space-exploration-graphics__/graphics/entity/pipe-to-ground/pipe-to-ground-left.png",
        priority = "high",
        width = 64,
        height = 64, --, shift = {-0.12, 0.1}
        hr_version =
        {
           filename = "__space-exploration-graphics__/graphics/entity/pipe-to-ground/hr-pipe-to-ground-left.png",
           priority = "extra-high",
           width = 128,
           height = 128,
           scale = 0.5
        }
      },
      right =
      {
        filename = "__space-exploration-graphics__/graphics/entity/pipe-to-ground/pipe-to-ground-right.png",
        priority = "high",
        width = 64,
        height = 64, --, shift = {0.1, 0.1}
        hr_version =
        {
           filename = "__space-exploration-graphics__/graphics/entity/pipe-to-ground/hr-pipe-to-ground-right.png",
           priority = "extra-high",
           width = 128,
           height = 128,
           scale = 0.5
        }
      }
    }
  },
})
for _, version in pairs(long_versions) do
  local long_horizontal_sprites = { layers = {} }
  local long_vertical_sprites = { layers = {} }
  for i = -(version.length/2-0.5), version.length/2-0.5, 1 do
    if i == 0 then
      if version.junction then
        table.insert(long_horizontal_sprites.layers, pipe_h_window)
        table.insert(long_horizontal_sprites.layers, pipe_v_window)
        table.insert(long_vertical_sprites.layers, pipe_h_window)
        table.insert(long_vertical_sprites.layers, pipe_v_window)
      else
        table.insert(long_horizontal_sprites.layers, pipe_h_window)
        table.insert(long_vertical_sprites.layers, pipe_v_window)
      end
    else
      table.insert(long_horizontal_sprites.layers, shift_sprite(pipe_h,{i,0}))
      table.insert(long_vertical_sprites.layers, shift_sprite(pipe_v,{0,i}))
    end
  end
  local pipe_connections = {
    {position = {0,version.length/2+0.5}},
    {position = {0,-(version.length/2+0.5)}}
  }
  if version.junction then
    table.insert(pipe_connections, {position = {1,0}})
    table.insert(pipe_connections, {position = {-1,0}})
  end
  local name = data_util.mod_prefix.."space-pipe-long-"..(version.junction and "j" or "s").."-"..version.length
  table.insert(data.raw.technology[data_util.mod_prefix.."space-platform-scaffold"].effects,
    { type = "unlock-recipe", recipe = name })

  data:extend{
    {
      icons = {
        { icon = version.junction
          and "__space-exploration-graphics__/graphics/icons/space-pipe-long-junction.png"
          or "__space-exploration-graphics__/graphics/icons/space-pipe-long.png",
        scale = 1, icon_size = 64, shift = {0, 0}},
        { icon = "__space-exploration-graphics__/graphics/icons/number/"..version.length..".png", scale = 1, shift = {-20, -20}, icon_size = 20 },
      },
      name = name,
      order = "a[pipe]-s[space]-c[long]",
      place_result = name,
      stack_size = 50,
      subgroup = "pipe",
      type = "item"
    },
    {
      type = "recipe",
      name = name,
      ingredients = {
        { data_util.mod_prefix .. "space-pipe", math.ceil(version.length/2) },
      },
      result = name,
      energy_required = version.length,
      result_count = 1,
      enabled = false,
      always_show_made_in = true,
    },
    {
      type = "storage-tank",
      name = name,
      localised_name = version.junction
        and {"entity-name."..data_util.mod_prefix.."space-pipe-long-junction", version.length}
        or {"entity-name."..data_util.mod_prefix.."space-pipe-long-straight", version.length},
      localised_description = version.junction
        and {"entity-description."..data_util.mod_prefix.."space-pipe-long-junction", version.length}
        or {"entity-description."..data_util.mod_prefix.."space-pipe-long-straight", version.length},
      minable = {
        mining_time = 0.2,
        result = name,
      },
      selection_box = {{-0.5,-version.length/2},{0.5,version.length/2}},
      collision_box = {{-0.3,-(version.length/2-0.2)},{0.3,version.length/2-0.2}},
      collision_mask = collision_floor,
      scale_info_icons = false,
      two_direction_only = true,
      circuit_wire_max_distance = 0,
      corpse = "storage-tank-remnants",
      order = "z",
      damaged_trigger_effect = {
        entity_name = "spark-explosion",
        offset_deviation = {
          {
            -0.5,
            -0.5
          },
          {
            0.5,
            0.5
          }
        },
        offsets = {
          {
            0,
            1
          }
        },
        type = "create-entity"
      },
      dying_explosion = "storage-tank-explosion",
      flags = {
        "placeable-player",
        "player-creation"
      },
      flow_length_in_ticks = 360,
      fluid_box = {
        base_area = settings.startup["se-space-pipe-capacity"].value/100,
        pipe_connections = pipe_connections,
        pipe_covers = {
          east = {
            layers = {
              {
                filename = "__base__/graphics/entity/pipe-covers/pipe-cover-east.png",
                height = 64,
                hr_version = {
                  filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-east.png",
                  height = 128,
                  priority = "extra-high",
                  scale = 0.5,
                  width = 128
                },
                priority = "extra-high",
                width = 64
              },
              {
                draw_as_shadow = true,
                filename = "__base__/graphics/entity/pipe-covers/pipe-cover-east-shadow.png",
                height = 64,
                hr_version = {
                  draw_as_shadow = true,
                  filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-east-shadow.png",
                  height = 128,
                  priority = "extra-high",
                  scale = 0.5,
                  width = 128
                },
                priority = "extra-high",
                width = 64
              }
            }
          },
          north = {
            layers = {
              {
                filename = "__base__/graphics/entity/pipe-covers/pipe-cover-north.png",
                height = 64,
                hr_version = {
                  filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-north.png",
                  height = 128,
                  priority = "extra-high",
                  scale = 0.5,
                  width = 128
                },
                priority = "extra-high",
                width = 64
              },
              {
                draw_as_shadow = true,
                filename = "__base__/graphics/entity/pipe-covers/pipe-cover-north-shadow.png",
                height = 64,
                hr_version = {
                  draw_as_shadow = true,
                  filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-north-shadow.png",
                  height = 128,
                  priority = "extra-high",
                  scale = 0.5,
                  width = 128
                },
                priority = "extra-high",
                width = 64
              }
            }
          },
          south = {
            layers = {
              {
                filename = "__base__/graphics/entity/pipe-covers/pipe-cover-south.png",
                height = 64,
                hr_version = {
                  filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-south.png",
                  height = 128,
                  priority = "extra-high",
                  scale = 0.5,
                  width = 128
                },
                priority = "extra-high",
                width = 64
              },
              {
                draw_as_shadow = true,
                filename = "__base__/graphics/entity/pipe-covers/pipe-cover-south-shadow.png",
                height = 64,
                hr_version = {
                  draw_as_shadow = true,
                  filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-south-shadow.png",
                  height = 128,
                  priority = "extra-high",
                  scale = 0.5,
                  width = 128
                },
                priority = "extra-high",
                width = 64
              }
            }
          },
          west = {
            layers = {
              {
                filename = "__base__/graphics/entity/pipe-covers/pipe-cover-west.png",
                height = 64,
                hr_version = {
                  filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-west.png",
                  height = 128,
                  priority = "extra-high",
                  scale = 0.5,
                  width = 128
                },
                priority = "extra-high",
                width = 64
              },
              {
                draw_as_shadow = true,
                filename = "__base__/graphics/entity/pipe-covers/pipe-cover-west-shadow.png",
                height = 64,
                hr_version = {
                  draw_as_shadow = true,
                  filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-west-shadow.png",
                  height = 128,
                  priority = "extra-high",
                  scale = 0.5,
                  width = 128
                },
                priority = "extra-high",
                width = 64
              }
            }
          }
        }
      },
      icon = version.junction
        and "__space-exploration-graphics__/graphics/icons/space-pipe-long-junction.png"
        or "__space-exploration-graphics__/graphics/icons/space-pipe-long.png",
      icon_size = 64,
      icon_mipmaps = 1,
      max_health = 500,
      pictures = {
        flow_sprite = {
          filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
          height = 20,
          priority = "extra-high",
          width = 160
        },
        fluid_background = {
          filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
          height = 15,
          priority = "extra-high",
          width = 16
        },
        gas_flow = {
          animation_speed = 0.25,
          axially_symmetrical = false,
          direction_count = 1,
          filename = "__base__/graphics/entity/pipe/steam.png",
          frame_count = 60,
          height = 15,
          hr_version = {
            animation_speed = 0.25,
            axially_symmetrical = false,
            direction_count = 1,
            filename = "__base__/graphics/entity/pipe/hr-steam.png",
            frame_count = 60,
            height = 30,
            line_length = 10,
            priority = "extra-high",
            scale = 0.5,
            width = 48
          },
          line_length = 10,
          priority = "extra-high",
          width = 24
        },
        picture = {
          north = long_vertical_sprites,
          south = long_vertical_sprites,
          east = long_horizontal_sprites,
          west = long_horizontal_sprites,
        },
        window_background = {
          filename = "__base__/graphics/entity/storage-tank/window-background.png",
          height = 12,
          hr_version = {
            filename = "__base__/graphics/entity/storage-tank/hr-window-background.png",
            height = 24,
            priority = "extra-high",
            scale = 0.5,
            width = 34
          },
          priority = "extra-high",
          width = 17
        }
      },
      window_bounding_box = {
        {
          -0.1,
          -0.5
        },
        {
          0.1,
          -0.15
        }
      },
      vehicle_impact_sound = {
        {
          filename = "__base__/sound/car-metal-impact.ogg",
          volume = 0.5
        },
        {
          filename = "__base__/sound/car-metal-impact-2.ogg",
          volume = 0.5
        },
        {
          filename = "__base__/sound/car-metal-impact-3.ogg",
          volume = 0.5
        },
        {
          filename = "__base__/sound/car-metal-impact-4.ogg",
          volume = 0.5
        },
        {
          filename = "__base__/sound/car-metal-impact-5.ogg",
          volume = 0.5
        },
        {
          filename = "__base__/sound/car-metal-impact-6.ogg",
          volume = 0.5
        }
      },
      water_reflection = {
        orientation_to_variation = false,
        pictures = {
          filename = "__base__/graphics/entity/storage-tank/storage-tank-reflection.png",
          height = 24,
          priority = "extra-high",
          scale = 5,
          shift = {
            0.15625,
            1.09375
          },
          variation_count = 1,
          width = 24
        },
        rotate = false
      },
      working_sound = {
        apparent_volume = 1.5,
        match_volume_to_activity = true,
        max_sounds_per_type = 3,
        sound = {
          filename = "__base__/sound/storage-tank.ogg",
          volume = 0.6
        }
      }
    }
  }
end
