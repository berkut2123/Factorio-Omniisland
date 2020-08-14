local pic = function(name, number, width, height)
  return {
    filename = "__alien-biomes__/graphics/decorative/"..name.."/sr/"..name.."-"..number..".png",
    priority = base_decorative_sprite_priority,
    width = math.floor(width/2),
    height = math.floor(height/2),
    hr_version = {
      filename = "__alien-biomes__/graphics/decorative/"..name.."/hr/"..name.."-"..number..".png",
      priority = base_decorative_sprite_priority,
      width = width,
      height = height,
      scale = 0.5
    },
  }
end
local tile_restriction = alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), {"snow"})) -- not ice
if table_size(tile_restriction) > 0 then
  data:extend({
    {
      name = "cane-single",
      type = "optimized-decorative",
      subgroup = "grass",
      order = "b[decorative]-b[asterisk-mini]-b[green]",
      collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
      selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
      selectable_in_game = false,
      render_layer = "decorative",
      autoplace = {
        random_probability_penalty = 0.25,
        peaks = {
          { influence = -0.2 },
          {
            influence = 0.4,
            noise_layer = "grass1",
            noise_octaves_difference = -2,
            noise_persistence = 0.8,
            temperature_optimal = -10,
            temperature_range = 10,
            temperature_max_range = 15,
            water_optimal = 1,
            water_range = 0.4,
            water_max_range = 0.6,
          }
        },
        tile_restriction = alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), {"snow"})) -- not ice
      },
      pictures =
      {
        pic("cane-single", "01", 56, 60),
        pic("cane-single", "02", 44, 43),
        pic("cane-single", "03", 48, 51),
        pic("cane-single", "04", 45, 37),
        pic("cane-single", "05", 81, 57),
        pic("cane-single", "06", 31, 94),
      }
    },
    {
      name = "cane-cluster",
      type = "optimized-decorative",
      subgroup = "grass",
      order = "b[decorative]-b[asterisk-mini]-b[green]",
      collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
      selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
      selectable_in_game = false,
      render_layer = "decorative",
      autoplace = {
        random_probability_penalty = 0.75,
        peaks = {
          { influence = -0.2 },
          {
            influence = 0.4,
            noise_layer = "grass1",
            noise_octaves_difference = -2,
            noise_persistence = 0.7,
            temperature_optimal = -10,
            temperature_range = 10,
            temperature_max_range = 15,
            water_optimal = 1,
            water_range = 0.4,
            water_max_range = 0.6,
          }
        },
        tile_restriction = alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), {"snow"})) -- not ice
      },
      pictures =
      {
        pic("cane-cluster", "01", 131, 146),
        pic("cane-cluster", "02", 154, 176),
        pic("cane-cluster", "03", 264, 156),
        pic("cane-cluster", "04", 119, 138),
        pic("cane-cluster", "05", 140, 230),
      }
    },
  })
end
