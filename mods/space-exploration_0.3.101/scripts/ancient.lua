local Ancient = {}

--[[
IMPORTANT

The pyramids and anomaly gate puzzle in-game is supposed to be the crowning achievement of completing Space Exploration.
Please don't try to reverse engineer this code to figure out a solution to the puzzle, it will spoil it for you and for others.

]]--

-- STATIC
if true then
  -- rectangles
  Ancient.name_tech_coordinates = mod_prefix .. "long-range-star-mapping"
  Ancient.name_tech_anchor = mod_prefix .. "dimensional-anchor"
  Ancient.name_gate_tryplace = mod_prefix .. "gate-tryplace"
  Ancient.name_gate_blocker = mod_prefix .. "gate-blocker"
  Ancient.name_gate_blocker_void = mod_prefix .. "gate-blocker-void"
  Ancient.name_gate_void_sprite = mod_prefix.."gate-void-sprite"
  Ancient.name_gate_glyph_prefix = mod_prefix.."glyph-a-energy-"
  Ancient.name_gate_glyph_locked_suffix = "-locked"
  Ancient.name_gate_light = mod_prefix .. "gate-light"
  Ancient.name_gate_light_middle = mod_prefix .. "gate-light-middle"
  Ancient.name_gate_lock_combinator = mod_prefix .. "gate-lock-combinator"
  Ancient.name_gate_lock_switch = mod_prefix .. "gate-lock-switch"
  Ancient.name_gate_fluid_input = mod_prefix .. "gate-tank-input"
  Ancient.name_gate_fluid_output = mod_prefix .. "gate-tank-output"
  Ancient.name_button_player_track_glyphs = "player_track_glyphs"

  Ancient.name_gate_cloud = mod_prefix .. "gate-cloud"
  Ancient.name_gate_spec_white = mod_prefix .. "gate-spec-white"
  Ancient.name_gate_spec_cyan = mod_prefix .. "gate-spec-cyan"

  Ancient.name_sound_gate_turning = mod_prefix .. "sound-continous-gate-turning"
  Ancient.name_sound_gate_power_on = mod_prefix .. "sound-continous-gate-power-on"
  Ancient.name_sound_gate_power_up = mod_prefix .. "sound-gate-power-up"
  Ancient.name_sound_gate_power_down = mod_prefix .. "sound-gate-power-down"
  Ancient.name_sound_gate_button = mod_prefix .. "sound-gate-button"
  Ancient.name_sound_gate_lock = mod_prefix .. "sound-gate-lock"

  Ancient.timer_power_up_complete = 395 -- based on audio
  Ancient.timer_power_up_ghyph_light_interval = 3
  Ancient.timer_power_down_complete = 283
  Ancient.timer_shunt_step = 0.03
  Ancient.timer_shunt_glyph_lock = 1.09
  Ancient.timer_shunt_complete = 3.5

  Ancient.gate_temperature_resting = 25
  Ancient.gate_temperature_partial = -200 -- required for glyph lock
  Ancient.gate_temperature_required = -250 -- required for gate activation
  Ancient.gate_temperature_zero = -273.15
  Ancient.gate_temperature_per_coolant_max = 1
  Ancient.gate_temperature_per_coolant_min = 0.001 -- lerp between resting and zero
  Ancient.gate_temperature_return_per_tick = 0.00001 -- multiplied by -temp
  Ancient.gate_temperature_while_powered = 0.001
  Ancient.gate_temperature_while_turning = 0.01
  Ancient.gate_temperature_while_locked = 0.1
  Ancient.gate_temperature_while_portal = 1

  Ancient.gate_cloud_tint_1 = {r = 0.2, g = 0.6, b = 1}
  Ancient.gate_cloud_tint_2 = {r = 0.2, g = 0.2, b = 1}

  Ancient.vault_entrance_structures = { -- also used in zone deletion
    mod_prefix .. "pyramid-a",
    mod_prefix .. "pyramid-b",
    mod_prefix .. "pyramid-c",
  }

  Ancient.gate_default_position = {x =0, y = -128}
  Ancient.galaxy_ship_default_position = {x = 100, y = -400}

  -- rows
  Ancient.gate_blockers_phase_1 = {
    [-26] = {{-8,9}},
    [-25] = {{-15,5}},
    [-24] = {{-16,5}},
    [-23] = {{-18,5}},
    [-22] = {{-20,5}},
    [-21] = {{-22,-9}},
    [-20] = {{-24,-13}, {23,25}},
    [-19] = {{-25,-16}},
    [-18] = {{-27,-18}},
    [-17] = {{-28,-20}, {21,23}},
    [-16] = {{-29,-21}, {22,23}},
    [-15] = {{-30,-22}},
    [-14] = {{-31,-24}},
    [-13] = {{-32,-25}},
    [-12] = {{-34,-26}},
    [-11] = {{-34,-27}},
    [-10] = {{-34,-27}},
    [-9] = {{-34,-28}},
    [-8] = {{-34,-28}, {29,31}},
    [-7] = {{-34,-29}, {30,31}},
    [-6] = {{-35,-29}, {30,31}, {35,36}},
    [-5] = {{-35,-30}, {35,36}},
    [-4] = {{-35,-30}},
    [-3] = {{-35,-30}},
    [-2] = {{-35,-30}},
    [-1] = {{-35,-30}},
    [0] = {{-35,-30}},
    [1] = {{-35,-30}},
    [2] = {{-35,-30}},
    [3] = {{-35,-30}, {35,36}},
    [4] = {{-35,-30}, {35,36}},
    [5] = {{-34,-29}},
    [6] = {{-34,-29}},
    [7] = {{-34,-28}},
    [8] = {{-34,-28}},
    [9] = {{-34,-27}},
    [10] = {{-34,-26}, {27,28}},
    [11] = {{-32,-28}, {26,28}},
    [12] = {{-31,-28}, {25,28}},
    [13] = {{-30,-28}, {29,31}},
    [14] = {{-29,-28}, {29,30}},
    [15] = {{21,23}},
    [16] = {{-20,-19}},
    [17] = {{-25,-23}, {18,19}, {25,26}},
    [18] = {{-24,-23}},
    [20] = {{8,9}},
    [24] = {{-8,-7}},
    [25] = {{-5,6}},
    [26] = {{-4,5}},
  }
  Ancient.gate_blockers_void_phase_1 = {
    [-21] = {{-9,5}},
    [-20] = {{-13,5}},
    [-19] = {{-16,5}},
    [-18] = {{-18,5}},
    [-17] = {{-20,21}},
    [-16] = {{-21,22}},
    [-15] = {{-22,23}},
    [-14] = {{-24,23}},
    [-13] = {{-25,23}},
    [-12] = {{-26,23}},
    [-11] = {{-27,23}},
    [-10] = {{-27,23}},
    [-9] = {{-28,23}},
    [-8] = {{-28,29}},
    [-7] = {{-29,30}},
    [-6] = {{-29,30}},
    [-5] = {{-30,31}},
    [-4] = {{-30,31}},
    [-3] = {{-30,31}},
    [-2] = {{-30,31}},
    [-1] = {{-30,31}},
    [0] = {{-30,31}},
    [1] = {{-30,31}},
    [2] = {{-30,31}},
    [3] = {{-30,28}},
    [4] = {{-30,28}},
    [5] = {{-29,28}},
    [6] = {{-29,28}},
    [7] = {{-28,28}},
    [8] = {{-28,28}},
    [9] = {{-27,28}},
    [10] = {{-26,27}},
    [11] = {{-20,26}},
    [12] = {{-20,25}},
    [13] = {{-20,23}},
    [14] = {{-20,23}},
    [15] = {{-20,21}},
    [16] = {{-19,19}},
    [17] = {{-7,18}},
    [18] = {{-7,9}},
    [19] = {{-7,9}},
    [20] = {{-7,8}},
  }
  Ancient.gate_blockers_phase_2 = {
    [-25] = {{5,16}},
    [-24] = {{5,17}},
    [-23] = {{5,19}},
    [-22] = {{5,21}},
    [-21] = {{10,23}},
    [-20] = {{14,23}},
    [-19] = {{17,26}},
    [-18] = {{19,28}},
    [-17] = {{23,29}},
    [-16] = {{23,30}},
    [-15] = {{23,31}},
    [-14] = {{25,32}},
    [-13] = {{26,33}},
    [-12] = {{27,35}},
    [-11] = {{28,35}},
    [-10] = {{28,35}},
    [-9] = {{29,35}},
    [-8] = {{31,35}},
    [-7] = {{31,35}},
    [-6] = {{31,35}},
    [-5] = {{31,35}},
    [-4] = {{31,36}},
    [-3] = {{31,36}},
    [-2] = {{31,36}},
    [-1] = {{31,36}},
    [0] = {{31,36}},
    [1] = {{31,36}},
    [2] = {{31,36}},
    [3] = {{31,35}},
    [4] = {{31,35}},
    [5] = {{30,35}},
    [6] = {{30,35}},
    [7] = {{29,35}},
    [8] = {{29,35}},
    [9] = {{28,35}},
    [10] = {{28,35}},
    [11] = {{-28,-25}, {28,33}},
    [12] = {{-28,-24}, {28,32}},
    [13] = {{-28,-23}, {24,29}},
    [14] = {{-28,-22}, {23,29}},
    [15] = {{-28,-20}, {23,29}},
    [16] = {{-27,-20}, {20,28}},
    [17] = {{-23,-17}, {19,25}},
    [18] = {{-23,-15}, {16,25}},
    [19] = {{-22,-10}, {11,23}},
    [20] = {{-20,-7}, {9,21}},
    [21] = {{-18,19}},
    [22] = {{-16,17}},
    [23] = {{-15,16}},
    [24] = {{-7,9}},
  }
  Ancient.gate_blockers_void_phase_2 = {
    [-21] = {{5,10}},
    [-20] = {{5,14}},
    [-19] = {{5,17}},
    [-18] = {{5,19}},
    [-14] = {{23,25}},
    [-13] = {{23,26}},
    [-12] = {{23,27}},
    [-11] = {{23,28}},
    [-10] = {{23,28}},
    [-9] = {{23,29}},
    [3] = {{28,31}},
    [4] = {{28,31}},
    [5] = {{28,30}},
    [6] = {{28,30}},
    [7] = {{28,29}},
    [8] = {{28,29}},
    [11] = {{-25,-20}},
    [12] = {{-24,-20}},
    [13] = {{-23,-20}, {23,24}},
    [14] = {{-22,-20}},
    [16] = {{19,20}},
    [17] = {{-17,-7}},
    [18] = {{-15,-7}, {9,16}},
    [19] = {{-10,-7}, {9,11}},
  }
  Ancient.gate_fragments = {
    [mod_prefix .. "gate-fragment-1"] = {placeable = true, position = {x = 28, y = -10}, required_position = {14,23}},
    [mod_prefix .. "gate-fragment-2"] = {placeable = true, position = {x = 39, y = -3}, required_position = {1,22}},
    [mod_prefix .. "gate-fragment-3"] = {placeable = true, position = {x = 38, y = 9.5}, required_position = {-13,20.5}},
    [mod_prefix .. "gate-fragment-4"] = {placeable = true, position = {x = 41, y = 19}, required_position = {-24,14}},
    [mod_prefix .. "gate-fragment-5"] = {placeable = true, position = {x = 40, y = 28}, required_position = {24,18}},
    [mod_prefix .. "gate-fragment-6"] = {placeable = true, position = {x = 0, y = 24}, required_position = {21,17}},
    [mod_prefix .. "gate-fragment-7"] = {placeable = true, position = {x = -23, y = 15}, required_position = {26,15}},
    [mod_prefix .. "gate-fragment-8"] = {placeable = true, position = {x = 27.5, y = 26}, required_position = {31.5,8}},
    [mod_prefix .. "gate-fragment-9"] = {placeable = true, position = {x = 52.5, y = 28.5}, required_position = {33.5,0.5}},
    [mod_prefix .. "gate-fragment-10"] = {placeable = true, position = {x = 12, y = -19}, required_position = {32,-5}},
    [mod_prefix .. "gate-fragment-11"] = {placeable = true, position = {x = 24, y = -18}, required_position = {34,-7}},
    [mod_prefix .. "gate-fragment-12"] = {placeable = true, position = {x = 16, y = 24.5}, required_position = {30,-12.5}},
    [mod_prefix .. "gate-fragment-13"] = {placeable = true, position = {x = -17, y = 21}, required_position = {14,-23}},
    [mod_prefix .. "gate-fragment-14-a"] = {placeable = false, position = {x = -28, y = -4}},
    [mod_prefix .. "gate-fragment-14-b"] = {placeable = false, position = {x = -8.5, y = -24}},
  }
  Ancient.gate_parts_main = {
    [mod_prefix .. "gate-main-e"] = {32,0},
    [mod_prefix .. "gate-main-en"] = {28.5,-15.5},
    [mod_prefix .. "gate-main-es"] = {28.5,15},
    [mod_prefix .. "gate-main-n"] = {0.5,-23},
    [mod_prefix .. "gate-main-ne"] = {17.5,-20.5},
    [mod_prefix .. "gate-main-nw"] = {-16.5,-20.5},
    [mod_prefix .. "gate-main-s"] = {0.5,22.5},
    [mod_prefix .. "gate-main-se"] = {16.5,19.5},
    [mod_prefix .. "gate-main-sw"] = {-15.5,19.5},
    [mod_prefix .. "gate-main-w"] = {-31,0},
    [mod_prefix .. "gate-main-wn"] = {-27.5,-15.5},
    [mod_prefix .. "gate-main-ws"] = {-27.5,15},
  }
  Ancient.gate_parts_main_shadow = {
    [mod_prefix .. "gate-main-e-shadow"] = {35.5,0},
    [mod_prefix .. "gate-main-en-shadow"] = {30.0,-14.5},
    [mod_prefix .. "gate-main-es-shadow"] = {28.5,15},
    [mod_prefix .. "gate-main-ne-shadow"] = {16.0,-20.5},
    [mod_prefix .. "gate-main-s-shadow"] = {0.5,24.0},
    [mod_prefix .. "gate-main-se-shadow"] = {16.5,21.5},
    [mod_prefix .. "gate-main-sw-shadow"] = {-15.5,21.5},
    [mod_prefix .. "gate-main-w-shadow"] = {-34,0},
    [mod_prefix .. "gate-main-ws-shadow"] = {-27.5,15},
  }
  Ancient.gate_parts_underlay = {
    [mod_prefix .. "gate-underlay-e"] = {32.5,-1},
    [mod_prefix .. "gate-underlay-en"] = {28,-15},
    [mod_prefix .. "gate-underlay-es"] = {27.5,12.5},
    [mod_prefix .. "gate-underlay-n"] = {0.5,-23.5},
    [mod_prefix .. "gate-underlay-ne"] = {19,-20},
    [mod_prefix .. "gate-underlay-nw"] = {-18,-20},
    [mod_prefix .. "gate-underlay-s"] = {0.5,22},
    [mod_prefix .. "gate-underlay-se"] = {19.5,19},
    [mod_prefix .. "gate-underlay-sw"] = {-18.5,19},
    [mod_prefix .. "gate-underlay-w"] = {-31.5,-1},
    [mod_prefix .. "gate-underlay-wn"] = {-27,-15},
    [mod_prefix .. "gate-underlay-ws"] = {-26.5,12.5},
  }
  Ancient.gate_parts_rails = {
    [mod_prefix .. "gate-rails-1"] = {-12.5,21},
    [mod_prefix .. "gate-rails-2"] = {-30.5,8},
    [mod_prefix .. "gate-rails-3"] = {-30.5,-10},
    [mod_prefix .. "gate-rails-4"] = {-12.5,-23},
    [mod_prefix .. "gate-rails-5"] = {13.5,-23},
    [mod_prefix .. "gate-rails-6"] = {31.5,-10},
    [mod_prefix .. "gate-rails-7"] = {31.5,8},
    [mod_prefix .. "gate-rails-8"] = {13.5,21},
  }
  Ancient.gate_parts_shunts = {
    [1] = {name = mod_prefix .. "gate-shunt-1", position = {-13,21.5}, lock_offset = {0.45,-0.8}},
    [2] = {name = mod_prefix .. "gate-shunt-2", position = {-31,8.5}, lock_offset = {1.1,-0.4}},
    [3] = {name = mod_prefix .. "gate-shunt-3", position = {-31,-10.5}, lock_offset = {1.1,0.4}},
    [4] = {name = mod_prefix .. "gate-shunt-4", position = {-13,-23.5}, lock_offset = {0.45,0.8}},
    [5] = {name = mod_prefix .. "gate-shunt-5", position = {14,-23.5}, lock_offset = {-0.45,0.8}},
    [6] = {name = mod_prefix .. "gate-shunt-6", position = {32,-10.5}, lock_offset = {-1.1,0.4}},
    [7] = {name = mod_prefix .. "gate-shunt-7", position = {32,8.5}, lock_offset = {-1.1,-0.4}},
    [8] = {name = mod_prefix .. "gate-shunt-8", position = {14,21.5}, lock_offset = {-0.45,-0.8}},
  }
  Ancient.gate_parts_addons = {
    [mod_prefix .. "gate-addon-1"] = {-13,22},
    [mod_prefix .. "gate-addon-2"] = {-32,9},
    [mod_prefix .. "gate-addon-3"] = {-32,-10},
    [mod_prefix .. "gate-addon-4"] = {-13,-23},
    [mod_prefix .. "gate-addon-5"] = {14,-23},
    [mod_prefix .. "gate-addon-6"] = {33,-10},
    [mod_prefix .. "gate-addon-7"] = {33,9},
    [mod_prefix .. "gate-addon-8"] = {14,22},
  }
  Ancient.gate_parts_lock_combinators = {
    [1] = {direction = defines.direction.south, position = {-13.062, 23.543}},
    [2] = {direction = defines.direction.west, position = {-33.644, 8.933}},
    [3] = {direction = defines.direction.west, position = {-33.625, -9.476}},
    [4] = {direction = defines.direction.north, position = {-12.968, -24.746}},
    [5] = {direction = defines.direction.north, position = {13.675, -24.753}},
    [6] = {direction = defines.direction.east, position = {34.468, -10.558}},
    [7] = {direction = defines.direction.east, position = {34.582, 8.433}},
    [8] = {direction = defines.direction.south, position = {13.96, 23.519}},
  }
  Ancient.gate_parts_lock_fluid_inputs = {
    [1] = {direction = defines.direction.south, position = {-14.5, 23.5}},
    [2] = {direction = defines.direction.west, position = {-33.5, 7.5}},
    [3] = {direction = defines.direction.west, position = {-33.5, -11.5}},
    [4] = {direction = defines.direction.north, position = {-11.5, -24.5}},
    [5] = {direction = defines.direction.north, position = {15.5, -24.5}},
    [6] = {direction = defines.direction.east, position = {34.5, -8.5}},
    [7] = {direction = defines.direction.east, position = {34.5, 10.5}},
    [8] = {direction = defines.direction.south, position = {12.5, 23.5}},
  }
  Ancient.gate_parts_lock_fluid_outputs = {
    [1] = {direction = defines.direction.south, position = {-11.5, 23.5}},
    [2] = {direction = defines.direction.west, position = {-33.5, 10.5}},
    [3] = {direction = defines.direction.west, position = {-33.5, -8.5}},
    [4] = {direction = defines.direction.north, position = {-14.5, -24.5}},
    [5] = {direction = defines.direction.north, position = {12.5, -24.5}},
    [6] = {direction = defines.direction.east, position = {34.5, -11.5}},
    [7] = {direction = defines.direction.east, position = {34.5, 7.5}},
    [8] = {direction = defines.direction.south, position = {15.5, 23.5}},
  }
  Ancient.gate_parts_platform = {
    name = mod_prefix .. "gate-platform",
    name_scaffold = mod_prefix .. "gate-platform-scaffold",
    position = {0.5,25},
    energy_interface = {
      name = mod_prefix .. "gate-energy-interface",
      position = {0.5,25}
    },
    buttons = {
      name_switch = mod_prefix .. "gate-platform-button-switch",
      left = {name = mod_prefix .. "gate-platform-button-left", position = {2.5234,26.04}, switch_position = {2.5234,26.04}},
      middle = {name = mod_prefix .. "gate-platform-button-middle", position = {3.37,26.04}, switch_position = {3.37,26.04}},
      right = {name = mod_prefix .. "gate-platform-button-right", position = {4.19,26.04}, switch_position = {4.19,26.04}},
    },
    indicators = {
      names  = {
        [1] = mod_prefix .. "gate-platform-indicator-red",
        [2] = mod_prefix .. "gate-platform-indicator-yellow",
        [3] = mod_prefix .. "gate-platform-indicator-green",
      },
      x_start = -2.789,
      x_spacing = 7/32,
      anchor_y = 24.859,
      temperature_y = 25.421,
      lock_y = 25.984,
    },
    combinator = {
      name = mod_prefix .. "gate-platform-combinator",
      position = {4.55, 26.2}
    }
  }
  Ancient.gate_sound_positions = {
    [1] = {-13,21.5},
    [2] = {-31,8.5},
    [3] = {-31,-10.5},
    [4] = {-13,-23.5},
    [5] = {14,-23.5},
    [6] = {32,-10.5},
    [7] = {32,8.5},
    [8] = {14,21.5},
    [9] = {0.5,25}, -- platform
  }


  Ancient.gate_glyphs_x = 0.5
  Ancient.gate_glyphs_x_mult = 33.4
  Ancient.gate_glyphs_y = -0.9
  Ancient.gate_glyphs_y_mult = 23.55

  Ancient.gate_parts_locked_glyphs = {
    [1] = {-11.75,19.91},
    [2] = {-29.09,7.64},
    [3] = {-29.09,-9.66},
    [4] = {-11.75,-21.91},
    [5] = {12.75,-21.91},
    [6] = {30.09,-9.66},
    [7] = {30.09,7.64},
    [8] = {12.75,19.91},
  }

  Ancient.gate_acceleration = 0.002
  Ancient.gate_decceleration = 0.02
  Ancient.gate_max_speed = 0.1

  Ancient.pyramid_width = 9*2
  Ancient.pyramid_height = 7*2
  Ancient.cartouche_path_width = 4
  Ancient.cartouche_path_wall_width = 12
  Ancient.cartouche_path_start = 0
  Ancient.cartouche_path_wall_start = 30
  Ancient.cartouche_path_end = 40
  Ancient.cartouche_path_wall_end= 100
