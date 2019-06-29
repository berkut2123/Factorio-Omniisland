local compi = {}
local locations = require(mod_name .. ".lualib.locations")
local command_callback = require(mod_name .. ".lualib.command_callback")
local function_save = require(mod_name .. ".lualib.function_save")
local util = require("util")
local math2d = require("math2d")

local teleport_near_and_walk_to_internal
local walk_to_internal

compi.compi_build_callback = function()
  local next = global.compi_build_items_list[#global.compi_build_items_list]
  local previous = global.compi_build_item_previous

  if previous then
    local entity_width = previous.prototype.collision_box.right_bottom.x - previous.prototype.collision_box.left_top.x
    local entity_height = previous.prototype.collision_box.right_bottom.y - previous.prototype.collision_box.left_top.y

    local masks = {}
    for mask, on in pairs(previous.prototype.collision_mask) do
      if on then
        table.insert(masks, mask)
      end
    end

    local overlapping_entities = locations.get_main_surface().find_entities_filtered
    {
      area = math2d.bounding_box.create_from_centre(previous.position, entity_width, entity_height),
      collision_mask = masks
    }

    local teleport_compi = false
    for _, entity in pairs(overlapping_entities) do
      if entity == global.compilatron.entity then
        teleport_compi = true
      elseif entity.health then
        entity.die()
      else
        entity.destroy()
      end
    end

    local new_entity = locations.get_main_surface().create_entity
    {
      name = previous.name,
      position = previous.position,
      direction = previous.direction,
      force = game.forces.player,
    }

    -- if compilatron was blocking the building himself, just teleport him away
    if teleport_compi then
      local tele_spot = global.compilatron.entity.surface.find_non_colliding_position(global.compilatron.entity.name,
                                                                                      global.compilatron.entity.position,
                                                                                      0,
                                                                                      0.5)

      global.compilatron.entity.teleport(tele_spot)
    end

    assert(new_entity)
    if new_entity.get_fuel_inventory() then
      new_entity.get_fuel_inventory().insert({name='coal',count=2})
    end
    if type(previous.operable) == 'boolean' then
      new_entity.operable = previous.operable
    end
    if type(previous.active) == 'boolean' then
      new_entity.active = previous.active
    end
    if type(previous.rotatable) == 'boolean' then
      new_entity.rotatable = previous.rotatable
    end
    if type(previous.minable) == 'boolean' then
      new_entity.minable = previous.minable
    end
    if type(previous.destructible) == 'boolean' then
      new_entity.destructible = previous.destructible
    end
    new_entity.create_build_effect_smoke()
    new_entity.surface.play_sound{path="entity-build/"..new_entity.prototype.name, position=new_entity.position}

    global.compi_build_item_previous = nil
  end

  if next then
    global.compi_build_items_list[#global.compi_build_items_list] = nil
    global.compi_build_item_previous = next
    compi.stand_next_to(next.box, nil, nil, 'compi_build_callback', "immediately")
  else
    global.compi_build_items_list = nil

    if global.compi_build_completed_callback then
      function_save.run(global.compi_build_completed_callback)
    else
      global.compilatron.reset = true
    end
    global.compi_build_completed_callback = nil
    global.compi_is_building = false
  end
end
function_save.add_function('compi_build_callback', compi.compi_build_callback)

compi.set_direction = function(direction)
  direction = direction or defines.direction.southeast

  local compi_ent = global.compilatron.entity

  local deg45 = 1/8;

  if direction == defines.direction.north then
    compi_ent.orientation = deg45 * 0
  elseif direction == defines.direction.northeast then
    compi_ent.orientation = deg45 * 1
  elseif direction == defines.direction.east then
    compi_ent.orientation = deg45 * 2
  elseif direction == defines.direction.southeast then
    compi_ent.orientation = deg45 * 3
  elseif direction == defines.direction.south then
    compi_ent.orientation = deg45 * 4
  elseif direction == defines.direction.southwest then
    compi_ent.orientation = deg45 * 5
  elseif direction == defines.direction.west then
    compi_ent.orientation = deg45 * 6
  elseif direction == defines.direction.northwest then
    compi_ent.orientation = deg45 * 7
  end

  global.compilatron.direction = direction
end

compi.stop = function()
  global.compilatron.entity.set_command({ type=defines.command.stop })
end

compi.moving = function()
  return global.compilatron.moving
end

compi.teleport_near_and_walk_to = function(destination, teleport_on_fail)
  compi.remove_display()

  local self = global.compilatron
  if teleport_on_fail == nil then teleport_on_fail = true end

  global.compilatron.moving = true
  teleport_near_and_walk_to_internal(self, destination, teleport_on_fail, false)
end

compi.walk_to = function(_destination, teleport_on_fail, allow_destroy_friendly_entities, arrived_callback_name)
  compi.remove_display()

  if teleport_on_fail == nil then teleport_on_fail = true end
  if allow_destroy_friendly_entities == nil then allow_destroy_friendly_entities = true end

  local destroy_immediately = false
  if allow_destroy_friendly_entities == "immediately" then
    allow_destroy_friendly_entities = true
    destroy_immediately = true
  end

  local destination
  if _destination.x == nil then
    destination = {_destination[1], _destination[2]}
  else
    destination = {_destination.x, _destination.y}
  end

  destination[1] = math.floor(destination[1]) + 0.5
  destination[2] = math.floor(destination[2]) + 0.5

  global.compilatron.walk_to_retry_data =
  {
    destination = destination,
    teleport_on_fail = teleport_on_fail,
    allow_destroy_friendly_entities = allow_destroy_friendly_entities
  }

  walk_to_internal(
    destination,
    teleport_on_fail,
    destroy_immediately,
    false,
    "walk_to_retry",
    arrived_callback_name)
end

-- target: entity or bounding_box to walk near to
-- do_indicate: whether to draw an indication box around the target
-- say: what to say when we get there
compi.stand_next_to = function(target, do_indicate, say, arrived_callback_name, allow_destroy_friendly_entities)
  if allow_destroy_friendly_entities == nil then
    allow_destroy_friendly_entities = true
  end


  assert(target, "attempted to tell Compi to stand_next_to nil target")
  local is_bounding_box = false
  for k,_ in pairs(target) do
    if k == "left_top" then
      is_bounding_box = true
      break
    end
  end

  local bounding_box = target
  if is_bounding_box == false then
    bounding_box = target.bounding_box
  end

  bounding_box = {
    left_top = {
      x = bounding_box.left_top.x - 1,
      y = bounding_box.left_top.y - 1,
    },
    right_bottom = {
      x = bounding_box.left_top.x,
      y = bounding_box.left_top.y,
    },
  }

  local position = locations.get_main_surface().find_non_colliding_position_in_box('compilatron',bounding_box,0.01,true)
  local tries = 0
  while position == nil and tries < 4 do
    bounding_box = {
      left_top = {
        x = bounding_box.left_top.x,
        y = bounding_box.left_top.y,
      },
      right_bottom = {
        x = bounding_box.right_bottom.x + 1,
        y = bounding_box.right_bottom.y + 1,
      },
    }
    position = locations.get_main_surface().find_non_colliding_position_in_box('compilatron',bounding_box,0.01,true)
    tries = tries + 1
  end

  if position then
    compi.walk_to(position, true, allow_destroy_friendly_entities, arrived_callback_name)

    if do_indicate then
      global.compilatron.future_box = target
    end

    if say then
      compi.say_later(say)
    end
  else
    global.compilatron.reset = true
    print("Compi was blocked")
  end
end

compi.say = function(text)
  if global.compilatron.bubble then global.compilatron.bubble.destroy() end
  if text == nil and global.compilatron.bubble then
    global.compilatron.bubble.destroy()
    global.compilatron.wait_text = nil
    return true
  elseif text == nil then
    global.compilatron.wait_text = nil
    return true
  end

  local ent = global.compilatron.entity
  local bubble = ent.surface.create_entity({
    name="compi-speech-bubble",
    text=text,
    position={0,0},
    source=ent
    })
  global.compilatron.bubble = bubble
  ent.direction = defines.direction.southwest
end

function compi.display()
  local surface = global.compilatron.entity.surface
  for _, ghost in pairs(global.compilatron.ghosts_to_display) do
    local ghost_ent = surface.create_entity({
      name='entity-ghost',
      inner_name=ghost.name,
      position=ghost.position,
      direction=ghost.direction,
      force='player',
    })
    table.insert(global.compilatron.displayed_ghosts,ghost_ent)
  end
end

function compi.remove_display()
  for _, ghost_ent in pairs(global.compilatron.displayed_ghosts) do
    ghost_ent.destroy()
  end
  if global.compilatron.indicator then
    global.compilatron.indicator.destroy() global.compilatron.indicator = nil
  end
  if global.compilatron.future_box then
    global.compilatron.future_box = nil
  end
  if global.compilatron.bubble then
    global.compilatron.bubble.destroy()
  end
end

function compi.say_later(text)
  if global.compilatron.bubble then global.compilatron.bubble.destroy() global.compilatron.bubble = nil end
  global.compilatron.wait_text = text
end

function compi.indicate(target)
  if target == nil then
    compi.remove_display()
    global.compilatron.future_box = nil
    return
  end
  if global.compilatron.indicator then global.compilatron.indicator.destroy() global.compilatron.indicator = nil end

  local is_bounding_box = false
  for k,_ in pairs(target) do
    if k == "left_top" then
      is_bounding_box = true
      break
    end
  end

  if is_bounding_box then
    global.compilatron.indicator = global.compilatron.entity.surface.create_entity({
      name='highlight-box',
      bounding_box = target,
      position = {0,0}
    })
  else -- target is an entity
    global.compilatron.indicator = global.compilatron.entity.surface.create_entity({
      name='highlight-box',
      source = target,
      position = {0,0}
    })
  end
  --print("boop:",serpent.block(box))
  global.compilatron.future_box = nil
end

function compi.display_ghost_later(entity_name,position,direction)
  table.insert(global.compilatron.ghosts_to_display,{name = entity_name, position = position, direction = direction})
end

function compi.check_range(position,range)
  local dist = math2d.position.distance(global.compilatron.entity.position,position)
  return dist < range
end

compi.respawn_compi = function(spawn_pos)
  assert(global.compilatron.entity == nil or global.compilatron.entity.health == 0 or not global.compilatron.entity.valid)

  spawn_pos = spawn_pos or global.compilatron.wait_position or {0,0}
  local new_compi = locations.get_main_surface().create_entity
    {
      name = "compilatron",
      position = spawn_pos,
      force = "player"
    }
  new_compi.set_command { type=defines.command.stop }

  global.compilatron.entity = new_compi
  return new_compi
end

compi.teleport_to = function(position)
  global.compilatron.entity.teleport(position)
end

compi.build_area = function(area_name, search_params, entity_properties)
  entity_properties = entity_properties or {}

  search_params = util.table.deepcopy(search_params)
  search_params.area = locations.get_area(area_name)

  local entities_to_build_in_template_surface = locations.get_template_surface().find_entities_filtered(search_params)

  global.compi_build_items_list = {}
  for _, entity in pairs(entities_to_build_in_template_surface) do
    local active = entity.active
    local operable = entity.operable
    local minable = entity.minable
    local destructible = entity.destructible
    local rotatable = entity.rotatable

    local this_entity_properties = entity_properties[entity.prototype.name]
    if this_entity_properties then
      if this_entity_properties.active ~= nil then active = this_entity_properties.active end
      if this_entity_properties.operable ~= nil then operable = this_entity_properties.operable end
      if this_entity_properties.minable ~= nil then minable = this_entity_properties.minable end
      if this_entity_properties.destructible ~= nil then destructible = this_entity_properties.destructible end
      if this_entity_properties.rotatable ~= nil then rotatable = this_entity_properties.rotatable end
    end

    local new_entity =
    {
      position = entity.position,
      name = entity.prototype.name,
      direction = entity.direction,
      box = entity.selection_box,
      active = active,
      operable = operable,
      minable = minable,
      destructible = destructible,
      rotatable = rotatable,
      prototype = entity.prototype,
    }
    table.insert(global.compi_build_items_list,new_entity)
  end

  table.sort(global.compi_build_items_list, function (a, b)
    return a.box.left_top.x < b.box.left_top.x
  end)

  global.compi_is_building = true
  global.compi_build_completed_callback = nil
  compi.compi_build_callback()
end


---------------
-- Internals --
---------------

local function find_tele_spot_internal()
  if global.find_tele_spot_data.debug_search_points then
    print("find_tele_spot_internal called")
  end

  -- failure
  if global.find_tele_spot_data.next_radius > global.find_tele_spot_data.max_radius then
    local callback = global.find_tele_spot_data.callback
    global.find_tele_spot_data = nil
    function_save.run(callback, nil)
    return
  end

  if global.find_tele_spot_data.debug_search_points then
     print("searching with radius", global.find_tele_spot_data.next_radius)
  end

  local vector = {x = global.find_tele_spot_data.next_radius, y = 0}
  global.find_tele_spot_data.next_radius = global.find_tele_spot_data.next_radius + global.find_tele_spot_data.radius_step

  local steps = 5
  for i=1,steps do
    local angle = (i / steps) * 360

    local try_position = math2d.position.rotate_vector(vector, angle)

    try_position.x = try_position.x + global.find_tele_spot_data.target_position.x
    try_position.y = try_position.y + global.find_tele_spot_data.target_position.y

    -- make sure we don't teleport to somewhere a player can see us
    local position_ok = true
    local radius_squared = global.find_tele_spot_data.required_player_radius * global.find_tele_spot_data.required_player_radius
    for _,player in pairs(game.players) do
      if math2d.position.distance_squared(try_position, player.position) < radius_squared then
        position_ok = false

        if global.find_tele_spot_data.debug_search_points then
          print(serpent.line(try_position), "too close to a player")
          global.find_tele_spot_data.surface.create_entity
          {
            name = "tutorial-flying-text",
            text = "X",
            color = {r=1, g=0, b=0},
            position = try_position
          }
        end

        break
      end
    end

    if position_ok then
      if global.find_tele_spot_data.debug_search_points then
        print("searching", i, serpent.line(try_position))
      end
      local id = global.find_tele_spot_data.surface.request_path
      {
        bounding_box = global.find_tele_spot_data.entity.prototype.collision_box,
        collision_mask = global.find_tele_spot_data.entity.prototype.collision_mask,
        start = try_position,
        goal = global.find_tele_spot_data.target_position,
        force = global.find_tele_spot_data.entity.force,
        pathfind_flags = { allow_destroy_friendly_entities = global.find_tele_spot_data.allow_destroy_friendly_entities,
                           cache = false,
                           prefer_straight_paths = true }
      }

      global.find_tele_spot_data.points[id] = try_position
    end
  end

  -- If no points were suitable to search, then continue with a larger radius
  local count = 0
  for _ in pairs(global.find_tele_spot_data.points) do count = count + 1 end

  if count == 0 then
    find_tele_spot_internal()
  end
end

local function find_tele_spot(surface, entity, target_position, allow_destroy_friendly_entities, callback)
  if global.find_tele_spot_data then
    error("only one find_tele_spot can be running at a time!")
  end

  global.find_tele_spot_data =
  {
    surface = surface,
    entity = entity,
    target_position = target_position,
    next_radius = 10,
    max_radius = 250, -- maximum distance from the goal
    radius_step = 50,
    required_player_radius = 150, -- how far does the teleport position need to be from any player
    points = {},
    callback = callback,
    result_point = nil,
    debug_search_points = false, -- when true, shows the points searched with a red x flying text entity
    allow_destroy_friendly_entities = allow_destroy_friendly_entities
  }

  find_tele_spot_internal()
end

local function on_entity_died(event)
  if event.cause and
     event.cause == global.compilatron.entity and
     event.entity.force == global.compilatron.entity.force and
     event.entity.prototype.is_building
  then
    event.entity.force = "compi_res_force"
    table.insert(global.compilatron.destroyed_entity_positions, event.entity.position)
  end
  if event.entity == global.compilatron.entity then
    global.compilatron.entity = compi.respawn_compi()
  end
end

local function on_script_path_request_finished(event)
    -- Ignore pathfinds that we didn't request
    if global.find_tele_spot_data == nil or global.find_tele_spot_data.points[event.id] == nil then
      return
    end

    -- We could add handling code for this, but it's not really necessary.
    -- Still, we want to know if it ever becomes an issue.
    if event.try_again_later then
      error "overloading the pathfinder"
    end

    local color

    if event.path then
      if global.find_tele_spot_data.result_point == nil then
        global.find_tele_spot_data.result_point = global.find_tele_spot_data.points[event.id]
      end

      color = {r=0,g=1,b=0}
    else
      color = {r=1,g=0,b=0}
    end

    if global.find_tele_spot_data.debug_search_points then
      print(serpent.line(global.find_tele_spot_data.points[event.id]), "done", event.path ~= nil)
      global.find_tele_spot_data.surface.create_entity
      {
        name = "tutorial-flying-text",
        text = "X",
        color = color,
        position = global.find_tele_spot_data.points[event.id]
      }
    end

     -- success
    if global.find_tele_spot_data.result_point ~= nil then
      local result_point = global.find_tele_spot_data.result_point
      local callback = global.find_tele_spot_data.callback
      global.find_tele_spot_data = nil

      function_save.run(callback, result_point)
      return
    end

    global.find_tele_spot_data.points[event.id] = nil

    local count = 0
    for _ in pairs(global.find_tele_spot_data.points) do count = count + 1 end

    if count == 0 then
      find_tele_spot_internal()
    end
end

teleport_near_and_walk_to_internal = function(self, destination, teleport_on_fail, is_retry)
  if global.compilatron.bubble then global.compilatron.bubble.destroy() end
  -- would be nice to have surface as a parameter, but surface teleporting only works for players atm
  local surface = self.entity.surface

  global.compilatron.teleport_near_and_walk_to_internal_callback_data =
  {
    destination = destination,
    teleport_on_fail = teleport_on_fail,
    is_retry = is_retry
  }

  find_tele_spot(surface, self.entity, destination, is_retry, "teleport_near_and_walk_to_internal_callback")
end

local teleport_near_and_walk_to_internal_callback = function(tele_spot)
  local d = global.compilatron.teleport_near_and_walk_to_internal_callback_data

  -- failed to find a spot to path from, just give up and teleport
  if tele_spot == nil then
    if not d.is_retry then
      teleport_near_and_walk_to_internal(global.compilatron, d.destination, d.teleport_on_fail, true)
    elseif d.teleport_on_fail then
      global.compilatron.entity.teleport(d.destination) --, surface)
    end
    return
  end

  global.compilatron.entity.teleport(tele_spot) --, surface)
  compi.walk_to(d.destination)
