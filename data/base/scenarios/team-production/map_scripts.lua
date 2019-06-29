function create_grid()
  global.placement_grid = {}
  for y = -1, 2 do
    for x = -2, 1 do
      local offset = {x, y}
      table.insert(global.placement_grid, offset)
    end
  end
end

function get_spawn_coordinate(n)
  local root = n^0.5
  local nearest_root = math.floor(root+0.5)
  local upper_root = math.ceil(root)
  local root_difference = math.abs(nearest_root^2 - n)
  if nearest_root == upper_root then
    x = upper_root - root_difference
    y = nearest_root
  else
    x = upper_root
    y = root_difference
  end
  --game.print(x.." - "..y)
  return {x, y}
end

simple_entities =
  {
  ["tree"] = true,
  ["fish"] = true
  }

function save_map_data(distance)

  local data = "{\n  map_set_size = "..distance.."\n  map_set_tiles = \n  {\n"
  local tiles = {}
  for X = -distance, distance-1 do
    for Y = -distance, distance-1 do
      local tile = game.surfaces[1].get_tile(X, Y)
      local name = tile.name
      if name ~= "out-of-map" then
        if not tiles[name] then tiles[name] = {} end
        local X, Y = tile.position.x, tile.position.y
        if not tiles[name][X] then tiles[name][X] = {} end
        table.insert(tiles[name][X], Y)
      end
    end
  end

  for name, array in pairs (tiles) do
    data = data.."    [\""..name.."\"] = \n    {"
    for X, another in pairs (array) do
      if #another > 0 then
        data = data.."\n    [\""..X.."\"] = {"
        for k, Y in pairs (another) do
          data = data..Y..","
        end
        data = data.."},"
      end
    end
    data = data.."    },\n"
  end

  data = data.."\n  },\n  map_set_entities = \n  {\n"
  local entities = {}
  for k, entity in pairs (game.surfaces[1].find_entities({{-distance, -distance}, {distance-1, distance-1}})) do
    local name = entity.name
    local position = entity.position
    local direction = entity.direction
    local force = entity.force
    if not entities[name] then entities[name] = {} end
    if entity.name == "express-loader" then
      local loader_type = entity.loader_type
      table.insert(entities[name], "    {position = {"..position.x..", "..position.y.."}, force = \"player\", direction = "..direction..", type = \""..loader_type.."\"}, \n")
    elseif entity.type == "resource" then
      local amount = entity.amount
      table.insert(entities[name], "    {position = {"..position.x..", "..position.y.."}, amount = "..amount.."}, \n")
    elseif simple_entities[entity.type] then
      table.insert(entities[name], "    {position = {"..position.x..", "..position.y.."}}, \n")
    else
      table.insert(entities[name], "    {position = {"..position.x..", "..position.y.."}, force = \"player\", direction = "..direction.."}, \n")
    end
  end
  for name, array in pairs (entities) do
    data = data.."\n  [\""..name.."\"] = \n  {\n"
    for k, entity in pairs (array) do
      data = data..entity
    end
    data = data.."  },"
  end

  data = data.."\n  }\n}"
  game.write_file("tile_data.lua", data)
end

function clear_map(surface, area)
  if area then
    for k, entity in pairs (surface.find_entities(area)) do
      entity.destroy()
    end
  else
    for k, entity in pairs (surface.find_entities()) do
      entity.destroy()
    end
  end
end

function create_tiles(set, offset_x, offset_y, bool, clear)

  if not set then return end

  local offset_tiles = {}
  local distance = set.map_set_size
  local tiles = set.map_set_tiles
  local gap = global.distance_between_areas
  local index = 1
  local blank_tiles = {}
  local count = 1
  if clear then
    for X = -(distance+gap), (distance+gap)-1 do
      for Y = -(distance+gap), (distance+gap)-1 do
        blank_tiles[count] = {name = "out-of-map", position = {X+offset_x, Y+offset_y}}
        count = count + 1
      end
    end
    game.surfaces[1].set_tiles(blank_tiles, false)
    return
  end
  local map_tiles = {}
  count = 1
  for name, array_x in pairs (tiles) do
    for X, array_y in pairs (array_x) do
      for k, Y in pairs (array_y) do
        map_tiles[count] = {name = name, position = {X+offset_x, Y+offset_y}}
        count = count + 1
      end
    end
  end
  game.surfaces[1].set_tiles(blank_tiles, false)
  game.surfaces[1].set_tiles(map_tiles, bool)
end

function recreate_entities(entities, offset_x, offset_y, force, duration)
  if not global.chests then global.chests = {} end
  if not global.input_chests then global.input_chests = {} end

  if not entities or not force or not offset_x or not duration or not offset_y then return end
  local tick = game.tick
  local surface = game.surfaces[1]
  for name, array in pairs (entities) do
    for k, entity in pairs (array) do
      if (k + tick) % global.ticks_to_generate_entities == 0 then
        local position = {entity.position[1]+offset_x, entity.position[2]+offset_y}
        if entity.amount then
          surface.create_entity{name = name, position = position, amount = entity.amount}
        elseif name == "express-loader" then
          local v = surface.create_entity{name = name, position = position, force = force, type = entity.type, direction = entity.direction}
          v.destructible = false
          v.minable = false
          v.rotatable = false
        elseif name == "red-chest" then
          local v = surface.create_entity({force = force, name = name, position = position})
          v.destructible = false
          v.minable = false
          v.rotatable = false
          table.insert(global.chests, v)
        elseif name == "blue-chest" then
          local v = surface.create_entity({force = force, name = name, position = position})
          v.destructible = false
          v.minable = false
          v.rotatable = false
          v.operable = false
          table.insert(global.input_chests, v)
        elseif name == "electric-energy-interface" then
          local v = surface.create_entity({force = force, name = name, position = position})
          v.destructible = false
          v.minable = false
          v.rotatable = false
          v.operable = false
        elseif name == "big-electric-pole" then
          local v = surface.create_entity({force = force, name = name, position = position})
          v.destructible = false
          v.minable = false
          v.rotatable = false
        else
          surface.create_entity({force = force, name = name, position = position})
        end
      end
    end
  end
end