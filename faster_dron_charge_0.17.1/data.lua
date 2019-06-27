data.raw.roboport.roboport.energy_source.input_flow_limit = "15MW"
data.raw.roboport.roboport.charging_energy = "3MW"
data.raw.roboport.roboport.robot_slots_count = 20
data.raw.roboport.roboport.material_slots_count = 10

data.raw["logistic-robot"]["logistic-robot"].max_energy = "3MJ"
data.raw["construction-robot"]["construction-robot"].max_energy = "3MJ"

data.raw["roboport-equipment"]["personal-roboport-equipment"].energy_source.input_flow_limit = "7MW"
data.raw["roboport-equipment"]["personal-roboport-equipment"].charging_energy = "3MW"

data.raw["roboport-equipment"]["personal-roboport-mk2-equipment"].energy_source.input_flow_limit = "12MW"
data.raw["roboport-equipment"]["personal-roboport-mk2-equipment"].charging_energy = "4.375MW"

if mods["5dim_logistic"]  then
	require("prototypes.5dim")
end
if mods["boblogistics"] then
	require("prototypes.bob")
end
if mods["bobvehicleequipment"] then
	require("prototypes.bobequipment")
end