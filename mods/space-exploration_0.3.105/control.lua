require("stdlib/table")
require("stdlib/string")

version = 0003099 -- 0.3.99
local mod_display_name = "Space Exploration"
is_debug_mode = false

Util = require("scripts/util") util = Util
mod_prefix = util.mod_prefix

sha2 = require('scripts/sha2')
Log = require('scripts/log')
Event = require('scripts/event')

Shared = require("shared")
Universe = require("scripts/universe")
RemoteView = require('scripts/remote-view')
Respawn = require('scripts/respawn')
Launchpad = require('scripts/launchpad')
Landingpad = require('scripts/landingpad')
Capsule = require('scripts/capsule')
Zone = require('scripts/zone')
Zonelist = require('scripts/zonelist')
Weapon = require('scripts/weapon')
Spaceship = require('scripts/spaceship')
Coreminer = require('scripts/core-miner')
CondenserTurbine = require('scripts/condenser-turbine')
BigTurbine = require('scripts/big-turbine')
Meteor = require('scripts/meteor')
Beacon = require('scripts/beacon')
Lifesupport = require('scripts/lifesupport')
ShieldProjector = require('scripts/shield-projector')
DeliveryCannon = require('scripts/delivery-cannon')
Composites = require('scripts/composites')

Ancient = require('scripts/ancient')
DAnchor = require('scripts/dimensional-anchor')
Ruin = require('scripts/ruin')

Informatron = require('scripts/informatron')

Migrate = require('scripts/migrate')

--satellite_blueprint = require("scripts/satellite")

space_collision_layer = "layer-14"
spaceship_collision_layer = "layer-15"
sp_tile_plate = mod_prefix.."space-platform-plating"
sp_tile_scaffold = mod_prefix.."space-platform-scaffold"
name_space_tile = mod_prefix.."space"
name_out_of_map_tile = "out-of-map"
space_tiles = {
  name_space_tile
}
name_asteroid_tile = mod_prefix.."asteroid"
--air_tiles = {"air-1", "air-2", "air-3", "air-4"}

name_fluid_rocket_fuel = mod_prefix.."liquid-rocket-fuel"
name_thermofluid_hot = mod_prefix.."space-coolant-hot"
name_thermofluid_supercooled = mod_prefix.."space-coolant-supercooled"
name_suffix_spaced = "-spaced"
name_suffix_grounded = "-grounded"

name_thruster_suits = {
  mod_prefix.."thruster-suit",
  mod_prefix.."thruster-suit-2",
  mod_prefix.."thruster-suit-3",
  mod_prefix.."thruster-suit-4",
}
base_space_thrust = 1
thruster_suit_thrust = {
  [mod_prefix.."thruster-suit"] = 2,
  [mod_prefix.."thruster-suit-2"] = 3,
  [mod_prefix.."thruster-suit-3"] = 4,
  [mod_prefix.."thruster-suit-4"] = 5,
}

starting_item_stacks = {
  {name = mod_prefix.."medpack", count = 1}
}

suffocation_interval = 120

collision_player = mod_prefix.."collision-player"
collision_player_not_space = mod_prefix.."collision-player-not-space"
collision_rocket_destination_surface = mod_prefix.."collision-rocket-destination-surface"
collision_rocket_destination_orbit = mod_prefix.."collision-rocket-destination-orbital"

function get_make_playerdata(player)
  global.playerdata = global.playerdata or {}
  global.playerdata[player.index] = global.playerdata[player.index] or {}
  return global.playerdata[player.index]
end

function player_set_dropdown_values(player, key, values)
   local playerdata = get_make_playerdata(player)
   playerdata.dropdown_values = playerdata.dropdown_values or {}
   playerdata.dropdown_values[key] = values
end

function player_get_dropdown_value(player, key, index)
   local playerdata = get_make_playerdata(player)
   if playerdata.dropdown_values and playerdata.dropdown_values[key] then
     return playerdata.dropdown_values[key][index]
   end
end

function player_clear_dropdown_values(player, key)
   local playerdata = get_make_playerdata(player)
   if playerdata.dropdown_values then playerdata.dropdown_values[key] = nil end
end

function player_clear_all_dropdown_values(player)
   local playerdata = get_make_playerdata(player)
   playerdata.dropdown_values = nil
end

function player_get_character(player)
  if player.character then return player.character end
  local playerdata = get_make_playerdata(player)
  if playerdata.character then
    if playerdata.character.valid then
      return playerdata.character
    else
      playerdata.character = nil
    end
  end
end

-- creation must contain position
-- returns entity, position
function create_non_colliding(surface, creation, radius, precision)
    radius = radius or 32
    precision = precision or 1
    local try_pos = creation.position
    local safe_pos = surface.find_non_colliding_position(creation.name, try_pos, radius, 1)or try_pos
    creation.position = safe_pos
    return surface.create_entity(creation), safe_pos
end

