local crater_tile_restriction = alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), {"dirt", "sand", "heat-1"}))
local function autoplace_crater (max_probability, random_probability_penalty)
  return {
    max_probability = max_probability,
    random_probability_penalty = random_probability_penalty,
    sharpness = 0.7,
    order = "a[doodad]-b[decal]",
    peaks = {
      { influence = -0.3},
      {
        influence = 0.5,
        noise_layer = "crater",
        noise_octaves_difference = -2,
        noise_persistence = 0.9,
        water_optimal = 0,
        water_range = 0.2,
        water_max_range = 0.3,
      }
    },
    tile_restriction = crater_tile_restriction
  }
end
local function crater_picture (name, width, height)
  return {
    filename = "__alien-biomes__/graphics/decorative/crater/sr/crater-"..name..".png",
    width = math.floor(width/2),
    height = math.floor(height/2),
    hr_version = {
      filename = "__alien-biomes__/graphics/decorative/crater/hr/crater-"..name..".png",
      width = width,
      height = height,
      scale = 0.5
    },
  }
end
local function make_crater(name, box, max_probability, random_probability_penalty, pictures)
  return {
    name = name,
    type = "optimized-decorative",
    subgroup = "grass",
    order = "b[decorative]-b[crater-decal]",
    collision_box = {{-box, -box*0.75}, {box, box*0.75}},
    collision_mask = {"doodad-layer", "water-tile", "not-colliding-with-itself"},
    render_layer = "decals",
    tile_layer = default_decal_layer,
    autoplace = autoplace_crater(max_probability),
    pictures = pictures
  }
end
data:extend({
  {
      type = "noise-layer",
      name = "crater"
  },
  make_crater("crater3-huge", 8, 0.001, 0.95, {
    crater_picture("huge-01", 1249, 877),
  }),
  make_crater("crater1-large-rare", 4, 0.07, 0.95, {
    crater_picture("large-01", 679, 513),
  }),
  make_crater("crater1-large", 4, 0.07, 0.7, {
    crater_picture("large-02", 327, 284),
    crater_picture("large-03", 481, 393),
    crater_picture("large-04", 406, 382),
    crater_picture("large-05", 363, 301),
  }),
  make_crater("crater2-medium", 3, 0.09, 0.5, {
    crater_picture("medium-01", 283, 231),
    crater_picture("medium-02", 213, 182),
    crater_picture("medium-03", 243, 189),
    crater_picture("medium-04", 237, 173),
    crater_picture("medium-05", 195, 182),
    crater_picture("medium-06", 146, 125),
    crater_picture("medium-07", 180, 127),
  }),
  make_crater("crater4-small", 2, 0.06, 0.8, {
    crater_picture("small-01", 122, 108),
  }),
})
