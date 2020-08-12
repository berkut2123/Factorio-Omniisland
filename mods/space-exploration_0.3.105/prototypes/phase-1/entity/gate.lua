local data_util = require("data_util")

local fragment_render_layer = "lower-object-above-shadow"
local underlay_render_layer = "transport-belt-integration"
local track_glyph_render_layer = "resource"
local lock_rail_render_layer = "building-smoke"
local lock_shunt_render_layer = "decorative"
local portal_main_shadow_render_layer = "decorative"
local portal_main_render_layer = "lower-object"
local portal_addons_render_layer = "transport-belt-circuit-connector"
local locked_glyph_render_layer = "transport-belt-circuit-connector"
local portal_buttons_render_layer = "lower-object-above-shadow"
local placeable_collision = {"floor-layer", "water-tile"}

local px = 1/32

local blank_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
}

local no_north_cover_pictures = pipecoverspictures()
no_north_cover_pictures.north = blank_image

local function middle_shift (box)
  return {(box[1][1]+box[2][1])/2, (box[1][2]+box[2][2])/2}
end

for i = 1, 64, 1 do
  local track = {
    name = data_util.mod_prefix .. "glyph-a-energy-"..i,
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__space-exploration-graphics__/graphics/icons/glyph/glyph-a-"..i..".png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-g[glyph]-"..i,
    collision_box = {{-1, -1}, {1, 1}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = {{-1, -1}, {1, 1}},
    selectable_in_game = false,
    render_layer = lock_rail_render_layer,
    picture = {

      filename = "__space-exploration-graphics__/graphics/entity/gate/sr/glyphs-a-energy.png",
      width = 2048/8/2,
      height = 1536/8/2,
      x = ((i-1)%8)*2048/8/2,
      y = math.floor((i-1)/8)*1536/8/2,
      shift = {0,0},
      scale = 0.135*2,
      hr_version = data_util.hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/glyphs-a-energy.png",
        width = 2048/8,
        height = 1536/8,
        x = ((i-1)%8)*2048/8,
        y = math.floor((i-1)/8)*1536/8,
        shift = {0,0},
        scale = 0.135,
      }),
    },
    localised_name = {"entity-name.glyph"}
  }
  local locked = table.deepcopy(track)
  locked.name = locked.name .. "-locked"
  locked.render_layer = portal_buttons_render_layer
  locked.picture.scale = 0.11
  data:extend({track, locked})
end


local main = {
  e = {512,1280},
  en = {832,704},
  es = {832,640},
  n = {1600,384},
  ne = {576,576},
  nw = {576,576},
  s = {1344,320},
  se = {704,576},
  sw = {704,576},
  w = {512,1280},
  wn = {832,704},
  ws = {832,640},
}

for m, dimensions in pairs(main) do
  data:extend({
    {
      type = "simple-entity",
      name = data_util.mod_prefix .. "gate-main-"..m,
      flags = {"placeable-neutral"},
      icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
      icon_size = 64,
      render_layer = portal_main_render_layer,
      order = "a[ancient]-g[gate]-m[main]-"..m,
      collision_mask = {"not-colliding-with-itself"},
      collision_box = {{-dimensions[1]/64/2, -dimensions[2]/64/2}, {dimensions[1]/64/2, dimensions[2]/64/2}},
      selection_box = {{-dimensions[1]/64/2, -dimensions[2]/64/2}, {dimensions[1]/64/2, dimensions[2]/64/2}},
      selectable_in_game = false,
      picture = data_util.auto_sr_hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/main-"..m..".png",
        width = dimensions[1],
        height = dimensions[2],
        shift = {0,0},
        scale = 0.5,
      })
    },
  })
end

local main_shadow = {
  e = {192,1280},
  en = {704,576},
  es = {832,640},
  ne = {128,128},
  s = {1344,128},
  se = {704,320},
  sw = {704,320},
  w = {128,1280},
  ws = {832,640},
}
for m, dimensions in pairs(main_shadow) do
  data:extend({
    {
      type = "simple-entity",
      name = data_util.mod_prefix .. "gate-main-"..m.."-shadow",
      flags = {"placeable-neutral"},
      icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
      icon_size = 64,
      render_layer = portal_main_shadow_render_layer,
      order = "a[ancient]-g[gate]-s[shadow]-"..m,
      collision_mask = {"not-colliding-with-itself"},
      collision_box = {{-dimensions[1]/64/2, -dimensions[2]/64/2}, {dimensions[1]/64/2, dimensions[2]/64/2}},
      selection_box = {{-dimensions[1]/64/2, -dimensions[2]/64/2}, {dimensions[1]/64/2, dimensions[2]/64/2}},
      selectable_in_game = false,
      picture = data_util.auto_sr_hr({
        draw_as_shadow = true,
        filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/main-"..m.."-shadow.png",
        width = dimensions[1],
        height = dimensions[2],
        shift = {0,0},
        scale = 0.5,
      })
    },
  })
