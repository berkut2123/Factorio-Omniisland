local util = require('util')

local item = {
  type = "item-with-entity-data",
  name = "accumulator-wagon",
  icon = "__accumulator-wagon__/graphics/icons/accumulator-wagon.png",
  icon_size = 32,
  flags = {},
  subgroup = "transport",
  order = "a[train-system]-gz[accumulator-wagon]",
  place_result = "accumulator-wagon",
  stack_size = 5,
}

local recipe = {
  type = "recipe",
  name = "accumulator-wagon",
  enabled = false,
  ingredients = 
  {
    { "cargo-wagon", 1 },
    { "accumulator", 10 },
    { "electronic-circuit", 5 },
  },
  result = "accumulator-wagon",
}

local technology = {
  type = "technology",
  name = "accumulator-wagon",
  icon_size = 128,
  icon = "__accumulator-wagon__/graphics/technology/accumulator-wagon.png",
  effects = {
    {
      type = "unlock-recipe",
      recipe = "accumulator-wagon"
    }
  },
  prerequisites = { "railway", "electric-energy-accumulators" },
  unit = {
    count = 250,
    ingredients =
    {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  order = "c-k-d-z",
}

local wagon = util.table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
wagon.name = "accumulator-wagon"
wagon.type = "fluid-wagon"
wagon.capacity = 25000
wagon.color = {r = 0.1, g = 0.60, b = 0.1, a = 0.75}
wagon.icon = "__accumulator-wagon__/graphics/icons/accumulator-wagon.png"
wagon.inventory_size = 0
wagon.horizontal_doors = nil
wagon.vertical_doors = nil
wagon.minable.result = "accumulator-wagon"

local passive_accumulator = util.table.deepcopy(data.raw["accumulator"]["accumulator"])
passive_accumulator.name = "accumulator-wagon-proxy-passive"
passive_accumulator.order = "z[accumulator-wagon-proxy-passive]"
passive_accumulator.collision_mask = {"ghost-layer"}
passive_accumulator.selectable_in_game = false
passive_accumulator.picture.layers[1].filename = "__accumulator-wagon__/graphics/entity/transparent.png"
passive_accumulator.picture.layers[1].hr_version = nil
passive_accumulator.picture.layers[2] = nil
passive_accumulator.charge_animation.layers[1].layers[1].filename = "__accumulator-wagon__/graphics/entity/transparent-charge.png"
passive_accumulator.charge_animation.layers[1].layers[1].hr_version = nil
passive_accumulator.charge_animation.layers[1].layers[2] = nil
passive_accumulator.charge_animation.layers[2] = nil
passive_accumulator.discharge_animation.layers[1].layers[1].filename = "__accumulator-wagon__/graphics/entity/transparent-charge.png"
passive_accumulator.discharge_animation.layers[1].layers[1].hr_version = nil
passive_accumulator.discharge_animation.layers[1].layers[2] = nil
passive_accumulator.discharge_animation.layers[2] = nil
passive_accumulator.energy_source.buffer_capacity = "500MJ"
-- / 25000 capacity = 20kJ per unit of battery fluid
passive_accumulator.energy_source.input_flow_limit = "30MW"
passive_accumulator.energy_source.output_flow_limit = "30MW"

local input_accumulator = util.table.deepcopy(passive_accumulator)
input_accumulator.name = "accumulator-wagon-proxy-input"
input_accumulator.type = "electric-energy-interface"
input_accumulator.order = "z[accumulator-wagon-proxy-input]"
input_accumulator.energy_source.usage_priority = "secondary-input"

local output_accumulator = util.table.deepcopy(passive_accumulator)
output_accumulator.name = "accumulator-wagon-proxy-output"
output_accumulator.type = "electric-energy-interface"
output_accumulator.order = "z[accumulator-wagon-proxy-output]"
output_accumulator.energy_source.usage_priority = "secondary-output"

local fluid = {
  type = "fluid",
  name = "battery-fluid",
  auto_barrel = false,
  default_temperature = 15,
  heat_capacity = "0.1KJ",
  base_color = {r=0.18, g=0.82, b=0.18},
  flow_color = {r=0.5, g=0.5, b=0.5},
  max_temperature = 100,
  icon = "__accumulator-wagon__/graphics/icons/battery-fluid.png",
  icon_size = 32,
  pressure_to_speed_ratio = 0.4,
  flow_to_energy_ratio = 0.59,
  order = "a[fluid]-z[battery-fluid]"
}

local signal_group = {
  type = "item-subgroup",
  name = "accumulator-wagon-signal",
  group = "signals",
  order = "z[accumulator-wagon-signal]"
}

local charge_signal = {
  type = "virtual-signal",
  name = "accumulator-wagon-charge",
  icon = "__accumulator-wagon__/graphics/icons/accumulator-wagon-charge.png",
  icon_size = 32,
  subgroup = "accumulator-wagon-signal",
  order = "a[special]-a[accumulator-wagon-charge]"
}

local discharge_signal = {
  type = "virtual-signal",
  name = "accumulator-wagon-discharge",
  icon = "__accumulator-wagon__/graphics/icons/accumulator-wagon-discharge.png",
  icon_size = 32,
  subgroup = "accumulator-wagon-signal",
  order = "a[special]-b[accumulator-wagon-discharge]"
}

data:extend({ item, recipe, technology, wagon, passive_accumulator, input_accumulator, output_accumulator, fluid, signal_group, charge_signal, discharge_signal })
