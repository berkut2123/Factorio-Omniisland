local data_util = require("data_util")

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
local i = 0
local function make_crater(name, box, max_probability, random_probability_penalty, pictures)
  i = i + 1
  return {
    name = data_util.mod_prefix..name,
    type = "optimized-decorative",
    subgroup = "grass",
    order = "b[decorative]-b[crater-decal]-"..i,
    collision_box = {{-box, -box*0.75}, {box, box*0.75}},
    collision_mask = {"doodad-layer", "water-tile"},
    render_layer = "decals",
    tile_layer = 50, -- as long as it is over asteroid layer
    pictures = pictures,
    autoplace = {
      max_probability = max_probability,
      --random_probability_penalty = random_probability_penalty,
      sharpness = 0.7,
      order = "a[doodad]-b[decal]",
      peaks = {
        { influence = 0.4},
        {
          influence = 0.15,
          noise_layer = "trees-"..i,
          noise_octaves_difference = -3,
          noise_persistence = 0.9,
        }
      },
      tile_restriction = {data_util.mod_prefix.."asteroid"}
    },
  }
end
data:extend({
  make_crater("crater3-huge", 3, 0.01, 0.95, {
    crater_picture("huge-01", 1249, 877),
  }),
  make_crater("crater1-large-rare", 2, 0.01, 0.95, {
    crater_picture("large-01", 679, 513),
  }),
  make_crater("crater1-large", 1, 0.1, 0.7, {
    crater_picture("large-02", 327, 284),
    crater_picture("large-03", 481, 393),
    crater_picture("large-04", 406, 382),
    crater_picture("large-05", 363, 301),
  }),
  make_crater("crater2-medium", 0.5, 0.1, 0.5, {
    crater_picture("medium-01", 283, 231),
    crater_picture("medium-02", 213, 182),
    crater_picture("medium-03", 243, 189),
    crater_picture("medium-04", 237, 173),
    crater_picture("medium-05", 195, 182),
    crater_picture("medium-06", 146, 125),
    crater_picture("medium-07", 180, 127),
  }),
  make_crater("crater4-small", 0.25, 0.1, 0.8, {
    crater_picture("small-01", 122, 108),
  }),
})
