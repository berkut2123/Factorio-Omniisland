local util = require('util')

local tree_view = {}

local generate_empty_grid = function(data)
  local width = 0
  local height = 0

  local recurse
  recurse = function(level, indent)
    indent = indent or 1
    width = math.max(width, indent)

    for _, row in pairs(level) do
      height = height + 1
      if row.children then
        recurse(row.children, indent + 1)
      end
    end
  end

  recurse(data)

  local grid = {}

  for _=1,height,1 do
    local row = {}
    for _=1,width,1 do
      table.insert(row, " ")
    end
    table.insert(grid, row)
  end

  return grid
end

tree_view.flatten_rows = function(data)
  local flat_rows = {}

  local recurse
  recurse = function(level)
    for _, row in pairs(level) do
      table.insert(flat_rows, row)

      if row.children then
        recurse(row.children, row)
      end
    end
  end

  recurse(data)

  return flat_rows
end

local generate_layout_grid = function(data)
  local grid = generate_empty_grid(data)

  -- Place 'X' at each box, and '└' before each box, so we get something like this:
  -- {"X", " ", " ", " "}
  -- {"└", "X", " ", " "}
  -- {" ", "└", "X", " "}
  -- {" ", " ", "└", "X"}
  -- {"└", "X", " ", " "}
  -- {"X", " ", " ", " "}

  local row_num = 1
  local recurse
  recurse = function(level, indent)
    indent = indent or 1

    for _, item in pairs(level) do
      grid[row_num][indent] = 'X'

      if indent > 1 then
        grid[row_num][indent - 1] = '└'
      end

      row_num = row_num + 1
      if item.children then
        recurse(item.children, indent+1)
      end
    end
  end
  recurse(data)

  -- Next step is to account for the four types of box:
  -- 1: A root node with children, which has a line attached on the bottom only.
  -- 2: A root node with no children, which has no lines attached.
  -- 2: An intermediate node, with lines attached on the left and bottom.
  -- 3: An end(leaf) node, with a line attached on the left only.
  -- We will use R for root nodes with children, r for root nodes with no children, I for intermediates, and E for end nodes.
  -- We should end up with something like this:
  -- {"R", " ", " ", " "}
  -- {"└", "I", " ", " "}
  -- {" ", "└", "I", " "}
  -- {" ", " ", "└", "E"}
  -- {"└", "E", " ", " "}
  -- {"r", " ", " ", " "}

  for y=#grid,1,-1 do
    for x=1,#grid[y],1 do
      if grid[y][x] == 'X' then
        if x == 1 then
          if y < #grid and grid[y+1][x] == '└' then
            grid[y][x] = 'R'
          else
            grid[y][x] = 'r'
          end
        elseif y < #grid and grid[y+1][x] == '└' then
          grid[y][x] = 'I'
        else
          grid[y][x] = 'E'
        end
      end
    end
  end

  -- The next step is a pass that fixes up the spaces on the left of the boxes, to turn it into something like this:
  -- {"R", " ", " ", " "}
  -- {"├", "I", " ", " "}
  -- {"|", "└", "I", " "}
  -- {"|", " ", "└", "E"}
  -- {"├", "E", " ", " "}
  -- {"r", " ", " ", " "}

  for y=#grid,1,-1 do
    for x=1,#(grid[y]) do
      if grid[y][x] == ' ' and y + 1 < #grid and (grid[y+1][x] == '└' or
        grid[y+1][x] == "|" or grid[y+1][x] == "├") then
        grid[y][x] = '|'
      elseif grid[y][x] == '└' and y + 1 <= #grid and (grid[y+1][x] == '└' or
        grid[y+1][x] == "|" or grid[y+1][x] == "├") then
          grid[y][x] = '├'
      end
    end
  end

  return grid
end

