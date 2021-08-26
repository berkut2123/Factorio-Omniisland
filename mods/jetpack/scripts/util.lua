local util = {}

util.mod_prefix = "aai-" -- update strings.cfg

util.min = math.min
util.max = math.max
util.floor = math.floor
util.abs = math.abs
util.sqrt = math.sqrt
util.sin = math.sin
util.cos = math.cos
util.atan = math.atan
util.pi = math.pi
util.remove = table.remove
util.insert = table.insert
util.str_gsub = string.gsub


function util.deep_copy (t)
  return table.deepcopy(t)
end

function util.shallow_copy (t) -- shallow-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do target[k] = v end
    setmetatable(target, meta)
    return target
end

function util.remove_from_table(list, item)
    local index = 0
    for _,_item in ipairs(list) do
        if item == _item then
            index = _
            break
        end
    end
    if index > 0 then
        util.remove(list, index)
    end
end

function util.shuffle (tbl)
  size = #tbl
  for i = size, 1, -1 do
    --local rand = 1 + math.floor(size * (math.random() - 0.0000001))
    local rand = math.random(size)
    tbl[i], tbl[rand] = tbl[rand], tbl[i]
  end
  return tbl
end

function util.random_from_array (tbl)
  --return tbl[1 + math.floor(#tbl * (math.random() - 0.0000001))]
  return tbl[math.random(#tbl)]
end

function util.transfer_burner_direct (burner_a, burner_b)
    if burner_a and burner_b then
      burner_b.heat = burner_a.heat
      if burner_a.currently_burning then
        burner_b.currently_burning = burner_a.currently_burning.name
        burner_b.remaining_burning_fuel = burner_a.remaining_burning_fuel
      end
      if burner_a.inventory and burner_b.inventory then
        util.swap_inventories(burner_a.inventory, burner_b.inventory)
      end
      if burner_a.burnt_result_inventory and burner_b.burnt_result_inventory then
        util.swap_inventories(burner_a.burnt_result_inventory, burner_b.burnt_result_inventory)
      end
    end
end

function util.transfer_burner (entity_a, entity_b)
  util.transfer_burner_direct (entity_a.burner, entity_b.burner)
end

function util.copy_inventory (inv_a, inv_b, probability)
    if not probability then probability = 1 end
    if inv_a and inv_b then
        local contents = inv_a.get_contents()
        for item_type, item_count in pairs(contents) do
            if probability == 1 or probability > math.random() then
              inv_b.insert({name=item_type, count=item_count})
            end
        end
    end
end

function util.move_inventory_items (inv_a, inv_b)
  -- move all items from inv_a to inv_b
  -- preserves item data but inv_b MUST be able to accept the items or they are lost.
  -- inventory A is cleared.
  for i = 1, util.min(#inv_a, #inv_b) do
    if inv_a[i] and inv_a[i].valid then
      inv_b.insert(inv_a[i])
    end
  end
  inv_a.clear()
end

function util.transfer_inventory_filters (entity_a, entity_b, inventory_type)
    local inv_a = entity_a.get_inventory(inventory_type)
    local inv_b = entity_b.get_inventory(inventory_type)
    if inv_a.supports_filters() and inv_b.supports_filters() then
        for i = 1, util.min(#inv_a, #inv_b) do
            local filter = inv_a.get_filter(i)
            if filter then
                inv_b.set_filter(i, filter)
            end
        end
    end
end

function util.transfer_equipment_grid (entity_a, entity_b)
  game.print("test")
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
            if item.burner then
              util.transfer_burner_direct (item.burner, new_item.burner)
            end
        else
            util.send_message("Error transfering "..item.name)
        end
    end
end

function util.area_add_position(area, position)
  local area2 = table.deepcopy(area)
  for k1, v1 in pairs(area2) do
    for k2, v2 in pairs(v1) do
      if k2 == 1 or k2 == "x" then
        v1[k2] = v2 + (position.x or position[1])
      elseif k2 == 2 or k2 == "y" then
        v1[k2] = v2 + (position.y or position[2])
      end
    end
  end
  return area2
end

function util.area_extend(area, range)
  local area2 = table.deepcopy(area)
  for k1, v1 in pairs(area2) do
    local m = 1
    if k1 == 1 or k1 == "left_top" then
      m = -1
    end
    for k2, v2 in pairs(v1) do
      v1[k2] = v2 + range * m
    end
  end
  return area2
end

function util.position_to_area(position, radius)
  return {{x = position.x - radius, y = position.y - radius},
          {x = position.x + radius, y = position.y + radius}}
end

function util.position_to_tile(position)
    return {x = math.floor(position.x), y = math.floor(position.y)}
end

function util.tile_to_position(tile_position)
    return {x = tile_position.x+0.5, y = tile_position.y+0.5}
end

function util.position_to_xy_string(position)
    return util.xy_to_string(position.x, position.y)
end

function util.xy_to_string(x, y)
    return util.floor(x) .. "_" .. util.floor(y)
end

function util.lerp(a, b, alpha)
    return a + (b - a) * alpha
end

function util.lerp_angles(a, b, alpha)
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

function util.array_to_vector(array)
    return {x = array[1], y = array[2]}
end

function util.vectors_delta(a, b) -- from a to b
    if not a and b then return 0 end
    return {x = b.x - a.x, y = b.y - a.y}
end

function util.vectors_delta_length(a, b)
    return util.vector_length_xy(b.x - a.x, b.y - a.y)
end

function util.vector_length(a)
    return util.sqrt(a.x * a.x + a.y * a.y)
end

function util.vector_length_xy(x, y)
    return util.sqrt(x * x + y * y)
end

function util.vector_dot(a, b)
    return a.x * b.x + a.y * b.y
end

function util.vector_multiply(a, multiplier)
    return {x = a.x * multiplier, y = a.y * multiplier}
end

function util.vector_dot_projection(a, b)
    local n = util.vector_normalise(a)
    local d = util.vector_dot(n, b)
    return {x = n.x * d, y = n.y * d}
end

function util.vector_normalise(a)
    local length = util.vector_length(a)
    return {x = a.x/length, y = a.y/length}
end

function util.vector_set_length(a, length)
    local old_length = util.vector_length(a)
    if old_length == 0 then return {x = 0, y = -length} end
    return {x = a.x/old_length*length, y = a.y/old_length*length}
end

function util.orientation_from_to(a, b)
    return util.vector_to_orientation_xy(b.x - a.x, b.y - a.y)
end

function util.orientation_to_vector(orientation, length)
    return {x = length * util.sin(orientation * 2 * util.pi), y = -length * util.cos(orientation * 2 * util.pi)}
end

function util.rotate_vector(orientation, a)
    return {
      x = -a.y * util.sin(orientation * 2 * util.pi) + a.x * util.sin((orientation + 0.25) * 2 * util.pi),
      y = a.y * util.cos(orientation * 2 * util.pi) -a.x * util.cos((orientation + 0.25) * 2 * util.pi)}
end

function util.vectors_add(a, b)
    return {x = a.x + b.x, y = a.y + b.y}
end

function util.lerp_vectors(a, b, alpha)
    return {x = a.x + (b.x - a.x) * alpha, y = a.y + (b.y - a.y) * alpha}
end

function util.move_to(a, b, max_distance, eliptical)
    -- move from a to b with max_distance.
    -- if eliptical, reduce y change (i.e. turret muzzle flash offset)
    local eliptical_scale = 0.9
    local delta = util.vectors_delta(a, b)
    if eliptical then
        delta.y = delta.y / eliptical_scale
    end
    local length = util.vector_length(delta)
    if (length > max_distance) then
        local partial = max_distance / length
        delta = {x = delta.x * partial, y = delta.y * partial}
    end
    if eliptical then
        delta.y = delta.y * eliptical_scale
    end
    return {x = a.x + delta.x, y = a.y + delta.y}
end

function util.vector_to_orientation(v)
    return util.vector_to_orientation_xy(v.x, v.y)
end

function util.vector_to_orientation_xy(x, y)
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
                return util.atan(x / -y) / util.pi / 2
            else
                return 1 + util.atan(x / -y) / util.pi / 2
            end
        else
            return 0.5 + util.atan(x / -y) / util.pi / 2
        end
    end
end

function util.direction_to_orientation(direction)
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

function util.signal_to_string(signal)
    return signal.type .. "__" .. signal.name
end

function util.signal_container_add(container, signal, count)
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

function util.signal_container_add_inventory(container, entity, inventory)
    local inv = entity.get_inventory(inventory)
    if inv then
        local contents = inv.get_contents()
        for item_type, item_count in pairs(contents) do
            util.signal_container_add(container, {type="item", name=item_type}, item_count)
        end
    end
end

function util.signal_container_get(container, signal)
    if container[signal.type] and container[signal.type][signal.name] then
        return container[signal.type][signal.name]
    end
end

util.char_to_multiplier = {
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

function util.string_to_number(str)
    str = ""..str
    local number_string = ""
    local last_char = nil
    for i = 1, #str do
        local c = str:sub(i,i)
        if c == "." or (c == "-" and i == 1) or tonumber(c) ~= nil then
            number_string = number_string .. c
        else
            last_char = c
            break
        end
    end
    if last_char and util.char_to_multiplier[last_char] then
        return tonumber(number_string) * util.char_to_multiplier[last_char]
    end
    return tonumber(number_string)
end

function util.replace(str, what, with)
    what = util.str_gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = util.str_gsub(with, "[%%]", "%%%%") -- escape replacement
    return util.str_gsub(str, what, with)
end

function util.split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function util.overwrite_table(table_weak, table_strong)
  for k,v in pairs(table_strong) do table_weak[k] = v end
  return table_weak
end

function util.table_contains(table, check)
  for k,v in pairs(table) do if v == check then return true end end
  return false
end

function util.table_to_string(table)
  return serpent.block( table, {comment = false, numformat = '%1.8g' } )
end

function util.values_to_string(table)
  local string = ""
  for _, value in pairs(table) do
    string = ((string == "") and "" or ", ") .. string .. value
  end
  return string
end

function util.math_log(value, base)
  --logb(a) = logc(a) / logc(b)
  return math.log(value)/math.log(base)
end

function util.seconds_to_clock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "0";
  else
    local hours = math.floor(seconds/3600)
    local mins = math.floor(seconds/60 - (hours*60))
    local secs = math.floor(seconds - hours*3600 - mins *60)
    local s_hours = string.format("%02.f",hours);
    local s_mins = string.format("%02.f", mins);
    local s_secs = string.format("%02.f", secs);
    if hours > 0 then
      return s_hours..":"..s_mins..":"..s_secs
    end
    if mins > 0 then
      return s_mins..":"..s_secs
    end
    if secs == 0 then
      return "0"
    end
    return s_secs
  end
end

function util.to_rail_grid(number_or_position)
  if type(number_or_position) == "table" then
    return {x = util.to_rail_grid(number_or_position.x), y = util.to_rail_grid(number_or_position.y)}
  end
  return math.floor(number_or_position / 2) * 2
end

function util.format_fuel(fuel, ceil)
  return string.format("%.2f",(fuel or 0) / 1000).."k"
end

function util.format_energy(fuel, ceil)
  if ceil then
    return math.ceil((fuel or 0) / 1000000000).."GJ"
  else
    return math.floor((fuel or 0) / 1000000000).."GJ"
  end
end

function util.direction_to_vector (direction)
  if direction == defines.direction.east then return {x=1,y=0} end
  if direction == defines.direction.north then return {x=0,y=-1} end
  if direction == defines.direction.northeast then return {x=1,y=-1} end
  if direction == defines.direction.northwest then return {x=-1,y=-1} end
  if direction == defines.direction.south then return {x=0,y=1} end
  if direction == defines.direction.southeast then return {x=1,y=1} end
  if direction == defines.direction.southwest then return {x=-1,y=1} end
  if direction == defines.direction.west then return {x=-1,y=0} end
end

function util.sign(x)
   if x<0 then
     return -1
   elseif x>0 then
     return 1
   else
     return 0
   end
end

function util.find_first_descendant_by_name(gui_element, name)
  for _, child in pairs(gui_element.children) do
    if child.name == name then
      return child
    end
    local found = util.find_first_descendant_by_name(child, name)
    if found then return found end
  end
end

function util.find_descendants_by_name(gui_element, name, all_found)
  local found = all_found or {}
  for _, child in pairs(gui_element.children)do
    if child.name == name then
      table.insert(found, child)
    end
    util.find_descendants_by_name(child, name, found)
  end
  return found
end

function util.swap_entity_inventories(entity_a, entity_b, inventory)
  util.swap_inventories(entity_a.get_inventory(inventory), entity_b.get_inventory(inventory))
end

function util.swap_inventories(inv_a, inv_b)
  if inv_a.is_filtered() then
    for i = 1, math.min(#inv_a, #inv_b) do
      inv_b.set_filter(i, inv_a.get_filter(i))
    end
  end
  for i = 1, math.min(#inv_a, #inv_b)do
    inv_b[i].swap_stack(inv_a[i])
  end
end


return util
