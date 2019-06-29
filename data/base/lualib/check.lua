local quest_gui = require(mod_name .. ".lualib.quest_gui")
local locations = require(mod_name .. ".lualib.locations")
local misc = require(mod_name .. ".lualib.misc")
local math2d = require("math2d")
local tracker = require(mod_name .. ".lualib.player_tracker")

local sanitize_name_goal_list = function(item_list)
  local new_list = {}
  for _, item in ipairs(item_list) do
    if type(item) == 'string' then
      table.insert(new_list,{name=item,goal=1})
    elseif type(item) == 'table' then
      table.insert(new_list,item)
    else
      error("sanitize_name_goal_list: item goal list included non string, non table item")
    end
  end
  return new_list
end

local check = {}

check.get_list_of_powered_blocked_miners = function()
  local blocked = {}
  local drills = locations.get_main_surface().find_entities_filtered({name='burner-mining-drill'})
  for _, drill in pairs(drills) do
    if (not drill.drop_target) and drill.energy > 0 then
      table.insert(blocked,drill)
    end
  end
  return blocked
end

check.get_list_of_unpowered_burners = function()
  local burners = locations.get_main_surface().find_entities_filtered({name={'burner-mining-drill','stone-furnace'}})
  local empty_burners = {}
  for _, burner in pairs(burners) do
    if burner.energy == 0 and burner.get_fuel_inventory().is_empty() then
      table.insert(empty_burners,burner)
    end
  end
  return empty_burners
end

check.times_behavior_observed = function(behavior_name,count)
  if count == nil then count = 1 end
  local state
  local times_observed = tracker.times_observed(behavior_name)
  if times_observed >= count then
    state = 3
  else
    state = 1
  end
  quest_gui.update_state('was-observed-'..behavior_name,state)
  return times_observed >= count
end

check.closest_entity = function(position,list)
  local closest = {ent=nil,dist=9999}
  for _,ent in ipairs(list) do
    local dist = math2d.position.distance(position,ent.position)
    if dist < closest.dist then
      closest = {ent=ent,dist=dist}
    end
  end
  return closest.ent
end

check.entities_removed_since = function(start_count,goal)
  if tracker.times_observed('mined_entity') >= (start_count+goal) then
    quest_gui.update_state('collect',3)
    return true
  elseif tracker.times_observed('mined_entity') > (start_count) then
    quest_gui.update_state('collect',2)
  else
    quest_gui.update_state('collect',1)
  end
  return false
end

check.entity_count_in_area = function(entity_type,area_name)
  local area = locations.get_area(area_name)
  assert(area,"check.entity_count_area: map is missing area: area_name")
  local entities = locations.get_main_surface().find_entities_filtered({name=entity_type,area=area})
  return #entities
end

check.entities_removed_from_area = function(entity_type,area_name,starting_number,goal)
  local count = check.entity_count_in_area(entity_type,area_name)
  local removed = starting_number-count
  quest_gui.update_count('remove-'..entity_type,removed,goal)
  return removed >= goal
end

check.entity_count_with_contents_in_area = function(entity_type,item_list,area_name,goal)
  local area = locations.get_area(area_name)
  assert(area,"check.entity_count_with_contents_in_area: map is missing area: area_name")
  local entities = locations.get_main_surface().find_entities_filtered({name=entity_type,area=area})
  if #entities == 0 then return false end
  item_list = sanitize_name_goal_list(item_list)
  local count = 0
  for _, entity in pairs(entities) do
    local entity_result = true
    for _, item in pairs(item_list) do
      local item_result = false
      for _, inventory_type in pairs(defines.inventory) do
        local inventory = entity.get_inventory(inventory_type)
        if inventory and inventory.get_item_count(item.name) >= item.goal then
          item_result = true
        end
      end
      if item_result == false then
        entity_result = false
        break
      end
    end
    if entity_result then count = count + 1 end
  end
  return count >= goal
end

