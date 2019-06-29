local locations = require(mod_name .. ".lualib.locations")
local quest_gui = require(mod_name .. ".lualib.quest_gui")

local tracker = {}

tracker.give_hint_first_time = function(hint, behavior)
  if tracker.times_observed(behavior) == 1 then
    quest_gui.add_hint({hint})
  end
end

tracker.log_behavior = function(behavior_name,max_samples)
  if global.behaviors[behavior_name] == nil then
    global.behaviors[behavior_name] = {}
  end
  if #global.behaviors[behavior_name] < max_samples then
    table.insert(global.behaviors[behavior_name],game.ticks_played)
    return true
  end
  return false
end

tracker.log_position = function(player)
  if global.player_positions == nil then global.player_positions = {} end
  table.insert(global.player_positions,{tick=game.ticks_played,x=player.position.x,y=player.position.y})
end

tracker.was_observed = function(behavior_name)
  if global.behaviors and global.behaviors[behavior_name] then
    return true
  end
  return false
end

tracker.first_observed = function(behavior_name)
  if tracker.was_observed(behavior_name) then
    return global.behaviors[behavior_name][1]
  end
  return -1
end

tracker.times_observed = function(behavior_name)
  if tracker.was_observed(behavior_name) then
    return #global.behaviors[behavior_name]
  end
  return 0
end

tracker.start_timer = function(timer_name)
  if global.timers[timer_name] == nil then
    global.timers[timer_name] = game.ticks_played
    return true
  end
  return false
end

tracker.check_elapsed_ticks_on_timer = function(timer_name,ticks)
  if global.timers[timer_name] then
    return game.ticks_played > global.timers[timer_name] + ticks
  end
  return false
end

tracker.reset_timer = function(timer_name)
  global.timers[timer_name] = game.ticks_played
end

tracker.check_lab = function()
  local lab = locations.get_structure_in_area('escape-pod-lab','starting-area')
  if lab then
    local packs = lab.get_inventory(defines.inventory.lab_input).get_contents()
    local has_packs = false
    for i, quant in pairs(packs) do
      if i == 'automation-science-pack' and quant > 0 then
        has_packs = true
      end
    end
    if has_packs then
      tracker.log_behavior('loaded_bottles',1)
    end
  end
end

tracker.check_repair_state = function()
  if active_player() and active_player().repair_state.repairing then
    tracker.log_behavior('has_repaired',1)
  end
end

tracker.check_chest_for_coal = function()
  local chests = locations.get_main_surface().find_entities_filtered({name='wooden-chest'})
  local miners = locations.get_main_surface().find_entities_filtered({name='burner-mining-drill'})
  for _, chest in pairs(chests) do
    local inv = chest.get_inventory(defines.inventory.chest)
    if inv.get_item_count('coal') > 5 then
      tracker.start_timer('full_coal_chest')
      return chest
    end
  end
  for _, miner in pairs(miners) do
    local inv = miner.get_inventory(defines.inventory.fuel)
    if inv.get_item_count('coal') > 15 and miner.mining_target and miner.mining_target.name == 'coal'  then
      tracker.start_timer('full_coal_chest')
      return miner
    end
  end
  return nil
end

tracker.check_chest_for_items = function(item_list,quant)
  local chests = locations.get_main_surface().find_entities_filtered({name='wooden-chest'})
  for _, chest in pairs(chests) do
    local inv = chest.get_inventory(defines.inventory.chest)
    for _, item_name in pairs(item_list) do
      if inv.get_item_count(item_name) > quant then
        print("found chest of iron")
        tracker.start_timer('full_item_chest')
        return chest
      end
    end
  end
  return nil
end

local on_player_toggled_alt_mode = function()
  tracker.log_behavior('used_alt_mode',100)
  tracker.give_hint_first_time('quest-hints.info-alt-mode','used_alt_mode')
end

tracker.check_outputs = function()
  local drills = game.surfaces[1].find_entities_filtered({name='burner-mining-drill'})
  local placed = false
  if not tracker.was_observed('placed_output') then
    for _, drill in pairs(drills) do
      if drill.burner.heat > 0 and
         drill.drop_target and
         (drill.drop_target.name == 'burner-mining-drill' or drill.drop_target.name == 'iron-chest' or
           drill.drop_target.name == 'wooden-chest' or drill.drop_target.name == 'stone-furnace') then
        placed = true
      end
    end
  end
  if placed == true then
    tracker.log_behavior('placed_output',1)
  end
