local data_util = require("data_util")
data.raw.item["rocket-silo"].subgroup = "rocket-logistics"
data.raw.item["rocket-silo"].order = "a"

data.raw.item["rocket-control-unit"].subgroup = "rocket-intermediate-product"
data.raw.item["low-density-structure"].subgroup = "rocket-intermediate-product"
data.raw.item["low-density-structure"].order = "b"
data.raw.item["low-density-structure"].stack_size = 50
data.raw.item["rocket-fuel"].subgroup = "rocket-intermediate-product"

data.raw.capsule["raw-fish"].capsule_action = {
  attack_parameters = {
    ammo_category = "capsule",
    ammo_type = {
      action = {
        action_delivery = {
          target_effects = {
            damage = {
              amount = -10,
              type = "poison"
            },
            type = "damage"
          },
          type = "instant"
        },
        type = "direct"
      },
      category = "capsule",
      target_type = "position"
    },
    cooldown = 30,
    range = 0,
    type = "projectile"
  },
  type = "use-on-self"
}


if not data.raw.item["sand"] then
  data:extend({
    {
      icon = "__space-exploration-graphics__/graphics/icons/sand.png",
      icon_size = 64,
      name = "sand",
      order = "a[wood]-b-b",
      stack_size = 200,
      subgroup = "raw-material",
      type = "item"
    }
  })
end

if not data.raw.item["glass"] then
  data:extend({
    {
      icon = "__space-exploration-graphics__/graphics/icons/glass.png",
      icon_size = 64,
      name = "glass",
      order = "a[wood]-b-c",
      stack_size = 100,
      subgroup = "raw-material",
      type = "item"
    }
  })
end

-- item_group, sequence
--[[
data:extend({
  {
      action = {
        action_delivery = {
          target_effects = {
            damage = {
              amount = 50, -- 8,
              type = "physical"
            },
            type = "damage"
          },
          type = "instant"
        },
        type = "direct"
      },
      durability = 10000, -- 5000
      icon = "__space-exploration-graphics__/graphics/icons/omega-tool.png",
      icon_size = 32,
      name = data_util.mod_prefix .. "omega-tool",
      order = "a[mining]-b[steel-axe]",
      speed = 100, --4,
      stack_size = 5,
      subgroup = "tool",
      type = "mining-tool"
    },
})]]--

