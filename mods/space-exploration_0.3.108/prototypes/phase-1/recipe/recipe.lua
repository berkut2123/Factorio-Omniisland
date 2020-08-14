local data_util = require("data_util")
local make_recipe = data_util.make_recipe

if not data.raw.recipe["sand-from-stone"] then
  data:extend({
    {
      ingredients = {
        { "stone", 1 }
      },
      name = "sand-from-stone",
      result = "sand",
      result_count = 2,
      type = "recipe",
      enabled = false,
      energy_required = 0.5,
    }
  })
end
data:extend({
  {
    ingredients = {
      { "stone", 1 }
    },
    name = data_util.mod_prefix .. "pulverised-sand",
    result = "sand",
    result_count = 3,
    type = "recipe",
    enabled = false,
    energy_required = 0.5,
    category = "pulverising",
    --localised_name = {"recipe-name."..data_util.mod_prefix .. "pulverised-sand"},
    always_show_made_in = true,
  }
})

if not data.raw.recipe["glass-from-sand"] then
  data:extend({
    {
      category = "smelting",
      enabled = true,
      energy_required = 4,
      ingredients = {
        { "sand", 4 }
      },
      name = "glass-from-sand",
      result = "glass",
      type = "recipe",
      enabled = false,
    },
  })
end