-- returns entity, position
function teleport_non_colliding(entity, position, radius, precision)
  if entity then
    radius = radius or 32
    precision = precision or 1
    local try_pos = position
    local safe_pos = entity.surface.find_non_colliding_position(entity.name, try_pos, radius, 1) or try_pos
    entity.teleport(safe_pos)
    return entity, safe_pos
  end
end

function teleport_non_colliding_player(player, position, surface, radius, precision)
  surface = surface or player.surface
  radius = radius or 32
  precision = precision or 1
  local try_pos = position
  local safe_pos = surface.find_non_colliding_position(player.character.name, try_pos, radius, 1) or try_pos
  player.teleport(safe_pos, surface)
  return player, safe_pos
end

function teleport_character_to_surface(character, surface, position)
  local try_pos = position
  local safe_pos = surface.find_non_colliding_position(character.name, try_pos, 32, 1) or try_pos
  if surface == character.surface then
    -- easy
    character.teleport(safe_pos)
    return character, safe_pos
  end
  local zone = Zone.from_surface(surface)
  if zone then
    Zone.discover(character.force.name, zone)
  end
  if character.player then
    -- use the player to do it
    local player = character.player
    player.teleport(safe_pos, surface) -- surface change breaks character reference
    local playerdata = get_make_playerdata(player)
    playerdata.last_position = nil
    playerdata.set_postition = nil
    playerdata.velocity = nil
    return player.character, safe_pos
  end

  -- attach a player to do it
  for player_index, playerdata in pairs(global.playerdata) do
    local player = game.players[player_index]
    if player and player.connected then
      if RemoteView.is_active(player) and playerdata.character and playerdata.character == character then
        local player_pos = player.position
        local player_surface = player.surface
        player.teleport(playerdata.character.position, playerdata.character.surface)
        player.set_controller{type = defines.controllers.character, character = playerdata.character}
        player.teleport(safe_pos, surface) -- surface change breaks character reference
        playerdata.character = player.character
        player.set_controller{type = defines.controllers.ghost}
        --player.set_controller{type = defines.controllers.spectator}
        player.teleport(player_pos, player_surface)
        playerdata.last_position = nil
        playerdata.set_postition = nil
        playerdata.velocity = nil
        Log.trace("character moved by reassociation")
        return playerdata.character, safe_pos
      end
    end
  end

  -- clone the character and destroy the original
  -- what could possibly go wrong?
  surface.clone_entities{
    entities = {character},
    destination_offset = util.vectors_delta(character.position, safe_pos),
    destination_surface = surface,
    destination_force = character.force,
    snap_to_grid = false
  }
  local candidates = surface.find_entities_filtered{
    type = character.type,
    name = character.name,
    force = character.force
  }
  for _, candidate in pairs(candidates) do
    if candidate.player == nil
      and candidate.color.r == character.color.r
      and candidate.color.g == character.color.g
      and candidate.color.b == character.color.b then
        candidate.teleport(safe_pos)

        for player_index, playerdata in pairs(global.playerdata) do
          if playerdata.character and playerdata.character == character then
            playerdata.character = candidate
          end
        end
        character.destroy()
        Log.trace("character moved by cloning")
        return clone, safe_pos
    end
  end

  Log.trace("character move by cloning but failed")
  -- failed
  return nil, safe_pos
end

function surface_set_area_tiles(data)
  -- data.surface
  -- data.name (tile type)
  -- data.area
  if not (data.surface and data.name and data.area) then return end

  local tiles = {}
  for y = data.area.left_top.y, data.area.right_bottom.y, 1 do
    for x = data.area.left_top.x, data.area.right_bottom.x, 1 do
      table.insert(tiles, {
        name = data.name,
        position = {x = x, y = y}})
    end
  end
  data.surface.set_tiles(tiles, true)
end

function surface_set_space_tiles(data)
  -- data.surface
  -- data.area
  if not (data.surface and data.area) then return end

  local tiles = {}
  for y = data.area.left_top.y, data.area.right_bottom.y, 1 do
    for x = data.area.left_top.x, data.area.right_bottom.x, 1 do
      table.insert(tiles, {
        name = name_space_tile,
        position = {x = x, y = y}})
    end
  end
  data.surface.set_tiles(tiles, true)
end

function position_2d_array_add(array, position)
    if not array[position.y] then array[position.y] = {} end
    if not array[position.y][position.x] then array[position.y][position.x] = position end
end

function position_2d_array_add_range(array, position, range)
    for y = position.y - range, position.y + range, 1 do
      for x = position.x - range, position.x + range, 1 do
            position_2d_array_add(array, {x = x, y = y})
      end
    end
end

function tile_is_space(tile)
    for _, name in pairs(space_tiles) do
      if tile.name == name then return true end
    end
    return false
end

function tile_is_space_platform(tile)
    return tile.name == sp_tile_plate or tile.name == sp_tile_scaffold
end


--[[function on_player_created(event)
    --local player = game.players[event.player_index]
    --TODO: capsule crash sequence
end
Event.addListener(defines.events.on_player_created, on_player_created)]]--

