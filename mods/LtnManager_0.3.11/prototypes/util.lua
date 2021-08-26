local util = {}

for key, value in pairs(require("__core__.lualib.util")) do
  util[key] = value
end

util.paths = {
  nav_icons = "__LtnManager__/graphics/gui/frame-action-icons.png",
  shortcut_icons = "__LtnManager__/graphics/shortcut/ltn-manager-shortcut.png"
}

util.empty_checkmark = {
  filename = "__core__/graphics/empty.png",
  priority = "very-low",
  width = 1,
  height = 1,
  frame_count = 1,
  scale = 8
}

return util