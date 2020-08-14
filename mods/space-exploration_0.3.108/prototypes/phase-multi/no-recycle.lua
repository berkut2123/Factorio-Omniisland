
-- reverse factory
--table.insert(rf.norecycle_items, "example-recipe")
rf = rf or {}
rf.norecycle_categories = rf.norecycle_categories or {}
rf.norecycle_items = rf.norecycle_items or {}

local function norecycle_category(category)
  if rf and rf.norecycle_categories then
    table.insert(rf.norecycle_categories, category)
  end
end

local function norecycle_recipe(recipe)
  if rf and rf.norecycle_items then
    table.insert(rf.norecycle_items, recipe)
  end
end


norecycle_recipe("se-micro-black-hole-data")

norecycle_category("condenser-turbine")
norecycle_category("core-mining")
norecycle_category("space-accelerator")
norecycle_category("space-astrometrics")
norecycle_category("space-collider")
norecycle_category("space-materialisation")
norecycle_category("space-genetics")
norecycle_category("space-gravimetrics")
norecycle_category("space-growth")
norecycle_category("space-hypercooling")
norecycle_category("space-mechanical")
norecycle_category("space-observation-gammaray")
norecycle_category("space-observation-xray")
norecycle_category("space-observation-uv")
norecycle_category("space-observation-visible")
norecycle_category("space-observation-infrared")
norecycle_category("space-observation-microwave")
norecycle_category("space-observation-radio")
norecycle_category("space-radiator")
norecycle_category("space-radiation")
norecycle_category("space-research")
norecycle_category("space-supercomputing-1")
norecycle_category("space-supercomputing-2")
norecycle_category("space-supercomputing-3")
norecycle_category("space-antimatter-engine")
norecycle_category("space-rocket-engine")
