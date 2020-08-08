local Lifesupport = {}
--[[
Lifesupport mechanics:
Consume lifesupport canisters for food & air

Equiment boosts the lifesupport drain efficiency, stacks additivly.
All thruster suits have some base level life support efficiency, 1 module is built-in.

Non-thruster suits can have modules added but only function on land and efficiency banafits are halved. Only useful on hostile planets.
A spacesuit proper spacesuit is required in space.

]]

Lifesupport.name_gui_root = mod_prefix.."lifesupport"
Lifesupport.name_window_close = "close_lifesupport"
Lifesupport.name_sound_used_canister = mod_prefix .. "canister-breath"

Lifesupport.lifesupport_refil_threshold = 50
Lifesupport.lifesupport_bar_max = 150
Lifesupport.lifesupport_per_second = 1 -- at 100% hazard (space)
Lifesupport.tick_interval = 240
Lifesupport.check_inventory_interval = Lifesupport.tick_interval * 4

Lifesupport.min_effective_efficiency = 0.25 -- acts as damage multiplier
Lifesupport.spacesuit_base_efficiency = 1
Lifesupport.non_spacesuit_base_efficiency = 0
Lifesupport.non_spacesuit_efficiency_multiplier = 0.5

Lifesupport.lifesupport_canisters = {
  {
    name = mod_prefix .. "lifesupport-canister",
    used = mod_prefix .. "used-lifesupport-canister",
    lifesupport = 100
  }
}

Lifesupport.lifesupport_equipment = {
  [mod_prefix .. "lifesupport-equipment-1"] = {efficiency = 1},
  [mod_prefix .. "lifesupport-equipment-2"] = {efficiency = 2},
  [mod_prefix .. "lifesupport-equipment-3"] = {efficiency = 4},
  [mod_prefix .. "lifesupport-equipment-4"] = {efficiency = 8},
}

--[[
  playerdata.user_opened_armor_gui -> flag that says user has armor gui open and we show life support gui
  playerdata.environment_hostile -> flag for hostile environment where air is used up
  playerdata.suit_thrust_bonused -> flag for thruster suit giving bonuses to thrusters
]]

function Lifesupport.get_gui(player)
  return player.gui.left[Lifesupport.name_gui_root]
end

function Lifesupport.check_inventory_reserve_lifesupport(player)
  local playerdata = get_make_playerdata(player)
  local character = player_get_character(player)
  if not character then
    playerdata.reserve_lifesupport = 0
    return
  end
  playerdata.reserve_lifesupport = 0
  local inventory = character.get_main_inventory()
  if inventory and inventory.valid then
    for _, lifesupport_canister in pairs(Lifesupport.lifesupport_canisters) do
      playerdata.reserve_lifesupport = playerdata.reserve_lifesupport + inventory.get_item_count(lifesupport_canister.name) * lifesupport_canister.lifesupport
    end
  end
end

function Lifesupport.get_current_hazard(player)
  local playerdata = get_make_playerdata(player)
  local character = player_get_character(player)
  if not character then
    playerdata.lifesupport_environment = "unknown"
    return 0
  end
  local position = Util.position_to_tile(character.position)
  local zone = Zone.from_surface(character.surface)
  local spaceship = (zone and zone.type == "spaceship") and zone or nil

  local hazard = 0
  if character.vehicle then
    hazard = 0
  else
    if not zone then
      -- vaults?
      hazard = 0
      playerdata.lifesupport_environment = "unknown"
    elseif spaceship then
      if spaceship.known_tiles
         and spaceship.known_tiles[position.x] and spaceship.known_tiles[position.x][position.y]
         and (spaceship.known_tiles[position.x][position.y] == Spaceship.tile_status.floor_interior
            or spaceship.known_tiles[position.x][position.y] == Spaceship.tile_status.floor_console_connected
            or spaceship.known_tiles[position.x][position.y] == Spaceship.tile_status.wall_console_connected
            or spaceship.known_tiles[position.x][position.y] == Spaceship.tile_status.bulkhead_console_connected) then
          hazard = 0
          playerdata.lifesupport_environment = "spaceship-interior"
      else
          hazard = 1
          playerdata.lifesupport_environment = "space"
      end
    else
      local tile = character.surface.get_tile(Util.position_to_tile(character.position))
      if tile and tile.valid and Util.table_contains(Spaceship.names_spaceship_floors, tile.name) then
        hazard = 0
        playerdata.lifesupport_environment = "spaceship-interior"
      elseif Zone.is_space(zone) then
        hazard = 1
        playerdata.lifesupport_environment = "space"
      else
        hazard = 0
        if zone.plague_used then
          hazard = 1
          if zone.type == "moon" then
            playerdata.lifesupport_environment = "plague-moon"
          else
            playerdata.lifesupport_environment = "plague-planet"
          end
        else
          -- land
          -- TODO: Get habitability from zone data. hazard factors: desert, hot, cold, uranium, high aux.
          if zone.type == "moon" then
            playerdata.lifesupport_environment = "moon"
          else
            playerdata.lifesupport_environment = "planet"
          end
        end
      end
    end
  end
  return hazard

