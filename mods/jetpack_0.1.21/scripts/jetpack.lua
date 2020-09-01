local Jetpack = {}

--TODO: interaction with vehicles?

Jetpack.on_character_swapped_event = "on_character_swapped"
--{new_unit_number = uint, old_unit_number = uint, new_character = luaEntity, old_character = luaEntity}

Jetpack.name_event = "jetpack"
Jetpack.name_character_suffix = "-jetpack"
Jetpack.name_jetpack_shadow = "jetpack-shadow"
Jetpack.drag = 0.01
Jetpack.thrust_multiplier = 0.005
Jetpack.shadow_base_offset = {x = 1, y = 0.1}
Jetpack.altitude_target = 3
Jetpack.altitude_base_increase = 0.01
Jetpack.altitude_percentage_increase = 0.05
Jetpack.altitude_decrease = 0.2
Jetpack.fuel_use_base = 5000
Jetpack.fuel_use_thrust = 10000
Jetpack.jump_base_thrust = 0.15 -- excluding suit thrust
Jetpack.jump_thrust_multiplier = 5 -- multiplies suit thrust
Jetpack.landing_collision_snap_radius = 3

Jetpack.jetpack_equipment = {
  ["jetpack-1"] = {thrust = 1},
  ["jetpack-2"] = {thrust = 2},
  ["jetpack-3"] = {thrust = 3},
  ["jetpack-4"] = {thrust = 4},
}
Jetpack.jetpack_armor = {
  ["se-thruster-suit"] = {thrust = 1},
  ["se-thruster-suit-2"] = {thrust = 1},
  ["se-thruster-suit-3"] = {thrust = 1},
  ["se-thruster-suit-4"] = {thrust = 1},
}
Jetpack.fuels = { -- sorted by preference
  ["rocket-fuel"] = {thrust = 1},
  ["nuclear-fuel"] = {thrust = 1},
  ["processed-fuel"] = {thrust = 1},
}
Jetpack.space_tiles = {["se-space"] = "se-space"}

-- SPACEWALK
Jetpack.spacewalk_base_thrust = 0.1
Jetpack.spacewalk_thrust_multiplier = 0.5
Jetpack.spacewalk_fuel_multiplier = 0.25
Jetpack.spacewalk_no_drag_threshold = 0.5

function Jetpack.tile_is_space(tile)
  return Jetpack.space_tiles[tile.name] and true or false
end

function Jetpack.on_space_tile(character)
  local tile = character.surface.get_tile(character.position.x, character.position.y)
  return Jetpack.tile_is_space(tile)
end

function Jetpack.from_character(character)
  return global.jetpacks[character.unit_number]
end

function Jetpack.update_shadow(jetpack)
  if not rendering.is_valid(jetpack.shadow) then
    jetpack.shadow = rendering.draw_sprite{
      sprite = Jetpack.name_jetpack_shadow,
      surface = jetpack.character.surface,
      target = jetpack.character,
      target_offset = {x = Jetpack.shadow_base_offset.x + jetpack.altitude, y = Jetpack.shadow_base_offset.y + jetpack.altitude}
    }
  else
    rendering.set_target(jetpack.shadow, jetpack.character,
      {x = Jetpack.shadow_base_offset.x + jetpack.altitude, y = Jetpack.shadow_base_offset.y + jetpack.altitude})
  end
end

