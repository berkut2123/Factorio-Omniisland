--local inspect = require('inspect')
require('tree-stump')

local util = require('util')
local merge = util.merge
local tree_models = require('tree-models')
local color_limit = 32
local starting_area_clearing_radius = 64
local starting_area_clearing_border_width = 32

local function index_to_letter(index, starting_at)
  return string.char(string.byte(starting_at or "a", 1) - 1 + index)
end

-- disable existing trees
for _, tree in pairs(data.raw.tree) do
  tree.autoplace = nil
end

local water_bands = {
  [1] = {0.2, 0.4},
  [2] = {0.4, 0.6},
  [3] = {0.6, 0.9},
  [4] = {0.9, 1.1},
}

local function map_temperature(input)
  -- range is currently 0 - 100
  return input * 100
end

local starting_area_clearing_peak = {
  influence = -0.25,
  richness_influence = 0,
  distance_optimal = 0,
  distance_range = starting_area_clearing_radius - starting_area_clearing_border_width,
  distance_max_range = starting_area_clearing_radius + starting_area_clearing_border_width,
  distance_top_property_limit = starting_area_clearing_radius, -- must be halfway between range and max_range so that influence never becomes positive!
}

local next_tree_noise_layer_number = 1

-- static_influence is added
-- tree_noise_influence is multiplied by tree noise, the result of which is added
local function tree_autoplace(treedata)

  local dimensions_peak = {
    influence = 1,
    richness_influence = 0.25,
  }

  if treedata.water_band then
    treedata.water_low = water_bands[treedata.water_band][1]
    treedata.water_high = water_bands[treedata.water_band][1]
  end
  if treedata.water_low and treedata.water_high then
    dimensions_peak.water_optimal = (treedata.water_low + treedata.water_high) * 0.5
    dimensions_peak.water_range = (treedata.water_high - treedata.water_low) * 0.5
    dimensions_peak.water_max_range = (treedata.water_high - treedata.water_low) * 0.5 + 0.05
  end

  if treedata.temperature_low and treedata.temperature_high then
    local temp_low = map_temperature(treedata.temperature_low)
    local temp_high = map_temperature(treedata.temperature_high)
    dimensions_peak.temperature_optimal = (temp_low + temp_high) * 0.5
    dimensions_peak.temperature_range = (temp_high - temp_low) * 0.5
    dimensions_peak.temperature_max_range = (temp_high - temp_low) * 0.5  + 0.05
  end

  if treedata.aux_low and treedata.aux_high then
    local aux_low = treedata.aux_low
    local aux_high = treedata.aux_high
    dimensions_peak.aux_optimal = (aux_low + aux_high) * 0.5
    dimensions_peak.aux_range = (aux_high - aux_low) * 0.5
    dimensions_peak.aux_max_range = (aux_high - aux_low) * 0.5  + 0.05
  end

  if treedata.elevation_low and treedata.elevation_high then
    dimensions_peak.elevation_optimal = (treedata.elevation_low + treedata.elevation_high) * 0.5
    dimensions_peak.elevation_range = (treedata.elevation_high - treedata.elevation_low) * 0.5
    dimensions_peak.elevation_max_range = (treedata.elevation_high - treedata.elevation_low) * 0.5  + 0.05
  end

  local tree_noise_influence = 0.65
  local density = (treedata.density or 1)
  local static_influence = -1 + treedata.density * 0.1
  local noise_layer_name = treedata.noise
  data:extend{{type="noise-layer", name=noise_layer_name}}

  local autoplace = {
    control = "trees",
    order = "z[tree]-b[forest]",
    max_probability = 0.5 * density/4,
    random_probability_penalty = 0.02 + 0.01 * (1 - density/4);
    sharpness = 0.25,
    richness_base = 0.0, -- 0.0,
    richness_multiplier = 0.5,
    peaks = {
      {
        -- increase richness everywhere to reduce
        -- large groups of unhealthy trees
        influence = 0,
        richness_influence = 1.2
      },
      {
        influence = static_influence,
        richness_influence = -static_influence,
      },
      {
        -- Give each tree type its own noise layer to add some randomness
        -- to the boundaries between types of forests.
        -- This results in more forest coverage overall so has to be countered
        -- with more negative static influence.
        max_influence = tree_noise_influence,
        influence = tree_noise_influence,
        richness_influence = -tree_noise_influence,
        noise_layer = noise_layer_name,
        noise_persistence = 0.6,
        noise_octaves_difference = -0.75
      },
      {
        max_influence = tree_noise_influence * 0.7,
        influence = tree_noise_influence * 0.7,
        richness_influence = -tree_noise_influence,
        noise_layer = "trees",
        noise_persistence = 0.6,
        noise_octaves_difference = -0.65
      },
      dimensions_peak,
      starting_area_clearing_peak,
    },
  }
  --log( treedata.name )
  --log( serpent.block( autoplace, {comment = false, numformat = '%1.8g' } ) )
  local excludes = {"volcanic", "frozen"}
  if treedata.water_band and treedata.water_band > 1 then
    table.insert(excludes, "sand")
  end
  autoplace.tile_restriction = treedata.tile_restriction or alien_biomes.list_tiles(alien_biomes.exclude_tags(alien_biomes.all_tiles(), excludes))
  return autoplace
end

local function clamp_color(value)
  return math.min(math.max(value, 0), 255)
end

local function table_add_color(table, color)
  local step = 5
  color.r = clamp_color(math.ceil(color.r/5)*5)
  color.g = clamp_color(math.ceil(color.g/5)*5)
  color.b = clamp_color(math.ceil(color.b/5)*5)
  local key = color.r .. "-" .. color.g .. "-" .. color.b
  if not table[key] then
    table[key] = color
    table.count = table.count + 1
  end