function close_own_guis(player)
  -- NOTE: don't close remote view gui here
  Launchpad.gui_close(player)
  Landingpad.gui_close(player)
  Capsule.gui_close(player)
  Spaceship.gui_close(player)
  DeliveryCannon.gui_close(player)
  --player_clear_all_dropdown_values(player)
end


--[[
  tag: {
    surface_name (optional)
    force_name
    position
    icon_type (item/virtual)
    icon_name
    text
    chart_range (optional)
  }
]]
function chart_tag_buffer_add(tag)
  local surface = tag.surface
  local force_name = tag.force_name
  local force = game.forces[force_name]
  local range = tag.chart_range or Zone.discovery_scan_radius

  force.chart(surface, util.position_to_area(tag.position, range))

  global.chart_tag_buffer = global.chart_tag_buffer or {}
  global.chart_tag_next_id = (global.chart_tag_next_id or 0) + 1
  global.chart_tag_buffer[global.chart_tag_next_id] = tag
end

function process_chart_tag_buffer()
  if global.chart_tag_buffer then
    local tags_remaining = 0
    for _, tag in pairs(global.chart_tag_buffer) do
      local surface = tag.surface
      local force_name = tag.force_name
      local force = game.forces[force_name]
      local chart_tag = force.add_chart_tag(surface, {
        icon = {type = tag.icon_type, name = tag.icon_name},
        position = tag.position,
        text = tag.text
      })
      if chart_tag then
        global.chart_tag_buffer[_] = nil
      else
        tags_remaining = tags_remaining + 1
      end
    end
    if tags_remaining == 0 then
      -- cleanup
      global.chart_tag_buffer = nil
      global.chart_tag_next_id = nil
    end
  end
end


function get_selected_index(array, current)
  local i = 0
  for _, item in ipairs(array) do
    i = i + 1
    if item == current then return i end
  end
end

function get_dropdown_string(element, relevant_value)
  if not relevant_value then relevant_value = 1 end
  if element.selected_index and element.items[element.selected_index] then
    local selected = element.items[element.selected_index]
    if type(selected) == "string" then
      return selected
    elseif type(selected) == "table" and selected[relevant_value] then
      return selected[relevant_value]
    end
  end
end

function selected_name_from_dropdown_preset(element, preset)
  -- options eg:  destination_type_options

  local selected_string = get_dropdown_string(element)
  for _, option in pairs(preset) do
    if type(option.display) == "string" then
      if option.display == selected_string then
        return option.name
      end
    elseif type(option.display) == "table" and option.display[1] == selected_string then
      return option.name
    end
  end
end

function dropdown_from_preset(preset, current)
  -- options eg:  destination_type_options
  local selected_index
  local list = {}
  for _, option in pairs(preset) do
    table.insert(list, option.display)
    if option.name == current then selected_index = #list end
  end
  return list, selected_index
end

function count_inventory_slots_used(inv)
  return #inv - inv.count_empty_stacks()
end

function gui_element_or_parent(element, name)
  if not element then return end
  if element.name == name then
    return element
  elseif element.parent then
    return gui_element_or_parent(element.parent, name)
  end
end

function on_tick_player(player)

  local playerdata = get_make_playerdata(player)

  --on_tick_player_gui(player)

  -- save position
  playerdata.surface_positions = playerdata.surface_positions or {}
  playerdata.surface_positions[player.surface.index] = player.position
end



function on_player_changed_position(event)
  local player = game.players[event.player_index]
  if not player.character then return end
  local playerdata = get_make_playerdata(player)
  local zone = Zone.from_surface(player.surface)
  if zone then
    -- track visited
    if not playerdata.visited_zone then playerdata.visited_zone = {} end
    if not playerdata.visited_zone[zone.index] then playerdata.visited_zone[zone.index] = game.tick end

    if (not playerdata.has_entered_anomaly) and zone.type == "anomaly" and player.character then
      playerdata.has_entered_anomaly = true
      player.print({"space-exploration.galaxy_ship_authenticated"})
      for _, entity in pairs(player.surface.find_entities_filtered{force="ignore"}) do
        entity.force = "friendly"
      end
      player.force.chart(player.surface, util.position_to_area(Ancient.galaxy_ship_default_position, 2))
      player.force.chart_all(player.surface)
    end
    if zone.vault_pyramid_position then
      if not (zone.vault_pyramid and zone.vault_pyramid.valid) then
        -- make the pyramid again.
        Ancient.make_vault_exterior(zone)
      end
      -- check if touching the pyramid
      local x_test = Ancient.pyramid_width/2
      local y_test = Ancient.pyramid_height/2
      local buffer = 1
      if player.position.x < zone.vault_pyramid_position.x + x_test + buffer
        and player.position.x > zone.vault_pyramid_position.x - x_test - buffer
        and player.position.y < zone.vault_pyramid_position.y + y_test + buffer
        and player.position.y > zone.vault_pyramid_position.y - y_test - buffer then
          Ancient.make_vault_interior(zone)
          local vault = global.glyph_vaults[zone.glyph][zone.index]
          local vault_surface = game.surfaces[vault.surface_index]
          player.teleport({0, Ancient.cartouche_path_end-2}, vault_surface)
          local corpses = vault_surface.find_entities_filtered{type="corpse"}
          for _, corpse in pairs(corpses) do corpse.destroy() end
          if not playerdata.first_entered_vault then
            playerdata.first_entered_vault = zone
          end
      end
    end
  else -- no zone
    local vault = Ancient.vault_from_surface(player.surface)
    if vault then
      -- check if on the entrance/exit section
      if player.position.x <=4 and player.position.x >= -4 and player.position.y > Ancient.cartouche_path_end -1 and player.position.y < Ancient.cartouche_path_end +1 then
        local zone = Zone.from_zone_index(vault.zone_index)
        local zone_surface = Zone.get_make_surface(zone)
        local pos = table.deepcopy(zone.vault_pyramid_position) or {x = 0, y = 0}
        pos.y = pos.y + Ancient.pyramid_height/2 + 1
        teleport_character_to_surface(player.character, zone_surface, pos)
      end
    end
  end