function Jetpack.on_tick_jetpack(jetpack)

  if not (jetpack.character and jetpack.character.valid) then
    global.jetpacks[jetpack.unit_number] = nil
    return
  end
  local character = jetpack.character
  if character.vehicle then
    character.vehicle.set_driver(nil)
  end
  if character.vehicle then
    character.vehicle.set_passenger(nil)
  end
  local on_space_tile = Jetpack.on_space_tile(jetpack.character)
  if not rendering.is_valid(jetpack.shadow) then
    Jetpack.update_shadow(jetpack)
  end
  if jetpack.status == "flying" then
    if jetpack.altitude < Jetpack.altitude_target then
      local difference = Jetpack.altitude_target - jetpack.altitude
      local change =  math.min(difference, difference * Jetpack.altitude_percentage_increase + Jetpack.altitude_base_increase)
      jetpack.altitude = jetpack.altitude + change
      character.teleport({x = character.position.x, y = character.position.y - change})
      Jetpack.update_shadow(jetpack)
    end
  else -- "stopping"
    if jetpack.altitude > 0 then
      jetpack.altitude = math.max(0, jetpack.altitude - Jetpack.altitude_decrease)
      character.teleport({x = character.position.x, y = character.position.y + Jetpack.altitude_decrease})
      Jetpack.update_shadow(jetpack)
    end
    if jetpack.altitude <= 0 and not on_space_tile then
      global.jetpacks[jetpack.unit_number] = nil
      rendering.destroy(jetpack.shadow)
      local non_colliding = jetpack.character.surface.find_non_colliding_position(
        util.replace(jetpack.character.name, Jetpack.name_character_suffix, ""), -- name
        jetpack.character.position, -- center
        Jetpack.landing_collision_snap_radius, --radius
        0.1, -- precision
        false --force_to_tile_center
      )
      if non_colliding then jetpack.character.teleport(non_colliding) end
      local land_character = Jetpack.swap_character(jetpack.character, util.replace(jetpack.character.name, Jetpack.name_character_suffix, ""))
      if jetpack.fuel.energy > 0 then
        jetpack.fuel.type = "saved"
        global.players = global.players or {}
        global.players[jetpack.player_index] = global.players[jetpack.player_index] or {}
        global.players[jetpack.player_index].saved_fuel = jetpack.fuel
      end
      return
    end
  end

  -- drag
  if on_space_tile and jetpack.altitude <= 0 then
    local speed = util.vector_length(jetpack.velocity)
    if speed > Jetpack.spacewalk_no_drag_threshold then
      local m = (speed - Jetpack.spacewalk_no_drag_threshold) / speed -- reduction
      jetpack.velocity.x = jetpack.velocity.x * (1-Jetpack.drag * m)
      jetpack.velocity.y = jetpack.velocity.y * (1-Jetpack.drag * m)
    end
  else
    jetpack.velocity.x = jetpack.velocity.x * (1-Jetpack.drag)
    jetpack.velocity.y = jetpack.velocity.y * (1-Jetpack.drag)
  end

  if jetpack.altitude > 0 then
    jetpack.fuel.energy = jetpack.fuel.energy - Jetpack.fuel_use_base
    if game.tick %2 == 0 then
      character.surface.create_trivial_smoke{name = "smoke", position = {character.position.x, character.position.y - 0.7} }
    end
  end

  local walking_state = character.walking_state
  if walking_state.walking == true then
    local direction_vector = util.direction_to_vector(walking_state.direction)
    if direction_vector then
      direction_vector = util.vector_normalise(direction_vector)
      local thrust = Jetpack.thrust_multiplier * jetpack.thrust -- get from equipment + fuel
      if on_space_tile and jetpack.altitude <= 0 then
        thrust = thrust * Jetpack.spacewalk_thrust_multiplier
        thrust = thrust + Jetpack.thrust_multiplier * Jetpack.spacewalk_base_thrust
        jetpack.fuel.energy = jetpack.fuel.energy - Jetpack.fuel_use_thrust * Jetpack.spacewalk_fuel_multiplier
      else
        jetpack.fuel.energy = jetpack.fuel.energy - Jetpack.fuel_use_thrust
      end
      if math.random() < 0.1 then
        character.surface.create_trivial_smoke{name = "smoke", position = {character.position.x, character.position.y - 0.7} }
      end
      local thrust_vector = {x = direction_vector.x * thrust, y = direction_vector.y * thrust}
      jetpack.velocity.x = jetpack.velocity.x + thrust_vector.x
      jetpack.velocity.y = jetpack.velocity.y + thrust_vector.y
    end
  end

  if jetpack.fuel.energy <= 0 then
    local fuel = Jetpack.get_fuel(jetpack.character)
    if fuel then
      local inventory = character.get_main_inventory()
      local fuel_removed = inventory.remove({name=fuel.name, count=1})
      if fuel_removed == 0 then
        jetpack.status = "stopping"
      else
        jetpack.fuel = fuel
        jetpack.fuel.type = "jetpack"
      end
    else
      jetpack.status = "stopping"
    end
  end

  local new_position = {x = character.position.x + jetpack.velocity.x, y = character.position.y + jetpack.velocity.y}

  local target_tile = jetpack.character.surface.get_tile(new_position.x, new_position.y)
  if target_tile then
    if target_tile.name == "out-of-map" then -- bounce
      jetpack.velocity.x = jetpack.velocity.x / -2
      jetpack.velocity.y = jetpack.velocity.y / -2
    elseif target_tile.name == "se-spaceship-floor" then
      jetpack.status = "stopping"
      jetpack.altitude = 0
      jetpack.velocity.x = jetpack.velocity.x / 2
      jetpack.velocity.y = jetpack.velocity.y / 2
      character.teleport(new_position)
    else
      character.teleport(new_position)
    end
  else
    jetpack.velocity.x = jetpack.velocity.x / 2
    jetpack.velocity.y = jetpack.velocity.y / 2
  end
