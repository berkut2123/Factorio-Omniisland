bobmods.ores.tin =
{
  name = "tin-ore",
  tint = {r = 0.95, g = 0.95, b = 0.95},
  map_color = {r = 0.600, g = 0.600, b = 0.600},
  mining_time = 0.8,
  enabled = false,
  icon = "__bobores__/graphics/icons/tin-ore.png",
  stage_mult = 100,
  item =
  {
    create = true,
    create_variations = true,
    subgroup = "bob-ores",
  },
  sprite =
  {
    sheet = 1
  },
--[[
  autoplace = 
  {
    create = true,
    starting_area = true,
    richness = 1.2,
    size = 1.5
  }
  autoplace = resource_autoplace.resource_autoplace_settings{
    name = "tin-ore",
    order = "c",
    base_density = 8,
    has_starting_area_placement = true,
    resource_index = resource_autoplace.get_next_resource_index(),
    regular_rq_factor_multiplier = 1.1,
    starting_rq_factor_multiplier = 1.2
  },
]]--
  autoplace = false,
}


function bobmods.ores.tin.create_autoplace()

resource_generator.setup_resource_autoplace_data("tin-ore", {
    name = "tin-ore",
    order = "c",
    base_density = 8,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.1,
    starting_rq_factor_multiplier = 1.2
  }
)
bobmods.lib.resource.generate_autoplace_control("tin-ore")
end