end

local underlays = {
  e = {320,1280},
  en = {512,512},
  es = {576,448},
  n = {1728,192},
  ne = {640,384},
  nw = {640,384},
  s = {1728,256},
  se = {704,384},
  sw = {704,384},
  w = {320,1280},
  wn = {512,512},
  ws = {576,448},
}
for u, dimensions in pairs(underlays) do
  data:extend({
    {
      type = "simple-entity",
      name = data_util.mod_prefix .. "gate-underlay-"..u,
      flags = {"placeable-neutral"},
      icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
      icon_size = 64,
      render_layer = underlay_render_layer,
      order = "a[ancient]-g[gate]-u[underlay]-"..u,
      collision_mask = {"not-colliding-with-itself"},
      collision_box = {{-dimensions[1]/64/2, -dimensions[2]/64/2}, {dimensions[1]/64/2, dimensions[2]/64/2}},
      selection_box = {{-dimensions[1]/64/2, -dimensions[2]/64/2}, {dimensions[1]/64/2, dimensions[2]/64/2}},
      selectable_in_game = false,
      picture = data_util.auto_sr_hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/underlay-"..u..".png",
        width = dimensions[1],
        height = dimensions[2],
        shift = {0,0},
        scale = 0.5,
      })
    },
  })
end

for i = 1, 8, 1 do
  data:extend({
    {
      type = "simple-entity",
      name = data_util.mod_prefix .. "gate-rails-"..i,
      flags = {"placeable-neutral"},
      icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
      icon_size = 64,
      render_layer = lock_rail_render_layer,
      order = "a[ancient]-g[gate]-r[rails]-"..i,
      collision_mask = {"not-colliding-with-itself"},
      collision_box = {{-1.5, -1}, {1.5, 1}},
      selection_box = {{-1.5, -1}, {1.5, 1}},
      selectable_in_game = false,
      picture = data_util.auto_sr_hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-rails-"..i..".png",
        width = 192,
        height = 128,
        shift = {0,0},
        scale = 0.5,
      })
    },
  })
end

for i = 1, 8, 1 do
  data:extend({
    {
      type = "simple-entity",
      name = data_util.mod_prefix .. "gate-shunt-"..i,
      flags = {"placeable-neutral", "placeable-off-grid"},
      icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
      icon_size = 64,
      render_layer = lock_shunt_render_layer,
      order = "a[ancient]-g[gate]-s[shunt]-"..i,
      collision_mask = {"not-colliding-with-itself"},
      collision_box = {{-2, -1.5}, {2, 1.5}},
      selection_box = {{-2, -1.5}, {2, 1.5}},
      selectable_in_game = false,
      picture = data_util.auto_sr_hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-shunt-"..i..".png",
        width = 256,
        height = 192,
        shift = {0,0},
        scale = 0.5,
      })
    },
  })
end


