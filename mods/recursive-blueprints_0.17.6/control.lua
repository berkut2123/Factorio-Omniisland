-- Command signals
local DEPLOY_SIGNAL = {name="construction-robot", type="item"}
local DECONSTRUCT_SIGNAL = {name="deconstruction-planner", type="item"}
local COPY_SIGNAL = {name="signal-C", type="virtual"}
local WIDTH_SIGNAL = {name="signal-W", type="virtual"}
local HEIGHT_SIGNAL = {name="signal-H", type="virtual"}
local X_SIGNAL = {name="signal-X", type="virtual"}
local Y_SIGNAL = {name="signal-Y", type="virtual"}
local ROTATE_SIGNAL = {name="signal-R", type="virtual"}

function on_init()
  global.deployers = {}
  on_mods_changed()
end

function on_mods_changed()
  if not global.deployers then global.deployers = {} end
  global.net_cache = {}

  -- Construction robotics unlocks deployer chest
  for _,force in pairs(game.forces) do
    if force.technologies["construction-robotics"].researched then
      force.recipes["blueprint-deployer"].enabled = true
    end
  end

  -- Collect all modded blueprint signals in one table
  global.blueprint_signals = {}
  for _,item in pairs(game.item_prototypes) do
    if item.type == "blueprint"
    or item.type == "blueprint-book"
    or item.type == "upgrade-item"
    or item.type == "deconstruction-item" then
      table.insert(global.blueprint_signals, {name=item.name, type="item"})
    end
  end
end

function on_built(event)
  local entity = event.created_entity or event.entity
  if not entity or not entity.valid then return end
  if entity.name == "blueprint-deployer" then
    table.insert(global.deployers, entity)
  end
end