end

local crypto = 0
local cryptl = 1
local cryptf = 5
local cryptc = 8
local crypte = 11
local crypti = 60
local cryptr = cryptl+math.sqrt(cryptf)
local cryptg = (cryptr)/2
local crypta = (cryptl+cryptr)/3
local cryptb = (cryptr)/6

local cryptx = {
cryptl,cryptg,crypto,cryptl,-cryptg,crypto,-cryptl,cryptg,crypto,-cryptl,
-cryptg,crypto,cryptg,crypto,cryptl,cryptg,crypto,-cryptl,-cryptg,crypto,
cryptl,-cryptg,crypto,-cryptl,crypto,cryptl,cryptg,crypto,cryptl,-cryptg,
crypto,-cryptl,cryptg,crypto,-cryptl,-cryptg,cryptl,cryptl,cryptl,cryptl,
cryptl,-cryptl,cryptl,-cryptl,cryptl,cryptl,-cryptl,-cryptl,-cryptl,cryptl,
cryptl,-cryptl,cryptl,-cryptl,-cryptl,-cryptl,cryptl,-cryptl,-cryptl,-cryptl,
crypta,cryptb,crypto,crypta,-cryptb,crypto,-crypta,cryptb,crypto,-crypta,
-cryptb,crypto,cryptb,crypto,crypta,cryptb,crypto,-crypta,-cryptb,crypto,
crypta,-cryptb,crypto,-crypta,crypto,crypta,cryptb,crypto,crypta,-cryptb,
crypto,-crypta,cryptb,crypto,-crypta,-cryptb}

local cryptv = { 1,29,30,1,30,14,1,14,21,1,21,13,1,13,29,2,32,31,2,31,15,2,15,
22,2,22,16,2,16,32,3,30,29,3,29,17,3,17,23,3,23,18,3,18,30,4,31,32,4,32,20,4,20,
24,4,24,19,4,19,31,5,21,22,5,22,15,5,15,25,5,25,13,5,13,21,6,22,21,6,21,14,6,14,
26,6,26,16,6,16,22,7,24,23,7,23,17,7,17,27,7,27,19,7,19,24,8,23,24,8,24,20,8,20,
28,8,28,18,8,18,23,9,25,27,9,27,17,9,17,29,9,29,13,9,13,25,10,28,26,10,26,14,10,
14,30,10,30,18,10,18,28,11,27,25,11,25,15,11,15,31,11,31,19,11,19,27,12,26,28,
12,28,20,12,20,32,12,32,16,12,16,26 }