data:extend({
  -- fragments
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-1",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-1"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-1.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-5+px, -5+px}, {9-px, 1-px}},
    selection_box = {{-5+px, -5+px}, {9-px, 1-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-1.png",
          width = 960,
          height = 512,
          shift = middle_shift({{-6, -6}, {9, 2}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-1-shadow.png",
          width = 1024,
          height = 448,
          shift = {2,-1.5},
          scale = 0.5,q
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-2",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-2"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-2.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-8+px, -1+px}, {8-px, 3-px}},
    selection_box = {{-8+px, -1+px}, {8-px, 3-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-2.png",
          width = 1280,
          height = 320,
          shift = middle_shift({{-10, -2}, {10, 3}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-2-shadow.png",
          width = 1280,
          height = 320,
          shift = {1,0.5},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-3",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-3"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-3.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-10+px, -3.5+px}, {6-px, 3.5-px}},
    selection_box = {{-10+px, -3.5+px}, {6-px, 3.5-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-3.png",
          width = 1280,
          height = 512,
          shift = {-1,-0.5},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-3-shadow.png",
          width = 1216,
          height = 448,
          shift = {0,0},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-4",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-4"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-4.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-3+px, -3+px}, {5-px, 3-px}},
    selection_box = {{-3+px, -3+px}, {5-px, 3-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-4.png",
          width = 640,
          height = 576,
          shift = middle_shift({{-4, -4}, {6, 5}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-4-shadow.png",
          width = 704,
          height = 576,
          shift = middle_shift({{-4, -4}, {7, 5}}),
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-5",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-5"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-5.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-1+px, -1+px}, {1-px, 1-px}},
    selection_box = {{-1+px, -1+px}, {1-px, 1-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-5.png",
          width = 256,
          height = 256,
          shift = middle_shift({{-3, -2}, {1, 2}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-5-shadow.png",
          width = 320,
          height = 192,
          shift = {-0.5,0.5},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-6",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-6.png",
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-6"},
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-2+px, -1+px}, {2-px, 1-px}},
    selection_box = {{-2+px, -1+px}, {2-px, 1-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-6.png",
          width = 384,
          height = 256,
          shift = middle_shift({{-3, -2}, {3, 2}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-6-shadow.png",
          width = 384,
          height = 256,
          shift = middle_shift({{-2, -2}, {4, 2}}),
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-7",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-7.png",
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-7"},
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-3+px, -2+px}, {3-px, 2-px}},
    selection_box = {{-3+px, -2+px}, {3-px, 2-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-7.png",
          width = 448,
          height = 384,
          shift = middle_shift({{-4, -3}, {3, 3}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-7-shadow.png",
          width = 448,
          height = 320,
          shift = {-0.5,0.5},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-8",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-8"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-8.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-3.5+px, -5+px}, {3.5-px, 5-px}},
    selection_box = {{-3.5+px, -5+px}, {3.5-px, 5-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-8.png",
          width = 640,
          height = 832,
          shift = {-0.5, 0.5},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-8-shadow.png",
          width = 640,
          height = 832,
          shift = {-0.5, 1.5},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-9",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-9"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-9.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-2.5+px, -4.5+px}, {2.5-px, 2.5-px}},
    selection_box = {{-2.5+px, -4.5+px}, {2.5-px, 2.5-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-9.png",
          width = 320,
          height = 704,
          shift = {0,-1},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-9-shadow.png",
          width = 384,
          height = 704,
          shift = {0.5,0},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-10",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-10"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-10.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-1+px, -3+px}, {1-px, 1-px}},
    selection_box = {{-1+px, -3+px}, {1-px, 1-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-10.png",
          width = 320,
          height = 512,
          shift = {0.5,0},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-10-shadow.png",
          width = 320,
          height = 512,
          shift = {1.5,0},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-11",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-11"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-11.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-1+px, -1+px}, {1-px, 3-px}},
    selection_box = {{-1+px, -1+px}, {1-px, 3-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-11.png",
          width = 256,
          height = 384,
          shift = middle_shift({{-2, -2}, {2, 4}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-11-shadow.png",
          width = 256,
          height = 320,
          shift = {0,1.5},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-12",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-12"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-12.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-7+px, -6.5+px}, {5-px, 4.5-px}},
    selection_box = {{-7+px, -6.5+px}, {5-px, 4.5-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-12.png",
          width = 832,
          height = 896,
          shift = {-1.5,-0.5},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-12-shadow.png",
          width = 896,
          height = 960,
          shift = {-1,0},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-13",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    minable = {mining_time = 0.5, result = data_util.mod_prefix .. "gate-fragment-13"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/fragment-13.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = placeable_collision,
    collision_box = {{-9+px, -2+px}, {9-px, 6-px}},
    selection_box = {{-9+px, -2+px}, {9-px, 6-px}},
    selectable_in_game = true,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-13.png",
          width = 1344,
          height = 640,
          shift = {-0.5,3},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-13-shadow.png",
          width = 1280,
          height = 640,
          shift = {1,3},
          scale = 0.5,
        })
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-14-a",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-6+px, -15+px}, {6-px, 15-px}},
    selection_box = {{-6+px, -15+px}, {6-px, 15-px}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-14-a.png",
          width = 832,
          height = 2176,
          shift = {-0.5,1},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-14-a-shadow.png",
          width = 832,
          height = 2176,
          shift = {-0.5,1},
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-fragment-14-b",
    localised_name = {"entity-name."..data_util.mod_prefix .. "gate-fragment"},
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = fragment_render_layer,
    order = "a[ancient]-g[gate]-a",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-13.5+px, -1+px}, {13.5-px, 5-px}},
    selection_box = {{-13.5+px, -1+px}, {13.5-px, 5-px}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-14-b.png",
          width = 2048,
          height = 704,
          shift = {2.5,3.5},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/fragment-14-b-shadow.png",
          width = 2048,
          height = 704,
          shift = {2.5,3.5},
          scale = 0.5,
        })
      }
    }
  },

  -- addons
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-addon-1",
    localised_name = {"entity-name."..data_util.mod_prefix.."gate-addon"},
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_addons_render_layer,
    order = "a[ancient]-g[gate]-d[addon]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-1.png",
          width = 384,
          height = 256,
          shift = middle_shift({{-3, -1}, {3, 3}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-1-shadow.png",
          width = 320,
          height = 128,
          shift = middle_shift({{-2, 1}, {3, 3}}),
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-addon-2",
    localised_name = {"entity-name."..data_util.mod_prefix.."gate-addon"},
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_addons_render_layer,
    order = "a[ancient]-g[gate]-d[addon]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-2.png",
          width = 256,
          height = 320,
          shift = middle_shift({{-3, -3}, {1, 2}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-2-shadow.png",
          width = 256,
          height = 128,
          shift = {-1,2},
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-addon-3",
    localised_name = {"entity-name."..data_util.mod_prefix.."gate-addon"},
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_addons_render_layer,
    order = "a[ancient]-g[gate]-d[addon]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-3.png",
          width = 256,
          height = 320,
          shift = middle_shift({{-3, -3}, {1, 2}}) ,
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-3-shadow.png",
          width = 128,
          height = 192,
          shift = {-1.5,1},
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-addon-4",
    localised_name = {"entity-name."..data_util.mod_prefix.."gate-addon"},
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_addons_render_layer,
    order = "a[ancient]-g[gate]-d[addon]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-4.png",
          width = 320,
          height = 192,
          shift = {0.5,-1.5},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-4-shadow.png",
          width = 128,
          height = 64,
          shift = {1,-1.5},
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-addon-5",
    localised_name = {"entity-name."..data_util.mod_prefix.."gate-addon"},
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_addons_render_layer,
    order = "a[ancient]-g[gate]-d[addon]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-5.png",
          width = 320,
          height = 192,
          shift = middle_shift({{-2, -3}, {3, 0}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-5-shadow.png",
          width = 192,
          height = 128,
          shift = {2.5,-1},
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-addon-6",
    localised_name = {"entity-name."..data_util.mod_prefix.."gate-addon"},
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_addons_render_layer,
    order = "a[ancient]-g[gate]-d[addon]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-6.png",
          width = 256,
          height = 320,
          shift = {1, -0.5},
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-6-shadow.png",
          width = 192,
          height = 256,
          shift = {2.5,0},
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-addon-7",
    localised_name = {"entity-name."..data_util.mod_prefix.."gate-addon"},
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_addons_render_layer,
    order = "a[ancient]-g[gate]-d[addon]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-7.png",
          width = 256,
          height = 320,
          shift = middle_shift({{-1, -3}, {3, 2}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-7-shadow.png",
          width = 192,
          height = 256,
          shift = middle_shift({{0, -2}, {3, 2}}),
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-addon-8",
    localised_name = {"entity-name."..data_util.mod_prefix.."gate-addon"},
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_addons_render_layer,
    order = "a[ancient]-g[gate]-d[addon]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-8.png",
          width = 384,
          height = 256,
          shift = middle_shift({{-3, -1}, {3, 3}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/lock-addon-8-shadow.png",
          width = 384,
          height = 192,
          shift = middle_shift({{-3, 0}, {3, 3}}),
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-platform",
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_addons_render_layer,
    order = "a[ancient]-g[gate]-d[addon]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-4.5, -4}, {4.5, 2}},
    selection_box = {{-4.5, -4}, {4.5, 2}},
    selectable_in_game = false,
    picture = {
      layers = {
        data_util.auto_sr_hr({
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/platform.png",
          width = 704,
          height = 384,
          shift = middle_shift({{-5.5, -4}, {5.5, 2}}),
          scale = 0.5,
        }),
        data_util.auto_sr_hr({
          draw_as_shadow = true,
          filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/platform-shadow.png",
          width = 768,
          height = 192,
          shift = {0.5,0.5},
          scale = 0.5,
        }),
      }
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-platform-button-left",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_buttons_render_layer,
    order = "a[ancient]-g[gate]-b[button]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    selectable_in_game = true,
    pictures = {
      blank_image,
      data_util.auto_sr_hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/platform-button-left.png",
        width = 52,
        height = 48,
        shift = {0,0},
        scale = 0.5,
      })
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-platform-button-middle",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_buttons_render_layer,
    order = "a[ancient]-g[gate]-b[button]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    selectable_in_game = false,
    pictures = {
      blank_image,
      data_util.auto_sr_hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/platform-button-middle.png",
        width = 54,
        height = 48,
        shift = {0,0},
        scale = 0.5,
      })
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-platform-button-right",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_buttons_render_layer,
    order = "a[ancient]-g[gate]-b[button]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    selectable_in_game = false,
    pictures = {
      blank_image,
      data_util.auto_sr_hr({
        filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/platform-button-right.png",
        width = 48,
        height = 48,
        shift = {0,0},
        scale = 0.5,
      })
    }
  },
  {
    type = "constant-combinator",
    name = data_util.mod_prefix .. "gate-platform-button-switch",
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-z[invisible]",
    flags = {"placeable-neutral", "placeable-off-grid", "not-deconstructable", "not-blueprintable", },
    collision_box = {{-0.5,-0.5},{0.5,0.5}},
    selection_box = {{-0.5,-0.5},{0.5,0.5}},
    selection_priority = 200,
    collision_mask = {"not-colliding-with-itself"},
    item_slot_count = 0,
    activity_led_light = { color = {b = 1,g = 1,r = 1},intensity = 0.8,size = 1},
    activity_led_light_offsets = {{0.296875,-0.40625},{0.25,-0.03125},{-0.296875,-0.078125},{-0.21875,-0.46875}},
    activity_led_sprites = {
      east = blank_image,
      north = blank_image,
      south = blank_image,
      west = blank_image,
    },
    circuit_wire_connection_points = {
      {shadow = {green = {0.71875,-0.1875},red = {0.21875,-0.1875}},wire = {green = {0.21875,-0.546875},red = {-0.265625,-0.546875}}},
      {shadow = {green = {1,0.25},red = {1,-0.15625}},wire = {green = {0.5,-0.109375},red = {0.5,-0.515625}}},
      {shadow = {green = {0.28125,0.625},red = {0.78125,0.625}},wire = {green = {-0.203125,0.234375},red = {0.28125,0.234375}}},
      {shadow = {green = {0.03125,-0.0625},red = {0.03125,0.34375}},wire = {green = {-0.46875,-0.421875},red = {-0.46875,-0.015625}}}
    },
    circuit_wire_max_distance = 0,
    max_health = 100000,
    sprites = {
      east = blank_image,
      north = blank_image,
      south = blank_image,
      west = blank_image,
    },
  },
  {
    type = "constant-combinator",
    name = data_util.mod_prefix .. "gate-lock-switch",
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-z[invisible]",
    flags = {"placeable-neutral", "placeable-off-grid", "not-deconstructable", "not-blueprintable", },
    collision_box = {{-1.5,-1.5},{1.5,1.5}},
    selection_box = {{-1.5,-1.5},{1.5,1.5}},
    selection_priority = 200,
    collision_mask = {"not-colliding-with-itself"},
    item_slot_count = 0,
    activity_led_light = { color = {b = 1,g = 1,r = 1},intensity = 0.8,size = 1},
    activity_led_light_offsets = {{0.296875,-0.40625},{0.25,-0.03125},{-0.296875,-0.078125},{-0.21875,-0.46875}},
    activity_led_sprites = {
      east = blank_image,
      north = blank_image,
      south = blank_image,
      west = blank_image,
    },
    circuit_wire_connection_points = {
      {shadow = {green = {0.71875,-0.1875},red = {0.21875,-0.1875}},wire = {green = {0.21875,-0.546875},red = {-0.265625,-0.546875}}},
      {shadow = {green = {1,0.25},red = {1,-0.15625}},wire = {green = {0.5,-0.109375},red = {0.5,-0.515625}}},
      {shadow = {green = {0.28125,0.625},red = {0.78125,0.625}},wire = {green = {-0.203125,0.234375},red = {0.28125,0.234375}}},
      {shadow = {green = {0.03125,-0.0625},red = {0.03125,0.34375}},wire = {green = {-0.46875,-0.421875},red = {-0.46875,-0.015625}}}
    },
    circuit_wire_max_distance = 0,
    max_health = 100000,
    sprites = {
      east = blank_image,
      north = blank_image,
      south = blank_image,
      west = blank_image,
    },
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-platform-indicator-green",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_buttons_render_layer,
    order = "a[ancient]-g[gate]-b[button]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-0.1, -0.25}, {0.1, 0.25}},
    selection_box = {{-0.1, -0.25}, {0.1, 0.25}},
    selectable_in_game = false,
    picture = data_util.auto_sr_hr({
      filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/platform-indicator-green.png",
      width = 14,
      height = 26,
      shift = {0,0},
      scale = 0.5,
    })
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-platform-indicator-yellow",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_buttons_render_layer,
    order = "a[ancient]-g[gate]-b[button]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-0.1, -0.25}, {0.1, 0.25}},
    selection_box = {{-0.1, -0.25}, {0.1, 0.25}},
    selectable_in_game = false,
    picture = data_util.auto_sr_hr({
      filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/platform-indicator-yellow.png",
      width = 14,
      height = 26,
      shift = {0,0},
      scale = 0.5,
    })
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-platform-indicator-red",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    render_layer = portal_buttons_render_layer,
    order = "a[ancient]-g[gate]-b[button]",
    collision_mask = {"not-colliding-with-itself"},
    collision_box = {{-0.1, -0.25}, {0.1, 0.25}},
    selection_box = {{-0.1, -0.25}, {0.1, 0.25}},
    selectable_in_game = false,
    picture = data_util.auto_sr_hr({
      filename = "__space-exploration-hr-graphics__/graphics/entity/gate/hr/platform-indicator-red.png",
      width = 14,
      height = 26,
      shift = {0,0},
      scale = 0.5,
    })
  },
  {
    type = "sprite",
    name = data_util.mod_prefix .. "gate-void-sprite",
    filename = "__space-exploration-graphics__/graphics/entity/gate/void.png",
    priority = "extra-high",
    width = 512,
    height = 362,
    shift = {0,0}
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-blocker",
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-b[button]",
    collision_mask = {"object-layer", "floor-layer", "item-layer"},
    collision_box = {{-0.49, -0.49}, {0.49, 0.49}},
    selection_box = {{-0.49, -0.49}, {0.49, 0.49}},
    selectable_in_game = false,
    map_color = {r=0.8, g=0.8, b=0.8, a=1},
    picture = {
      filename = "__space-exploration-graphics__/graphics/blank.png",
      width = 1,
      height = 1,
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-blocker-void",
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-b[button]",
    collision_mask = {"object-layer", "floor-layer", "item-layer"},
    collision_box = {{-0.49, -0.49}, {0.49, 0.49}},
    selection_box = {{-0.49, -0.49}, {0.49, 0.49}},
    selectable_in_game = false,
    map_color = {r=0, g=0, b=0, a=1},
    picture = {
      filename = "__space-exploration-graphics__/graphics/blank.png",
      width = 1,
      height = 1,
    }
  },
  {
    type = "simple-entity",
    name = data_util.mod_prefix .. "gate-tryplace",
    flags = {"placeable-neutral"},
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-b[button]",
    collision_mask = placeable_collision,
    collision_box = {{-35.5, -26.5}, {35.5, 26.5}}, -- note gate registration point is at -0.5,-0.5 from this center
    selection_box = {{-35.5, -26.5}, {35.5, 26.5}},
    selectable_in_game = false,
    map_color = {r=1, g=0, b=0, a=1},
    picture = {
      filename = "__space-exploration-graphics__/graphics/blank.png",
      width = 1,
      height = 1,
    }
  },

  -- active entities
  {
    type = "storage-tank",
    name = data_util.mod_prefix .. "gate-tank-input",
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    scale_info_icons = false,
    render_layer = "higher-object-above",
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    max_health = 500,
    order = "a[ancient]-g[gate]-z[invisible]",
    corpse = "medium-remnants",
    collision_box = {{-0.5+px,-0.5+px},{0.5-px,0.5-px}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = {{-0.5+px,-0.5+px},{0.5-px,0.5-px}},
    selectable_in_game = true,
    fluid_box =
    {
      filter = data_util.mod_prefix .. "space-coolant-supercooled",
      base_area = 10, -- gets multiplied by 100 by engine
      base_level = -1, -- pull fluid in
      pipe_covers = no_north_cover_pictures,
      pipe_connections =
      {
        { position = {0, -1} },
      },
      secondary_draw_orders = { north = -1 }
    },
    window_bounding_box = {{0, 0}, {0, 0}},
    pictures =
    {
      picture = blank_image,
      fluid_background = blank_image,
      window_background = blank_image,
      flow_sprite = blank_image,
      gas_flow = blank_image,
    },
    flow_length_in_ticks = 360,
    circuit_wire_max_distance = 0
  },
  {
    type = "storage-tank",
    name = data_util.mod_prefix .. "gate-tank-output",
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-z[invisible]",
    scale_info_icons = false,
    render_layer = "higher-object-above",
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable"},
    max_health = 500,
    order = "a[ancient]-g[gate]-z[invisible]",
    corpse = "medium-remnants",
    collision_box = {{-0.5+px,-0.5+px},{0.5-px,0.5-px}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = {{-0.5+px,-0.5+px},{0.5-px,0.5-px}},
    selectable_in_game = true,
    fluid_box =
    {
      filter = data_util.mod_prefix .. "space-coolant-hot",
      base_area = 10, -- gets multiplied by 100 by engine
      base_level = 2, -- push fluid out
      pipe_covers = no_north_cover_pictures,
      pipe_connections =
      {
        { position = {0, -1} },
      },
      secondary_draw_orders = { north = -1 }
    },
    window_bounding_box = {{0, 0}, {0, 0}},
    pictures =
    {
      picture = blank_image,
      fluid_background = blank_image,
      window_background = blank_image,
      flow_sprite = blank_image,
      gas_flow = blank_image,
    },
    flow_length_in_ticks = 360,
    circuit_wire_max_distance = 0
  },
  {
    type = "constant-combinator",
    name = data_util.mod_prefix .. "gate-lock-combinator",
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-z[invisible]",
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable", "placeable-off-grid"},
    collision_box = {{-0.35,-0.35},{0.35,0.35}},
    selection_box = {{-0.5,-0.5},{0.5,0.5}},
    selection_priority = 200,
    collision_mask = {"not-colliding-with-itself"},
    item_slot_count = 18,
    activity_led_light = { color = {b = 1,g = 1,r = 1},intensity = 0.8,size = 1},
    activity_led_light_offsets = {{0.296875,-0.40625},{0.25,-0.03125},{-0.296875,-0.078125},{-0.21875,-0.46875}},
    activity_led_sprites = {
      east = {
        filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-E.png",
        frame_count = 1,
        width = 8,
        height = 8,
        shift = {0.25,0},
        hr_version = {
          filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-E.png",
          frame_count = 1,
          width = 14,
          height = 14,
          scale = 0.5,
          shift = {0.234375,-0.015625},
        },
      },
      north = {
        filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-N.png",
        frame_count = 1,
        width = 8,
        height = 6,
        shift = {0.28125,-0.375},
        hr_version = {
          filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-N.png",
          frame_count = 1,
          width = 14,
          height = 12,
          scale = 0.5,
          shift = {0.28125,-0.359375},
        },
      },
      south = {
        filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-S.png",
        frame_count = 1,
        width = 8,
        height = 8,
        shift = {-0.28125,0.0625},
        hr_version = {
          filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-S.png",
          frame_count = 1,
          width = 14,
          height = 16,
          scale = 0.5,
          shift = {-0.28125,0.078125},
        },
      },
      west = {
        filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-W.png",
        frame_count = 1,
        width = 8,
        height = 8,
        shift = {-0.21875,-0.46875},
        hr_version = {
          filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-W.png",
          frame_count = 1,
          width = 14,
          height = 16,
          scale = 0.5,
          shift = {-0.21875,-0.46875},
        },
      }
    },
    circuit_wire_connection_points = {
      {shadow = {green = {0.71875,-0.1875},red = {0.21875,-0.1875}},wire = {green = {0.21875,-0.546875},red = {-0.265625,-0.546875}}},
      {shadow = {green = {1,0.25},red = {1,-0.15625}},wire = {green = {0.5,-0.109375},red = {0.5,-0.515625}}},
      {shadow = {green = {0.28125,0.625},red = {0.78125,0.625}},wire = {green = {-0.203125,0.234375},red = {0.28125,0.234375}}},
      {shadow = {green = {0.03125,-0.0625},red = {0.03125,0.34375}},wire = {green = {-0.46875,-0.421875},red = {-0.46875,-0.015625}}}
    },
    circuit_wire_max_distance = 9,
    max_health = 100000,
    sprites = {
      east = blank_image,
      north = blank_image,
      south = blank_image,
      west = blank_image,
    },
  },
  {
    type = "constant-combinator",
    name = data_util.mod_prefix .. "gate-platform-combinator",
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-z[invisible]",
    flags = {"placeable-neutral", "not-deconstructable", "not-blueprintable", "placeable-off-grid"},
    collision_box = {{-0.35,-0.35},{0.35,0.35}},
    selection_box = {{-0.6,-0.7},{0.6,0}},
    selection_priority = 200,
    collision_mask = {"not-colliding-with-itself"},
    item_slot_count = 18,
    activity_led_light = { color = {b = 1,g = 1,r = 1},intensity = 0.8,size = 1},
    activity_led_light_offsets = {{0.296875,-0.40625},{0.25,-0.03125},{-0.296875,-0.078125},{-0.21875,-0.46875}},
    activity_led_sprites = {
      east = {
        filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-E.png",
        frame_count = 1,
        width = 8,
        height = 8,
        shift = {0.25,0},
        hr_version = {
          filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-E.png",
          frame_count = 1,
          width = 14,
          height = 14,
          scale = 0.5,
          shift = {0.234375,-0.015625},
        },
      },
      north = {
        filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-N.png",
        frame_count = 1,
        width = 8,
        height = 6,
        shift = {0.28125,-0.375},
        hr_version = {
          filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-N.png",
          frame_count = 1,
          width = 14,
          height = 12,
          scale = 0.5,
          shift = {0.28125,-0.359375},
        },
      },
      south = {
        filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-S.png",
        frame_count = 1,
        width = 8,
        height = 8,
        shift = {-0.28125,0.0625},
        hr_version = {
          filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-S.png",
          frame_count = 1,
          width = 14,
          height = 16,
          scale = 0.5,
          shift = {-0.28125,0.078125},
        },
      },
      west = {
        filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-W.png",
        frame_count = 1,
        width = 8,
        height = 8,
        shift = {-0.21875,-0.46875},
        hr_version = {
          filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-W.png",
          frame_count = 1,
          width = 14,
          height = 16,
          scale = 0.5,
          shift = {-0.21875,-0.46875},
        },
      }
    },
    circuit_wire_connection_points = {
      {shadow = {green = {0.71875,-0.1875},red = {0.21875,-0.1875}},wire = {green = {0.21875,-0.546875},red = {-0.265625,-0.546875}}},
      {shadow = {green = {1,0.25},red = {1,-0.15625}},wire = {green = {0.5,-0.109375},red = {0.5,-0.515625}}},
      {shadow = {green = {0.28125,0.625},red = {0.78125,0.625}},wire = {green = {-0.203125,0.234375},red = {0.28125,0.234375}}},
      {shadow = {green = {0.03125,-0.0625},red = {0.03125,0.34375}},wire = {green = {-0.46875,-0.421875},red = {-0.46875,-0.015625}}}
    },
    circuit_wire_max_distance = 9,
    max_health = 100000,
    sprites = {
      east = blank_image,
      north = blank_image,
      south = blank_image,
      west = blank_image,
    },
  },
  {
    type = "electric-energy-interface",
    name = data_util.mod_prefix .. "gate-energy-interface",
    icon = "__space-exploration-graphics__/graphics/icons/gate/gate.png",
    icon_size = 64,
    order = "a[ancient]-g[gate]-z[invisible]",
    allow_copy_paste = false,
    picture = blank_image,
    collision_box = {{-4.5+px, -1.5+px},{4.5-px, 1.5-px}},
    selection_box = {{-4.5+px, -1.5+px},{4.5-px, 1.5-px}},
    collision_mask = {"not-colliding-with-itself"},
    selectable = false,
    continuous_animation = true,
    corpse = "medium-remnants",
    energy_source = {
      buffer_capacity = "1GJ",
      --input_flow_limit = "60GW", -- total when all active (values over 60GW won't work)
      input_flow_limit = "22GW", -- total when all active (values over 60GW won't work)
      output_flow_limit = "0kW",
      type = "electric",
      usage_priority = "primary-input"
    },
    energy_production = "0kW",
    --energy_usage = "60GW", -- platform + 1x per lock + 1x for final energy spike final activation.
    energy_usage = "20GW", -- platform + 1x per lock + 1x for final energy spike final activation.
    flags = {
      "placeable-player",
      "player-creation",
      "hidden",
      "not-rotatable"
    },
    max_health = 150000,
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    working_sound = {
      fade_in_ticks = 10,
      fade_out_ticks = 30,
      idle_sound = {
        filename = "__base__/sound/accumulator-idle.ogg",
        volume = 0.5
      },
      max_sounds_per_type = 3,
      sound = {
        filename = "__base__/sound/accumulator-working.ogg",
        volume = 1
      }
    }
  },
  {
    type = "animation",
    name = data_util.mod_prefix .. "gate-cloud",
    animation_speed = 0.5,
    filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
    flags = {
      "compressed"
    },
    frame_count = 45,
    height = 256,
    line_length = 7,
    priority = "low",
    scale = 3,
    width = 256,
    apply_runtime_tint = true,
    blend_mode = "additive", --"additive-soft"
  },
  {
    type = "projectile",
    name = data_util.mod_prefix .. "gate-spec-white",
    direction_only = false,
    flags = { "not-on-map", "placeable-off-grid" },
    acceleration = -0.001,
    collision_mask = {"not-colliding-with-itself"},
    animation = {
      filename = "__space-exploration-graphics__/graphics/entity/spaceship-particle/speck.png",
      frame_count = 1,
      height = 50,
      priority = "high",
      width = 3,
      apply_runtime_tint = true,
      blend_mode = "additive", --"additive-soft"
      scale = 1
    },
  },
  {
    type = "projectile",
    name = data_util.mod_prefix .. "gate-spec-cyan",
    direction_only = false,
    flags = { "not-on-map", "placeable-off-grid" },
    acceleration = -0.001,
    collision_mask = {"not-colliding-with-itself"},
    animation = {
      filename = "__space-exploration-graphics__/graphics/entity/spaceship-particle/speck.png",
      frame_count = 1,
      height = 50,
      priority = "high",
      width = 3,
      apply_runtime_tint = true,
      blend_mode = "additive", --"additive-soft"
      tint = {r = 0.0, g = 0.6, b = 1, a = 1},
      scale = 1
    },
  },
})
