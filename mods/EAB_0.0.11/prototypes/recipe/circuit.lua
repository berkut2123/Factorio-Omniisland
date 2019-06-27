data:extend(
  {
    {
      type = "recipe",
      name = "platin-trace-circuit-board",
      category = "electronics-machine",
      enabled = false,
      ingredients = {
        {"fibreglass-board", 4},
        {"angels-plate-platinum", 10},
        {"gold-plate", 4},
        {type = "fluid", name = "ferric-chloride-solution", amount = 40}
      },
      result = "platin-trace-circuit-board"
    },
    {
      type = "recipe",
      name = "platin-processing-unit",      
      normal = {
        enabled = false,
        energy_required = 10,
        ingredients = {
          {"platin-trace-circuit-board", 4},
          {"angels-plate-platinum", 10},
          {"basic-electronic-components", 4},
          {"electronic-components", 8},
          {"intergrated-electronics", 4},
          {"processing-electronics", 4}
        },
        result = "platin-processing-unit"
      },
      expensive = {
        enabled = false,
        energy_required = 16,
        ingredients = {
          {"platin-trace-circuit-board", 6},
          {"angels-plate-platinum", 14},
          {"basic-electronic-components", 6},
          {"electronic-components", 12},
          {"intergrated-electronics", 8},
          {"processing-electronics", 6}
        },
        result = "platin-processing-unit"
      }
    }
  }
)