end

function Lifesupport.update_lifesupport_efficiency(player)
  local character = player_get_character(player)
  if not character then return end
  local playerdata = get_make_playerdata(player)

  playerdata.lifesupport_efficiency = 0
  playerdata.has_spacesuit = false

  local armor_inv = character.get_inventory(defines.inventory.character_armor)
  if armor_inv and armor_inv[1] and armor_inv[1].valid_for_read then
    if util.table_contains(name_thruster_suits, armor_inv[1].name) then
      playerdata.lifesupport_efficiency = Lifesupport.spacesuit_base_efficiency
      playerdata.has_spacesuit = true
    end

    -- get lifesupport equipment modules
    local grid_efficiency = 0
    if character.grid then
      for name, count in pairs(character.grid.get_contents()) do
        if Lifesupport.lifesupport_equipment[name] ~= nil then
          grid_efficiency = grid_efficiency + count * (Lifesupport.lifesupport_equipment[name].efficiency or 0)
        end
      end
    end
    playerdata.lifesupport_efficiency = playerdata.lifesupport_efficiency + grid_efficiency
  end

  if not playerdata.has_spacesuit then
    playerdata.lifesupport_efficiency = playerdata.lifesupport_efficiency / 2
  end

  return playerdata.lifesupport_efficiency
end


function Lifesupport.on_tick(event)
  for _, player in pairs(game.connected_players) do
    if game.tick % Lifesupport.tick_interval == 0 then
      Lifesupport.consume_lifesupport(player)
    end
    if Lifesupport.get_gui(player) then
      Lifesupport.gui_update(player, playerdata)
    end
  end
end
Event.addListener(defines.events.on_tick, Lifesupport.on_tick)


function Lifesupport.consume_lifesupport(player)
  local playerdata = get_make_playerdata(player)
  local character = player_get_character(player)
  if not character then return end
  local hazard = Lifesupport.get_current_hazard(player)
  if hazard > 0 then
    --Lifesupport.gui_open(player)
    Lifesupport.update_lifesupport_efficiency(player) -- saves to playerdata.lifesupport_efficiency
    local efficiency = playerdata.lifesupport_efficiency
    if efficiency > 0 and not playerdata.has_spacesuit then
      local zone = Zone.from_surface(character.surface)
      if Zone.is_space(zone) then
        efficiency = 0
      end
    end
    local effective_efficiency = math.max(efficiency, Lifesupport.min_effective_efficiency)
    local hazard_use_rate_per_s = Lifesupport.lifesupport_per_second * Lifesupport.get_current_hazard(player)
    local effective_use_rate_per_s = hazard_use_rate_per_s / effective_efficiency
    local effective_use_per_interval = Lifesupport.tick_interval * effective_use_rate_per_s / 60
    if efficiency > 0 then
      -- consume lifesupport
      playerdata.lifesupport = (playerdata.lifesupport or 0) - effective_use_per_interval
      if playerdata.lifesupport < Lifesupport.lifesupport_refil_threshold then
        Lifesupport.consume_canister(player, playerdata, character)
      end
      if playerdata.lifesupport < 0 then
        Lifesupport.damage_character(player, playerdata, character, -playerdata.lifesupport)
        playerdata.lifesupport = 0
      end
    else
      -- lifesupport is not funcitioning. Even if there is a lifesupport buffer it won't do anything (eg: non-space suit in space.)
      Lifesupport.damage_character(player, playerdata, character, effective_use_per_interval)
    end
  elseif playerdata.lifesupport == nil or playerdata.lifesupport < Lifesupport.lifesupport_refil_threshold then
    Lifesupport.consume_canister(player, playerdata, character)
  end