check.closest_position = function(position,list)
  local closest = {pos=nil,dist=9999}
  for _,pos in ipairs(list) do
    local dist = math2d.position.distance(position,pos)
    if dist < closest.dist then
      closest = {pos=pos,dist=dist}
    end
  end
  return closest.pos
end

check.len = function(list)
  local result = 0
  for _ in pairs(list) do
    result = result +1
  end
  return result
end

check.entity_types_on_same_electric_network_in_area = function(type_list, area_name, update_quest_gui)
  local found_networks = {}
  local area = locations.get_area(area_name)
  assert(area,"requested entity type electric network comparison on invalid area")
  for _, entity_type in pairs(type_list) do
    local entities_of_type = locations.get_main_surface().find_entities_filtered({
      name = entity_type,
      area = area,
    })
    for _, entity in pairs(entities_of_type) do
      local network = entity.electric_network_id
      if network then
        if not found_networks[network] then
          found_networks[network] = {}
        end
        found_networks[network][entity_type] = 1
      end
    end
  end

  local best_state = 1
  for _, types_in_network in pairs(found_networks) do

    local length = 0
    for _,_ in pairs(types_in_network) do
      length = length + 1
    end
    if length > 1 and length < #type_list then
      best_state = math.max(2,best_state)
    elseif length >= #type_list then
      best_state = math.max(3,best_state)
    end

  end
  if update_quest_gui then
    quest_gui.update_state('connect-all-types',best_state)
  end
  return best_state == 3
end

check.chests_emptied = function(chest_list, goal, update_quest_gui)
  if update_quest_gui == nil then
    update_quest_gui = true
  end
  goal = goal or #chest_list

  -- Check each entity by tag in the list
  local result = {total=0,current=0}
  for _, tag in ipairs(chest_list) do
    local chest = locations.get_surface_ent_from_tag(locations.get_main_surface(),tag)
    if chest then
      local inventory = chest.get_inventory(defines.inventory.chest)
      result.total = result.total + 1
      if inventory and inventory.is_empty() then
        result.current = result.current +1
      end
    end
  end

  if update_quest_gui then
    quest_gui.update_count('empty',result.current,goal)
  end

  return result.current >= goal
end

check.bottles_and_tech_started = function(areaname,techname)
  --check that the lab has packs and the technology is set
  local lab = locations.get_structure_in_area('escape-pod-lab',areaname)
  local packs = lab.get_inventory(defines.inventory.lab_input).get_contents()
  local has_packs = false
  for i, quant in pairs(packs) do
    if i == 'automation-science-pack' and quant > 0 then
      has_packs = true
    end
    -- TODO: update pakcs quest gui
  end
  if has_packs then
    quest_gui.update_state('has-packs',3)
  else
    quest_gui.update_state('has-packs',1)
  end

  local research_selected = false
  if (game.forces['player'].current_research and game.forces['player'].current_research.name == techname) or
     game.forces['player'].technologies[techname].researched == true then
    research_selected = true
    quest_gui.update_state('tech-selected',3)
  else
    quest_gui.update_state('tech-selected',1)
  end

  return research_selected and has_packs
end

check.resources_exploited_by_miners = function(resources,goal)
  local drills = game.surfaces[1].find_entities_filtered({name='burner-mining-drill'})
  local res_totals = {}
  for _, res in pairs(resources) do
    res_totals[res] = 0
  end

  for _, drill in ipairs(drills) do
    if drill.mining_target then
      for i, res in ipairs(resources) do
        if drill.mining_target.name == res then
          res_totals[res] = math.floor(game.forces['player'].item_production_statistics.get_input_count(res))
          if res_totals[res] >= goal then
            table.remove(resources,i)
          end
        end
      end
    end
  end

  for res, total in pairs(res_totals) do
    --reset quest item to not complete
    quest_gui.update_count('exploit-'..res,total,goal)
  end

  return #resources == 0
end

