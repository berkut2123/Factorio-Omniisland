local data_util = require("data_util")

-- NOTE: space- prefix categories should ONLY be available in space
-- otherwise add a non-prefixed version
local crafting_categories = {
  "condenser-turbine",
  "big-turbine",
  "delivery-cannon",
  "fixed-recipe", -- generic group for anything with a fixed recipe, not chosen by player
  "fuel-refining",
  "core-fragment-processing",
  "lifesupport", -- same as "space-lifesupport" but can be on land
  "pulverising",
  "hard-recycling", -- no conflict with "recycling"
  "hand-hard-recycling", -- no conflict with "recycling"
  "space-accelerator",
  "space-astrometrics",
  "space-biochemical",
  "space-collider",
  "space-crafting", -- same as basic assembling but only in space
  "space-decontamination",
  "space-electromagnetics",
  "space-materialisation",
  "space-genetics",
  "space-gravimetrics",
  "space-growth",
  "space-hypercooling",
  "space-laser",
  "space-lifesupport", -- same as "lifesupport" but can only be in space
  "space-manufacturing",
  "space-mechanical",
  "space-observation-gammaray",
  "space-observation-xray",
  "space-observation-uv",
  "space-observation-visible",
  "space-observation-infrared",
  "space-observation-microwave",
  "space-observation-radio",
  "space-plasma",
  "space-radiation",
  "space-radiator",
  "space-hard-recycling", -- no conflict with "recycling"
  "space-research",
  "space-spectrometry",
  "space-supercomputing-1",
  "space-supercomputing-2",
  "space-supercomputing-3",
  "space-thermodynamics",
  "spaceship-console",
  "spaceship-antimatter-engine",
  "spaceship-rocket-engine",
  "pressure-washing",
  "dummy",
  "no-category" -- has no recipes
}
for _, name in pairs(crafting_categories) do
  data:extend({
    { type = "recipe-category", name = name },
    {
      type = "item-subgroup",
      name = name,
      group = "intermediate-products", --group = "space",
      order = "z-b-"..name
    },
  })
end
-- table.insert(data.raw.character.character.crafting_categories, "lifesupport") -- too many fluid recipes
data:extend({
  {
    type = "fuel-category",
    name = "antimatter"
  },
  {
    type = "resource-category",
    name = data_util.mod_prefix .. "core-mining",
  }
})


for _, tech in pairs(data.raw.technology) do
  if tech.effects then
    for _, effect in pairs(tech.effects) do
      if (effect.type == "ammo-damage" or effect.type == "gun-speed") and effect.ammo_category == "bullet" then
        local c = table.deepcopy(effect)
        c.ammo_category = "railgun"
        table.insert(tech.effects, c)
      end
    end
  end
end
