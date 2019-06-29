local math2d = require("math2d")
local cutscene = require(mod_name .. ".lualib.cutscene")
local function_save = require(mod_name .. ".lualib.function_save")
local misc = require(mod_name .. ".lualib.misc")
local util = require("util")

local map_expand = {}

local tick_functions = {}

map_expand.init = function(_)
  global.map_expand_tick_functions = tick_functions

  global.expand_surface_sizes = {}
  for _, surface in pairs(game.surfaces) do

    if global.expand_surface_sizes[surface.name] == nil then
      global.expand_surface_sizes[surface.name] =
      {
        left_top = {x = -surface.map_gen_settings.width/2, y = -surface.map_gen_settings.height/2},
        right_bottom = {x = surface.map_gen_settings.width/2, y = surface.map_gen_settings.height/2}
      }
    end
  end
end

map_expand.on_load = function()
  tick_functions = global.map_expand_tick_functions or tick_functions
end

local on_tick = function(_)
  if tick_functions[game.tick] ~= nil then
    for _, function_data in pairs(tick_functions[game.tick]) do
      function_save.run(function_data[1], function_data[2])
    end

    tick_functions[game.tick] = nil
  end
end

local add_tick_function = function(tick, data)
  if tick_functions[tick] == nil then
    tick_functions[tick] = {}
  end

  table.insert(tick_functions[tick], data)
end