end
Event.addListener(defines.events.on_player_changed_position, on_player_changed_position)

function on_trigger_created_entity(event)
  if event.entity and event.entity.valid and event.entity.name == mod_prefix.."trigger-movable-debris" then
    -- meteor and rocket fragments

    local surface = event.entity.surface
    local deconstruct = false
    for force in pairs(game.forces) do
      local networks = surface.find_logistic_networks_by_construction_area(event.entity.position, force)
      if networks and #networks > 0 then
        for _, network in pairs(networks) do
          if network.storages and #network.storages > 1 then
            local entities = surface.find_entities_filtered{position = event.entity.position, type = "simple-entity"}
            for _, entity in pairs(entities) do
              entity.order_deconstruction(force)
              deconstruct = true
            end
          end
        end
      end
    end
    if not deconstruct then
      local tile = surface.get_tile(event.entity.position.x, event.entity.position.y)
      local meteors = surface.find_entities_filtered{ type = "simple-entity", area = Util.position_to_area(event.entity.position, 1) }
      for _, meteor in pairs(meteors) do
        if string.find(meteor.name, "meteor", 1, true) then
          if tile.collides_with("player-layer") then
            meteor.destroy()
          else
            --[[
            local size = math.random() < 0.5 and "crater2-medium" or "crater1-large"
            surface.create_decoratives{
              check_collision = true,
              decoratives={
                {
                  name=size,
                  position = event.entity.position,
                  amount = 1
                }
              }
            }
            ]]--
          end
        end
      end
    end
  end
end
Event.addListener(defines.events.on_trigger_created_entity, on_trigger_created_entity)

function cancel_entity_creation(entity, player_index, message)
  -- put an item back in the inventory or drop to ground
  -- display flying text
  local player
  if player_index then
    player = game.players[player_index]
  end
  local inserted = 0
  local item_to_place = entity.prototype.items_to_place_this[1]
  local surface = entity.surface
  local position = entity.position
  if player then
    if player.mine_entity(entity, false) then
      inserted = 1
    elseif item_to_place and item_to_place.name then
      inserted = player.insert{name = item_to_place.name, count = 1}
    end
  end
  if inserted == 0 and item_to_place and item_to_place.name then
   surface.create_entity{
      name = "item-on-ground",
      position = position,
      stack = {name = item_to_place.name, count = 1}
    }
  end
  surface.create_entity{
     name = "flying-text",
     position = position,
     text = message,
     render_player_index = player_index,
  }
  if entity and entity.valid then
    entity.destroy()
  end
end

function cancel_tile_placement(surface, tile, old_tiles, player_index, message)
  -- put an item back in the inventory or drop to ground
  -- display flying text
  local player
  if player_index then
    player = game.players[player_index]
    if player.controller_type == defines.controllers.editor then
      -- tile placement could be allowed for testing but it will create errors further down the line so this should not be enabled.
      -- e.g:
        -- space platform on a spaceship surface will break cause errors.
        -- water and/or land in space will cause entity problems.
        -- space surfaces on planets will cause entity problems and maybe errors.
    end
  end
  local set_tiles = {}
  for i, old_tile in pairs(old_tiles) do
    if tile.items_to_place_this and tile.items_to_place_this[1] then
      local inserted = 0
      if player then
        inserted = player.insert{name = tile.items_to_place_this[1].name, count = 1}
      end
      if inserted == 0 then
       surface.create_entity{
          name = "item-on-ground",
          position = old_tile.position,
          --["item-entity"] = {name = tile.items_to_place_this[1].name, count = 1}
          stack = {name = tile.items_to_place_this[1].name, count = 1}
        }
      end
    end
    if i == 1 then
      surface.create_entity{
         name = "flying-text",
         position = old_tile.position,
         text = message,
         render_player_index = player_index,
       }
     end
     local hidden = surface.get_hidden_tile(old_tile.position)
    table.insert(set_tiles, {name = hidden or old_tile.old_tile.name, position = old_tile.position})
  end
  surface.set_tiles(set_tiles)

