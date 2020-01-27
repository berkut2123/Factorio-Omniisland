if settings.startup["bobmods-logistics-disableroboports"].value == false then


data.raw["roboport"]["bob-roboport-2"].robot_slots_count = 20

data.raw["roboport"]["bob-roboport-3"].robot_slots_count = 20
data.raw["roboport"]["bob-roboport-3"].material_slots_count = 20

data.raw["roboport"]["bob-roboport-4"].robot_slots_count = 30
data.raw["roboport"]["bob-roboport-4"].material_slots_count = 20

data.raw["roboport"]["bob-robochest"].robot_slots_count = 20
data.raw["roboport"]["bob-robochest"].material_slots_count = 10

data.raw["roboport"]["bob-robochest-2"].robot_slots_count = 30
data.raw["roboport"]["bob-robochest-2"].material_slots_count = 15

data.raw["roboport"]["bob-robochest-3"].robot_slots_count = 40
data.raw["roboport"]["bob-robochest-3"].material_slots_count = 20

data.raw["roboport"]["bob-robochest-4"].robot_slots_count = 50
data.raw["roboport"]["bob-robochest-4"].material_slots_count = 30

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
