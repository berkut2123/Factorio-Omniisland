for index, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  if technologies["military"].researched then
    recipes["yelDrumMag"].enabled = true
	recipes["yelDouble"].enabled = true
	recipes["drum-copper-firearm-magazine"].enabled = true
	recipes["saddle-copper-firearm-magazine"].enabled = true
    recipes["shotgun"].reload()
    recipes["shotgun-shell"].reload()
	recipes["submachine-gun"].reload()
	recipes["yelDrumMag"].reload()
    recipes["yelDouble"].reload()
	recipes["drum-copper-firearm-magazine"].reload()
	recipes["saddle-copper-firearm-magazine"].reload()
  end
  if technologies["military-2"].researched then
    recipes["redExtMag"].enabled = true
	recipes["redDrumMag"].enabled = true
	recipes["redDouble"].enabled = true
	recipes["copper-piercing-rounds-magazine"].enabled = true
	recipes["ext-copper-piercing-rounds-magazine"].enabled = true
	recipes["drum-copper-piercing-rounds-magazine"].enabled = true
	recipes["saddle-copper-piercing-rounds-magazine"].enabled = true
	recipes["redExtMag"].reload()
	recipes["redDrumMag"].reload()
	recipes["redDouble"].reload()
	recipes["copper-piercing-rounds-magazine"].reload()
	recipes["ext-copper-piercing-rounds-magazine"].reload()
	recipes["drum-copper-piercing-rounds-magazine"].reload()
	recipes["saddle-copper-piercing-rounds-magazine"].reload()
	recipes["grenade"].reload()
	recipes["piercing-rounds-magazine"].reload()
  end
  if technologies["uranium-ammo"].researched then
    recipes["ext-uranium-rounds-magazine"].enabled = true
	recipes["drum-uranium-rounds-magazine"].enabled = true
	recipes["saddle-uranium-rounds-magazine"].enabled = true
	recipes["copper-uranium-magazine"].enabled = true
	recipes["ext-copper-uranium-magazine"].enabled = true
	recipes["drum-copper-uranium-magazine"].enabled = true
	recipes["saddle-copper-uranium-magazine"].enabled = true
	recipes["ext-uranium-rounds-magazine"].reload()
	recipes["drum-uranium-rounds-magazine"].reload()
	recipes["saddle-uranium-rounds-magazine"].reload()
	recipes["copper-uranium-magazine"].reload()
	recipes["ext-copper-uranium-magazine"].reload()
	recipes["drum-copper-uranium-magazine"].reload()
	recipes["saddle-copper-uranium-magazine"].reload()
	recipes["explosive-uranium-cannon-shell"].reload()
	recipes["uranium-cannon-shell"].reload()
	recipes["uranium-rounds-magazine"].reload()
  end

end