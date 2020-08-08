local data_util = require("data_util")

data.raw.item["fusion-reactor-equipment"].order = "a[energy-source]-b[fusion-reactor]-c",

data:extend{
  {
    type = "item",
    name = data_util.mod_prefix .. "rtg-equipment",
    icon = "__space-exploration-graphics__/graphics/icons/rtg-equipment.png",
    icon_size = 64,
    order = "a[energy-source]-b[fusion-reactor]-a",
    placed_as_equipment_result = data_util.mod_prefix .. "rtg-equipment",
    stack_size = 20,
    subgroup = "equipment",
  },
  {
    type = "generator-equipment",
    name = data_util.mod_prefix .. "rtg-equipment",
    categories = { "armor" },
    energy_source = { type = "electric", usage_priority = "primary-output" },
    power = "300kW",
    shape = { type = "full", height = 4, width = 4 },
    sprite = {
      filename = "__space-exploration-graphics__/graphics/equipment/rtg-equipment.png",
      height = 128,
      priority = "medium",
      width = 128
    },
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "rtg-equipment-2",
    icon = "__space-exploration-graphics__/graphics/icons/rtg-equipment-2.png",
    icon_size = 64,
    order = "a[energy-source]-b[fusion-reactor]-b",
    placed_as_equipment_result = data_util.mod_prefix .. "rtg-equipment-2",
    stack_size = 20,
    subgroup = "equipment",
  },
  {
    type = "generator-equipment",
    name = data_util.mod_prefix .. "rtg-equipment-2",
    categories = { "armor" },
    energy_source = { type = "electric", usage_priority = "primary-output" },
    power = "500kW",
    shape = { type = "full", height = 4, width = 4 },
    sprite = {
      filename = "__space-exploration-graphics__/graphics/equipment/rtg-equipment-2.png",
      height = 128,
      priority = "medium",
      width = 128
    },
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-1",
    icon = "__space-exploration-graphics__/graphics/icons/adaptive-armour-1.png",
    icon_size = 64,
    placed_as_equipment_result = data_util.mod_prefix .. "adaptive-armour-equipment-1",
    subgroup = "equipment",
    order = "ca[shield]-a[adaptive-armour-1]",
    stack_size = 20
  },
  {
    type = "energy-shield-equipment",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-1",
    sprite = {
      filename = "__space-exploration-graphics__/graphics/equipment/adaptive-armour-1.png",
      width = 64,
      height = 64,
      priority = "medium"
    },
    shape = {
      width = 2,
      height = 2,
      type = "full"
    },
    max_shield_value = 25,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "10kJ",
      input_flow_limit = "25kW",
      usage_priority = "primary-input",
    },
    energy_per_shield = "20kJ",
    categories = {"armor"}
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-2",
    icon = "__space-exploration-graphics__/graphics/icons/adaptive-armour-2.png",
    icon_size = 64,
    placed_as_equipment_result = data_util.mod_prefix .. "adaptive-armour-equipment-2",
    subgroup = "equipment",
    order = "ca[shield]-b[adaptive-armour-2]",
    stack_size = 20
  },
  {
    type = "energy-shield-equipment",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-2",
    sprite = {
      filename = "__space-exploration-graphics__/graphics/equipment/adaptive-armour-2.png",
      width = 64,
      height = 64,
      priority = "medium"
    },
    shape = {
      width = 2,
      height = 2,
      type = "full"
    },
    max_shield_value = 50,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "10kJ",
      input_flow_limit = "50kW",
      usage_priority = "primary-input",
    },
    energy_per_shield = "20kJ",
    categories = {"armor"}
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-3",
    icon = "__space-exploration-graphics__/graphics/icons/adaptive-armour-3.png",
    icon_size = 64,
    placed_as_equipment_result = data_util.mod_prefix .. "adaptive-armour-equipment-3",
    subgroup = "equipment",
    order = "ca[shield]-c[adaptive-armour-3]",
    stack_size = 20
  },
  {
    type = "energy-shield-equipment",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-3",
    sprite = {
      filename = "__space-exploration-graphics__/graphics/equipment/adaptive-armour-3.png",
      width = 64,
      height = 64,
      priority = "medium"
    },
    shape = {
      width = 2,
      height = 2,
      type = "full"
    },
    max_shield_value = 100,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "10kJ",
      input_flow_limit = "100kW",
      usage_priority = "primary-input",
    },
    energy_per_shield = "20kJ",
    categories = {"armor"}
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-4",
    icon = "__space-exploration-graphics__/graphics/icons/adaptive-armour-4.png",
    icon_size = 64,
    placed_as_equipment_result = data_util.mod_prefix .. "adaptive-armour-equipment-4",
    subgroup = "equipment",
    order = "ca[shield]-d[adaptive-armour-4]",
    stack_size = 20
  },
  {
    type = "energy-shield-equipment",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-4",
    sprite = {
      filename = "__space-exploration-graphics__/graphics/equipment/adaptive-armour-4.png",
      width = 64,
      height = 64,
      priority = "medium"
    },
    shape = {
      width = 2,
      height = 2,
      type = "full"
    },
    max_shield_value = 200,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "10kJ",
      input_flow_limit = "200kW",
      usage_priority = "primary-input",
    },
    energy_per_shield = "20kJ",
    categories = {"armor"}
  },
  {
    type = "item",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-5",
    icon = "__space-exploration-graphics__/graphics/icons/adaptive-armour-5.png",
    icon_size = 64,
    placed_as_equipment_result = data_util.mod_prefix .. "adaptive-armour-equipment-5",
    subgroup = "equipment",
    order = "ca[shield]-e[adaptive-armour-5]",
    stack_size = 20
  },
  {
    type = "energy-shield-equipment",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-5",
    sprite = {
      filename = "__space-exploration-graphics__/graphics/equipment/adaptive-armour-5.png",
      width = 64,
      height = 64,
      priority = "medium"
    },
    shape = {
      width = 2,
      height = 2,
      type = "full"
    },
    max_shield_value = 500,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "10kJ",
      input_flow_limit = "500kW",
      usage_priority = "primary-input",
    },
    energy_per_shield = "20kJ",
    categories = {"armor"}
  },
  {
    type = "item",
    name = "energy-shield-mk3-equipment",
    icon = "__space-exploration-graphics__/graphics/icons/energy-shield-green.png",
    icon_size = 64,
    placed_as_equipment_result = "energy-shield-mk3-equipment",
    subgroup = "equipment",
    order = "b[shield]-c[energy-shield]",
    stack_size = 20
  },
  {
    type = "energy-shield-equipment",
    name = "energy-shield-mk3-equipment",
    sprite =
    {
      filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-green.png",
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
    max_shield_value = 500,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "180kJ",
      input_flow_limit = "5MW",
      usage_priority = "primary-input"
    },
    energy_per_shield = "30kJ",
    categories = {"armor"}
  },
  {
    type = "item",
    name = "energy-shield-mk4-equipment",
    icon = "__space-exploration-graphics__/graphics/icons/energy-shield-cyan.png",
    icon_size = 64,
    placed_as_equipment_result = "energy-shield-mk4-equipment",
    subgroup = "equipment",
    order = "b[shield]-d[energy-shield]",
    stack_size = 20
  },
  {
    type = "energy-shield-equipment",
    name = "energy-shield-mk4-equipment",
    sprite =
    {
      filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-cyan.png",
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
    max_shield_value = 1000,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "180kJ",
      input_flow_limit = "10MW",
      usage_priority = "primary-input"
    },
    energy_per_shield = "30kJ",
    categories = {"armor"}
  },
  {
    type = "item",
    name = "energy-shield-mk5-equipment",
    icon = "__space-exploration-graphics__/graphics/icons/energy-shield-blue.png",
    icon_size = 64,
    placed_as_equipment_result = "energy-shield-mk5-equipment",
    subgroup = "equipment",
    order = "b[shield]-e[energy-shield]",
    stack_size = 20
  },
  {
    type = "energy-shield-equipment",
    name = "energy-shield-mk5-equipment",
    sprite =
    {
      filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-blue.png",
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
    max_shield_value = 2000,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "180kJ",
      input_flow_limit = "20MW",
      usage_priority = "primary-input"
    },
    energy_per_shield = "30kJ",
    categories = {"armor"}
  },
  {
    type = "item",
    name = "energy-shield-mk6-equipment",
    icon = "__space-exploration-graphics__/graphics/icons/energy-shield-magenta.png",
    icon_size = 64,
    placed_as_equipment_result = "energy-shield-mk6-equipment",
    subgroup = "equipment",
    order = "b[shield]-f[energy-shield]",
    stack_size = 20
  },
  {
    type = "energy-shield-equipment",
    name = "energy-shield-mk6-equipment",
    sprite =
    {
      filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-magenta.png",
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
    max_shield_value = 4000,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "180kJ",
      input_flow_limit = "40MW",
      usage_priority = "primary-input"
    },
    energy_per_shield = "30kJ",
    categories = {"armor"}
  },
}
