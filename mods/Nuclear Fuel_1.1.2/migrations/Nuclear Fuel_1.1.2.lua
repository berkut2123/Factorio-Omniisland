-- Reload recipes and technologies
-- for i, player in ipairs(game.players) do
  -- player.force.reset_recipes()
  -- player.force.reset_technologies()
-- end

for index, force in pairs(game.forces) do
  -- Generate technology and recipe tables
  local tech = force.technologies
  local recipes = force.recipes

  -- Kovarex recipe deprecated
  if recipes["kovarex-enrichment-process"] then
    recipes["kovarex-enrichment-process"].enabled = false
  end

  -- Kovarex research is removed, so unlock replacement techs if it's already completed
  if tech["kovarex-enrichment-process"] then
    tech["kovarex-enrichment-process"].enabled = false
    if tech["kovarex-enrichment-process"].researched then
      tech["kovarex-enrichment-process"].researched = false
      if tech["mox-fuel"] then
        tech["mox-fuel"].researched = true
      end
      if tech["nuclear-rocket-fuel"] then
        tech["nuclear-rocket-fuel"].researched = true
      end
    end
  end
end