function on_destroyed(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.name == "blueprint-deployer" then
    global.net_cache[entity.unit_number] = nil
  end
end

function on_tick(event)
  for key, deployer in pairs(global.deployers) do
    if deployer.valid then
      on_tick_deployer(deployer)
    else
      global.deployers[key] = nil
    end
  end
end

function on_tick_deployer(deployer)
  local bp = nil
  local deploy = get_signal(deployer, DEPLOY_SIGNAL)
  if deploy > 0 then
    bp = deployer.get_inventory(defines.inventory.chest)[1]
    if not bp.valid_for_read then return end
    if bp.is_blueprint then
      -- Deploy blueprint
      deploy_blueprint(bp, deployer)
    elseif bp.is_blueprint_book then
      -- Deploy blueprint from book
      local inventory = bp.get_inventory(defines.inventory.item_main)
      if deploy > inventory.get_item_count() then
        deploy = bp.active_index
      end
      deploy_blueprint(inventory[deploy], deployer)
    elseif bp.is_deconstruction_item then
      -- Deconstruct area
      deconstruct_area(bp, deployer, true)
    elseif bp.is_upgrade_item then
      -- Upgrade area
      upgrade_area(bp, deployer, true)
    end
    return
  end

  if deploy == -1 then
    bp = deployer.get_inventory(defines.inventory.chest)[1]
    if not bp.valid_for_read then return end
    if bp.is_deconstruction_item then
      -- Cancel deconstruction in area
      deconstruct_area(bp, deployer, false)
    elseif bp.is_upgrade_item then
      -- Cancel upgrade upgrade in area
      upgrade_area(bp, deployer, false)
    end
    return
  end

  local deconstruct = get_signal(deployer, DECONSTRUCT_SIGNAL)
  if deconstruct == -1 then
    -- Deconstruct area
    deconstruct_area(bp, deployer, true)
    return
  elseif deconstruct == -2 then
    -- Deconstruct Self
    deployer.order_deconstruction(deployer.force)
    return
  elseif deconstruct == -3 then
    -- Cancel deconstruction in area
    deconstruct_area(bp, deployer, false)
    return
  end

  local copy = get_signal(deployer, COPY_SIGNAL)
  if copy == 1 then
    -- Copy blueprint
    copy_blueprint(deployer)
    return
  elseif copy == -1 then
    -- Delete blueprint
    local stack = deployer.get_inventory(defines.inventory.chest)[1]
    if not stack.valid_for_read then return end
    if stack.is_blueprint
    or stack.is_blueprint_book
    or stack.is_upgrade_item
    or stack.is_deconstruction_item then
      stack.clear()
    end
    return
  end
end

function deploy_blueprint(bp, deployer)
  if not bp then return end
  if not bp.valid_for_read then return end
  if not bp.is_blueprint_setup() then return end

  -- Find anchor point
  local anchor_entity = nil
  local entities = bp.get_blueprint_entities()
  if entities then
    for _, entity in pairs(entities) do
      if entity.name == "wooden-chest" then
        anchor_entity = entity
        break
      elseif entity.name == "blueprint-deployer" and not anchor_entity then
        anchor_entity = entity
      end
    end
  end
  local anchorX, anchorY = 0, 0
  if anchor_entity then
    anchorX = anchor_entity.position.x
    anchorY = anchor_entity.position.y
  end

  -- Rotate
  local rotation = get_signal(deployer, ROTATE_SIGNAL)
  local direction = defines.direction.north
  if (rotation == 1) then
    direction = defines.direction.east
    anchorX, anchorY = -anchorY, anchorX
  elseif (rotation == 2) then
    direction = defines.direction.south
    anchorX, anchorY = -anchorX, -anchorY
  elseif (rotation == 3) then
    direction = defines.direction.west
    anchorX, anchorY = anchorY, -anchorX
  end

  local position = {
    x = deployer.position.x - anchorX + get_signal(deployer, X_SIGNAL),
    y = deployer.position.y - anchorY + get_signal(deployer, Y_SIGNAL),
  }

  local result = bp.build_blueprint{
    surface = deployer.surface,
    force = deployer.force,
    position = position,
    direction = direction,
    force_build = true,
  }

  for _, entity in pairs(result) do
    script.raise_event(defines.events.script_raised_built, {
      entity = entity,
      stack = bp,
    })
  end
end

function deconstruct_area(bp, deployer, deconstruct)
  local area = get_area(deployer)
  if deconstruct == false then
    -- Cancel Area
    deployer.surface.cancel_deconstruct_area{
      area = area,
      force = deployer.force,
      skip_fog_of_war = false,
      item = bp,
    }
  else
    -- Deconstruct Area
    local deconstruct_self = deployer.to_be_deconstructed(deployer.force)
    deployer.surface.deconstruct_area{
      area = area,
      force = deployer.force,
      skip_fog_of_war = false,
      item = bp,
    }
    if not deconstruct_self then
       -- Don't deconstruct myself in an area order
      deployer.cancel_deconstruction(deployer.force)
    end
  end
end

function upgrade_area(bp, deployer, upgrade)
  local area = get_area(deployer)
  if upgrade == false then
    -- Cancel area
    deployer.surface.cancel_upgrade_area{
      area = area,
      force = deployer.force,
      skip_fog_of_war = false,
      item = bp,
    }
  else
    -- Upgrade area
    deployer.surface.upgrade_area{
      area = area,
      force = deployer.force,
      skip_fog_of_war = false,
      item = bp,
    }
  end
end

function get_area(deployer)
  local X = get_signal(deployer, X_SIGNAL)
  local Y = get_signal(deployer, Y_SIGNAL)
  local W = get_signal(deployer, WIDTH_SIGNAL)
  local H = get_signal(deployer, HEIGHT_SIGNAL)

  if W < 1 then W = 1 end
  if H < 1 then H = 1 end

  -- Align to grid
  if W % 2 == 0 then X = X + 0.5 end
  if H % 2 == 0 then Y = Y + 0.5 end

  -- Subtract 1 pixel from edges to avoid tile overlap
  W = W - 1/128
  H = H - 1/128

  return {
    {deployer.position.x+X-(W/2), deployer.position.y+Y-(H/2)},
    {deployer.position.x+X+(W/2), deployer.position.y+Y+(H/2)},
  }
end

function copy_blueprint(deployer)
  local inventory = deployer.get_inventory(defines.inventory.chest)
  if not inventory.is_empty() then return end
  for _,signal in pairs(global.blueprint_signals) do
    -- Check for a signal before doing an expensive search
    if get_signal(deployer, signal) >= 1 then
      -- Signal exists, now we have to search for the blueprint
      local stack = find_stack_in_network(deployer, signal.name)
      if stack then
        inventory[1].set_stack(stack)
        return
      end
    end
  end
end

-- Breadth-first search for an item in the circuit network
-- If there are multiple items, returns the closest one (least wire hops)
function find_stack_in_network(deployer, item_name)
  local present = {
    [con_hash(deployer, defines.circuit_connector_id.container, defines.wire_type.red)] =
    {
      entity = deployer,
      connector = defines.circuit_connector_id.container,
      wire = defines.wire_type.red,
    },
    [con_hash(deployer, defines.circuit_connector_id.container, defines.wire_type.green)] =
    {
      entity = deployer,
      connector = defines.circuit_connector_id.container,
      wire = defines.wire_type.green,
    }
  }
  local past = {}
  local future = {}
  while next(present) do
    for key, con in pairs(present) do
      -- Search connecting wires
      for _, def in pairs(con.entity.circuit_connection_definitions) do
        -- Wire color and connection points must match
        if def.target_entity.unit_number
        and def.wire == con.wire
        and def.source_circuit_id == con.connector then
          local hash = con_hash(def.target_entity, def.target_circuit_id, def.wire)
          if not past[hash] and not present[hash] and not future[hash] then
            -- Search inside the entity
            local stack = find_stack_in_container(def.target_entity, item_name)
            if stack then return stack end

            -- Add entity connections to future searches
            future[hash] = {
              entity = def.target_entity,
              connector = def.target_circuit_id,
              wire = def.wire
            }
          end
        end
      end
      past[key] = true
    end
    present = future
    future = {}
  end
end

function con_hash(entity, connector, wire)
  return entity.unit_number .. "-" .. connector .. "-" .. wire
end

function find_stack_in_container(entity, item_name)
  if entity.type == "container" or entity.type == "logistic-container" then
    local inventory = entity.get_inventory(defines.inventory.chest)
    for i = 1, #inventory do
      if inventory[i].valid_for_read and inventory[i].name == item_name then
        return inventory[i]
      end
    end
  elseif entity.type == "inserter" then
    local behavior = entity.get_control_behavior()
    if not behavior then return end
    if not behavior.circuit_read_hand_contents then return end
    if entity.held_stack.valid_for_read and entity.held_stack.name == item_name then
      return entity.held_stack
    end
  end
end

-- Return integer value for given Signal: {type=, name=}
function get_signal(entity, signal)
  -- Cache the circuit networks to speed up performance
  local cache = global.net_cache[entity.unit_number]
  if not cache then
    cache = {last_update = -1}
    global.net_cache[entity.unit_number] = cache
  end
  -- Try to reload empty networks once per tick
  -- Never reload valid networks
  if cache.last_update < game.tick then
    if not cache.red_network or not cache.red_network.valid then
      cache.red_network = entity.get_circuit_network(defines.wire_type.red)
    end
    if not cache.green_network or not cache.green_network.valid then
      cache.green_network = entity.get_circuit_network(defines.wire_type.green)
    end
    cache.last_update = game.tick
  end

  -- Get the signal
  local value = 0
  if cache.red_network then
    value = value + cache.red_network.get_signal(signal)
  end
  if cache.green_network then
    value = value + cache.green_network.get_signal(signal)
  end

  -- Mimic circuit network integer overflow
  if value > 2147483647 then value = value - 4294967296 end
  if value < -2147483648 then value = value + 4294967296 end
  return value;
end


script.on_init(on_init)
script.on_configuration_changed(on_mods_changed)
script.on_event(defines.events.on_tick, on_tick)
script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)
script.on_event(defines.events.on_entity_cloned, on_built)
script.on_event(defines.events.script_raised_built, on_built)
script.on_event(defines.events.script_raised_revive, on_built)
script.on_event(defines.events.on_player_mined_entity, on_destroyed)
script.on_event(defines.events.on_robot_mined_entity, on_destroyed)
script.on_event(defines.events.on_entity_died, on_destroyed)
script.on_event(defines.events.script_raised_destroy, on_destroyed)