end

local check_ore_on_ground = function()
  local ground_items = game.surfaces[1].find_entities_filtered({name='item-on-ground'})
  local ores = {'copper-ore','stone','iron-ore','coal'}
  local found_ore = nil
  for _, ground_item in pairs(ground_items) do
    for _, res_type in pairs(ores) do
      if ground_item.stack.name == res_type then
        found_ore = ground_item
      end
    end
  end

  if found_ore then
    --print("found-ore")
    local drills = game.surfaces[1].find_entities_filtered({name='burner-mining-drill'})
    for _, drill in pairs(drills) do
      --print("checked drill")
      if drill.drop_position.x == found_ore.position.x and drill.drop_position.y == found_ore.position.y then
        tracker.start_timer('blocked_miner')
        tracker.log_behavior('blocked_miner',2)
        tracker.give_hint_first_time('quest-hints.info-miner-output','blocked_miner')
      end
    end
  end

  if found_ore then
    tracker.start_timer('ore_on_ground')
  end
end


local check_fuelled = function()
  -- search through miners and furnaces
  -- if any have fuel then stop the timer
  local result = false
  local drills = game.surfaces[1].find_entities_filtered({name='burner-mining-drill'})
  local furnaces = game.surfaces[1].find_entities_filtered({name='stone-furnace'})
  for _, drill in pairs(drills) do
    if drill.get_fuel_inventory().is_empty() == false or drill.burner.heat > 0 then
      result = true
    end
  end
  if result == false then
    for _, furnace in pairs(furnaces) do
      if furnace.get_fuel_inventory().is_empty() == false or furnace.burner.heat > 0 then
        result = true
      end
    end
  end
  if result then
    tracker.log_behavior('fueled_ent',2)
    tracker.give_hint_first_time('quest-hints.info-burner-structures','fueled_ent')
  end
end

local on_player_pipette = function()
  tracker.log_behavior('used_pipette',100)
  tracker.give_hint_first_time('quest-hints.info-pipette', 'used_pipette')
end

local on_player_changed_position = function (event)
  tracker.log_behavior('moved',1)
  if game.players[event.player_index].character and
     game.players[event.player_index].character.direction == defines.direction.north then
    tracker.log_behavior('moved_up',1)
  end
  if game.players[event.player_index].character and
     game.players[event.player_index].character.direction == defines.direction.east then
    tracker.log_behavior('moved-right',1)
  end
  if game.players[event.player_index].character and
     game.players[event.player_index].character.direction == defines.direction.west then
    tracker.log_behavior('moved-left',1)
  end
  if game.players[event.player_index].character and
     game.players[event.player_index].character.direction == defines.direction.south then
    tracker.log_behavior('moved_down',1)
  end
end

local on_player_cursor_stack_changed = function(event)
  tracker.log_behavior('moved-item',30)
  tracker.log_position(game.players[event.player_index])
  tracker.check_lab()
  check_fuelled()
end

local on_player_rotated_entity = function()
  tracker.log_behavior('used_rotate',30)
  tracker.give_hint_first_time('quest-hints.info-rotate','used_rotate')
end

local on_player_used_capsule = function (event)
  if event.item.name == 'repair-pack' then
    tracker.log_behavior('used_repair-pack',30)
    tracker.give_hint_first_time('quest-hints.info-repair-pack','used_repair_pack')
  end
end

local on_player_mined_entity = function(event)
  if event.buffer.get_item_count('wood')>0 then
    tracker.log_behavior('mined_tree',1000)
  elseif event.entity.name == 'stone' then
    tracker.log_behavior('mined_stone',300)
    tracker.give_hint_first_time('quest-hints.info-hand-mining','mined_stone')
  elseif event.entity.name == 'coal' then
    tracker.log_behavior('mined_coal',300)
  elseif event.entity.name == 'copper-ore' then
    tracker.log_behavior('mined_copper',300)
  elseif event.entity.name == 'iron-ore' then
    tracker.log_behavior('mined_iron',300)
  else
    tracker.log_behavior('mined_entity',1000)
    tracker.give_hint_first_time('quest-hints.info-remove-structure','mined_entity')
  end
end

