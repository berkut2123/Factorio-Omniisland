local data_util = require("data_util")
local make_recipe = data_util.make_recipe

if settings.startup["se-electric-boiler"].value then
data:extend({
    {
        type = "item",
        name = data_util.mod_prefix .. "electric-boiler",
        icon = "__space-exploration-graphics__/graphics/icons/electric-boiler.png",
        icon_size = 64,
        order = "d[fluid-burner-generator]-a",
        subgroup = "energy",
        stack_size = 50,
        place_result = data_util.mod_prefix .. "electric-boiler",
    },
    {
        type = "recipe",
        name = data_util.mod_prefix .. "electric-boiler",
        result = data_util.mod_prefix .. "electric-boiler",
        enabled = false,
        energy_required = 3,
        ingredients = {
          { "copper-plate", 100 },
          { "steel-plate", 10 },
          { "pipe", 10 },
          { data_util.mod_prefix .. "heat-shielding", 1 },
        },
        requester_paste_multiplier = 1,
        always_show_made_in = false,
    },
    {
        type = "technology",
        name = data_util.mod_prefix .. "electric-boiler",
        effects = {
         {
           type = "unlock-recipe",
           recipe = data_util.mod_prefix .. "electric-boiler",
         },
        },
        icon = "__space-exploration-graphics__/graphics/technology/electric-boiler.png",
        icon_size = 128,
        order = "e-g",
        prerequisites = {
          data_util.mod_prefix .. "heat-shielding",
        },
        unit = {
         count = 100,
         time = 10,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
         }
        },
    },
    {
        type = "boiler",
        name = data_util.mod_prefix .. "electric-boiler",
        icon = "__space-exploration-graphics__/graphics/icons/electric-boiler.png",
        icon_size = 64,
        flags = {"placeable-neutral", "player-creation"},
        minable = { mining_time = 0.2, result = data_util.mod_prefix .. "electric-boiler"},
        max_health = 200,
        corpse = "boiler-remnants",
        vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
        mode = "output-to-separate-pipe",
        resistances =
        {
          {
            type = "fire",
            percent = 90
          },
          {
            type = "explosion",
            percent = 30
          },
          {
            type = "impact",
            percent = 30
          }
        },
        collision_box = {{-1.29, -0.79}, {1.29, 0.79}},
        collision_mask = {
            "water-tile",
            "item-layer",
            "object-layer",
            "player-layer",
            spaceship_collision_layer,
          },
        selection_box = {{-1.5, -1}, {1.5, 1}},
        target_temperature = 500,
        fluid_box =
        {
          base_area = 1,
          height = 2,
          base_level = -1,
          pipe_covers = pipecoverspictures(),
          pipe_connections =
          {
            {type = "input-output", position = {-2, 0.5}},
            {type = "input-output", position = {2, 0.5}}
          },
          production_type = "input-output",
          filter = "water"
        },
        output_fluid_box =
        {
          base_area = 1,
          height = 2,
          base_level = 1,
          pipe_covers = pipecoverspictures(),
          pipe_connections =
          {
            {type = "output", position = {0, -1.5}}
          },
          production_type = "output",
          filter = "steam"
        },
        energy_consumption = "10MW",
        energy_source =
        {
          type = "electric",
          --drain = "10MW",
          usage_priority = "secondary-input"
        },
        working_sound =
        {
          sound =
          {
            filename = "__base__/sound/boiler.ogg",
            volume = 0.8
          },
          max_sounds_per_type = 3
        },
        structure =
        {
          north =
          {
            layers =
            {
              {
                filename = "__space-exploration-graphics__/graphics/entity/electric-boiler/electric-boiler-n.png",
                priority = "extra-high",
                width = 268/2,
                height = 220/2,
                shift = util.by_pixel(-1.25, 5.25),
                data_util.hr({
                  filename = "__space-exploration-hr-graphics__/graphics/entity/electric-boiler/hr-electric-boiler-n.png",
                  width = 268,
                  height = 220,
                  priority = "extra-high",
                  shift = util.by_pixel(-1.25, 5.25),
                  scale = 0.5,
                }),
              },
              {
                filename = "__space-exploration-graphics__/graphics/entity/electric-boiler/electric-boiler-n-shadow.png",
                priority = "extra-high",
                width = 274/2,
                height = 164/2,
                shift = util.by_pixel(20.5, 9),
                draw_as_shadow = true,
                data_util.hr({
                  filename = "__space-exploration-hr-graphics__/graphics/entity/electric-boiler/hr-electric-boiler-n-shadow.png",
                  width = 274,
                  height = 164,
                  priority = "extra-high",
                  shift = util.by_pixel(20.5, 9),
                  draw_as_shadow = true
                }),
              }
            }
          },
          east =
          {
            layers =
            {
              {
                filename = "__space-exploration-graphics__/graphics/entity/electric-boiler/electric-boiler-e.png",
                priority = "extra-high",
                width = 210/2,
                height = 300/2,
                shift = util.by_pixel(-1.75, 1.25),
                data_util.hr({
                  filename = "__space-exploration-hr-graphics__/graphics/entity/electric-boiler/hr-electric-boiler-e.png",
                  width = 210,
                  height = 300,
                  priority = "extra-high",
                  shift = util.by_pixel(-1.75, 1.25),
                  scale = 0.5,
                }),
              },
              {
                filename = "__space-exploration-graphics__/graphics/entity/electric-boiler/electric-boiler-e-shadow.png",
                priority = "extra-high",
                width = 184/2,
                height = 194/2,
                shift = util.by_pixel(30, 9.5),
                draw_as_shadow = true,
                data_util.hr({
                  filename = "__space-exploration-hr-graphics__/graphics/entity/electric-boiler/hr-electric-boiler-e-shadow.png",
                  width = 184,
                  height = 194,
                  priority = "extra-high",
                  shift = util.by_pixel(30, 9.5),
                  draw_as_shadow = true
                }),
              }
            }
          },
          south =
          {
            layers =
            {
              {
                filename = "__space-exploration-graphics__/graphics/entity/electric-boiler/electric-boiler-s.png",
                priority = "extra-high",
                width = 260/2,
                height = 200/2,
                shift = util.by_pixel(4, 10.75),
                data_util.hr({
                  filename = "__space-exploration-hr-graphics__/graphics/entity/electric-boiler/hr-electric-boiler-s.png",
                  width = 260,
                  height = 200,
                  priority = "extra-high",
                  shift = util.by_pixel(4, 10.75),
                  scale = 0.5,
                }),
              },
              {
                filename = "__space-exploration-graphics__/graphics/entity/electric-boiler/electric-boiler-s-shadow.png",
                priority = "extra-high",
                width = 310/2,
                height = 130/2,
                shift = util.by_pixel(29.75, 15.75),
                draw_as_shadow = true,
                data_util.hr({
                  filename = "__space-exploration-hr-graphics__/graphics/entity/electric-boiler/hr-electric-boiler-s-shadow.png",
                  priority = "extra-high",
                  width = 310,
                  height = 130,
                  shift = util.by_pixel(29.75, 15.75),
                  draw_as_shadow = true
                }),
              }
            }
          },
          west =
          {
            layers =
            {
              {
                filename = "__space-exploration-graphics__/graphics/entity/electric-boiler/electric-boiler-w.png",
                priority = "extra-high",
                width = 196/2,
                height = 272/2,
                shift = util.by_pixel(1.5, 7.75),
                data_util.hr({
                  filename = "__space-exploration-hr-graphics__/graphics/entity/electric-boiler/hr-electric-boiler-w.png",
                  width = 196,
                  height = 272,
                  priority = "extra-high",
                  shift = util.by_pixel(1.5, 7.75),
                  scale = 0.5,
                }),
              },
              {
                filename = "__space-exploration-graphics__/graphics/entity/electric-boiler/electric-boiler-w-shadow.png",
                priority = "extra-high",
                width = 206/2,
                height = 218/2,
                shift = util.by_pixel(19.5, 6.5),
                draw_as_shadow = true,
                data_util.hr({
                  filename = "__space-exploration-hr-graphics__/graphics/entity/electric-boiler/hr-electric-boiler-w-shadow.png",
                  width = 206,
                  height = 218,
                  priority = "extra-high",
                  shift = util.by_pixel(19.5, 6.5),
                  draw_as_shadow = true
                }),
              }
            }
          }
        },
        fire = {},
        fire_glow = {},
        burning_cooldown = 20
    },

})
end