check.research_list_complete = function(reseearch_list, update_quest_gui)
  if update_quest_gui == nil then
    update_quest_gui = true
  end

  local all_done = true
  for _, techname in pairs(reseearch_list) do
    local done = game.forces['player'].technologies[techname].researched or game.forces['player'].technologies[techname].level > 2
    all_done = all_done and done

    if update_quest_gui then
      if game.forces['player'].current_research and game.forces['player'].current_research.name == techname then
        quest_gui.update_state('research-'..techname,2)
      elseif game.forces['player'].technologies[techname].researched then
        quest_gui.update_state('research-'..techname,3)
      else
        quest_gui.update_state('research-'..techname,1)
      end
    end
  end

  return all_done
end

check.entity_connected_to_electric_network_in_area = function(entity_type,area_name)
  local area = locations.get_area(area_name)
  assert(area,"check.entity_connected_to_electric_network_in_area: map is missing area: area_name")
  local entities = locations.get_main_surface().find_entities_filtered({
    name = entity_type,
    area = area,
    })
  for _, entity in pairs(entities) do
    if entity.is_connected_to_electric_network() then
      return true
    end
  end
  return false
end

check.entity_placed = function(entity_type, update_quest_gui)
  if update_quest_gui == nil then
    update_quest_gui = true
  end

  local entities = locations.get_main_surface().find_entities_filtered{ name = entity_type, force = 'player' }
  local found_one = #entities > 0

  if update_quest_gui then
    if found_one then
      quest_gui.update_state('place-'.. entity_type,3)
    elseif game.forces['player'].item_production_statistics.get_input_count(entity_type) > 0 then
      quest_gui.update_state('place-'.. entity_type,2)
    else
      quest_gui.update_state('place-'.. entity_type,1)
    end
  end

  return found_one
end

check.entity_powered = function(entity_type, update_quest_gui)
  if update_quest_gui == nil then
    update_quest_gui = true
  end

  local ents = locations.get_main_surface().find_entities_filtered{ name = entity_type, force = 'player' }

  local connection_found = false
  for _, ent in ipairs(ents) do
    if ent.is_connected_to_electric_network() == true then
      connection_found = true
    end
  end

  if update_quest_gui then
    if connection_found then
      quest_gui.update_state('power-'.. entity_type,3)
    else
      quest_gui.update_state('power-'.. entity_type,1)
    end
  end

  return connection_found
end

check.entity_placed_and_powered = function(entity_type, update_quest_gui)
  check.entity_placed(entity_type, update_quest_gui)
  return check.entity_powered(entity_type, update_quest_gui)
end

check.furnace_setup_correct = function()
  local furnaces = locations.get_main_surface().find_entities_filtered({name='stone-furnace'})
  if #furnaces == 0 then
    return false
  end

  local states = {fuelled = false, ore = false}
  for _, furnace in pairs(furnaces) do
    local local_states = {fuelled = false, ore = false}
    if furnace.get_inventory(defines.inventory.fuel).get_item_count('coal') > 0 or
      furnace.get_inventory(defines.inventory.fuel).get_item_count('wood') > 0 or
      furnace.get_inventory(defines.inventory.fuel).get_item_count('solid-fuel') > 0 or
      furnace.burner.heat > 0 then
      local_states.fuelled = true
    end
    if furnace.get_inventory(defines.inventory.furnace_source).get_item_count('iron-ore') > 0 or
       check.player_crafted_list({{name='iron-plate',goal=1}}) then
      local_states.ore = true
    end
    if local_states.fuelled and local_states.ore then
      states = local_states
      break
    elseif (local_states.fuelled == true and states.fuelled == false) or (local_states.ore == true and states.ore == false) then
      states = local_states
    end
  end

  if states.fuelled then
    quest_gui.update_state('furnace-fuel',3)
  else
    quest_gui.update_state('furnace-fuel',1)
  end

  if states.ore then
    quest_gui.update_state('furnace-ore',3)
  else
    quest_gui.update_state('furnace-ore',1)
  end

  return states.fuelled and states.ore

end


