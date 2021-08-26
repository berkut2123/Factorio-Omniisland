local function update_settings()
  for i,force in pairs(game.forces) do
    if settings.startup["nuclear-fuel-bomb-ingredient"].value == "both" then
      if force.technologies["atomic-bomb"].researched then
        
        force.recipes["atomic-bomb-pu"].enabled = true
      end
    end
    if settings.startup["nuclear-fuel-kovarex-enabled"].value then
      force.technologies["kovarex-enrichment-process"].enabled = true
      if force.technologies["kovarex-enrichment-process"].researched then
        force.recipes["kovarex-enrichment-process"].enabled = true
      end
    else
      force.technologies["kovarex-enrichment-process"].enabled = false
      force.recipes["kovarex-enrichment-process"].enabled = false
    end
  end
end

script.on_configuration_changed(update_settings)