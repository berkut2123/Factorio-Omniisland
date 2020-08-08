local noise = require("noise")
local tne = noise.to_noise_expression

local function make_basis_noise_function(seed0,seed1,outscale0,inscale0)
  outscale0 = outscale0 or 1
  inscale0 = inscale0 or 1/outscale0
  return function(x,y,inscale,outscale)
    return tne{
      type = "function-application",
      function_name = "factorio-basis-noise",
      arguments = {
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

-- Returns a multioctave noise function where each octave's noise is multiplied by some other noise
-- by default 'some other noise' is the basis noise at 17x lower frequency,
-- normalized around 0.5 and clamped between 0 and 1
local function make_multioctave_modulated_noise_function(params)
  local seed0 = params.seed0 or 1
  local seed1 = params.seed1 or 1
  local octave_count = params.octave_count or 1
  local octave0_output_scale = params.octave0_output_scale or 1
  local octave0_input_scale = params.octave0_input_scale or 1
  local octave_output_scale_multiplier = params.octave_output_scale_multiplier or 2
  local octave_input_scale_multiplier = params.octave_input_scale_multiplier or 1/2
  local basis_noise_function = params.basis_noise_function or make_basis_noise_function(seed0, seed1)
  local modulation_noise_function = params.modulation_noise_function or function(x,y)
    return noise.clamp(basis_noise_function(x,y)+0.5, 0, 1)
  end
  -- input scale of modulation relative to each octave's base input scale
  local mris = params.modulation_relative_input_scale or 1/17

  return function(x,y)
    local outscale = octave0_output_scale
    local inscale = octave0_input_scale
    local result = 0

    for i=1,octave_count do
      local noise = basis_noise_function(x*inscale, y*inscale)
      local modulation = modulation_noise_function(x*(inscale*mris), y*(inscale*mris))
      result = result + (outscale * noise * modulation)

      outscale = outscale * octave_output_scale_multiplier
      inscale = inscale * octave_input_scale_multiplier
    end

    return result
  end
end

local function make_multioctave_noise_function(seed0,seed1,octaves,octave_output_scale_multiplier,octave_input_scale_multiplier,output_scale0,input_scale0)
  octave_output_scale_multiplier = octave_output_scale_multiplier or 2
  octave_input_scale_multiplier = octave_input_scale_multiplier or 1 / octave_output_scale_multiplier
  return function(x,y,inscale,outscale)
    return tne{
      type = "function-application",
      function_name = "factorio-quick-multioctave-noise",
      arguments =
      {
        x = tne(x),
        y = tne(y),
        seed0 = tne(seed0),
        seed1 = tne(seed1),
        input_scale = tne((inscale or 1) * (input_scale0 or 1)),
        output_scale = tne((outscale or 1) * (output_scale0 or 1)),
        octaves = tne(octaves),
        octave_output_scale_multiplier = tne(octave_output_scale_multiplier),
        octave_input_scale_multiplier = tne(octave_input_scale_multiplier)
      }
    }
  end
end

-- Inputs to multi-octave noise to replicate 0.15 terrain
-- (ignoring that it won't match due to shifting having changed)
-- Roughness scale=0.125000, seed=9, amplitude=0.325000
-- Elevation scale=0.500000, seed=8, amplitude=6000.000000

-- TODO: Use actual noise layer indexes for seeds instead of hard-coding

local function clamp_moisture(raw_moisture)
  return noise.clamp(raw_moisture, 0, 1)
end

local function clamp_temperature(raw_temperature)
  return noise.clamp(raw_temperature, -20, 150)
end

local function clamp_aux(raw_aux)
  return noise.clamp(raw_aux, 0, 1)
end

local average_sea_level_temperature = 15
local elevation_temperature_gradient = 0 -- -0.5 might be a good value to start with if you want to try correlating temperature with elevation

data:extend({
  {
    type = "autoplace-control",
    name = "hot",
    order = "z-a",
    category = "terrain",
    richness = true,
  },
  {
    type = "noise-expression",
    name = "control-setting:hot:frequency:multiplier",
    expression = noise.to_noise_expression(1)
  },
  {
    type = "noise-expression",
    name = "control-setting:hot:bias",
    expression = noise.to_noise_expression(0)
  },
  {
    type = "autoplace-control",
    name = "cold",
    order = "z-b",
    category = "terrain",
    richness = true,
  },
  {
    type = "noise-expression",
    name = "control-setting:cold:frequency:multiplier",
    expression = noise.to_noise_expression(1)
  },
  {
    type = "noise-expression",
    name = "control-setting:cold:bias",
    expression = noise.to_noise_expression(0)
  },
})

data:extend({
  {
    type = "noise-expression",
    name = "temperature",
    intended_property = "temperature",
    expression = noise.define_noise_function( function(x,y,tile,map)

      -- values range from 0 to 6
      local cold = noise.get_control_setting("cold").size_multiplier -- 0-6
      local hot = noise.get_control_setting("hot").size_multiplier -- 0-6

      -- make base noise with the frequencey half of the average of the hot and cold scale
      local base_x = x * (noise.var("control-setting:cold:frequency:multiplier") + noise.var("control-setting:hot:frequency:multiplier")) / 2
      local base_y = y * (noise.var("control-setting:cold:frequency:multiplier") + noise.var("control-setting:hot:frequency:multiplier")) / 2 + 40000

      local average = 50 - 125 * cold / 6 + 125 * hot / 6 -- -5 to 150
      local range = 50 * (noise.clamp(cold, 0, 1) / 2 + cold / 10) + 50 * (noise.clamp(hot, 0, 1) / 2 + hot / 10)
      --(seed0,seed1,octaves,octave_output_scale_multiplier = 2,octave_input_scale_multiplier = 1/2,output_scale0 = 1,input_scale0 = 1)
      local base = average + range * noise.clamp(0.25 * make_multioctave_noise_function(map.seed, 5,
        11, -- octaves
        1.4, -- octave_output_scale_multiplier
        0.5, -- octave_input_scale_multiplier
        1, -- output_scale0
        1 -- input_scale0
      )(base_x,base_y,1/32,1/20), -1, 1)

      -- add additional hot and cold spots with their own scales

      local hot_x = x * noise.var("control-setting:hot:frequency:multiplier") + 40000
      local hot_y = y * noise.var("control-setting:hot:frequency:multiplier")
      local hotspots  = (noise.clamp(hot,  0, 1) / 2 + hot  / 10) * 40 * noise.clamp(-0.45 + hot /6
        + make_multioctave_noise_function(map.seed, 5, 10, 1.5, 0.5)(hot_x,hot_y,1/8,1/20), 0, 4)

      local cold_x = x * noise.var("control-setting:cold:frequency:multiplier") - 40000
      local cold_y = y * noise.var("control-setting:cold:frequency:multiplier")
      local coldspots = (noise.clamp(cold, 0, 1) / 2 + cold / 10) * 50 * noise.clamp(-0.45 + cold/6
        + make_multioctave_noise_function(map.seed, 5, 10, 1.5, 0.5)(cold_x,cold_y,1/30,1/20), 0, 4)

      --return clamp_temperature(base)
      --return clamp_temperature(50 - coldspots + hotspots)
      local combined = base - coldspots + hotspots
      combined = noise.clamp(combined, -50, 110) -- slice off the lava peaks
      local volcanic_area = noise.clamp(combined - 100, 0, 10)
      local volcanic_hotspots = noise.clamp(0.5 + make_multioctave_noise_function(map.seed, 5, 6, 1.5, 0.5)(x,y,1,1/20), 0, 10) * volcanic_area * 4 -- 0 - 40
      return clamp_temperature(combined + volcanic_hotspots)
    end)
  },
  {
    type = "noise-expression",
    name = "moisture",
    intended_property = "moisture",
    expression = noise.define_noise_function( function(x,y,tile,map)
      x = x * noise.var("control-setting:moisture:frequency:multiplier") + 30000 -- Move the point where 'fractal similarity' is obvious off into the boonies
      y = y * noise.var("control-setting:moisture:frequency:multiplier")
      local raw_moisture =
        0.5
        + 2.5 * make_multioctave_noise_function(map.seed, 6, 8, 0.5, 3)(x,y,1/2000,1/8)
        + 2.2 * noise.var("control-setting:moisture:bias")
      return clamp_moisture(raw_moisture)
    end)
  },
  {
    type = "noise-expression",
    name = "aux",
    intended_property = "aux",
    expression = noise.define_noise_function( function(x,y,tile,map)
      x = x * noise.var("control-setting:aux:frequency:multiplier") + 20000 -- Move the point where 'fractal similarity' is obvious off into the boonies
      y = y * noise.var("control-setting:aux:frequency:multiplier")
      local raw_aux =
        0.45 -- slight bias to normal
        + 2.2 * make_multioctave_noise_function(map.seed, 7, 8, 0.5, 3)(x,y,1/5000,1/4)
        + 2.2 * noise.var("control-setting:aux:bias")
      return clamp_aux(raw_aux)
    end)
  },
  --[[{
    type = "noise-expression",
    name = "debug-temperature",
    intended_property = "temperature",
    expression = noise.define_noise_function( function(x,y,tile,map)
      return noise.clamp(50 + y  * (1 / 1024) * 200, -50, 150)
    end)
  },
  {
    type = "noise-expression",
    name = "debug-moisture",
    intended_property = "moisture",
    expression = noise.define_noise_function( function(x,y,tile,map)
      return clamp_moisture(0.5 + x * (1 / 1024))
    end)
  },
  {
    type = "noise-expression",
    name = "debug-aux",
    intended_property = "aux",
    expression = noise.define_noise_function( function(x,y,tile,map)
      -- Tile peaks tend to be based on aux+water,
      -- so let's use the same dimension as temperature for aux
      return clamp_aux(0.5 + x * (1 / 1024))
    end)
  },]]--
})
