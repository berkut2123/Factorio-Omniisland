local data_util = require("data_util")

local recipe = data.raw.recipe
local tech = data.raw.technology

  --Add various K2 products to the delivery cannon.
se_delivery_cannon_recipes = se_delivery_cannon_recipes or {}

se_delivery_cannon_recipes["mineral-water"] = {name="water-barrel"}
se_delivery_cannon_recipes["biomethanol"] = {name="biomethanol-barrel"}
se_delivery_cannon_recipes["chlorine"] = {name="chlorine-barrel"}
se_delivery_cannon_recipes["dirty-water"] = {name="dirty-water-barrel"}
se_delivery_cannon_recipes["heavy-water"] = {name="heavy-water-barrel"}
se_delivery_cannon_recipes["hydrogen-chloride"] = {name="hydrogen-chloride-barrel"}
se_delivery_cannon_recipes["nitric-acid"] = {name="nitric-acid-barrel"}

se_delivery_cannon_recipes["raw-imersite"] = {name="raw-imersite"}
se_delivery_cannon_recipes["imersite-powder"] = {name="imersite-powder"}
se_delivery_cannon_recipes["imersium-plate"] = {name="imersium-plate"}
se_delivery_cannon_recipes["imersite-crystal"] = {name="imersite-crystal"}
se_delivery_cannon_recipes["coke"] = {name="coke"}
se_delivery_cannon_recipes["quartz"] = {name="quartz"}
se_delivery_cannon_recipes["silicon"] = {name="silicon"}
se_delivery_cannon_recipes["enriched-iron"] = {name="enriched-iron"}
se_delivery_cannon_recipes["enriched-copper"] = {name="enriched-copper"}
se_delivery_cannon_recipes["enriched-rare-metals"] = {name="enriched-rare-metals"}
se_delivery_cannon_recipes["raw-rare-metals"] = {name="raw-rare-metals"}
se_delivery_cannon_recipes["rare-metals"] = {name="rare-metals"}
se_delivery_cannon_recipes["lithium"] = {name="lithium"}
se_delivery_cannon_recipes["lithium-chloride"] = {name="lithium-chloride"}
se_delivery_cannon_recipes["tritium"] = {name="tritium"}
se_delivery_cannon_recipes["fuel"] = {name="fuel"}
se_delivery_cannon_recipes["bio-fuel"] = {name="bio-fuel"}
se_delivery_cannon_recipes["advanced-fuel"] = {name="advanced-fuel"}
se_delivery_cannon_recipes["fertilizer"] = {name="fertilizer"}

table.insert(tech["se-processing-vulcanite"].prerequisites, "kr-enriched-ores")

recipe["se-iron-smelting-vulcanite"].ingredients = {
  {"enriched-iron", 8},
  {"se-vulcanite-block", 1}
}

recipe["se-copper-smelting-vulcanite"].ingredients = {
  {"enriched-copper", 8},
  {"se-vulcanite-block", 1}
}

local rare_metals_vulcanite = table.deepcopy(recipe["se-copper-smelting-vulcanite"])
rare_metals_vulcanite.name = "rare-metals-vulcanite"
rare_metals_vulcanite.ingredients = {
  {"enriched-rare-metals", 8},
  {"se-vulcanite-block", 1}
}
rare_metals_vulcanite.results = {{"rare-metals", 12}}
rare_metals_vulcanite.group = "resources"
rare_metals_vulcanite.subgroup = "raw-material"
recipe["rare-metals-vulcanite"] = rare_metals_vulcanite
table.insert(tech["se-processing-vulcanite"].effects, {type = "unlock-recipe", recipe = "rare-metals-vulcanite"})

local silicon_vulcanite = table.deepcopy(recipe["se-copper-smelting-vulcanite"])
silicon_vulcanite.name = "silicon-vulcanite"
silicon_vulcanite.ingredients = {
  {"quartz", 18},
  {"se-vulcanite-block", 1}
}
silicon_vulcanite.results = {{"silicon", 18}}
recipe["silicon-vulcanite"] = silicon_vulcanite
table.insert(tech["se-processing-vulcanite"].effects, {type = "unlock-recipe", recipe = "silicon-vulcanite"})

recipe["se-stone-brick-vulcanite"].group = "resources"
recipe["se-stone-brick-vulcanite"].subgroup = "raw-material"

data_util.allow_productivity({
  "rare-metals-vulcanite",
  "silicon-vulcanite",
})
