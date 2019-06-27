data:extend({
  {
    type = "recipe-category",
    name = "deep-mine"
  },
  {
    type = "assembling-machine",
    name = "deep-mine",
    fast_replaceable_group = "deep-mine",
    icon = "__DeepMine__/graphics/icons/deep-mine.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.8, mining_time = 1.2, result = "deep-mine"},
    max_health = 500,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-1.25, -1.25}, {1.25, 1.25}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    animation =
    {
      filename = "__DeepMine__/graphics/entity/deep-mine.png",
      priority = "high",
      width = 156,
      height = 127,
      frame_count = 1,
      line_length = 1,
      shift = {0.95, 0.2}
    },
    crafting_categories = {"deep-mine"},
    crafting_speed = 1.25 * settings.startup["deep-mine-crafting-speed"].value,
    module_specification =
    {
      module_slots = 3
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_second_per_watt = 12 / 180000,
    },
    energy_usage = "180kW",
    ingredient_count = 1,
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t1-2.ogg",
          volume = 0.8
        },
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    }
  },
  {
    type = "assembling-machine",
    name = "deep-mine-2",
    fast_replaceable_group = "deep-mine",
    icon = "__DeepMine__/graphics/icons/deep-mine-2.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.8, mining_time = 1.2, result = "deep-mine-2"},
    max_health = 500,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-1.25, -1.25}, {1.25, 1.25}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    animation =
    {
      filename = "__DeepMine__/graphics/entity/deep-mine-2.png",
      priority = "high",
      width = 156,
      height = 127,
      frame_count = 1,
      line_length = 1,
      shift = {0.95, 0.2}
    },
    crafting_categories = {"deep-mine"},
    crafting_speed = 2.5 * settings.startup["deep-mine-crafting-speed"].value,
    module_specification =
    {
      module_slots = 4
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_second_per_watt = 10 /250000,
    },
    energy_usage = "250kW",
    ingredient_count = 1,
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t2-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t2-2.ogg",
          volume = 0.8
        },
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    }
  },

  -- hidden beacon simulating mining bonus
  {
    type = "beacon",
    name = "deep-mine-beacon",
    energy_usage = "10W",
    -- 0.17 supports "no-automated-item-removal", "no-automated-item-insertion"
    flags = { "hide-alt-info", "not-blueprintable", "not-deconstructable", "placeable-off-grid", "not-on-map", "no-automated-item-removal", "no-automated-item-insertion" },
    collision_mask = { "resource-layer" }, -- disable collision
    animation = {
      filename =  "__core__/graphics/empty.png",
      width = 1,
      height = 1,
      line_length = 1,
      frame_count = 1,
    },
    animation_shadow = {
        filename = "__core__/graphics/empty.png",
        width = 1,
        height = 1,
        line_length = 1,
        frame_count = 1,
    },
    -- 0.17 supports 0W entities
    energy_source = {type="void"},
    base_picture =
    {
      filename = "__core__/graphics/empty.png",
      width = 1,
      height = 1,
    },
    supply_area_distance = 0,
    radius_visualisation_picture =
    {
      filename = "__core__/graphics/empty.png",
      width = 1,
      height = 1
    },
    distribution_effectivity = 1,
    module_specification =
    {
      module_slots = 65535,
    },
    allowed_effects = { "productivity" },
    selection_box = {{0, 0}, {0, 0}},
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}}, -- reduce size preventing inserters from picking modules, will not power unless center is covered
  },
})
