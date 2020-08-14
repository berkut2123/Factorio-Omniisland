local data_util = require("data_util")

if mods["Krastorio2"] then

  data_util.tech_remove_ingredients("kr-imersium-processing", {"matter-tech-card"})
  data_util.tech_remove_prerequisites("kr-imersium-processing", {"kr-matter-tech-card"})
  data_util.tech_add_ingredients("kr-imersium-processing", {"se-rocket-science-pack"})
  data_util.tech_add_prerequisites("kr-imersium-processing", {"se-rocket-science-pack"})

end
