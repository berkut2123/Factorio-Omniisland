local data_util = require("data_util")

data:extend({
  {
    name = data_util.mod_prefix .. "pyramid-a",
    type = "simple-entity",
    map_color = {r = 0, g = 0, b = 0},
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/pyramid.png",
    icon_size = 64,
    order = "a[ancient]-p[pyramid]-a",
    collision_box = {{-9, -7}, {9, 7}},
    collision_mask = {"item-layer","object-layer","player-layer","water-tile"},
    selection_box = {{-9, -7}, {9, 7}},
    render_layer = "object",
    selectable_in_game = false,
    picture =
    {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/pyramid-a.png",
          width = 622+64,
          height = 571+32,
          shift = {0,-1+0.25},
          scale = 1,
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/pyramid-a-shadow.png",
          width = 743,
          height = 584,
          shift = {1.5-2/32,-1+8/32},
          scale = 1,
        }
      }
    }
  },
  {
    name = data_util.mod_prefix .. "pyramid-b",
    type = "simple-entity",
    map_color = {r = 0, g = 0, b = 0},
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/pyramid.png",
    icon_size = 64,
    order = "a[ancient]-p[pyramid]-b",
    collision_box = {{-9, -7}, {9, 7}},
    collision_mask = {"item-layer","object-layer","player-layer","water-tile"},
    selection_box = {{-9, -7}, {9, 7}},
    render_layer = "object",
    selectable_in_game = false,
    picture =
    {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/pyramid-b.png",
          width = 611+64,
          height = 554+32,
          shift = {0,-1.5+0.25},
          scale = 1,
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/pyramid-b-shadow.png",
          width = 867,
          height = 568,
          shift = {3.5+2/32,-1.5+8/32},
          scale = 1,
        }
      }
    }
  },
  {
    name = data_util.mod_prefix .. "pyramid-c",
    type = "simple-entity",
    map_color = {r = 0, g = 0, b = 0},
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/pyramid.png",
    icon_size = 64,
    order = "a[ancient]-p[pyramid]-c",
    collision_box = {{-9, -7}, {9, 7}},
    collision_mask = {"item-layer","object-layer","player-layer","water-tile"},
    selection_box = {{-9, -7}, {9, 7}},
    render_layer = "object",
    selectable_in_game = false,
    picture =
    {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/pyramid-c.png",
          width = 623+64,
          height = 571+32,
          shift = {0,-1+0.25},
          scale = 1,
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/pyramid-c-shadow.png",
          width = 976,
          height = 584,
          shift = {5+4/32,-1+8/32},
          scale = 1,
        }
      }
    }
  },
  {
    name = data_util.mod_prefix .. "cartouche-a",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__space-exploration-graphics__/graphics/icons/cartouche-a.png",
    icon_size = 64,
    order = "a[ancient]-c[cartouche]-a[a]",
    collision_box = {{-9, -7}, {9, 7}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = {{-9, -7}, {9, 7}},
    render_layer = "floor",
    selectable_in_game = false,
    picture =
    {
      filename = "__space-exploration-graphics__/graphics/entity/cartouche/cartouche-a.png",
      width = 1154,
      height = 821,
      shift = {0,0},
      scale = 0.5,
    }
  },
  {
    name = data_util.mod_prefix .. "cartouche-b-a",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__space-exploration-graphics__/graphics/icons/cartouche-b-a.png",
    icon_size = 64,
    order = "a[ancient]-c[cartouche]-b[b]-a",
    collision_box = {{-4, -3}, {4, 3}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = {{-4, -3}, {4, 3}},
    selectable_in_game = false,
    render_layer = "floor",
    picture =
    {
      filename = "__space-exploration-graphics__/graphics/entity/cartouche/cartouche-b-a.png",
      width = 520,
      height = 373,
      shift = {0,0},
      scale = 0.5,
    }
  },
  {
    name = data_util.mod_prefix .. "cartouche-b-b",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__space-exploration-graphics__/graphics/icons/cartouche-b-b.png",
    icon_size = 64,
    order = "a[ancient]-c[cartouche]-b[b]-b",
    collision_box = {{-1, -1}, {1, 1}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = {{-1, -1}, {1, 1}},
    selectable_in_game = false,
    render_layer = "floor",
    picture =
    {
      filename = "__space-exploration-graphics__/graphics/entity/cartouche/cartouche-b-b.png",
      width = 520,
      height = 373,
      shift = {0,0},
      scale = 0.5,
    }
  },
  {
    type = "container",
    name = data_util.mod_prefix .. "cartouche-chest", -- "rocket-launch-pad-chest"
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
    icon = "__space-exploration-graphics__/graphics/icons/cartouche-chest.png",
    icon_size = 64,
    inventory_size = 10,
    max_health = 1000,
    open_sound = {
      filename = "__base__/sound/metallic-chest-open.ogg",
      volume = 0.65
    },
    order = "z-z",
    picture = {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/chest.png",
          height = 128,
          priority = "extra-high",
          shift = { 0, 0 },
          width = 128,
          scale = 0.5
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/chest-shadow.png",
          height = 96,
          priority = "extra-high",
          shift = { 8/32, 8/32 },
          width = 160,
          scale = 0.5
        },
      }
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    }
  },
})

