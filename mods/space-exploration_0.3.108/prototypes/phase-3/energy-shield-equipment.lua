local data_util = require("data_util")

data_util.tech_add_prerequisites("energy-shield-equipment", {
  data_util.mod_prefix .. "energy-science-pack-1"
})
data_util.tech_add_ingredients("energy-shield-equipment", {
  "automation-science-pack", "logistic-science-pack", "chemical-science-pack", data_util.mod_prefix .. "rocket-science-pack", data_util.mod_prefix .. "energy-science-pack-1"}, true)
data.raw.technology["energy-shield-equipment"].icon = "__space-exploration-graphics__/graphics/technology/energy-shield-red.png"
data.raw.item["energy-shield-equipment"].icon = "__space-exploration-graphics__/graphics/icons/energy-shield-red.png"
data.raw.item["energy-shield-equipment"].icon_size = 64
data.raw["energy-shield-equipment"]["energy-shield-equipment"].max_shield_value = 100
data.raw["energy-shield-equipment"]["energy-shield-equipment"].energy_source.input_flow_limit = "1MW"
data.raw["energy-shield-equipment"]["energy-shield-equipment"].sprite.filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-red.png"
data_util.replace_or_add_ingredient("energy-shield-equipment", nil, data_util.mod_prefix .. 'holmium-cable', 20)
data_util.replace_or_add_ingredient("energy-shield-equipment", nil, data_util.mod_prefix .. 'electromagnetic-field-data', 5)

data_util.tech_add_prerequisites("energy-shield-mk2-equipment", {
  data_util.mod_prefix .. "space-catalogue-energy-2",
  data_util.mod_prefix .. "material-science-pack-1",
  data_util.mod_prefix .. "holmium-solenoid"
})
data.raw.technology["energy-shield-mk2-equipment"].icon = "__space-exploration-graphics__/graphics/technology/energy-shield-yellow.png"
data.raw.item["energy-shield-mk2-equipment"].icon = "__space-exploration-graphics__/graphics/icons/energy-shield-yellow.png"
data.raw.item["energy-shield-mk2-equipment"].icon_size = 64
data.raw["energy-shield-equipment"]["energy-shield-mk2-equipment"].max_shield_value = 250
data.raw["energy-shield-equipment"]["energy-shield-mk2-equipment"].energy_source.input_flow_limit = "3MW"
data.raw["energy-shield-equipment"]["energy-shield-mk2-equipment"].sprite.filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-yellow.png"
data_util.replace_or_add_ingredient("energy-shield-mk2-equipment", "energy-shield-equipment", "energy-shield-equipment", 5)
data_util.replace_or_add_ingredient("energy-shield-mk2-equipment", nil, data_util.mod_prefix .. 'forcefield-data', 5)
data_util.replace_or_add_ingredient("energy-shield-mk2-equipment", nil, data_util.mod_prefix .. 'iridium-plate', 10)
data_util.replace_or_add_ingredient("energy-shield-mk2-equipment", nil, data_util.mod_prefix .. 'holmium-solenoid', 20)

data_util.tech_add_prerequisites("energy-shield-mk3-equipment", {
  data_util.mod_prefix .. "space-catalogue-energy-3",
  data_util.mod_prefix .. 'quantum-processor'
})
data.raw.technology["energy-shield-mk3-equipment"].icon = "__space-exploration-graphics__/graphics/technology/energy-shield-green.png"
data.raw.item["energy-shield-mk3-equipment"].icon = "__space-exploration-graphics__/graphics/icons/energy-shield-green.png"
data.raw.item["energy-shield-mk3-equipment"].icon_size = 64
data.raw["energy-shield-equipment"]["energy-shield-mk3-equipment"].max_shield_value = 500
data.raw["energy-shield-equipment"]["energy-shield-mk3-equipment"].energy_source.input_flow_limit = "7MW"
data.raw["energy-shield-equipment"]["energy-shield-mk3-equipment"].sprite.filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-green.png"
data_util.replace_or_add_ingredient("energy-shield-mk3-equipment", nil, data_util.mod_prefix .. 'superconductivity-data', 10)
data_util.replace_or_add_ingredient("energy-shield-mk3-equipment", nil, data_util.mod_prefix .. 'quantum-processor', 10)

