local Util = {}

Util.min = math.min
Util.max = math.max
Util.floor = math.floor
Util.abs = math.abs
Util.sqrt = math.sqrt
Util.sin = math.sin
Util.cos = math.cos
Util.atan = math.atan
Util.pi = math.pi
Util.remove = table.remove
Util.insert = table.insert
Util.str_gsub = string.gsub

function Util.string_split (str, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function Util.string_join (str_table, sep)
  local str = ""
  for _, str_part in pairs(str_table) do
    if str ~= "" then
      str = str .. sep
    end
      str = str .. str_part
  end
  return str
end


function Util.dot_string_less_than(a, b, allow_equal)
  if allow_equal and a == b then return true end
  local a_parts = Util.string_split(a, ".")
  local b_parts = Util.string_split(b, ".")
  for i = 1, #a_parts do
    if tonumber(a_parts[i]) < tonumber(b_parts[i]) then
      return true
    elseif a_parts[i] ~= b_parts[i] then
      return false
    end
  end
  return false
end

function Util.dot_string_greater_than(a, b, allow_equal)
  if allow_equal and a == b then return true end
  local a_parts = Util.string_split(a, ".")
  local b_parts = Util.string_split(b, ".")
  for i = 1, #a_parts do
    if tonumber(a_parts[i]) > tonumber(b_parts[i]) then
      return true
    elseif a_parts[i] ~= b_parts[i] then
      return false
    end
  end
  return false
end


function Util.string_trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function Util.send_message(text)
    for _, player in pairs(game.players) do
        player.print(text)
    end
end

function Util.firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function Util.table_contains(table, check)
  for k,v in pairs(table) do if v == check then return true end end
  return false
end

function Util.remove_from_table(list, item)
    local index = 0
    for _,_item in ipairs(list) do
        if item == _item then
            index = _
            break
        end
    end
    if index > 0 then
        Util.remove(list, index)
    end
end

function Util.transfer_burner (entity_a, entity_b)
    if entity_a.burner and entity_a.burner.currently_burning and entity_b.burner then
        entity_b.burner.currently_burning = entity_a.burner.currently_burning.name
        entity_b.burner.remaining_burning_fuel = entity_a.burner.remaining_burning_fuel
    end
end

function Util.transfer_inventory_loose (entity_a, entity_b, inventory_type)
    local inv_a = entity_a.get_inventory(inventory_type)
    if inv_a then
        local contents = inv_a.get_contents()
        for item_type, item_count in pairs(contents) do
            entity_b.insert({name=item_type, count=item_count})
        end
    end
end

function Util.transfer_inventory (entity_a, entity_b, inventory_type, inventory_type_b)
    local inv_a = entity_a.get_inventory(inventory_type)
    local inv_b = entity_b.get_inventory(inventory_type_b or inventory_type)
    if inv_a and inv_b then
        local contents = inv_a.get_contents()
        for item_type, item_count in pairs(contents) do
            inv_b.insert({name=item_type, count=item_count})
        end
    end
end

function Util.transfer_inventory_filters (entity_a, entity_b, inventory_type)
    local inv_a = entity_a.get_inventory(inventory_type)
    local inv_b = entity_b.get_inventory(inventory_type)
    if inv_a.supports_filters() and inv_b.supports_filters() then
        for i = 1, Util.min(#inv_a, #inv_b) do
            local filter = inv_a.get_filter(i)
            if filter then
                inv_b.set_filter(i, filter)
            end
        end
    end
end

--[[
function Util.transfer_equipment_grid (entity_a, entity_b)
    if not (entity_a.grid and entity_b.grid) then return end
    local grid_a = entity_a.grid
    local grid_b = entity_b.grid
    local equipment = grid_a.equipment
    for _, item in pairs(equipment) do
        local new_item = grid_b.put({
                name=item.name,
                position=item.position})
        if new_item then
            if item.shield and item.shield > 0 then
                new_item.shield = item.shield
            end
            if item.energy and item.energy > 0 then
                new_item.energy = item.energy
            end
        else
            Util.send_message("Error transfering "..item.name)
        end
    end
end
]]
function Util.transfer_equipment_grid (entity_a, entity_b) -- update by lwsid
    if not (entity_a.grid and entity_b.grid) then return end
    local grid_a = entity_a.grid
    local grid_b = entity_b.grid
    local equipment = grid_a.equipment
    for _, item in pairs(equipment) do
        local new_item = grid_b.put({
                name=item.name,
                position=item.position})
        if new_item then
            if item.type == "energy-shield-equipment" then
                new_item.shield = item.shield
            end
            if item.energy then
                new_item.energy = item.energy
            end
            if item.burner and item.burner.inventory then
              for i = 1, #item.burner.inventory do
                new_item.burner.inventory.insert(item.burner.inventory[i])
              end
              new_item.burner.currently_burning = item.burner.currently_burning
              new_item.burner.heat = item.burner.heat
              new_item.burner.remaining_burning_fuel = item.burner.remaining_burning_fuel
            end
        else
            Util.send_message("Error transfering "..item.name)
        end
    end
end

function Util.position_to_area(position, radius)
  return {{x = position.x - radius, y = position.y - radius},
          {x = position.x + radius, y = position.y + radius}}
end

function Util.position_to_tile(position)
    return {x = math.floor(position.x), y = math.floor(position.y)}
end
function Util.tile_to_position(tile_position)
    return {x = tile_position.x+0.5, y = tile_position.y+0.5}
end

function Util.position_to_xy_string(position)
    return Util.xy_to_string(position.x, position.y)
end

function Util.xy_to_string(x, y)
    return Util.floor(x) .. "_" .. Util.floor(y)
end

function Util.lerp_angles(a, b, alpha)
    local da = b - a

    if da < -0.5 then
        da = da + 1
    elseif da > 0.5 then
        da = da - 1
    end
    local na = a + da * alpha
    if na < 0 then
        na = na + 1
    elseif na > 1 then
        na = na - 1
    end
    return na
end

function Util.array_to_vector(array)
    return {x = array[1], y = array[2]}
end

function Util.vectors_delta(a, b)
    if not a and b then return 0 end
    return {x = b.x - a.x, y = b.y - a.y}
end

function Util.vectors_delta_length(a, b)
    return Util.vector_length_xy(b.x - a.x, b.y - a.y)
end

function Util.vector_length(a)
    return Util.sqrt(a.x * a.x + a.y * a.y)
end

function Util.vector_length_xy(x, y)
    return Util.sqrt(x * x + y * y)
end

function Util.vector_dot(a, b)
    return a.x * b.x + a.y * b.y
end

function Util.vector_dot_projection(a, b)
    local n = Util.vector_normalise(a)
    local d = Util.vector_dot(n, b)
    return {x = n.x * d, y = n.y * d}
end

function Util.vector_normalise(a)
    local length = Util.vector_length(a)
    return {x = a.x/length, y = a.y/length}
end

function Util.vector_set_length(a, length)
    local old_length = Util.vector_length(a)
    if old_length == 0 then return {x = 0, y = -length} end
    return {x = a.x/old_length*length, y = a.y/old_length*length}
end

function Util.orientation_from_to(a, b)
    return Util.vector_to_orientation_xy(b.x - a.x, b.y - a.y)
end

function Util.orientation_to_vector(orientation, length)
    return {x = length * Util.sin(orientation * 2 * Util.pi), y = -length * Util.cos(orientation * 2 * Util.pi)}
end

function Util.rotate_vector(orientation, a)
    return {
      x = -a.y * Util.sin(orientation * 2 * Util.pi) + a.x * Util.sin((orientation + 0.25) * 2 * Util.pi),
      y = a.y * Util.cos(orientation * 2 * Util.pi) -a.x * Util.cos((orientation + 0.25) * 2 * Util.pi)}
end

function Util.vectors_add(a, b)
    return {x = a.x + b.x, y = a.y + b.y}
end

function Util.lerp_vectors(a, b, alpha)
    return {x = a.x + (b.x - a.x) * alpha, y = a.y + (b.y - a.y) * alpha}
end

function Util.move_to(a, b, max_distance, eliptical)
    -- move from a to b with max_distance.
    -- if eliptical, reduce y change (i.e. turret muzzle flash offset)
    local eliptical_scale = 0.9
    local delta = Util.vectors_delta(a, b)
    if eliptical then
        delta.y = delta.y / eliptical_scale
    end
    local length = Util.vector_length(delta)
    if (length > max_distance) then
        local partial = max_distance / length
        delta = {x = delta.x * partial, y = delta.y * partial}
    end
    if eliptical then
        delta.y = delta.y * eliptical_scale
    end
    return {x = a.x + delta.x, y = a.y + delta.y}
end

function Util.vector_to_orientation(v)
    return Util.vector_to_orientation_xy(v.x, v.y)
end

function Util.vector_to_orientation_xy(x, y)
    if x == 0 then
        if y > 0 then
            return 0.5
        else
            return 0
        end
    elseif y == 0 then
        if x < 0 then
            return 0.75
        else
            return 0.25
        end
    else
        if y < 0 then
            if x > 0 then
                return Util.atan(x / -y) / Util.pi / 2
            else
                return 1 + Util.atan(x / -y) / Util.pi / 2
            end
        else
            return 0.5 + Util.atan(x / -y) / Util.pi / 2
        end
    end
end

function Util.direction_to_orientation(direction)
    if direction == defines.direction.north then
        return 0
    elseif direction == defines.direction.northeast then
        return 0.125
    elseif direction == defines.direction.east then
        return 0.25
    elseif direction == defines.direction.southeast then
        return 0.375
    elseif direction == defines.direction.south then
        return 0.5
    elseif direction == defines.direction.southwest then
        return 0.625
    elseif direction == defines.direction.west then
        return 0.75
    elseif direction == defines.direction.northwest then
        return 0.875
    end
    return 0
end

function Util.signal_to_string(signal)
    return signal.type .. "__" .. signal.name
end

function Util.signal_container_add(container, signal, count)
    if signal then
        if not container[signal.type] then
            container[signal.type] = {}
        end
        if container[signal.type][signal.name] then
            container[signal.type][signal.name].count = container[signal.type][signal.name].count + count
        else
            container[signal.type][signal.name] = {signal = signal, count = count}
        end
    end
end

function Util.signal_container_add_inventory(container, entity, inventory)
    local inv = entity.get_inventory(inventory)
    if inv then
        local contents = inv.get_contents()
        for item_type, item_count in pairs(contents) do
            Util.signal_container_add(container, {type="item", name=item_type}, item_count)
        end
    end
end

function Util.signal_container_get(container, signal)
    if container[signal.type] and container[signal.type][signal.name] then
        return container[signal.type][signal.name]
    end
end

Util.char_to_multiplier = {
    m = 0.001,
    c = 0.01,
    d = 0.1,
    h = 100,
    k = 1000,
    M = 1000000,
    G = 1000000000,
    T = 1000000000000,
    P = 1000000000000000,
}

function Util.string_to_number(str)
    str = ""..str
    local number_string = ""
    local last_char = nil
    for i = 1, #str do
        local c = str:sub(i,i)
        if c == "." or (c == "-" and string.len(number_string) == 0) or tonumber(c) ~= nil then
            number_string = number_string .. c
        else
            last_char = c
            break
        end
    end
    if last_char and Util.char_to_multiplier[last_char] then
        return tonumber(number_string) * Util.char_to_multiplier[last_char]
    end
    return tonumber(number_string)
end

function Util.replace(str, what, with)
    what = Util.str_gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = Util.str_gsub(with, "[%%]", "%%%%") -- escape replacement
    return Util.str_gsub(str, what, with)
end


-- splits a string by spaces
function Util.just_words(str)
   --[[str = str
   local t = {}
   local function helper(word)
      table.insert(t, word)
      return ""
   end
   if not str:gsub("%w+", helper):find"%S" then
      return t
   end]]--
   local words = {}
   for w in str:gmatch("%S+") do
     if w  and w ~= "" then
       table.insert(words, w)
     end
   end
   if #words > 0 then
     return words
   end
end


function Util.transfer_equipment_grid (entity_a, entity_b) -- NOTE: entity can be an item
    if not (entity_a.grid and entity_b.grid) then return end
    local grid_a = entity_a.grid
    local grid_b = entity_b.grid
    local equipment = grid_a.equipment
    for _, item in pairs(equipment) do
        local new_item = grid_b.put({
                name=item.name,
                position=item.position})
        if new_item then
            if item.shield and item.shield > 0 then
                new_item.shield = item.shield
            end
            if item.energy and item.energy > 0 then
                new_item.energy = item.energy
            end
        else
            Util.send_message("Error transfering "..item.name)
        end
    end
end

return Util