local on_player_main_inventory_changed = function(event)
  tracker.log_behavior('moved_item',1)
  tracker.check_lab()
  tracker.log_position(game.players[event.player_index])
  check_fuelled()
end

local on_entity_settings_pasted = function()
  tracker.log_behavior('used_copy_paste',100)
  tracker.give_hint_first_time('quest-hints.info-copy-paste-settings','used_copy_paste')
end

local on_built_entity = function (event)
  tracker.log_behavior('built_entity',300)
  tracker.give_hint_first_time('quest-hints.info-build','built_entity')
  if event.created_entity.name == "burner-mining-drill" or event.created_entity.name == "stone-furnace" then
    tracker.start_timer('no_fuel')
  end

  if event.created_entity.name == "small-electric-pole" then
    tracker.log_behavior('built_electric_pole',5)
    tracker.give_hint_first_time('quest-hints.info-pole','built_electric_pole')
  end

  if event.created_entity.direction > 0 then
    tracker.log_behavior('used_rotate',300)
    tracker.give_hint_first_time('quest-hints.info-rotate','used_rotate')
  end

  tracker.check_outputs()
end

local on_gui_opened = function (event)
  if event.gui_type == defines.gui_type.research then
    tracker.log_behavior('opened_technology',100)
    tracker.give_hint_first_time('quest-hints.info-research-screen','opened_technology')
  elseif event.gui_type == defines.gui_type.controller then
    tracker.log_behavior('opened_inventory',1000)
    tracker.give_hint_first_time('quest-hints.info-inventory','opened_inventory')
  elseif event.gui_type == defines.gui_type.entity then
    tracker.log_behavior('opened_ent',300)
    tracker.give_hint_first_time('quest-hints.info-move-click','opened_ent')
    if event.entity.name == 'escape-pod-assembler' then
      tracker.log_behavior('opened_escape_pod_assembler',300)
    elseif event.entity.name == 'escape-pod-lab' then
      tracker.log_behavior('opened_escape_pod_lab',300)
    elseif event.entity.name == 'lab' then
      tracker.log_behavior('opened_lab',300)
    elseif event.entity.name == 'assembling-machine-1' then
      tracker.log_behavior('opened_assembling_machine_1',300)
    elseif event.entity.name == 'big-ship-wreck-1' or event.entity.name == 'big-ship-wreck-2' then
      tracker.log_behavior('opened_wreck',300)
    elseif event.entity.name == 'stone-furnace' then
      tracker.log_behavior('opened_furnace',300)
    elseif event.entity.name == 'burner-mining-drill' then
      tracker.log_behavior('opened_burner_mining_drill',300)
    end
  end
  tracker.log_position(game.players[event.player_index])
  check_ore_on_ground()
end

local on_tick = function ()
  if game.ticks_played % 60 == 0 then
    check_ore_on_ground()
    tracker.check_chest_for_coal()
    if tracker.was_observed('iron_stockpiled') == false then
      if tracker.check_chest_for_items({'iron-plate'},50) then
        tracker.log_behavior('iron_stockpiled',5)
      end
    end
  end
  tracker.check_repair_state()
end

tracker.init = function()
  global.behaviors = {
    moved = nil,
    moved_up = nil,
    moved_down = nil,
    moved_left = nil,
    moved_right = nil,
    opened_ent = nil,
    opened_technology = nil,
    opened_inventory = nil,
    moved_item = nil,
    used_pipette = nil,
    used_alt_mode = nil,
    used_copy_paste = nil,
    used_rotate = nil,
    used_quick_take = nil,
    used_repair_pack = nil,
    mined_wood = nil,
    mined_stone = nil,
    mined_coal = nil,
    mined_iron = nil,
    mined_copper = nil,
    built_entity = nil,
    removed_entity = nil,
    fueled_ent = nil,
    loaded_bottles = nil,
    powered_ent = nil,
    generated_power = nil,
    collected_ore = nil,
    collected_gears = nil,
    has_repaired = nil,
    placed_output = nil,
    visited_panic_point = nil,
    visited_exit_point = nil,
    player_fired_pistol = nil,
    player_attacked_with_pickaxe = nil,
    assembler_has_been_fed = nil,
    lab_has_been_fed = nil,
    copper_setup_built = nil,
    picked_up_item = nil,
  }
  global.player_positions = {}
  global.last_timer_check = 1
  global.timers = {
    turret_damaged = nil,
    character_move = nil,
    player_click = nil,
    no_research = nil,
    no_bottles = nil,
    no_inventory = nil,
    no_stone = nil,
    no_fuel = nil,
    no_gears = nil,
    ore_on_ground = nil,
    electronics_begins = nil,
    packup_begins = nil,
    scanned_wreck = nil,
    no_rotate = nil,
    blocked_miner = nil,
    full_item_chest = nil,
  }