end

function Jetpack.on_tick(event)
  for unit_number, jetpack in pairs(global.jetpacks) do
    Jetpack.on_tick_jetpack(jetpack)
  end
  if global.robot_collections then
    for k, robot_collection in pairs(global.robot_collections) do
      if not (robot_collection.character and robot_collection.character.valid) then
        global.robot_collections[k] = nil
      elseif robot_collection.character.logistic_cell and robot_collection.character.logistic_cell.valid
       and robot_collection.character.logistic_cell.logistic_network and robot_collection.character.logistic_cell.logistic_network.valid then
        for _, robot in pairs(robot_collection.robots) do
          if robot.valid and robot.surface == robot_collection.character.surface then
            robot.logistic_network = robot_collection.character.logistic_cell.logistic_network
          end
        end
        global.robot_collections[k] = nil
      end
    end
  end
end
Event.addListener(defines.events.on_tick, Jetpack.on_tick)

function Jetpack.swap_character(old, new_name)
  if not game.entity_prototypes[new_name] then return end
  local buffer_capacity = 1000
  local old_unit_number = old.unit_number
  local new = old.surface.create_entity{
    name = new_name,
    position = old.position,
    force = old.force,
    direction = old.direction,
  }

  new.character_inventory_slots_bonus = old.character_inventory_slots_bonus + buffer_capacity
  old.character_inventory_slots_bonus = old.character_inventory_slots_bonus + buffer_capacity


  local vehcile = old.vehicle
  local save_queue = nil
  if old.crafting_queue then
     save_queue = {}
     for i = old.crafting_queue_size, 1, -1 do
       if old.crafting_queue and old.crafting_queue[i] then
         table.insert(save_queue, old.crafting_queue[i])
         old.cancel_crafting(old.crafting_queue[i])
       end
     end
  end
  local opened_self = old.player and old.player.opened_self

  if old.logistic_network and #old.logistic_network.robots > 0 then
    global.robot_collections = global.robot_collections or {}
    table.insert(global.robot_collections, {character = new, robots = old.logistic_network.robots})
  end

  new.health = old.health
  new.copy_settings(old)
  new.selected_gun_index = old.selected_gun_index

  local slot_count = old.character_logistic_slot_count
  new.character_logistic_slot_count = slot_count
  for i = 1, slot_count do
    local slot = old.get_personal_logistic_slot(i)
    if slot and slot.name then
      if slot.min then
        if slot.max then
          slot.min = math.min(slot.min, slot.max)
        end
        slot.min = math.max(0, slot.min)
      end
      if slot.max then
        if slot.min then
          slot.max = math.max(slot.min, slot.max)
        end
        slot.max = math.max(0, slot.max)
      end
      new.set_personal_logistic_slot(i, slot)
    end
  end
  new.character_personal_logistic_requests_enabled = old.character_personal_logistic_requests_enabled
  new.allow_dispatching_robots = old.allow_dispatching_robots

  new.cursor_stack.swap_stack(old.cursor_stack)
  if old.player then
    old.player.set_controller{type=defines.controllers.character, character=new}
    if opened_self then new.player.opened = new end
  end

  -- need to stop inventory overflow when armor is swapped
  local old_inv = old.get_inventory(defines.inventory.character_armor)
  if old_inv and old_inv[1] and old_inv[1].valid_for_read then
    local new_inv = new.get_inventory(defines.inventory.character_armor)
    new_inv.insert({name = old_inv[1].name, count = 1})
  end

  if old.grid then
    for _, old_eq in pairs(old.grid.equipment) do
      local new_eq = new.grid.put{name = old_eq.name, position = old_eq.position}
      if new_eq and new_eq.valid then
        if old_eq.type == "energy-shield-equipment" then
          new_eq.shield = old_eq.shield
        end
        if old_eq.energy then
          new_eq.energy = old_eq.energy
        end
        if old_eq.burner then
          for i = 1, #old_eq.burner.inventory do
            new_eq.burner.inventory.insert(old_eq.burner.inventory[i])
          end
          new_eq.burner.currently_burning = old_eq.burner.currently_burning
          new_eq.burner.heat = old_eq.burner.heat
          new_eq.burner.remaining_burning_fuel = old_eq.burner.remaining_burning_fuel
        end
      end
    end
    new.grid.inhibit_movement_bonus = old.grid.inhibit_movement_bonus
  end

  --util.swap_entity_inventories(old, new, defines.inventory.character_armor)
  util.swap_entity_inventories(old, new, defines.inventory.character_main)
  util.swap_entity_inventories(old, new, defines.inventory.character_guns)
  util.swap_entity_inventories(old, new, defines.inventory.character_ammo)
  util.swap_entity_inventories(old, new, defines.inventory.character_trash)

  raise_event(Jetpack.on_character_swapped_event, {
      new_unit_number = new.unit_number,
      old_unit_number = old.unit_number,
      new_character = new,
      old_character = old
    })
  if old.valid then
    old.destroy()
  end
  if vehicle then
    if not vehicle.get_driver(new) then
      vehicle.set_driver(new)
    elseif not vehicle.get_passenger(new) then
      vehicle.set_passenger(new)
    end
  end
  if save_queue then
    for i = #save_queue, 1, -1 do
      local cci = save_queue[i]
      if cci then
        cci.silent = true
        new.begin_crafting(cci)
      end
    end
  end
  new.character_inventory_slots_bonus = new.character_inventory_slots_bonus - buffer_capacity

  return new
