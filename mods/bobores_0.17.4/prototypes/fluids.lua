bobmods.ores.water =
{
  name = "ground-water",
  icon = "__base__/graphics/icons/fluid/water.png",
  category = "water",
  infinite = true,
  minimum = 1000,
  normal = 1000,
  resource_patch_search_radius = 12,
  mining_time = 0.1,
  tint = {r = 0.2, g = 0.8, b = 1},
  map_color = {r = 0.2, g = 0.8, b = 1},
  collision_box = {{ -1.4, -1.4}, {1.4, 1.4}},
  particle = nil,
  items = 
  {
    {
      type = "fluid",
      name = "water",
      amount_min = 10,
      amount_max = 10,
      probability = 1
    }
  },
  sprite =
  {
    sheet = 5
  },
  disable_map_grid = true,
  enabled = false,
--[[
  autoplace =
  {
    control = "ground-water",
    sharpness = 1,
    max_probability = 0.02,
    richness_base = 240000,
    richness_multiplier = 300000,
    richness_multiplier_distance_bonus = 1500,
    coverage = 0.002, -- Cover on average 0.2% of surface area.
    peaks =
    {
      {
        noise_layer = "ground-water",
        noise_octaves_difference = -0.5,
        noise_persistence = 0.4,
      }
    }
  }
  autoplace = resource_autoplace.resource_autoplace_settings{
    name = "ground-water",
    order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
    base_density = 8.2,
    base_spots_per_km2 = 1.8,
    random_probability = 1/48,
    random_spot_size_minimum = 1,
    random_spot_size_maximum = 1, -- don't randomize spot size
    additional_richness = 220000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
    has_starting_area_placement = false,
    resource_index = resource_autoplace.get_next_resource_index(),
    regular_rq_factor_multiplier = 1
  },
]]--
  autoplace = false,
}

function bobmods.ores.water.create_autoplace()

resource_generator.setup_resource_autoplace_data("ground-water", {
    name = "ground-water",
    order = "c",
    base_density = 8.2,
    base_spots_per_km2 = 1.8,
    random_probability = 1/48,
    random_spot_size_minimum = 1,
    random_spot_size_maximum = 1,
    additional_richness = 220000,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 1
  }
)
bobmods.lib.resource.generate_autoplace_control("ground-water")
end


bobmods.ores.lithia_water =
{
  name = "lithia-water",
  icon = "__bobores__/graphics/icons/lithia-water.png",
  category = "water",
  infinite = true,
  minimum = 1000,
  normal = 1000,
  resource_patch_search_radius = 12,
  mining_time = 0.1,
  tint = {r = 0.5, g = 0.7, b = 0.8},
  map_color = {r = 0.5, g = 0.7, b = 0.8},
  collision_box = {{ -1.4, -1.4}, {1.4, 1.4}},
  particle = nil,
  items = 
  {
    {
      type = "fluid",
      name = "lithia-water",
      amount_min = 10,
      amount_max = 10,
      probability = 1
    }
  },
  sprite =
  {
    sheet = 5
  },
  disable_map_grid = true,
  enabled = false,
--[[
  autoplace =
  {
    control = "ground-water",
    sharpness = 1,
    max_probability = 0.02,
    richness_base = 240000,
    richness_multiplier = 300000,
    richness_multiplier_distance_bonus = 1500,
    coverage = 0.002, -- Cover on average 0.2% of surface area.
    peaks =
    {
      {
        noise_layer = "lithia-water",
        noise_octaves_difference = -0.5,
        noise_persistence = 0.4,
      }
    }
  }
  autoplace = resource_autoplace.resource_autoplace_settings{
    name = "ground-water",
    order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
    base_density = 8.2,
    base_spots_per_km2 = 1.8,
    random_probability = 1/48,
    random_spot_size_minimum = 1,
    random_spot_size_maximum = 1, -- don't randomize spot size
    additional_richness = 220000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
    has_starting_area_placement = false,
    resource_index = resource_autoplace.get_next_resource_index(),
    regular_rq_factor_multiplier = 1
  },
]]--
  autoplace = false,
}

function bobmods.ores.lithia_water.create_autoplace()

resource_generator.setup_resource_autoplace_data("lithia-water", {
    name = "ground-water",
    order = "c",
    base_density = 8.2,
    base_spots_per_km2 = 1.8,
    random_probability = 1/48,
    random_spot_size_minimum = 1,
    random_spot_size_maximum = 1,
    additional_richness = 220000,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 1
  }
)
bobmods.lib.resource.generate_autoplace_control("ground-water")
end

data:extend(
{
  {
    type = "fluid",
    name = "lithia-water",
    default_temperature = 15,
    max_temperature = 100,
    heat_capacity = "0.2KJ",
    base_color = {r=0, g=0.34, b=0.6},
    flow_color = {r=0.7, g=1.0, b=1.0},
    icon = "__bobores__/graphics/icons/lithia-water.png",
    icon_size = 32,
    order = "a[fluid]-a[water-lithia]",
  },
}
)