end

function swap_structure(entity, prototype_name)
  local surface = entity.surface
  local recipe = entity.get_recipe()
  local clone = surface.create_entity{
    name = prototype_name,
    position = entity.position,
    force = entity.force,
    direction = entity.direction,
    recipe = recipe and recipe.name
  }
  clone.operable = entity.operable
  clone.active = entity.active
  clone.destructible = entity.destructible
  clone.rotatable = entity.rotatable
  local inventories = {}
  for _, inv_type in pairs({
    defines.inventory.fuel,
    defines.inventory.burnt_result,
    defines.inventory.furnace_source,
    defines.inventory.furnace_result,
    defines.inventory.furnace_modules,
    defines.inventory.assembling_machine_input,
    defines.inventory.assembling_machine_output,
    defines.inventory.assembling_machine_modules
  }) do
    inventories[inv_type] = inv_type -- no duplicate indexes
  end
  for _, inv_type in pairs(inventories) do
    local inv_a = entity.get_inventory(inv_type)
    local inv_b = clone.get_inventory(inv_type)
    if inv_a and inv_b then
      util.move_inventory_items(inv_a, inv_b)
    end
  end
  entity.destroy()
  return clone
end

function on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if (not entity) or entity.type == "entity-ghost" or entity.type == "tile-ghost" then return end

  local zone = Zone.from_surface(entity.surface)
  if zone and Zone.is_space(zone) then
    if entity.type == "car" and not string.find(entity.name, mod_prefix.."space", 1, true) then
      return cancel_entity_creation(entity, event.player_index, {"space-exploration.construction-denied-vehicle-in-space"})
    end
    if game.entity_prototypes[entity.name..name_suffix_spaced] then
      -- replace with spaced
      return swap_structure(entity, entity.name..name_suffix_spaced)
    end
    if string.find(entity.name, name_suffix_grounded, 1, true) then
      -- replace with non-grounded
      return swap_structure(entity, util.replace(entity.name, name_suffix_grounded, ""))
    end
    if entity.type == "offshore-pump" then
      return cancel_entity_creation(entity, event.player_index, {"space-exploration.construction-denied"})
    end
  else -- not space
    if string.find(entity.name, name_suffix_spaced, 1, true) then
      -- replace with non-spaced
      return swap_structure(entity, util.replace(entity.name, name_suffix_spaced, ""))
    end
    if game.entity_prototypes[entity.name..name_suffix_grounded] then
      -- replace with grounded
      return swap_structure(entity, entity.name..name_suffix_grounded)
    end
    if zone and entity.type == "offshore-pump" and zone.tags and util.table_contains(zone.tags, "water_none") then
      if entity.prototype.fluid == "water" then -- there is no water on this planet, send via rocket, cannon, or ship
        return cancel_entity_creation(entity, event.player_index, {"space-exploration.construction-denied-no-water"})
      end
    end
  end
end
Event.addListener(defines.events.on_robot_built_entity, on_entity_created)
Event.addListener(defines.events.on_built_entity, on_entity_created)
Event.addListener(defines.events.script_raised_built, on_entity_created)
Event.addListener(defines.events.script_raised_revive, on_entity_created)

function on_built_tile(event)
  if not event.surface_index then return end
  local surface = game.surfaces[event.surface_index]
  if not surface then return end
  local player
  local tile = event.tile
  local old_tiles = event.tiles
  local stack = event.stack -- used to create, may be empty
  if tile_is_space_platform(tile) then
    local zone = Zone.from_surface(surface)
    if (not zone) or not (
      zone.type == "orbit" or
      zone.type == "asteroid-belt" or
      zone.type == "asteroid-field" or
      zone.type == "anomaly") then
        -- should not be here
        cancel_tile_placement(surface, tile, old_tiles, event.player_index, {"space-exploration.construction-denied"})
    end
  elseif string.find(tile.name, "water", 1, true) then
    local zone = Zone.from_surface(surface)
    if zone and (Zone.is_space(zone) or (zone.tags and (util.table_contains(zone.tags, "water_none")))) then
      -- should not be here
      cancel_tile_placement(surface, tile, old_tiles, event.player_index, {"space-exploration.construction-denied-no-water"})
    end
  end
end
Event.addListener(defines.events.on_player_built_tile, on_built_tile)
Event.addListener(defines.events.on_robot_built_tile, on_built_tile)



function on_tick()

  process_chart_tag_buffer()

  for _, player in pairs(game.connected_players) do
    on_tick_player(player)
  end

  for _, tick_task in pairs(global.tick_tasks) do
    if tick_task.type == "chain-beam" then
      Weapon.chain_beam(tick_task)
    elseif tick_task.type == "plague-tick" then
      Weapon.plague_tick(tick_task)
    elseif tick_task.type == "cryogun-unfreeze" then
      Weapon.cryogun_unfreeze(tick_task)
    elseif tick_task.type == "bind-corpse" then
      Respawn.tick_task_bind_corpse(tick_task)
    elseif tick_task.type == "launchpad-journey" then
      Launchpad.tick_journey(tick_task)
    elseif tick_task.type == "force-message" then
      if (not tick_task.delay_until) or game.tick >= tick_task.delay_until then
        if tick_task.force_name then
          local force = game.forces[tick_task.force_name]
          if force then
            force.print(tick_task.message)
          end
        end
        tick_task.valid = false
      end
    else
      tick_task.valid = false
    end
    if not tick_task.valid then
      global.tick_tasks[tick_task.id] = nil
    end
  end

