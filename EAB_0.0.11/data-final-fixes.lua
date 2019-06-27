local item = data.raw.item
local recipe = data.raw.recipe
local technology = data.raw.technology

local lib_tech = bobmods.lib.tech

local function renable_technology(tech)
  if type(tech) == "table" then
    for tk, techk in pairs(tech) do
      data.raw.technology[techk].enabled = true
    end
  else
    data.raw.technology[tech].enabled = true
  end
end

if mods["ShinyIcons"] and mods["ShinyBobGFX"] then
  if settings.startup["add-powerbars"].value == true then
    item["assembling-machine-7"].icon = nil
    item["assembling-machine-7"].icons = {
      {icon = "__EAB__/graphics/icons/assembling-machine-7.png"},
      {icon = "__EAB__/graphics/icons/num-6.png"}
    }
    item["electronics-machine-4"].icon = nil
    item["electronics-machine-4"].icons = {
      {icon = "__EAB__/graphics/icons/electronics-machine-4.png"},
      {icon = "__EAB__/graphics/icons/num-6.png"}
    }
  end
end

renable_technology({"angels-platinum-smelting-1", "angels-platinum-smelting-2", "angels-platinum-smelting-3"})

-- data.raw.technology["angels-platinum-smelting-1"].enabled = true

lib_tech.add_prerequisite("angels-platinum-smelting-1", "ore-processing-2")
technology["angels-platinum-smelting-1"].unit = {
  count = 200,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"production-science-pack", 1},
    {"utility-science-pack", 1}
  },
  time = 60
}
recipe["platinum-ore-smelting"].results[1].amount = 8
recipe["molten-platinum-smelting"].results[1].amount_min = 60
recipe["molten-platinum-smelting"].results[1].amount_max = 60
recipe["angels-plate-platinum"].normal.results[1].amount = 2
recipe["angels-plate-platinum"].expensive.results[1].amount = 2

technology["angels-platinum-smelting-2"].unit = {
  count = 200,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"production-science-pack", 1},
    {"utility-science-pack", 1},
    {"space-science-pack", 1}
  },
  time = 60
}
recipe["processed-platinum-smelting"].results[1].amount = 12

technology["angels-platinum-smelting-2"].unit = {
  count = 250,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"production-science-pack", 1},
    {"utility-science-pack", 1},
    {"space-science-pack", 1}
  },
  time = 60
}
recipe["solid-ammonium-chloroplatinate-smelting"].results[1].amount = 16

if mods["Clowns-AngelBob-Nuclear"] then
  item["superradiothermal-fuel"].fuel_acceleration_multiplier = 1.25
  item["superradiothermal-fuel"].fuel_top_speed_multiplier = 1.2
  item["ultraradiothermal-fuel"].fuel_acceleration_multiplier = 1.5
  item["ultraradiothermal-fuel"].fuel_top_speed_multiplier = 1.5
end

if mods["Clowns-Processing"] then
  recipe["platinum-pure-processing"].normal.results[1].amount = 4
  recipe["platinum-pure-processing"].expensive.results[1].amount = 4
end

if mods["ShinyIcons"] then
  item["assembling-machine-7"].subgroup = "shinyassem1"
  item["electronics-machine-4"].subgroup = "shinyassem3"
  recipe["assembling-machine-7"].subgroup = "shinyassem1"
  recipe["electronics-machine-4"].subgroup = "shinyassem3"
end
