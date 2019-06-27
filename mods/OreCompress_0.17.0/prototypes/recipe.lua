local OreCompressEnergyCost = 4  -- Crafting time
local OreCompressAmount = 20
local CompressedSmeltCost = 3.5 * 4  -- Vanilla time for iron, copper, stone = 3.5 sec
local SmeltRatio = 0.8  -- 1.0 = 100%

local CompressedSmeltAmount = math.floor(OreCompressAmount*SmeltRatio+0.01)

data:extend({
	-- Iron compression
  {
    type = "recipe",
    name = "compress-iron-ore",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"iron-ore", OreCompressAmount}},
    result = "compressed-iron-ore"
  },

  {
    type = "recipe",
    name = "uncompress-iron-ore",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"compressed-iron-ore", 1}},
    result = "iron-ore",
	  result_count = OreCompressAmount
  },
  
  -- Copper compression
  {
    type = "recipe",
    name = "compress-copper-ore",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"copper-ore", OreCompressAmount}},
    result = "compressed-copper-ore"
  },
  
  {
    type = "recipe",
    name = "uncompress-copper-ore",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"compressed-copper-ore", 1}},
    result = "copper-ore",
	  result_count = OreCompressAmount
  },
  
  -- Uranium compression
  {
    type = "recipe",
    name = "compress-uranium-ore",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"uranium-ore", OreCompressAmount}},
    result = "compressed-uranium-ore"
  },
  
  {
    type = "recipe",
    name = "uncompress-uranium-ore",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"compressed-uranium-ore", 1}},
    result = "uranium-ore",
	  result_count = OreCompressAmount
  },
  
  -- Coal compression
  {
    type = "recipe",
    name = "compress-coal",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"coal", OreCompressAmount}},
    result = "compressed-coal"
  },
  
  {
    type = "recipe",
    name = "uncompress-coal",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"compressed-coal", 1}},
    result = "coal",
	  result_count = OreCompressAmount
  },
  
  -- Stone compression
  {
    type = "recipe",
    name = "compress-stone",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"stone", OreCompressAmount}},
    result = "compressed-stone"
  },
  
  {
    type = "recipe",
    name = "uncompress-stone",
    energy_required = OreCompressEnergyCost,
    category = "advanced-crafting",
    enabled = false,
    ingredients = {{"compressed-stone", 1}},
    result = "stone",
	  result_count = OreCompressAmount
  },
  
  -- Smelting recipes
  {
    type = "recipe",
    name = "smelt-compressed-iron-ore",
    energy_required = CompressedSmeltCost,
    category = "smelting",
    enabled = false,
    ingredients = {{"compressed-iron-ore", 1}},
    result = "iron-plate",
    result_count = CompressedSmeltAmount
  },
  
  {
    type = "recipe",
    name = "smelt-compressed-copper-ore",
    energy_required = CompressedSmeltCost,
    category = "smelting",
    enabled = false,
    ingredients = {{"compressed-copper-ore", 1}},
    result = "copper-plate",
    result_count = CompressedSmeltAmount
  },
  
  {
    type = "recipe",
    name = "smelt-compressed-stone",
    energy_required = CompressedSmeltCost,
    category = "smelting",
    enabled = false,
    ingredients = {{"compressed-stone", 1}},
    result = "stone-brick",
    result_count = CompressedSmeltAmount/2 -- 2 stones => 1 stone brick
  }  
})