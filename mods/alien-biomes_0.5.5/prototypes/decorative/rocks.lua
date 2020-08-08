local util = require('data-util')

local any = alien_biomes.require_tag
local all = alien_biomes.require_tags
local list = alien_biomes.list_tiles
local tiles = alien_biomes.all_tiles

local tints = {
  tan = {193,162,127},
  white = {255,255,255},
  grey = {177,183,187},
  black = {135,135,135},
  purple = {169,177,239},
  red = {185,107,105},
  violet = {165,107,161},
  dustyrose = {180,148,137},
  cream = {234,216,179},
  brown = {162,117,88},
  beige = {178,164,138},
  aubergine = {126,115,156}
}
for _, tint in pairs(tints) do
  local tint2 = {}
  tint2.a = 1
  tint2.r = tint[1]/255
  tint2.g = tint[2]/255
  tint2.b = tint[3]/255
  tints[_] = tint2
end
for _, tint in pairs(tints) do
  if _ ~= "tan" then
    local fade = 0.5
    if _ == "white" or _ == "black" then
      fade = 0.2
    end
    -- step 20% towards normal rock color for other rocks (becuase cliff colours are locked)
    tint.r = tint.r * (1 - fade) + tints["tan"].r * fade
    tint.g = tint.g * (1 - fade) + tints["tan"].g * fade
    tint.b = tint.b * (1 - fade) + tints["tan"].b * fade
  end
end

-- NOISE LAYERS
data:extend({
  {
    type = "noise-layer",
    name = "mud-decal"
  },
  {
    type = "noise-layer",
    name = "stone-decal"
  }
})

-- SHARED GRASS
data.raw['optimized-decorative']['puberty-decal'].autoplace =
{
  max_probability = 0.01,
  order = "a[doodad]-b[decal]",
  peaks = {
    {
      influence = 1,
      noise_layer = "mud-decal",
      noise_octaves_difference = -2,
      noise_persistence = 0.9
    }
  },
  sharpness = 0.3,
  tile_restriction = list(any(tiles(), {'grass'}))
}

data.raw["optimized-decorative"]["dark-mud-decal"].autoplace = {
  max_probability = 0.01,
  order = "a[doodad]-b[decal]",
  peaks = {
    {
      influence = 1,
      noise_layer = "mud-decal",
      noise_octaves_difference = -2,
      noise_persistence = 0.9
    },
  },
  sharpness = 0.3,
  tile_restriction = list(any(tiles(), {'grass', 'dirt'}))
}

-- ROCKS

-- get base rocks
local base_rocks_list = require("rocks-base")
local base_rocks = {}
for _, rock in pairs(base_rocks_list) do
  base_rocks[rock.name] = rock
end

-- make a new colored rock from a base rock and restrict to certain biome tiles by tag
local make_rock = function(name, base_names, tile_restriction, multiplier, color)
  if table_size(tile_restriction) > 0 then
    if color == nil then color = name end
    for _, base_name in pairs(base_names) do
      local rock = table.deepcopy(base_rocks[base_name])
      rock.name = base_name .. '-' .. name
      rock.autoplace.tile_restriction = tile_restriction
      if rock.autoplace.coverage then rock.autoplace.coverage = rock.autoplace.coverage * multiplier end
      if rock.autoplace.max_probability then rock.autoplace.max_probability = rock.autoplace.max_probability * multiplier end

      -- replace still required for dunes
      if base_name == 'sand-dune-decal' then
        util.replace_filenames_recursive(rock.pictures, '|color|', color)
      else
          for _, pic in pairs(rock.pictures) do
            pic.tint = tints[color]
            if pic.hr_version then
              pic.hr_version.tint = tints[color]
            end
          end
      end

      --rock.localised_name = {"alien-biomes.doublestring", {"alien-biomes.".. color}, {"entity-name.rock"} }
      rock.localised_name = {"entity-name.rock"}
      -- volcanic has generally more rocks
      data:extend({rock})
    end
  end
end

-- main rocks
make_rock(
  'tan',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(any(tiles(),
    {'dirt', 'grass'}), -- land types
    {
      'dustyrose',-- dirt
      'green', 'turquoise' -- grass
    }
  )),
  1
)

-- main rocks
make_rock(
  'dustyrose',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(tiles(),{'dirt-dustyrose', 'grass-violet'})),
  1
)

make_rock(
  'cream',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(any(tiles(),
    {'dirt', 'grass'}), -- land types
    {
      'cream',-- dirt
      'yellow' -- grass
    }
  )),
  1
)

