informatron_menu_width = 250
informatron_content_width = 940 -- inner width is informatron_content_width - 40

data.raw["gui-style"]["default"]["informatron_image_container"] = {
  type = "frame_style",
  padding = 4,
  width = informatron_content_width - 40,
  graphical_set = {
    base = {
      corner_size = 8,
      opacity = 0.9,
      position = { 403, 0 }
    },
    shadow = nil
  },
  vertical_flow_style = {
    type = "vertical_flow_style",
    vertical_spacing = 2
  },
  top_margin = 15,
  bottom_margin = 15,
  horizontal_align = "center",
}

function informatron_make_image(unique_name, filename, width, height)
  data.raw["gui-style"]["default"][unique_name] = {
    width = width,
    height = height,
    type = "button_style",
    clicked_graphical_set = { filename = filename, scale = 1, width = width, height = height},
    default_graphical_set = { filename = filename, scale = 1, width = width, height = height},
    disabled_graphical_set = { filename = filename, scale = 1, width = width, height = height},
    hovered_graphical_set = { filename = filename, scale = 1, width = width, height = height},
  }
end

data.raw["gui-style"]["default"]["informatron_title_frame"] = {
  type = "frame_style",
  graphical_set = {},
  horizontally_stretchable = "on",
  padding = 0,
  right_margin = 6,
  top_margin = 4,
  vertical_align = "center"
}

data.raw["gui-style"]["default"]["informatron_close_button"] = {
  parent = "frame_button",
  size = 20,
  type = "button_style",
  top_padding = -2,
  top_margin = -4,
  default_font_color = { 1,1,1 },
}

data.raw["gui-style"]["default"]["informatron_inside_deep_frame"] = {
  type = "frame_style",
  graphical_set = {
    base = {
      center = {
        position = { 42, 8 },
        size = { 1,1 }
      },
      corner_size = 8,
      draw_type = "outer",
      position = {17,0}
    },
    shadow = nil
  },
  padding = 0,
  parent = "frame",
  vertical_flow_style = {
    type = "vertical_flow_style",
    vertical_spacing = 0
  },
  vertically_stretchable = "on",
}

data.raw["gui-style"]["default"]["informatron_content_pane"] = {
  type = "scroll_pane_style",
  extra_padding_when_activated = -4,
  graphical_set = {
    base = {},
    shadow = nil
  },
  padding = 8,
  vertical_scrollbar_style = {
    background_graphical_set = {
      blend_mode = "multiplicative-with-alpha",
      corner_size = 8,
      opacity = 0.7,
      position = {
        0,
        72
      }
    },
    type = "vertical_scrollbar_style"
  },
  vertically_stretchable = "on",
  horizontally_squashable = "on",
  width = informatron_content_width,
  minimal_height = 600,
  padding = 18,
}

data.raw["gui-style"]["default"]["informatron_content_title"] = {
  type = "frame_style",
  graphical_set = {
    base = {
      background_blur_sigma = 4,
      corner_size = 8,
      opacity = 0.88,
      position = {
        403,
        0
      }
    },
    shadow = nil
  },
  vertical_flow_style = {
    type = "vertical_flow_style",
    vertical_spacing = 2
  },
  use_header_filler = false,
  top_padding = 5,
  bottom_padding = 2,
  right_padding = 10,
  left_padding = 10
}

data.raw["gui-style"]["default"]["informatron_menu_pane"] = {
  type = "scroll_pane_style",
  vertically_stretchable = "on",
  width = informatron_menu_width,
  padding = 0,
  extra_padding_when_activated = 0,
  extra_left_margin_when_activated = 0
}

data.raw["gui-style"]["default"]["informatron_menu_button"] = {
  type = "button_style",
  font = "default-listbox",
  horizontal_align = "left",
  horizontally_stretchable = "on",
  horizontally_squashable = "on",
  width = informatron_menu_width,
  bottom_margin = -3,
  default_font_color = {250/255,250/255,250/255},
  hovered_font_color = { 0.0, 0.0, 0.0 },
  selected_clicked_font_color = { 0.97, 0.54, 0.15 },
  selected_font_color = { 0.97, 0.54, 0.15 },
  selected_hovered_font_color = { 0.97, 0.54, 0.15  },
  clicked_graphical_set = {
    corner_size = 8,
    position = { 51, 17 }
  },
  default_graphical_set = {
    corner_size = 8,
    position = { 208, 17 }
  },
  disabled_graphical_set = {
    corner_size = 8,
    position = { 17, 17 }
  },
  hovered_graphical_set = {
    base = {
      corner_size = 8,
      position = { 34, 17 }
    }
  }
}

data.raw["gui-style"]["default"]["informatron_menu_button_primary"] = {
  type = "button_style",
  parent = "informatron_menu_button",
  font = "default-bold",
  default_font_color = {255/255,230/255,192/255},
}

data.raw["gui-style"]["default"]["informatron_menu_button_selected"] = {
  type = "button_style",
  parent = "informatron_menu_button",
  default_font_color = { 0.0, 0.0, 0.0 },
  hovered_font_color = { 0.0, 0.0, 0.0 },
  selected_clicked_font_color = { 0.0, 0.0, 0.0 },
  selected_font_color = { 0.0, 0.0, 0.0 },
  selected_hovered_font_color = { 0.0, 0.0, 0.0 },
  clicked_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    position = { 75, 108 },
    scale = 1,
    size = 36
  },
  default_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    position = {75,108},
    scale = 1,
    size = 36
  },
  hovered_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    position = {75,108},
    scale = 1,
    size = 36
  },
}

data.raw["gui-style"]["default"]["informatron_menu_button_primary_selected"] = {
  type = "button_style",
  parent = "informatron_menu_button_selected",
  font = "default-bold",
}
