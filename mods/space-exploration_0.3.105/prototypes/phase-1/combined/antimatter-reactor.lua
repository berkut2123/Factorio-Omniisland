local data_util = require("data_util")

local blank = {
  direction_count = 8,
  frame_count = 1,
  filename = "__space-exploration-graphics__/graphics/blank.png",
  width = 1,
  height = 1,
  priority = "low"
}

local max_temperature = 10000
local specific_heat_reactor = "10MJ"
local specific_heat_pipe = "1MJ"
local specific_heat_pipe_long = "2MJ"
local max_transfer = "100GW"
local pipe_tint = {r = 0.8, b=1, g=0.8}
local glow_tint = {r = 0.5, b=1, g=0.5}
local long_versions = {
  {pattern = "--+--", icon = "__space-exploration-graphics__/graphics/icons/naquium-heat-pipe-horizontal.png"},
  {pattern = "--+-----+--", icon = "__space-exploration-graphics__/graphics/icons/naquium-heat-pipe-horizontal-2.png"},
}
data:extend({
  {
    type = "reactor",
    name = data_util.mod_prefix .. "antimatter-reactor",
    icon  = "__space-exploration-graphics__/graphics/icons/antimatter-reactor.png",
    icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "antimatter-reactor"},
    max_health = 500,
    corpse = "nuclear-reactor-remnants",
    consumption = "400MW",
    neighbour_bonus = 1,
    energy_source =
    {
      type = "burner",
      fuel_category = "antimatter",
      effectivity = 1,
      fuel_inventory_size = 1,
      burnt_inventory_size = 1
    },
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    --the collision box of a reactor is increased by this on the sides where it connects to another reactor:
    --neighbour_collision_increase = 0.25,
    lower_layer_picture =
    {
      filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
      width = 156,
      height = 156,
      shift = util.by_pixel(-2, -4),
      tint = pipe_tint,
      hr_version =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-pipes.png",
        width = 320,
        height = 316,
        scale = 0.5,
        shift = util.by_pixel(-1, -5),
        tint = pipe_tint,
      }
    },
    heat_lower_layer_picture =
    {
      filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes-heated.png",
      width = 156,
      height = 156,
      shift = util.by_pixel(-3, -4),
      tint = glow_tint,
      blend_mode = "additive",
      hr_version =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-pipes-heated.png",
        width = 320,
        height = 316,
        scale = 0.5,
        shift = util.by_pixel(-0.5, -4.5),
        tint = glow_tint,
        blend_mode = "additive",
      }
    },

    picture =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics__/graphics/entity/antimatter-reactor/reactor.png",
          width = 160,
          height = 160,
          shift = { -0.03125, -0.1875 },
          hr_version =
          {
            filename = "__space-exploration-graphics__/graphics/entity/antimatter-reactor/hr-reactor.png",
            width = 320,
            height = 320,
            scale = 0.5,
            shift = { -0.03125, -0.1875 }
          }
        },
        {
          filename = "__base__/graphics/entity/nuclear-reactor/reactor-shadow.png",
          width = 263,
          height = 162,
          shift = { 1.625 , 0 },
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-shadow.png",
            width = 525,
            height = 323,
            scale = 0.5,
            shift = { 1.625, 0 },
            draw_as_shadow = true
          }
        }
      }
    },

    working_light_picture =
    {
      filename = "__space-exploration-graphics__/graphics/entity/antimatter-reactor/reactor-lights-color.png",
      width = 160,
      height = 160,
      shift = { -0.03125, -0.1875 },
      blend_mode = "additive",
      hr_version =
      {
        filename = "__space-exploration-graphics__/graphics/entity/antimatter-reactor/hr-reactor-lights-color.png",
        width = 320,
        height = 320,
        scale = 0.5,
        shift = { -0.03125, -0.1875 },
        blend_mode = "additive"
      }
    },

    light = {intensity = 1, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.9, g = 0.0, b = 1.0}},

    heat_buffer =
    {
      max_temperature = max_temperature,
      specific_heat = specific_heat_reactor,
      max_transfer = max_transfer,
      connections =
      {
        {
          position = {-2, -2},
          direction = defines.direction.north
        },
        {
          position = {0, -2},
          direction = defines.direction.north
        },
        {
          position = {2, -2},
          direction = defines.direction.north
        },
        {
          position = {2, -2},
          direction = defines.direction.east
        },
        {
          position = {2, 0},
          direction = defines.direction.east
        },
        {
          position = {2, 2},
          direction = defines.direction.east
        },
        {
          position = {2, 2},
          direction = defines.direction.south
        },
        {
          position = {0, 2},
          direction = defines.direction.south
        },
        {
          position = {-2, 2},
          direction = defines.direction.south
        },
        {
          position = {-2, 2},
          direction = defines.direction.west
        },
        {
          position = {-2, 0},
          direction = defines.direction.west
        },
        {
          position = {-2, -2},
          direction = defines.direction.west
        }
      },

      heat_picture =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-heated.png",
        width = 108,
        height = 128,
        shift = util.by_pixel(1, -7),
        tint = glow_tint,
        blend_mode = "additive",
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-heated.png",
          width = 216,
          height = 256,
          scale = 0.5,
          shift = util.by_pixel(3, -6.5),
          tint = glow_tint,
          blend_mode = "additive",
        }
      },
      heat_glow =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-heat-glow.png",
        priority = "extra-high",
        width = 188,
        height = 190,
        shift = util.by_pixel(-2, -4),
        tint = glow_tint,
        blend_mode = "additive",
      }
    },

    connection_patches_connected =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches.png",
        width = 32,
        height = 32,
        variation_count = 12,
        tint = pipe_tint,
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-connect-patches.png",
          width = 64,
          height = 64,
          variation_count = 12,
          scale = 0.5,
          tint = pipe_tint,
        }
      }
    },

    connection_patches_disconnected =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches.png",
        width = 32,
        height = 32,
        variation_count = 12,
        y = 32,
        tint = pipe_tint,
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-connect-patches.png",
          width = 64,
          height = 64,
          variation_count = 12,
          y = 64,
          scale = 0.5,
          tint = pipe_tint,
        }
      }
    },

    connection_patches =
    {
      north =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/connection-patch-north.png",
        width = 160,
        height = 15,
        shift = util.by_pixel(0, -72.5),
        tint = pipe_tint,
      },
      east =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/connection-patch-east.png",
        width = 15,
        height = 160,
        shift = util.by_pixel(72.5, 0)
      },
      south =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/connection-patch-south.png",
        width = 160,
        height = 15,
        shift = util.by_pixel(0, 72.5)
      },
      west =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/connection-patch-west.png",
        width = 15,
        height = 160,
        shift = util.by_pixel(-72.5, 0)
      }
    },

    heat_connection_patches_connected =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches-heated.png",
        width = 32,
        height = 32,
        variation_count = 12,
        tint = glow_tint,
        blend_mode = "additive",
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-connect-patches-heated.png",
          width = 64,
          height = 64,
          variation_count = 12,
          scale = 0.5,
          tint = glow_tint,
          blend_mode = "additive",
        }
      }
    },

    heat_connection_patches_disconnected =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches-heated.png",
        width = 32,
        height = 32,
        variation_count = 12,
        y = 32,
        tint = glow_tint,
        blend_mode = "additive",
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-connect-patches-heated.png",
          width = 64,
          height = 64,
          variation_count = 12,
          y = 64,
          scale = 0.5,
          tint = glow_tint,
          blend_mode = "additive",
        }
      }
    },

    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},

    meltdown_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
              repeat_count = 100,
              type = "create-trivial-smoke",
              smoke_name = "nuclear-smoke",
              offset_deviation = {{-1, -1}, {1, 1}},
              starting_frame = 3,
              starting_frame_deviation = 5,
              starting_frame_speed = 0,
              starting_frame_speed_deviation = 5,
              speed_from_center = 0.5
          },
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "damage",
            damage = {amount = 400, type = "explosion"}
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 2000,
              radius = 35,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-wave",
                starting_speed = 0.5
              }
            }
          }
        }
      }
    }
  },
})