data:extend({
  {
    type = "item",
    name = data_util.mod_prefix .. "heat-shielding",
    icon = "__space-exploration-graphics__/graphics/icons/heat-shielding.png",
    icon_size = 64,
    order = "a",
    stack_size = 50,
    subgroup = "rocket-intermediate-product",
  },
  {
    icon = "__space-exploration-graphics__/graphics/icons/accumulator.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "space-accumulator",
    order = data.raw.item.accumulator.order,
    place_result = data_util.mod_prefix .. "space-accumulator",
    stack_size = data.raw.item.accumulator.stack_size,
    subgroup = "solar",
    type = "item"
  },
  {
    icon = "__space-exploration-graphics__/graphics/icons/accumulator-2.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "space-accumulator-2",
    order = data.raw.item.accumulator.order,
    place_result = data_util.mod_prefix .. "space-accumulator-2",
    stack_size = data.raw.item.accumulator.stack_size,
    subgroup = "solar",
    type = "item"
  },
  {
    icon = "__space-exploration-graphics__/graphics/icons/solar-panel.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "space-solar-panel",
    order = "d[solar-panel]-a[solar-panel]-b",
    place_result = data_util.mod_prefix .. "space-solar-panel",
    stack_size = 20,
    subgroup = "solar",
    type = "item"
  },
  {
    icon = "__space-exploration-graphics__/graphics/icons/solar-panel-2.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "space-solar-panel-2",
    order = "d[solar-panel]-a[solar-panel]-b2",
    place_result = data_util.mod_prefix .. "space-solar-panel-2",
    stack_size = 20,
    subgroup = "solar",
    type = "item"
  },
  {
    icon = "__space-exploration-graphics__/graphics/icons/solar-panel-3.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "space-solar-panel-3",
    order = "d[solar-panel]-a[solar-panel]-b3",
    place_result = data_util.mod_prefix .. "space-solar-panel-3",
    stack_size = 20,
    subgroup = "solar",
    type = "item"
  },
  {
    icon = "__space-exploration-graphics__/graphics/icons/medpack-1.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "medpack",
    order = "aa",
    stack_size = 20,
    subgroup = "capsule",
    type = "capsule",
    capsule_action = {
      attack_parameters = {
        ammo_category = "capsule",
        ammo_type = {
          action = {
            action_delivery = {
              target_effects = {
                damage = {
                  amount = -50,
                  type = "poison"
                },
                type = "damage"
              },
              type = "instant"
            },
            type = "direct"
          },
          category = "capsule",
          target_type = "position"
        },
        cooldown = 10,
        range = 0,
        type = "projectile"
      },
      type = "use-on-self"
    },
  },
  {
    icon = "__space-exploration-graphics__/graphics/icons/medpack-2.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "medpack-2",
    order = "aa",
    stack_size = 20,
    subgroup = "capsule",
    type = "capsule",
    capsule_action = {
      attack_parameters = {
        ammo_category = "capsule",
        ammo_type = {
          action = {
            action_delivery = {
              target_effects = {
                damage = {
                  amount = -100,
                  type = "poison"
                },
                type = "damage"
              },
              type = "instant"
            },
            type = "direct"
          },
          category = "capsule",
          target_type = "position"
        },
        cooldown = 10,
        range = 0,
        type = "projectile"
      },
      type = "use-on-self"
    },
  },
  {
    icon = "__space-exploration-graphics__/graphics/icons/medpack-3.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "medpack-3",
    order = "aa",
    stack_size = 20,
    subgroup = "capsule",
    type = "capsule",
    capsule_action = {
      attack_parameters = {
        ammo_category = "capsule",
        ammo_type = {
          action = {
            action_delivery = {
              target_effects = {
                damage = {
                  amount = -200,
                  type = "poison"
                },
                type = "damage"
              },
              type = "instant"
            },
            type = "direct"
          },
          category = "capsule",
          target_type = "position"
        },
        cooldown = 10,
        range = 0,
        type = "projectile"
      },
      type = "use-on-self"
    },
  },
  {
    icon = "__space-exploration-graphics__/graphics/icons/medpack-4.png",
    icon_size = 64,
    name = data_util.mod_prefix .. "medpack-4",
    order = "aa",
    stack_size = 20,
    subgroup = "capsule",
    type = "capsule",
    capsule_action = {
      attack_parameters = {
        ammo_category = "capsule",
        ammo_type = {
          action = {
            action_delivery = {
              target_effects = {
                damage = {
                  amount = -400,
                  type = "poison"
                },
                type = "damage"
              },
              type = "instant"
            },
            type = "direct"
          },
          category = "capsule",
          target_type = "position"
        },
        cooldown = 10,
        range = 0,
        type = "projectile"
      },
      type = "use-on-self"
    },
  },
})

local function make_item_sequence(item_group, items, set, icon_size)
  for _, item in pairs(items) do
    -- name, stack_size, icon_size, picture count
    local item = type(item) == "string" and {item, 50} or item
    local order = "a-" .. string.format("%02d", _)
    local filename = item[1] .. ".png"
    local proto = {
      type = "item",
      name = data_util.mod_prefix .. item[1],
      icon = "__space-exploration-graphics__/graphics/icons/" .. (set == "catalogue" and "catalogue/" or "") .. filename,
      icon_size = set == "catalogue" and 64 or (item[3] or (icon_size or 32)),
      subgroup = item_group,
      order = order,
      stack_size = item[2]
    }
    if item[4] then
      local baseFileName = "__space-exploration-graphics__/graphics/icons/" .. (set == "catalogue" and "catalogue/" or "") .. item[1]
      proto.pictures = {
         { size = 32, filename = baseFileName .. ".png", scale = 0.5 },
         { size = 32, filename = baseFileName .. "-1" .. ".png", scale = 0.5 },
         { size = 32, filename = baseFileName .. "-2" .. ".png", scale = 0.5 },
         { size = 32, filename = baseFileName .. "-3" .. ".png", scale = 0.5 }
      }
    end
    data:extend({proto})
    --log(data_util.mod_prefix .. item[1])
  end
end