end

function Lifesupport.consume_canister(player, playerdata, character)
  local inventory = character.get_main_inventory()
  if inventory and inventory.valid then
    for _, lifesupport_canister in pairs(Lifesupport.lifesupport_canisters) do
      local count = inventory.get_item_count(lifesupport_canister.name)
      if count > 0 then
        inventory.remove({name=lifesupport_canister.name, count=1})
        inventory.insert({name=lifesupport_canister.used, count=1})
        playerdata.lifesupport = (playerdata.lifesupport or 0) + lifesupport_canister.lifesupport
        player.play_sound { path = Lifesupport.name_sound_used_canister }
        return
      end
    end
  end
end

function Lifesupport.damage_character(player, playerdata, character, damage)
  -- half damage direct to character
  if damage > character.health then
    player.print({"space-exploration.suffocating-warning"}, {r = 1, g = 0, b = 0, a = 0})
    character.die("neutral")
    Lifesupport.gui_close(player)
    return
  end

  local shield_damage = 0
  if character.grid then
    shield_damage = character.grid.shield
  end
  character.damage(damage + shield_damage, "neutral", "suffocation")
  player.print({"space-exploration.suffocating-warning"}, {r = 1, g = 0, b = 0, a = 0})
end

function Lifesupport.on_equipment_changed(event)
  local player = game.players[event.player_index]
  local character = player_get_character(player)
  if not character then return end
  Lifesupport.update_lifesupport_efficiency(player)
end
Event.addListener(defines.events.on_player_placed_equipment, Lifesupport.on_equipment_changed)
Event.addListener(defines.events.on_player_removed_equipment, Lifesupport.on_equipment_changed)

function Lifesupport.on_armor_changed(event)
  local player = game.players[event.player_index]
  local character = player_get_character(player)
  if not character then return end
  Lifesupport.update_lifesupport_efficiency(player)
  local playerdata = get_make_playerdata(player)
  if playerdata.lifesupport_efficiency and playerdata.lifesupport_efficiency > 0 then
    Lifesupport.gui_open(player, playerdata)
  end
end
Event.addListener(defines.events.on_player_armor_inventory_changed, Lifesupport.on_armor_changed)

function Lifesupport.on_gui_opened(event)
  local player = game.players[event.player_index]
  if event.gui_type == defines.gui_type.item and event.item and event.item.type == "armor" and event.item.grid then
    Lifesupport.update_lifesupport_efficiency(player)
    local character = player_get_character(player)
    if not character then return end
    local playerdata = get_make_playerdata(player)
    if playerdata.lifesupport_efficiency and playerdata.lifesupport_efficiency > 0 then
      Lifesupport.gui_open(player, playerdata)
    end
  end
end
Event.addListener(defines.events.on_gui_opened, Lifesupport.on_gui_opened)
--[[
function Lifesupport.on_gui_closed(event)
  local player = game.players[event.player_index]

  if event.gui_type == defines.gui_type.item then
    Lifesupport.gui_close(player, playerdata)
  end

end
Event.addListener(defines.events.on_gui_closed, Lifesupport.on_gui_closed)
]]--

function Lifesupport.gui_open(player)
  if settings.get_player_settings(player)["se-never-show-lifesupport"].value then
    return
  end
  local gui = Lifesupport.get_gui(player)
  if not gui then
    local root = player.gui.left.add{
      type = "frame",
      name = Lifesupport.name_gui_root,
      direction = "vertical",
    }

    local title_table = root.add{type="table", name="title_table", column_count=2, draw_horizontal_lines=false}
    title_table.style.horizontally_stretchable = true
    title_table.style.column_alignments[1] = "left"
    title_table.style.column_alignments[2] = "right"

    local title_frame = title_table.add{type="frame", name="title_frame", caption = {"space-exploration.lifesupport_title"}, style="informatron_title_frame"}
    title_frame.style.right_padding = -5

    local right_flow = title_table.add{type="flow", name="title_flow_right"}
    --local close = right_flow.add{type="button", name=Lifesupport.name_window_close, caption="✖", style="informatron_close_button"}
    local close = right_flow.add{type="sprite-button", name=Lifesupport.name_window_close, sprite = "utility/close_white", style="informatron_close_button"}
    close.style.width = 28
    close.style.height = 28

    root.add { type = "label", name = "lifesupport_environment" }
    root.add { type = "label", name = "lifesupport_efficiency" }
    local bar = root.add { type = "progressbar", name="lifesupport_bar", size = 100, value = 0, style = "space_platform_progressbar_fuel" }
    bar.style.color = {r=70/255, g=171/255, b=1}
    root.add { type = "label", name = "lifesupport_suit" }
    root.add { type = "label", name = "lifesupport_reserves" }
    bar.style.horizontally_stretchable  = true
  end
