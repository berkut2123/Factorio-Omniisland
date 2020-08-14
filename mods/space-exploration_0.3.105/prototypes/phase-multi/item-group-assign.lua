local data_util = require("data_util")
local types = {"item", "item-with-entity-data", "rail-planner", "capsule"}

local function change_group (name, group, order)
  if data.raw["item-subgroup"][name] then
    data.raw["item-subgroup"][name].group = group
    if order then
      data.raw["item-subgroup"][name].order = order
    end
  end
end

change_group("fluid-recipes", "resources")
change_group("fuel-processing", "resources")
change_group("fill-barrel", "resources")
change_group("empty-barrel", "resources")
change_group("raw-resource", "resources")
change_group("raw-material", "resources")
change_group("science-pack", "science", "a")
change_group("tool", "combat", "a-a")
change_group("gun", "combat", "a-b")

local function change_subgroup (name, subgroup, order)
  for _, type in pairs(types) do
    if data.raw[type][name] then
      data.raw[type][name].subgroup = subgroup
      if order then
        data.raw[type][name].order = order
      end
    end
  end
end
change_subgroup("logistic-chest-active-provider", "storage")
change_subgroup("logistic-chest-passive-provider", "storage")
change_subgroup("logistic-chest-storage", "storage")
change_subgroup("logistic-chest-buffer", "storage")
change_subgroup("logistic-chest-requester", "storage")

change_subgroup("transport-belt", "transport-belt")
change_subgroup("fast-transport-belt", "transport-belt")
change_subgroup("express-transport-belt", "transport-belt")

change_subgroup("underground-belt", "underground-belt")
change_subgroup("fast-underground-belt", "underground-belt")
change_subgroup("express-underground-belt", "underground-belt")

change_subgroup("splitter", "splitter")
change_subgroup("fast-splitter", "splitter")
change_subgroup("express-splitter", "splitter")

change_subgroup("pipe", "pipe")
change_subgroup("pipe-to-ground", "pipe")
change_subgroup("pump", "pipe")
change_subgroup("storage-tank", "pipe")

change_subgroup("rail", "rail")
change_subgroup("train-stop", "rail")
change_subgroup("rail-signal", "rail")
change_subgroup("rail-chain-signal", "rail")
change_subgroup("locomotive", "rail")
change_subgroup("cargo-wagon", "rail")
change_subgroup("fluid-wagon", "rail")
change_subgroup("artillery-wagon", "rail")

change_subgroup("burner-lab", "lab")
change_subgroup("lab", "lab")

change_subgroup("solar-panel", "solar")
change_subgroup("accumulator", "solar")

change_subgroup("chemical-plant", "chemistry")
change_subgroup("oil-refinery", "chemistry")
change_subgroup("fuel-processor", "chemistry")

change_subgroup("burner-assembling-machine", "assembling")
change_subgroup("assembling-machine-1", "assembling")
change_subgroup("assembling-machine-2", "assembling")
change_subgroup("assembling-machine-3", "assembling")

change_subgroup("centrifuge", "radiation")


change_subgroup("sand", "pulverised")
change_subgroup("glass", "plates")
change_subgroup("iron-plate", "plates")
change_subgroup("copper-plate", "plates")
change_subgroup("steel-plate", "plates")
change_subgroup("plastic-bar", "plates")
change_subgroup("stone-tablet", "plates")

change_subgroup("battery", "intermediate-product")
change_subgroup("explosives", "intermediate-product")

change_subgroup("cliff-explosives", "capsule")

if data.raw.item["logistic-train-stop"] then data.raw.item["logistic-train-stop"].subgroup = "rail" end
if data.raw["item-subgroup"]["angels-warehouses"] then data.raw["item-subgroup"]["angels-warehouses"].order = "a1-"..data.raw["item-subgroup"]["angels-warehouses"].order end
if data.raw.item["angels-pressure-tank-1"] then data.raw.item["angels-pressure-tank-1"].subgroup = "pipe" end