local cryptn = { 2,5,11,15,49,48,3,4,44,43,12,3,1,48,47,28,27,4,5,11,15,49,4,2,
27,26,21,25,5,1,48,47,28,5,3,25,24,45,44,1,2,27,26,21,1,4,44,43,12,11,2,3,25,24,
45,7,10,16,20,54,53,8,9,59,58,17,8,6,53,52,23,22,9,10,16,20,54,9,7,22,21,26,30,
10,6,53,52,23,10,8,30,29,60,59,6,7,22,21,26,6,9,59,58,17,16,7,8,30,29,60,12,15,
1,5,44,43,13,14,49,48,2,13,11,43,42,33,32,14,15,1,5,44,14,12,32,31,36,40,15,11,
43,42,33,15,13,40,39,50,49,11,12,32,31,36,11,14,49,48,2,1,12,13,40,39,50,17,20,
6,10,59,58,18,19,54,53,7,18,16,58,57,38,37,19,20,6,10,59,19,17,37,36,31,35,20
,16,58,57,38,20,18,35,34,55,54,16,17,37,36,31,16,19,54,53,7,6,17,18,35,34,55,22,
25,26,30,9,8,23,24,4,3,27,23,21,8,7,53,52,24,25,26,30,9,24,22,52,51,41,45,25,21,
8,7,53,25,23,45,44,5,4,21,22,52,51,41,21,24,4,3,27,26,22,23,45,44,5,27,30,21,25,
4,3,28,29,9,8,22,28,26,3,2,48,47,29,30,21,25,4,29,27,47,46,56,60,30,26,3,2,48,
30,28,60,59,10,9,26,27,47,46,56,26,29,9,8,22,21,27,28,60,59,10,32,35,36,40,14,
13,33,34,19,18,37,33,31,13,12,43,42,34,35,36,40,14,34,32,42,41,51,55,35,31,13,
12,43,35,33,55,54,20,19,31,32,42,41,51,31,34,19,18,37,36,32,33,55,54,20,37,40,
31,35,19,18,38,39,14,13,32,38,36,18,17,58,57,39,40,31,35,19,39,37,57,56,46,50,
40,36,18,17,58,40,38,50,49,15,14,36,37,57,56,46,36,39,14,13,32,31,37,38,50,49,
15,42,45,51,55,34,33,43,44,24,23,52,43,41,33,32,13,12,44,45,51,55,34,44,42,12,
11,1,5,45,41,33,32,13,45,43,5,4,25,24,41,42,12,11,1,41,44,24,23,52,51,42,43,5,4,
25,47,50,56,60,29,28,48,49,39,38,57,48,46,28,27,3,2,49,50,56,60,29,49,47,2,1,11,
15,50,46,28,27,3,50,48,15,14,40,39,46,47,2,1,11,46,49,39,38,57,56,47,48,15,14,
40,52,55,41,45,24,23,53,54,34,33,42,53,51,23,22,8,7,54,55,41,45,24,54,52,7,6,16,
20,55,51,23,22,8,55,53,20,19,35,34,51,52,7,6,16,51,54,34,33,42,41,52,53,20,19,
35,57,60,46,50,39,38,58,59,29,28,47,58,56,38,37,18,17,59,60,46,50,39,59,57,17,
16,6,10,60,56,38,37,18,60,58,10,9,30,29,56,57,17,16,6,56,59,29,28,47,46,57,58,
10,9,30 }

local crypts = {3,4,5,6,1,7,8,2,9,10,11}

local cryptt = { 7,0,0,-1,-1,3,6,1,0,-4,3,6,6,0,0,1,4,2,6,0,1,3,-2,8,5,2,0,-9,6,
11,5,1,0,2,7,5,5,1,1,6,8,13,5,0,1,4,9,7,5,0,2,8,-5,15,4,3,0,-16,11,18,4,2,0,5,
12,10,4,2,1,11,13,20,4,1,1,7,14,12,4,1,2,13,15,22,4,0,2,9,16,14,4,0,3,15,-10,24,
3,4,0,-25,18,27,3,3,0,10,19,17,3,3,1,18,20,29,3,2,1,12,21,19,3,2,2,20,22,31,3,1,
2,14,23,21,3,1,3,22,24,33,3,0,3,16,25,23,3,0,4,24,-17,35,2,5,0,-36,27,38,2,4,0,
17,28,26,2,4,1,27,29,40,2,3,1,19,30,28,2,3,2,29,31,42,2,2,2,21,32,30,2,2,3,31,
33,44,2,1,3,23,34,32,2,1,4,33,35,46,2,0,4,25,36,34,2,0,5,35,-26,48,1,6,0,-49,38,
51,1,5,0,26,39,37,1,5,1,38,40,53,1,4,1,28,41,39,1,4,2,40,42,55,1,3,2,30,43,41,1,
3,3,42,44,57,1,2,3,32,45,43,1,2,4,44,46,59,1,1,4,34,47,45,1,1,5,46,48,61,1,0,5,
36,49,47,1,0,6,48,-37,63,0,7,0,-64,51,-64,0,6,0,37,52,50,0,6,1,51,53,-62,0,5,1,
39,54,52,0,5,2,53,55,-60,0,4,2,41,56,54,0,4,3,55,57,-58,0,3,3,43,58,56,0,3,4,57,
59,-56,0,2,4,45,60,58,0,2,5,59,61,-54,0,1,5,47,62,60,0,1,6,61,63,-52,0,0,6,49,
64,62,0,0,7,63,-50,-50 }

function Ancient.cryptf1(a)
  local b = cryptt[a*6-5]
  local c = cryptt[a*6-4]
  local d = cryptt[a*6-3]
  if not (b + c + d == 6) then
    return {{(b + 1)/cryptc, c/cryptc, d/cryptc},{b/cryptc, (c + 1)/cryptc, d/cryptc},{b/cryptc, c/cryptc, (d + 1)/cryptc}}
  else
    return {{b/cryptc, (c + 1)/cryptc, (d + 1)/cryptc},{(b + 1)/cryptc, c/cryptc, (d + 1)/cryptc},{(b + 1)/cryptc, (c + 1)/cryptc, d/cryptc}}
  end
end

function Ancient.cryptf2(a,b,c,d)
  local e = {a[1],a[2],a[3]}
  local f = {b[1],b[2],b[3]}
  local g = {c[1],c[2],c[3]}
  if d then
    for _, h in pairs(d) do
      local w = Ancient.cryptf1(h)
      local n2a = {
        e[1] * w[1][1] + f[1] * w[1][2] + g[1] * w[1][3],
        e[2] * w[1][1] + f[2] * w[1][2] + g[2] * w[1][3],
        e[3] * w[1][1] + f[3] * w[1][2] + g[3] * w[1][3]
      }
      local n2b = {
        e[1] * w[2][1] + f[1] * w[2][2] + g[1] * w[2][3],
        e[2] * w[2][1] + f[2] * w[2][2] + g[2] * w[2][3],
        e[3] * w[2][1] + f[3] * w[2][2] + g[3] * w[2][3]
      }
      local n2c = {
        e[1] * w[3][1] + f[1] * w[3][2] + g[1] * w[3][3],
        e[2] * w[3][1] + f[2] * w[3][2] + g[2] * w[3][3],
        e[3] * w[3][1] + f[3] * w[3][2] + g[3] * w[3][3]
      }
      e = n2a
      f = n2b
      g = n2c
    end
  end
  return {e, f, g}
end

function Ancient.cryptf3 (a)
  local b = math.sqrt(a[1]*a[1] + a[2]*a[2] + a[3]*a[3])
  return {a[1]/b, a[2]/b, a[3]/b}
end

function Ancient.cryptf4(a, b)
  local c = Ancient.cryptf5(a)
  local d = Ancient.cryptf2(c[1],c[2],c[3],b)
  return Ancient.cryptf3({
    (d[1][1] + d[2][1] + d[3][1])/3,
    (d[1][2] + d[2][2] + d[3][2])/3,
    (d[1][3] + d[2][3] + d[3][3])/3
  })
end

function Ancient.cryptf4b(a)
  local b = Ancient.gtf(a[1])
  local c = {}
  for i, j in pairs(a) do
    if i ~= 1 then table.insert(c, Ancient.gtt(j)) end
  end
  return Ancient.cryptf4(b, c)
end

function Ancient.cryptf5(a)
  local b = cryptv[a*3-2]
  local c = cryptv[a*3-1]
  local d = cryptv[a*3]
  return {
    Ancient.cryptf3({cryptx[b*3-2], cryptx[b*3-1], cryptx[b*3]}),
    Ancient.cryptf3({cryptx[c*3-2], cryptx[c*3-1], cryptx[c*3]}),
    Ancient.cryptf3({cryptx[d*3-2], cryptx[d*3-1], cryptx[d*3]})}
end

function Ancient.ftg(a)
  if not global.ftg then
    local ftg = {}
    for i = 1, crypti, 1 do ftg[i] = i end
    Util.shuffle(ftg)
    global.ftg = ftg
  end
  if a then return global.ftg[a] end
end

function Ancient.gtf(a)
  if not global.gtf then
     Ancient.ftg()
     local gtf = {}
     for i, j in pairs(global.ftg) do gtf[j] = i end
     global.gtf = gtf
  end
  if a then return global.gtf[a] end
end