local function expand_compute_copy_regions(direction, surface, template, template_section)

  local copy_regions = {}

  local template_bounds = template_section
  if template_bounds == nil then
    template_bounds = global.expand_surface_sizes[template.name]
  end

  template_bounds = math2d.bounding_box.ensure_xy(template_bounds)

  local template_dims =
  {
    w = template_bounds.right_bottom.x - template_bounds.left_top.x,
    h = template_bounds.right_bottom.y - template_bounds.left_top.y
  }

  local surface_bounds = global.expand_surface_sizes[surface.name]
  local surface_dims =
  {
    w = surface_bounds.right_bottom.x - surface_bounds.left_top.x,
    h = surface_bounds.right_bottom.y - surface_bounds.left_top.y
  }

  if direction == defines.direction.north or
     direction == defines.direction.south or
     direction == defines.direction.east  or
     direction == defines.direction.west then

    local destination_area

    if direction == defines.direction.east then
      assert(surface_dims.h == template_dims.h)
      destination_area =
      {
        left_top = {x = surface_bounds.right_bottom.x, y = surface_bounds.left_top.y},
        right_bottom = {x = surface_bounds.right_bottom.x + template_dims.w, y = surface_bounds.right_bottom.y}
      }
    elseif direction == defines.direction.west then
      assert(surface_dims.h == template_dims.h)
      destination_area =
      {
        left_top = {x = surface_bounds.left_top.x - template_dims.w, y = surface_bounds.left_top.y},
        right_bottom = {x = surface_bounds.left_top.x, y = surface_bounds.right_bottom.y}
      }
    elseif direction == defines.direction.north then
      assert(surface_dims.w == template_dims.w)
      destination_area =
      {
        left_top = {x = surface_bounds.left_top.x, y = surface_bounds.left_top.y - template_dims.h},
        right_bottom = {x = surface_bounds.right_bottom.x, y = surface_bounds.left_top.y}
      }
    elseif direction == defines.direction.south then
      assert(surface_dims.w == template_dims.w)
      destination_area =
      {
        left_top = {x = surface_bounds.left_top.x, y = surface_bounds.right_bottom.y},
        right_bottom = {x = surface_bounds.right_bottom.x, y = surface_bounds.right_bottom.y + template_dims.h}
      }
    end

    local source_area =
    {
      left_top = {template_bounds.left_top.x, template_bounds.left_top.y},
      right_bottom = {template_bounds.right_bottom.x, template_bounds.right_bottom.y}
    }

    table.insert(copy_regions, {source_area, destination_area})
  else
    assert(template_dims.w >= surface_dims.w)
    assert(template_dims.h >= surface_dims.h)

    local region1
    local region2

    if direction == defines.direction.northeast then
      region1 =
      {
        {
          left_top = {x = template_bounds.left_top.x, y = template_bounds.left_top.y},
          right_bottom = {x = template_bounds.right_bottom.x, y =template_bounds.right_bottom.y - surface_dims.h}
        },
        {
          left_top = {x = surface_bounds.left_top.x, y = surface_bounds.left_top.y - (template_dims.h - surface_dims.h)},
          right_bottom = {x = surface_bounds.left_top.x + template_dims.w, y = surface_bounds.left_top.y}
        }
      }

      region2 =
      {
        {
          left_top = {x = template_bounds.left_top.x + surface_dims.w, y = template_bounds.right_bottom.y - surface_dims.h},
          right_bottom = {x = template_bounds.right_bottom.x, y = template_bounds.right_bottom.y}
        },
        {
          left_top = {x = surface_bounds.right_bottom.x, y = surface_bounds.left_top.y},
          right_bottom = {x = surface_bounds.right_bottom.x + (template_dims.w - surface_dims.w),
                          y = surface_bounds.right_bottom.y}
        }
      }
    elseif direction == defines.direction.northwest then
      region1 =
      {
        {
          left_top = {x = template_bounds.left_top.x, y = template_bounds.left_top.y},
          right_bottom = {x = template_bounds.right_bottom.x, y = template_bounds.right_bottom.y - surface_dims.h}
        },
        {
          left_top = {x = surface_bounds.left_top.x - template_dims.w + surface_dims.w,
                      y = surface_bounds.left_top.y - (template_dims.h - surface_dims.h)},
          right_bottom = {x = surface_bounds.left_top.x + surface_dims.w, y = surface_bounds.left_top.y}
        }
      }

      region2 =
      {
        {
          left_top = {x = template_bounds.left_top.x, y = template_bounds.right_bottom.y - surface_dims.h},
          right_bottom = {x = template_bounds.right_bottom.x - surface_dims.w, y = template_bounds.right_bottom.y}
        },
        {
          left_top = {x = surface_bounds.right_bottom.x - template_dims.w, y = surface_bounds.left_top.y},
          right_bottom = {x = surface_bounds.left_top.x, y = surface_bounds.right_bottom.y}
        }
      }
    elseif direction == defines.direction.southwest then
      region1 =
      {
        {
          left_top = {x = template_bounds.left_top.x, y = template_bounds.left_top.y},
          right_bottom = {x = template_bounds.right_bottom.x - surface_dims.w, y = template_bounds.left_top.y + surface_dims.h}
        },
        {
          left_top = {x = surface_bounds.right_bottom.x - template_dims.w, y = surface_bounds.left_top.y},
          right_bottom = {x = surface_bounds.left_top.x, y = surface_bounds.right_bottom.y}
        }
      }

      region2 =
      {
        {
          left_top = {x = template_bounds.left_top.x, y = template_bounds.left_top.y + surface_dims.h},
          right_bottom = {x = template_bounds.right_bottom.x, y = template_bounds.right_bottom.y}
        },
        {
          left_top = {x = surface_bounds.left_top.x - template_dims.w + surface_dims.w,
                      y = surface_bounds.left_top.y - (template_dims.h - surface_dims.h) + (template_dims.h )},
          right_bottom = {x = surface_bounds.left_top.x + surface_dims.w, y = surface_bounds.left_top.y + (template_dims.h )}
        }
      }
    elseif direction == defines.direction.southwest then
      region1 =
      {
        {
          left_top = {x = template_bounds.left_top.x, y = template_bounds.left_top.y},
          right_bottom = {x = template_bounds.right_bottom.x - surface_dims.w, y = template_bounds.left_top.y + surface_dims.h}
        },
        {
          left_top = {x = surface_bounds.right_bottom.x - template_dims.w, y = surface_bounds.left_top.y},
          right_bottom = {x = surface_bounds.left_top.x, y = surface_bounds.right_bottom.y}
        }
      }

      region2 =
      {
        {
          left_top = {x = template_bounds.left_top.x, y = template_bounds.left_top.y + surface_dims.h},
          right_bottom = {x = template_bounds.right_bottom.x, y = template_bounds.right_bottom.y}
        },
        {
          left_top = {x = surface_bounds.left_top.x - template_dims.w + surface_dims.w,
                      y = surface_bounds.left_top.y + surface_dims.h},
          right_bottom = {x = surface_bounds.left_top.x + surface_dims.w, y = surface_bounds.left_top.y + template_dims.h}
        }
      }
    elseif direction == defines.direction.southeast then
      region1 =
      {
        {
          left_top = {x = template_bounds.left_top.x + surface_dims.w, y = template_bounds.left_top.y},
          right_bottom = {x = template_bounds.right_bottom.x, y = template_bounds.left_top.y + surface_dims.h}
        },
        {
          left_top = {x = surface_bounds.right_bottom.x, y = surface_bounds.left_top.y},
          right_bottom = {x = surface_bounds.left_top.x + template_dims.w, y = surface_bounds.right_bottom.y}
        }
      }

      region2 =
      {
        {
          left_top = {x = template_bounds.left_top.x, y = template_bounds.left_top.y + surface_dims.h},
          right_bottom = {x = template_bounds.right_bottom.x, y = template_bounds.right_bottom.y}
        },
        {
          left_top = {x = surface_bounds.left_top.x, y = surface_bounds.left_top.y + surface_dims.h},
          right_bottom = {x = surface_bounds.left_top.x + template_dims.w, y = surface_bounds.left_top.y + template_dims.h}
        }
      }
    end

    table.insert(copy_regions, region1)
    table.insert(copy_regions, region2)
  end

  return copy_regions