data.raw["heat-pipe"]["heat-pipe"].fast_replaceable_group = "heat-pipe"
local heat_pipe = table.deepcopy(data.raw["heat-pipe"]["heat-pipe"])
heat_pipe.name = data_util.mod_prefix .. "naquium-heat-pipe"
heat_pipe.icon = "__space-exploration-graphics__/graphics/icons/naquium-heat-pipe.png"
heat_pipe.icon_size = 64
heat_pipe.icon_mipmaps = 1
heat_pipe.heat_buffer.max_temperature = max_temperature
heat_pipe.heat_buffer.specific_heat = specific_heat_pipe
heat_pipe.heat_buffer.max_transfer = max_transfer
heat_pipe.order = "z"
heat_pipe.minable.result = data_util.mod_prefix .. "naquium-heat-pipe"

data_util.tint_recursive(heat_pipe.connection_sprites, pipe_tint)
data_util.tint_recursive(heat_pipe.heat_glow_sprites, glow_tint)
data_util.blend_mode_recursive(heat_pipe.heat_glow_sprites, "additive")
data_util.tint_recursive(heat_pipe.heat_buffer.heat_glow, glow_tint)
data_util.blend_mode_recursive(heat_pipe.heat_buffer.heat_glow, "additive")
data:extend({
  heat_pipe,
})

