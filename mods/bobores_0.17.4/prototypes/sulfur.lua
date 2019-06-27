bobmods.ores.sulfur =
{
  name = "sulfur",
  tint = {r = 0.8, g = 0.75, b = 0.1},
  map_color = {r=0.8, g=0.75, b=0.1},
  mining_time = 0.25,
  enabled = false,
  icon = "__base__/graphics/icons/sulfur.png",
  stage_mult = 100,
  items =
  {
    {
      name = "sulfur"
    }
  },
  sprite =
  {
    sheet = 4
  },
--[[
  autoplace = 
  {
    create = true,
    starting_area = false,
    richness = 1,
    size = 1
  }
  autoplace = resource_autoplace.resource_autoplace_settings{
    name = "sulfur",
    order = "c",
    base_density = 8,
    has_starting_area_placement = false,
    resource_index = resource_autoplace.get_next_resource_index(),
    regular_rq_factor_multiplier = 1,
  },
]]--
  autoplace = false,
}


function bobmods.ores.sulfur.create_autoplace()

resource_generator.setup_resource_autoplace_data("sulfur", {
    name = "sulfur",
    order = "c",
    base_density = 8,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 1,
  }
)
bobmods.lib.resource.generate_autoplace_control("sulfur")
end
