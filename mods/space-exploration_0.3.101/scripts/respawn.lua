local Respawn = {}

-- constants
Respawn.name_gui = mod_prefix.."respawn-gui"
Respawn.name_shortcut = mod_prefix.."respawn"
Respawn.name_event = mod_prefix.."respawn"
Respawn.keep_percent = 0.9
Respawn.corpse_inventory_size_buffer = 100
Respawn.non_colliding_search_radius = 128

function Respawn.at(player, surface, position)
  position = position or player.force.get_spawn_position(surface) or {0,0}
  player.teleport(position, surface)

  local character = surface.create_entity{name = "character", position=position, force=player.force}
  local playerdata = get_make_playerdata(player)
  Respawn.set_data(playerdata, character)
  player.set_controller{type = defines.controllers.character, character = character}
  teleport_non_colliding_player(player, position)
  Respawn.close_gui(player)
  RemoteView.stop(player)
  --script.raise_event(defines.events.on_player_respawned, {player_index=player.index}) -- crashes in 0.18.27
  on_player_spawned({player_index=player.index})
end

function Respawn.at_zone(player, zone, position)
  Respawn.at(player, Zone.get_make_surface(zone), position)
end

function Respawn.at_landing_pad(player, landing_pad)
  if not landing_pad.container and landing_pad.container.valid then
    Respawn.open_gui (player)
    return
  end
  local position = landing_pad.container.position or {0,0}
  local surface = landing_pad.container.surface
  Respawn.at(player, surface, position)
end

function Respawn.at_spaceship(player, spaceship)
  local position = {0,0}
  local surface = game.surfaces[1]
  if spaceship.console and spaceship.console.valid then
    position = spaceship.console.position
    surface = spaceship.console.surface
  elseif spaceship.own_surface_index then
    surface = Spaceship.get_own_surface(spaceship)
    if spaceship.known_bounds then
      position = {
        x = (spaceship.known_bounds.left_top.x + spaceship.known_bounds.right_bottom.x) / 2,
        y = (spaceship.known_bounds.left_top.y + spaceship.known_bounds.right_bottom.y) / 2
      }
    end
  end
  Respawn.at(player, surface, position)
end


function Respawn.get_options(force)
  local home_zone
  if global.forces[force.name] and global.forces[force.name].homeworld_index then
    home_zone = Zone.from_zone_index(global.forces[force.name].homeworld_index)
  end
  if not home_zone then home_zone = Zone.from_name("Nauvis") end
  local options = {
    default = home_zone,
    rocket_landing_pads = {},
    spaceships = {}
  }
  if global.spaceships then
    for _, spaceship in pairs(global.spaceships) do
      if spaceship.force_name == force.name then
        table.insert(options.spaceships, spaceship)
      end
    end
  end
  if global.rocket_landing_pads then
    for _, rocket_landing_pad in pairs(global.rocket_landing_pads) do
      if rocket_landing_pad.force_name == force.name then
        if rocket_landing_pad.container and rocket_landing_pad.container.valid then
          table.insert(options.rocket_landing_pads, rocket_landing_pad)
        else
          Landingpad.destroy(rocket_landing_pad)
        end
      end
    end
  end
  return options
end