end

function Jetpack.on_armor_changed(event)
  local player = game.players[event.player_index]
  if player.character then
    local character = player.character
    local jetpack = Jetpack.from_character(character)
    if jetpack then
      local thrust = Jetpack.get_current_thrust(character)
      jetpack.thrust = thrust
      if thrust <= 0 then
        jetpack.status = "stopping"
      end
    end
  end
end
Event.addListener(defines.events.on_player_placed_equipment, Jetpack.on_armor_changed)
Event.addListener(defines.events.on_player_removed_equipment, Jetpack.on_armor_changed)
Event.addListener(defines.events.on_player_armor_inventory_changed, Jetpack.on_armor_changed)

function Jetpack.get_fuel(character, allow_saved)
  if allow_saved and character.player and global.players and global.players[character.player.index] and global.players[character.player.index].saved_fuel then
    return global.players[character.player.index].saved_fuel
  end
  local inventory = character.get_main_inventory()
  if inventory and inventory.valid then
    for fuel_name, fuel_stats in pairs(Jetpack.fuels) do
      if game.item_prototypes[fuel_name] then
        local count = inventory.get_item_count(fuel_name)
        if count > 0 then return { type="inventory", name = fuel_name, energy = game.item_prototypes[fuel_name].fuel_value, thrust = fuel_stats.thrust} end
      end
    end
  end
end

function Jetpack.get_current_thrust(character)
  local thrust = 0
  -- thruster suits have thrust
  local armor_inv = character.get_inventory(defines.inventory.character_armor)
  if armor_inv and armor_inv[1] and armor_inv[1].valid_for_read then
    local armor = armor_inv[1]
    if Jetpack.jetpack_armor[armor.name] then
      thrust = thrust + Jetpack.jetpack_armor[armor.name].thrust
    end
  end
  -- jetpack equipment has thrust
  if character.grid then
    for name, count in pairs(character.grid.get_contents()) do
      if Jetpack.jetpack_equipment[name] ~= nil then
        thrust = thrust + count * (Jetpack.jetpack_equipment[name].thrust or 0)
      end
    end
  end

  return math.sqrt(thrust)