check.player_crafted_list = function(list, update_quest_gui)
  if update_quest_gui == nil then
    update_quest_gui = true
  end

  local result = true
  for _,item in pairs(list) do

    if type(item)=='string' then
      item = {name=item,goal=1}
    end

    local count = game.forces['player'].item_production_statistics.get_input_count(item.name)
    if count < item.goal then
      result = false
    end

    if update_quest_gui then
      quest_gui.update_count('craft-' .. item.name, count, item.goal)
    end
  end

  return result
end

check.player_stockpiled_list = function(list)
  local result = true
  for _,item in pairs(list) do
    local made = game.forces['player'].item_production_statistics.get_input_count(item.name)
    local used = game.forces['player'].item_production_statistics.get_output_count(item.name)
    local count = made - used
    -- TODO: update quest gui for this item
    if count == 0 then
      result = false
      quest_gui.update_count('stockpile-'..item.name,0,item.goal)
    elseif count < item.goal then
      result = false
      quest_gui.update_count('stockpile-'..item.name,count,item.goal)
    else
      quest_gui.update_count('stockpile-'..item.name,count,item.goal)
    end
  end
  return result
end

check.area_accumulators_full = function(area_name)
  local area = locations.get_area(area_name)
  local accumulators = locations.get_main_surface().find_entities_filtered({
      name = 'accumulator',
      force = 'player',
      area = area,
    })
  local result = true
  for _, accumulator in pairs(accumulators) do
    if accumulator.energy < 5000 then
      result = false
    end
  end
  return result
end