end
function_save.add_function("teleport_near_and_walk_to_internal_callback", teleport_near_and_walk_to_internal_callback)

local update = function()
  if global.compilatron.entity then
    -- grab the entity ghosts from stuff we destroyed
    for i=#global.compilatron.destroyed_entity_positions,1,-1 do
      local pos = global.compilatron.destroyed_entity_positions[i]
      local bounding_box = {{pos.x, pos.y}, {pos.x + 0.1, pos.y + 0.1}}
      local ghosts = global.compilatron.entity.surface.find_entities_filtered{type="entity-ghost", area=bounding_box}

      assert(#ghosts == 1)
      table.insert(global.compilatron.destroyed_entity_ghosts, { ghost = ghosts[1], timer = 0})

      table.remove(global.compilatron.destroyed_entity_positions, i)
    end

    -- try to revive any ghosts created by compilatron
    for i=#global.compilatron.destroyed_entity_ghosts,1,-1 do
      if global.compilatron.destroyed_entity_ghosts[i].timer > 60 * 5 then
        local new_entity

        if global.compilatron.destroyed_entity_ghosts[i].ghost.valid then
          _, new_entity = global.compilatron.destroyed_entity_ghosts[i].ghost.revive()
        end

        if new_entity then
          new_entity.force = "player"
          table.remove(global.compilatron.destroyed_entity_ghosts, i)
        else
          -- if we failed to revive, the ghost is probably blocked, just try again later
          global.compilatron.destroyed_entity_ghosts[i].timer = 0
        end
      else
        if not global.compilatron.destroyed_entity_ghosts[i].ghost.valid then
          table.remove(global.compilatron.destroyed_entity_ghosts, i)
        else
          global.compilatron.destroyed_entity_ghosts[i].timer = global.compilatron.destroyed_entity_ghosts[i].timer + 1
        end
      end
    end
  end
end

local walk_to_retry = function(_)
  local d = global.compilatron.walk_to_retry_data
  walk_to_internal(d.destination, d.teleport_on_fail, d.allow_destroy_friendly_entities, true, nil, d.arrived_callback)
end
function_save.add_function("walk_to_retry", walk_to_retry)

walk_to_internal = function(destination,
                            teleport_on_fail,
                            allow_destroy_friendly_entities,
                            is_retry,
                            retry_callback,
                            arrived_callback)
  global.compilatron.moving = true
  -- if compi is already on his way somewhere, let him finish then queue the move for after
  if global.compilatron.walk_to_internal_retry_data and not is_retry then
    global.compilatron.next_destination_data =
    {
      retry_callback = retry_callback,
      arrived_callback = arrived_callback,
      destination = destination,
      teleport_on_fail = teleport_on_fail,
      allow_destroy_friendly_entities = allow_destroy_friendly_entities,
    }
    return
  end

  compi.remove_display()

  global.compilatron.walk_to_internal_retry_data =
  {
    retry_callback = retry_callback,
    arrived_callback = arrived_callback,
    destination = destination,
    teleport_on_fail = teleport_on_fail,
    is_retry = is_retry
  }

  local radius = 0.1
  if is_retry then
    radius = 3 -- 3 is the default if no radius is specified
  end

  local command =
  {
    type = defines.command.go_to_location,
    destination = destination,
    pathfind_flags = { allow_destroy_friendly_entities = allow_destroy_friendly_entities,
                       cache = false,
                       prefer_straight_paths = true },
    distraction = defines.distraction.none,
    radius = radius
  }

  command_callback.set_command(
    global.compilatron.entity,
    command,
    -- If walking fails even though it should have succeeded, then try again,
    -- if that fails, just teleport.
    "walk_to_internal_callback"
  )
end

local walk_to_internal_callback = function (result)

  global.compilatron.entity.set_command
  {
    type = defines.command.stop,
    distraction = defines.distraction.none
  }

  local d = global.compilatron.walk_to_internal_retry_data
  global.compilatron.walk_to_internal_retry_data = nil
  if result ~= defines.behavior_result.success then
    if not d.is_retry then
      function_save.run(d.retry_callback, result)
      return
    elseif d.teleport_on_fail then
      global.compilatron.entity.teleport(d.destination)
    end
  end

  -- arrived

  -- if we were asked to move somewhere while we were on our way to here, then start going to the other place
  if global.compilatron.next_destination_data ~= nil then
    local data = global.compilatron.next_destination_data
    global.compilatron.next_destination_data = nil

    walk_to_internal(data.destination,
                     data.teleport_on_fail,
                     data.allow_destroy_friendly_entities,
                     false,
                     data.retry_callback,
                     data.arrived_callback)
    return
  end

  compi.set_direction(global.compilatron.direction)


  if global.compilatron.wait_text then
    compi.say(global.compilatron.wait_text)
    compi.display(global.compilatron.ghosts_to_display)
    global.compilatron.wait_text = nil
    global.compilatron.ghosts_to_display = {}
  end

  if global.compilatron.future_box then
    compi.indicate(global.compilatron.future_box)
  end
  global.compilatron.moving = false

  if d.arrived_callback then
    function_save.run(d.arrived_callback)
  end
end
command_callback.add_callback("walk_to_internal_callback", walk_to_internal_callback)

compi.set_wait_time_modifier = function(modifier)
  if type(tonumber(modifier))== 'number' and tonumber(modifier) > 0 and tonumber(modifier) < 100 then
    global.compilatron.wait_time_modifier = modifier
    return true
  end
  return false
end

compi.init = function(start_pos)
  game.map_settings.path_finder.max_steps_worked_per_tick = 500

  global.compilatron =
  {
    entity = nil,
    destroyed_entity_positions = {},
    destroyed_entity_ghosts = {},
    behavior = {},
    bubble = nil,
    indicator = nil,
    future_box = nil,
    ghosts_to_display = {},
    displayed_ghosts = {},
    wait_text = nil,
    wait_time_modifier = 1,
    wait_position = start_pos,
    direction = defines.direction.southeast,
    moving = false
  }

  if start_pos then
    global.compilatron.entity = compi.respawn_compi(start_pos)
    assert(global.compilatron.entity.valid)
  end

  local compi_res_force = game.create_force("compi_res_force")
  compi_res_force.ghost_time_to_live = 99999
end

local compi_command = function(data)
  local params = util.split_whitespace(data.parameter)

  local player = game.players[data.player_index]
  if params[1] == 'come' then
    compi.walk_to(player.position)
    compi.say_later("???")
  elseif params[1] == 'wait' then
    compi.walk_to(global.compilatron.wait_position)
  elseif params[1] == 'show' then
    if player.selected then
      compi.stand_next_to(player.selected.selection_box, true, player.selected.name)
    end
  elseif params[1] == 'wait_time' then
    if compi.set_wait_time_modifier(params[2]) then
      player.print("Compilatron wait times are now multiplied by "..params[2])
    else
      player.print("This command requires a number between 0 and 100")
    end
  elseif params[1] == 'goto' then
    local x = tonumber(params[2])
    local y = tonumber(params[3])

    compi.walk_to({x, y})
  end
end
commands.add_command("compi","A series of commands to test Compilatron. Uses include: come, wait", compi_command)

compi.on_load = function()
end

compi.events = {
  [defines.events.on_entity_died] = on_entity_died,
  [defines.events.on_tick] = update,
  [defines.events.on_script_path_request_finished] = on_script_path_request_finished,
}

return compi