for i = 1, 64, 1 do
  local large = {
    name = data_util.mod_prefix .. "glyph-a-"..i,
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__space-exploration-graphics__/graphics/icons/glyph/glyph-a-"..i..".png",
    icon_size = 64,
    order = "a[ancient]-c[cartouche]-g[glyph]-a[a]-"..i,
    collision_box = {{-1, -1}, {1, 1}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = {{-1, -1}, {1, 1}},
    selectable_in_game = false,
    render_layer = "lower-object",
    picture =
    {
      filename = "__space-exploration-graphics__/graphics/entity/cartouche/glyphs-a-metal.png",
      width = 2048/8,
      height = 1536/8,
      x = ((i-1)%8)*2048/8,
      y = math.floor((i-1)/8)*1536/8,
      shift = {0,0},
      scale = 0.5,
    },
    localised_name = {"entity-name.glyph"}
  }
  local small = table.deepcopy(large)
  small.name = small.name .. "-small"
  small.picture.scale = small.picture.scale * 0.5
  data:extend({small, large})
end

for i = 1, 64, 1 do
  local large = {
    name = data_util.mod_prefix .. "glyph-b-"..i,
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__space-exploration-graphics__/graphics/icons/glyph/glyph-b-"..i..".png",
    icon_size = 64,
    order = "a[ancient]-c[cartouche]-g[glyph]-b[b]-"..i,
    collision_box = {{-4, -3}, {4, 3}},
    collision_mask = {"not-colliding-with-itself"},
    selection_box = {{-4, -3}, {4, 3}},
    selectable_in_game = false,
    render_layer = "lower-object",
    picture =
    {
      filename = "__space-exploration-graphics__/graphics/entity/cartouche/glyphs-b-metal.png",
      width = 1280/8,
      height = 1024/8,
      x = ((i-1)%8)*1280/8,
      y = math.floor((i-1)/8)*1024/8,
      shift = {0,0},
      scale = 0.5,
    },
    localised_name = {"entity-name.glyph"}
  }
  local small = table.deepcopy(large)
  small.name = small.name .. "-small"
  small.picture.scale = small.picture.scale * 0.65
  data:extend({small, large})
end

data:extend({
  --[[{
    name = data_util.mod_prefix .. "lightbeam-a",
    type = "projectile",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-exploration-graphics__/graphics/icons/pyramid.png",
    icon_size = 64,
    order = "a[ancient]-p[pyramid]-a",
    collision_box = {{-9, -7}, {9, 7}},
    collision_mask = {"item-layer","object-layer","player-layer","water-tile"},
    selection_box = {{-9, -7}, {9, 7}},
    render_layer = "object",
    selectable_in_game = false,
    picture =
    {
      layers = {
        {
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/pyramid-a.png",
          width = 622,
          height = 571,
          shift = {0,-1},
          scale = 1,
        },
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics__/graphics/entity/cartouche/pyramid-a-shadow.png",
          width = 743,
          height = 584,
          shift = {1.5-2/32,-1+8/32},
          scale = 1,
        }
      }
    }
  },]]--
  {
    type = "projectile",
    name = data_util.mod_prefix .. "lightbeam-a",
    acceleration = 0,
    rotatable = false,
    animation = {
      filename = "__space-exploration-graphics__/graphics/entity/cartouche/lightbeam-a.png",
      frame_count = 1,
      width = 296,
      height = 193,
      line_length = 1,
      priority = "high",
      shift = { 0, 0 },
      scale = 1,
      blend_mode = "additive"
    },
    flags = { "not-on-map" },
    light = { intensity = 2, size = 16, color={r=1,g=0.9,b=0.8}},
  },

})