tree_view.add_tree_view_to_frame = function(frame, data, main_table_name)
  local grid = generate_layout_grid(data)
  local flat_rows = tree_view.flatten_rows(data)

  local table = frame.add{ type = "table" , name = main_table_name, column_count = 1}
  table.style.vertical_spacing = 0

  local rows = {}

  for y=1,#grid,1 do
    local row = grid[y]

    local row_flow = table.add{ type = "flow", direction = "horizontal"}
    row_flow.style.horizontal_spacing = 0

    rows[y] =
    {
      row_flow = row_flow,
      original_data_row = flat_rows[y]
    }

    local seen_box = false

    local tileset_size = 24 -- This must match the prototypes for the sprites we use below, tree_view_tileset-square_d etc

    local add_stretchy_vertical_line = function(stretch_container)
      local stretch_img = stretch_container.add{ type = "sprite", sprite="tree_view_tileset-vertical_line"}
      stretch_img.style.vertically_stretchable = true
      stretch_img.style.stretch_image_to_widget_size = true
      stretch_img.style.width = tileset_size
      return stretch_img
    end

    local add_stretchy_empty = function(stretch_container)
      local stretch_img = stretch_container.add{ type = "sprite", sprite="tree_view_tileset-empty"}
      stretch_img.style.vertically_stretchable = true
      stretch_img.style.stretch_image_to_widget_size = true
      stretch_img.style.width = tileset_size
      return stretch_img
    end

    local add_stretch_container = function(parent)
      local stretch_container = parent.add{type = "flow", direction = "vertical"}
      stretch_container.style.vertical_spacing = 0
      return stretch_container
    end

    local add_non_stretchy_section = function(parent, sprite_name)
      local image = parent.add{ type = "sprite", sprite=sprite_name}
      image.style.width = tileset_size
      image.style.height = tileset_size
      image.style.stretch_image_to_widget_size = true
      return image
    end

    for _, item in pairs(row) do
      if item == 'R' then
        seen_box = true
        local stretch_container = add_stretch_container(row_flow)
        add_non_stretchy_section(stretch_container, "tree_view_tileset-square_d")
        add_stretchy_vertical_line(stretch_container)
      elseif item == 'r' then
        seen_box = true
        local stretch_container = add_stretch_container(row_flow)
        add_non_stretchy_section(stretch_container, "tree_view_tileset-square_no_lines")
        add_stretchy_empty(stretch_container)
      elseif item == "I" then
        seen_box = true
        local stretch_container = add_stretch_container(row_flow)
        add_non_stretchy_section(stretch_container, "tree_view_tileset-square_l_d")
        add_stretchy_vertical_line(stretch_container)
      elseif item == "E" then
        seen_box = true
        local stretch_container = add_stretch_container(row_flow)
        add_non_stretchy_section(stretch_container, "tree_view_tileset-square_l")
        add_stretchy_empty(stretch_container)
      elseif item == ' ' and not seen_box then
        local stretch_container = add_stretch_container(row_flow)
        add_non_stretchy_section(stretch_container, "tree_view_tileset-empty")
        add_stretchy_empty(stretch_container)
      elseif item == '|' then
        local stretch_container = add_stretch_container(row_flow)
        add_non_stretchy_section(stretch_container, "tree_view_tileset-vertical_line")
        add_stretchy_vertical_line(stretch_container)
      elseif item == '├' then
        local stretch_container = add_stretch_container(row_flow)
        add_non_stretchy_section(stretch_container, "tree_view_tileset-u_d_r_line")
        add_stretchy_vertical_line(stretch_container)
      elseif item == '└' then
        local stretch_container = add_stretch_container(row_flow)
        add_non_stretchy_section(stretch_container, "tree_view_tileset-u_r_line")
        add_stretchy_empty(stretch_container)
      end
    end
  end

  return
  {
    table = table,
    rows = rows
  }
end


