----------------------------------------------------------------------------------
--	Yellow Extended Mag
----------------------------------------------------------------------------------
local yelExtMag = table.deepcopy(data.raw.ammo["firearm-magazine"])
yelExtMag.name = "yelExtMag"
yelExtMag.magazine_size=30
yelExtMag.icon = "__adrizz-magazines__/graphics/A2.png"

-- Recipe
local recipe = table.deepcopy(data.raw.recipe["firearm-magazine"])
recipe.enabled = true
recipe.name = "yelExtMag"
recipe.ingredients = {{"firearm-magazine",1},{"copper-cable",1},{"iron-plate",2}}
recipe.result = "yelExtMag"
yelExtMag.order = "a[basic-clips]-d[yelExtMag]"
----------------------------------------------------------------------------------
--	Yellow Drum Mag
----------------------------------------------------------------------------------
local yelDrumMag = table.deepcopy(data.raw.ammo["firearm-magazine"])
yelDrumMag.name = "yelDrumMag"
yelDrumMag.magazine_size=50
yelDrumMag.icon = "__adrizz-magazines__/graphics/A3.png"
yelDrumMag.order = "a[basic-clips]-e[yelDrumMag]"

-- Recipe
local yelDrumMagRecipe = table.deepcopy(data.raw.recipe["firearm-magazine"])
yelDrumMagRecipe.enabled = false
yelDrumMagRecipe.name = "yelDrumMag"
yelDrumMagRecipe.ingredients = {{"firearm-magazine",3},{"iron-plate",2},{"copper-cable",2}}
yelDrumMagRecipe.result = "yelDrumMag"
table.insert(data.raw["technology"]["military"].effects, {type = "unlock-recipe", recipe = "yelDrumMag" })

----------------------------------------------------------------------------------
--	Yellow Double Mag
----------------------------------------------------------------------------------
local yelDouble = table.deepcopy(data.raw.ammo["firearm-magazine"])
yelDouble.magazine_size = 100
yelDouble.name = "yelDouble"
yelDouble.icon = "__adrizz-magazines__/graphics/A4.png"
yelDouble.order = "a[basic-clips]-e[yelDouble]"

-- Recipe
local yelDoubleRecipe = table.deepcopy(data.raw.recipe["firearm-magazine"])
yelDoubleRecipe.enabled = false
yelDoubleRecipe.name = "yelDouble"
yelDoubleRecipe.ingredients = {{"firearm-magazine",5},{"iron-plate",5},{"copper-cable",5}}
yelDoubleRecipe.result = "yelDouble"
table.insert(data.raw["technology"]["military"].effects, {type = "unlock-recipe", recipe = "yelDouble" })


----------------------------------------------------------------------------------
--	Prototype data extension
----------------------------------------------------------------------------------
data:extend{yelExtMag,recipe,yelDrumMag,yelDrumMagRecipe,yelDouble,yelDoubleRecipe}