local data_util = require("data_util")

if mods["Krastorio2"] then

  require("prototypes/phase-2/compatibility/krastorio2/matter")
  require("prototypes/phase-2/compatibility/krastorio2/resources")
  require("prototypes/phase-2/compatibility/krastorio2/recipes")

  -- temporarilty remove space-science-pack from any non-k2 techs.
  -- after the procedural stop later add it back again, if it is at a certain complexity
  for _, tech in pairs(data.raw.technology) do
    if tech.mod ~= "Krastorio2" then
      data_util.tech_remove_ingredients(tech.name, {"space-science-pack"})
      data_util.tech_remove_prerequisites(tech.name, {"space-science-pack"})
      tech.space_science_pack_removed = true
    end
  end


end
