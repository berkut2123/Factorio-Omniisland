local data_util = require("data_util")

data:extend({
  {
    type = "shortcut",
    name = data_util.mod_prefix .. "remote-view",
    localised_name = { "shortcut."..data_util.mod_prefix .. "remote-view"},
    order = "a",
    action = "lua",
    style = "blue",
    icon = {
      filename = "__space-exploration-graphics__/graphics/icons/shortcut-toolbar/remote-view-32-white.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 32
    },
    small_icon = {
      filename = "__space-exploration-graphics__/graphics/icons/shortcut-toolbar/remote-view-24-white.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 24
    },
    disabled_small_icon = {
      filename = "__space-exploration-graphics__/graphics/icons/shortcut-toolbar/remote-view-24-black.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 24
    },
  },
  {
    type = "shortcut",
    name = data_util.mod_prefix .. "universe-explorer",
    localised_name = { "shortcut."..data_util.mod_prefix .. "universe-explorer"},
    order = "a",
    action = "lua",
    style = "blue",
    icon = {
      filename = "__space-exploration-graphics__/graphics/icons/astronomical/planet-orbit.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 32
    },
    small_icon = {
      filename = "__space-exploration-graphics__/graphics/icons/astronomical/planet-orbit.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 32
    },
    disabled_small_icon = {
      filename = "__space-exploration-graphics__/graphics/icons/astronomical/planet-orbit.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 32
    },
  },
  {
    type = "shortcut",
    name = data_util.mod_prefix .. "respawn",
    localised_name = { "shortcut."..data_util.mod_prefix .. "respawn"},
    order = "a",
    action = "lua",
    style = "red",
    icon = {
      filename = "__space-exploration-graphics__/graphics/icons/shortcut-toolbar/respawn-32-white.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 32
    },
    small_icon = {
      filename = "__space-exploration-graphics__/graphics/icons/shortcut-toolbar/respawn-24-white.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 24
    },
    disabled_small_icon = {
      filename = "__space-exploration-graphics__/graphics/icons/shortcut-toolbar/respawn-24-black.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 24
    },
  },
})