end

local function expand_map_bounds(params)
  for _, region in pairs(params.copy_regions) do
    local bounds = global.expand_surface_sizes[params.surface.name]
    bounds.left_top.x = math.min(bounds.left_top.x, region[2].left_top.x)
    bounds.left_top.y = math.min(bounds.left_top.y, region[2].left_top.y)
    bounds.right_bottom.x = math.max(bounds.right_bottom.x, region[2].right_bottom.x)
    bounds.right_bottom.y = math.max(bounds.right_bottom.y, region[2].right_bottom.y)
  end
end

local function expand_do_map_copy(params)
  for _, region in pairs(params.copy_regions) do
    params.template.clone_area
    {
      source_area = region[1],
      destination_area = region[2],
      destination_surface = params.surface,
      expand_map = true,
    }
  end
end
function_save.add_function("expand_do_map_copy", expand_do_map_copy)

local chart_function = function(params)
  params.force.chart(params.surface, params.bounding_box)
end
function_save.add_function("chart_function", chart_function)


local function expand_do_chart_chunks(surface, force, x_ranges, y_ranges, total_chunks, delay,
                                      ticks_to_do_chart)
  local chart_start_tick = game.tick + delay

  local ticks_per_chunk = math.floor(ticks_to_do_chart / total_chunks)
  local current_chunk = 0

  local rndval = 1

  -- wtf is this? fizzlefade! http://fabiensanglard.net/fizzlefade/index.php
  repeat
    local index_val = rndval - 1

    local lsb = bit32.band(rndval, 1)
    rndval = bit32.rshift(rndval, 1)

    if lsb ~= 0 then
      rndval = bit32.bxor(rndval, 0x00012000)
    end

    if index_val < total_chunks then
      for i=1,#x_ranges,1 do
        local width = x_ranges[i][2]-x_ranges[i][1] + 1
        local height = y_ranges[i][2]-y_ranges[i][1] + 1

        if index_val < width*(height) then
          local x = index_val % width
          local y = math.floor(index_val / width)

          x = x + x_ranges[i][1]
          y = y + y_ranges[i][1]

          -- TODO: add param that allows disabling the initial "radar" coverage after chart
          add_tick_function(chart_start_tick + ticks_per_chunk * current_chunk,
                            {
                              "chart_function",
                              {
                                force = force,
                                surface = surface,
                                bounding_box = {left_top={x*misc.chunk_size, y*misc.chunk_size},
                                                right_bottom={x*misc.chunk_size + 1, y*misc.chunk_size + 1}}
                              }
                            })

          current_chunk = current_chunk + 1
          break
        end

        index_val = index_val - width*height
      end
    end

  until rndval == 1
end

