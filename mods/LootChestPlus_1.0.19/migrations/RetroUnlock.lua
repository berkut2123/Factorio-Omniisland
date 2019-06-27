for _, force in pairs(game.forces) do
  force.reset_recipes()
  force.reset_technologies()

  -- create tech/recipe table once
  local techs = force.technologies
  local recipes = force.recipes
  if techs["logistic-robotics"].researched then
    recipes["artifact-loot-chest"].enabled = true
  end
end