function Ancient.gtt(a)
  if not global.gtt then
    local gtt = {}
    for i = 2, crypti+3, 1 do
      if not(i == 31 or i == 50) then gtt[#gtt+1] = i end
    end
    Util.shuffle(gtt)
    gtt[#gtt+1] = #gtt-10
    gtt[#gtt+1] = #gtt+3
    gtt[#gtt+1] = 1
    gtt[#gtt+1] = (#gtt-1)/2
    global.gtt = gtt
  end
  if a then return global.gtt[a] end
end

function Ancient.ttg(a)
  if not global.ttg then
     Ancient.gtt()
     local ttg = {}
     for i, j in pairs(global.gtt) do ttg[j] = i end
     global.ttg = ttg
  end
  if a then return global.ttg[a] end
end

function Ancient.cryptf6()
  if global.hcoord then return end
  Ancient.ftg()
  Ancient.gtt()
  local a = {}
  for i = 1, crypti, 1 do a[i] = i end
  Util.shuffle(a)
  local gdp = a[crypti]
  local gdpf = Ancient.gtf(gdp)
  a[crypti] = crypti+1
  a[crypti+1] = crypti+2
  a[crypti+2] = crypti+3
  a[crypti+3] = crypti+4
  Util.shuffle(a)
  local gda = {}
  local gdat = {}
  local gds = gdp
  for i = 1, cryptc-1, 1 do
    gda[i] = a[i]
    gdat[i] = Ancient.gtt(a[i])
    gds = gds .. "|" .. a[i]
  end
  global.hcoord = Ancient.cryptf4(gdpf, gdat)
  global.gds = sha2.hash256(gds)
  local vgo = {}
  for i, j in pairs(gda) do if j <= 60 then vgo[#vgo + 1] = j end end
  local b = Ancient.ftg(cryptn[(gdpf-1)*crypte + math.random(1,crypte)])
  if not Util.table_contains(vgo, b) then vgo[#vgo + 1] = b end
  while #vgo < 20 do
    local c = math.random(1,60)
    if c ~= gdp and not Util.table_contains(vgo, c) then vgo[#vgo + 1] = c end
  end
  Util.shuffle(vgo)
  local d = math.random(41,crypti)
  local e = table.deepcopy(global.ftg)
  Util.shuffle(e)
  for i, j in pairs(e) do
    if #vgo == d - 1 then vgo[#vgo + 1] = gdp end
    if j ~= gdp and not Util.table_contains(vgo, j)then vgo[#vgo + 1] = j end
  end
  global.vgo = vgo
  local gco = {}
  local f = {gdp}
  for i = 1, crypte, 1 do f[#f + 1] = Ancient.ftg(cryptn[(gdpf-1)*crypte+i]) end
  for i = 1, crypti, 1 do if not Util.table_contains(f, i) then gco[#gco+1] = i end end
  Util.shuffle(gco)
  for i = 31, crypti, 1 do f[#f+1] = gco[i] gco[i] = nil end
  Util.shuffle(f)
  for i, j in pairs(f) do gco[#gco+1] = j end
  global.gco = gco
end

function Ancient.cryptf7(a)
  a = table.deepcopy(a)
  for b,c in pairs(a) do
    a[b]=c*-1
  end
  return a
end

function Ancient.place_cartouche_a(surface, glyph, position)
  local x = position.x or position[1]
  local y = position.y or position[2]

  surface.request_to_generate_chunks({x,y}, 1)
  surface.force_generate_chunk_requests()
  local entity
  entity = surface.create_entity{
    name = mod_prefix .. "cartouche-a",
    position = {x,y}
  }
  entity.destructible = false
  entity = surface.create_entity{
    name = mod_prefix .. "glyph-a-" .. glyph ,
    position = {x,y-6/32}
  }
  entity.destructible = false
  for j = 1, crypte, 1 do
    local k = cryptn[(Ancient.gtf(glyph)-1) * crypte + crypts[j]]
    local jy = Util.cos((j-1)/crypte * 2 * Util.pi) * 4.5
    local jx = Util.sin((j-1)/crypte * 2 * Util.pi) * 6.32
    entity = surface.create_entity{
      name = mod_prefix .. "glyph-a-" .. Ancient.ftg(k).."-small",
      position = {x + jx, y + jy - 4/32}
    }
    entity.destructible = false
  end
end

function Ancient.place_cartouche_b(surface, glyph, position)
  local entity
  local x = position.x or position[1]
  local y = position.y or position[2]
  local tes = Ancient.gtt(glyph)
  surface.request_to_generate_chunks({x,y}, 1)
  surface.force_generate_chunk_requests()
  if cryptt[tes*6-5] + cryptt[tes*6-4] + cryptt[tes*6-3] > 6 then
    entity = surface.create_entity{
      name = mod_prefix .. "cartouche-b-a",
      position = {x,y}
    }
    entity.destructible = false
    entity = surface.create_entity{
      name = mod_prefix .. "glyph-b-" .. tes,
      position = {x,y-cryptc/32}
    }
    entity.destructible = false
    if cryptt[tes*6-2] > 0 then
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. cryptt[tes*6-2].."-small",
        position = {x-1.6, y-0.5}
      }
      entity.destructible = false
    end
    if cryptt[tes*6-1] > 0 then
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. cryptt[tes*6-1] .."-small",
        position = {x+1.6, y-0.5}
      }
      entity.destructible = false
    end
    if cryptt[tes*6] > 0 then
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. cryptt[tes*6] .."-small",
        position = {x, y+1.5}
      }
      entity.destructible = false
    end
  else
    entity = surface.create_entity{
      name = mod_prefix .. "cartouche-b-b",
      position = {x,y}
    }
    entity.destructible = false
    entity = surface.create_entity{
      name = mod_prefix .. "glyph-b-" .. tes,
      position = {x,y+4/32}
    }
    entity.destructible = false
    if cryptt[tes*6-2] > 0 then
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. cryptt[tes*6-2].."-small",
        position = {x, y-1.5}
      }
      entity.destructible = false
    end
    if cryptt[tes*6-1] > 0 then
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. cryptt[tes*6-1] .."-small",
        position = {x+1.6, y+0.5}
      }
      entity.destructible = false
    end
    if cryptt[tes*6] > 0 then
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. cryptt[tes*6] .."-small",
        position = {x-1.6, y+0.5}
      }
      entity.destructible = false
    end

  end
end

function Ancient.assign_zone_next_glyph(zone)
  if not(zone.type == "planet" and zone.glyph==nil) then return end
  if zone.name == "Nauvis" or zone.is_homeworld then return end
  Ancient.cryptf6()
  for _, g in pairs(global.vgo) do
    global.glyph_vaults = global.glyph_vaults or {}
    if not global.glyph_vaults[g] then
      zone.glyph = g
      global.glyph_vaults[g] = {}
      global.glyph_vaults[g][zone.index] = {
        glyph = g,
        zone_index = zone.index
      }
      if zone.surface_index then
        Ancient.make_vault_exterior(zone)
      end
      return
    end
  end
end

function Ancient.make_vault_exterior(zone)

  if zone.glyph == nil or zone.surface_index == nil then return end
  if zone.vault_pyramid and (not zone.vault_pyramid.valid) then
    zone.vault_pyramid = nil
  end
  if zone.vault_pyramid then return end

  local zone_surface = Zone.get_make_surface(zone)
  if not zone.seed then
    zone.seed = zone_surface.map_gen_settings.seed
  end
  local zrng = game.create_random_generator(zone.seed)

  local glyph = zone.glyph
  local pyramid_pos = zone.vault_pyramid_position or nil

  if not pyramid_pos then
    local base_pos
    for i = 1, 4, 1 do
      base_pos = {zrng(-256,256),zrng(-256,256)}
      zone_surface.request_to_generate_chunks(base_pos, 4)
      zone_surface.force_generate_chunk_requests()
      pyramid_pos = zone_surface.find_non_colliding_position(mod_prefix .. "pyramid-a", base_pos, 256, 1)
      if pyramid_pos then break end
    end
    if not pyramid_pos then pyramid_pos = base_pos end
  end

  local entity = Ancient.vault_entrance_structures[zrng(1,#Ancient.vault_entrance_structures)]
  local box = game.entity_prototypes[entity].collision_box
  local area = util.area_add_position(box, pyramid_pos)
  local entities = zone_surface.find_entities_filtered{
    area = area
  }
  for _, entity in pairs(entities) do
    entity.destroy()
  end
  local pyramid = zone_surface.create_entity{
    name = entity,
    position = pyramid_pos
  }
  pyramid.destructible = false
  zone.vault_pyramid = pyramid
  zone.vault_pyramid_position = pyramid_pos
end

function Ancient.make_vault_interior(zone)

    if zone.glyph == nil or zone.vault_pyramid == nil then return end
    if global.glyph_vaults[zone.glyph][zone.index].surface_index and game.surfaces[global.glyph_vaults[zone.glyph][zone.index].surface_index] then
      return -- already exists
    end

    local glyph = zone.glyph

    local surface_name = Ancient.vault_surface_name(zone, glyph)
    if game.surfaces[surface_name] then
      global.glyph_vaults[glyph][zone.index].surface_index = game.surfaces[surface_name].index
      return
    end

    local tile = "mineral-beige-dirt-1"

    local map_gen_settings = {
      autoplace_controls = {
        ["planet-size"] = { frequency = 1/1000, size = 1 }
      }
    }
    map_gen_settings.seed = glyph * 10000000
    map_gen_settings.cliff_settings = {richness = 0}
    map_gen_settings.autoplace_settings={
      ["decorative"]={
        treat_missing_as_default=false,
        settings={
          ['rock-medium-beige'] = {},
          ['rock-small-beige'] = {},
          ['rock-tiny-beige'] = {}
        }
      },
      ["entity"]={
        treat_missing_as_default=false,
        settings={
            ['rock-huge-beige'] = {},
            ['rock-big-beige'] = {},
            ['biter-spawner'] = {},
            ['spitter-spawner'] = {},
        }
      },
      ["tile"]={
        treat_missing_as_default=false,
        settings={
          --[mod_prefix.. "regolith"]={},
          [tile]={},
          ["out-of-map"]={}
        }
      },
    }
    map_gen_settings.property_expression_names = {
      ["tile:"..tile..":probability"] = "vault-land-probability",
      ["tile:out-of-map:probability"] = 0,
      ["entity:biter-spawner:probability"] = 0,
      ["entity:spitter-spawner:probability"] = 0,
    }

    local surface = game.create_surface(surface_name, map_gen_settings)

    surface.freeze_daytime = true
    surface.daytime = 0.5 -- night
    surface.min_brightness = 0.02

    surface.request_to_generate_chunks({0,0}, 2)
    surface.request_to_generate_chunks({0,32*1}, 2)
    surface.request_to_generate_chunks({0,32*2}, 2)
    surface.force_generate_chunk_requests()

    map_gen_settings.property_expression_names["entity:biter-spawner:probability"] = 0.01
    surface.map_gen_settings = map_gen_settings
    surface.regenerate_entity({"biter-spawner"})
    map_gen_settings.property_expression_names["entity:spitter-spawner:probability"] = 0.05
    surface.map_gen_settings = map_gen_settings
    surface.regenerate_entity({"spitter-spawner"})
    map_gen_settings.property_expression_names["entity:biter-spawner:probability"] = 0.05
    surface.map_gen_settings = map_gen_settings
    local entities = surface.find_entities_filtered{
      force = "enemy",
      area = {{-9,-11},{9,Ancient.cartouche_path_wall_end}}
    }
    for _, entity in pairs(entities) do entity.destroy() end


    local tiles = {}
    for i = -Ancient.cartouche_path_width/2,Ancient.cartouche_path_width/2,1 do
      for j = Ancient.cartouche_path_start,Ancient.cartouche_path_wall_start,1 do
        table.insert(tiles, {name = tile, position = {x=i,y=j}})
      end
    end

    for i = -Ancient.cartouche_path_wall_width/2,Ancient.cartouche_path_wall_width/2,1 do
      for j = Ancient.cartouche_path_wall_start+1,Ancient.cartouche_path_end,1 do
        if i >= -Ancient.cartouche_path_width/2 and i <= Ancient.cartouche_path_width/2 then
          table.insert(tiles, {name = tile, position = {x=i,y=j}})
        else
          table.insert(tiles, {name = "out-of-map", position = {x=i,y=j}})
        end
      end
    end

    for i = -Ancient.cartouche_path_wall_width/2,Ancient.cartouche_path_wall_width/2,1 do
      for j = Ancient.cartouche_path_end+1,Ancient.cartouche_path_wall_end,1 do
        table.insert(tiles, {name = "out-of-map", position = {x=i,y=j}})
      end
    end

    surface.set_tiles(tiles, true)
    local light = surface.create_entity{
      name="se-lightbeam-a",
      position = {0,Ancient.cartouche_path_end},
      target={0,0},
      speed = 0
    }
    light.destructible = false

    Ancient.place_cartouche_a(surface, glyph, {x=0,y=-6})
    Ancient.place_cartouche_b(surface, glyph, {x=0,y=4})
    local items = {"productivity-module-", "speed-module-", "effectivity-module-"}
    local chest = surface.create_entity{
       name = mod_prefix .. "cartouche-chest",
       position = {0, -14},
       force = "neutral"
    }
    chest.destructible = false



    -- mark that the module has been generated
    global.glyph_vaults_made_loot = global.glyph_vaults_made_loot or {}
    if not global.glyph_vaults_made_loot[glyph] then
      chest.insert({name = items[Ancient.gtf(zone.glyph)%#items+1].."9", amount = 1})
      global.glyph_vaults_made_loot[glyph] = true
    end

    global.glyph_vaults[glyph][zone.index].surface_index = surface.index

end

function Ancient.vault_surface_name(zone, glyph)
  if not glyph then glyph = zone.glyph end
  return "Vault "..zone.index.."."..glyph
end

function Ancient.vault_from_surface(surface)
  if string.find(surface.name, "Vault ", 1, true) then
    for glyph, vaults in pairs(global.glyph_vaults) do
      for zone_index, try_vault in pairs(vaults) do
        if try_vault.surface_index == surface.index then
          return try_vault
        end
      end
    end
  end
end

function Ancient.make_test_surface()

  if game.surfaces["vault-test"] then
    game.delete_surface("vault-test")
  end

  Ancient.ftg()

  local map_gen_settings = {
    autoplace_controls = {
      ["planet-size"] = { frequency = 1/1000, size = 1 }
    }
  }
  map_gen_settings.autoplace_settings={
    ["decorative"]={
      treat_missing_as_default=false,
      settings={
        ['rock-medium-beige'] = {},
        ['rock-small-beige'] = {},
        ['rock-tiny-beige'] = {}
      }
    },
    ["entity"]={
      treat_missing_as_default=false,
      settings={
          ['rock-huge-beige'] = {},
          ['rock-big-beige'] = {},
      }
    },
    ["tile"]={
      treat_missing_as_default=false,
      settings={
        --[mod_prefix.. "regolith"]={},
        ["mineral-beige-dirt-1"]={},
        ["out-of-map"]={}
      }
    },
  }
  map_gen_settings.property_expression_names = {
    ["tile:mineral-beige-dirt-1:probability"] = "vault-land-probability",
    ["tile:out-of-map:probability"] = 0
  }

  local surface = game.create_surface("vault-test", map_gen_settings)

  surface.freeze_daytime = true
  surface.daytime = 0.5 -- night

  surface.request_to_generate_chunks({0,0}, 1)
  surface.force_generate_chunk_requests()
  game.players[1].teleport({0,0}, surface)
  local entity

  for k = 1, crypti, 1 do
    local x = (k-1)%cryptc * 16 - 200
    local y = math.floor((k-1)/cryptc)* 20
    surface.request_to_generate_chunks({x,y}, 1)
    surface.force_generate_chunk_requests()
    entity = surface.create_entity{
      name = mod_prefix .. "cartouche-a",
      position = {x,y}
    }
    entity.destructible = false
    entity = surface.create_entity{
      name = mod_prefix .. "glyph-a-" .. Ancient.ftg(k),
      position = {x,y-6/32}
    }
    entity.destructible = false
    for j = 1, crypte, 1 do
      local k = cryptn[(k-1) * crypte + crypts[j]]
      local jy = Util.cos((j-1)/crypte * 2 * Util.pi) * 4.5
      local jx = Util.sin((j-1)/crypte * 2 * Util.pi) * 6.32
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-a-" .. Ancient.ftg(k).."-small",
        position = {x + jx, y + jy - 4/32}
      }
      entity.destructible = false
    end
    y = y + 8

    i = Ancient.gtt(Ancient.ftg(k))


    surface.request_to_generate_chunks({x,y}, 1)
    surface.force_generate_chunk_requests()
    if cryptt[i*6-5] + cryptt[i*6-4] + cryptt[i*6-3] > 6 then
      entity = surface.create_entity{
        name = mod_prefix .. "cartouche-b-a",
        position = {x,y}
      }
      entity.destructible = false
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. i,
        position = {x,y-cryptc/32}
      }
      entity.destructible = false
      if cryptt[i*6-2] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6-2].."-small",
          position = {x-1.6, y-0.5}
        }
        entity.destructible = false
      end
      if cryptt[i*6-1] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6-1] .."-small",
          position = {x+1.6, y-0.5}
        }
        entity.destructible = false
      end
      if cryptt[i*6] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6] .."-small",
          position = {x, y+1.5}
        }
        entity.destructible = false
      end
    else
      entity = surface.create_entity{
        name = mod_prefix .. "cartouche-b-b",
        position = {x,y}
      }
      entity.destructible = false
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. i,
        position = {x,y+4/32}
      }
      entity.destructible = false
      if cryptt[i*6-2] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6-2].."-small",
          position = {x, y-1.5}
        }
        entity.destructible = false
      end
      if cryptt[i*6-1] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6-1] .."-small",
          position = {x+1.6, y+0.5}
        }
        entity.destructible = false
      end
      if cryptt[i*6] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6] .."-small",
          position = {x-1.6, y+0.5}
        }
        entity.destructible = false
      end

    end


  end

  for i = 1, crypti, 1 do
    local x = (i-1)%cryptc * 16
    local y = math.floor((i-1)/cryptc)* 12
    surface.request_to_generate_chunks({x,y}, 1)
    surface.force_generate_chunk_requests()
    entity = surface.create_entity{
      name = mod_prefix .. "cartouche-a",
      position = {x,y}
    }
    entity.destructible = false
    entity = surface.create_entity{
      name = mod_prefix .. "glyph-a-" .. Ancient.ftg(i),
      position = {x,y-6/32}
    }
    entity.destructible = false
    for j = 1, crypte, 1 do
      local k = cryptn[(i-1) * crypte + crypts[j]]
      local jy = Util.cos((j-1)/crypte * 2 * Util.pi) * 4.5
      local jx = Util.sin((j-1)/crypte * 2 * Util.pi) * 6.32
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-a-" .. Ancient.ftg(k).."-small",
        position = {x + jx, y + jy - 4/32}
      }
      entity.destructible = false
    end
  end

  for i = 1, crypti+4, 1 do
    local x = -16 - (i-1)%cryptc * cryptc
    local y = math.floor((i-1)/cryptc)* 5
    y = - 16 - cryptt[i*6-5] * 5
    x = (-cryptt[i*6-4] + cryptt[i*6-3]) * 8
    surface.request_to_generate_chunks({x,y}, 1)
    surface.force_generate_chunk_requests()
    if cryptt[i*6-5] + cryptt[i*6-4] + cryptt[i*6-3] > 6 then
      entity = surface.create_entity{
        name = mod_prefix .. "cartouche-b-a",
        position = {x,y}
      }
      entity.destructible = false
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. i,
        position = {x,y-cryptc/32}
      }
      entity.destructible = false
      if cryptt[i*6-2] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6-2].."-small",
          position = {x-1.6, y-0.5}
        }
        entity.destructible = false
      end
      if cryptt[i*6-1] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6-1] .."-small",
          position = {x+1.6, y-0.5}
        }
        entity.destructible = false
      end
      if cryptt[i*6] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6] .."-small",
          position = {x, y+1.5}
        }
        entity.destructible = false
      end
    else
      entity = surface.create_entity{
        name = mod_prefix .. "cartouche-b-b",
        position = {x,y}
      }
      entity.destructible = false
      entity = surface.create_entity{
        name = mod_prefix .. "glyph-b-" .. i,
        position = {x,y+4/32}
      }
      entity.destructible = false
      if cryptt[i*6-2] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6-2].."-small",
          position = {x, y-1.5}
        }
        entity.destructible = false
      end
      if cryptt[i*6-1] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6-1] .."-small",
          position = {x+1.6, y+0.5}
        }
        entity.destructible = false
      end
      if cryptt[i*6] > 0 then
        entity = surface.create_entity{
          name = mod_prefix .. "glyph-b-" .. cryptt[i*6] .."-small",
          position = {x-1.6, y+0.5}
        }
        entity.destructible = false
      end

    end

  end

  return surface
