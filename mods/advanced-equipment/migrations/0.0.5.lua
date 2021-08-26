for index, force in pairs(game.forces) do
    force.reset_recipes()
    force.reset_technologies()

    local technologies = force.technologies
    local recipes = force.recipes

        technologies["power-armor-mk3"].researched = recipes["power-armor-mk3"].enabled
        technologies["fusion-reactor-mk2-equipment"].researched = recipes["fusion-reactor-mk2-equipment"].enabled
        technologies["battery-mk3-equipment"].researched = recipes["battery-mk3-equipment"].enabled
        technologies["energy-shield-mk3-equipment"].researched = recipes["energy-shield-mk3-equipment"].enabled
end