make_rock(
  'brown',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(any(tiles(),
    {'dirt', 'grass'}), -- land types
    {
      'brown',-- dirt
      'orange' -- grass
    }
  )),
  1
)

make_rock(
  'beige',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(any(tiles(),
    {'dirt', 'grass'}), -- land types
    {
      'beige',-- dirt
      'olive' -- grass
    }
  )),
  1
)

make_rock(
  'red',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(any(tiles(),
    {'dirt', 'grass'}), -- land types
    {
      'red',  -- dirt or grass
    }
  )),
  1
)

make_rock(
  'violet',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(tiles(),{'dirt-violet'})),
  1
)

make_rock(
  'purple',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(tiles(),{'dirt-purple'})),
  1
)

make_rock(
  'aubergine',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(tiles(),{'dirt-aubergine', 'grass-mauve'})),
  1
)

make_rock(
  'black',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(any(tiles(),
    {'dirt', 'volcanic'}), -- land types
    {'black', 'volcanic' }
  )),
  1
)

make_rock(
  'grey',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(tiles(),{'dirt-grey', 'grass-blue', 'grass-turquoise'})),
  1
)

make_rock(
  'white',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny'
  },
  list(any(any(tiles(),
    {'dirt', 'frozen'}), -- land types
    {
      'white', -- dirt
      'snow',
    }
  )),
  1
)

-- non-sand shared decals
make_rock(
  'tan',
  { 'stone-decal' },
  list(any(any(tiles(),
    {'dirt', 'grass'}), -- land types
    {
      'tan', 'brown', 'cream', 'beige', 'dustyrose',-- dirt
      'green', 'olive', 'turquoise', 'yellow', 'orange', 'purple' -- grass
    }
  )),
  1
)

make_rock(
  'red',
  { 'stone-decal' },
  list(any(any(tiles(),
    {'dirt', 'grass'}), -- land types
    {
      'red', 'violet', -- dirt
      'red', 'violet', -- grass
    }
  )),
  1
)

make_rock(
  'purple',
  { 'stone-decal' },
  list(any(any(tiles(),
    {'dirt', 'grass'}), -- land types
    {
      'purple', 'aubergine', -- dirt
      'purple', -- grass
    }
  )),
  1
)

make_rock(
  'black',
  { 'stone-decal' },
  list(any(any(tiles(),
    {'dirt'}), -- land types
    {'black'}
  )),
  1
)

make_rock(
  'white',
  { 'stone-decal' },
  list(any(any(tiles(),
    {'dirt', 'grass', 'frozen'}), -- land types
    {
      'white', 'grey', -- dirt
      'blue', 'mauve', -- grass
      'snow',
    }
  )),
  1
)

-- shared decals
make_rock(
  'tan',
  { 'sand-decal' },
  list(any(any(tiles(),
    {'dirt', 'sand', 'grass'}), -- land types
    {
      'tan', 'brown', 'cream', 'beige', 'dustyrose',-- dirt
      'green', 'olive', 'turquoise', 'yellow', 'orange', 'purple' -- grass
    }
  )),
  1
)

make_rock(
  'red',
  { 'sand-decal' },
  list(any(any(tiles(),
    {'dirt', 'sand', 'grass'}), -- land types
    {
      'red', 'violet', -- dirt
      'red', 'violet', -- grass
    }
  )),
  1
)

make_rock(
  'purple',
  { 'sand-decal' },
  list(any(any(tiles(),
    {'dirt', 'sand', 'grass'}), -- land types
    {
      'purple', 'aubergine', -- dirt
      'purple', -- grass
    }
  )),
  1
)

make_rock(
  'black',
  { 'sand-decal' },
  list(any(any(tiles(),
    {'dirt', 'sand', 'volcanic'}), -- land types
    {'black', 'volcanic' }
  )),
  2
)

make_rock(
  'white',
  { 'sand-decal' },
  list(any(any(tiles(),
    {'dirt', 'sand', 'grass', 'frozen'}), -- land types
    {
      'white', 'grey', -- dirt
      'blue', 'mauve', -- grass
      'snow',
    }
  )),
  2
)

-- sandy rocks and decals
make_rock(
  'tan',
  {
    'sand-rock-big',
    'sand-rock-medium',
    'sand-rock-small',
  },
  list(any(any(tiles(),
    {'sand'}), -- land types
    {
      'tan', 'brown', 'cream', 'beige' -- dirt
    }
  )),
  1
)

