local data_util = require("data_util")

local washlist = {"chemical-plant", data_util.mod_prefix.."space-decontamination-facility"}
for _, name in pairs(washlist) do
  if data.raw["assembling-machine"][name] then
    table.insert(data.raw["assembling-machine"][name].crafting_categories, "pressure-washing")
  end
end

data_util.replace_or_add_ingredient("low-density-structure", "steel-plate", "steel-plate", 5)
data_util.replace_or_add_ingredient("low-density-structure", "copper-plate", "copper-plate", 10)
if data.raw.item.glass then
  data_util.replace_or_add_ingredient("low-density-structure", nil, "glass", 10)
else
  data_util.replace_or_add_ingredient("low-density-structure", nil, "stone", 10)
end
data_util.replace_or_add_ingredient("low-density-structure", "plastic-bar", "plastic-bar", 10)

data_util.replace_or_add_ingredient("rocket-control-unit", nil, "iron-plate", 5)
data_util.replace_or_add_ingredient("rocket-control-unit", nil, "glass", 5)
data_util.replace_or_add_ingredient("rocket-control-unit", "speed-module", "battery", 5)
data_util.replace_or_add_ingredient("rocket-control-unit", "advanced-circuit", "advanced-circuit", 5)
data_util.replace_or_add_ingredient("rocket-control-unit", "processing-unit", "processing-unit", 1)

data_util.replace_or_add_ingredient("rocket-part", "low-density-structure", "low-density-structure", 5)
data_util.replace_or_add_ingredient("rocket-part", "rocket-control-unit", "rocket-control-unit", 5)
data_util.replace_or_add_ingredient("rocket-part", nil, data_util.mod_prefix .. "heat-shielding", 5)
data.raw["rocket-silo"]["rocket-silo"].rocket_parts_required = 50


data.raw.recipe["solid-fuel-from-heavy-oil"].category = "fuel-refining"
data.raw.recipe["solid-fuel-from-heavy-oil"].energy_required = 0.5
data.raw.recipe["solid-fuel-from-light-oil"].category = "fuel-refining"
data.raw.recipe["solid-fuel-from-light-oil"].energy_required = 0.5
data.raw.recipe["solid-fuel-from-petroleum-gas"].category = "fuel-refining"
data.raw.recipe["solid-fuel-from-petroleum-gas"].energy_required = 0.5

data.raw.recipe["rocket-fuel"].crafting_machine_tint =
{
  primary = {r = 0.290, g = 0.027, b = 0.000, a = 0.000}, -- #49060000
  secondary = {r = 0.722, g = 0.465, b = 0.190, a = 0.000}, -- #b8763000
  tertiary = {r = 0.870, g = 0.365, b = 0.000, a = 0.000}, -- #dd5d0000
}
data.raw.recipe["rocket-fuel"].category = "fuel-refining"
data.raw.recipe["rocket-fuel"].subgroup = "rocket-intermediate-product"
data.raw.recipe["rocket-fuel"].order = "zz"
data.raw.recipe["rocket-fuel"].energy_required = 1

data:extend({
  {
    type = "recipe",
    name = data_util.mod_prefix .. "liquid-rocket-fuel",
    ingredients = {
      { name = "rocket-fuel", amount = 1 },
    },
    results = {
      {name = data_util.mod_prefix.."liquid-rocket-fuel", type="fluid", amount=data_util.liquid_rocket_fuel_per_solid}
    },
    energy_required = 1,
    enabled = false,
    category = "fuel-refining",
    subgroup = "rocket-intermediate-product",
    order = "zz",
    crafting_machine_tint =
    {
      primary = {r = 0.290, g = 0.027, b = 0.000, a = 0.000}, -- #49060000
      secondary = {r = 0.722, g = 0.465, b = 0.190, a = 0.000}, -- #b8763000
      tertiary = {r = 0.870, g = 0.365, b = 0.000, a = 0.000}, -- #dd5d0000
    }
  },
  {
    type = "recipe",
    name = data_util.mod_prefix .. "vulcanite-rocket-fuel",
    ingredients = {
      { name = data_util.mod_prefix .. "vulcanite-block", amount = 8 },
    },
    results = {
      { name = "rocket-fuel", amount= 1 }
    },
    energy_required = 1,
    enabled = false,
    category = "fuel-refining",
    subgroup = "rocket-intermediate-product",
    order = "zz",
    crafting_machine_tint =
    {
      primary = {r = 0.290, g = 0.027, b = 0.000, a = 0.000}, -- #49060000
      secondary = {r = 0.722, g = 0.465, b = 0.190, a = 0.000}, -- #b8763000
      tertiary = {r = 0.870, g = 0.365, b = 0.000, a = 0.000}, -- #dd5d0000
    },
    allow_as_intermediate = false,
  },
})

