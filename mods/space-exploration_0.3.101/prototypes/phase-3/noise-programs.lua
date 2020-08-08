local noise = require("noise")
local util = require("util")
local tne = noise.to_noise_expression
local data_util = require("data_util")

local function scaled_noise_layer_expression(scale)
  return noise.function_application("factorio-multioctave-noise",
    {
      x = noise.var("x") / scale,
      y = noise.var("y") / scale,
      persistence = 0.7,
      seed0 = noise.var("map_seed"),
      seed1 = 1,
      input_scale = noise.fraction(1, 6),
      output_scale = 1,
      octaves = 4,
    }
  )
end

local function make_basis_noise_function(seed0,seed1,outscale0,inscale0)
  outscale0 = outscale0 or 1
  inscale0 = inscale0 or 1/outscale0
  return function(x,y,inscale,outscale)
    return tne
    {
      type = "function-application",
      function_name = "factorio-basis-noise",
      arguments =
      {
        x = tne(x),
        y = tne(y),
        seed0 = tne(seed0),
        seed1 = tne(seed1),
        input_scale = tne((inscale or 1) * inscale0),
        output_scale = tne((outscale or 1) * outscale0)
      }
    }
  end
end

local function make_multioctave_noise_function(seed0,seed1,octaves,octave_output_scale_multiplier,octave_input_scale_multiplier,output_scale0,input_scale0)
  octave_output_scale_multiplier = octave_output_scale_multiplier or 2
  octave_input_scale_multiplier = octave_input_scale_multiplier or 1 / octave_output_scale_multiplier
  return function(x,y,inscale,outscale)
    return tne{
      type = "function-application",
      function_name = "factorio-multioctave-noise",
      arguments = {
        x = tne(x),
        y = tne(y),
        seed0 = tne(seed0),
        seed1 = tne(seed1),
        input_scale = tne((inscale or 1) * (input_scale0 or 1)),
        output_scale = tne((outscale or 1) * (output_scale0 or 1)),
        octaves = tne(octaves),
        octave_output_scale_multiplier = tne(octave_output_scale_multiplier),
        octave_input_scale_multiplier = tne(octave_input_scale_multiplier),
      }
    }
  end
end

local function make_split_multioctave_noise_function(seed0,seed1,octaveses,octave_output_scale_multiplier,octave_input_scale_multiplier,output_scale0,input_scale0)
  output_scale0 = output_scale0 or 1
  input_scale0 = input_scale0 or 1
  octave_output_scale_multiplier = octave_output_scale_multiplier or 1
  octave_input_scale_multiplier = octave_input_scale_multiplier or 1
  local funx = {}
  for i=1,#octaveses do
    funx[i] = make_multioctave_noise_function(seed0,seed1,octaveses[i],octave_output_scale_multiplier,octave_input_scale_multiplier,output_scale0,input_scale0)
    output_scale0 = output_scale0 * octave_output_scale_multiplier ^ octaveses[i]
    input_scale0  = input_scale0  * octave_input_scale_multiplier  ^ octaveses[i]
  end
  return funx
end

local function peak_to_noise_expression(variable, optimal, range)
  local distance_from_optimal = noise.ridge(variable - optimal, 0, math.huge)
  -- Idea is to have a plateau in the center of the rectangle,
  -- edges that taper off at a consistent slope for all rectangles (so that interactions between rectangles are predictable),
  return range - distance_from_optimal
end

local function rectangle_peak_to_noise_expression(variable, optimal, range)
  -- Clamp rectangle-based peaks so that large rectangles don't become
  -- super powerful at their centers, because we want to be able to override
  -- them e.g. with beach peaks or whatever
  return noise.min(peak_to_noise_expression(variable, optimal, range) * 20, 1)
end

-- restrict planet size by placing out-of-map tiles at a certain radius from the center.
-- elevation is not required, put the expression on out-of-map

