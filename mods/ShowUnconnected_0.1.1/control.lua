local types = {'underground-belt', 'pipe-to-ground', 'electric-pole'}

local black_list = {'factory-power-pole'}

function is_value_in_list (value, list)
  for i, v in pairs (list) do
    if value == v then
      return true
    end
  end
  return false
end

function try_delete_no_connection (entity)
  -- if not entity or not entity.valid then return end
  -- game.print (entity.name)
  local surface = entity.surface
  local e = surface.find_entity('no-connection', entity.position)
  if e then
    e.destroy()
  end
end

function try_place_nc (entity)
  local surface = entity.surface
  local e = surface.find_entity('no-connection', entity.position)
  if not e then
    surface.create_entity {name='no-connection', position=entity.position}
  end
end

function is_underground_pipe_connection (pipe1, pipe2)
  if pipe1.type == 'pipe-to-ground' and pipe2.type == 'pipe-to-ground' then
    local dir = pipe1.direction
    -- game.print ('dir '..dir..' y1: '.. pipe1.position.y ..' y2: '..pipe2.position.y)
    if      dir == defines.direction.north and pipe1.position.y < pipe2.position.y then
      return true
    elseif  dir == defines.direction.east and pipe1.position.x > pipe2.position.x then
      return true
    elseif  dir == defines.direction.south and pipe1.position.y > pipe2.position.y then
      return true
    elseif  dir == defines.direction.west and pipe1.position.x < pipe2.position.x then
      return true
    end
  end
end

function u_pipe_neighbour (entity)
  if entity.type == 'pipe-to-ground' then
    for i, deep_neighbours in pairs (entity.neighbours) do
      for j, neighbour in pairs (deep_neighbours) do
        if is_underground_pipe_connection (entity, neighbour) then
          return neighbour
        end
      end
    end
  end
end

function check_one (entity)
  if is_value_in_list (entity.name, black_list) then
    return
  end
  local must_be_placed = true
  local surface = entity.surface
  
  if entity.type == 'pipe-to-ground' then
    local neighbour = u_pipe_neighbour (entity)
    if neighbour then
      must_be_placed = false
      try_delete_no_connection (neighbour)
    end

  elseif entity.type == 'underground-belt' then
    if entity.neighbours then
      must_be_placed = false
      -- try_delete_no_connection (entity)
      try_delete_no_connection (entity.neighbours)
    end
    
  elseif entity.type == 'electric-pole' then
    for i, deep_neighbours in pairs (entity.neighbours) do
      for j, neighbour in pairs (deep_neighbours) do
        must_be_placed = false
        try_delete_no_connection (neighbour)
      end
    end
  end
  
  if must_be_placed then
    try_place_nc (entity)
  else
    try_delete_no_connection (entity)
  end
end

function check_all ()
  for surface_name, surface in pairs (game.surfaces) do
    local entities = surface.find_entities_filtered{type=types}
    for i, entity in pairs (entities) do
      check_one (entity)
    end
  end
end

function check_area_about (entity)
  if entity.type == 'pipe-to-ground' or entity.type == 'underground-belt' or entity.type == 'electric-pole' then
    local surface = entity.surface
    local pos = entity.position
    local max_dist = entity.prototype.max_underground_distance or entity.prototype.max_wire_distance or 32
    local area = {left_top = {x=pos.x-32, y=pos.y-32}, right_bottom = {x=pos.x+32, y=pos.y+32}}
    local entities = surface.find_entities_filtered{type=types}
    for i, e in pairs (entities) do
      check_one (e)
    end
  end
end

function add_pole_to_global (entity)
  table.insert(global.poles, {status = false, entity = entity, energy = 0})
end