data:extend({
  {
    type = "recipe",
    name = data_util.mod_prefix .. "rocket-fuel-from-water-copper",
    ingredients = {
      { type = "fluid", name = "water", amount = 1000 },
      { name = "copper-plate", amount = 1 },
    },
    results = {
      {name = "rocket-fuel", amount = 1 },
      {name = data_util.mod_prefix .. "scrap", probability = 0.1, amount_min = 1, amount_max = 1 },
    },
    icons = data_util.transition_icons(
      {
        icon = data.raw.fluid["water"].icon,
        icon_size = data.raw.fluid["water"].icon_size
      },
      {
        icon = data.raw.item["rocket-fuel"].icon,
        icon_size = data.raw.item["rocket-fuel"].icon_size
      }
    ),
    energy_required = 500,
    enabled = false,
    category = "fuel-refining",
    subgroup = "rocket-intermediate-product",
    order = "zz",
    crafting_machine_tint =
    {
      primary = {r = 0.290, g = 0.027, b = 0.000, a = 0.000}, -- #49060000
      secondary = {r = 0.722, g = 0.465, b = 0.190, a = 0.000}, -- #b8763000
      tertiary = {r = 0.870, g = 0.365, b = 0.000, a = 0.000}, -- #dd5d0000
    }
  },
})
data_util.allow_productivity(data_util.mod_prefix .. "liquid-rocket-fuel")
data_util.allow_productivity(data_util.mod_prefix .. "rocket-fuel-from-water-copper")
data_util.allow_productivity("sand-from-stone")
data_util.allow_productivity("glass-from-sand")
data_util.allow_productivity("sand-to-solid-sand")
data_util.allow_productivity(data_util.mod_prefix .. "heat-shielding")
--data_util.allow_productivity(data_util.mod_prefix .. "rocket-science-pack")
data_util.allow_productivity(data_util.mod_prefix .. "data-storage-substrate")
data_util.allow_productivity(data_util.mod_prefix .. "material-testing-pack")

data_util.disallow_productivity("empty-barrel")
data.raw.recipe["empty-barrel"].normal = nil
data.raw.recipe["empty-barrel"].expensive = nil
data.raw.recipe["empty-barrel"].result = nil
data.raw.recipe["empty-barrel"].ingredients = { { name = "steel-plate", amount = 1 } }
data.raw.recipe["empty-barrel"].results = { { name = "empty-barrel", amount = 1 } }

data_util.allow_productivity({
  data_util.mod_prefix .. "cryonite-crushed",
  data_util.mod_prefix .. "cryonite-washed",
  data_util.mod_prefix .. "cryonite-rod",
  data_util.mod_prefix .. "cryonite-ion-exchange-beads",
  data_util.mod_prefix .. "beryllium-ore-crushed",
  data_util.mod_prefix .. "beryllium-ore-washed",
  data_util.mod_prefix .. "beryllium-sulfate",
  data_util.mod_prefix .. "beryllium-hydroxide",
  data_util.mod_prefix .. "beryllium-powder",
  data_util.mod_prefix .. "beryllium-ingot",
  data_util.mod_prefix .. "beryllium-plate",
  data_util.mod_prefix .. "holmium-ore-crushed",
  data_util.mod_prefix .. "holmium-ore-washed",
  data_util.mod_prefix .. "holmium-powder",
  data_util.mod_prefix .. "holmium-ingot",
  data_util.mod_prefix .. "holmium-plate",
  data_util.mod_prefix .. "iridium-ore-crushed",
  data_util.mod_prefix .. "iridium-ore-washed",
  data_util.mod_prefix .. "iridium-powder",
  data_util.mod_prefix .. "iridium-ingot",
  data_util.mod_prefix .. "iridium-plate",
  data_util.mod_prefix .. "naquium-ore-crushed",
  data_util.mod_prefix .. "naquium-ore-washed",
  data_util.mod_prefix .. "naquium-powder",
  data_util.mod_prefix .. "naquium-ingot",
  data_util.mod_prefix .. "naquium-plate",
  data_util.mod_prefix .. "vitamelange-nugget",
  data_util.mod_prefix .. "vitamelange-roast",
  data_util.mod_prefix .. "vitamelange-spice",
  data_util.mod_prefix .. "vitamelange-extract",
  data_util.mod_prefix .. "vulcanite-crushed",
  data_util.mod_prefix .. "vulcanite-washed",
  data_util.mod_prefix .. "vulcanite-block",
  data_util.mod_prefix .. "vulcanite-ion-exchange-beads",
  data_util.mod_prefix .. "aeroframe-pole",
  data_util.mod_prefix .. "aeroframe-scaffold",
  data_util.mod_prefix .. "aeroframe-bulkhead",
  data_util.mod_prefix .. "lattice-pressure-vessel",
  data_util.mod_prefix .. "heavy-girder",
  data_util.mod_prefix .. "heavy-bearing",
  data_util.mod_prefix .. "heavy-composite",
  data_util.mod_prefix .. "heavy-assembly",
  data_util.mod_prefix .. "vitalic-acid",
  data_util.mod_prefix .. "bioscrubber",
  data_util.mod_prefix .. "vitalic-reagent",
  data_util.mod_prefix .. "vitalic-epoxy",
  data_util.mod_prefix .. "self-sealing-gel",
  data_util.mod_prefix .. "holmium-cable",
  data_util.mod_prefix .. "holmium-solenoid",
  data_util.mod_prefix .. "quantum-processor",
  data_util.mod_prefix .. "dynamic-emitter",
  data_util.mod_prefix .. "iron-smelting-vulcanite",
  data_util.mod_prefix .. "copper-smelting-vulcanite",
  data_util.mod_prefix .. "stone-brick-vulcanite",
  data_util.mod_prefix .. "glass-vulcanite",
  data_util.mod_prefix .. "cryonite-lubricant",
  data_util.mod_prefix .. "low-density-structure-beyllium",
  data_util.mod_prefix .. "heat-shielding-iridium",
  data_util.mod_prefix .. "pulverised-sand",
  data_util.mod_prefix .. "low-density-structure-beryllium",
})