end

function Lifesupport.gui_close(player)
  local gui = Lifesupport.get_gui(player)
  if gui then gui.destroy() end
end

function Lifesupport.gui_update(player, playerdata)
  local gui = Lifesupport.get_gui(player)
  if not gui then return end
  local character = player_get_character(player)
  if not (gui and character) then Lifesupport.gui_close(player) return end

  local playerdata = get_make_playerdata(player)
  Lifesupport.check_inventory_reserve_lifesupport(player)
  local hazard = Lifesupport.get_current_hazard(player)
  if not playerdata.lifesupport_efficiency then
    Lifesupport.update_lifesupport_efficiency(player)
  end

  if playerdata.has_spacesuit then
    gui.lifesupport_efficiency.caption = {"space-exploration.lifesupport_efficiency_spacesuit", math.floor(playerdata.lifesupport_efficiency * 100) .. "%"}
  else
    gui.lifesupport_efficiency.caption = {"space-exploration.lifesupport_efficiency_no_spacesuit", math.floor(playerdata.lifesupport_efficiency * 100).. "%"}
  end

  gui.lifesupport_bar.value = math.max(0, math.min(Lifesupport.lifesupport_bar_max, (playerdata.lifesupport or 0) / Lifesupport.lifesupport_bar_max))


  local efficiency = playerdata.lifesupport_efficiency
  if efficiency > 0 and not playerdata.has_spacesuit then
    local zone = Zone.from_surface(character.surface)
    if zone and Zone.is_space(zone) then
      efficiency = 0
    end
  end

  local effective_efficiency = math.max(efficiency, Lifesupport.min_effective_efficiency)
  local is_space_estimation = false
  if hazard == 0 then
    hazard = 1
    is_space_estimation = true
  end
  local hazard_use_rate_per_s = Lifesupport.lifesupport_per_second * hazard
  local effective_use_rate_per_s = hazard_use_rate_per_s / effective_efficiency

  local lifesupport_suit_s = (playerdata.lifesupport or 0) / effective_use_rate_per_s
  local lifesupport_duration = util.seconds_to_clock(lifesupport_suit_s)

  local lifesupport_reserve_s = (playerdata.reserve_lifesupport or 0) / effective_use_rate_per_s
  local lifesupport_reserve_duration = util.seconds_to_clock(lifesupport_reserve_s)

  if is_space_estimation then
    gui.lifesupport_suit.caption =  { "space-exploration.lifesupport_suit_est", lifesupport_duration }
    gui.lifesupport_reserves.caption =  { "space-exploration.lifesupport_reserves_est", lifesupport_reserve_duration }
  else
    gui.lifesupport_suit.caption =  { "space-exploration.lifesupport_suit", lifesupport_duration }
    gui.lifesupport_reserves.caption =  { "space-exploration.lifesupport_reserves", lifesupport_reserve_duration }
  end

  gui.lifesupport_environment.caption = { "space-exploration.lifesupport_environment_"..playerdata.lifesupport_environment, canisters_per_hour, reserve_minutes }
end

function Lifesupport.on_gui_click (event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  local player = game.players[event.player_index]

  root = gui_element_or_parent(element, Lifesupport.name_gui_root)
  if root then
    if element.name == Lifesupport.name_window_close then
      Lifesupport.gui_close(player)
    end
  end
end
Event.addListener(defines.events.on_gui_click, Lifesupport.on_gui_click)


return Lifesupport
