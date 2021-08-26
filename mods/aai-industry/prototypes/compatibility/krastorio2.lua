local data_util = require("data-util")

if mods["Krastorio2"] then
  data.raw.technology["basic-logistics"].prerequisites = {}
  data.raw.technology["basic-logistics"].unit.ingredients = {{"basic-tech-card", 1}}
  data.raw.recipe["automation-science-pack"].category = "basic-crafting"
  data.raw.recipe["blank-tech-card"].category = "basic-crafting"
  table.insert(data.raw.technology["automation-science-pack"].prerequisites, "basic-automation")

  function k2_aai_industry_compatibility()

    -- balance electronic circuit recipes
    data_util.replace_or_add_ingredient("electronic-circuit", "copper-cable", "copper-cable", 3)
    data_util.replace_or_add_ingredient("electronic-circuit", "wood", "wood", 3)
    data_util.recipe_set_time("electronic-circuit", data.raw.recipe["electronic-circuit-stone"].energy_required)

    local r = data.raw.recipe["electronic-circuit"]
    r.result = "electronic-circuit" r.result_count = 1 r.results = nil
    if r.normal then r.normal.result = "electronic-circuit" r.normal.result_count = 1 r.normal.results = nil end
    if r.expensive then r.expensive.result = "electronic-circuit" r.expensive.result_count = 1 r.expensive.results = nil end

    -- fix fuel categories
    data_util.add_fuel_category(data.raw["burner-generator"]["burner-turbine"].burner, "vehicle-fuel")
    data_util.add_fuel_category(data.raw["assembling-machine"]["burner-assembling-machine"].energy_source, "vehicle-fuel")
    data_util.add_fuel_category(data.raw["lab"]["burner-lab"].energy_source, "vehicle-fuel")

    local fuel = data.raw.item["processed-fuel"]
    if fuel then
      if krastorio.general.getSafeSettingValue("kr-rebalance-fuels") then
      	fuel.acceleration_multiplier = 1.0
      	fuel.top_speed_multiplier = 0.9
      else
      	fuel.fuel_acceleration_multiplier = 1.2
      	fuel.fuel_top_speed_multiplier = 1.05
      end
    end

    -- Compensate for the processed fuel exploit. Alternative could be to reduce wood flue value.
    -- 40 * 2MJ * 1.1 = in 60s. = 1466 kW
    -- 20 * 2MJ * 1.1 = in 120s. = 366 kW
    -- can get even more energy value with coke recipe.
    -- changes make player choose between energy production at the cost of stone, or free wood but much larger footprint.
    local sand_wood = table.deepcopy(data.raw.recipe["kr-grow-wood-with-water"])
    sand_wood.name = "kr-grow-wood-with-sand"
    data:extend({sand_wood})
    data_util.replace_or_add_ingredient("kr-grow-wood-with-sand", "sand", "sand", 10)
    data_util.recipe_set_result_count("kr-grow-wood-with-sand", 40)
    data_util.recipe_set_time("kr-grow-wood-with-sand", 60)
    data_util.replace_or_add_ingredient("kr-grow-wood-with-sand", "water", "water", 200, true)
    data_util.tech_lock_recipes("kr-greenhouse", "kr-grow-wood-with-sand")

    data_util.recipe_set_result_count("kr-grow-wood-with-water", 20)
    data_util.recipe_set_time("kr-grow-wood-with-water", 120)
    data_util.replace_or_add_ingredient("kr-grow-wood-with-water", "water", "water", 800, true)

    data_util.recipe_set_result_count("kr-grow-wood-plus", 80)
    data_util.recipe_set_time("kr-grow-wood-plus", 60)
    data_util.replace_or_add_ingredient("kr-grow-wood-plus", "water", "water", 400, true)
    data_util.replace_or_add_ingredient("kr-grow-wood-plus", "sand", "sand", 5)

    if krastorio.general.getSafeSettingValue("kr-rebalance-fuels") then
      data.raw["assembling-machine"]["kr-greenhouse"].energy_usage = "200KW" -- still positive energy but much slower.
    else
      data.raw["assembling-machine"]["kr-greenhouse"].energy_usage = "350KW" -- still positive energy but much slower.
    end
    data_util.recipe_set_result_count("fertilizer", 5)

    for i = 0, 9 do
      data_util.recipe_set_result_count("tree-0"..i, 1)
    end

    -- need to use assembler (makes burner assembler required to be used at least once)
    local recipes = {"blank-tech-card", "biters-research-data", "matter-research-data", "matter-research-data", "space-research-data",
      "automation-science-pack", "logistic-science-pack", "military-science-pack", "chemical-science-pack", "production-science-pack", "utility-science-pack"}
    for _, recipe_name in pairs(recipes) do
      local recipe = data.raw.recipe[recipe_name]
      if recipe then
        if recipe.category == "crafting" or recipe.category == nil then
          recipe.category = "basic-crafting"
        end
        recipe.always_show_made_in = true
      end
    end

    data_util.techs_add_ingredients({"kr-basic-fluid-handling", "kr-steam-engine", "automation"}, {"automation-science-pack"}, false)
    data_util.tech_remove_ingredients("gun-turret", {"automation-science-pack"})
    data_util.tech_remove_prerequisites ("gun-turret", {"automation-science-pack"})

  end

end