end

function Ancient.make_gate_blockers(surface, position, set, name)
  for y, row in pairs(set) do
    for _, start_end in pairs(row) do
      for x = start_end[1], start_end[2]-1, 1 do
        local entity = surface.create_entity{
          name = name,
          position = {x = position.x + x, y = position.y + y}
        }
        entity.destructible = false
      end
    end
  end
end

function Ancient.make_gate_phase_1_blockers(surface, position)
  Ancient.make_gate_blockers(surface, position, Ancient.gate_blockers_phase_1, Ancient.name_gate_blocker)
end

function Ancient.make_gate_phase_1_void_blockers(surface, position)
  Ancient.make_gate_blockers(surface, position, Ancient.gate_blockers_void_phase_1, Ancient.name_gate_blocker_void)
end

function Ancient.make_gate_phase_2_blockers(surface, position)
  Ancient.make_gate_blockers(surface, position, Ancient.gate_blockers_phase_2, Ancient.name_gate_blocker)
end

function Ancient.make_gate_phase_2_void_blockers(surface, position)
  Ancient.make_gate_blockers(surface, position, Ancient.gate_blockers_void_phase_2, Ancient.name_gate_blocker_void)
end

function Ancient.make_gate(position)
  -- gate middle X tile is effectivly at +0.5
  -- gate middle is along the actual y
  Ancient.cryptf6()
  local gate = {
    status = "fragments",
    status_progress = 0,
    rotation = 0,
    rotation_velocity = 0, -- -1 to 1
    rotation_direction = 0, -- -1 to 1
  }

  global.gate = gate
  gate.position = position
  local zone = Zone.from_name("Foenestra")
  local surface = Zone.get_make_surface(zone)
  gate.surface = surface
  gate.void_sprite = rendering.draw_sprite({
    sprite= Ancient.name_gate_void_sprite,
    --sprite = "file/__space-exploration-graphics__/graphics/entity/gate/hr/void.png",
    --sprite = "virtual-signal.se-star",
    surface = surface,
    x_scale = 4,
    y_scale = 4,
    render_layer = 28, -- just above decals
    target = position,
  })
  Ancient.make_gate_phase_1_blockers(surface, position)
  Ancient.make_gate_phase_1_void_blockers(surface, position)

  for fragment_name, fragment in pairs(Ancient.gate_fragments) do
    local entity = surface.create_entity{
      name = fragment_name,
      position = {x = position.x + fragment.position.x, y = position.y + fragment.position.y}
    }
    entity.destructible = false
  end

end

function Ancient.check_gate_fragments()
  local gate = global.gate
  if not (gate and gate.status == "fragments") then return end
  local zone = Zone.from_name("Foenestra")
  local surface = Zone.get_make_surface(zone)

  for fragment_name, fragment in pairs(Ancient.gate_fragments) do
    if fragment.placeable then
      local entity = surface.find_entity(fragment_name, {
        x = gate.position.x + fragment.required_position[1],
        y = gate.position.y + fragment.required_position[2]
      })
      if not entity then
        return
      end
    end
  end
  Ancient.gate_phase_2(gate)
end

function Ancient.gate_phase_2(gate)
  gate.status = "scaffold"
  local surface = gate.surface

  -- all here
  local fragment_names = {}
  for fragment_name, fragment in pairs(Ancient.gate_fragments) do
    table.insert(fragment_names, fragment_name)
  end

  local entities = surface.find_entities_filtered{name = fragment_names}
  for _, entity in pairs(entities) do
    entity.destroy()
  end

  Ancient.make_gate_phase_2_blockers(surface, gate.position)
  Ancient.make_gate_phase_2_void_blockers(surface, gate.position)

  for part_name, position in pairs(Ancient.gate_parts_main) do
    local entity = surface.create_entity{
      name = part_name,
      position = {x = gate.position.x + position[1], y = gate.position.y + position[2]}
    }
    entity.destructible = false
  end

  for part_name, position in pairs(Ancient.gate_parts_main_shadow) do
    local entity = surface.create_entity{
      name = part_name,
      position = {x = gate.position.x + position[1], y = gate.position.y + position[2]}
    }
    entity.destructible = false
  end

  for part_name, position in pairs(Ancient.gate_parts_underlay) do
    local entity = surface.create_entity{
      name = part_name,
      position = {x = gate.position.x + position[1], y = gate.position.y + position[2]}
    }
    entity.destructible = false
  end

  local entity = surface.create_entity{
    name = Ancient.name_gate_light_middle,
    target = {x = gate.position.x, y = gate.position.y + 1},
    position = {x = gate.position.x, y = gate.position.y},
    speed = 0
  }
  entity.destructible = false

  gate.lock_switches = {}
  local i = 0
  for part_name, position in pairs(Ancient.gate_parts_rails) do
    i = i + 1
    local entity = surface.create_entity{
      name = part_name,
      position = {x = gate.position.x + position[1], y = gate.position.y + position[2]}
    }
    entity.destructible = false
    local entity = surface.create_entity{
      name = Ancient.name_gate_light,
      target = {x = gate.position.x + position[1], y = gate.position.y + position[2] + 1},
      position = {x = gate.position.x + position[1], y = gate.position.y + position[2]},
      speed = 0
    }
    entity.destructible = false
    gate.lock_switches[i] = surface.create_entity{
      name = Ancient.name_gate_lock_switch,
      position = {x = gate.position.x + position[1], y = gate.position.y + position[2]},
      force = "neutral"
    }
    gate.lock_switches[i].destructible = false
  end

  gate.shunts = {}
  for i, part in pairs(Ancient.gate_parts_shunts) do
    gate.shunts[i] = surface.create_entity{
      name = part.name,
      position = {x = gate.position.x + part.position[1], y = gate.position.y + part.position[2]}
    }
    gate.shunts[i].destructible = false
  end

  gate.platform_scaffold = surface.create_entity{
    name = Ancient.gate_parts_platform.name_scaffold,
    position = {x = gate.position.x + Ancient.gate_parts_platform.position[1], y = gate.position.y + Ancient.gate_parts_platform.position[2]},
    force = "neutral"
  }
  gate.platform_scaffold.destructible = false

  Ancient.update_unlocks()

end