data_util.tech_add_prerequisites("energy-shield-mk4-equipment", {
  data_util.mod_prefix .. "superconductive-cable",
  data_util.mod_prefix .. 'heavy-composite'
})
data.raw.technology["energy-shield-mk4-equipment"].icon = "__space-exploration-graphics__/graphics/technology/energy-shield-cyan.png"
data.raw.item["energy-shield-mk4-equipment"].icon = "__space-exploration-graphics__/graphics/icons/energy-shield-cyan.png"
data.raw.item["energy-shield-mk4-equipment"].icon_size = 64
data.raw["energy-shield-equipment"]["energy-shield-mk4-equipment"].max_shield_value = 1000
data.raw["energy-shield-equipment"]["energy-shield-mk4-equipment"].energy_source.input_flow_limit = "15MW"
data.raw["energy-shield-equipment"]["energy-shield-mk4-equipment"].sprite.filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-cyan.png"
data_util.replace_or_add_ingredient("energy-shield-mk4-equipment", nil, data_util.mod_prefix .. 'superconductive-cable', 50)
data_util.replace_or_add_ingredient("energy-shield-mk4-equipment", nil, data_util.mod_prefix .. 'heavy-composite', 50)

data_util.tech_add_prerequisites("energy-shield-mk5-equipment", {
  data_util.mod_prefix .. "space-catalogue-energy-4",
  data_util.mod_prefix .. 'dynamic-emitter'
})
data_util.tech_add_prerequisites("energy-shield-mk5-equipment", { data_util.mod_prefix .. "space-catalogue-material-4"})
data.raw.technology["energy-shield-mk5-equipment"].icon = "__space-exploration-graphics__/graphics/technology/energy-shield-blue.png"
data.raw.item["energy-shield-mk5-equipment"].icon = "__space-exploration-graphics__/graphics/icons/energy-shield-blue.png"
data.raw.item["energy-shield-mk5-equipment"].icon_size = 64
data.raw["energy-shield-equipment"]["energy-shield-mk5-equipment"].max_shield_value = 2000
data.raw["energy-shield-equipment"]["energy-shield-mk5-equipment"].energy_source.input_flow_limit = "35MW"
data.raw["energy-shield-equipment"]["energy-shield-mk5-equipment"].sprite.filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-blue.png"
data_util.replace_or_add_ingredient("energy-shield-mk5-equipment", nil, data_util.mod_prefix .. 'nano-material', 50)
data_util.replace_or_add_ingredient("energy-shield-mk5-equipment", nil, data_util.mod_prefix .. 'magnetic-monopole-data', 50)
data_util.replace_or_add_ingredient("energy-shield-mk5-equipment", nil, data_util.mod_prefix .. 'dynamic-emitter', 50)

data_util.tech_add_prerequisites("energy-shield-mk6-equipment", {
  data_util.mod_prefix .. "antimatter-production",
  data_util.mod_prefix .. 'naquium-processor'
})
data.raw.technology["energy-shield-mk6-equipment"].icon = "__space-exploration-graphics__/graphics/technology/energy-shield-magenta.png"
data.raw.item["energy-shield-mk6-equipment"].icon = "__space-exploration-graphics__/graphics/icons/energy-shield-magenta.png"
data.raw.item["energy-shield-mk6-equipment"].icon_size = 64
data.raw["energy-shield-equipment"]["energy-shield-mk6-equipment"].max_shield_value = 4000
data.raw["energy-shield-equipment"]["energy-shield-mk6-equipment"].energy_source.input_flow_limit = "80MW"
data.raw["energy-shield-equipment"]["energy-shield-mk6-equipment"].sprite.filename = "__space-exploration-graphics__/graphics/equipment/energy-shield-magenta.png"
data_util.replace_or_add_ingredient("energy-shield-mk6-equipment", nil, data_util.mod_prefix .. 'antimatter-canister', 50)
data_util.replace_or_add_ingredient("energy-shield-mk6-equipment", nil, data_util.mod_prefix .. 'enriched-naquium', 50)
data_util.replace_or_add_ingredient("energy-shield-mk6-equipment", nil, data_util.mod_prefix .. 'naquium-processor', 50)

for _, proto in pairs(data.raw["energy-shield-equipment"]) do
  if not string.find(proto.name, "adaptive-armour", 1, true) then
    local max_shield = proto.max_shield_value
    proto.energy_per_shield = (20 + max_shield / 100) .. "kJ"
    local input_flow = data_util.string_to_number(proto.energy_source.input_flow_limit)
    local drain = (input_flow / 100)
    proto.energy_source.drain = drain.."W"
  end
end
--log( serpent.block( data.raw["energy-shield-equipment"], {comment = false, numformat = '%1.8g' } ) )
