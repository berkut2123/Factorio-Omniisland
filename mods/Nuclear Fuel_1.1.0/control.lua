local function update_recipes()
  if settings.startup["nuclear-fuel-bomb-ingredient"].value == "both" then
    for i,force in pairs(game.forces) do
      if force.technologies["atomic-bomb"].researched then
        force.recipes["atomic-bomb-pu"].enabled = true
      end
    end
  end
end

script.on_configuration_changed(update_recipes)