map_expand.expand = function(args)

  local waypoints_after = args.waypoints_after or {}
  local ticks_per_chunk = args.ticks_per_chunk or 1
  local transition_to_expand_time = args.transition_to_expand_time or 100
  local pause_after_charted = args.pause_after_charted or 60 * 3
  local chart_mode_cutoff = args.chart_mode_cutoff or 0.3
  local final_transition_time = args.final_transition_time or 100
  local skip_cutscene = args.skip_cutscene

  if #game.players == 0 then
    return
  end

  for _, player in pairs(game.players) do
    assert(game.players[1].surface == player.surface)
    assert(game.players[1].force == player.force)
  end

  local force = game.players[1].force
  local surface = game.players[1].surface

  local destination_areas = {}
  for _, section in pairs(args.sections) do
    local copy_regions = expand_compute_copy_regions(section.direction, surface, section.template, section.template_section)
    local expand_params =
    {
      copy_regions = copy_regions,
      surface = surface,
      template = section.template
    }

    -- We need to do this now so that the perceived size of the map is adjusted for the next loop iteration.
    -- Otherwise, we could just make it part of expand_do_map_copy
    expand_map_bounds(expand_params)

    if skip_cutscene then
      -- do it now
      expand_do_map_copy(expand_params)
    else
      -- delay actual expansion so we don't see it jump in while we're still zooming out
      add_tick_function(game.tick + transition_to_expand_time,
                        {
                         "expand_do_map_copy",
                         util.table.deepcopy(expand_params) -- need to copy here due to some wacky lua scoping rules
                       })
    end

    for _, region in pairs(copy_regions) do
      table.insert(destination_areas, region[2])
    end
  end

  local x_ranges = {}
  local y_ranges = {}
  local total_chunks = 0
  for i, destination_area in pairs(destination_areas) do
    x_ranges[i] = {math.floor(destination_area.left_top.x/misc.chunk_size),
                   math.floor((destination_area.right_bottom.x-1)/misc.chunk_size)}
    y_ranges[i] = {math.floor(destination_area.left_top.y/misc.chunk_size),
                   math.floor((destination_area.right_bottom.y-1)/misc.chunk_size)}

    total_chunks = total_chunks +
      math.abs(x_ranges[i][2]-x_ranges[i][1] + 1) * math.abs(y_ranges[i][2]-y_ranges[i][1] + 1)
  end

  local ticks_to_do_chart = ticks_per_chunk * total_chunks
  expand_do_chart_chunks(surface, force, x_ranges, y_ranges, total_chunks, transition_to_expand_time,
                         ticks_to_do_chart)

  local destination_area = destination_areas[1]
  for _, area in pairs(destination_areas) do
    destination_area.left_top.x = math.min(area.left_top.x, destination_area.left_top.x)
    destination_area.left_top.y = math.min(area.left_top.y, destination_area.left_top.y)
    destination_area.right_bottom.x = math.max(area.right_bottom.x, destination_area.right_bottom.x)
    destination_area.right_bottom.y = math.max(area.right_bottom.y, destination_area.right_bottom.y)
  end

  for _, player in pairs(game.players) do
    local display_new_area_params = misc.get_cutscene_show_area_parameters(destination_area,
      player.display_resolution, 16, player.position)

    local waypoints =
    {
      {
        position = display_new_area_params.position,
        transition_time = transition_to_expand_time,
        time_to_wait = ticks_to_do_chart + pause_after_charted,
        zoom = display_new_area_params.zoom
      }
    }

    for _, waypoint in pairs(waypoints_after) do
      table.insert(waypoints, waypoint)
    end

    local scene =
    {
      type=defines.controllers.cutscene,
      waypoints = waypoints,
      final_transition_time = final_transition_time,
      chart_mode_cutoff = chart_mode_cutoff
    }
    if not skip_cutscene then
      cutscene.play(scene, {player})
    end
  end
end

map_expand.events = {
  [defines.events.on_tick] = on_tick,
}

map_expand.set_surface_bounds = function(surface, bounds)
  global.expand_surface_sizes[surface.name] = math2d.bounding_box.ensure_xy(bounds)
end

map_expand.clear_old_data = function()
  if global.expand_trigger_areas then
    global.expand_trigger_areas = nil
  end
  for key, _ in pairs(tick_functions) do
    tick_functions[key] = nil
  end
end

return map_expand