local pipes_cross = {
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-t-1.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-t-1.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64
    },
  }
}
local pipes_horizontal = {
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-horizontal-1.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-horizontal-1.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-horizontal-2.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-horizontal-2.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-horizontal-3.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    shift = {-4,0},
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-horizontal-3.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-horizontal-4.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-horizontal-4.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-horizontal-5.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-horizontal-5.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-horizontal-6.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-horizontal-6.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
}
local pipes_vertical = {
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-vertical-1.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-vertical-1.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-vertical-2.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-vertical-2.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-vertical-3.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    shift = {-4,0},
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-vertical-3.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-vertical-4.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-vertical-4.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-vertical-5.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-vertical-5.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
  {
    filename = "__base__/graphics/entity/heat-pipe/heat-pipe-straight-vertical-6.png",
    height = 32,
    priority = "extra-high",
    width = 32,
    hr_version = {
      filename = "__base__/graphics/entity/heat-pipe/hr-heat-pipe-straight-vertical-6.png",
      height = 64,
      priority = "extra-high",
      scale = 0.5,
      width = 64,
    },
  },
}
local pipe_glow = {
  filename = "__base__/graphics/entity/heat-pipe/heated-glow.png",
  width = 55,
  height = 55,
  priority = "extra-high",
  tint = glow_tint,
  blend_mode = "additive"
}

local shift_sprite = data_util.shift_sprite

