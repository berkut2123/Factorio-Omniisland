local data_util = require("data_util")

-- Collision entities
local base_collision_entity = {
    type = "simple-entity",
    icon = "__base__/graphics/icons/iron-chest.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-off-grid"},
    subgroup = "grass",
    order = "z-z",
    selection_box = {{-0.0, -0.0}, {0.0, 0.0}},
    selectable_in_game = false,
    render_layer = "resource",
    pictures = {{
        filename = "__space-exploration-graphics__/graphics/blank.png",
        width = 1,
        height = 1
    }},
}

local collision_player = table.deepcopy(base_collision_entity)
collision_player.name = data_util.mod_prefix .. "collision-player"
collision_player.collision_mask = { "player-layer", "train-layer"}
collision_player.collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }

local collision_player_not_space = table.deepcopy(base_collision_entity)
collision_player_not_space.name = data_util.mod_prefix .. "collision-player-not-space"
collision_player_not_space.collision_mask = { "player-layer", "train-layer", space_collision_layer}
collision_player_not_space.collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }

local collision_rocket_destination_surface = table.deepcopy(base_collision_entity)
collision_rocket_destination_surface.name = data_util.mod_prefix .. "collision-rocket-destination-surface"
collision_rocket_destination_surface.collision_mask = { "player-layer", "train-layer", space_collision_layer}
collision_rocket_destination_surface.collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }

local collision_rocket_destination_orbital = table.deepcopy(base_collision_entity)
collision_rocket_destination_orbital.name = data_util.mod_prefix .. "collision-rocket-destination-orbital"
collision_rocket_destination_orbital.collision_mask = { "player-layer", "train-layer"}
collision_rocket_destination_orbital.collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }

data:extend({
  collision_player,
  collision_player_not_space,
  collision_rocket_destination_surface,
  collision_rocket_destination_orbital
})

-- settings entity
data:extend({
  { -- this is a tempalte
    type = "programmable-speaker",
    name = data_util.mod_prefix .. "struct-settings-string",
    icon = "__space-exploration-graphics__/graphics/icons/settings.png",
    icon_size = 32,
    order="zzz",
    flags = {"placeable-neutral", "player-creation"},
    collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    selection_box = {{-0.0, -0.0}, {0.0, 0.0}},
    drawing_box = {{-0.0, -0.0}, {0.0, 0.0}},
    selectable_in_game = false,
    energy_source = {
      --type = "electric",
      type = "void",
      usage_priority = "secondary-input",
      render_no_power_icon = false
    },
    energy_usage_per_tick = "1W",
    sprite =
    {
      layers =
      {
        {
            filename = "__space-exploration-graphics__/graphics/blank.png",
            width = 1,
            height = 1,
            frame_count = 1,
            line_length = 1,
            shift = { 0, 0 },
        }
      }
    },
    maximum_polyphony = 0,
    instruments = { },
  },
})
--[[
energy_source = {
  buffer_capacity = "5MJ",
  input_flow_limit = "300kW",
  output_flow_limit = "300kW",
  type = "electric",
  usage_priority = "tertiary"
},]]--

data.raw.accumulator.accumulator.fast_replaceable_group = "accumulator"
local accumulator = table.deepcopy(data.raw.accumulator.accumulator)
accumulator.name = data_util.mod_prefix .. "space-accumulator"
accumulator.collision_box = {{-0.8,-0.8},{0.8,0.8}}
accumulator.collision_mask = { "floor-layer", "object-layer", "water-tile", "ground-tile", "player-layer"}
data_util.replace_filenames_recursive(accumulator, "__base__/graphics/entity/accumulator/accumulator.png", "__space-exploration-graphics__/graphics/entity/accumulator/accumulator.png")
data_util.replace_filenames_recursive(accumulator, "__base__/graphics/entity/accumulator/hr-accumulator.png", "__space-exploration-graphics__/graphics/entity/accumulator/hr-accumulator.png")
accumulator.icon = "__space-exploration-graphics__/graphics/icons/accumulator.png"
accumulator.icon_size = 64
accumulator.energy_source = {
  buffer_capacity = "25MJ",
  input_flow_limit = "2500kW",
  output_flow_limit = "2500kW",
  type = "electric",
  usage_priority = "tertiary"
}
accumulator.minable.result = data_util.mod_prefix .. "space-accumulator"
accumulator.fast_replaceable_group = "space-accumulator"
accumulator.next_upgrade = data_util.mod_prefix .. "space-accumulator-2"


local accumulator2 = table.deepcopy(accumulator)
accumulator2.name = data_util.mod_prefix .. "space-accumulator-2"
data_util.replace_filenames_recursive(accumulator2, "__space-exploration-graphics__/graphics/entity/accumulator/accumulator.png", "__space-exploration-graphics__/graphics/entity/accumulator/accumulator-2.png")
data_util.replace_filenames_recursive(accumulator2, "__space-exploration-graphics__/graphics/entity/accumulator/hr-accumulator.png", "__space-exploration-graphics__/graphics/entity/accumulator/hr-accumulator-2.png")
accumulator2.icon = "__space-exploration-graphics__/graphics/icons/accumulator-2.png"
accumulator2.icon_size = 64
accumulator2.energy_source = {
  buffer_capacity = "100MJ",
  input_flow_limit = "10000kW",
  output_flow_limit = "10000kW",
  type = "electric",
  usage_priority = "tertiary"
}
accumulator2.minable.result = data_util.mod_prefix .. "space-accumulator-2"
accumulator2.next_upgrade = nil

