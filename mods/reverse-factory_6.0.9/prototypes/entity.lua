data:extend({
--Reverse Factory tier 1
{
    type = "furnace",
    name = "reverse-factory-1",
    icon = "__reverse-factory__/graphics/item/reverse-factory-1.png",
	icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable =
    {
        mining_time = 1,
        result = "reverse-factory-1"
    },
    max_health = 250,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    light =
    {
        intensity = 1,
        size = 10
    },
    resistances =
    {
        {
          type = "fire",
          percent = 80
        }
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
	module_specification =
    {
      module_slots = 2,
      module_info_icon_shift = {0, 0.8}
    },
    allowed_effects = {"consumption", "speed", "pollution"},
    crafting_categories = {"recycle"},
    result_inventory_size = 5,
    crafting_speed = 25,
    energy_usage = "100kW",
    source_inventory_size = 1,
    fast_replaceable_group = "reverse-factory",
    energy_source =
    {
        type = "electric",
        usage_priority = "secondary-input",
        emissions = 0.005
    },
    working_sound =
    {
        sound =
        {
            filename = "__base__/sound/electric-furnace.ogg",
            volume = 0.7
        },
        apparent_volume = 1.5
    },
    animation =
    {
        filename = "__reverse-factory__/graphics/entity/reverse-factory-1.png",
        priority = "high",
        width = 129,
        height = 100,
        frame_count = 1,
        shift = {0.421875, 0}
    },
    working_visualisations =
    {
        {
            animation =
            {
                filename = "__reverse-factory__/graphics/entity/reverse-factory-heater.png",
                priority = "high",
                width = 25,
                height = 15,
                frame_count = 12,
                animation_speed = 0.5,
                shift = {0.015625, 0.890625}
            },
            light =
            {
                intensity = 0.4,
                size = 6, shift = {0.0, 1.0}
            }
        },
        {
            animation =
            {
                filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-1.png",
                priority = "high",
                width = 19,
                height = 13,
                frame_count = 4,
                animation_speed = 0.5,
                shift = {-0.671875, -0.640625}
            }
        },
        {
            animation =
            {
                filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-2.png",
                priority = "high",
                width = 12,
                height = 9,
                frame_count = 4,
                animation_speed = 0.5,
                shift = {0.0625, -1.234375}
            }
        }
    },
},

--Reverse factory tier 2
{
    type = "furnace",
    name = "reverse-factory-2",
    icon = "__reverse-factory__/graphics/item/reverse-factory-2.png",
	icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable =
    {
        mining_time = 1,
        result = "reverse-factory-2"
    },
    max_health = 250,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    light =
    {
        intensity = 1,
        size = 10
    },
    resistances =
    {
        {
          type = "fire",
          percent = 80
        }
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
	module_specification =
    {
      module_slots = 4,
      module_info_icon_shift = {0, 0.8}
    },
    allowed_effects = {"consumption", "speed", "pollution"},
    crafting_categories = {"recycle", "recycle-with-fluids"},
    result_inventory_size = 5,
    crafting_speed = 50,
    energy_usage = "120kW",
    source_inventory_size = 1,
    fast_replaceable_group = "reverse-factory",
    energy_source =
    {
        type = "electric",
        usage_priority = "secondary-input",
        emissions = 0.005
    },
    working_sound =
    {
        sound =
        {
            filename = "__base__/sound/electric-furnace.ogg",
            volume = 0.7
        },
        apparent_volume = 1.5
    },
    animation =
    {
        filename = "__reverse-factory__/graphics/entity/reverse-factory-2.png",
        priority = "high",
        width = 129,
        height = 100,
        frame_count = 1,
        shift = {0.421875, 0}
    },
    working_visualisations =
    {
        {
            animation =
            {
                filename = "__reverse-factory__/graphics/entity/reverse-factory-heater.png",
                priority = "high",
                width = 25,
                height = 15,
                frame_count = 12,
                animation_speed = 0.5,
                shift = {0.015625, 0.890625}
            },
            light =
            {
                intensity = 0.4,
                size = 6, shift = {0.0, 1.0}
            }
        },
        {
            animation =
            {
                filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-1.png",
                priority = "high",
                width = 19,
                height = 13,
                frame_count = 4,
                animation_speed = 0.5,
                shift = {-0.671875, -0.640625}
            }
        },
        {
            animation =
            {
                filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-2.png",
                priority = "high",
                width = 12,
                height = 9,
                frame_count = 4,
                animation_speed = 0.5,
                shift = {0.0625, -1.234375}
            }
        }
    },
	fluid_boxes =
    {
      {
        production_type = "output",
		pipe_picture = rfpipepictures(),
        pipe_covers = pipecoverspictures(),
        base_level = 1,
        pipe_connections = {{ position = {-1, -2} }}
      },
      {
        production_type = "output",
		pipe_picture = rfpipepictures(),
        pipe_covers = pipecoverspictures(),
        base_level = 1,
        pipe_connections = {{ position = {1, -2} }}
      }
    }
}
})
