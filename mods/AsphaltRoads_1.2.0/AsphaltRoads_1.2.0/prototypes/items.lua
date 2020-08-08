local config = require "config"

data:extend(
{
    {
        type = "item",
        name = "Arci-asphalt",
        icon = "__AsphaltRoads__/graphics/icons/hr/asphalt.png",
        icon_size = 64,
        flags = {},
        subgroup = "Arci-asphalt-1",
        order = "a",
        stack_size = config.asphalt_stack_size,
        place_as_tile =
        {
            result = "Arci-asphalt",
            condition_size = 1,
            condition = { "water-tile" }
        }
    }
}
)  
	
	
	