end
Event.addListener(defines.events.on_tick, on_tick)

function new_tick_task(type)
  global.next_tick_task_id = global.next_tick_task_id or 1
  local new_tick_task = {
    id = global.next_tick_task_id,
    valid = true,
    type = type
  }
  global.tick_tasks[new_tick_task.id] = new_tick_task
  global.next_tick_task_id = global.next_tick_task_id + 1
  return new_tick_task
end

function on_entity_damaged (event)
  if event.entity and event.entity.valid and event.entity.name ~= ShieldProjector.name_barrier then
    if event.entity.health < 0 and event.entity.active == false then
      event.entity.destroy()
    end
  end
end
Event.addListener(defines.events.on_entity_damaged, on_entity_damaged)

function build_satellite(force_name)
  Log.debug_log("build_satellite: " .. force_name)
  local home_zone = Zone.get_force_home_zone(force_name)
  if not home_zone then home_zone = Zone.get_default() end
  local zone = home_zone.orbit
  local surface = Zone.get_make_surface(zone)
  local satellite_position = Zone.find_zone_landing_position(zone, {
    x = (-0.5+math.random()) * 256,
    y = (-0.5+math.random()) * 64})

  surface.request_to_generate_chunks(satellite_position, 2)
  surface.force_generate_chunk_requests() -- must be generated to place

  Ruin.build({
    ruin_name = "satellite",
    surface_index = surface.index,
    position = satellite_position,
    force_name_override = force_name
  })
  local range = Zone.discovery_scan_radius
  game.forces[force_name].chart(surface, {
      {satellite_position.x - range, satellite_position.y - range},
      {satellite_position.x + range, satellite_position.y + range}
  })
  game.forces[force_name].print({"space-exploration.satellite-discovered-platform", zone.name})
  chart_tag_buffer_add({
    force_name = force_name,
    surface = Zone.get_make_surface(zone),
    position = satellite_position,
    icon_type = "item",
    icon_name = "satellite",
    text = "Space Platform",
    chart_range = Zone.discovery_scan_radius,
  })
  global.forces[force_name].nauvis_satellite = satellite_position
end


function on_satellite_launched(force_name, surface)
  Log.debug_log("on_satellite_launched: " .. force_name)
  local starting_zone = Zone.from_surface(surface)
  if not starting_zone then
    return game.forces[force_name].print("Satellite error: Invalid launch location.")
  end
  global.forces[force_name] = global.forces[force_name] or {}
  global.forces[force_name].satellites_launched = (global.forces[force_name].satellites_launched or 0) + 1

  -- discovery options are:
    -- discover the satellite (always on 1st launch) either in orbit or deadsapce
    -- discover a planet or moon (always on 1st - 5rd launches), 90% chance after
    -- if nothing else discovered, discover an asteroid in deadpsace

  local dicovered_something = false
  if global.forces[force_name].satellites_launched == 1 then
    -- nauvis satellite station

    build_satellite(force_name)
    Zone.discover_next_satellite(force_name, "The Satellite", starting_zone)
    dicovered_something = true
    game.forces[force_name].print({"space-exploration.satellite-view-unlocked"})
  --elseif global.forces[force_name].satellites_launched < 6
  --    or math.random() < 0.9 then
  else
    dicovered_something = Zone.discover_next_satellite(force_name, "Satellite", starting_zone)
    if not dicovered_something then
      game.forces[force_name].print({"space-exploration.satellite-discovered-nothing"})
    end
  end

end

function on_rocket_launched(event)
  Log.debug_log("on_rocket_launched")
	game.set_game_state{game_finished=false, player_won=false, can_continue=true}
  if event.rocket and event.rocket.valid then
    if event.rocket.get_item_count("satellite") > 0 then
      on_satellite_launched(event.rocket.force.name, event.rocket.surface)
    end
  end
end
Event.addListener(defines.events.on_rocket_launched, on_rocket_launched)

