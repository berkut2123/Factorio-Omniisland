local mk1, mk2
mk1 = "3MW"
mk2 = "4.375MW"

data.raw["roboport-equipment"]["vehicle-roboport"].energy_source.input_flow_limit = "7MW"
data.raw["roboport-equipment"]["vehicle-roboport"].charging_energy = mk1

data.raw["roboport-equipment"]["vehicle-roboport-2"].energy_source.input_flow_limit = "18MW"
data.raw["roboport-equipment"]["vehicle-roboport-2"].charging_energy = mk2
