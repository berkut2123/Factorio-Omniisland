local data_util = require("data_util")

local function make_structure(name, smart_overrides, overrides)
  local base_structure = {
    type = "assembling-machine",
    name = data_util.mod_prefix .. name,
    icon = "__base__/graphics/icons/assembling-machine-3.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 1, result = data_util.mod_prefix .. name},
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-2, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {2, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      off_when_no_fluid_recipe = false
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t3-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t3-2.ogg",
          volume = 0.8
        },
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    collision_mask = {
      "water-tile",
      "ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
    },
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    drawing_box = {{-1.5, -1.7}, {1.5, 1.5}},
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3.png",
          priority = "high",
          width = 108,
          height = 119,
          frame_count = 32,
          line_length = 8,
          shift = util.by_pixel(0, -0.5),
          hr_version = {
            filename = "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3.png",
            priority = "high",
            width = 214,
            height = 237,
            frame_count = 32,
            line_length = 8,
            shift = util.by_pixel(0, -0.75),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-shadow.png",
          priority = "high",
          width = 130,
          height = 82,
          frame_count = 32,
          line_length = 8,
          draw_as_shadow = true,
          shift = util.by_pixel(28, 4),
          hr_version = {
            filename = "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3-shadow.png",
            priority = "high",
            width = 260,
            height = 162,
            frame_count = 32,
            line_length = 8,
            draw_as_shadow = true,
            shift = util.by_pixel(28, 4),
            scale = 0.5
          }
        },
      },
    },
    crafting_categories = {},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions = 0.03 / 3.5
    },
    energy_usage = "210kW",
    ingredient_count = 8,
    module_specification =
    {
      module_slots = 8
    },
    allowed_effects = {"consumption", "speed",  "pollution"} -- not "productivity",
  }
  if smart_overrides.square then
    -- placeholder graphics
    base_structure.animation.layers[1].scale = smart_overrides.square/3
    base_structure.animation.layers[1].hr_version.scale = smart_overrides.square/3/2
    base_structure.animation.layers[2].scale = smart_overrides.square/3
    base_structure.animation.layers[2].hr_version.scale = smart_overrides.square/3/2

    local collision = smart_overrides.square / 2 - 0.3
    base_structure.collision_box = {{-collision, -collision}, {collision, collision}}
    local select = smart_overrides.square / 2
    base_structure.selection_box = {{-select, -select}, {select, select}}
    base_structure.drawing_box = {{-select, -select - 0.75}, {select, select}}

    base_structure.fluid_boxes[1].pipe_connections[1].position[2] = -(smart_overrides.square / 2 + 0.5)
    base_structure.fluid_boxes[2].pipe_connections[1].position[1] = -(smart_overrides.square / 2 + 0.5)
    base_structure.fluid_boxes[3].pipe_connections[1].position[2] = (smart_overrides.square / 2 + 0.5)
    base_structure.fluid_boxes[4].pipe_connections[1].position[1] = (smart_overrides.square / 2 + 0.5)

  end
  for _, override in pairs(overrides) do
    base_structure[_] = override
  end
  data:extend({base_structure})
  if smart_overrides.make_item then
    local stack_size = 1
    if smart_overrides.square <= 3 then
      stack_size = 20
    elseif smart_overrides.square <= 5 then
        stack_size = 10
    elseif smart_overrides.square <= 7 then
        stack_size = 5
    elseif smart_overrides.square <= 9 then
        stack_size = 1
    end
    data:extend({{
      type = "item",
      name = data_util.mod_prefix .. name,
      icon = overrides.icon,
      icon_size = 32,
      order = overrides.order or "a-"..name,
      stack_size = stack_size,
      subgroup = "space-structures",
      place_result = data_util.mod_prefix .. name,
    }})
  end
  --[[if smart_overrides.make_recipe and false then
    data:extend({
      {
        type = "recipe",
        name = data_util.mod_prefix .. name,
        category = "space-manufacturing",
        --enabled = false,
        energy_required = 1,
        ingredients = smart_overrides.ingredients,
        results=
        {
          {name=data_util.mod_prefix .. name, amount=1}
        },
        icon = overrides.icon,
        icon_size = 32,
        crafting_machine_tint =
        {
          primary = {r = 0.290, g = 0.027, b = 0.000, a = 0.000}, -- #49060000
          secondary = {r = 0.722, g = 0.465, b = 0.190, a = 0.000}, -- #b8763000
          tertiary = {r = 0.870, g = 0.365, b = 0.000, a = 0.000}, -- #dd5d0000
        },
        subgroup = "space-structures",
        order = overrides.order or "a-"..name,
      },})
  end]]--
end

--[[
make_structure("space-astrometrics-laboratory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 5, subgroup="space-astronomic-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/astrometrics-laboratory.png",
  crafting_categories = {"space-astrometrics"}
  })

make_structure("space-biochemical-laboratory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-biological-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/biochemical-laboratory.png",
  crafting_categories = {"space-biochemical"}
  })

make_structure("space-decontamination-facility", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 6, subgroup="space-production-structures"}, { order="a-c[decontamination]",
  icon = "__space-exploration-graphics__/graphics/icons/decontamination-facility.png",
  crafting_categories = {"space-decontamination"}
  })

make_structure("space-electromagnetics-laboratory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-material-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/electromagnetics-laboratory.png",
  crafting_categories = {"space-electromagnetics"}
  })

make_structure("space-genetics-laboratory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-biological-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/genetics-laboratory.png",
  crafting_categories = {"space-genetics"}
  })

