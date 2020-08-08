local data_util = require("data_util")

if data.raw["recipe-category"]["ore-sorting-t1"] then
  table.insert( data.raw["assembling-machine"][data_util.mod_prefix .. "space-mechanical-laboratory"].crafting_categories, "ore-sorting-t1") -- crushing
end

if data.raw["recipe-category"]["ore-sorting"] then
  table.insert( data.raw["assembling-machine"][data_util.mod_prefix .. "space-manufactory"].crafting_categories, "ore-sorting")
end

if data.raw["fluid"]["gas-methane"] then

  data.raw.fluid[data_util.mod_prefix .. "methane-gas"].localised_name = {"fluid-name."..data_util.mod_prefix .."methane-gas-mixed"}
  local results = {
    { type = "fluid", name = "gas-methane", amount = 90},
  }
  if data.raw["fluid"]["gas-natural-1"] then
    table.insert(results, { type = "fluid", name = "gas-natural-1", amount = 10})
  end
  data_util.make_recipe({
    name = data_util.mod_prefix .. "mixed-methane-gas-separation",
    ingredients = {
      { type = "fluid", name = data_util.mod_prefix .. "methane-gas", amount = 10},
    },
    results = results,
    energy_required = 1,
    subgroup = "space-fluids",
    category = "chemistry",
    always_show_made_in = true,
  })
  data_util.tech_lock_recipes(data_util.mod_prefix .. "space-biochemical-laboratory", data_util.mod_prefix .. "mixed-methane-gas-separation")


end
