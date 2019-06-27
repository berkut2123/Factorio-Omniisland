data:extend(
  {
    {
      type = "assembling-machine",
      name = "assembling-machine-7",
      icon = "__EAB__/graphics/icons/assembling-machine-7.png",
      icon_size = 32,
      flags = {"placeable-neutral", "placeable-player", "player-creation"},
      minable = {hardness = 0.2, mining_time = 0.5, result = "assembling-machine-7"},
      max_health = 700,
      corpse = "big-remnants",
      dying_explosion = "medium-explosion",
      resistances = {
        {
          type = "fire",
          percent = 70
        }
      },
      fluid_boxes = {
        {
          production_type = "input",
          pipe_picture = assembler3pipepictures(),
          pipe_covers = pipecoverspictures(),
          base_area = 10,
          base_level = -1,
          pipe_connections = {{type = "input", position = {0, -2}}}
        },
        {
          production_type = "output",
          pipe_picture = assembler3pipepictures(),
          pipe_covers = pipecoverspictures(),
          base_area = 10,
          base_level = 1,
          pipe_connections = {{type = "output", position = {0, 2}}}
        },
        off_when_no_fluid_recipe = true
      },
      open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
      close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
      working_sound = {
        sound = {
          {
            filename = "__base__/sound/assembling-machine-t3-1.ogg",
            volume = 0.8
          },
          {
            filename = "__base__/sound/assembling-machine-t3-2.ogg",
            volume = 0.8
          }
        },
        idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
        apparent_volume = 1.5
      },
      collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
      selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
      fast_replaceable_group = "assembling-machine",
      animation = {
        layers = {
          {
            filename = "__EAB__/graphics/entity/assembling-machine-7.png",
            priority = "high",
            width = 142,
            height = 113,
            frame_count = 32,
            line_length = 8,
            shift = {0.84, -0.09}
          },
          {
            filename = "__EAB__/graphics/entity/hr-assembling-machine-7-mask.png",
            priority = "high",
            width = 214,
            height = 237,
            frame_count = 32,
            line_length = 8,
            shift = util.by_pixel(0, -0.75),
            scale = 0.5
          }
        }
      },
      crafting_categories = {"crafting", "advanced-crafting", "crafting-with-fluid"},
      crafting_speed = 4.0,
      energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_second_per_watt = 1 / 750000
      },
      energy_usage = "480kW",
      ingredient_count = 12,
      module_specification = {
        module_slots = 8,
        module_info_icon_shift = {0, 0.5},
        module_info_multi_row_initial_height_modifier = -0.3
      },
      allowed_effects = {"consumption", "speed", "productivity", "pollution"}
    },
    {
      type = "assembling-machine",
      name = "electronics-machine-4",
      icon = "__EAB__/graphics/icons/electronics-machine-4.png",
      icon_size = 32,
      flags = {"placeable-neutral", "placeable-player", "player-creation"},
      minable = {hardness = 0.2, mining_time = 0.5, result = "electronics-machine-4"},
      max_health = 450,
      corpse = "medium-remnants",
      dying_explosion = "medium-explosion",
      resistances = {
        {
          type = "fire",
          percent = 70
        }
      },
      fluid_boxes = {
        {
          production_type = "input",
          pipe_picture = assembler3pipepictures(),
          pipe_covers = pipecoverspictures(),
          base_area = 10,
          base_level = -1,
          pipe_connections = {{type = "input", position = {0.5, -1.5}}}
        },
        off_when_no_fluid_recipe = true
      },
      collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
      selection_box = {{-1, -1}, {1, 1}},
      fast_replaceable_group = "assembling-machine",
      animation = {
        layers = {
          {
            filename = "__EAB__/graphics/entity/assembling-machine-7.png",
            priority = "high",
            width = 142,
            height = 113,
            frame_count = 32,
            line_length = 8,
            shift = {0.56, -0.16},
            scale = 0.66,
            hr_version = {
              filename = "__EAB__/graphics/entity/hr-assembling-machine-7-mask.png",
              priority = "high",
              width = 214,
              height = 237,
              frame_count = 32,
              line_length = 8,
              shift = util.by_pixel(0, -0.75),
              scale = 0.33
            }
          },
          {
            filename = "__EAB__/graphics/entity/assembling-machine-noshad-4.png",
            priority = "high",
            width = 142,
            height = 113,
            frame_count = 32,
            line_length = 8,
            shift = {0.85, -0.15},
            draw_as_shadow = true,
            scale = 0.66,
            hr_version = {
              filename = "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3-shadow.png",
              priority = "high",
              width = 260,
              height = 162,
              frame_count = 32,
              line_length = 8,
              draw_as_shadow = true,
              shift = util.by_pixel(18, 4),
              scale = 0.33
            }
          }
        }
      },
      open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
      close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
      working_sound = {
        sound = {
          {
            filename = "__base__/sound/assembling-machine-t3-1.ogg",
            volume = 0.8
          },
          {
            filename = "__base__/sound/assembling-machine-t3-2.ogg",
            volume = 0.8
          }
        },
        idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
        apparent_volume = 1.5
      },
      crafting_categories = {"electronics", "electronics-machine"},
      crafting_speed = 4,
      energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions = 0.01
      },
      energy_usage = "360kW",
      ingredient_count = 6,
      module_specification = {
        module_slots = 6
      },
      allowed_effects = {"consumption", "speed", "productivity", "pollution"}
    }
  }
)
