data:extend({
  {
    type = "energy-shield-equipment",
    name = "energy-shield-mk3-equipment",
    sprite =
    {
      filename = "__advanced-equipment__/graphics/equipment/energy-shield-mk3-equipment.png",
      width = 64,
      height = 64,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 2,
      type = "full"
    },
    max_shield_value = 450,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "240kJ",
      input_flow_limit = "480kW",
      usage_priority = "primary-input"
    },
    energy_per_shield = "40kJ",
    categories = {"armor"}
  },
  {
    type = "battery-equipment",
    name = "battery-mk3-equipment",
    sprite =
    {
      filename = "__advanced-equipment__/graphics/equipment/battery-mk3-equipment.png",
      width = 32,
      height = 64,
      priority = "medium"
    },
    shape =
    {
      width = 1,
      height = 2,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "500MJ",
      usage_priority = "tertiary"
    },
    categories = {"armor"}
  },
  {
    type = "generator-equipment",
    name = "fusion-reactor-mk2-equipment",
    sprite =
    {
      filename = "__advanced-equipment__/graphics/equipment/fusion-reactor-mk2-equipment.png",
      width = 128,
      height = 128,
      priority = "medium"
    },
    shape =
    {
      width = 4,
      height = 4,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "primary-output"
    },
    power = "3000kW",
    categories = {"armor"}
  },
  {
    type = "movement-bonus-equipment",
    name = "exoskeleton-mk2-equipment",
    sprite =
    {
      filename = "__advanced-equipment__/graphics/equipment/exoskeleton-mk2-equipment.png",
      width = 64,
      height = 128,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 4,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_consumption = "500kW",
    movement_bonus = 0.5,
    categories = {"armor"}
  }
})