tree_view.test = function()
  local test = function(data, expected, i)

    print("--------------------- Test #" .. i)
    local grid = generate_layout_grid(data)

    for _, row in pairs(grid) do
      print(serpent.line(row))
    end
    print("--------------------- End Test # " .. i)

    assert(util.table.compare(grid, expected))

    local root = game.players[1].gui.center
    local flow = root.add{type = "flow"}
    flow.style.vertically_stretchable = false
    local frame = flow.add{type = "frame", caption = "Test #" .. i}

    local tree_view_data = tree_view.add_tree_view_to_frame(frame, data)

    for _, row in pairs(tree_view_data.rows) do
      local name_label = row.row_flow.add{type = "label", caption = row.original_data_row.name}
      name_label.style.single_line = false
    end
  end


  local data_1 =
  {
    {
      name = "A",
      children =
      {
        {
          name = "B",
          children =
          {
            {
              name = "C",
              children =
              {
                {
                  name = "D",
                  children =
                  {
                    {
                      name = "E"
                    }
                  }
                },
                {
                  name = "F"
                }
              }
            },
            {
              name = "G"
            }
          }
        },
        {
          name = "H"
        }
      }
    },
    {
      name = "I"
    }
  }

  local expected_1 =
  {
    {'R', ' ', ' ', ' ', ' '},
    {'├', 'I', ' ', ' ', ' '},
    {'|', '├', 'I', ' ', ' '},
    {'|', '|', '├', 'I', ' '},
    {'|', '|', '|', '└', 'E'},
    {'|', '|', '└', 'E', ' '},
    {'|', '└', 'E', ' ', ' '},
    {'└', 'E', ' ', ' ', ' '},
    {'r', ' ', ' ', ' ', ' '},
  }


  local data_2 =
  {
    {
      name = "A",
      children =
      {
        {
          name = "B",
          children =
          {
            {
              name = "C\n1\n2\n3\n4\n5\n6\n7",
              children =
              {
                {
                  name = "D\n1\n2\n3\n4\n5\n6\n7"
                }
              }
            }
          }
        },
        {
          name = "E"
        }
      }
    },
    {
      name = "F",
      children =
      {
        {
          name = "G"
        }
      }
    }
  }

  local expected_2 =
  {
    {'R', ' ', ' ', ' '},
    {'├', 'I', ' ', ' '},
    {'|', '└', 'I', ' '},
    {'|', ' ', '└', 'E'},
    {'└', 'E', ' ', ' '},
    {'R', ' ', ' ', ' '},
    {'└', 'E', ' ', ' '},
  }

  local data_3 =
  {
    {
      name = "A",
      children =
      {
        {
          name = "B",
          children =
          {
            {
              name = "C"
            }
          }
        }
      }
    }
  }

  local expected_3 =
  {
    {'R', ' ', ' '},
    {'└', 'I', ' '},
    {' ', '└', 'E'},
  }

  local data_4 =
  {
    {
      name = "A",
      children =
      {
        {
          name = "B"
        },
        {
          name = "C"
        }
      }
    }
  }

  local expected_4 =
  {
    {'R', ' '},
    {'├', 'E'},
    {'└', 'E'},
  }

  local data_5 =
  {
    {
      name = "A",
      children =
      {
        {
          name = "B"
        },
        {
          name = "C"
        },
        {
          name = "D"
        }
      }
    }
  }

  local expected_5 =
  {
    {'R', ' '},
    {'├', 'E'},
    {'├', 'E'},
    {'└', 'E'},
  }

  local data_6 =
  {
    {
      name = "A",
      children =
      {
        {
          name = "B",
          children =
          {
            {
              name = "C"
            },
            {
              name = "D"
            }
          }
        }
      }
    }
  }

   local expected_6 =
  {
    {'R', ' ', ' '},
    {'└', 'I', ' '},
    {' ', '├', 'E'},
    {' ', '└', 'E'},
  }

  test(data_1, expected_1, 1)
  test(data_2, expected_2, 2)
  test(data_3, expected_3, 3)
  test(data_4, expected_4, 4)
  test(data_5, expected_5, 5)
  test(data_6, expected_6, 6)
end

return tree_view