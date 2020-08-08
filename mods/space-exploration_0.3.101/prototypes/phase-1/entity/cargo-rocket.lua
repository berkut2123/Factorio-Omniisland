local data_util = require("data_util")

local side_thruster_offset = 40
local bottom_thruster_offset = 89

data:extend({
  {
    type = "container",
    name = data_util.mod_prefix .. "cargo-rocket-cargo-pod", -- "rocket-launch-pad-chest"
    circuit_connector_sprites = nil,
    circuit_wire_connection_point = nil,
    circuit_wire_max_distance = 0,
    close_sound = {
      filename = "__base__/sound/metallic-chest-close.ogg",
      volume = 0.7
    },
    collision_box = {{-0.95, -0.95}, {0.95, 0.95}},
    selection_box = {{-0.95, -0.95}, {0.95, 0.95}},
    corpse = "medium-remnants",
    flags = {
      "placeable-neutral",
      "player-creation"
    },
    icon = "__space-exploration-graphics__/graphics/icons/cargo-pod.png",
    icon_size = 32,
    inventory_size = math.ceil(rocket_capacity / 0.9 / 100 ) * 10, --can fit all partial stacks if 9/10 pods land
    max_health = 1000,
    minable = {
      mining_time = 0.2,
      result = data_util.mod_prefix .. "cargo-rocket-cargo-pod"
    },
    open_sound = {
      filename = "__base__/sound/metallic-chest-open.ogg",
      volume = 0.65
    },
    order = "z-z",
    picture = {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/cargo-pod/cargo-pod.png",
          height = 194,
          priority = "extra-high",
          shift = { 1/32, 1/32 },
          width = 147,
          scale = 0.35
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/cargo-pod/cargo-pod-shadow.png",
          height = 164,
          priority = "extra-high",
          shift = { 10/32, 6/32 },
          width = 167,
          scale = 0.35
        },
      }
    },
    resistances = {
      {
        percent = 90,
        type = "fire"
      },
      {
        percent = 90,
        type = "explosion"
      },
      {
        percent = 100,
        type = "poison"
      },
      {
        percent = 60,
        type = "impact"
      }
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    }
  },
  {
    -- this only exists for the animation
    -- it won't be selectable or affected normally
    -- when ready to launch the required dummy item will be added
    -- then launch will be triggered by script
    type = "rocket-silo-rocket",
    name = data_util.mod_prefix .. "cargo-rocket",
    inventory_size = 1,
    collision_box = { { -2, -7 }, { 2, 7 } },
    collision_mask = { "not-colliding-with-itself" },
    dying_explosion = "massive-explosion",
    shadow_slave_entity = "rocket-silo-rocket-shadow",
    engine_starting_speed = 1 / (5.5 * 60),
    flying_speed = 1 / (2000 * 60),
    flying_acceleration = 0.01,
    flags = { "not-on-map" },
    flying_trigger = {
      {
        sound = {
          {
            filename = "__base__/sound/silo-rocket.ogg",
            volume = 1.8
          }
        },
        type = "play-sound"
      }
    },
    glow_light =
    {
      intensity = 1,
      size = 30,
      shift = {0, 1.5},
      color = {r = 1.0, g = 1.0, b = 1.0}
    },

    rising_speed = 1 / (7 * 60),
    rocket_initial_offset = {0, 5},
    rocket_rise_offset = {0, -5.75},
    rocket_launch_offset = {0, -256},
    rocket_render_layer_switch_distance = 10.5,--7.5,
    full_render_layer_switch_distance = 12,--9,
    effects_fade_in_start_distance = 7.5,--4.5,
    effects_fade_in_end_distance = 10.5,--7.5,
    shadow_fade_out_start_ratio = 0.25,
    shadow_fade_out_end_ratio = 0.75,
    rocket_visible_distance_from_center = 2.75,

    --[[
    rocket_shadow_sprite = {
      draw_as_shadow = true,
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/09-rocket-shadow/09-rocket-shadow.png",
      height = 128,
      priority = "medium",
      shift = {
        -2.5,
        2
      },
      width = 394
    },
    rocket_sprite = {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/02-11-rocket/02-rocket.png",
      height = 394,
      shift = {
        0,
        5.5 - (394 - 288) / 2 / 32 -- keep base aligned with flare
      },
      width = 192
    },
    ]]--

    rocket_sprite = util.add_shift_offset(util.by_pixel(0, 32*3.5), --util.mul_shift(rocket_rise_offset, -1),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/02-rocket.png",
      width = 310/2,
      height = 950/2,
      shift = util.by_pixel(-5, -27),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-02-rocket.png",
        width = 310,
        height = 950,
        shift = util.by_pixel(-5, -27),
        scale = 0.5
      }
    }),

    rocket_shadow_sprite = util.add_shift_offset(util.by_pixel(-146, -120),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/09-rocket-shadow.png",
      priority = "medium",
      width = 788/2,
      height = 256/2,
      draw_as_shadow = true,
      shift = util.by_pixel(146, 120),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-09-rocket-shadow.png",
        priority = "medium",
        width = 788,
        height = 256,
        draw_as_shadow = true,
        shift = util.by_pixel(146, 121),
        scale = 0.5
      }
    }),


    rocket_glare_overlay_sprite = util.add_shift_offset(util.by_pixel(0, 112+112),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/03-rocket-over-glare.png",
      blend_mode = "additive",
      width = 481,
      height = 481,
      shift = util.by_pixel(-2, -2 + bottom_thruster_offset),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-03-rocket-over-glare.png",
        blend_mode = "additive",
        width = 954,
        height = 954,
        shift = util.by_pixel(0, 0 + bottom_thruster_offset),
        scale = 0.5
      }
    }),
    rocket_smoke_top1_animation = util.add_shift_offset(util.by_pixel(0-66, -112+28+232+32),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/12-rocket-smoke.png",
      priority = "medium",
      tint = { r = 0.8, g = 0.8, b = 1, a = 0.8 },
      --tint = { r = 1, g = 0, b = 0, a = 0.8 },
      width = 41,
      height = 145,
      frame_count = 24,
      line_length = 8,
      animation_speed = 0.5,
      scale = 1.5*1.3,
      shift = util.by_pixel(-2, -2 + side_thruster_offset),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-12-rocket-smoke.png",
        priority = "medium",
        tint = { r = 0.8, g = 0.8, b = 1, a = 0.8 },
        --tint = { r = 1, g = 0, b = 0, a = 0.8 },
        width = 80,
        height = 286,
        frame_count = 24,
        line_length = 8,
        animation_speed = 0.5,
        scale = 1.5/2*1.3,
        shift = util.by_pixel(-1, -3 + side_thruster_offset),
      }
    }),
    rocket_smoke_top2_animation = util.add_shift_offset(util.by_pixel(0+17, -112+28+265+32),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/12-rocket-smoke.png",
      priority = "medium",
      tint = { r = 0.8, g = 0.8, b = 1, a = 0.8 },
      --tint = { r = 0, g = 1, b = 0, a = 0.8 },
      width = 41,
      height = 145,
      frame_count = 24,
      line_length = 8,
      animation_speed = 0.5,
      scale = 1.5*1.3,
      shift = util.by_pixel(-2, -2 + side_thruster_offset),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-12-rocket-smoke.png",
        priority = "medium",
        tint = { r = 0.8, g = 0.8, b = 1, a = 0.8 },
        --tint = { r = 0, g = 1, b = 0, a = 0.8 },
        width = 80,
        height = 286,
        frame_count = 24,
        line_length = 8,
        animation_speed = 0.5,
        scale = 1.5/2*1.3,
        shift = util.by_pixel(-1, -3 + side_thruster_offset),
      }
    }),
    rocket_smoke_top3_animation = util.add_shift_offset(util.by_pixel(0+48, -112+28+252+32),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/12-rocket-smoke.png",
      priority = "medium",
      tint = { r = 0.8, g = 0.8, b = 1, a = 0.8 },
      --tint = { r = 0, g = 0, b = 1, a = 0.8 },
      width = 41,
      height = 145,
      frame_count = 24,
      line_length = 8,
      animation_speed = 0.5,
      scale = 1.5*1.3,
      shift = util.by_pixel(-2, -2 + side_thruster_offset),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-12-rocket-smoke.png",
        priority = "medium",
        tint = { r = 0.8, g = 0.8, b = 1, a = 0.8 },
        --tint = { r = 0, g = 0, b = 1, a = 0.8 },
        width = 80,
        height = 286,
        frame_count = 24,
        line_length = 8,
        animation_speed = 0.5,
        scale = 1.5/2*1.3,
        shift = util.by_pixel(-1, -3 + side_thruster_offset),
      }
    }),

    rocket_smoke_bottom1_animation = util.add_shift_offset(util.by_pixel(0-69, -112+28+205+32),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/12-rocket-smoke.png",
      priority = "medium",
      tint = { r = 0.8, g = 0.8, b = 1, a = 0.7 },
      --tint = { r = 1, g = 1, b = 0, a = 0.8 },
      width = 41,
      height = 145,
      frame_count = 24,
      line_length = 8,
      animation_speed = 0.5,
      scale = 1.5*1.3,
      shift = util.by_pixel(-2, -2 + bottom_thruster_offset),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-12-rocket-smoke.png",
        priority = "medium",
        tint = { r = 0.8, g = 0.8, b = 1, a = 0.7 },
        --tint = { r = 1, g = 1, b = 0, a = 0.8 },
        width = 80,
        height = 286,
        frame_count = 24,
        line_length = 8,
        animation_speed = 0.5,
        scale = 1.5/2*1.3,
        shift = util.by_pixel(-1, -3 + bottom_thruster_offset),
      }
    }),
    rocket_smoke_bottom2_animation = util.add_shift_offset(util.by_pixel(0+62, -112+28+207+32),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/12-rocket-smoke.png",
      priority = "medium",
      tint = { r = 0.8, g = 0.8, b = 1, a = 0.7 },
      --tint = { r = 0, g = 1, b = 1, a = 0.8 },
      width = 41,
      height = 145,
      frame_count = 24,
      line_length = 8,
      animation_speed = 0.5,
      scale = 1.5*1.3,
      shift = util.by_pixel(-2, -2 + bottom_thruster_offset),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-12-rocket-smoke.png",
        priority = "medium",
        tint = { r = 0.8, g = 0.8, b = 1, a = 0.7 },
        --tint = { r = 0, g = 1, b = 1, a = 0.8 },
        width = 80,
        height = 286,
        frame_count = 24,
        line_length = 8,
        animation_speed = 0.5,
        scale = 1.5/2*1.3,
        shift = util.by_pixel(-1, -3 + bottom_thruster_offset),
      }
    }),
    rocket_flame_animation = util.add_shift_offset(util.by_pixel(-1, 280-16),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/10-jet-flame.png",
      priority = "medium",
      blend_mode = "additive",
      width = 87,
      height = 128,
      frame_count = 8,
      line_length = 8,
      animation_speed = 0.5,
      scale = 1.13,
      shift = util.by_pixel(-0.5, -2 + bottom_thruster_offset),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-10-jet-flame.png",
        priority = "medium",
        blend_mode = "additive",
        width = 172,
        height = 256,
        frame_count = 8,
        line_length = 8,
        animation_speed = 0.5,
        scale = 1.13/2,
        shift = util.by_pixel(-1, -2 + bottom_thruster_offset),
      }
    }),
    rocket_flame_left_animation = util.add_shift_offset(util.by_pixel(-32-28+3, 280-68+1),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/10-jet-flame.png",
      priority = "medium",
      blend_mode = "additive",
      width = 87,
      height = 128,
      frame_count = 8,
      line_length = 8,
      animation_speed = 0.5,
      scale = 0.345*1.15,
      shift = util.by_pixel(-0.5, -2 + bottom_thruster_offset),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-10-jet-flame.png",
        priority = "medium",
        blend_mode = "additive",
        width = 172,
        height = 256,
        frame_count = 8,
        line_length = 8,
        animation_speed = 0.5,
        scale = 0.345/2*1.15,
        shift = util.by_pixel(-1, -2 + bottom_thruster_offset),
      }
    }),
    rocket_flame_left_rotation = 0.0611,

    rocket_flame_right_animation = util.add_shift_offset(util.by_pixel(32+16, 280-50),
    {
      filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/10-jet-flame.png",
      priority = "medium",
      blend_mode = "additive",
      width = 87,
      height = 128,
      frame_count = 8,
      line_length = 8,
      animation_speed = 0.5,
      scale = 0.368*1.15,
      shift = util.by_pixel(-0.5, -2 + bottom_thruster_offset),
      hr_version = {
        filename = "__space-exploration-graphics__/graphics/entity/rocket-launch-pad/hr-10-jet-flame.png",
        priority = "medium",
        blend_mode = "additive",
        width = 172,
        height = 256,
        frame_count = 8,
        line_length = 8,
        animation_speed = 0.5,
        scale = 0.368/2*1.15,
        shift = util.by_pixel(-1, -2 + bottom_thruster_offset),
      }
    }),
    rocket_flame_right_rotation = 0.952,


  }
})
