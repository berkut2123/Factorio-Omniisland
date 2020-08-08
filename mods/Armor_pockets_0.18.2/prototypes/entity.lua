data:extend({
    {
      type = "battery-equipment",
      name = "armor-pocket-equipment",
      sprite =
        {
          filename = "__Armor_pockets__/graphics/icons/armor-pocket-64.png",
          width = 64,
          height = 64,
          priority = "medium"
        },
        shape =
        {
          width = 1,
          height = 1,
          type = "full"
        },
      energy_source =
        {
          type = "electric",
          buffer_capacity = nil,
          input_flow_limit = nil,
          usage_priority = "primary-input"
        },
      energy_input = nil,
      tint = {r = 0, g = 0.1, b = 0, a = 0.2},
      categories = {"armor"}
    }
})