function Ancient.gate_phase_3(gate)
  local surface = gate.surface
  gate.status = "unpowered"
  gate.status_progress = 0
  if gate.platform_scaffold and gate.platform_scaffold.valid then
    --  give back any excess
    local inv = gate.platform_scaffold.get_inventory(defines.inventory.assembling_machine_input)
    if not inv.is_empty() then
      local pos = gate.platform_scaffold.position
      pos.x = pos.x - 8
      pos.y = pos.y - 1
      if not (gate.overflow_chest and gate.overflow_chest.valid) then
        gate.overflow_chest = gate.platform_scaffold.surface.create_entity{
          name = "steel-chest",
          force = gate.platform_scaffold.force,
          position = pos
        }
      end
      for name, count in pairs(inv.get_contents()) do
        gate.overflow_chest.insert({name=name, count=count})
      end
    end
    gate.platform_scaffold.destroy()
  end
  gate.platform_scaffold = nil

  for part_name, position in pairs(Ancient.gate_parts_addons) do
    local entity = surface.create_entity{
      name = part_name,
      position = {x = gate.position.x + position[1], y = gate.position.y + position[2]}
    }
    entity.destructible = false
  end

  gate.lock_combinators = {}
  for i, part in pairs(Ancient.gate_parts_lock_combinators) do
    gate.lock_combinators[i] = surface.create_entity{
      name = Ancient.name_gate_lock_combinator,
      position = {x = gate.position.x + part.position[1], y = gate.position.y + part.position[2]},
      direction = part.direction,
      force = "neutral"
    }
    gate.lock_combinators[i].destructible = false
    gate.lock_combinators[i].operable = false
    gate.lock_combinators[i].rotatable = false
  end

  gate.lock_fluid_inputs = {}
  for i, part in pairs(Ancient.gate_parts_lock_fluid_inputs) do
    gate.lock_fluid_inputs[i] = surface.create_entity{
      name = Ancient.name_gate_fluid_input,
      position = {x = gate.position.x + part.position[1], y = gate.position.y + part.position[2]},
      direction = part.direction,
      force = "neutral"
    }
    gate.lock_fluid_inputs[i].destructible = false
    gate.lock_fluid_inputs[i].rotatable = false
  end

  gate.lock_fluid_outputs = {}
  for i, part in pairs(Ancient.gate_parts_lock_fluid_outputs) do
    gate.lock_fluid_outputs[i] = surface.create_entity{
      name = Ancient.name_gate_fluid_output,
      position = {x = gate.position.x + part.position[1], y = gate.position.y + part.position[2]},
      direction = part.direction,
      force = "neutral"
    }
    gate.lock_fluid_outputs[i].destructible = false
    gate.lock_fluid_outputs[i].rotatable = false
  end

  entity = surface.create_entity{
    name = Ancient.gate_parts_platform.name,
    position = {x = gate.position.x + Ancient.gate_parts_platform.position[1], y = gate.position.y + Ancient.gate_parts_platform.position[2]}
  }
  entity.destructible = false

  gate.platform_combinator = surface.create_entity{
    name = Ancient.gate_parts_platform.combinator.name,
    position = {x = gate.position.x + Ancient.gate_parts_platform.combinator.position[1], y = gate.position.y + Ancient.gate_parts_platform.combinator.position[2]},
    direction = defines.direction.east,
    force = "neutral"
  }
  gate.platform_combinator.destructible = false
  gate.platform_combinator.rotatable = false

  gate.platform_energy_interfaces = {}
  gate.platform_energy_interfaces[9] = surface.create_entity{
    name = Ancient.gate_parts_platform.energy_interface.name,
    position = {x = gate.position.x + Ancient.gate_parts_platform.energy_interface.position[1], y = gate.position.y + Ancient.gate_parts_platform.energy_interface.position[2]},
    direction = defines.direction.north,
    force = "neutral"
  }
  gate.platform_energy_interfaces[9].destructible = false
  gate.platform_energy_interfaces[9].rotatable = false

  gate.buttons = {}
  gate.buttons.left_switch = surface.create_entity{
    name = Ancient.gate_parts_platform.buttons.name_switch,
    position = {
      x = gate.position.x + Ancient.gate_parts_platform.buttons.left.switch_position[1],
      y = gate.position.y + Ancient.gate_parts_platform.buttons.left.switch_position[2]},
      force = "neutral"
  }
  gate.buttons.left_switch.destructible = false
  gate.buttons.left_display = surface.create_entity{
    name = Ancient.gate_parts_platform.buttons.left.name,
    position = {
      x = gate.position.x + Ancient.gate_parts_platform.buttons.left.position[1],
      y = gate.position.y + Ancient.gate_parts_platform.buttons.left.position[2]}
  }
  gate.buttons.left_display.graphics_variation = 1
  gate.buttons.left_display.destructible = false

  gate.buttons.middle_switch = surface.create_entity{
    name = Ancient.gate_parts_platform.buttons.name_switch,
    position = {
      x = gate.position.x + Ancient.gate_parts_platform.buttons.middle.switch_position[1],
      y = gate.position.y + Ancient.gate_parts_platform.buttons.middle.switch_position[2]},
      force = "neutral"
  }
  gate.buttons.middle_switch.destructible = false
  gate.buttons.middle_display = surface.create_entity{
    name = Ancient.gate_parts_platform.buttons.middle.name,
    position = {
      x = gate.position.x + Ancient.gate_parts_platform.buttons.middle.position[1],
      y = gate.position.y + Ancient.gate_parts_platform.buttons.middle.position[2]}
  }
  gate.buttons.middle_display.graphics_variation = 1
  gate.buttons.middle_display.destructible = false

  gate.buttons.right_switch = surface.create_entity{
    name = Ancient.gate_parts_platform.buttons.name_switch,
    position = {
      x = gate.position.x + Ancient.gate_parts_platform.buttons.right.switch_position[1],
      y = gate.position.y + Ancient.gate_parts_platform.buttons.right.switch_position[2]},
      force = "neutral"
  }
  gate.buttons.right_switch.destructible = false
  gate.buttons.right_display = surface.create_entity{
    name = Ancient.gate_parts_platform.buttons.right.name,
    position = {
      x = gate.position.x + Ancient.gate_parts_platform.buttons.right.position[1],
      y = gate.position.y + Ancient.gate_parts_platform.buttons.right.position[2]}
  }
  gate.buttons.right_display.graphics_variation = 1
  gate.buttons.right_display.destructible = false

  Ancient.gate_set_glyph_order(gate)

  gate.glyphs = {}


  Ancient.update_unlocks()

end



function Ancient.gate_set_glyph_order(gate)
  if gate.glyph_order then return end
  local glyph_order = {}
  for i = 1,64,1 do
    glyph_order[i]=i
  end
  Util.shuffle(glyph_order)
  gate.glyph_order = glyph_order
end

function Ancient.gate_update_indicators_anchor(gate)
  gate.indicators = gate.indicators or {}
  gate.indicators.anchor = gate.indicators.anchor or {}
  gate.indicators.anchor.statuses = gate.indicators.anchor.statuses or {}
  gate.indicators.anchor.entities = gate.indicators.anchor.entities or {}

  local anchors = 0
  local active_anchors = 0
  if global.dimensional_anchors then
    for zone_index, anchor in pairs(global.dimensional_anchors) do
      anchors = anchors + 1
      if anchor.active then active_anchors = active_anchors + 1 end
    end
  end

  for i = 1,8,1 do
    local status = 1
    if anchors >= i then
      status = 2
    end
    if active_anchors >= i then
      status = 3
    end
    if gate.indicators.anchor.statuses[i] ~= status then
      gate.indicators.anchor.statuses[i] = status
      if gate.indicators.anchor.entities[i] and gate.indicators.anchor.entities[i] then
        gate.indicators.anchor.entities[i].destroy()
      end
      gate.indicators.anchor.entities[i] = gate.surface.create_entity{
        name = Ancient.gate_parts_platform.indicators.names[status],
        position = {
          x = gate.position.x + Ancient.gate_parts_platform.indicators.x_start + Ancient.gate_parts_platform.indicators.x_spacing * (i - 1),
          y = gate.position.y + Ancient.gate_parts_platform.indicators.anchor_y}
      }
    end
  end
end

function Ancient.gate_update_indicators_temperature(gate)
  gate.indicators = gate.indicators or {}
  gate.indicators.temperature = gate.indicators.temperature or {}
  gate.indicators.temperature.statuses = gate.indicators.temperature.statuses or {}
  gate.indicators.temperature.entities = gate.indicators.temperature.entities or {}

  for i = 1,8,1 do
    local status = 1
    if gate.lock_temperatures and gate.lock_temperatures[i] and gate.lock_temperatures[i] <= Ancient.gate_temperature_partial then
      status = 2
    end
    if gate.lock_temperatures and gate.lock_temperatures[i] and gate.lock_temperatures[i] <= Ancient.gate_temperature_required then
      status = 3
    end
    if gate.indicators.temperature.statuses[i] ~= status then
      gate.indicators.temperature.statuses[i] = status
      if gate.indicators.temperature.entities[i] and gate.indicators.temperature.entities[i] then
        gate.indicators.temperature.entities[i].destroy()
      end
      gate.indicators.temperature.entities[i] = gate.surface.create_entity{
        name = Ancient.gate_parts_platform.indicators.names[status],
        position = {
          x = gate.position.x + Ancient.gate_parts_platform.indicators.x_start + Ancient.gate_parts_platform.indicators.x_spacing * (i - 1),
          y = gate.position.y + Ancient.gate_parts_platform.indicators.temperature_y}
      }
    end
  end
end

function Ancient.gate_update_indicators_lock(gate)
  gate.indicators = gate.indicators or {}
  gate.indicators.lock = gate.indicators.lock or {}
  gate.indicators.lock.statuses = gate.indicators.lock.statuses or {}
  gate.indicators.lock.entities = gate.indicators.lock.entities or {}

  for i = 1,8,1 do
    local status = 1
    if gate.shunts_actions and gate.shunts_actions[i] and gate.shunts_actions[i].active then
      status = 2
    end
    if gate.locked_glyphs and gate.locked_glyphs[i] then
      status = 3
    end

    if gate.indicators.lock.statuses[i] ~= status then
      gate.indicators.lock.statuses[i] = status
      if gate.indicators.lock.entities[i] and gate.indicators.lock.entities[i] then
        gate.indicators.lock.entities[i].destroy()
      end
      gate.indicators.lock.entities[i] = gate.surface.create_entity{
        name = Ancient.gate_parts_platform.indicators.names[status],
        position = {
          x = gate.position.x + Ancient.gate_parts_platform.indicators.x_start + Ancient.gate_parts_platform.indicators.x_spacing * (i - 1),
          y = gate.position.y + Ancient.gate_parts_platform.indicators.lock_y}
      }
    end
  end
end

function Ancient.gate_update_indicators(gate)
  -- don't update every frame, once per second is ok
  if gate.status == "fragments" or gate.status == "scaffold" or gate.status == "unpowered" or gate.status == "powering-up" or gate.status == "powering-down" then
    local indicators = gate.surface.find_entities_filtered{name=Ancient.gate_parts_platform.indicators.names}
    for _, indicator in pairs(indicators) do indicator.destroy() end
    gate.indicators = nil
    return
  end
  Ancient.gate_update_indicators_anchor(gate)

  Ancient.gate_update_indicators_temperature(gate)

  Ancient.gate_update_indicators_lock(gate)
end

function Ancient.gate_set_rotation(gate, direction)
  if direction == 0 then
    gate.rotation_direction = 0
    gate.buttons.left_display.graphics_variation = 1
    gate.buttons.middle_display.graphics_variation = 2
    gate.buttons.right_display.graphics_variation = 1
    gate.surface.create_entity{
      name= Ancient.name_sound_gate_button,
      position= Ancient.gate_parts_platform.buttons.middle.position,
      target= gate.position,
      speed=0
    }
  elseif direction == 1 then
    gate.rotation_direction = 1
    gate.buttons.left_display.graphics_variation = 2
    gate.buttons.middle_display.graphics_variation = 1
    gate.buttons.right_display.graphics_variation = 1
    gate.surface.create_entity{
      name= Ancient.name_sound_gate_button,
      position= Ancient.gate_parts_platform.buttons.left.position,
      target= gate.position,
      speed=0
    }
  elseif direction == -1 then
    gate.rotation_direction = -1
    gate.buttons.left_display.graphics_variation = 1
    gate.buttons.middle_display.graphics_variation = 1
    gate.buttons.right_display.graphics_variation = 2
    gate.surface.create_entity{
      name= Ancient.name_sound_gate_button,
      position= Ancient.gate_parts_platform.buttons.right.position,
      target= gate.position,
      speed=0
    }
  end
end

function Ancient.gate_activate_lock(gate, lock_id)
  gate.shunts_actions = gate.shunts_actions or {}
  gate.shunts_actions[lock_id] = gate.shunts_actions[lock_id] or {
    active = false, -- default
    progress = 0, -- 0 to 1, 1 is lock point, 1-2 is return
  }
  if not gate.shunts_actions[lock_id].active == true then
    gate.shunts_actions[lock_id].active = true
    gate.surface.create_entity{
      name= Ancient.name_sound_gate_lock,
      position= {x = Ancient.gate_parts_shunts[lock_id].position[1] + gate.position.x, y = Ancient.gate_parts_shunts[lock_id].position[2] + gate.position.y} ,
      target= gate.position,
      speed=0
    }
  end
  Ancient.gate_clear_glyph(gate, lock_id)
end