for _, version in pairs(long_versions) do
  local length = #version.pattern
  local name = heat_pipe.name.."-long"..version.pattern
  local long_pipes_horizontal = {}
  local long_pipes_vertical = {}
  local long_pipes_glow_horizontal = {}
  local long_pipes_glow_vertical = {}
  local connections = {}
  for i = 1, #version.pattern do
    local c = string.sub(version.pattern, i, i)
    local j = i - length/2 -0.5
    if i == 1 and (c == "-" or c == "+") then
      table.insert(connections,{
        position = {0, j},
        direction = defines.direction.north
      })
    end
    if i == length and (c == "-" or c == "+") then
      table.insert(connections,{
        position = {0, j},
        direction = defines.direction.south
      })
    end
    if c == "+" then
      table.insert(connections,{
        position = {0, j},
        direction = defines.direction.east
      })
      table.insert(connections,{
        position = {0, j},
        direction = defines.direction.west
      })
      table.insert(long_pipes_horizontal, shift_sprite(table.deepcopy(pipes_cross[1+i%#pipes_cross]),{j,0}))
      table.insert(long_pipes_vertical, shift_sprite(table.deepcopy(pipes_cross[1+i%#pipes_cross]),{0,j}))
    elseif  c == "-" then
      table.insert(long_pipes_horizontal, shift_sprite(table.deepcopy(pipes_horizontal[1+i%#pipes_horizontal]),{j,0}))
      table.insert(long_pipes_vertical, shift_sprite(table.deepcopy(pipes_vertical[1+i%#pipes_vertical]),{0,j}))
    end
    table.insert(long_pipes_glow_horizontal, shift_sprite(table.deepcopy(pipe_glow),{j,0}))
    table.insert(long_pipes_glow_vertical, shift_sprite(table.deepcopy(pipe_glow),{0,j}))
  end
  local long_pipes_heated_horizontal = table.deepcopy(long_pipes_horizontal)
  local long_pipes_heated_vertical = table.deepcopy(long_pipes_vertical)
  data_util.tint_recursive(long_pipes_horizontal, pipe_tint)
  data_util.tint_recursive(long_pipes_vertical, pipe_tint)

  data_util.replace_filenames_recursive(long_pipes_heated_horizontal, "heat-pipe/heat-pipe", "heat-pipe/heated")
  data_util.replace_filenames_recursive(long_pipes_heated_horizontal, "heat-pipe/hr-heat-pipe", "heat-pipe/hr-heated")
  data_util.tint_recursive(long_pipes_heated_horizontal, glow_tint)
  data_util.blend_mode_recursive(long_pipes_heated_horizontal, "additive")

  data_util.replace_filenames_recursive(long_pipes_heated_vertical, "heat-pipe/heat-pipe", "heat-pipe/heated")
  data_util.replace_filenames_recursive(long_pipes_heated_vertical, "heat-pipe/hr-heat-pipe", "heat-pipe/hr-heated")
  data_util.tint_recursive(long_pipes_heated_vertical, glow_tint)
  data_util.blend_mode_recursive(long_pipes_heated_vertical, "additive")


  table.insert(data.raw.technology[data_util.mod_prefix.."antimatter-reactor"].effects,
    { type = "unlock-recipe", recipe = name })
  data:extend{
    {
      type = "item",
      name = name,
      icon = version.icon,
      icon_size = 64,
      order = "f[nuclear-energy]-b[heat-pipe]-n",
      subgroup = "energy",
      stack_size = 50,
      place_result = name,
    },
    {
      type = "recipe",
      name = name,
      result = name,
      enabled = false,
      energy_required = 10,
      ingredients = {
        { data_util.mod_prefix .. "naquium-heat-pipe", math.ceil(length/2)},
      },
      requester_paste_multiplier = 1,
      always_show_made_in = true,
    },
    {
      type = "boiler",
      name = name,
      localised_name = {"entity-name."..data_util.mod_prefix.."naquium-heat-pipe-long", version.pattern},
      localised_description = {"entity-description."..data_util.mod_prefix.."naquium-heat-pipe-long", version.pattern},
      burning_cooldown = 20,
      collision_box = {{-0.3,-(length/2-0.2)},{0.3,(length/2-0.2)}},
      collision_mask = {
        "item-layer",
        "floor-layer",
        "object-layer",
        "water-tile"
      },
      selection_box = {{-0.5,-length/2},{0.5,length/2}},
      order = "z",
      corpse = "heat-pipe-remnants",
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
      dying_explosion = "heat-exchanger-explosion",
      energy_consumption = "0.0000001W",
      energy_source = {
        connections = connections,
        heat_glow = {
          east = {layers = long_pipes_glow_horizontal},
          north = {layers = long_pipes_glow_vertical},
          south = {layers = long_pipes_glow_vertical},
          west = {layers = long_pipes_glow_horizontal},
        },
        heat_picture = {
          east = {layers = {{layers = long_pipes_heated_horizontal}}},
          north = {layers = {{layers = long_pipes_heated_vertical}}},
          south = {layers ={{layers =  long_pipes_heated_vertical}}},
          west = {layers = {{layers = long_pipes_heated_horizontal}}},
        },
        heat_pipe_covers = {
          east = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings-heated.png",
            frame_count = 1,
            height = 32,
            tint = glow_tint,
            blend_mode = "additive",
            hr_version = {
              tint = glow_tint,
              blend_mode = "additive",
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings-heated.png",
              frame_count = 1,
              height = 64,
              priority = "high",
              scale = 0.5,
              width = 64,
              x = 64,
              y = 0
            },
            priority = "high",
            scale = 1,
            width = 32,
            x = 32,
            y = 0
          },
          north = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings-heated.png",
            frame_count = 1,
            height = 32,
            tint = glow_tint,
            blend_mode = "additive",
            hr_version = {
              tint = glow_tint,
              blend_mode = "additive",
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings-heated.png",
              frame_count = 1,
              height = 64,
              priority = "high",
              scale = 0.5,
              width = 64,
              x = 0,
              y = 0
            },
            priority = "high",
            scale = 1,
            width = 32,
            x = 0,
            y = 0
          },
          south = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings-heated.png",
            frame_count = 1,
            height = 32,
            tint = glow_tint,
            blend_mode = "additive",
            hr_version = {
              tint = glow_tint,
              blend_mode = "additive",
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings-heated.png",
              frame_count = 1,
              height = 64,
              priority = "high",
              scale = 0.5,
              width = 64,
              x = 128,
              y = 0
            },
            priority = "high",
            scale = 1,
            width = 32,
            x = 64,
            y = 0
          },
          west = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings-heated.png",
            frame_count = 1,
            height = 32,
            tint = glow_tint,
            blend_mode = "additive",
            hr_version = {
              tint = glow_tint,
              blend_mode = "additive",
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings-heated.png",
              frame_count = 1,
              height = 64,
              priority = "high",
              scale = 0.5,
              width = 64,
              x = 192,
              y = 0
            },
            priority = "high",
            scale = 1,
            width = 32,
            x = 96,
            y = 0
          }
        },
        max_temperature = max_temperature,
        max_transfer = max_transfer,
        min_working_temperature = max_temperature,
        minimum_glow_temperature = 350,
        pipe_covers = {
          east = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
            frame_count = 1,
            height = 32,
            tint = pipe_tint,
            hr_version = {
            tint = pipe_tint,
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings.png",
              frame_count = 1,
              height = 64,
              priority = "high",
              scale = 0.5,
              width = 64,
              x = 64,
              y = 0
            },
            priority = "high",
            scale = 1,
            width = 32,
            x = 32,
            y = 0
          },
          north = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
            frame_count = 1,
            height = 32,
            tint = pipe_tint,
            hr_version = {
            tint = pipe_tint,
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings.png",
              frame_count = 1,
              height = 64,
              priority = "high",
              scale = 0.5,
              width = 64,
              x = 0,
              y = 0
            },
            priority = "high",
            scale = 1,
            width = 32,
            x = 0,
            y = 0
          },
          south = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
            frame_count = 1,
            height = 32,
            tint = pipe_tint,
            hr_version = {
            tint = pipe_tint,
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings.png",
              frame_count = 1,
              height = 64,
              priority = "high",
              scale = 0.5,
              width = 64,
              x = 128,
              y = 0
            },
            priority = "high",
            scale = 1,
            width = 32,
            x = 64,
            y = 0
          },
          west = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
            frame_count = 1,
            height = 32,
            tint = pipe_tint,
            hr_version = {
            tint = pipe_tint,
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings.png",
              frame_count = 1,
              height = 64,
              priority = "high",
              scale = 0.5,
              width = 64,
              x = 192,
              y = 0
            },
            priority = "high",
            scale = 1,
            width = 32,
            x = 96,
            y = 0
          }
        },
        specific_heat = specific_heat_pipe_long,
        type = "heat"
      },
      fire = {},
      fire_glow = {},
      flags = {
        "placeable-neutral",
        "player-creation"
      },
      fluid_box = {
        base_area = 1,
        base_level = 1,
        filter = "water",
        height = 2,
        pipe_connections = { },
        production_type = "input-output"
      },
      icon = version.icon,
      icon_mipmaps = 1,
      icon_size = 64,
      max_health = 200,
      minable = {
        mining_time = 0.2,
        result = name
      },
      mode = "output-to-separate-pipe",
      output_fluid_box = {
        base_area = 1,
        base_level = 1,
        filter = "steam",
        height = 2,
        pipe_connections = { },
        production_type = "output"
      },
      resistances = {
        {
          percent = 90,
          type = "fire"
        },
        {
          percent = 30,
          type = "explosion"
        },
        {
          percent = 30,
          type = "impact"
        }
      },
      structure = {
        east = {layers = {{layers = long_pipes_horizontal}}},
        north = {layers = {{layers = long_pipes_vertical}}},
        south = {layers = {{layers = long_pipes_vertical}}},
        west = {layers = {{layers = long_pipes_horizontal}}},
      },
      target_temperature = max_temperature,
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
        orientation_to_variation = true,
        pictures = {
          filename = "__base__/graphics/entity/boiler/boiler-reflection.png",
          height = 32,
          priority = "extra-high",
          scale = 5,
          shift = {
            0.15625,
            0.9375
          },
          variation_count = 4,
          width = 28
        },
        rotate = false
      },
      working_sound = {
        fade_in_ticks = 10,
        fade_out_ticks = 30,
        max_sounds_per_type = 3,
        sound = {
          filename = "__base__/sound/boiler.ogg",
          volume = 0.8
        }
      }
    }
  }
end