function setup_force(force)
  if force.name == "enemy" or force.name == "neutral" or force.name == "capture" then return end

  local force_name = force.name
  Log.debug_log("setup_force: "..force_name)
  global.forces = global.forces or {}
  global.forces[force_name] = {
    force_name = force_name,
    zones_discovered_count = 0, -- planets and moons discovered
    zones_discovered = {}, -- name = ForceZoneData{discovered_at = tick discovered, marker = map marker}
    satellites_launched = 0,
    cargo_rockets_launched = 0,
    cargo_rockets_crashed = 0,
    zone_assets = {}, -- zone_index > (rocket_launch_pad_names/ rocket_landing_pad_names)
    zone_priorities = {}
  }
  local homeworld = Zone.from_name("Nauvis")
  global.forces[force_name].homeworld_index = homeworld.index
  Zone.discover(force_name, homeworld)
  Zone.discover(force_name, homeworld.parent)
  for _, zone in pairs(global.zone_index) do
    if zone.is_homeworld then
      global.forces[force_name].zone_priorities[zone.index] = global.forces[force_name].zone_priorities[zone.index] or 1
    end
  end

  local friendly = game.forces["friendly"]
  if friendly then
    friendly.set_friend(force, true)
    force.set_friend(friendly, true)
  end

  local ignore = game.forces["ignore"]
  if ignore then
    ignore.set_cease_fire(force, true)
    force.set_cease_fire(ignore, true)
  end

  local ignore = game.forces["capture"]
  if ignore then
    ignore.set_cease_fire(force, true)
    force.set_cease_fire(ignore, true)
  end
end

--/c remote.call("space-exploration", "set_force_homeworld", {zone_name = "Arendel", force_name = "player-2", spawn_position = {x = 0, y = 0}, reset_discoveries = true})
function set_force_homeworld(data)
  local zone = Zone.from_name(data.zone_name)
  if not zone then return game.print("No zone found") end
  if not zone.is_homeworld then return game.print("Zone must be a homeworld") end

  local force = game.forces[data.force_name]
  if not force  then return game.print("No force found") end

  local force_data = global.forces[data.force_name]
  if not force_data  then return game.print("No force data found") end

  force_data.homeworld_index = zone.index
  Zone.get_make_surface(zone) -- make sure the surface exists
  force.set_spawn_position(data.spawn_position or {x = 0, y = 0}, zone.surface_index)

  if data.reset_discoveries then
    force_reset_discoveries(data.force_name)
  end
end

function force_reset_discoveries(force_name)
  local force_data = global.forces[force_name]
  if not force_data then return end
  game.print("reset discoeries for force: " .. force_name)
  force_data.zones_discovered_count = 0
  force_data.zones_discovered = {}
  force_data.satellites_launched = 0
  force_data.zone_priorities = {}
  local homeworld = Zone.from_name("Nauvis")
  if force_data.homeworld_index then
    homeworld = Zone.from_zone_index(force_data.homeworld_index)
  end
  Zone.discover(force_name, homeworld)
  Zone.discover(force_name, homeworld.parent)
  for _, zone in pairs(global.zone_index) do
    if zone.is_homeworld then
      global.forces[force_name].zone_priorities[zone.index] = global.forces[force_name].zone_priorities[zone.index] or 1
    end
  end
end

function setup_util_forces()

  if not game.forces["friendly"] then
    game.create_force("friendly") -- acts like a player entity, displays power icons, can be deconstructured by player
  end
  local friendly = game.forces["friendly"]
  for _, force in pairs(game.forces) do
    friendly.set_friend(force, true)
    force.set_friend(friendly, true)
  end

  if not game.forces["ignore"] then
    game.create_force("ignore") -- won't shoot at the player, does not show icons, cannot be deconstructed.
  end
  local ignore = game.forces["ignore"]
  for _, force in pairs(game.forces) do
    ignore.set_cease_fire(force, true)
    force.set_cease_fire(ignore, true)
  end

  if not game.forces["capture"] then
    game.create_force("capture") -- won't shoot at the player, does not show icons, cannot be deconstructed. Can be cpatured (TODO)
  end
  local ignore = game.forces["capture"]
  for _, force in pairs(game.forces) do
    ignore.set_cease_fire(force, true)
    force.set_cease_fire(ignore, true)
  end

end

function on_force_created(event)
  setup_force(event.force)
end
Event.addListener(defines.events.on_force_created, on_force_created)

function on_runtime_mod_setting_changed()
  if global.next_meteor_shower and
    global.next_meteor_shower > game.tick + 60 * 60 * settings.global["se-meteor-interval"].value then
    global.next_meteor_shower = game.tick + math.random() * 60 * 60 * settings.global["se-meteor-interval"].value
  end
end
Event.addListener(defines.events.on_runtime_mod_setting_changed, on_runtime_mod_setting_changed)

