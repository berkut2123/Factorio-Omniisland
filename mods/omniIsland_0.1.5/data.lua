--data.lua



require("prototypes.recipe")
require("prototypes.item")


for n,v in pairs(data.raw.tile) do
  v.autoplace = nil
end

data.raw['noise-expression']['cliffiness'].expression = {
	expression_id = "literal-number-0",
	type = "literal-number",
	literal_value = 0
}

data.raw.tile['grass-1'].autoplace = {
	sharpness = 0.5,
	max_probability = 0.3,
	peaks = {
		{
			influence = 1.0,
			noise_layer = 'enemy-base',
			noise_octaves_difference = -2.5,
			noise_persistence = 0.2,
		},
		{
			influence = -1,
			starting_area_weight_optimal = 1,
			starting_area_weight_range = 0.001,
			starting_area_weight_max_range = 0.001,
		},
		{
			influence = -1.6
		}
	}
}


data.raw.tile['deepwater'].autoplace = {
  peaks = {
  {
    influence = -0.1,
    starting_area_weight_optimal = 1,
    starting_area_weight_range = 0,
    starting_area_weight_max_range = 0,
    order = "zzzzzzzzzzzz"
  }}
}

-- This tends to prevent the player from spawning far away from 0,0 and getting killed when they spawn on top of water. 
-- I'm not sure of the exact mechanics, but it seems to have something to do with the starting area - if I don't trap
-- on-chunk-generated, it makes a perfect sand circle around 0,0.

data.raw.tile['sand-1'].autoplace = {
  peaks = {{
    influence = 0.1
   }}
}