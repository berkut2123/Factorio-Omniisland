if settings.startup["bobmods-logistics-disableroboports"].value == false then


data.raw["logistic-robot"]["bob-logistic-robot-2"].max_energy = "4.375MJ"
data.raw["construction-robot"]["bob-construction-robot-2"].max_energy = "4.375MJ"

data.raw["logistic-robot"]["bob-logistic-robot-3"].max_energy = "5.4MJ"
data.raw["construction-robot"]["bob-construction-robot-3"].max_energy = "5.4MJ"

data.raw["logistic-robot"]["bob-logistic-robot-4"].max_energy = "7.5MJ"
data.raw["construction-robot"]["bob-construction-robot-4"].max_energy = "7.5MJ"

local mk1, mk2, mk3, mk4
mk1 = "3MW"
mk2 = "4.375MW"
mk3 = "5.4MW"
mk4 = "7.5MW"

data.raw["roboport"]["bob-roboport-2"].energy_source.input_flow_limit = "20MW"
data.raw["roboport"]["bob-roboport-2"].charging_energy = mk2
data.raw["roboport"]["bob-roboport-2"].robot_slots_count = 20

data.raw["roboport"]["bob-roboport-3"].energy_source.input_flow_limit = "30MW"
data.raw["roboport"]["bob-roboport-3"].charging_energy = mk3
data.raw["roboport"]["bob-roboport-3"].robot_slots_count = 20
data.raw["roboport"]["bob-roboport-3"].material_slots_count = 20

data.raw["roboport"]["bob-roboport-4"].energy_source.input_flow_limit = "45MW"
data.raw["roboport"]["bob-roboport-4"].charging_energy = mk4
data.raw["roboport"]["bob-roboport-4"].robot_slots_count = 30
data.raw["roboport"]["bob-roboport-4"].material_slots_count = 20

data.raw["roboport"]["bob-robochest"].energy_source.input_flow_limit = "3.1MW"
data.raw["roboport"]["bob-robochest"].charging_energy = mk1
data.raw["roboport"]["bob-robochest"].robot_slots_count = 20
data.raw["roboport"]["bob-robochest"].material_slots_count = 10

data.raw["roboport"]["bob-robochest-2"].energy_source.input_flow_limit = "4.5MW"
data.raw["roboport"]["bob-robochest-2"].charging_energy = mk2
data.raw["roboport"]["bob-robochest-2"].robot_slots_count = 30
data.raw["roboport"]["bob-robochest-2"].material_slots_count = 15

data.raw["roboport"]["bob-robochest-3"].energy_source.input_flow_limit = "5.5MW"
data.raw["roboport"]["bob-robochest-3"].charging_energy = mk3
data.raw["roboport"]["bob-robochest-3"].robot_slots_count = 40
data.raw["roboport"]["bob-robochest-3"].material_slots_count = 20

data.raw["roboport"]["bob-robochest-4"].energy_source.input_flow_limit = "7.6MW"
data.raw["roboport"]["bob-robochest-4"].charging_energy = mk4
data.raw["roboport"]["bob-robochest-4"].robot_slots_count = 50
data.raw["roboport"]["bob-robochest-4"].material_slots_count = 30

mk1 = "3.75MW"
mk2 = "5.46MW"
mk3 = "6.66MW"
mk4 = "9.38MW"

data.raw["roboport"]["bob-robo-charge-port"].energy_source.input_flow_limit = "15MW"
data.raw["roboport"]["bob-robo-charge-port"].charging_energy =  mk1

data.raw["roboport"]["bob-robo-charge-port-2"].energy_source.input_flow_limit = "21.84MW"
data.raw["roboport"]["bob-robo-charge-port-2"].charging_energy =  mk2

data.raw["roboport"]["bob-robo-charge-port-3"].energy_source.input_flow_limit = "26.64MW"
data.raw["roboport"]["bob-robo-charge-port-3"].charging_energy = mk3

data.raw["roboport"]["bob-robo-charge-port-4"].energy_source.input_flow_limit = "37.52MW"
data.raw["roboport"]["bob-robo-charge-port-4"].charging_energy =  mk4

data.raw["roboport"]["bob-robo-charge-port-large"].energy_source.input_flow_limit = "33.75MW"
data.raw["roboport"]["bob-robo-charge-port-large"].charging_energy =  mk1

data.raw["roboport"]["bob-robo-charge-port-large-2"].energy_source.input_flow_limit = "37.52MW"
data.raw["roboport"]["bob-robo-charge-port-large-2"].charging_energy =  mk2

data.raw["roboport"]["bob-robo-charge-port-large-3"].energy_source.input_flow_limit = "59.94MW"
data.raw["roboport"]["bob-robo-charge-port-large-3"].charging_energy =  mk3

data.raw["roboport"]["bob-robo-charge-port-large-4"].energy_source.input_flow_limit = "84.42MW"
data.raw["roboport"]["bob-robo-charge-port-large-4"].charging_energy =  mk4

data.raw["roboport"]["bob-roboport-4"].charging_offsets =
    {
      {-1.4, -0.5}, {1.4, -0.5}, {1.4, 1.5}, {-1.4, 1.5},
      {-1.5, -0.4}, {1.5, -0.4}, {1.5, 1.4}, {-1.5, 1.4},
    }
data.raw["roboport"]["bob-roboport-3"].charging_offsets =
    {
      {-1.4, -0.5}, {1.4, -0.5}, {1.4, 1.5}, {-1.4, 1.5},
      {-1.5, -0.4}, {1.5, -0.4}
    }
data.raw["roboport"]["bob-roboport-2"].charging_offsets =
    {
      {-1.4, -0.5}, {1.4, -0.5}, {1.4, 1.5}, {-1.4, 1.5},
      {-1.5, -0.4}
    }

data.raw.recipe["bob-roboport-2"].ingredients =
    {
      {"roboport", 1},
      {"steel-plate", 15},
      {"roboport-antenna-2", 5},
      {"roboport-chargepad-2", 5},
      {"roboport-door-2", 1},
    }
data.raw.recipe["bob-roboport-3"].ingredients =
    {
      {"bob-roboport-2", 1},
      {"steel-plate", 15},
      {"roboport-antenna-3", 5},
      {"roboport-chargepad-3", 6},
      {"roboport-door-3", 1},
    }
data.raw.recipe["bob-roboport-4"].ingredients =
    {
      {"bob-roboport-3", 1},
      {"steel-plate", 15},
      {"roboport-antenna-4", 5},
      {"roboport-chargepad-4", 8},
      {"roboport-door-4", 1},
    }
end
