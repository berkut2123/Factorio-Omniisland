local function bobclass_button_style(filename)
return {
      type = "button_style",
      font = "default-button",
      default_font_color={r=1, g=1, b=1},
      align = "center",
      width = 36,
      height = 36,
      top_padding = 5,
      right_padding = 5,
      bottom_padding = 5,
      left_padding = 5,
      default_graphical_set =
      {
        type = "monolith",
        monolith_image =
        {
          filename = filename,
          priority = "extra-high-no-scale",
          load_in_minimal_mode = true,
          width = 36,
          height = 36,
        }
      },
      hovered_font_color = {r=0, g=0, b=0},
      hovered_graphical_set =
      {
        type = "monolith",
        monolith_image =
        {
          filename = filename,
          priority = "extra-high-no-scale",
          load_in_minimal_mode = true,
          width = 36,
          height = 36,
          x = 36
        }
      },
      clicked_font_color={r=1, g=1, b=1},
      clicked_graphical_set =
      {
        type = "monolith",
        monolith_image =
        {
          filename = filename,
          priority = "extra-high-no-scale",
          load_in_minimal_mode = true,
          width = 36,
          height = 36,
          x = 72
        }
      },
      disabled_font_color={r=0.5, g=0.5, b=0.5},
      disabled_graphical_set =
      {
        type = "monolith",
        monolith_image =
        {
          filename = filename,
          priority = "extra-high-no-scale",
          load_in_minimal_mode = true,
          width = 36,
          height = 36,
          x = 108
        }
      },
      pie_progress_color = {r=1, g=1, b=1}
    }
end

data.raw["gui-style"].default.bobclass_ballanced_button = bobclass_button_style("__bobclasses__/buttons/ballanced-button.png")
data.raw["gui-style"].default.bobclass_miner_button = bobclass_button_style("__bobclasses__/buttons/miner-button.png")
data.raw["gui-style"].default.bobclass_fighter_button = bobclass_button_style("__bobclasses__/buttons/fighter-button.png")
data.raw["gui-style"].default.bobclass_builder_button = bobclass_button_style("__bobclasses__/buttons/builder-button.png")


--[[
local function bobclass_button_style(filename)
return {
      type = "button_style",
      font = "default-button",
      default_font_color={r=1, g=1, b=1},
      align = "center",
      width = 36,
      height = 36,
      top_padding = 5,
      right_padding = 5,
      bottom_padding = 5,
      left_padding = 5,
      default_graphical_set =
      {
        type = "monolith",
        monolith_image =
        {
          layers =
          {
            {
              filename = "__bobclasses__/buttons/button.png",
              priority = "extra-high-no-scale",
              load_in_minimal_mode = true,
              width = 36,
              height = 36,
            },
            {
              filename = filename,
              priority = "extra-high-no-scale",
              load_in_minimal_mode = true,
              width = 32,
              height = 32,
              shift = {2, 2}
            }
          }
        }
      },
      hovered_font_color = {r=0, g=0, b=0},
      hovered_graphical_set =
      {
        type = "monolith",
        monolith_image =
        {
          layers =
          {
            {
              filename = "__bobclasses__/buttons/button.png",
              priority = "extra-high-no-scale",
              load_in_minimal_mode = true,
              width = 36,
              height = 36,
              x = 36
            },
            {
              filename = filename,
              priority = "extra-high-no-scale",
              load_in_minimal_mode = true,
              width = 32,
              height = 32,
              shift = {2, 2}
            }
          }
        }
      },
      clicked_font_color={r=1, g=1, b=1},
      clicked_graphical_set =
      {
        type = "monolith",
        monolith_image =
        {
          layers =
          {
            {
              filename = "__bobclasses__/buttons/button.png",
              priority = "extra-high-no-scale",
              load_in_minimal_mode = true,
              width = 36,
              height = 36,
              x = 72
            },
            {
              filename = filename,
              priority = "extra-high-no-scale",
              load_in_minimal_mode = true,
              width = 32,
              height = 32,
              shift = {3, 3}
            }
          }
        }
      },
      disabled_font_color={r=0.5, g=0.5, b=0.5},
      disabled_graphical_set =
      {
        type = "monolith",
        monolith_image =
        {
          layers =
          {
            {
              filename = "__bobclasses__/buttons/button.png",
              priority = "extra-high-no-scale",
              load_in_minimal_mode = true,
              width = 36,
              height = 36,
              x = 108
            },
            {
              filename = filename,
              priority = "extra-high-no-scale",
              load_in_minimal_mode = true,
              width = 32,
              height = 32,
              tint = {r = 1, g = 1, b = 1, a = 0.5},
              shift = {2, 2}
            }
          }
        }
      },
      pie_progress_color = {r=1, g=1, b=1}
    }
end

data.raw["gui-style"].default.bobclass_ballanced_button = bobclass_button_style("__bobclasses__/icons/ballanced.png")
data.raw["gui-style"].default.bobclass_miner_button = bobclass_button_style("__bobclasses__/icons/miner.png")
data.raw["gui-style"].default.bobclass_fighter_button = bobclass_button_style("__bobclasses__/icons/fighter.png")
data.raw["gui-style"].default.bobclass_builder_button = bobclass_button_style("__bobclasses__/icons/builder.png")
]]--


