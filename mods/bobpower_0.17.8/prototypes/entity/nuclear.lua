if settings.startup["bobmods-power-steam"].value == true then

data.raw["heat-pipe"]["heat-pipe"].fast_replaceable_group = "heat-pipe"

data:extend({
util.merge{data.raw["heat-pipe"]["heat-pipe"],
  {
    name = "heat-pipe-2",
    icon = "__bobpower__/graphics/icons/heat-pipe-2.png",
    icon_size = 32,
    minable = {mining_time = 0.1, result = "heat-pipe-2"},
    max_health = 300,
    minimum_glow_temperature = 400,
    glow_alpha_modifier = 0.5,
    heat_buffer =
    {
      max_transfer = "3GW",
      max_temperature = 1250,
    },
    connection_sprites = make_heat_pipe_pictures("__bobpower__/graphics/heat-pipe-2/", "heat-pipe",
      {
        single = { name = "straight-vertical-single", ommit_number = true },
        straight_vertical = { variations = 6 },
        straight_horizontal = { variations = 6 },
        corner_right_up = { name = "corner-up-right", variations = 6 },
        corner_left_up = { name = "corner-up-left", variations = 6 },
        corner_right_down = { name = "corner-down-right", variations = 6 },
        corner_left_down = { name = "corner-down-left", variations = 6 },
        t_up = {},
        t_down = {},
        t_right = {},
        t_left = {},
        cross = { name = "t" },
        ending_up = {},
        ending_down = {},
        ending_right = {},
        ending_left = {}
      }
    ),
  }
},
util.merge{data.raw["heat-pipe"]["heat-pipe"],
  {
    name = "heat-pipe-3",
    icon = "__bobpower__/graphics/icons/heat-pipe-3.png",
    icon_size = 32,
    minable = {mining_time = 0.1, result = "heat-pipe-3"},
    max_health = 400,
    minimum_glow_temperature = 450,
    glow_alpha_modifier = 0.4,
    heat_buffer =
    {
      max_transfer = "5GW",
      max_temperature = 1500,
    },
    connection_sprites = make_heat_pipe_pictures("__bobpower__/graphics/heat-pipe-3/", "heat-pipe",
      {
        single = { name = "straight-vertical-single", ommit_number = true },
        straight_vertical = { variations = 6 },
        straight_horizontal = { variations = 6 },
        corner_right_up = { name = "corner-up-right", variations = 6 },
        corner_left_up = { name = "corner-up-left", variations = 6 },
        corner_right_down = { name = "corner-down-right", variations = 6 },
        corner_left_down = { name = "corner-down-left", variations = 6 },
        t_up = {},
        t_down = {},
        t_right = {},
        t_left = {},
        cross = { name = "t" },
        ending_up = {},
        ending_down = {},
        ending_right = {},
        ending_left = {}
      }
    ),
  }
}
})

end

if settings.startup["bobmods-power-nuclear"].value == true then

data.raw.reactor["nuclear-reactor"].fast_replaceable_group = "nuclear-reactor"
data.raw.reactor["nuclear-reactor"].use_fuel_glow_color = true
data.raw.reactor["nuclear-reactor"].working_light_picture =
  {
    filename = "__bobpower__/graphics/nuclear-reactor/reactor-lights.png",
    width = 160,
    height = 160,
    shift = { -0.03125, -0.1875 },
    blend_mode = "additive",
    hr_version =
    {
      filename = "__bobpower__/graphics/nuclear-reactor/hr-reactor-lights.png",
      width = 320,
      height = 320,
      scale = 0.5,
      shift = { -0.03125, -0.1875 },
      blend_mode = "additive"
    }
  }

data:extend({util.merge{data.raw.reactor["nuclear-reactor"],
  {
    name = "nuclear-reactor-2",
    icon  = "__base__/graphics/icons/nuclear-reactor.png",
    icon_size = 32,
    minable = {mining_time = 0.5, result = "nuclear-reactor-2"},
    max_health = 750,
    consumption = "72MW",
    heat_buffer =
    {
      max_transfer = "20GW",
      max_temperature = 1250,
    },
    lower_layer_picture =
    {
      filename = "__bobpower__/graphics/nuclear-reactor/reactor-pipes-2.png",
      width = 160,
      height = 160,
      shift = { -0.03125, -0.1875 },
      hr_version =
      {
        filename = "__bobpower__/graphics/nuclear-reactor/hr-reactor-pipes-2.png",
        width = 320,
        height = 320,
        scale = 0.5,
        shift = { -0.03125, -0.1875 }
      }
    },
    connection_patches_connected =
    {
      sheet =
      {
        filename = "__bobpower__/graphics/nuclear-reactor/reactor-connect-patches-2.png",
        width = 32,
        height = 32,
        variation_count = 12,
        hr_version =
        {
          filename = "__bobpower__/graphics/nuclear-reactor/hr-reactor-connect-patches-2.png",
          width = 64,
          height = 64,
          variation_count = 12,
          scale = 0.5
        }
      }
    },
    connection_patches_disconnected =
    {
      sheet =
      {
        filename = "__bobpower__/graphics/nuclear-reactor/reactor-connect-patches-2.png",
        width = 32,
        height = 32,
        variation_count = 12,
        y = 32,
        hr_version =
        {
          filename = "__bobpower__/graphics/nuclear-reactor/hr-reactor-connect-patches-2.png",
          width = 64,
          height = 64,
          variation_count = 12,
          y = 64,
          scale = 0.5
        }
      }
    },
  }
}
})

data:extend({util.merge{data.raw.reactor["nuclear-reactor"],
  {
    name = "nuclear-reactor-3",
    icon  = "__base__/graphics/icons/nuclear-reactor.png",
    icon_size = 32,
    minable = {mining_time = 0.5, result = "nuclear-reactor-3"},
    max_health = 1000,
    consumption = "90MW",
    heat_buffer =
    {
      max_transfer = "30GW",
      max_temperature = 1500,
    },
    lower_layer_picture =
    {
      filename = "__bobpower__/graphics/nuclear-reactor/reactor-pipes-3.png",
      width = 160,
      height = 160,
      shift = { -0.03125, -0.1875 },
      hr_version =
      {
        filename = "__bobpower__/graphics/nuclear-reactor/hr-reactor-pipes-3.png",
        width = 320,
        height = 320,
        scale = 0.5,
        shift = { -0.03125, -0.1875 }
      }
    },
    connection_patches_connected =
    {
      sheet =
      {
        filename = "__bobpower__/graphics/nuclear-reactor/reactor-connect-patches-3.png",
        width = 32,
        height = 32,
        variation_count = 12,
        hr_version =
        {
          filename = "__bobpower__/graphics/nuclear-reactor/hr-reactor-connect-patches-3.png",
          width = 64,
          height = 64,
          variation_count = 12,
          scale = 0.5
        }
      }
    },
    connection_patches_disconnected =
    {
      sheet =
      {
        filename = "__bobpower__/graphics/nuclear-reactor/reactor-connect-patches-3.png",
        width = 32,
        height = 32,
        variation_count = 12,
        y = 32,
        hr_version =
        {
          filename = "__bobpower__/graphics/nuclear-reactor/hr-reactor-connect-patches-3.png",
          width = 64,
          height = 64,
          variation_count = 12,
          y = 64,
          scale = 0.5
        }
      }
    },
  }
}
})

data.raw.reactor["nuclear-reactor"].next_upgrade = "nuclear-reactor-2"
data.raw.reactor["nuclear-reactor-2"].next_upgrade = "nuclear-reactor-3"

end