function on_built_entity (event)
  local entity = event.created_entity
  if is_value_in_list (entity.name, black_list) then
    return
  end
  -- check_one (entity) -- here can be just one check, but for pipes must be updated also all disconnected pipes
  check_area_about (entity)
  if entity.type == 'electric-pole' then
    add_pole_to_global (entity)
    -- game.print ('added: '.. #global.poles)
  end
end

function on_robot_built_entity (event)
  local entity = event.created_entity
  if is_value_in_list (entity.name, black_list) then
    return
  end
  
  -- check_one (entity) -- here can be just one check, but for pipes must be updated also all disconnected pipes
  check_area_about (entity)
  if entity.type == 'electric-pole' then
    add_pole_to_global (entity)
    -- game.print ('added: '.. #global.poles)
  end
end

function on_player_rotated_entity (event)
  local entity = event.entity
  check_area_about (entity)
end

function amount_pole_connections (entity)
  if not (entity.type == 'electric-pole') then
    game.print ('not electric-pole: ['..entity.type..']['..entity.name..']')
    return
  end
  local amount = 0
  if entity.neighbours then -- https://mods.factorio.com/mod/ShowUnconnected/discussion/5c9ec239ef0d7a000d15cd8e
    for i, deep_neighbours in pairs (entity.neighbours) do
      for j, neighbour in pairs (deep_neighbours) do
        amount = amount + 1
      end
    end
  else
    game.print ('no neighbours by ['..entity.type..']['..entity.name..']')
  end
  return amount
end

function place_to_neighbours (entity)
  if not entity.valid then
    game.print ('[Show Unconnected]: invalid entity')
    -- check_area_about (entity)
    return
  end

  if entity.type == 'pipe-to-ground' then
    local neighbour = u_pipe_neighbour (entity)
    if neighbour then
      try_place_nc (neighbour)
    end
    
  elseif entity.type == 'underground-belt' then
    -- game.print ('place_to_neighbours: underground-belt')
    if entity.neighbours then
      -- game.print ('has neighbours: name: '..entity.neighbours.name .. ' position: '.. serpent.line(entity.neighbours.position))
      try_place_nc (entity.neighbours)
    end
    
  elseif entity.type == 'electric-pole' then
    for i, deep_neighbours in pairs (entity.neighbours) do
      for j, neighbour in pairs (deep_neighbours) do
        local amount = amount_pole_connections (neighbour)
        if amount == 1 then
          -- game.print ('amount '..amount)
          try_place_nc (neighbour)
        end
      end
    end
  end
end

function on_player_mined_entity (event)
  local entity = event.entity
  
  place_to_neighbours (entity)
  try_delete_no_connection (entity)
  try_remove_no_energy (entity)
end

function on_robot_mined_entity (event)
  local entity = event.entity
  
  place_to_neighbours (entity)
  try_delete_no_connection (entity)
  try_remove_no_energy (entity)
end

function on_entity_died (event) -- not works
  local entity = event.entity
  
  place_to_neighbours (entity)
  try_delete_no_connection (entity)
  try_remove_no_energy (entity)
end

function check_all_poles ()
  for surface_name, surface in pairs (game.surfaces) do
    local entities = surface.find_entities_filtered{type='electric-pole'}
    for i, entity in pairs (entities) do
      -- check_one (entity)
      add_pole_to_global (entity)
    end
  end
end

function try_init ()
  global.poles = global.poles or {}
  global.next_pole_id = global.next_pole_id or 1
  check_all()
  
  check_all_poles()
end

function get_total_output_energy (output_counts)
  if output_counts then
    local energy = 0
    for input, value in pairs (output_counts) do
      energy = energy + value
    end
    return energy
  end
  return false
end

function try_remove_no_energy (entity)
  if not entity or not entity.valid then return end
  local surface = entity.surface
  local n_energy = surface.find_entity('no-energy', entity.position)
  if n_energy then
    n_energy.destroy()
  end
end

function try_add_no_energy (entity)
  local surface = entity.surface
  local n_energy = surface.find_entity('no-energy', entity.position)
  if not n_energy then
    surface.create_entity {name='no-energy', position=entity.position}
  end
end

function check_pole (pole)
  local entity = pole.entity

  local electric_network_statistics = entity.electric_network_statistics
  local output_counts = electric_network_statistics.output_counts
  local energy = get_total_output_energy (output_counts)
  if energy and not (energy == pole.energy) then
    pole.energy = energy
    try_remove_no_energy (entity)
  else
    try_add_no_energy (entity)
  end
end

function on_tick ()
  local pole_id = global.next_pole_id
  if #global.poles == 0 then return end
  if #global.poles < pole_id then 
    global.next_pole_id = 1
    return 
  end
  local pole = global.poles[pole_id]
  local entity = pole.entity
  if not entity or not entity.valid then
    -- game.print ('removed')
    table.remove (global.poles, pole_id)
    return
  end
  
  check_pole (pole)
  
  -- right ending
  global.next_pole_id = pole_id + 1
end

script.on_init(try_init)
script.on_configuration_changed(try_init)

script.on_event(defines.events.on_built_entity, on_built_entity)
script.on_event(defines.events.on_robot_built_entity, on_robot_built_entity)

script.on_event(defines.events.on_player_rotated_entity, on_player_rotated_entity)

script.on_event(defines.events.on_player_mined_entity, on_player_mined_entity)
script.on_event(defines.events.on_robot_mined_entity, on_robot_mined_entity)

script.on_event(defines.events.on_entity_died, on_entity_died)






script.on_event(defines.events.on_tick, on_tick)
-- script.on_event(defines.events.on_player_driving_changed_state, on_player_driving_changed_state)

-- script.on_load(on_load)

-- script.on_event(defines.events.on_gui_click, on_Gui_Click)

-- script.on_event(defines.events.on_pre_player_mined_item, on_pre_player_mined_item)


-- script.on_event(defines.events.on_player_created, on_player_created)