end

function Jetpack.start_on_character(character, thrust, fuel)
  local player = character.player
  if character.vehicle or global.disabled_on and global.disabled_on[character.unit_number] then return end
  local inventory = character.get_main_inventory()
  if not player and inventory then return end
  local tile = character.surface.get_tile(character.position.x, character.position.y)
  if tile.name == "se-spaceship-floor" then
    if character.player then
      character.player.print("Can't fly inside.")
    end
    return
  end
  if fuel.type == "inventory" then
    local fuel_removed = inventory.remove({name=fuel.name, count=1})
    if fuel_removed == 0 then return end
  elseif character.player and global.players and global.players[character.player.index] then
     global.players[character.player.index].saved_fuel = nil
  end
  fuel.type = "jetpack"
  local walking_state = character.walking_state
  local new_character = Jetpack.swap_character(character, character.name .. Jetpack.name_character_suffix)
  if not new_character then
    for _, jetpack in pairs(global.jetpacks) do
      if jetpack.character == character then return end
    end
    new_character = character
  end
  local shadow = rendering.draw_sprite{
    sprite = Jetpack.name_jetpack_shadow,
    surface = new_character.surface,
    target = new_character,
    target_offset = Jetpack.shadow_base_offset
  }
  local jetpack = {
    status = "flying",
    character = new_character,
    unit_number = new_character.unit_number,
    force_name = new_character.force.name,
    player_index = player.index,
    fuel = fuel,
    velocity = {x=0,y=0},
    altitude = 0,
    shadow = shadow,
    thrust = thrust,
  }
  if walking_state.walking == true then
    local direction_vector = util.direction_to_vector(walking_state.direction)
    if direction_vector then
      direction_vector = util.vector_normalise(direction_vector)
      local thrust = Jetpack.thrust_multiplier * jetpack.thrust -- get from equipment + fuel
      jetpack.velocity.x = direction_vector.x * (Jetpack.jump_base_thrust + Jetpack.jump_thrust_multiplier * thrust)
      jetpack.velocity.y = direction_vector.y * (Jetpack.jump_base_thrust + Jetpack.jump_thrust_multiplier * thrust)
    end
  end
  global.jetpacks[jetpack.unit_number] = jetpack
  return jetpack
end

function Jetpack.on_player_changed_position(event)
  local player = game.players[event.player_index]
  if player and player.connected and player.character then
    if not Jetpack.from_character(player.character) then
      if Jetpack.on_space_tile(player.character) then
        -- start spacewalking at 0 altitude
        local character = player.character
        local thrust = Jetpack.get_current_thrust(character)
        local fuel = Jetpack.get_fuel(character, true)
        local jetpack = Jetpack.start_on_character(character, thrust, fuel or {type = "jetpack", name="spacewalking", energy = 0, thrust = 1})
        if jetpack then jetpack.status = "stopping" end
      end
    end
  end
end
Event.addListener(defines.events.on_player_changed_position, Jetpack.on_player_changed_position)


function Jetpack.stop_jetpack(jetpack)
  jetpack.status = "stopping"
end

function Jetpack.toggle(character)
  local jetpack = Jetpack.from_character(character)
  if jetpack then
    if jetpack.status == "stopping" then
      jetpack.status = "flying"
    else
      jetpack.status = "stopping"
    end
  else
    local thrust = Jetpack.get_current_thrust(character)
    if thrust > 0 then
      local fuel = Jetpack.get_fuel(character, true)
      if fuel then
        Jetpack.start_on_character(character, thrust, fuel)
      else
        if character.player then
          character.player.print("No jetpack fuel in inventory.")
        end
      end
    else
      if character.player then
        character.player.print("You need a jetpack to fly.")
      end
    end
  end
end

function Jetpack.on_jetpack_keypress (event)
  if event.player_index and game.players[event.player_index] and game.players[event.player_index].connected then
    local player = game.players[event.player_index]
    if player.character then
      Jetpack.toggle(player.character)
    end
  end
end
Event.addListener(Jetpack.name_event, Jetpack.on_jetpack_keypress)

function Jetpack.on_init(event)
  global.jetpacks = {}
end
Event.addListener("on_init", Jetpack.on_init, true)

return Jetpack