data:extend{
  accumulator,
  accumulator2,
  {
    type = "solar-panel",
    name = data_util.mod_prefix .. "space-solar-panel",
    collision_box = {
      { -1.95, -1.95 },
      { 1.95, 1.95 }
    },
    collision_mask = {
      "floor-layer",
      "object-layer",
      "water-tile",
      --"ground-tile"
    },
    selection_box = {
      { -2, -2 },
      { 2, 2 }
    },
    production = "400kW", -- 106.6 would be equivalent to a solar panel for its size.
    corpse = "big-remnants",
    energy_source = {
      type = "electric",
      usage_priority = "solar"
    },
    flags = {
      "placeable-neutral",
      "player-creation"
    },
    fast_replaceable_group = "space-solar-panel",
    icon = "__space-exploration-graphics__/graphics/icons/solar-panel.png",
    icon_size = 64,
    max_health = 400,
    minable = {
      mining_time = 0.1,
      result =  data_util.mod_prefix .. "space-solar-panel"
    },
    next_upgrade = data_util.mod_prefix .. "space-solar-panel-2",
    picture = {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/solar-panel/solar-panel.png",
          width = 260/2,
          height = 272/2,
          priority = "high",
          shift = {
            0,
            -1/32
          },
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/solar-panel/hr-solar-panel.png",
            width = 260,
            height = 272,
            priority = "high",
            scale = 0.5,
            shift = {
              0,
              -1/32
            },
          }),
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/solar-panel/solar-panel-shadow.png",
          width = 92/2,
          height = 260/2,
          priority = "high",
          shift = {
            1.5,
            1/32
          },
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/solar-panel/hr-solar-panel-shadow.png",
            width = 92,
            height = 260,
            priority = "high",
            scale = 0.5,
            shift = {
              1.5,
              1/32
            },
          }),
        }
      }
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    }
  },
  {
    type = "solar-panel",
    name = data_util.mod_prefix .. "space-solar-panel-2",
    collision_box = {
      { -1.95, -1.95 },
      { 1.95, 1.95 }
    },
    collision_mask = {
      "floor-layer",
      "object-layer",
      "water-tile",
      --"ground-tile"
    },
    selection_box = {
      { -2, -2 },
      { 2, 2 }
    },
    production = "800kW", -- 106.6 would be equivalent to a solar panel for its size.
    corpse = "big-remnants",
    energy_source = {
      type = "electric",
      usage_priority = "solar"
    },
    flags = {
      "placeable-neutral",
      "player-creation"
    },
    fast_replaceable_group = "space-solar-panel",
    icon = "__space-exploration-graphics__/graphics/icons/solar-panel-2.png",
    icon_size = 64,
    max_health = 500,
    minable = {
      mining_time = 0.1,
      result =  data_util.mod_prefix .. "space-solar-panel-2"
    },
    next_upgrade = data_util.mod_prefix .. "space-solar-panel-3",
    picture = {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/solar-panel-2/solar-panel.png",
          width = 260/2,
          height = 272/2,
          priority = "high",
          shift = {
            0,
            -1/32
          },
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/solar-panel-2/hr-solar-panel.png",
            width = 260,
            height = 272,
            priority = "high",
            scale = 0.5,
            shift = {
              0,
              -1/32
            },
          }),
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/solar-panel-2/solar-panel-shadow.png",
          width = 92/2,
          height = 260/2,
          priority = "high",
          shift = {
            1.5,
            1/32
          },
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/solar-panel-2/hr-solar-panel-shadow.png",
            width = 92,
            height = 260,
            priority = "high",
            scale = 0.5,
            shift = {
              1.5,
              1/32
            },
          }),
        }
      }
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    }
  },
  {
    type = "solar-panel",
    name = data_util.mod_prefix .. "space-solar-panel-3",
    collision_box = {
      { -1.95, -1.95 },
      { 1.95, 1.95 }
    },
    collision_mask = {
      "floor-layer",
      "object-layer",
      "water-tile", 
      --"ground-tile"
    },
    selection_box = {
      { -2, -2 },
      { 2, 2 }
    },
    production = "1600kW", -- 106.6 would be equivalent to a solar panel for its size.
    corpse = "big-remnants",
    energy_source = {
      type = "electric",
      usage_priority = "solar"
    },
    flags = {
      "placeable-neutral",
      "player-creation"
    },
    fast_replaceable_group = "space-solar-panel",
    icon = "__space-exploration-graphics__/graphics/icons/solar-panel-3.png",
    icon_size = 64,
    max_health = 500,
    minable = {
      mining_time = 0.1,
      result =  data_util.mod_prefix .. "space-solar-panel-3"
    },
    picture = {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/solar-panel-3/solar-panel.png",
          width = 260/2,
          height = 272/2,
          priority = "high",
          shift = {
            0,
            -1/32
          },
          hr_version = data_util.hr({
            filename = "__space-exploration-hr-graphics__/graphics/entity/solar-panel-3/hr-solar-panel.png",
            width = 260,
            height = 272,
            priority = "high",
            scale = 0.5,
            shift = {
              0,
              -1/32
            },
          }),
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/solar-panel-3/solar-panel-shadow.png",
          width = 92/2,
          height = 260/2,
          priority = "high",
          shift = {
            1.5,
            1/32
          },
          hr_version = data_util.hr({
            draw_as_shadow = true,
            filename = "__space-exploration-hr-graphics__/graphics/entity/solar-panel-3/hr-solar-panel-shadow.png",
            width = 92,
            height = 260,
            priority = "high",
            scale = 0.5,
            shift = {
              1.5,
              1/32
            },
          }),
        }
      }
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    }
  }
}