function Ancient.on_player_rotated_entity(event)
  if event.entity and event.entity.valid then
    local entity = event.entity
    if event.entity.name == Ancient.gate_parts_platform.buttons.name_switch then
      local gate = global.gate
      if gate.status == "powered" then
        if entity == gate.buttons.left_switch then
          Ancient.gate_set_rotation(gate, 1)
        end
        if entity == gate.buttons.middle_switch then
          Ancient.gate_set_rotation(gate, 0)
        end
        if entity == gate.buttons.right_switch then
          Ancient.gate_set_rotation(gate, -1)
        end
      end
    elseif event.entity.name == Ancient.name_gate_lock_switch then
      local gate = global.gate
      if gate.status == "powered" then
        for i, switch in pairs(gate.lock_switches) do
          if entity == switch then
            Ancient.gate_activate_lock(gate, i)
          end
        end
      end
    end
  end
end
Event.addListener(defines.events.on_player_rotated_entity, Ancient.on_player_rotated_entity)

function Ancient.on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if not entity then return end
  if entity.type == "simple-entity" then
    for fragment_name, fragment in pairs(Ancient.gate_fragments) do
      if entity.name == fragment_name then
        local anomaly = Zone.from_name("Foenestra")
        local anomaly_surface = Zone.get_surface(anomaly)
        if anomaly_surface and anomaly_surface.index == entity.surface.index then
          -- valid zone
          Ancient.check_gate_fragments()
          return
        else
          cancel_entity_creation(entity, event.player_index, "Cannot place here.")
          return
        end
      end
    end
  end

end
Event.addListener(defines.events.on_built_entity, Ancient.on_entity_created)
Event.addListener(defines.events.on_robot_built_entity, Ancient.on_entity_created)
Event.addListener(defines.events.script_raised_built, Ancient.on_entity_created)
Event.addListener(defines.events.script_raised_revive, Ancient.on_entity_created)


function Ancient.gate_begin_power_down(gate)
  gate.status = "powering-down"
  gate.status_progress = 0
  gate.portal_leads_to = nil
  for j, sound_position in pairs(Ancient.gate_sound_positions) do
    gate.surface.create_entity{
      name= Ancient.name_sound_gate_power_down,
      position= {x = sound_position[1] + gate.position.x, y = sound_position[2] + gate.position.y},
      target= gate.position,
      speed=0
    }
  end
  gate.rotation_velocity = 0
  gate.rotation_direction = 0
  Ancient.gate_remove_rotation_sounds(gate)
  Ancient.gate_remove_powered_sounds(gate)

  -- removed locked glyphs
  gate.locked_glyphs = {}
  if gate.locked_glyphs_entities then
    for _, entity in pairs(gate.locked_glyphs_entities) do
      if entity and entity.valid then entity.destroy() end
    end
  end

  -- removed extra power draw
  for i, entity in pairs(gate.platform_energy_interfaces) do
    if i ~= 9 then
      entity.destroy()
      gate.platform_energy_interfaces[i] = nil
    end
  end

end

function Ancient.gate_begin_power_up(gate)
  gate.queue_power_down = false
  gate.status = "powering-up"
  gate.status_progress = 0
  for j, sound_position in pairs(Ancient.gate_sound_positions) do
    gate.surface.create_entity{
      name= Ancient.name_sound_gate_power_up,
      position= {x = sound_position[1] + gate.position.x, y = sound_position[2] + gate.position.y},
      target= gate.position,
      speed=0
    }
  end
end

function Ancient.gate_power_up_complete(gate)
  gate.status = "powered"
  gate.status_progress = 0
  Ancient.gate_update_indicators(gate)

  gate.powered_sounds = {}
  for j, sound_position in pairs(Ancient.gate_sound_positions) do
    gate.powered_sounds[j] = gate.surface.create_entity{
      name= Ancient.name_sound_gate_power_on,
      position= {x = sound_position[1] + gate.position.x, y = sound_position[2] + gate.position.y},
      target= gate.position,
      speed=0
    }
  end

end

function Ancient.gate_evaluate_power(gate)

  local energy = 0
  local energy_capacity = 0
  for i, energy_interface in pairs(gate.platform_energy_interfaces) do
    energy = energy + energy_interface.energy
    energy_capacity = energy_capacity + energy_interface.prototype.electric_energy_source_prototype.buffer_capacity
  end
  local energy_of_required = energy/energy_capacity
  if energy_of_required < 0.99 then
    if gate.status == "powered" then
      Ancient.gate_begin_power_down(gate)
      gate.surface.print("Gate tried to draw more power than available.")
    else
      gate.queue_power_down = true
    end
    return
  end
  -- has power
  if gate.status == "unpowered" then
    Ancient.gate_begin_power_up(gate)
  end

end

function Ancient.gate_remove_powered_sounds(gate)
  if gate.powered_sounds then
    for _, sound in pairs(gate.powered_sounds) do
      if sound and sound.valid then sound.destroy() end
    end
    gate.powered_sounds = nil
  end
end

function Ancient.gate_remove_rotation_sounds(gate)
  if gate.rotation_sounds then
    for _, sound in pairs(gate.rotation_sounds) do
      if sound and sound.valid then sound.destroy() end
    end
    gate.rotation_sounds = nil
  end
end

function Ancient.gate_position_glyph(gate, glyph, index)
    glyph.teleport({
      x = gate.position.x + Ancient.gate_glyphs_x - math.sin(2*math.pi*(index/64+gate.rotation/64))*Ancient.gate_glyphs_x_mult,
      y = gate.position.y + Ancient.gate_glyphs_y + math.cos(2*math.pi*(index/64+gate.rotation/64))*Ancient.gate_glyphs_y_mult
    })
end

function Ancient.gate_position_glyphs(gate)
  if gate.glyphs then
    for i, glyph in pairs(gate.glyphs) do
      Ancient.gate_position_glyph(gate, glyph, i)
    end
  end
end

function Ancient.gate_update_temperatures(gate)
  gate.lock_temperatures = gate.lock_temperatures or {}
  for i = 1, 8, 1 do
    gate.lock_temperatures[i] = gate.lock_temperatures[i] or Ancient.gate_temperature_resting
    local diff = gate.lock_temperatures[i] - Ancient.gate_temperature_resting
    local change = -diff * Ancient.gate_temperature_return_per_tick
    if gate.status ~= "powering-down" and gate.status == "unpowered" then
      change = change + Ancient.gate_temperature_while_powered
      if gate.rotation_direction ~= 0 then
        change = change + Ancient.gate_temperature_while_turning
      end
      if gate.status == "opening-portal" or gate.status == "portal-open" then
        change = change + Ancient.gate_temperature_while_portal
      end
      if gate.locked_glyphs and gate.locked_glyphs[i] then
        change = change + Ancient.gate_temperature_while_locked
      end
    end
    gate.lock_temperatures[i] = gate.lock_temperatures[i] + change
    if gate.lock_temperatures[i] >= Ancient.gate_temperature_required then
      local fluid_available = gate.lock_fluid_inputs[i].get_fluid_count()
      if fluid_available > 0 then
        local fluid_in_output = gate.lock_fluid_outputs[i].get_fluid_count()

        -- from gate_temperature_resting to gate_temperature_zero
        local temp_range = math.abs(Ancient.gate_temperature_zero - Ancient.gate_temperature_resting)
        local temperature_as_percent = -(gate.lock_temperatures[i] - Ancient.gate_temperature_resting) / temp_range
        local fluid_efficiency = Util.lerp(Ancient.gate_temperature_per_coolant_max, Ancient.gate_temperature_per_coolant_min, temperature_as_percent)
        local temperature_drop_goal = (Ancient.gate_temperature_zero - gate.lock_temperatures[i]) / 10 -- don't do all in 1 step
        local fluid_required = math.min(100, math.max(0, -temperature_drop_goal / fluid_efficiency))
        if fluid_required > 0 then
          local used_fluid = gate.lock_fluid_outputs[i].insert_fluid({name = name_thermofluid_hot, amount = math.min(fluid_available, fluid_required)})
          if used_fluid > 0 then
            gate.lock_fluid_inputs[i].remove_fluid({name = name_thermofluid_supercooled, amount = used_fluid})
            gate.lock_temperatures[i] = gate.lock_temperatures[i] - fluid_efficiency * used_fluid
          end
        end
      end
    end
  end
end


