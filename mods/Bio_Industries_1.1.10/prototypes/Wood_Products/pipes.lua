--~ local BioInd = require('common')('Bio_Industries')

--~ local ICONPATH = BioInd.modRoot .. "/graphics/icons/"

local pipes_sheet = {
  straight_vertical_single = {
    number = 11,
    position = {x = 0, y = 0},
    size = {x = 8, y = 8},
  },

  ending_right = {
    number = 12,
    position = {x = 8, y = 0},
    size = {x = 6, y = 8},
    shift = {x = 1, y = 0}, --where must be center
  },
  straight_horizontal_window = {
    number = 13,
    position = {x = 14, y = 0},
    size = {x = 4, y = 8},
  },
  straight_horizontal = {
    number = 14,
    position = {x = 18, y = 0},
    size = {x = 4, y = 8},
  },
  ending_left = {
    number = 15,
    position = {x = 22, y = 0},
    size = {x = 6, y = 8},
    shift = {x = -1, y = 0},
  },
  ending_down = {
    number = 21,
    position = {x = 0, y = 8},
    size = {x = 8, y = 6},
    shift = {x = 0, y = 1},
  },
  straight_vertical_window = {
    number = 31,
    position = {x = 0, y = 14},
    size = {x = 8, y = 4},
  },
  straight_vertical = {
    number = 41,
    position = {x = 0, y = 18},
    size = {x = 8, y = 4},
  },
  ending_up = {
    number = 51,
    position = {x = 0, y = 22},
    size = {x = 8, y = 6},
    shift = {x = 0, y = -1},
  },
  corner_down_right = {
    number = 22,
    position = {x = 8, y = 8},
    size = {x = 6, y = 6},
    shift = {x = 1, y = 1},
  },
  t_down = {
    number = 23,
    position = {x = 14, y = 8},
    size = {x = 4, y = 6},
    shift = {x = 0, y = 1},
  },
  corner_down_left = {
    number = 24,
    position = {x = 18, y = 8},
    size = {x = 6, y = 6},
    shift = {x = -1, y = 1},
  },
  t_right = {
    number = 32,
    position = {x = 8, y = 14},
    size = {x = 6, y = 4},
    shift = {x = 1, y = 0},
  },
  cross = {
    number = 33,
    position = {x = 14, y = 14},
    size = {x = 4, y = 4},
  },
  t_left = {
    number = 34,
    position = {x = 18, y = 14},
    size = {x = 6, y = 4},
    shift = {x = -1, y = 0},
  },
  corner_up_right = {
    number = 42,
    position = {x = 8, y = 18},
    size = {x = 6, y = 6},
    shift = {x = 1, y = -1},
  },
  t_up = {
    number = 43,
    position = {x = 14, y = 18},
    size = {x = 4, y = 6},
    shift = {x = 0, y = -1},
  },
  corner_up_left = {
    number = 44,
    position = {x = 18, y = 18},
    size = {x = 6, y = 6},
    shift = {x = -1, y = -1},
  },

  --data.raw[pipe-to-ground][pipe-to-ground].pictures.up
  down = {
    number = 25,
    position = {x = 24, y = 8},
    size = {x = 8, y = 6},
    shift = {x = 0, y = 1},
  },
  up = {
    number = 35,
    position = {x = 24, y = 14},
    size = {x = 8, y = 6},
    shift = {x = 0, y = -1}, -- not 26
  },
  right = {
    number = 52,
    position = {x = 8, y = 24},
    size = {x = 6, y = 8},
    shift = {x = 1, y = 0},
  },
  left = {
    number = 53,
    position = {x = 14, y = 24},
    size = {x = 6, y = 8},
    shift = {x = -1, y = 0},
  }
}

local sheet_path = "__Bio_Industries__/graphics/entities/wood_products/wood_pipe/"
local sheet_name = "pipe_sheet.png"

function change_graphics (was_picture, sheet_element, quality)
  local picture = {}
  local k = 1
  if not sheet_element.shift then
    sheet_element.shift = {x = 0, y = 0}
  end
  if (quality == "hq") and (was_picture.hr_version) then
    --BioInd.writeDebug("hq")
    picture = was_picture.hr_version
    k = 2
  else
    --BioInd.writeDebug("lq")
    picture = was_picture
    k = 1
  end
  --BioInd.writeDebug("%s Quality: %s", {sheet_element.number, quality})

  if not (picture) then
    return
  end

  local size = sheet_element.size
  if type(size) == "number" then
    size = {x = size, y = size}
  elseif type(size) == "table" and not (size.x and size.y) then
    size = {x = size[1], y = size[2]}
  end

  picture.filename = sheet_path .. quality .. "_" .. sheet_name
  --~ picture.width = 8 * k * size.x
  --~ picture.height = 8 * k * size.y
  picture.size = {8 * k * size.x, 8 * k * size.y}
  picture.scale = 1/k
  picture.x = 8 * k * (sheet_element.position.x or sheet_element.position[1])
  picture.y = 8 * k * (sheet_element.position.y or sheet_element.position[2])
  picture.shift = {}
  --picture.shift.x = -8/32 * k * sheet_element.shift.x
  --picture.shift.y = -8/32 * k * sheet_element.shift.y
  picture.shift.x = -8/32  * (sheet_element.shift.x or sheet_element.shift[1])
  picture.shift.y = -8/32  * (sheet_element.shift.y or sheet_element.shift[2])
  --BioInd.writeDebug("%s Quality: %s - Success", {sheet_element.number, quality})
end


-------------------------------pipes
--local pipe_pictures = data.raw.pipe.pipe.pictures
local pipe_pictures = data.raw.pipe["bi-wood-pipe"].pictures
for i, was_picture in pairs (pipe_pictures) do
  for j, sheet_element in pairs (pipes_sheet) do
    if i == j then
      --BioInd.writeDebug("%s", {i}))
      change_graphics (was_picture, sheet_element, "hq")
      change_graphics (was_picture, sheet_element, "lq")
    end
  end
end

--------------------------------underground pipes
local pipe_to_ground_pictures = data.raw["pipe-to-ground"]["bi-wood-pipe-to-ground"].pictures

for i, was_picture in pairs (pipe_to_ground_pictures) do
  for j, sheet_element in pairs (pipes_sheet) do
    if i == j then
      --BioInd.writeDebug("%s", {i})
      change_graphics (was_picture, sheet_element, "hq")
      change_graphics (was_picture, sheet_element, "lq")
    end
  end
end