make_rock(
  'red',
  {
    'sand-rock-big',
    'sand-rock-medium',
    'sand-rock-small',
  },
  list(any(any(tiles(),
    {'sand'}), -- land types
    {
      'red', 'violet', 'dustyrose', -- dirt
    }
  )),
  1
)

make_rock(
  'purple',
  {
    'sand-rock-big',
    'sand-rock-medium',
    'sand-rock-small',
  },
  list(any(any(tiles(),
    {'sand'}), -- land types
    {
      'purple', 'aubergine', -- dirt
    }
  )),
  1
)

make_rock(
  'black',
  {
    'sand-rock-big',
    'sand-rock-medium',
    'sand-rock-small',
  },
  list(any(any(tiles(),
    {'sand'}), -- land types
    {'black' }
  )),
  1
)

make_rock(
  'white',
  {
    'sand-rock-big',
    'sand-rock-medium',
    'sand-rock-small',
  },
  list(any(any(tiles(),
    {'sand'}), -- land types
    {
      'white', 'grey', -- dirt
    }
  )),
  1
)

-- dune
for color, data in pairs(alien_biomes.spec.mineral.axes) do
  make_rock(color, {'sand-dune-decal'}, list(any(any(tiles(),{'sand'}), {color} )), 4 )
end

-- volcanic
local volcanic_tiles = list(any(tiles(), {'volcanic'} ))
make_rock(
  'volcanic',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny',
    'sand-decal',
    'stone-decal'
  },
  volcanic_tiles,
  2,
  "black"
)
if data.raw['simple-entity']['rock-huge-volcanic'] then
  data.raw['simple-entity']['rock-huge-volcanic'].autoplace = {
    random_probability_penalty = 0.6, tile_restriction = volcanic_tiles,
    peaks = {
      { influence = -0.2 },
      { noise_layer = "grass1", influence = 0.4, noise_persistance = 0.8, noise_octaves_difference = -4},
    }
  }
end
if data.raw['simple-entity']['rock-big-volcanic'] then
  data.raw['simple-entity']['rock-big-volcanic'].autoplace = {
    random_probability_penalty = 0.6, tile_restriction = volcanic_tiles,
    peaks = {
      { influence = -0.1 },
      { noise_layer = "grass1", influence = 0.4, noise_persistance = 0.8, noise_octaves_difference = -4},
    }
  }
end
if data.raw['optimized-decorative']['rock-medium-volcanic'] then
data.raw['optimized-decorative']['rock-medium-volcanic'].autoplace = {
  random_probability_penalty = 0.2, tile_restriction = volcanic_tiles,
  peaks = {
    { influence = 0.4 },
    { noise_layer = "grass1", influence = 0.4, noise_persistance = 0.8, noise_octaves_difference = -4},
  }
}
end
if data.raw['optimized-decorative']['rock-small-volcanic'] then
data.raw['optimized-decorative']['rock-small-volcanic'].autoplace = {
  random_probability_penalty = 0.25, tile_restriction = volcanic_tiles,
  peaks = {
    { influence = 0.45 },
    { noise_layer = "grass1", influence = 0.4, noise_persistance = 0.8, noise_octaves_difference = -4},
  }
}
end
if data.raw['optimized-decorative']['rock-tiny-volcanic'] then
data.raw['optimized-decorative']['rock-tiny-volcanic'].autoplace = {
  random_probability_penalty = 0.25, tile_restriction = volcanic_tiles,
  peaks = {
    { influence = 0.5 },
    { noise_layer = "grass1", influence = 0.4, noise_persistance = 0.8, noise_octaves_difference = -4},
  }
}
end
if data.raw['optimized-decorative']['sand-decal-volcanic'] then
data.raw['optimized-decorative']['sand-decal-volcanic'].autoplace = {
  max_probability = 0.3, tile_restriction = volcanic_tiles,
  peaks = {
    { influence = 0.2 },
    { noise_layer = "dirt-1", influence = 0.1, noise_persistance = 0.8, noise_octaves_difference = -4},
  }
}
end
if data.raw['optimized-decorative']['stone-decal-volcanic'] then
data.raw['optimized-decorative']['stone-decal-volcanic'].autoplace = {
  max_probability = 0.3, tile_restriction = volcanic_tiles,
  peaks = {
    { influence = 0.2 },
    { noise_layer = "dirt-2", influence = 0.1, noise_persistance = 0.8, noise_octaves_difference = -4},
  }
}
end