function Ancient.on_tick(event)
  if global.gate then
    local gate = global.gate

    if gate.status == "fragments" then
      -- nothing to do anymore
    elseif gate.status == "scaffold" then
      if gate.platform_scaffold.products_finished > 0 then
        Ancient.gate_phase_3(gate)
      end
    else

      Ancient.gate_evaluate_power(gate)

      if game.tick % 60 == 0 then
        Ancient.gate_update_temperatures(gate)
        Ancient.gate_update_indicators(gate)
      end

      if gate.status == "powering-up" then
        gate.status_progress = gate.status_progress + 1

        local glyphs_active = math.min(64, (gate.status_progress - Ancient.timer_power_up_complete) / Ancient.timer_power_up_ghyph_light_interval + 65)
        gate.glyphs = gate.glyphs or {}
        if glyphs_active > #gate.glyphs then
          local i = #gate.glyphs + 1
          gate.glyphs[i] = gate.surface.create_entity{
            name = Ancient.name_gate_glyph_prefix .. gate.glyph_order[i],
            position = gate.position
          }
          Ancient.gate_position_glyph(gate, gate.glyphs[i], i) -- move to correct place
          gate.glyphs[i].destructible = false
        end
        if gate.status_progress > Ancient.timer_power_up_complete then
          if gate.queue_power_down == true then
            Ancient.gate_begin_power_down(gate)
          else
            Ancient.gate_power_up_complete(gate)
          end
        end
      end

      if gate.status == "powering-down" then
        gate.status_progress = gate.status_progress + 1
        for _, glyph in pairs(gate.glyphs) do
          if glyph and glyph.valid then glyph.destroy() end
        end
        gate.glyphs = {}
        if gate.status_progress > Ancient.timer_power_down_complete then
          gate.status = "unpowered"
          gate.status_progress = 0
        end
      end

      if gate.status == "powered" then

        if gate.rotation_direction == 0 then
          --gate.rotation_velocity = gate.rotation_velocity + math.min(math.max((gate.rotation_direction-gate.rotation_velocity),-Ancient.gate_decceleration), Ancient.gate_decceleration)
          if gate.rotation_velocity > 0 then
            local next_snap = math.ceil(gate.rotation)
            local next_snap_distance = math.max(0, next_snap - gate.rotation - 0.01)
            gate.rotation_velocity = gate.rotation_velocity + math.min(math.max((next_snap_distance-gate.rotation_velocity),-Ancient.gate_decceleration), Ancient.gate_acceleration)
          else
            local next_snap = math.floor(gate.rotation)
            local next_snap_distance = math.min(0, next_snap - gate.rotation + 0.01)
            gate.rotation_velocity = gate.rotation_velocity + math.min(math.max((next_snap_distance-gate.rotation_velocity),-Ancient.gate_acceleration), Ancient.gate_decceleration)
          end

        elseif math.abs(gate.rotation_direction-gate.rotation_velocity) >= 1 then
          gate.rotation_velocity = gate.rotation_velocity + math.min(math.max((gate.rotation_direction-gate.rotation_velocity),-Ancient.gate_decceleration), Ancient.gate_decceleration)
        else
          gate.rotation_velocity = gate.rotation_velocity + math.min(math.max((gate.rotation_direction-gate.rotation_velocity),-Ancient.gate_acceleration), Ancient.gate_acceleration)
        end

        gate.rotation = gate.rotation + gate.rotation_velocity * Ancient.gate_max_speed

        if math.abs(gate.rotation_velocity) > 0.01 then
          if not gate.rotation_sounds then
            gate.rotation_sounds = {}
            for j, sound_position in pairs(Ancient.gate_sound_positions) do
              gate.rotation_sounds[j] = gate.surface.create_entity{
                name= Ancient.name_sound_gate_turning,
                position= {x = sound_position[1] + gate.position.x, y = sound_position[2] + gate.position.y},
                target= gate.position,
                speed=0
              }
            end
          end
        elseif gate.rotation_sounds then
          Ancient.gate_remove_rotation_sounds(gate)
        end

        if game.tick % 60 == 0 then
          Ancient.gate_try_open_portal(gate)
        end
      end

      if gate.status == "powered" or gate.status == "powering-up" then
        -- gate track rotation
        Ancient.gate_position_glyphs(gate)
      end

      if gate.status == "opening-portal" then
        gate.status_progress = gate.status_progress + 1
        local open_percent = gate.status_progress / 600
        rendering.set_x_scale(gate.activation_fx.cloud_1, 2.5 * open_percent)
        rendering.set_x_scale(gate.activation_fx.cloud_2, 2.5 * open_percent)
        rendering.set_y_scale(gate.activation_fx.cloud_1, 2 * open_percent)
        rendering.set_y_scale(gate.activation_fx.cloud_2, 2 * open_percent)
        for i = 0, 2, 1 do
          local angle = math.random()
          local target_offset = {
            x = -math.sin(2*math.pi*angle) * 30,
            y = math.cos(2*math.pi*angle) * 20
          }
          local magnitude = Util.vector_length(target_offset);
          local target_position = {x = gate.position.x + target_offset.x, y = gate.position.x + target_offset.y}
          gate.surface.create_entity{
            name = (i%2==0) and Ancient.name_gate_spec_white or Ancient.name_gate_spec_cyan,
            position = Util.lerp_vectors(gate.position, target_position, 0.1),
            target = target_position,
            speed = magnitude / 50 * (0.5 + math.random())
          }
        end
        if gate.status_progress >= 600 then
          gate.status = "portal-open"
          gate.status_progress = 0
          local coordinate = Ancient.cryptf4b(gate.locked_glyphs)
          local string = gate.locked_glyphs[1]
          for i = 2, 8 do
            string = string .. "|" .. gate.locked_glyphs[i]
          end
          local hash = sha2.hash256(string)
          game.print({"space-exploration.gate-portal-coordinates", Ancient.coordinate_to_string(coordinate)})
          if hash == global.gds then
            gate.portal_leads_to = "home"
            game.print("The portal is stable and leads to your final destination. Enter the portal to win the game.")
          else
            local hash1 = string.sub(hash, 1, 1)
            if tonumber(hash1) then
              gate.portal_leads_to = "biter"
              game.print("Something is coming through the portal.")
            else
              game.print("The distortion is unstable. The distortion vector does not lead anywhere.")
            end
          end
        end
      end

      if gate.status == "portal-open" then
        -- TODO: check sequence and show victory screen if correct.
        -- otherwise chance for gate close or invasion from : biters / robots / ancients
        if gate.portal_leads_to and gate.queue_power_down ~= true then
          if gate.portal_leads_to == "home" then
            -- TODO: look for player in the portal.
            local characters = gate.surface.find_entities_filtered{type = "character", position = gate.position, radius = 5}
            if characters and #characters >= 1 then
              game.set_game_state{
                game_finished=true,
                player_won=true,
                can_continue=true,
                victorious_force=characters[1].force
              }
              gate.status = "closing-portal"
              gate.status_progress = 0
              gate.portal_leads_to = nil
            end
          else
            if game.tick % 10 == 0 then
              -- assume a biter world for now.
              local names = {
                "small-spitter",
                "small-biter",
                "medium-spitter",
                "medium-biter",
                "big-spitter",
                "big-biter",
                "behemoth-spitter",
                "behemoth-biter",
              }
              local name = names[math.random(#names)]
              local pos = gate.surface.find_non_colliding_position(name, gate.position, 10, 1, false)
              if pos then
                gate.surface.create_entity{name = name, position = pos, force = "enemy"}
              end
            end
          end
        else
          gate.status = "closing-portal"
          gate.status_progress = 0
          gate.portal_leads_to = nil
        end
      end

      if gate.status == "closing-portal" then
        gate.status_progress = gate.status_progress + 1
        local closed_percent = gate.status_progress / 600
        local tint_1 = table.deepcopy(Ancient.gate_cloud_tint_1)
        local tint_2 = table.deepcopy(Ancient.gate_cloud_tint_2)
        for a, b in pairs(tint_1) do tint_1[a] = b * (1 - closed_percent) end
        for a, b in pairs(tint_2) do tint_2[a] = b * (1 - closed_percent) end
        rendering.set_color(gate.activation_fx.cloud_1, tint_1)
        rendering.set_color(gate.activation_fx.cloud_2, tint_2)
        if gate.status_progress >= 600 then
          Ancient.gate_begin_power_down(gate)
        end
      end

      -- shunts
      if gate.shunts_actions then
        for i, action in pairs(gate.shunts_actions) do
          if action.active then
            action.progress = action.progress + Ancient.timer_shunt_step
            if action.progress > Ancient.timer_shunt_glyph_lock and action.progress < (Ancient.timer_shunt_glyph_lock+Ancient.timer_shunt_step)
                and math.abs(gate.rotation_velocity) < 0.02
                and gate.status == "powered" then
              -- Lock the glyph
              gate.locked_glyphs = gate.locked_glyphs or {}
              gate.locked_glyphs_entities = gate.locked_glyphs_entities or {}

              local glyph = Ancient.gate_get_glyph_at_lock(gate, i)
              Ancient.gate_lock_glyph(gate, i, glyph)
              Ancient.gate_update_indicators_lock(gate)
            end
            if action.progress > Ancient.timer_shunt_complete  then
              action.progress = 0
              action.active = false
              if not gate.locked_glyphs[i] then
                if gate.platform_energy_interfaces and gate.platform_energy_interfaces[i] and gate.platform_energy_interfaces[i].valid then
                  gate.platform_energy_interfaces[i].destroy()
                end
                gate.platform_energy_interfaces[i] = nil
              end
              Ancient.gate_update_indicators(gate)
            end
            local track_pos = math.min(1, math.min(action.progress, Ancient.timer_shunt_complete -action.progress))
            if action.progress < 1 then
              track_pos = track_pos * track_pos
            elseif action.progress > (Ancient.timer_shunt_complete  - 1) then
              --track_pos = math.sqrt(track_pos)
            end
            local base_position = util.vectors_add(gate.position, {x = Ancient.gate_parts_shunts[i].position[1], y = Ancient.gate_parts_shunts[i].position[2]})
            local locked_position = util.vectors_add(base_position, {x = Ancient.gate_parts_shunts[i].lock_offset[1], y = Ancient.gate_parts_shunts[i].lock_offset[2]})

            gate.shunts[i].teleport(util.lerp_vectors(base_position, locked_position, track_pos))
          end
        end
      end

    end
  end
end
Event.addListener(defines.events.on_tick, Ancient.on_tick)

function Ancient.coordinate_to_string(coordinate)
  return coordinate[1] .. ", "..coordinate[2] .. ", " ..coordinate[3]
end

function Ancient.gate_clear_glyph(gate, lock_id, skip_indicators)
  gate.locked_glyphs = gate.locked_glyphs or {}
  gate.locked_glyphs[lock_id] = nil
  gate.locked_glyphs_entities = gate.locked_glyphs_entities or {}
  if gate.locked_glyphs_entities[lock_id] and gate.locked_glyphs_entities[lock_id].valid then
    gate.locked_glyphs_entities[lock_id].destroy() -- remove old
  end
  gate.locked_glyphs_entities[lock_id] = nil
  if not skip_indicators then
    Ancient.gate_update_indicators_lock(gate)
  end
end

function Ancient.gate_lock_glyph(gate, lock_id, glyph) -- real glyph id
  Ancient.gate_clear_glyph(gate, lock_id, true)
  if glyph and (lock_id > 1 or Ancient.gtf(glyph)) then
    gate.locked_glyphs[lock_id] = glyph
    gate.locked_glyphs_entities[lock_id] = gate.shunts[lock_id].surface.create_entity{
      name = Ancient.name_gate_glyph_prefix .. glyph .. Ancient.name_gate_glyph_locked_suffix, -- suffix changes render layer
      position = {
        x = gate.position.x + Ancient.gate_parts_locked_glyphs[lock_id][1],
        y = gate.position.y + Ancient.gate_parts_locked_glyphs[lock_id][2]
      }
    }
    gate.locked_glyphs_entities[lock_id].destructible = false
  end

  if not (gate.platform_energy_interfaces[lock_id] and gate.platform_energy_interfaces[lock_id].valid) then
    gate.platform_energy_interfaces[lock_id] = gate.shunts[lock_id].surface.create_entity{
      name = Ancient.gate_parts_platform.energy_interface.name,
      position = {x = gate.position.x + Ancient.gate_parts_platform.energy_interface.position[1], y = gate.position.y + Ancient.gate_parts_platform.energy_interface.position[2]},
      direction = defines.direction.north,
      force = "neutral"
    }
    gate.platform_energy_interfaces[lock_id].destructible = false
    gate.platform_energy_interfaces[lock_id].rotatable = false
    gate.platform_energy_interfaces[lock_id].energy = 1000000000000 -- max out to start
  end
  Ancient.gate_update_indicators_lock(gate)
end

function Ancient.gate_try_open_portal(gate)
  if not (gate.locked_glyphs and gate.lock_temperatures and global.dimensional_anchors) then return end
  local n_locked = 0
  for i = 1, 8, 1 do
    if not gate.locked_glyphs[i] then return end
    if not (gate.lock_temperatures[i] and gate.lock_temperatures[i] <= Ancient.gate_temperature_required) then return end
  end
  local active_anchors = 0
  for zone_index, anchor in pairs(global.dimensional_anchors) do
    if anchor.active then active_anchors = active_anchors + 1 end
  end
  if active_anchors < 8 then return end

  -- still going, all good
  gate.status = "opening-portal"
  gate.status_progress = 0
  gate.activation_fx = gate.activation_fx or {}
  for _, fx in pairs(gate.activation_fx) do
    rendering.destroy(fx)
  end
  gate.activation_fx.cloud_1 = rendering.draw_animation{
    animation=Ancient.name_gate_cloud,
    target=gate.position,
    surface=gate.surface,
    x_scale = 2.5 / 100,
    y_scale = 2 / 100,
    tint = Ancient.gate_cloud_tint_1,
    animation_speed = -1
  }
  gate.activation_fx.cloud_2 = rendering.draw_animation{
    animation=Ancient.name_gate_cloud,
    target=gate.position,
    surface=gate.surface,
    x_scale = 2.5 / 100,
    y_scale = 2 / 100,
    tint = Ancient.gate_cloud_tint_2,
    animation_speed = 0.5,
    orientation = 0.5
  }
end


function Ancient.gate_get_glyph_at_lock(gate, lock_id)
  local lock_rotation = (lock_id-0.5)/8*64
  local effective_rotation = (lock_rotation - gate.rotation)
  local snapped_rotation = math.floor(effective_rotation +0.5) % 64
  if snapped_rotation <= 0 then snapped_rotation = snapped_rotation + 64 end
  local glyph = gate.glyph_order[snapped_rotation]
  return glyph
end


function Ancient.on_research_finished(event)

  local force = event.research.force
  Ancient.update_force_unlocks(force.name)

  if event.research.name == Ancient.name_tech_coordinates then
    local force_data = global.forces[force.name]
    if force_data then
      if force.technologies[Ancient.name_tech_coordinates].enabled then
        local level = force.technologies[Ancient.name_tech_coordinates].level - 1
        if force.technologies[Ancient.name_tech_coordinates].researched then
          level = level + 1
        end
        if level >= 1 then
          if not force_data.coordinates_discovered then
            force_data.coordinates_discovered = {}
          end
          while level > #force_data.coordinates_discovered do
            local glyph_id = global.gco[#force_data.coordinates_discovered+1]
            table.insert(force_data.coordinates_discovered, glyph_id)
            local coordinate = Ancient.cryptf4b({glyph_id})
            force.print({"space-exploration.starmapping-found-constellation", "[img=entity/"..mod_prefix .. "glyph-a-energy-"..glyph_id.."]"})
          end
        end
      end
    end
  end
end
Event.addListener(defines.events.on_research_finished, Ancient.on_research_finished)

function Ancient.update_force_unlocks(force_name)
  local force = game.forces[force_name]
  if global.gate and global.gate.status ~= "fragments" then
    if not force.technologies[Ancient.name_tech_coordinates].enabled then
      force.technologies[Ancient.name_tech_coordinates].enabled = true
      force.print({"space-exploration.technology-unlocked", "[img=technology."..Ancient.name_tech_coordinates.."]",{"technology-name."..Ancient.name_tech_coordinates}})
    end
    if not force.technologies[Ancient.name_tech_anchor].enabled then
      force.print({"space-exploration.technology-unlocked", "[img=technology."..Ancient.name_tech_anchor.."]",{"technology-name."..Ancient.name_tech_anchor}})
      force.technologies[Ancient.name_tech_anchor].enabled = true
    end
  end
end

function Ancient.update_unlocks()
  for force_name, forcedata in pairs(global.forces) do -- only player forces
    Ancient.update_force_unlocks(force_name)
  end
end

return Ancient