function on_configuration_changed()

  Migrate.migrations()

  local zone = Zone.from_name("Nauvis")
  zone.fragment_name = "se-core-fragment-omni"
  zone.surface_index = 1
  zone.inflated = true

  if global.astronomical then
    global.universe = global.astronomical
    global.astronomical = nil
  end

  global.tick_tasks = global.tick_tasks or {}

  if global.forces then
    for force_name in pairs(global.forces) do
      global.forces[force_name].force_name = force_name
    end
  end

  for _, force in pairs(game.forces) do
    force.reset_recipes()
    if force.technologies["radar"] then
      force.technologies["radar"].enabled = true
    end
  end

  -- enable any recipes that should be unlocked.
  -- mainly required for entity-update-externals as a migration file won't work
  for _, force in pairs(game.forces) do
    for _, tech in pairs(force.technologies) do
      if tech.researched then
        for _, effect in pairs(tech.effects) do
          if effect.type == "unlock-recipe" and force.recipes[effect.recipe] then
            force.recipes[effect.recipe].enabled = true
          end
        end
      end
    end
  end

  -- stop game from ending on launch and tracking of launches
  local interface_name = "silo_script"
  if remote.interfaces[interface_name] then
    if remote.interfaces[interface_name]["set_finish_on_launch"] then
      remote.call(interface_name, "set_finish_on_launch", false)
    end
    if remote.interfaces[interface_name]["set_show_launched_without_satellite"] then
      remote.call(interface_name, "set_show_launched_without_satellite", false)
    end
    if remote.interfaces[interface_name]["remove_tracked_item"] then
      remote.call(interface_name, "remove_tracked_item", "satellite")
    end
  end

  if global.next_meteor_shower and
    global.next_meteor_shower > game.tick + 60 * 60 * settings.global["se-meteor-interval"].value then
    global.next_meteor_shower = game.tick + math.random() * 60 * 60 * settings.global["se-meteor-interval"].value
  end

  Universe.load_resource_data()

  local zone = Zone.from_name("Nauvis")
  zone.fragment_name = "se-core-fragment-omni"
  zone.surface_index = 1
  zone.inflated = true
  zone.resources = {}
  zone.ticks_per_day = 25000

  Coreminer.equalise_all()

  global.cache_travel_delta_v = nil

  game.print({"space-exploration.please-consider-patreon"})

end
Event.addListener("on_configuration_changed", on_configuration_changed, true)


function on_init()
  -- When creating a new game, script.on_init() will be called on each mod that has a control.lua file.
  -- When loading a save game and the mod did not exist in that save game script.on_init() is called.

    global.version = version

    -- Astronomical first
    global.seed = game.surfaces[1].map_gen_settings.seed
    global.next_tick_task_id = 1
    global.tick_tasks = {}

    setup_util_forces()

    Universe.build()

    local zone = Zone.from_name("Nauvis")
    zone.fragment_name = "se-core-fragment-omni"
    zone.surface_index = 1
    zone.inflated = true
    zone.resources = {}
    zone.ticks_per_day = 25000
    game.surfaces[1].solar_power_multiplier = Zone.solar_multiplier
    Zone.set_solar_and_daytime(zone)
    local surface = game.surfaces[1]
    for resource_name, resource_setting in pairs(global.resources_and_controls.resource_settings) do
      surface.regenerate_entity(resource_name)
    end

    global.zones_by_surface[zone.surface_index] = zone
    if game.surfaces[1].map_gen_settings.autoplace_controls["planet-size"] then
      -- planet_radius = 10000 / 6 * (6 + log(1/planet_frequency/6, 2))
      -- planet_frequency = 1 / 6 / 2 ^ (planet_radius * 6 / 10000 - 6)
      --zone.radius = 10000 / 6 * game.surfaces[1].map_gen_settings.autoplace_controls["planet-size"].frequency
      zone.radius = 10000 / 6 * (6 + util.math_log(1/game.surfaces[1].map_gen_settings.autoplace_controls["planet-size"].frequency/6, 2))
      Log.trace(zone.radius)
    else
      zone.radius = 10000 / 6
    end

    if Log.debug_big_logs then
      Log.log_universe_simplified()
      Log.log_universe()
    end

    -- Other stuff second
    global.playerdata = global.playerdata or {}
    global.forces = global.forces or {}

    for _, force in pairs(game.forces) do
        setup_force(force)
        force.reset_recipes()

        -- enable any recipes that should be unlocked.
        -- mainly required for entity-update-externals as a migration file won't work
        for _, tech in pairs(force.technologies) do
          if tech.researched then
            for _, effect in pairs(tech.effects) do
              if effect.type == "unlock-recipe" and force.recipes[effect.recipe] then
                force.recipes[effect.recipe].enabled = true
              end
            end
          end
        end

        for tech in pairs(force.technologies['rocket-silo'].prerequisites) do
          force.technologies[tech].enabled = true
        end
    end

end
Event.addListener("on_init", on_init, true)

function on_player_spawned(event)
  local player = game.players[event.player_index]
  if player and player.character then
    for _, item_stack in pairs(starting_item_stacks) do
      player.insert(item_stack)
    end
  end
end
Event.addListener(defines.events.on_player_respawned, on_player_spawned)

function on_player_created(event)
  local player = game.players[event.player_index]
  if player and player.connected then
    player.print({"space-exploration.please-consider-patreon"})
  end
  on_player_spawned(event)
end
Event.addListener(defines.events.on_player_created, on_player_created)


require('scripts/remote-interface')

--log( serpent.block( data.raw["projectile"], {comment = false, numformat = '%1.8g' } ) )
-- /c Log.trace(serpent.block( game.surfaces.nauvis.map_gen_settings.autoplace_controls, {comment = false, numformat = '%1.8g' }))
