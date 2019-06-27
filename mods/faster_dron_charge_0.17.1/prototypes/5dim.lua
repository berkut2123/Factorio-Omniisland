data.raw.roboport["5d-roboport-2"].energy_source.input_flow_limit = "20MW"
data.raw.roboport["5d-roboport-2"].charging_energy = "3.5MW"
data.raw.roboport["5d-roboport-2"].robot_slots_count = 20
data.raw.roboport["5d-roboport-2"].material_slots_count = 10
data.raw.roboport["5d-roboport-3"].energy_source.input_flow_limit = "30MW"
data.raw.roboport["5d-roboport-3"].charging_energy = "4MW"
data.raw.roboport["5d-roboport-3"].robot_slots_count = 20
data.raw.roboport["5d-roboport-3"].material_slots_count = 20
data.raw.roboport["5d-roboport-4"].energy_source.input_flow_limit = "45MW"
data.raw.roboport["5d-roboport-4"].charging_energy = "5MW"
data.raw.roboport["5d-roboport-4"].robot_slots_count = 30
data.raw.roboport["5d-roboport-4"].material_slots_count = 20

data.raw["logistic-robot"]["5d-logistic-robot-2"].max_energy = "6MJ"
data.raw["construction-robot"]["5d-construction-robot-2"].max_energy = "6MJ"

data.raw["logistic-robot"]["5d-logistic-robot-3"].max_energy = "9MJ"
data.raw["construction-robot"]["5d-construction-robot-3"].max_energy = "9MJ"

data.raw["logistic-robot"]["5d-logistic-robot-4"].max_energy = "12MJ"
data.raw["construction-robot"]["5d-construction-robot-4"].max_energy = "12MJ"

data.raw["logistic-robot"]["5d-logistic-robot-p"].max_energy = "12MJ"
data.raw["construction-robot"]["5d-construction-robot-p"].max_energy = "12MJ"





data.raw.roboport["5d-roboport-3"].charging_offsets =
    {
      {-1.4, -0.5}, {1.4, -0.5}, {1.4, 1.5}, {-1.4, 1.5},
      {-1.5, -0.4}, {1.5, -0.4}
    }
data.raw.roboport["5d-roboport-2"].charging_offsets =
    {
      {-1.4, -0.5}, {1.4, -0.5}, {1.4, 1.5}, {-1.4, 1.5},
      {-1.5, -0.4}
    }
