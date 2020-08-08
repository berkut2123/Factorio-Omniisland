local data_util = require("data_util")
local make_recipe = data_util.make_recipe
local pipe_tint = {r = 0.8, b=1, g=0.8}
local glow_tint = {r = 0.5, b=1, g=0.5}

data.raw["heat-interface"]["heat-interface"].heat_buffer.max_temperature = 10000 --For testing 5000C heat exchangers.

data:extend({
    {
        type = "item",
        name = data_util.mod_prefix .. "big-heat-exchanger",
        icon = "__space-exploration-graphics__/graphics/icons/big-heat-exchanger.png",
        icon_size = 64,
        order = "d[fluid-burner-generator]-a",
        subgroup = "energy",
        stack_size = 50,
        place_result = data_util.mod_prefix .. "big-heat-exchanger",
    },
    {
        type = "recipe",
        name = data_util.mod_prefix .. "big-heat-exchanger",
        result = data_util.mod_prefix .. "big-heat-exchanger",
        enabled = false,
        energy_required = 30,
        ingredients = {
          { data_util.mod_prefix .. "lattice-pressure-vessel", 10 },
          { data_util.mod_prefix .. "naquium-cube", 1 },
          { data_util.mod_prefix .. "space-pipe", 50 },
          { data_util.mod_prefix .. "heavy-composite", 20 },
          { data_util.mod_prefix .. "heat-shielding", 50 },
        },
        requester_paste_multiplier = 1,
        always_show_made_in = false,
    },
    {
        type = "technology",
        name = data_util.mod_prefix .. "big-heat-exchanger",
        effects = {
         {
           type = "unlock-recipe",
           recipe = data_util.mod_prefix .. "big-heat-exchanger",
         },
        },
        icon = "__space-exploration-graphics__/graphics/technology/big-heat-exchanger.png",
        icon_size = 128,
        order = "e-g",
        prerequisites = {
          data_util.mod_prefix .. "lattice-pressure-vessel",
          data_util.mod_prefix .. "naquium-cube",
        },
        unit = {
         count = 500,
         time = 60,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { "production-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "astronomic-science-pack-4", 1 },
           { data_util.mod_prefix .. "material-science-pack-4", 1 },
           { data_util.mod_prefix .. "energy-science-pack-4", 1 },
           { data_util.mod_prefix .. "deep-space-science-pack", 1 },
         }
        },
    },
    {
      type = "boiler",
      name = data_util.mod_prefix .. "big-heat-exchanger",
      icon = "__space-exploration-graphics__/graphics/icons/big-heat-exchanger.png",
      icon_mipmaps = 1,
      icon_size = 64,
      burning_cooldown = 20,
      collision_box = {{-2.3,-2.3},{2.3,2.3}},
      selection_box = {{-2.5,-2.5},{2.5,2.5}},
      corpse = "heat-exchanger-remnants",
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
      energy_consumption = "560MW",
      energy_source = {
        connections = {
          {
            direction = 4,
            position = {
              0,
              2
            }
          }
        },
        heat_glow = {
          east = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-E-glow.png",
            height = 62,
            priority = "extra-high",
            shift = {
              -0.6875-1.5,
              -0.375-0.5
            },
            width = 60
          },
          north = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-N-glow.png",
            height = 70,
            priority = "extra-high",
            shift = {
              0,
              0.25+1
            },
            tint = {
              b = 0.75,
              g = 0.85,
              r = 1
            },
            width = 38
          },
          south = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-S-glow.png",
            height = 40,
            priority = "extra-high",
            shift = {
              0,
              -1.125-1
            },
            tint = nil,
            width = 38
          },
          west = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-W-glow.png",
            height = 64,
            priority = "extra-high",
            shift = {
              0.625+1.5,
              -0.375-0.5
            },
            width = 60
          }
        },
        heat_picture = {
          east = {
            filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/east_heated.png",
            frame_count = 1,
            line_length = 1,
            width = 128/2,
            height = 128/2,
            shift = {-2,-0.5},
            tint = glow_tint,
            blend_mode = "additive",
            hr_version = data_util.hr({
              tint = glow_tint,
              blend_mode = "additive",
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/east_heated.png",
              frame_count = 1,
              line_length = 1,
              width = 128,
              height = 128,
              shift = {-2,-0.5},
              scale = 0.5,
            }),
          },
          north = {
            filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/north_heated.png",
            frame_count = 1,
            line_length = 1,
            width = 64/2,
            height = 160/2,
            shift = {0,1.25},
            tint = glow_tint,
            blend_mode = "additive",
            hr_version = data_util.hr({
              tint = glow_tint,
              blend_mode = "additive",
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/north_heated.png",
              frame_count = 1,
              line_length = 1,
              width = 64,
              height = 160,
              shift = {0,1.25},
              scale = 0.5,
            }),
          },
          south = {
            filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/south_heated.png",
            frame_count = 1,
            line_length = 1,
            width = 64/2,
            height = 64/2,
            shift = {0,-2.5},
            tint = glow_tint,
            blend_mode = "additive",
            hr_version = data_util.hr({
              tint = glow_tint,
              blend_mode = "additive",
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/south_heated.png",
              frame_count = 1,
              line_length = 1,
              width = 64,
              height = 64,
              shift = {0,-2.5},
              scale = 0.5,
            }),
          },
          west = {
            filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/west_heated.png",
            frame_count = 1,
            line_length = 1,
            width = 128/2,
            height = 128/2,
            shift = {2,-0.5},
            tint = glow_tint,
            blend_mode = "additive",
            hr_version = data_util.hr({
              tint = glow_tint,
              blend_mode = "additive",
              filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/west_heated.png",
              frame_count = 1,
              line_length = 1,
              width = 128,
              height = 128,
              shift = {2,-0.5},
              scale = 0.5,
            }),
          },
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
        max_temperature = 10000,
        max_transfer = "2GW",
        min_working_temperature = 5000,
        minimum_glow_temperature = 350,
        pipe_covers = {
          east = {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
            frame_count = 1,
            height = 32,
            hr_version = {
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
            hr_version = {
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
            hr_version = {
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
            hr_version = {
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
        specific_heat = "1MJ",
        type = "heat"
      },
      fire = {},
      fire_glow = {},
      flags = {
        "placeable-neutral",
        "player-creation"
      },
      fluid_box = {
        base_area = 10,
        base_level = -1,
        filter = "water",
        height = 2,
        pipe_connections = {
          {
            position = {
              -3,
              1
            },
            type = "input-output"
          },
          {
            position = {
              3,
              1
            },
            type = "input-output"
          }
        },
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
        },
        production_type = "input-output"
      },
      max_health = 500,
      minable = {
        mining_time = 0.1,
        result = data_util.mod_prefix .. "big-heat-exchanger",
      },
      mode = "output-to-separate-pipe",
      output_fluid_box = {
        base_area = 10,
        base_level = 1,
        filter = "steam",
        height = 2,
        pipe_connections = {
          {
            position = {
              0,
              -3
            },
            type = "output"
          }
        },
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
        },
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
        east = {
          layers = {
            {
              filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/east.png",
              frame_count = 1,
              line_length = 1,
              width = 384/2,
              height = 384/2,
              shift = {0,-0.5},
              hr_version = data_util.hr({
                filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/east.png",
                frame_count = 1,
                line_length = 1,
                width = 384,
                height = 384,
                shift = {0,-0.5},
                scale = 0.5,
              }),
            },
            {
              draw_as_shadow = true,
              filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/east_shadow.png",
              frame_count = 1,
              line_length = 1,
              width = 512/2,
              height = 352/2,
              shift = {1,0.25},
              hr_version = data_util.hr({
                draw_as_shadow = true,
                filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/east_shadow.png",
                frame_count = 1,
                line_length = 1,
                width = 512,
                height = 352,
                shift = {1,0.25},
                scale = 0.5,
              }),
            },
          }
        },
        north = {
          layers = {
            {
              filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/north.png",
              frame_count = 1,
              line_length = 1,
              width = 384/2,
              height = 384/2,
              shift = {0,-0.5},
              hr_version = data_util.hr({
                filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/north.png",
                frame_count = 1,
                line_length = 1,
                width = 384,
                height = 384,
                shift = {0,-0.5},
                scale = 0.5,
              }),
            },
            {
              draw_as_shadow = true,
              filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/north_shadow.png",
              frame_count = 1,
              line_length = 1,
              width = 512/2,
              height = 320/2,
              shift = {1.5,0.5},
              hr_version = data_util.hr({
                draw_as_shadow = true,
                filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/north_shadow.png",
                frame_count = 1,
                line_length = 1,
                width = 512,
                height = 320,
                shift = {1.5,0.5},
                scale = 0.5,
              }),
            },
          }
        },
        south = {
          layers = {
            {
              filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/south.png",
              frame_count = 1,
              line_length = 1,
              width = 384/2,
              height = 384/2,
              shift = {0,-0.5},
              hr_version = data_util.hr({
                filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/south.png",
                frame_count = 1,
                line_length = 1,
                width = 384,
                height = 384,
                shift = {0,-0.5},
                scale = 0.5,
              }),
            },
            {
              draw_as_shadow = true,
              filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/south_shadow.png",
              frame_count = 1,
              line_length = 1,
              width = 512/2,
              height = 256/2,
              shift = {1.5,0.5},
              hr_version = data_util.hr({
                draw_as_shadow = true,
                filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/south_shadow.png",
                frame_count = 1,
                line_length = 1,
                width = 512,
                height = 256,
                shift = {1.5,0.5},
                scale = 0.5,
              }),
            },
          }
        },
        west = {
          layers = {
            {
              filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/west.png",
              frame_count = 1,
              line_length = 1,
              width = 384/2,
              height = 384/2,
              shift = {0,-0.5},
              hr_version = data_util.hr({
                filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/west.png",
                frame_count = 1,
                line_length = 1,
                width = 384,
                height = 384,
                shift = {0,-0.5},
                scale = 0.5,
              }),
            },
            {
              draw_as_shadow = true,
              filename = "__space-exploration-graphics__/graphics/entity/big-heat-exchanger/sr/west_shadow.png",
              frame_count = 1,
              line_length = 1,
              width = 448/2,
              height = 352/2,
              shift = {1,0.25},
              hr_version = data_util.hr({
                draw_as_shadow = true,
                filename = "__space-exploration-hr-graphics__/graphics/entity/big-heat-exchanger/hr/west_shadow.png",
                frame_count = 1,
                line_length = 1,
                width = 448,
                height = 352,
                shift = {1,0.25},
                scale = 0.5,
              }),
            },
          }
        }
      },
      target_temperature = 5000,
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
})
local he = data.raw.boiler[data_util.mod_prefix .. "big-heat-exchanger"]
data_util.tint_recursive(he.energy_source.pipe_covers, pipe_tint)
data_util.tint_recursive(he.energy_source.heat_pipe_covers, glow_tint)
data_util.blend_mode_recursive(he.energy_source.heat_pipe_covers, "additive")