end

local on_entity_damaged = function(event)
  local active_player = active_player()
  if active_player and event.cause == active_player.character then
    if event.entity.name == 'small-biter' and
       active_player.get_inventory(defines.inventory.character_guns).get_item_count('pistol') > 0 then
      tracker.log_behavior('player_fired_pistol',3000)
      tracker.give_hint_first_time('quest-hints.info-test-fire','player_fired_pistol')
    end
  end
  if active_player and event.cause == active_player.character
    and (event.entity.force == game.forces['enemy'] or event.entity.force == game.forces['peaceful']) then
    if active_player.get_inventory(defines.inventory.character_guns).get_item_count('pistol') == 0 then
      tracker.log_behavior('player_attacked_with_pickaxe',100)
      tracker.give_hint_first_time('quest-hints.info-melee-attack','player_attacked_with_pickaxe')
    end
  end
  if event.cause and event.cause.name == 'character' and event.entity.name == 'small-biter' and
     event.entity.force.name == 'peaceful' then
    event.entity.force = 'enemy'
    if global.peaceful_biters_attacked == nil then
      global.peaceful_biters_attacked = 1
    else
      global.peaceful_biters_attacked = global.peaceful_biters_attacked + 1
    end
    event.entity.set_command(
      {
        type = defines.command.wander,
        radius = 60,
        distraction = defines.distraction.by_anything
    })
  end

  if event.entity.name == 'gun-turret' then
    tracker.reset_timer('turret_damaged')
  end
end

local on_player_fast_transferred = function(event)
  if event.from_player then
    tracker.log_behavior('used_quick_put',300)
  else
    tracker.log_behavior('used_quick_take',300)
    tracker.give_hint_first_time('quest-hints.info-fast-transfer','used_quick_take')
    if event.entity.name == 'stone-furnace' then
      tracker.log_behavior('used_quick_take_furnace',300)
    elseif event.entity.name == 'assembling-machine-1' then
      tracker.log_behavior('used_quick_take_am',300)
    elseif event.entity.name == 'burner-mining-drill' then
      tracker.log_behavior('used_quick_take_coal',300)
    elseif event.entity.name == 'wooden-chest' then
      tracker.log_behavior('used_quick_take_coal',300)
    end
  end
end

local on_picked_up_item = function()
  tracker.log_behavior('picked_up_item',300)
  tracker.give_hint_first_time('quest-hints.info-pickup-items','picked_up_item')
end

local on_research_finished = function(event)
  tracker.log_behavior('research_finished',300)
  tracker.log_behavior(event.research.name..'_finished' ,1)
  tracker.give_hint_first_time('quest-hints.info-research-screen','basic-electronics_finished')
end

tracker.events =
{
  [defines.events.on_picked_up_item] = on_picked_up_item,
  [defines.events.on_player_pipette] = on_player_pipette,
  [defines.events.on_player_changed_position] = on_player_changed_position,
  [defines.events.on_tick] = on_tick,
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_built_entity] = on_built_entity,
  [defines.events.on_entity_settings_pasted] = on_entity_settings_pasted,
  [defines.events.on_player_main_inventory_changed] = on_player_main_inventory_changed,
  [defines.events.on_player_mined_entity] = on_player_mined_entity,
  [defines.events.on_player_used_capsule] = on_player_used_capsule,
  [defines.events.on_player_rotated_entity] = on_player_rotated_entity,
  [defines.events.on_player_cursor_stack_changed] = on_player_cursor_stack_changed,
  [defines.events.on_entity_damaged] = on_entity_damaged,
  [defines.events.on_player_fast_transferred] = on_player_fast_transferred,
  [defines.events.on_player_toggled_alt_mode] = on_player_toggled_alt_mode,
  [defines.events.on_research_finished] = on_research_finished,
}

return tracker
