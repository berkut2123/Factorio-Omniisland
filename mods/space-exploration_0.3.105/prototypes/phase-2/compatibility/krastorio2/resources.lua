local data_util = require("data_util")

-- vanilla resource changed. Need more uranium.
se_resources["uranium-ore"] = se_resources["uranium-ore"] or {
  order = "c-d",
  has_starting_area_placement = false,
  base_density = 5,
  base_spots_per_km2 = 8,
  random_spot_size_minimum = 5,
  random_spot_size_maximum = 10
}

-- Krastorio 2 resources
se_resources["rare-metals"] = {order = "c-c", has_starting_area_placement = false, base_density = 8, starting_rq_factor_multiplier = 1.5}
se_resources["mineral-water"] = {
  order = "e-b",
  has_starting_area_placement = false,
  base_density = 8,
  base_spots_per_km2 = 2,
  random_probability = 1/48,
  random_spot_size_minimum = 1,
  random_spot_size_maximum = 1, -- don't randomize spot size
  additional_richness = 120000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
  regular_rq_factor_multiplier = 1,
  starting_rq_factor_multiplier = 1
}
se_resources["imersite"] = {
  order = "e-c",
  has_starting_area_placement = false,
  base_density = 1,
  base_spots_per_km2 = 0.05,
  random_spot_size_minimum = 0.01,
  random_spot_size_maximum = 0.1,
  additional_richness = 250000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
  regular_rq_factor_multiplier = 1,
  starting_rq_factor_multiplier = 1
}

se_core_fragment_resources["raw-imersite"] = { multiplier = 0.5, omni_multiplier = 0}
se_core_fragment_resources["mineral-water"] = { multiplier = 1, omni_multiplier = 0}

-- more uranium in fragments
se_core_fragment_resources["uranium-ore"] = se_core_fragment_resources["uranium-ore"] or { multiplier = 0.5, omni_multiplier = 0.02}