local function make_data_item_sequence(item_group, items, stack_size, icon_size)
  local stack_size = stack_size or 100
  for _, item in pairs(items) do
    local item = type(item) == "string" and {item, 50} or item
    local order = "a-" .. string.format("%02d", _)
    data:extend({{
      type = "item",
      name = data_util.mod_prefix .. item[1] .. "-data",
      icon = "__space-exploration-graphics__/graphics/icons/data/" .. item[1] .. ".png",
      icon_size = icon_size or 64,
      subgroup = item_group,
      order = order,
      stack_size = item[2]
    }})
    --log(data_util.mod_prefix .. item[1] .. "-data")
  end
end

make_item_sequence("data-catalogue-astronomic", {
  "astronomic-catalogue-1", "astronomic-catalogue-2", "astronomic-catalogue-3", "astronomic-catalogue-4", "astronomic-insight"}, "catalogue")
make_item_sequence("data-catalogue-energy", {
  "energy-catalogue-1", "energy-catalogue-2", "energy-catalogue-3", "energy-catalogue-4", "energy-insight"}, "catalogue")
make_item_sequence("data-catalogue-biological", {
  "biological-catalogue-1", "biological-catalogue-2", "biological-catalogue-3", "biological-catalogue-4", "biological-insight"}, "catalogue")
make_item_sequence("data-catalogue-material", {
  "material-catalogue-1", "material-catalogue-2", "material-catalogue-3", "material-catalogue-4", "material-insight"}, "catalogue")

make_data_item_sequence("data-significant", { "significant"})
make_data_item_sequence("data-generic", {"empty", "junk", "broken",
  "machine-learning"}, nil, 64)
data.raw.item[data_util.mod_prefix .. "broken-data"].icon_size = 32
data.raw.item[data_util.mod_prefix .. "empty-data"].order = "b"
data.raw.item[data_util.mod_prefix .. "machine-learning-data"].order = "c"

data:extend({
  {
    type = "item",
    name = data_util.mod_prefix .. "universal-catalogue",
    icon = "__space-exploration-graphics__/graphics/icons/catalogue/universal-catalogue.png",
    icon_size = 64,
    subgroup = "data-generic",
    order = "d",
    stack_size = 50
  }
})

make_data_item_sequence("data-astronomic", {
  "visible-observation",
  "infrared-observation",
  "uv-observation",
  "astrometric",
  --"doppler-shift",

  "microwave-observation",
  "xray-observation",
  "gravitational-lensing",
  "gravity-wave",

  "radio-observation",
  "gammaray-observation",
  "darkmatter",
  "negative-pressure",

  "dark-energy",
  "micro-black-hole",
  "timespace-anomaly",
  "zero-point-energy",
})

make_data_item_sequence("data-energy", {
  "conductivity",
  --"ion-spectrometry",
  "electromagnetic-field",
  "polarisation",
  "radiation",

  "quantum-phenomenon",
  "atomic",
  "subatomic",
  "forcefield",

  "superconductivity",
  "quark",
  "entanglement",
  "lepton",

  "boson",
  "fusion-test",
  "singularity",
  "magnetic-monopole",
})

make_data_item_sequence("data-biological", {
  "bio-combustion",
  --"bio-spectral",
  "biomechanical",
  "biochemical",
  "genetic",

  "bio-combustion-resistance",
  "experimental-genetic",
  "biochemical-resistance",
  "biomechanical-resistance",

  "bioelectrics",
  "cryogenics",
  "decompression",
  "radiation-exposure",

  "comparative-genetic",
  "decompression-resistance",
  "neural-anomaly",
  "radiation-exposure-resistance",
})

make_data_item_sequence("data-material", {
  "cold-thermodynamics",
  "hot-thermodynamics",
  "tensile-strength",
  "compressive-strength",
  --"shear-strength",

  "rigidity",
  "pressure-containment",
  "corrosion-resistance",
  "impact-shielding",

  "friction",
  "ballistic-shielding",
  "radiation-shielding",
  "explosion-shielding",

  "electrical-shielding",
  "laser-shielding",
  "particle-beam-shielding",
  "experimental-alloys",
})