end

local function lerp_color(color_a, color_b, value)
  return {
    r = math.ceil(color_a.r + (color_b.r - color_a.r) * value),
    b = math.ceil(color_a.b + (color_b.b - color_a.b) * value),
    g = math.ceil(color_a.g + (color_b.g - color_a.g) * value),
  }
end

local function expand_colors(all_colors)
  local source_colors = table.deepcopy(all_colors)
  for color_a_name, color_a in pairs(source_colors) do
    for color_b_name, color_b in pairs(source_colors) do
      if color_a_name ~= "count"
      and color_b_name ~= "count" and
      color_a_name ~= color_b_name and
      all_colors.count < color_limit then
        -- move 1/3 to the new color
        table_add_color(all_colors, lerp_color(color_a, color_b, 1/3) )
      end
    end
  end
end

local function lighten_color()

end

local function negate_channel(color, negate)
  -- the darker the negate the bigger the step needed towards white
  return math.ceil((1 - (1 - color / 255) * negate / 255) * 255)
end

local function make_tree(treedata)
  local all_colors = { count = 0 }
  for _, color in pairs(treedata.colors) do
    if treedata.negate_tint then
      table_add_color(all_colors, {
        r = negate_channel(color.r, treedata.negate_tint.r),
        g = negate_channel(color.g, treedata.negate_tint.g),
        b = negate_channel(color.b, treedata.negate_tint.b)
      })
    else
      table_add_color(all_colors, color)
    end
  end
  -- brown
  if treedata.model ~= "palm" then
    table_add_color(all_colors, {r = 75,  g = 60, b = 40,})
  end


  local step = 0
  while (all_colors.count < color_limit) and (step < 8) do
    step = step + 1
    expand_colors(all_colors)
  end

  -- get colors array
  local colors = {}
  for _, color in pairs(all_colors) do
    if _ ~= "count" then
      table.insert(colors, color)
    end
  end
  if tree_models[treedata.model] then
    treedata.model = tree_models[treedata.model]
    local ab = treedata.model.alien_biomes_texture == true
    local tree = {
      type = "tree",
      name = treedata.name,
      icon =  ab and "__base__/graphics/icons/tree-01.png" or "__base__/graphics/icons/tree-" .. treedata.model.type_name .. ".png",
      icon_size = 64,
      icon_mipmaps = 4,
      flags = {"placeable-neutral", "placeable-off-grid", "breaths-air"},
      selection_priority = 0,
      minable =
      {
        mining_particle = "wooden-particle",
        mining_time = 0.5,
        result = "wood",
        count = 4
      },
      corpse = treedata.stump or ("tree-" .. treedata.model.type_name .. "-stump"),
      remains_when_mined = treedata.stump or ("tree-" ..  treedata.model.type_name .. "-stump"),
      emissions_per_second = -0.001,
      max_health = 20,
      collision_box = {{-1/32, -1/32}, {1/32, 1/32}},
      selection_box = treedata.selection_box or {{-0.9, -2.2}, {0.9, 0.6}},
      drawing_box = treedata.model.drawing_box,
      subgroup = "trees",
      order = "a[tree]-b[alien-biomes]-a[" .. treedata.name .. "]",
      vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
      autoplace = tree_autoplace(treedata),
      variations = treedata.model.tree_variations,
      colors = colors,
      darkness_of_burnt_tree = 0.5,
      localised_name = { "entity-name.tree" },
      variation_weights = treedata.variation_weights,
    }
    data:extend({tree})
  else
    log( "Tree model load error:" )
    log( serpent.block( treedata, {comment = false, numformat = '%1.8g' } ) )
  end
end


local trees_data = require('tree-data')

for _, treedata in pairs(trees_data) do
  if not (treedata.enabled == false) then
    make_tree(treedata)
  end
end
--data.raw.tree["tree-wetland-c"].variations = data.raw.tree["tree-05"].variations

local not_extreme = alien_biomes.list_tiles(alien_biomes.exclude_tags(alien_biomes.all_tiles(), {"frozen", "volcanic"}))
local not_super_extreme = alien_biomes.list_tiles(alien_biomes.exclude_tags(alien_biomes.all_tiles(), {"heat-4", "heat-3", "ice"}))

local deadtrees = {
  ["dry-hairy-tree"] = {water_optimal = 0.8, tile_restriction = not_extreme},
  ["dead-grey-trunk"] = {water_optimal = 0.7, tile_restriction = not_extreme},
  ["dead-dry-hairy-tree"] = {water_optimal = 0.6, tile_restriction = not_extreme},
  ["dead-tree-desert"] = {water_optimal = 0.5, tile_restriction = not_extreme},
  ["dry-tree"] = {water_optimal = 0.4, tile_restriction = not_super_extreme},
}

for _, tree_data in pairs(deadtrees) do
  data.raw.tree[_].autoplace =
  {
    control = "trees",
    max_probability = 0.01,
    order = "z[tree]-b[forest]",
    peaks = {
      {
        influence = -0.7,
        richness_influence = 0
      },
      {
        influence = 1,
        noise_layer = "trees",
        noise_octaves_difference = -1.5,
        noise_persistence = 0.5,
        richness_influence = 0
      },
      {
        influence = 1,
        richness_influence = 0,
        water_optimal = tree_data.water_optimal,
        water_max_range = 0.4,
        water_range = 0.3
      }
    },
    random_probability_penalty = 0.01,
    sharpness = 0.6,
    tile_restriction = table.deepcopy(tree_data.tile_restriction)
  }
end
