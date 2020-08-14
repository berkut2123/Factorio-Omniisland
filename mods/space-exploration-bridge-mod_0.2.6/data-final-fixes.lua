-- additional entities for space
if data.raw["furnace"]["angels-flare-stack"] then
  data.raw.furnace["angels-flare-stack"].collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile"}
end

if data.raw["mining-drill"]["thermal-extractor"] then
  data.raw["mining-drill"]["thermal-extractor"].collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile"}
end

if data.raw["storage-tank"]["angels-pressure-tank-1"] then
  data.raw["storage-tank"]["angels-pressure-tank-1"].collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile"}
end

if data.raw["assembling-machine"]["asteroid-miner-placeholder"] then
  data.raw["assembling-machine"]["asteroid-miner-placeholder"].collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile"}
end

-- additional resources for space

-- re-enable asteroid dust source as infinite source for asteroid mining drill
if data.raw["resource"]["asteroid-dust-resource"] then
  data.raw["resource"]["asteroid-dust-resource"].infinite = true
  data.raw["resource"]["asteroid-dust-resource"].minimum = 10
  data.raw["resource"]["asteroid-dust-resource"].normal = 100
  data.raw["resource"]["asteroid-dust-resource"].maximum = 100
  data.raw["resource"]["asteroid-dust-resource"].infinite_depletion_amount = 10
end

-- additional recipes support to allow angel's production/refining/smelting/petrochem/bio-processing in space

-- angel's refining
-------------------
if data.raw["recipe-category"]["ore-sorting-t2"] then
  table.insert(data.raw["assembling-machine"]["se-space-decontamination-facility"].crafting_categories, "ore-sorting-t2")
end

if data.raw["recipe-category"]["ore-sorting-t3"] then
  table.insert(data.raw["assembling-machine"]["se-space-decontamination-facility"].crafting_categories, "ore-sorting-t3")
end

if data.raw["recipe-category"]["ore-sorting-t4"] then
  table.insert(data.raw["assembling-machine"]["se-space-manufactory"].crafting_categories, "ore-sorting-t4")
end

if data.raw["recipe-category"]["ore-sorting-t3-5"] then
  table.insert(data.raw["assembling-machine"]["se-space-decontamination-facility"].crafting_categories, "ore-sorting-t3-5")
end

if data.raw["recipe-category"]["ore-sorting-t1-5"] then
  table.insert(data.raw["assembling-machine"]["se-space-mechanical-laboratory"].crafting_categories, "ore-sorting-t1-5")
end

if data.raw["recipe-category"]["crystallizing"] then
  table.insert(data.raw["assembling-machine"]["se-space-growth-facility"].crafting_categories, "crystallizing")
end

if data.raw["recipe-category"]["water-treatment"] then
  table.insert(data.raw["assembling-machine"]["se-space-decontamination-facility"].crafting_categories, "water-treatment")
end

if data.raw["recipe-category"]["filtering"] then
  table.insert(data.raw["assembling-machine"]["se-space-decontamination-facility"].crafting_categories, "filtering")
end

if data.raw["recipe-category"]["salination-plant"] then
  table.insert(data.raw["assembling-machine"]["se-space-decontamination-facility"].crafting_categories, "salination-plant")
end

if data.raw["recipe-category"]["washing-plant"] then
  table.insert(data.raw["assembling-machine"]["se-space-decontamination-facility"].crafting_categories, "washing-plant")
end

-- angel's smelting
-------------------
if data.raw["recipe-category"]["blast-smelting"] then
  table.insert(data.raw["assembling-machine"]["se-space-thermodynamics-laboratory"].crafting_categories, "blast-smelting")
end

if data.raw["recipe-category"]["casting"] then
  table.insert(data.raw["assembling-machine"]["se-space-thermodynamics-laboratory"].crafting_categories, "casting")
end

if data.raw["recipe-category"]["induction-smelting"] then
  table.insert(data.raw["assembling-machine"]["se-space-thermodynamics-laboratory"].crafting_categories, "induction-smelting")
end

if data.raw["recipe-category"]["sintering"] then
  table.insert(data.raw["assembling-machine"]["se-space-thermodynamics-laboratory"].crafting_categories, "sintering")
end

if data.raw["recipe-category"]["chemical-smelting"] then
  table.insert(data.raw["assembling-machine"]["se-space-thermodynamics-laboratory"].crafting_categories, "chemical-smelting")
end

if data.raw["recipe-category"]["strand-casting"] then
  table.insert(data.raw["assembling-machine"]["se-space-thermodynamics-laboratory"].crafting_categories, "strand-casting")
end

if data.raw["recipe-category"]["ore-processing"] then
  table.insert(data.raw["assembling-machine"]["se-space-mechanical-laboratory"].crafting_categories, "ore-processing")
end

if data.raw["recipe-category"]["pellet-pressing"] then
  table.insert(data.raw["assembling-machine"]["se-space-mechanical-laboratory"].crafting_categories, "pellet-pressing")
end

if data.raw["recipe-category"]["powder-mixing"] then
  table.insert(data.raw["assembling-machine"]["se-space-manufactory"].crafting_categories, "powder-mixing")
end

if data.raw["recipe-category"]["cooling"] then
  table.insert(data.raw["assembling-machine"]["se-space-hypercooler"].crafting_categories, "cooling")
end

-- angel's petrochem
--------------------
if data.raw["recipe-category"]["steam-cracking"] then
  table.insert(data.raw["assembling-machine"]["se-space-biochemical-laboratory"].crafting_categories, "steam-cracking")
end

if data.raw["recipe-category"]["liquifying"] then
  table.insert(data.raw["assembling-machine"]["se-space-biochemical-laboratory"].crafting_categories, "liquifying")
end

if data.raw["recipe-category"]["petrochem-electrolyser"] then
  table.insert(data.raw["assembling-machine"]["se-space-decontamination-facility"].crafting_categories, "petrochem-electrolyser")
end

if data.raw["recipe-category"]["petrochem-separation"] then
  table.insert(data.raw["assembling-machine"]["se-space-biochemical-laboratory"].crafting_categories, "petrochem-separation")
end

if data.raw["recipe-category"]["gas-refining"] then
  table.insert(data.raw["assembling-machine"]["se-space-biochemical-laboratory"].crafting_categories, "gas-refining")
end

if data.raw["recipe-category"]["advanced-chemistry"] then
  table.insert(data.raw["assembling-machine"]["se-space-biochemical-laboratory"].crafting_categories, "advanced-chemistry")
end

if data.raw["recipe-category"]["chemistry"] then
  table.insert(data.raw["assembling-machine"]["se-space-biochemical-laboratory"].crafting_categories, "chemistry")
end


-- angel's bio processing
-------------------------
if data.raw["recipe-category"]["bio-processing"] then
  table.insert(data.raw["assembling-machine"]["se-space-growth-facility"].crafting_categories, "bio-processing")
end