make_item_sequence("space-observation-frame", {
  {"observation-frame-blank", 200},
  {"observation-frame-radio", 200},
  {"observation-frame-microwave", 200},
  {"observation-frame-infrared", 200},
  {"observation-frame-visible", 200},
  {"observation-frame-uv", 200},
  {"observation-frame-xray", 200},
  {"observation-frame-gammaray", 200},
})

make_item_sequence("space-canisters", {
  {"canister", 50},
  {"magnetic-canister", 50},
  {"plasma-canister", 50},
  {"antimatter-canister", 50},
  {"empty-lifesupport-canister", 50},
  {"lifesupport-canister", 50},
  {"used-lifesupport-canister", 50},
})
data.raw.item[data_util.mod_prefix .. "antimatter-canister"].fuel_value = "20000MJ"
data.raw.item[data_util.mod_prefix .. "antimatter-canister"].fuel_category = "antimatter"
data.raw.item[data_util.mod_prefix .. "antimatter-canister"].burnt_result = data_util.mod_prefix .. "magnetic-canister"

make_item_sequence("space-bioculture", {
  {"nutrient-vat", 5},
  {"bioculture", 5},
  {"experimental-bioculture", 5},
  {"specimen", 5},
  {"experimental-specimen", 5},
  {"significant-specimen", 5},
}, nil, 32)

make_item_sequence("space-components", {
  {"scrap", 50, 32, 4},
  {"contaminated-scrap", 50, 32, 4},
  "space-mirror",
  "gammaray-detector",
  {"material-testing-pack", 10},
  --"experimental-material",
  "nano-material",
  --"experimental-superconductor",

  {"superconductive-cable", 50, 64},

  {"aeroframe-pole", 50, 64},
  {"aeroframe-scaffold", 50, 64},
  {"aeroframe-bulkhead", 50, 64},
  {"lattice-pressure-vessel", 50, 64},

  {"heavy-girder", 50, 64},
  {"heavy-bearing", 50, 64},
  {"heavy-composite", 50, 64},
  {"heavy-assembly", 50, 64},

  {"vitalic-acid", 50, 64},
  {"bioscrubber", 50, 64},
  {"vitalic-reagent", 50, 64},
  {"vitalic-epoxy", 50, 64},
  {"self-sealing-gel", 50, 64},

  {"holmium-cable", 50, 64},
  {"holmium-solenoid", 50, 64},
  {"quantum-processor", 50, 64},
  {"dynamic-emitter", 50, 64},

  {"naquium-cube", 8, 64},
  {"naquium-tessaract", 1, 64},
  {"naquium-processor", 1, 64},
}, nil, 32)

data.raw.item[data_util.mod_prefix .. "scrap"].pictures = {
  {filename = "__space-exploration-graphics__/graphics/icons/scrap.png",scale = 0.5,size = 32},
  {filename = "__space-exploration-graphics__/graphics/icons/scrap-1.png",scale = 0.5,size = 32},
  {filename = "__space-exploration-graphics__/graphics/icons/scrap-2.png",scale = 0.5,size = 32},
  {filename = "__space-exploration-graphics__/graphics/icons/scrap-3.png",scale = 0.5,size = 32}
}
data.raw.item[data_util.mod_prefix .. "contaminated-scrap"].pictures = {
  {filename = "__space-exploration-graphics__/graphics/icons/contaminated-scrap.png",scale = 0.5,size = 32},
  {filename = "__space-exploration-graphics__/graphics/icons/contaminated-scrap-1.png",scale = 0.5,size = 32},
  {filename = "__space-exploration-graphics__/graphics/icons/contaminated-scrap-2.png",scale = 0.5,size = 32},
  {filename = "__space-exploration-graphics__/graphics/icons/contaminated-scrap-3.png",scale = 0.5,size = 32}
}

make_item_sequence("data-generic", {
  {"data-storage-substrate", 100},
  {"data-storage-substrate-cleaned", 100},
}, nil, 32)

data.raw.item[data_util.mod_prefix .. "material-testing-pack"].icon = nil
data.raw.item[data_util.mod_prefix .. "material-testing-pack"].icons =  {
    {
      icon = "__space-exploration-graphics__/graphics/icons/crate.png"
    },
    {
      icon = "__space-exploration-graphics__/graphics/icons/crate-mask.png",
      tint = {r = 255, g = 255, b = 255}
    }
}