function Respawn.on_gui_click(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  root = gui_element_or_parent(element, Respawn.name_gui)
  if not root then return end

  local options = Respawn.get_options(player.force)
  if element.name == "spaceship" and #options.spaceships > 0 then
    Respawn.at_spaceship(player, options.spaceships[math.random(#options.spaceships)])
  elseif element.name == "rocket-landing-pad" and #options.rocket_landing_pads > 0 then
    Respawn.at_landing_pad(player, options.rocket_landing_pads[math.random(#options.rocket_landing_pads)])
  else
    Respawn.at_zone(player, options.default)
  end
end
Event.addListener(defines.events.on_gui_click, Respawn.on_gui_click)

function Respawn.close_gui (player)
  if player.character and player.gui.center[Respawn.name_gui] then
    player.gui.center[Respawn.name_gui].destroy()
  end
end

function Respawn.open_gui (player)
  local gui = player.gui.center
  gui.clear()
  local options = Respawn.get_options(player.force)
  local root = gui.add{ type = "frame", name = Respawn.name_gui, direction="vertical", caption={"space-exploration.respawn-options-title"}}
  flow = root.add{ type="flow", name="respawn_options", direction="vertical"}
  --flow.add{ type = "sprite-button", sprite = "virtual-signal/"..mod_prefix.."planet", name = "planet"}
  flow.add{ type = "button", caption = {"space-exploration.respawn-button-homeworld"}, name = "planet"}
  if #options.rocket_landing_pads > 0 then
    --flow.add{ type = "sprite-button", sprite = "item/"..mod_prefix.."rocket-landing-pad", name = "rocket-landing-pad"}
    flow.add{ type = "button", caption = {"space-exploration.respawn-button-landing-pad"}, name = "rocket-landing-pad"}
  end
  if #options.spaceships > 0 then
    --flow.add{ type = "sprite-button", sprite = "virtual-signal/"..mod_prefix.."spaceship", name = "spaceship"}
    flow.add{ type = "button", caption = {"space-exploration.respawn-button-spaceship"}, name = "spaceship"}
  end
end

function Respawn.set_data(playerdata, character)

  local slot_count = playerdata.character_logistic_slot_count
  if slot_count then
    character.character_logistic_slot_count = playerdata.character_logistic_slot_count
    if playerdata.personal_logistic_slots then
      for i, slot in pairs(playerdata.personal_logistic_slots) do
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
          character.set_personal_logistic_slot(i, slot)
        end
      end
    end
  end

  if playerdata.character_personal_logistic_requests_enabled ~= nil then
    character.character_personal_logistic_requests_enabled = playerdata.character_personal_logistic_requests_enabled
  end

  if playerdata.inventory_filters then
    local inventory = character.get_main_inventory()
    for slot, string in pairs(playerdata.inventory_filters) do
      if string and slot <= #inventory and game.item_prototypes[string] then
        inventory.set_filter(slot, string)
      end
    end
  end
end

function Respawn.record_data(playerdata, character)
  playerdata.inventory_filters = {}
  playerdata.character_logistic_slot_count = 0
  playerdata.personal_logistic_slots = {}
  playerdata.character_personal_logistic_requests_enabled = nil

  if not character and character.valid then return end

  playerdata.character_logistic_slot_count = character.character_logistic_slot_count
  for i = 1, playerdata.character_logistic_slot_count do
    playerdata.personal_logistic_slots[i] = character.get_personal_logistic_slot(i)
  end

  playerdata.character_personal_logistic_requests_enabled= character.character_personal_logistic_requests_enabled

  local inventory = character.get_main_inventory()
  for i = 1, #inventory do
    playerdata.inventory_filters[i] = inventory.get_filter(i)
  end
end

function Respawn.tick_task_bind_corpse (tick_task)
  tick_task.valid = false
  local corpse = tick_task.corpse_surface.find_entity("character-corpse", tick_task.corpse_position)
  if corpse and corpse.valid then
    corpse.character_corpse_player_index = tick_task.player_index
  end
end

function Respawn.mark_corpse (player, character)
  player.force.add_chart_tag(character.surface, {
    icon = {type = "virtual", name = mod_prefix .. "character-corpse"},
    position = character.position,
    text = player.name
  })
  local tick_task = new_tick_task("bind-corpse")
  tick_task.corpse_position = character.position
  tick_task.corpse_surface = character.surface
  tick_task.player_index = player.index

end

function Respawn.respawn (player)

  close_own_guis(player)

  local playerdata = get_make_playerdata(player)
  if player.character then
    Respawn.mark_corpse(player, player.character)
    Respawn.record_data(playerdata, player.character)
  end
  playerdata.character = nil
  player.set_controller{type = defines.controllers.spectator}

  if playerdata.lock_respawn then
    if playerdata.lock_respawn.surface_name and game.surfaces[playerdata.lock_respawn.surface_name] then
      Respawn.at(player, game.surfaces[playerdata.lock_respawn.surface_name], playerdata.lock_respawn.position)
    end
    if playerdata.lock_respawn.zone_index then
      local zone = Zone.from_zone_index(playerdata.lock_respawn.zone_index)
      Respawn.at(player, Zone.get_make_surface(zone), playerdata.lock_respawn.position)
    end
    return
  end

  local options = Respawn.get_options(player.force)
  --if #options.rocket_landing_pads > 0 or #options.spaceships > 0 then
    Respawn.open_gui (player)
  --else
  --  Respawn.at_zone(player, options.default)
  --end
end

function Respawn.die (player)

  RemoteView.stop(player)
  Spaceship.stop_anchor_scouting(player)

  if player.character then
    player.character.die()
  else -- skip ahead
    local playerdata = get_make_playerdata(player)
    if playerdata.character and playerdata.character.valid then
      Respawn.record_data(playerdata, character)
      playerdata.character.die()
      game.print({"space-exploration.player-died", player.name or ("Player " .. player.index)})
    end
    Respawn.respawn(player)
  end

  if player and player.connected then
    player.print({"space-exploration.please-consider-patreon"})
  end
end

function Respawn.on_pre_player_died (event)
  local player = game.players[event.player_index]
  if player then
    RemoteView.stop(player)
    Spaceship.stop_anchor_scouting(player)
    Respawn.respawn(player)
    if player and player.connected then
      player.print({"space-exploration.please-consider-patreon"})
    end
    --[[
    local surface = player.character.surface
    player.character.health = player.character.prototype.max_health
    local main_inv = player.get_main_inventory()
    local corpse = surface.create_entity{
      name = player.character.prototype.character_corpse.name,
      position = player.position,
      force = player.force,
      player_index = player.index,
      inventory_size = #main_inv + Respawn.corpse_inventory_size_buffer
    }
    --corpse.expires = false -- errors
    corpse.character_corpse_player_index = player.index
    corpse.character_corpse_tick_of_death = game.tick
    for _, inv_type in pairs({
        defines.inventory.character_main,
        defines.inventory.character_guns,
        defines.inventory.character_ammo,
        defines.inventory.character_armor,
        defines.inventory.character_trash,
      }) do
      local inv = player.get_inventory(inv_type)
      if inv then
        local contents = inv.get_contents()
        for item_type, item_count in pairs(contents) do
            if inv_type == defines.inventory.character_armor then -- never lose this
              corpse.insert({name=item_type, count=item_count})
            elseif item_count > 1 then
              corpse.insert({name=item_type, count=math.ceil(item_count * Respawn.keep_percent) })
            elseif math.random() < Respawn.keep_percent then
              corpse.insert({name=item_type, count=item_count})
            end
        end
        inv.clear()
      end
    end
    game.print({"space-exploration.player-died", player.name or ("Player " .. player.index)})
    local nauvis = game.surfaces[1]
    player.teleport(nauvis.find_non_colliding_position(player.character.name, {x=0,y=0}, Respawn.non_colliding_search_radius, 1), nauvis)
    ]]--
  end
end
Event.addListener(defines.events.on_pre_player_died, Respawn.on_pre_player_died)


function Respawn.on_entity_died (event)
  -- Called when an entity dies.
  -- entity :: LuaEntity
  -- cause :: LuaEntity (optional): The entity that did the killing if available.
  -- loot :: LuaInventory: The loot generated by this entity if any.
  -- force :: LuaForce (optional): The force that did the killing if any.
  if not (event.entity and event.entity.valid) then return end
  if event.entity.type == "character" then
    local character = event.entity
    if not character.player then
      for player_index, playerdata in pairs(global.playerdata) do
        if playerdata.character == character then
          local player = game.players[player_index]
          if player and player.connected then
            -- player's character died
            RemoteView.stop(player)
            Spaceship.stop_anchor_scouting(player)

            Respawn.record_data(playerdata, character)
            game.print({"space-exploration.player-died", player.name or ("Player " .. player.index)})
            Respawn.respawn(player) -- adds marker
          end
          return
        end
      end
    end
  end
end
Event.addListener(defines.events.on_entity_died, Respawn.on_entity_died)

function Respawn.on_corpse_removed (corpse)

  for _, force in pairs(game.forces) do
    local tags = force.find_chart_tags(corpse.surface, Util.position_to_area( corpse.position, 1))
    for _, tag in pairs(tags) do
      if tag.icon and tag.icon.name == mod_prefix .. "character-corpse" then
        -- TODO: check that corpse matches the marker.
        -- will need to have the corpse know the player first.
        tag.destroy()
      end
    end
  end

end

function Respawn.on_character_corpse_expired (event)
  -- event.corpse LuaEntity
  -- Note: this is not called if the corpse is mined. See defines.events.on_pre_player_mined_item to detect that.
  -- remove corpse marker
  if not(event.corpse and event.corpse.valid) then return end
  Respawn.on_corpse_removed (event.corpse)

end
Event.addListener(defines.events.on_character_corpse_expired, Respawn.on_character_corpse_expired)

function Respawn.on_pre_player_mined_item (event)
  -- event.entity
  -- event.player_index
  -- remove corpse marker
  if not(event.entity and event.entity.valid) then return end
  if event.entity.name == "character-corpse" then
      Respawn.on_corpse_removed (event.entity)
  end
end
Event.addListener(defines.events.on_pre_player_mined_item, Respawn.on_pre_player_mined_item)

function Respawn.on_lua_shortcut (event)
  if event.player_index
    and game.players[event.player_index]
    and game.players[event.player_index].connected then
      if event.prototype_name == Respawn.name_shortcut then
        --Respawn.die(game.players[event.player_index])
        Respawn.confirm.open_gui(game.players[event.player_index])
      end
  end
end
Event.addListener(defines.events.on_lua_shortcut, Respawn.on_lua_shortcut)

function Respawn.on_respawn_keypress (event)
  if event.player_index
    and game.players[event.player_index]
    and game.players[event.player_index].connected
  then
      --Respawn.die(game.players[event.player_index])
      Respawn.confirm.open_gui(game.players[event.player_index])
  end
end
Event.addListener(Respawn.name_event, Respawn.on_respawn_keypress)

Respawn.confirm = {}
Respawn.confirm.name_gui = mod_prefix.."respawn-gui-confirm"
Respawn.confirm.buttons_container = 'confirm_button_container'
Respawn.confirm.button_yes = 'yes'
Respawn.confirm.button_no = 'no'

function Respawn.confirm.open_gui(player)
  local center = player.gui.center
  if (center[Respawn.confirm.name_gui]) then return end
  if (center[Respawn.name_gui]) then return end
	local popup = center.add {type = "frame", name = Respawn.confirm.name_gui, direction = "vertical", caption = {'space-exploration.respawn-confirm-title'}}

	local buttons_container = popup.add {type = "flow", name = Respawn.confirm.buttons_container, direction = "horizontal"}


  buttons_container.add {
    type = "button",
    name = Respawn.confirm.button_no,
    style="back_button",
    caption = {'space-exploration.respawn-confirm-no'}
  }

  local yes = buttons_container.add {
    type = "button",
    name = Respawn.confirm.button_yes,
    style="red_confirm_button",
    caption = {'space-exploration.respawn-confirm-yes'}
  }
  yes.style.left_margin = 10
end

function Respawn.confirm.close_gui(player)
  if player.gui.center[Respawn.confirm.name_gui] then
    player.gui.center[Respawn.confirm.name_gui].destroy()
  end
end

function Respawn.confirm.on_gui_click(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]
  root = gui_element_or_parent(element, Respawn.confirm.name_gui)
  if not root then return end
  if element.name == Respawn.confirm.button_yes then
    Respawn.die(game.players[event.player_index])
  end
  Respawn.confirm.close_gui(game.players[event.player_index])
end
Event.addListener(defines.events.on_gui_click, Respawn.confirm.on_gui_click)


return Respawn
