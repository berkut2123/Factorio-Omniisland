----------------------------------------------------------------------------------
--	Red Extended Mag
----------------------------------------------------------------------------------
local redExtMag = table.deepcopy(data.raw.ammo["piercing-rounds-magazine"])
redExtMag.name = "redExtMag"
redExtMag.magazine_size=30

-- Recipe
local redExtMagRecipe = table.deepcopy(data.raw.recipe["piercing-rounds-magazine"])
redExtMagRecipe.enabled = false
redExtMagRecipe.name = "redExtMag"
redExtMagRecipe.ingredients = {{"piercing-rounds-magazine",1},{"copper-cable",1},{"iron-plate",2}}
redExtMagRecipe.result = "redExtMag"
table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe", recipe = "redExtMag" })
redExtMag.icon = "__adrizz-magazines__/graphics/P2.png"
redExtMag.order = "a[basic-clips]-f[redExtMag]"
----------------------------------------------------------------------------------
--	Red Drum Mag
----------------------------------------------------------------------------------
local redDrumMag = table.deepcopy(data.raw.ammo["piercing-rounds-magazine"])
redDrumMag.name = "redDrumMag"
redDrumMag.magazine_size=50
redDrumMag.icon = "__adrizz-magazines__/graphics/P3.png"
redDrumMag.order = "a[basic-clips]-g[redDrumMag]"
-- Recipe
local redDrumMagRecipe = table.deepcopy(data.raw.recipe["piercing-rounds-magazine"])
redDrumMagRecipe.enabled = false
redDrumMagRecipe.name = "redDrumMag"
redDrumMagRecipe.ingredients = {{"piercing-rounds-magazine",3},{"iron-plate",2},{"copper-cable",2}}
redDrumMagRecipe.result = "redDrumMag"
table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe", recipe = "redDrumMag" })

----------------------------------------------------------------------------------
--	Red Double Mag
----------------------------------------------------------------------------------
local redDouble = table.deepcopy(data.raw.ammo["piercing-rounds-magazine"])
redDouble.magazine_size = 100
redDouble.name = "redDouble"
redDouble.icon = "__adrizz-magazines__/graphics/P4.png"
redDouble.order = "a[basic-clips]-h[redDouble]"
-- Recipe
local redDoubleRecipe = table.deepcopy(data.raw.recipe["piercing-rounds-magazine"])
redDoubleRecipe.enabled = false
redDoubleRecipe.name = "redDouble"
redDoubleRecipe.ingredients = {{"piercing-rounds-magazine",5},{"iron-plate",5},{"copper-cable",5}}
redDoubleRecipe.result = "redDouble"
table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe", recipe = "redDouble" })


----------------------------------------------------------------------------------
--	Prototype data extension
----------------------------------------------------------------------------------
data:extend{redExtMag,redExtMagRecipe,redDrumMag,redDrumMagRecipe,redDouble,redDoubleRecipe}