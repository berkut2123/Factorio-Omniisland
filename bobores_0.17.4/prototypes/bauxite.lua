bobmods.ores.bauxite =
{
  name = "bauxite-ore",
  tint = {r=0.777, g=0.7, b=0.333},
  map_color = {r=0.777, g=0.7, b=0.333},
  mining_time = 1.5,
  enabled = false,
  icon = "__bobores__/graphics/icons/bauxite-ore.png",
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
--[[  autoplace = 
  {
    create = true,
    starting_area = false,
    richness = 0.8,
    size = 1.5
  }
  autoplace = resource_autoplace.resource_autoplace_settings{
    name = "bauxite-ore",
    order = "c",
    base_density = 8,
    has_starting_area_placement = false,
    resource_index = resource_autoplace.get_next_resource_index(),
    regular_rq_factor_multiplier = 1,
  },
]]--
  autoplace = false,
}

function bobmods.ores.bauxite.create_autoplace()

resource_generator.setup_resource_autoplace_data("bauxite-ore", {
    name = "bauxite-ore",
    order = "c",
    base_density = 8,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 1,
  }
)
bobmods.lib.resource.generate_autoplace_control("bauxite-ore")
end
