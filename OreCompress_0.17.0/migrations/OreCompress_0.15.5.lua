for _, force in pairs(game.forces) do
  if force.technologies["orecompresstech"].researched then
    local recipes = force.recipes
    recipes["smelt-compressed-iron-ore"].enabled = true
    recipes["smelt-compressed-copper-ore"].enabled = true
    recipes["smelt-compressed-stone"].enabled = true
    recipes["iron-plate"].reload()
    recipes["copper-plate"].reload()
    recipes["stone-brick"].reload()
  end
end