local data_util = require('data_util')

-- decals for asteroids
-- rocks floating in space


local tints = {
  grey = {177,183,187},
}


-- ROCKS
-- get base rocks
local base_rocks_list = require("rocks-base")
local base_rocks = {}
for _, rock in pairs(base_rocks_list) do
  base_rocks[rock.name] = rock
end

-- make a new colored rock from a base rock and restrict to certain biome tiles by tag
local make_rock = function(name, color, base_names, tile_restriction, multiplier)
  if table_size(tile_restriction) > 0 then
    color = name
    for _, base_name in pairs(base_names) do
      local rock = table.deepcopy(base_rocks[base_name])
      rock.name = data_util.mod_prefix.. base_name .. '-' .. name
      rock.autoplace.tile_restriction = tile_restriction
      if rock.autoplace.coverage then rock.autoplace.coverage = rock.autoplace.coverage * multiplier end
      if rock.autoplace.max_probability then rock.autoplace.max_probability = rock.autoplace.max_probability * multiplier end

      for _, pic in pairs(rock.pictures) do
        pic.tint = tints[color]
        if pic.hr_version then
          pic.hr_version.tint = tints[color]
        end
      end

      rock.localised_name = {"entity-name.small-asteroid"}
      -- volcanic has generally more rocks
      data:extend({rock})
    end
  end
end

make_rock(
  'space', 'grey',
  {
    'rock-huge',
    'rock-big',
  },
  {data_util.mod_prefix.."space", data_util.mod_prefix.."asteroid"},
  0.25
)

make_rock(
  'asteroid', 'grey',
  {
    'rock-huge',
    'rock-big',
    'rock-medium',
    'rock-small',
    'rock-tiny',
    'sand-rock-big',
    'sand-rock-medium',
    'sand-rock-small',
  },
  {data_util.mod_prefix.."asteroid"},
  1
)

-- non-sand shared decals
make_rock(
  'space', 'grey',
  {
    'stone-decal',
    'sand-decal'
  },
  {data_util.mod_prefix.."asteroid"},
  2
)