check.player_built_list_in_area = function(list,area_name)
  local area = locations.get_area(area_name)
  local result = true
  if area then
    for _,entry in pairs(list) do
      local entities = locations.get_main_surface().find_entities_filtered({
          name = entry.name,
          force = 'player',
          area = area
        })
      if #entities < entry.goal then
        result = false
      end
      quest_gui.update_count('build-'..entry.name,#entities,entry.goal)
    end
  end
  return result
end

check.consumer_contains = function(consumer_tag,itemlist)
  if global.consumers == nil then return false end -- TODO: handle this better in the next NPE version
  local consumer = global.consumers[consumer_tag]
  if consumer == nil then return false end
  local result = true
  for index, item in pairs(itemlist) do
    if type(item) == 'string' then
      itemlist[index] = {name=item,goal=1}
    end
  end
  for _, item in pairs(itemlist) do
    if not (consumer[item.name] and consumer[item.name] > item.goal) then
      result = false
    end
  end
  return result
end

check.compi_box_contains = function(compi_box_tag,itemlist,update_quest_gui)
  if update_quest_gui == nil then
    update_quest_gui = true
  end

  local chest = locations.get_surface_ent_from_tag(locations.get_main_surface(),compi_box_tag)
  if chest == nil or chest.name ~= 'compilatron-chest' then
    for _ ,item in pairs(itemlist) do
      if update_quest_gui then
        quest_gui.update_count('compi-'..item.name,0,item.goal)
      end
    end
    return false
  end

  local inv = chest.get_inventory(defines.inventory.chest)
  --check that all quest items could theoretically be inserted
  local possible = true
  for _, item in pairs(itemlist) do
    if not inv.can_insert({name=item.name,count=1}) then
      inv.remove({name=item.name,count=1})
    end
    if not inv.can_insert({name=item.name,count=1}) then
      possible = false
    end
  end
  if possible == false then
    --remove one stack of the most common item
    local most_common = {name=nil, count = -1}
    for name, count in pairs(inv.get_contents()) do
      if count > most_common.count then
        most_common = {name=name,count=count}
      end
    end
    if most_common.name then
      inv.remove({name=most_common.name,count=game.item_prototypes[most_common.name].stack_size})
    end
  end


  local result = true
  for _, item in ipairs(itemlist) do
  local count = inv.get_item_count(item.name)
  if count < item.goal then
  result = false
  end
  if update_quest_gui then
  quest_gui.update_count('compi-'..item.name,math.min(count,item.goal),item.goal)
  end
  end
  return result
  end

check.get_merged_player_item_counts = function(item_list)
  local have_items_map = {}
  for _, item in ipairs(item_list) do
    have_items_map[item.name] = 0
  end

  for _, player in ipairs(game.connected_players) do
    if player.get_inventory(defines.inventory.character_main) then
      for _, item in ipairs(item_list) do
        local count = player.get_inventory(defines.inventory.character_main).get_item_count(item.name)
        have_items_map[item.name] = have_items_map[item.name] + count
      end
    end
  end

  return have_items_map
end

-- Sums inventories of all online players and compares to required amounts
check.player_inventory_contains = function(item_list, update_quest_gui)
  if update_quest_gui == nil then
    update_quest_gui = true
  end

  --sanitizing itemlist
  for index, item in ipairs(item_list) do
    if type(item) == 'string' then
      item_list[index] = { name=item, goal=1}
    end
  end

  local have_items_map = check.get_merged_player_item_counts(item_list)

  local result = true
  for _, item in ipairs(item_list) do
    if have_items_map[item.name] < item.goal then
      result = false
    end

    if update_quest_gui then
      quest_gui.update_count('obtain-'..item.name, have_items_map[item.name], item.goal)
    end
  end
  return result
end

check.remove_from_player_inventories = function(item_list)
  local need = {}
  for _, item in ipairs(item_list) do
    need[item.name] = item.goal
  end

  for _, player in ipairs(game.connected_players) do
    for _, item in ipairs(item_list) do
      local need_count = need[item.name]
      local count_in_player = player.get_inventory(defines.inventory.character_main).get_item_count(item.name)

      local to_take = math.min(count_in_player, need_count)

      if to_take > 0 then
        player.get_inventory(defines.inventory.character_main).remove({name = item.name, count = to_take})
        need[item.name] = need[item.name] - to_take
      end
    end
  end
end

check.player_in_range_of = function(position_name,radius)
  local player = main_player()
  local position = locations.get_pos(position_name)
  if position and math2d.position.distance(player.position,position) < radius then
    quest_gui.update_state('arrive',3)
    return true
  end
  quest_gui.update_state('arrive',1)
  return false
end

check.player_outside_range_of = function(position_name,radius)
  local player = main_player()
  local position = locations.get_pos(position_name)
  if position and math2d.position.distance(player.position,position) > radius then
    quest_gui.update_state('arrive',3)
    return true
  end
  quest_gui.update_state('arrive',1)
  return false
end

check.player_inside_box = function(box)
  local player = game.players[1]
  local area = box
  if area and player.position.x > area.left_top.x and
  player.position.x < area.right_bottom.x and
  player.position.y > area.left_top.y and
  player.position.y < area.right_bottom.y then
    quest_gui.update_state('arrive',3)
    return true
  end
  quest_gui.update_state('arrive',1)
  return false
end

check.player_inside_area = function(area_name, update_quest_gui)
  if update_quest_gui == nil then
    update_quest_gui = true
  end

  local area = locations.get_area(area_name)

  local arrived = false
  for _, player in pairs(game.connected_players) do
    if math2d.bounding_box.contains_point(area, player.position) then
      arrived = true
    end
  end

  if update_quest_gui then
    if arrived then
      quest_gui.update_state('arrive-' .. area_name, 3)
    else
      quest_gui.update_state('arrive-' .. area_name, 1)
    end
  end

  return arrived
end

check.entity_inside_area = function(area_name, entity, update_quest_gui)
  if update_quest_gui == nil then
    update_quest_gui = true
  end

  assert(entity.valid,"Given entity was not valid for checking if it is inside area "..area_name)

  local area = locations.get_area(area_name)

  local arrived = math2d.bounding_box.contains_point(area, entity.position)

  if update_quest_gui then
    if arrived then
      quest_gui.update_state('wait-for-entity-in-' .. area_name, 3)
    else
      quest_gui.update_state('wait-for-entity-in-' .. area_name, 1)
    end
  end

  return arrived
end

check.any_player_inside_area = function(area_name)
  local result = false
  for _, player in pairs(game.connected_players) do
    local area = locations.get_area(area_name)
    if area and player.position.x > area.left_top.x and
    player.position.x < area.right_bottom.x and
    player.position.y > area.left_top.y and
    player.position.y < area.right_bottom.y then
      result = true
    end
  end
  if result == true then
    quest_gui.update_state('players-inside-'..area_name,3)
  else
    quest_gui.update_state('players-inside-'..area_name,1)
  end
  return result
end

check.player_is_loaded = function()
  local player = game.players[1]
  local ammo = player.get_inventory(defines.inventory.character_ammo).get_contents()
  local count = ammo['firearm-magazine']
  --main_player().print("Player has ammo "..(count or "0"))
  local loaded = ((count or 0) > 0)
  if loaded then
    quest_gui.update_state('player-loaded',3)
  else
    quest_gui.update_state('player-loaded',1)
  end
  return loaded
end

check.player_placed_one_of_these= function(event,entlist)
  -- check if this is an entity placed event
  if event.name == defines.events.on_built_entity then
    -- if so is it one of the types we are looking for
    for _, entity in ipairs(entlist) do
      if event.created_entity.name == entity then
        return true
      end
    end
  end
  return false
end

check.any_sector_scanned = function(powered_radar)
  if powered_radar then
    quest_gui.update_state('radar-scan',2)
  else
    quest_gui.update_state('radar-scan',1)
  end

  local scanned = misc.radar_has_scanned_a_sector()

  if scanned then
    quest_gui.update_state('radar-scan',3)
  end

  return scanned
end

check.steam_engine_operational = function(update_gui)
  if update_gui == nil then update_gui = true end
  --the player owns a steam engine that contains steam and is connected to a load
  local engines = game.surfaces[1].find_entities_filtered({name='steam-engine'})
  local boilers = game.surfaces[1].find_entities_filtered({name='boiler'})
  local pumps = game.surfaces[1].find_entities_filtered({name='offshore-pump'})
  if #pumps > 0 and update_gui then
    quest_gui.update_state('build-offshore-pump',3)
  else
    quest_gui.update_state('build-offshore-pump',1)
  end

  local has_fuel = false
  local has_water = false
  if #boilers > 0 then
    for _, boiler in pairs(boilers) do
      if boiler.get_inventory(defines.inventory.fuel).get_item_count('coal') > 0 or
         boiler.get_inventory(defines.inventory.fuel).get_item_count('solid-fuel') > 0 or
         boiler.get_inventory(defines.inventory.fuel).get_item_count('wood') > 0 then
        has_fuel = true
      end
      if boiler.fluidbox[1] and boiler.fluidbox[1].name == 'water' then
        has_water = true
      end
    end
  end

  if has_fuel and has_water and update_gui then
    quest_gui.update_state('provide-water',3)
  elseif has_fuel or has_water then
    quest_gui.update_state('provide-water',2)
  else
    quest_gui.update_state('provide-water',1)
  end

  local any_has_steam = false
  local any_is_connected = false
  local result = false
  for _, engine in pairs(engines) do
    local has_steam = engine.get_fluid_count('steam')>0--(engine.energy > 0)
    local is_connected = engine.is_connected_to_electric_network()
    if has_steam and is_connected then
      result = true
    end
    if has_steam then
      any_has_steam = true
    end
    if is_connected then
      any_is_connected = true
    end
  end

  if any_has_steam and update_gui then
  quest_gui.update_state('provide-steam',3)
    else
  quest_gui.update_state('provide-steam',1)
  end

  if any_is_connected and update_gui then
    quest_gui.update_state('connection',3)
  else
    quest_gui.update_state('connection',1)
  end

  return result
end

check.is_turret_empty = function(turret)
  if turret == nil or turret.valid == false then print("checking non-existant turret for ammo") return false end
  local bullets = turret.get_inventory(defines.inventory.item_main).get_item_count('firearm-magazine')
  return bullets == nil or (bullets and bullets == 0)
end

check.which_turrets_are_empty = function(area_name)
  local area = locations.get_area(area_name)
  local turrets = game.surfaces[1].find_entities_filtered({
    area = area,
    name = 'gun-turret',
    force = 'player'
  })
  local empty_turrets = {}
  if #turrets > 0 then
    for _, turret in ipairs(turrets) do
      if check.is_turret_empty(turret) then
        table.insert(empty_turrets,turret)
      end
    end
  end
  return empty_turrets
end

check.item_produced_per_time = function(item_name,index,goal)
  local force = game.forces.player
  local produced = force.item_production_statistics.get_flow_count({
      name = item_name,
      input = true,
      precision_index = index
      })
  quest_gui.update_count('per-time-'..item_name,math.floor(produced),goal)
  return produced >= goal
end

check.is_turret_broken = function(turret)
  if turret == nil or turret.valid == false then print("checking non-existant turret for health") return false end
  local broken = turret.health < turret.prototype.max_health
  return broken
end


check.which_turrets_are_broken = function(area_name)
  local area = locations.get_area(area_name)
  local turrets = game.surfaces[1].find_entities_filtered({
    area = area,
    name = 'gun-turret',
    force = 'player'
  })
  local broken_turrets = {}
  if #turrets > 0 then
    for _, turret in ipairs(turrets) do
      if check.is_turret_broken(turret) then
        table.insert(broken_turrets,turret)
      end
    end
  end
  return broken_turrets
end

check.loaded_turrets_in_area = function (area_name)
  local total_state = 3
  local area = locations.get_area(area_name)
  local turrets = game.surfaces[1].find_entities_filtered({
    area = area,
    name = 'gun-turret',
    force = 'player'
  })
  for _, turret in ipairs(turrets) do
    local state = 1
    local bullets = turret.get_inventory(defines.inventory.item_main).get_item_count('firearm-magazine')
    if bullets and bullets > 9 then
      state = 3
    elseif bullets and bullets > 4 then
      state = 1
    elseif bullets and bullets < 2 then
      --low bullet, flag red and stop checking other turrets
      total_state = 4
      quest_gui.update_state('loaded-'..area_name, total_state)
      return false
    end
    total_state = math.min(state,total_state)
  end
  if #turrets == 0 then total_state = 1 end
  quest_gui.update_state('loaded-'..area_name,total_state)
  return total_state < 4
end

check.lowest_number_of_turrets_in_areas = function(area_list)
  local lowest_count = 9999
  for _, area_name in ipairs(area_list) do
    local loaded = 0
    local area = locations.get_area(area_name)
    if area then
      local turrets = game.surfaces[1].find_entities_filtered({
        area = area,
        name = 'gun-turret',
        force = 'player'
      })
      for _, turret in ipairs(turrets) do
        if turret.get_inventory(defines.inventory.item_main).get_item_count('firearm-magazine') > 0 then
          loaded = loaded + 1
        end
      end
      lowest_count = math.min(lowest_count,loaded)
    end
  end
  return lowest_count
end

check.number_of_loaded_turrets_in_areas = function(area_list,goal,update)
  local result = true
  for _, area_name in ipairs(area_list) do
    local loaded = 0
    local area = locations.get_area(area_name)
    local count = 0
    if area then
      local turrets = game.surfaces[1].find_entities_filtered({
        area = area,
        name = 'gun-turret',
        force = 'player'
      })
      count = count + #turrets
      for _, turret in ipairs(turrets) do
        if turret.get_inventory(defines.inventory.item_main).get_item_count('firearm-magazine') > 0 then
          loaded = loaded + 1
        end
      end
    end
    if (count > 0 and loaded < goal) or count == 0 then
      result = false
    end
    if update then
      quest_gui.update_count("loaded-"..area_name,loaded,goal)
    end

  end
  return result
end

return check
