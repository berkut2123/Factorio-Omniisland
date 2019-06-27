bobmods.ores.nickel =
{
  name = "nickel-ore",
  tint = {r=0.54, g=0.8, b=0.75},
  map_color = {r=0.380, g=0.560, b=0.515},
  mining_time = 1.5,
  enabled = false,
  icon = "__bobores__/graphics/icons/nickel-ore.png",
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
    starting_area = false,
    richness = 0.8,
    size = 1.2
  }
  autoplace = resource_autoplace.resource_autoplace_settings{
    name = "nickel-ore",
    order = "c",
    base_density = 5,
    has_starting_area_placement = false,
    resource_index = resource_autoplace.get_next_resource_index(),
    regular_rq_factor_multiplier = 1.1,
  },
]]--
  autoplace = false,
}


function bobmods.ores.nickel.create_autoplace()

resource_generator.setup_resource_autoplace_data("nickel-ore", {
    name = "nickel-ore",
    order = "c",
    base_density = 5,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 1.1,
  }
)
bobmods.lib.resource.generate_autoplace_control("nickel-ore")
end
