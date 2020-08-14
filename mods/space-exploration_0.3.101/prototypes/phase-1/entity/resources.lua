local data_util = require("data_util")
local noise = require("noise");
local tne = noise.to_noise_expression;
local resource_autoplace = require("resource-autoplace");

data:extend({
  {
    type = "resource",
    name = data_util.mod_prefix.."water-ice",
    icon = "__space-exploration-graphics__/graphics/icons/water-ice.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 1,
      result = data_util.mod_prefix.."water-ice",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = { -- real distribution set in stage 3
      control = data_util.mod_prefix.."water-ice",
      tile_restriction = {data_util.mod_prefix.."asteroid"}
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__space-exploration-graphics__/graphics/entity/water-ice/water-ice.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version =
        {
          filename = "__space-exploration-graphics__/graphics/entity/water-ice/hr-water-ice.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    },
    map_color = {r = 198/255, g = 241/255, b = 245/255}
  },
  {
    type = "resource",
    name = data_util.mod_prefix.."methane-ice",
    icon = "__space-exploration-graphics__/graphics/icons/methane-ice.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 1,
      result = data_util.mod_prefix.."methane-ice",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = { -- real distribution set in stage 3
      control = data_util.mod_prefix.."methane-ice",
      tile_restriction = {data_util.mod_prefix.."asteroid"}
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__space-exploration-graphics__/graphics/entity/methane-ice/methane-ice.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version =
        {
          filename = "__space-exploration-graphics__/graphics/entity/methane-ice/hr-methane-ice.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    },
    map_color = {r = 245/255, g = 231/255, b = 198/255}
  },
  {
    type = "resource",
    name = data_util.mod_prefix.."beryllium-ore",
    icon = "__space-exploration-graphics__/graphics/icons/beryllium-ore.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 4,
      result = data_util.mod_prefix.."beryllium-ore",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = { -- real distribution set in stage 3
      control = data_util.mod_prefix.."beryllium-ice"
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__space-exploration-graphics__/graphics/entity/beryllium-ore/beryllium-ore.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version =
        {
          filename = "__space-exploration-graphics__/graphics/entity/beryllium-ore/hr-beryllium-ore.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    },
    map_color = {r = 144/255, g = 222/255, b = 184/255}
  },
  {
    type = "resource",
    name = data_util.mod_prefix.."cryonite",
    icon = "__space-exploration-graphics__/graphics/icons/cryonite.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 2,
      result = data_util.mod_prefix.."cryonite",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = { -- real distribution set in stage 3
      control = data_util.mod_prefix.."cryonite",
      tile_restriction = alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), {"frozen"})), -- was just snow but too unpredicatable
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__space-exploration-graphics__/graphics/entity/cryonite/cryonite.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version =
        {
          filename = "__space-exploration-graphics__/graphics/entity/cryonite/hr-cryonite.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    },
    stages_effect = {
      sheet = {
        blend_mode = "additive",
        filename = "__space-exploration-graphics__/graphics/entity/cryonite/cryonite-glow.png",
        flags = {
          "light"
        },
        frame_count = 8,
        height = 64,
        hr_version = {
          blend_mode = "additive",
          filename = "__space-exploration-graphics__/graphics/entity/cryonite/hr-cryonite-glow.png",
          flags = {
            "light"
          },
          frame_count = 8,
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          variation_count = 8,
          width = 128
        },
        priority = "extra-high",
        variation_count = 8,
        width = 64
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    effect_darkness_multiplier = 3.6,
    max_effect_alpha = 0.3,
    min_effect_alpha = 0.2,
    map_color = {r = 35/255, g = 164/255, b = 255/255}
  },
  {
    type = "resource",
    name = data_util.mod_prefix.."holmium-ore",
    icon = "__space-exploration-graphics__/graphics/icons/holmium-ore.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 3,
      result = data_util.mod_prefix.."holmium-ore",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = { -- real distribution set in stage 3
      control = data_util.mod_prefix.."holmium-ore"
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__space-exploration-graphics__/graphics/entity/holmium-ore/holmium-ore.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version =
        {
          filename = "__space-exploration-graphics__/graphics/entity/holmium-ore/hr-holmium-ore.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    },
    map_color = {r = 135/255, g = 96/255, b = 109/255}
  },
  {
    type = "resource",
    name = data_util.mod_prefix.."iridium-ore",
    icon = "__space-exploration-graphics__/graphics/icons/iridium-ore.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      fluid_amount = 1,
      required_fluid = "sulfuric-acid",
      mining_particle = "stone-particle",
      mining_time = 5,
      result = data_util.mod_prefix.."iridium-ore",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = { -- real distribution set in stage 3
      control = data_util.mod_prefix.."iridium-ore"
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__space-exploration-graphics__/graphics/entity/iridium-ore/iridium-ore.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version =
        {
          filename = "__space-exploration-graphics__/graphics/entity/iridium-ore/hr-iridium-ore.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    },
    map_color = {r = 244/255, g = 202/255, b = 85/255}
  },
  {
    type = "resource",
    name = data_util.mod_prefix.."naquium-ore",
    icon = "__space-exploration-graphics__/graphics/icons/naquium-ore.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      fluid_amount = 20,
      required_fluid = "sulfuric-acid",
      mining_particle = "stone-particle",
      mining_time = 10,
      result = data_util.mod_prefix.."naquium-ore",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = { -- real distribution set in stage 3
      control = data_util.mod_prefix.."naquium-ore",
      tile_restriction = {data_util.mod_prefix.."asteroid"} -- only in DEEP space
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__space-exploration-graphics__/graphics/entity/naquium-ore/naquium-ore.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version =
        {
          filename = "__space-exploration-graphics__/graphics/entity/naquium-ore/hr-naquium-ore.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    },
    stages_effect = {
      sheet = {
        blend_mode = "additive",
        filename = "__space-exploration-graphics__/graphics/entity/naquium-ore/naquium-ore-glow.png",
        flags = {
          "light"
        },
        frame_count = 8,
        height = 64,
        hr_version = {
          blend_mode = "additive",
          filename = "__space-exploration-graphics__/graphics/entity/naquium-ore/hr-naquium-ore-glow.png",
          flags = {
            "light"
          },
          frame_count = 8,
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          variation_count = 8,
          width = 128
        },
        priority = "extra-high",
        variation_count = 8,
        width = 64
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    effect_darkness_multiplier = 3.6,
    max_effect_alpha = 0.3,
    min_effect_alpha = 0.2,
    map_color = {r = 137/255, g = 113/255, b = 214/255}
  },
  {
    type = "resource",
    name = data_util.mod_prefix.."vulcanite",
    icon = "__space-exploration-graphics__/graphics/icons/vulcanite.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 2,
      result = data_util.mod_prefix.."vulcanite",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = { -- real distribution set in stage 3
      control = data_util.mod_prefix.."vulcanite",
      tile_restriction = alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), {"volcanic"})),
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__space-exploration-graphics__/graphics/entity/vulcanite/vulcanite.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version =
        {
          filename = "__space-exploration-graphics__/graphics/entity/vulcanite/hr-vulcanite.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    },
    stages_effect = {
      sheet = {
        blend_mode = "additive",
        filename = "__space-exploration-graphics__/graphics/entity/vulcanite/vulcanite-glow.png",
        flags = {
          "light"
        },
        frame_count = 8,
        height = 64,
        hr_version = {
          blend_mode = "additive",
          filename = "__space-exploration-graphics__/graphics/entity/vulcanite/hr-vulcanite-glow.png",
          flags = {
            "light"
          },
          frame_count = 8,
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          variation_count = 8,
          width = 128
        },
        priority = "extra-high",
        variation_count = 8,
        width = 64
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    effect_darkness_multiplier = 3.6,
    max_effect_alpha = 0.3,
    min_effect_alpha = 0.2,
    map_color = {r = 236/255, g = 92/255, b = 18/255}
  },
  {
    type = "resource",
    name = data_util.mod_prefix.."vitamelange",
    icon = "__space-exploration-graphics__/graphics/icons/vitamelange.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 1,
      result = data_util.mod_prefix.."vitamelange",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = { -- real distribution set in stage 3
      control = data_util.mod_prefix.."vitamelange",
      tile_restriction = alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), {"grass", "dirt"})), -- not snow, volcanic, desert
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__space-exploration-graphics__/graphics/entity/vitamelange/vitamelange.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version =
        {
          filename = "__space-exploration-graphics__/graphics/entity/vitamelange/hr-vitamelange.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    },
    stages_effect = {
      sheet = {
        blend_mode = "additive-soft",
        filename = "__space-exploration-graphics__/graphics/entity/vitamelange/vitamelange-glow.png",
        flags = {
          "light"
        },
        frame_count = 8,
        height = 64,
        hr_version = {
          blend_mode = "additive-soft",
          filename = "__space-exploration-graphics__/graphics/entity/vitamelange/hr-vitamelange-glow.png",
          flags = {
            "light"
          },
          frame_count = 8,
          height = 128,
          priority = "extra-high",
          scale = 0.5,
          variation_count = 8,
          width = 128
        },
        priority = "extra-high",
        variation_count = 8,
        width = 64
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    effect_darkness_multiplier = 3.6,
    max_effect_alpha = 0.15,
    min_effect_alpha = 0.05,
    map_color = {r = 173/255, g = 206/255, b = 54/255},
  },

})