data:extend({
  {
      type = "recipe",
      name = data_util.mod_prefix .. "low-density-structure-beryllium",
      result = "low-density-structure",
      energy_required = 10,
      ingredients = {
        { name = data_util.mod_prefix .. "aeroframe-scaffold", amount = 2},
        { name = "glass", amount = 2},
        { "steel-plate", 2 },
        { "plastic-bar", 2 }
      },
      requester_paste_multiplier = 2,
      enabled = false,
      always_show_made_in = false,
      allow_as_intermediate = false,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "heat-shielding",
      result = data_util.mod_prefix .. "heat-shielding",
      energy_required = 10,
      ingredients = {
        { name = "stone-tablet", amount = 20},
        { "sulfur", 8 },
        { "steel-plate", 2 }
      },
      requester_paste_multiplier = 2,
      enabled = false,
      always_show_made_in = false,
  },
  {
      type = "recipe",
      name = data_util.mod_prefix .. "heat-shielding-iridium",
      result = data_util.mod_prefix .. "heat-shielding",
      energy_required = 10,
      ingredients = {
        { name = data_util.mod_prefix .. "iridium-plate", amount = 1},
        { name = "stone-tablet", amount = 4},
        { "sulfur", 1 },
      },
      requester_paste_multiplier = 2,
      enabled = false,
      always_show_made_in = true,
      allow_as_intermediate = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "thruster-suit",
    result = data_util.mod_prefix .. "thruster-suit",
    enabled = false,
    energy_required = 30,
    ingredients = {
      { "rocket-control-unit", 10 },
      { data_util.mod_prefix .. "heat-shielding", 20 },
      { "low-density-structure", 20 },
      { "glass", 20 },
      { "jetpack-1", 1 },
      { data_util.mod_prefix .. "lifesupport-equipment-1", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "thruster-suit-2",
    results = {
      { name=data_util.mod_prefix .. "thruster-suit-2", amount = 1},
    },
    main_product = data_util.mod_prefix .. "thruster-suit-2",
    enabled = false,
    energy_required = 30,
    ingredients = {
      { "processing-unit", 50 },
      { "rocket-fuel", 50 },
      { data_util.mod_prefix .. "iridium-plate", 50 },
      { data_util.mod_prefix .. "material-catalogue-1", 1 },
      { data_util.mod_prefix .. "thruster-suit", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "thruster-suit-3",
    results = {
      { name=data_util.mod_prefix .. "thruster-suit-3", amount = 1},
    },
    main_product = data_util.mod_prefix .. "thruster-suit-3",
    enabled = false,
    energy_required = 30,
    ingredients = {
      { "processing-unit", 100 },
      { "rocket-fuel", 50 },
      { data_util.mod_prefix .. "superconductive-cable", 50 },
      { data_util.mod_prefix .. "astronomic-catalogue-1", 1 },
      { data_util.mod_prefix .. "biological-catalogue-1", 1 },
      { data_util.mod_prefix .. "energy-catalogue-3", 1 },
      { data_util.mod_prefix .. "material-catalogue-3", 1 },
      { data_util.mod_prefix .. "aeroframe-bulkhead", 1 },
      { data_util.mod_prefix .. "thruster-suit-2", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "thruster-suit-4",
    results = {
      { name=data_util.mod_prefix .. "thruster-suit-4", amount = 1},
    },
    main_product = data_util.mod_prefix .. "thruster-suit-4",
    enabled = false,
    energy_required = 30,
    ingredients = {
      { "processing-unit", 200 },
      { data_util.mod_prefix .. "antimatter-canister", 10 },
      { data_util.mod_prefix .. "nano-material", 200 },
      { data_util.mod_prefix .. "superconductive-cable", 100 },
      { data_util.mod_prefix .. "naquium-plate", 100 },
      { data_util.mod_prefix .. "universal-catalogue", 1 },
      { data_util.mod_prefix .. "self-sealing-gel", 1 },
      { data_util.mod_prefix .. "lattice-pressure-vessel", 1 },
      { data_util.mod_prefix .. "naquium-processor", 1 },
      { data_util.mod_prefix .. "thruster-suit-3", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "rtg-equipment",
    result = data_util.mod_prefix .. "rtg-equipment",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "processing-unit", 50 },
      { "low-density-structure", 50 },
      { "uranium-fuel-cell", 4 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "rtg-equipment-2",
    result = data_util.mod_prefix .. "rtg-equipment-2",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "processing-unit", 50 },
      { "low-density-structure", 100 },
      { data_util.mod_prefix .."atomic-data", 1 },
      { data_util.mod_prefix .."radiation-data", 1 },
      { data_util.mod_prefix .. "rtg-equipment", 4 },
      { data_util.mod_prefix .. "holmium-solenoid", 8 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-1",
    result = data_util.mod_prefix .. "adaptive-armour-equipment-1",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "steel-plate", 20 },
      { "advanced-circuit", 10 },
      { "battery", 5 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-2",
    result = data_util.mod_prefix .. "adaptive-armour-equipment-2",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "steel-plate", 30 },
      { "processing-unit", 10 },
      { "low-density-structure", 10 },
      { data_util.mod_prefix .. "adaptive-armour-equipment-1", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-3",
    result = data_util.mod_prefix .. "adaptive-armour-equipment-3",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "steel-plate", 40 },
      { "processing-unit", 10 },
      { data_util.mod_prefix .. "heat-shielding", 10 },
      { data_util.mod_prefix .. "adaptive-armour-equipment-2", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-4",
    result = data_util.mod_prefix .. "adaptive-armour-equipment-4",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "steel-plate", 50 },
      { "processing-unit", 20 },
      { data_util.mod_prefix .. "heat-shielding", 20 },
      { data_util.mod_prefix .. "adaptive-armour-equipment-3", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "adaptive-armour-equipment-5",
    result = data_util.mod_prefix .. "adaptive-armour-equipment-5",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "steel-plate", 40 },
      { "processing-unit", 30 },
      { data_util.mod_prefix .. "nano-material", 10 },
      { data_util.mod_prefix .. "adaptive-armour-equipment-4", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = "energy-shield-mk3-equipment",
    result = "energy-shield-mk3-equipment",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "energy-shield-mk2-equipment", 5 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = "energy-shield-mk4-equipment",
    result = "energy-shield-mk4-equipment",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "energy-shield-mk3-equipment", 5 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = "energy-shield-mk5-equipment",
    result = "energy-shield-mk5-equipment",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "energy-shield-mk4-equipment", 5 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },
  {
    type = "recipe",
    name = "energy-shield-mk6-equipment",
    result = "energy-shield-mk6-equipment",
    enabled = false,
    energy_required = 10,
    ingredients = {
      { "energy-shield-mk5-equipment", 5 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
  },




  {
    type = "recipe",
    name = data_util.mod_prefix .. "aeroframe-pole",
    results = {{data_util.mod_prefix .. "aeroframe-pole", 2}},
    energy_required = 1,
    ingredients = {
      { data_util.mod_prefix .. "beryllium-plate", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "aeroframe-scaffold",
    result = data_util.mod_prefix .. "aeroframe-scaffold",
    energy_required = 2,
    ingredients = {
      { data_util.mod_prefix .. "aeroframe-pole", 2 },
      { data_util.mod_prefix .. "beryllium-plate", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "aeroframe-bulkhead",
    result = data_util.mod_prefix .. "aeroframe-bulkhead",
    energy_required = 4,
    ingredients = {
      { data_util.mod_prefix .. "aeroframe-scaffold", 1 },
      { "low-density-structure", 1 },
      { data_util.mod_prefix .. "beryllium-plate", 4 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "lattice-pressure-vessel",
    result = data_util.mod_prefix .. "lattice-pressure-vessel",
    energy_required = 3,
    ingredients = {
      { data_util.mod_prefix .. "beryllium-plate", 5 },
      { data_util.mod_prefix .. "cryonite-rod", 2 },
      { data_util.mod_prefix .. "vulcanite-block", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
    category="space-manufacturing"
  },

  {
    type = "recipe",
    name = data_util.mod_prefix .. "heavy-girder",
    result = data_util.mod_prefix .. "heavy-girder",
    energy_required = 1,
    ingredients = {
      { data_util.mod_prefix .. "iridium-plate", 2 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "heavy-bearing",
    result = data_util.mod_prefix .. "heavy-bearing",
    energy_required = 2,
    ingredients = {
      { data_util.mod_prefix .. "iridium-plate", 4 },
      { type="fluid", name="lubricant", amount=4 },
    },
    category="crafting-with-fluid",
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "heavy-composite",
    result = data_util.mod_prefix .. "heavy-composite",
    energy_required = 3,
    ingredients = {
      { data_util.mod_prefix .. "iridium-plate", 4 },
      { data_util.mod_prefix .. "heavy-girder", 2 },
      { data_util.mod_prefix .. "heat-shielding", 4 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "heavy-assembly",
    result = data_util.mod_prefix .. "heavy-assembly",
    energy_required = 4,
    ingredients = {
      { data_util.mod_prefix .. "iridium-plate", 4 },
      { data_util.mod_prefix .. "heavy-bearing", 4 },
      { "iron-gear-wheel", 4 },
      { type="fluid", name="lubricant", amount=4 },
    },
    category="crafting-with-fluid",
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
  },


  {
    type = "recipe",
    name = data_util.mod_prefix .. "vitalic-acid",
    result = data_util.mod_prefix .. "vitalic-acid",
    energy_required = 1,
    ingredients = {
      { "glass", 1 },
      { data_util.mod_prefix .. "vitamelange-extract", 2 },
      { type = "fluid", name = "sulfuric-acid", amount = 2 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
    category = "crafting-with-fluid",
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "bioscrubber",
    result = data_util.mod_prefix .. "bioscrubber",
    energy_required = 2,
    ingredients = {
      { data_util.mod_prefix .. "vitalic-acid", 2 },
      { "glass", 1 },
      { "steel-plate", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = true,
    enabled = false,
    category = "chemistry",
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "vitalic-reagent",
    result = data_util.mod_prefix .. "vitalic-reagent",
    energy_required = 3,
    ingredients = {
      { data_util.mod_prefix .. "vitamelange-extract", 4 },
      { data_util.mod_prefix .. "vulcanite-block", 4 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = true,
    enabled = false,
    category = "chemistry",
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "vitalic-epoxy",
    result = data_util.mod_prefix .. "vitalic-epoxy",
    energy_required = 4,
    ingredients = {
      { data_util.mod_prefix .. "vitalic-reagent", 2 },
      { data_util.mod_prefix .. "vitalic-acid", 2 },
      { "sulfur", 4 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = true,
    enabled = false,
    category = "chemistry",
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "self-sealing-gel",
    result = data_util.mod_prefix .. "self-sealing-gel",
    energy_required = 5,
    ingredients = {
      { data_util.mod_prefix .. "vitalic-reagent", 2 },
      { data_util.mod_prefix .. "vitalic-epoxy", 2 },
      { data_util.mod_prefix .. "cryonite-rod", 2 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = true,
    enabled = false,
    category = "space-biochemical",
  },




  {
    type = "recipe",
    name = data_util.mod_prefix .. "holmium-cable",
    results = {{data_util.mod_prefix .. "holmium-cable", 2}},
    energy_required = 1,
    ingredients = {
      { data_util.mod_prefix .. "holmium-plate", 1 },
      { "plastic-bar", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "holmium-solenoid",
    result = data_util.mod_prefix .. "holmium-solenoid",
    energy_required = 2,
    ingredients = {
      { data_util.mod_prefix .. "holmium-cable", 4 },
      { data_util.mod_prefix .. "holmium-plate", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = false,
    enabled = false,
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "quantum-processor",
    result = data_util.mod_prefix .. "quantum-processor",
    energy_required = 3,
    ingredients = {
      { "processing-unit", 1 },
      { data_util.mod_prefix .. "holmium-cable", 4 },
      { data_util.mod_prefix .. "holmium-plate", 1 },
      {data_util.mod_prefix .. "quantum-phenomenon-data", 1},
    },
    requester_paste_multiplier = 1,
    always_show_made_in = true,
    enabled = false,
    category="space-manufacturing"
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "dynamic-emitter",
    result = data_util.mod_prefix .. "dynamic-emitter",
    energy_required = 4,
    ingredients = {
      { data_util.mod_prefix .. "holmium-solenoid", 1 },
      { data_util.mod_prefix .. "quantum-processor", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = true,
    enabled = false,
    category="space-manufacturing"
  },

  {
    type = "recipe",
    name = data_util.mod_prefix .. "naquium-cube",
    results = {{data_util.mod_prefix .. "naquium-cube", 16}},
    energy_required = 10,
    ingredients = {
      { type="fluid", name = data_util.mod_prefix .. "particle-stream", amount = 16 },
      { data_util.mod_prefix .. "naquium-plate", 16 },
      { data_util.mod_prefix .. "universal-catalogue", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = true,
    enabled = false,
    category = "space-materialisation",
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "naquium-tessaract",
    result = data_util.mod_prefix .. "naquium-tessaract",
    energy_required = 20,
    ingredients = {
      { data_util.mod_prefix .. "nano-material", 1 },
      { data_util.mod_prefix .. "naquium-cube", 1 },
      { data_util.mod_prefix .. "enriched-naquium", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = true,
    enabled = false,
    category="space-gravimetrics"
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "naquium-processor",
    result = data_util.mod_prefix .. "naquium-processor",
    energy_required = 20,
    ingredients = {
      { data_util.mod_prefix .. "quantum-processor", 1 },
      { data_util.mod_prefix .. "naquium-tessaract", 1 },
    },
    requester_paste_multiplier = 1,
    always_show_made_in = true,
    enabled = false,
    category="space-laser"
  },
})