make_structure("space-gravimetrics-laboratory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-astronomic-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/gravimetrics-laboratory.png",
  crafting_categories = {"space-gravimetrics"}
  })

make_structure("space-growth-facility", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 9, subgroup="space-biological-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/growth-facility.png",
  crafting_categories = {"space-growth"}
  })

make_structure("space-hypercooler", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 5, subgroup="space-production-structures"}, { order="a-e[hypercooler]",
  icon = "__space-exploration-graphics__/graphics/icons/hypercooler.png",
  crafting_categories = {"space-hypercooling"}
  })

make_structure("space-laser-laboratory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 5, subgroup="space-production-structures"}, { order="a-f[laser]",
  icon = "__space-exploration-graphics__/graphics/icons/laser-laboratory.png",
  crafting_categories = {"space-laser"}
  })

make_structure("lifesupport-facility", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 6, subgroup="space-production-structures"}, { order="a-b[lifesupport]",
  icon = "__space-exploration-graphics__/graphics/icons/lifesupport-facility.png",
  crafting_categories = {"lifesupport"},
  collision_mask = {
    "water-tile",
    --"ground-tile", -- can place on ground
    "item-layer",
    "object-layer",
    "player-layer",
  },
  })
--data.raw.recipe[data_util.mod_prefix .. "space-lifesupport-facility"].category = "crafting"

make_structure("space-mechanical-laboratory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-subatomic-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/mechanical-laboratory.png",
  crafting_categories = {"space-mechanical"}
  })

make_structure("space-particle-accelerator", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 9, subgroup="space-subatomic-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/particle-accelerator.png",
  crafting_categories = {"space-accelerator"}
  })

make_structure("space-particle-collider", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 9, subgroup="space-subatomic-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/particle-collider.png",
  crafting_categories = {"space-collider"}
  })

make_structure("space-plasma-generator", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-subatomic-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/plasma-generator.png",
  crafting_categories = {"space-plasma"}
})

make_structure("space-radiation-laboratory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-subatomic-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/radiation-laboratory.png",
  crafting_categories = {"space-radiation"}
  })

make_structure("space-radiator", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 3, subgroup="space-production-structures"}, { order="a-f[radiator]",
  icon = "__space-exploration-graphics__/graphics/icons/radiator.png",
  crafting_categories = {"space-radiator"}
  })

make_structure("space-recycling-facility", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-production-structures"}, { order="a-d[recycling]",
  icon = "__space-exploration-graphics__/graphics/icons/recycling-facility.png",
  crafting_categories = {"space-recycling"}
  })

make_structure("space-spectrometer-facility", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-subatomic-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/spectrometer-facility.png",
  crafting_categories = {"space-spectrometry"}
  })

make_structure("space-manufactory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 9, subgroup="space-production-structures"}, { order="a-a[manufactory]",
  icon = "__space-exploration-graphics__/graphics/icons/space-manufactory.png",
  crafting_categories = {"crafting", "advanced-crafting", "crafting-with-fluid", "space-manufacturing"}
  })
data.raw.recipe["space-manufactory"].category = "crafting"


make_structure("space-material-fabricator", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 9, subgroup="space-material-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/material-fabricator.png",
  crafting_categories = {"space-fabrication"}
  })

make_structure("space-supercomputer-1", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 5, subgroup="space-computing-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/supercomputer-1.png",
  crafting_categories = {"space-supercomputing-1"}
  })

make_structure("space-supercomputer-2", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 5, subgroup="space-computing-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/supercomputer-2.png",
  crafting_categories = {"space-supercomputing-1", "space-supercomputing-2"}
  })

make_structure("space-supercomputer-3", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 5, subgroup="space-computing-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/supercomputer-3.png",
  crafting_categories = {"space-supercomputing-1", "space-supercomputing-2", "space-supercomputing-3"}
  })

make_structure("space-telescope-radio", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 9, subgroup="space-astronomic-structures"}, { order="a[telescope]-a",
  icon = "__space-exploration-graphics__/graphics/icons/telescope-radio.png",
  crafting_categories = {"space-observation-radio"}
  })

make_structure("space-telescope-microwave", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-astronomic-structures"}, { order="a[telescope]-b",
  icon = "__space-exploration-graphics__/graphics/icons/telescope-microwave.png",
  crafting_categories = {"space-observation-microwave"}
  })

make_structure("space-telescope", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 3, subgroup="space-astronomic-structures"}, { order="a[telescope]-c",
  icon = "__space-exploration-graphics__/graphics/icons/telescope.png",
  crafting_categories = {"space-observation-visible", "space-observation-uv", "space-observation-infrared"}
  })

make_structure("space-telescope-xray", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 5, subgroup="space-astronomic-structures"}, { order="a[telescope]-d",
  icon = "__space-exploration-graphics__/graphics/icons/telescope-xray.png",
  crafting_categories = {"space-observation-xray"}
  })

make_structure("space-telescope-gammaray", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 5, subgroup="space-astronomic-structures"}, { order="a[telescope]-e",
  icon = "__space-exploration-graphics__/graphics/icons/telescope-gammaray.png",
  crafting_categories = {"space-observation-gammaray"}
  })

make_structure("space-thermodynamics-laboratory", {make_item = true, make_recipe=true, ingredients = {{"iron-plate", 1}},
  square = 7, subgroup="space-material-structures"}, {
  icon = "__space-exploration-graphics__/graphics/icons/thermodynamics-laboratory.png",
  crafting_categories = {"space-thermodynamics"}
  })
]]--