data:extend({
  {
    type = "autoplace-control",
    name = "planet-size",
    order = "z-z",
    category = "terrain",
    richness = true,
  },
  {
    type = "noise-expression",
    name = "control-setting:planet-size:frequency:multiplier",
    expression = noise.to_noise_expression(1)
  },
  {
    type = "noise-expression",
    name = "control-setting:planet-size:size:multiplier",
    expression = noise.to_noise_expression(1)
  },
  {
    type = "noise-expression",
    name = "vault-land-probability",
    expression = 2 + noise.max(0, 20 - noise.var("distance")) - noise.var("distance")/30 - noise.absolute_value(scaled_noise_layer_expression(2))
  },
  {
    type = "autoplace-control",
    name = data_util.mod_prefix.."cryonite",
    order = "r-c-a",
    category = "resource",
    richness = true,
    hidden = true,
    enabled = false
  },
  {
    type = "autoplace-control",
    name = data_util.mod_prefix.."vulcanite",
    order = "r-c-b",
    category = "resource",
    richness = true,
    hidden = true,
    enabled = false
  },
  {
    type = "autoplace-control",
    name = data_util.mod_prefix.."vitamelange",
    order = "r-c-c",
    category = "resource",
    richness = true,
    hidden = true,
    enabled = false
  },
  {
    type = "autoplace-control",
    name = data_util.mod_prefix.."beryllium-ore",
    order = "r-c-d",
    category = "resource",
    richness = true,
    hidden = true,
    enabled = false
  },
  {
    type = "autoplace-control",
    name = data_util.mod_prefix.."holmium-ore",
    order = "r-c-e",
    category = "resource",
    richness = true,
    hidden = true,
    enabled = false
  },
  {
    type = "autoplace-control",
    name = data_util.mod_prefix.."iridium-ore",
    order = "r-c-f",
    category = "resource",
    richness = true,
    hidden = true,
    enabled = false
  },
  {
    type = "autoplace-control",
    name = data_util.mod_prefix.."water-ice",
    order = "r-s-a",
    category = "resource",
    richness = true,
    hidden = true,
    enabled = false
  },
  {
    type = "autoplace-control",
    name = data_util.mod_prefix.."methane-ice",
    order = "r-s-b",
    category = "resource",
    richness = true,
    hidden = true,
    enabled = false
  },
  {
    type = "autoplace-control",
    name = data_util.mod_prefix.."naquium-ore",
    order = "r-s-c",
    category = "resource",
    richness = true,
    hidden = true,
    enabled = false
  },
})

-- biggest planet size is 10000 at max(600%)
-- planet_radius = 10000 / 6 * (6 + log(1/planet_frequency/6, 2))
-- planet_frequency = 1 / 6 / 2 ^ (planet_radius * 6 / 10000 - 6)
data.raw.tile["out-of-map"].autoplace = {
  probability_expression = 10000 * (noise.distance_from(
    noise.var("x"),
    noise.var("y"),
    --noise.make_point_list({{0,0}})) - 10000 / 6 / noise.var("control-setting:planet-size:frequency:multiplier"))
    -- increase number, decrease multiplier, smaller planet
    -- smaller scale should have mneat bigger frequency, so smaller planet
     -- that worked, so if it actually frequency.

    noise.make_point_list({{0,0}})) - 10000 / 6 * (6 + noise.log2(1/noise.var("control-setting:planet-size:frequency:multiplier")/6)))
}

-- add the fallback land
data.raw.tile[data_util.mod_prefix.."regolith"].autoplace = {
  probability_expression = noise.to_noise_expression(-10000)
}

-- space in space: --(1000 - 100) * 10000 = 9,000,00
-- otherwise -100 * 10000 = -1,000,00
data.raw.tile[data_util.mod_prefix.."space"].autoplace = {
  probability_expression = (1 / noise.var("control-setting:planet-size:frequency:multiplier") - 100) * 1000
}

-- asteroids are mainly in asteroid belts and asteroid fields
-- asteroid belts have a band around X
-- asteroid fields are all over
--[[
noise.get_control_setting("planet-size").size_multiplier sets the width of the asteroid belt
asteroid field = 10000 width
asteroid belt = 200 width
planet ring is zone.parent.radius / 200
Sun is 50
spaceship is 1 <- this need to not be here
]]--
data.raw.tile[data_util.mod_prefix.."asteroid"].autoplace = {
  probability_expression = (1 / noise.var("control-setting:planet-size:frequency:multiplier") - 100) * 1000
  - 1
  + noise.max(-25, noise.min(0, noise.get_control_setting("planet-size").size_multiplier - 25)) -- Anything below 25 starts to disappear
  + (noise.min(noise.var("y") / noise.get_control_setting("planet-size").size_multiplier, 0 - noise.var("y") / noise.get_control_setting("planet-size").size_multiplier) -- this is the ridge
    --+ 0.25 * rectangle_peak_to_noise_expression(noise.var("y"), tne(0), noise.get_control_setting("planet-size").size_multiplier)
    + noise.max(scaled_noise_layer_expression(5), 0 -scaled_noise_layer_expression(5))) -- billows
}

-- we do need noise for asteroid spawning in space
-- unless that is all scripted
