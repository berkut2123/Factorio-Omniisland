local alc = data.raw["logistic-container"]
local loot_chest_size = settings.startup["loot-chest-size"].value
alc["artifact-loot-chest"].inventory_size = loot_chest_size
