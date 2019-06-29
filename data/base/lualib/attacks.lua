local locations = require(mod_name .. ".lualib.locations")
local pollution = require(mod_name .. ".lualib.pollution")
local story = require("story_2")
require 'util'

local attacks = {}

local structures = nil
local attacks_data = {
  current_attack_structure = nil,
  next_wave = nil,
  biter_costs = {},
  structures = {},
}

local generate_biter_costs = function()
  local biter_costs = {}
  for _, biter in pairs(game.entity_prototypes) do
    if biter.pollution_to_join_attack and biter.pollution_to_join_attack > 1 then
      biter_costs[biter.name] = biter.pollution_to_join_attack
    end
  end
  return biter_costs
end

-- Functions which calculate modifiers during play
attacks.modifiers= {}

attacks.modifiers.get_ammo_effect = function()
  if main_player().controller_type == defines.controllers.character then
    local ammo = game.players[1].get_inventory(defines.inventory.character_ammo).get_contents()
    local count = ammo['firearm-magazine'] or 0
    local capped = math.min(count,10)
    return 1/10*capped
  else
    return 0
  end
end

attacks.modifiers.ten_minutes = function()
  local ten_minutes = 60*10
  local passed = story.get_seconds_passed_since_current_node_started("main_story")
  --print("time passed in story: "..passed)
  local ratio = math.max(math.min(passed/ten_minutes,1),0.01)
  return ratio
end

attacks.modifiers.get_turrets_effect = function()
  -- return 0-1
  -- 8 turrets returns 1
  local quant = 10
  local count = 0
  local turrets = locations.get_main_surface().find_entities_filtered({
    name = 'gun-turret',
    force = 'player'
    })
  for _, turret in pairs(turrets) do
    local bullets = turret.get_inventory(defines.inventory.item_main).get_item_count('firearm-magazine')
    if bullets > 0 then
      count = count + 1
    end
  end
  return 1/quant*math.min(count,quant)
end

attacks.modifiers.get_turret_effect = function()
  -- return 0-1
  -- 1 turrets returns 1
  local turrets = locations.get_main_surface().find_entities_filtered({
    name = 'gun-turret',
    force = 'player'
    })
  for _, turret in pairs(turrets) do
    local bullets = turret.get_inventory(defines.inventory.item_main).get_item_count('firearm-magazine')
    if bullets > 0 then
      return 1
    end
  end
  return 0
end

attacks.modifiers.get_final_research_progress = function()
  -- return 0-1 as percent of final research complete
  local force = game.forces['player']
  local progress
  if force.current_research and force.current_research.name == 'demo-science-pack' then
    progress = force.research_progress
  else
    progress = force.get_saved_technology_progress('demo-science-pack')
  end
  progress = progress or 0
  --print("technology progress "..progress)
  return progress
end

attacks.random_position_from_area = function(area_name)
  local area = locations.get_area(area_name)
  assert(area,"attempted to use invalid area for random_position "..area_name)
  local w = area.right_bottom.x - area.left_top.x
  local h = area.right_bottom.y - area.left_top.y
  local random_position = {
      x = area.left_top.x + (math.random()*w),
      y = area.left_top.y + (math.random()*h),
    }
  return random_position
end

attacks.random_position_from_position = function(pos_name,factor)
  local pos = locations.get_pos(pos_name)
  assert(pos,"attempted to use invalid pos for random position "..pos_name)
  local x_random = math.random(-1*factor,factor)
  local y_random = math.random(-1*factor,factor)
  local random_position = {
      x = pos.x + x_random,
      y = pos.y + y_random,
    }
  return random_position
end

attacks.send_edge_attack = function(force)
  assert(attacks_data.next_wave,"attacks.send_edge_attack: trying to send non-existent wave")
  local wave = attacks_data.next_wave
  local surface = locations.get_main_surface()

  --prepare spawn, rally and target areas
  --here rally_area and spawn_area change into positions
  if type(wave.spawn_area) == 'string' then
    wave.spawn_area = attacks.random_position_from_area(wave.spawn_area)
  end
  if wave.rally_area and type(wave.rally_area) == 'string' then
    wave.rally_area = attacks.random_position_from_area(wave.rally_area)
  end
  if type(wave.target_area) == 'string' then
    wave.target_area = locations.get_area(wave.target_area)
  end

  --generate target list
  local targets = {}
  local disallowed_targets = {
    'straight-rail',
    'curved-rail',
    'rail',
    'big-electric-pole',
  }
  if #wave.target_types > 0 then
    targets = surface.find_entities_filtered({name=wave.target_types, area=wave.target_area})
  end
  if #targets == 0 then
    targets = surface.find_entities_filtered({
      force = {'enemy','pre-placed','neutral','train-gate'},
      area = wave.target_area,
      name = disallowed_targets,
      invert = true,
    })
  end
  if #targets == 0 then return end --no valid targets

  --spawn biters and send them to attack individually
  for _, biter_type in pairs(wave.biters) do
    local actual_pos = surface.find_non_colliding_position(biter_type,wave.spawn_area,20,2)
    if not actual_pos then
      if campaign_debug_mode then
        error("Couldn't find position to spawn biter")
      else
        break
      end
    end
    local biter = surface.create_entity{name = biter_type, position= actual_pos, force = force}
    biter.ai_settings.path_resolution_modifier = -2

    local target_entity = targets[math.random(#targets)]

    local commands = {}
    if wave.rally_area then
      table.insert(commands,{
        type = defines.command.go_to_location,
        destination=wave.rally_area,
        distraction = defines.distraction.by_damage,
        radius = 10,
        pathfind_flags = {prefer_straight_paths=true}
      })
    end

    table.insert(commands,{
          type = defines.command.attack,
          target=target_entity,
          distraction = defines.distraction.by_damage
        })

    table.insert(commands,{
          type = defines.command.wander,
          radius = 30,
          distraction = defines.distraction.by_anything,
        })

    biter.set_command({
      type = defines.command.compound,
      structure_type = defines.compound_command.return_last,
      commands = commands,
    })
  end
  pollution.spend_pollution(wave.cost)

end

local function calculate_cost_modifer(attack)
  if type(attack.cost) == 'number' then return attack.cost end
  local variable_cost = attack.cost.maximum - attack.cost.minimum
  local modifier = 0
  local weight_total = 0
  for _, scale_function in pairs(attack.modifiers) do
    local value = math.min(attacks.modifiers[scale_function.name](),1)
    for _=1, scale_function.weight do
      modifier = modifier + value
      weight_total = weight_total + 1
    end
  end
  modifier = modifier/weight_total
  modifier = 1-modifier

  local actual_cost = attack.cost.minimum + (variable_cost*modifier)

  return actual_cost
end

attacks.build_wave_structure = function(attack)
  print("DEBUG: building wave: "..attack.name)

  --randomize vector
  local vector = attack.vector[math.random(#attack.vector)]

  --randomise spawn, rally and target locations
  local new_wave = {
    spawn_area = vector.spawn[math.random(#vector.spawn)],
    rally_area = nil,
    target_area = vector.target[math.random(#vector.target)],
    target_types = vector.target_types,
    cost = 0,
    mission = vector.mission,
    biters = {}
  }

  if #vector.rally > 0 then
    new_wave.rally_area = vector.rally[math.random(#vector.rally)]
  end

  --randomise total number, accepting both fixed value and range
  local total_biters_in_wave = 1
  if type(attack.wave) == 'number' then
    total_biters_in_wave = attack.wave
  elseif type(attack.wave) == 'table' then
    total_biters_in_wave = math.random(attack.wave.minimum,attack.wave.maximum)
  end

  --calculate actual cost
  local wave_cost_mod = calculate_cost_modifer(attack)

  --copy the biters allowed types list from the vector
  local local_types = util.table.deepcopy(vector.allowed_biter_types)

  --add minimum values from biter target_types
  for _, biter_type in pairs(local_types) do
    biter_type.current = 0
    if biter_type.min > 0 then
      for _ = 1, biter_type.min do
        print(biter_type.name)
        table.insert(new_wave.biters,biter_type.name)
        biter_type.current = biter_type.current + 1
        new_wave.cost = new_wave.cost +
          attacks_data.biter_costs[biter_type.name]*
            biter_type.modifier*
            wave_cost_mod
      end
    end
  end

  --if the minimum is already enough, then stop here
  if #new_wave.biters >= total_biters_in_wave then
    return new_wave
  end

  -- add randomly until wave size reached
  local slots_remaining = total_biters_in_wave - #new_wave.biters
  for _ = 1, slots_remaining do
    local choice_number = math.random(#local_types)
    local choice = local_types[choice_number]
    if choice.current >= choice.max then
      table.remove(local_types,choice_number)
    else
      table.insert(new_wave.biters,choice.name)
      choice.current = choice.current + 1
      new_wave.cost = new_wave.cost + attacks_data.biter_costs[choice.name]*choice.modifier
    end
    if #local_types == 0 then break end
  end
  if campaign_debug_mode then
    print("DEBUG: Planned attack:",new_wave.spawn_area,"->",
      new_wave.rally_area or "->","->",new_wave.target_area,serpent.line(new_wave.biters))
  end
  return new_wave
end

attacks.check_spawn_wave = function(attack,force)
  if attacks_data.biter_costs == nil then
    attacks_data.biter_costs = {}
    for _, biter in pairs(game.entity_prototypes) do
      if biter.pollution_to_join_attack and biter.pollution_to_join_attack > 1 then
        attacks_data.biter_costs[biter.name] = biter.pollution_to_join_attack
      end
    end
  end


  if attacks_data.next_wave and attacks_data.next_wave.cost < global.pollution_unspent then
    attacks.send_edge_attack(force)
    attacks_data.next_wave = attacks.build_wave_structure(structures[attack])
  elseif attacks_data.next_wave == nil then
    attacks_data.next_wave = attacks.build_wave_structure(structures[attack])
  else
    if campaign_debug_mode then
      print("DEBUG: Pollution until next attack:",attacks_data.next_wave.cost - global.pollution_unspent)
    end
  end
end

attacks.pause = function()
  if attacks_data.current_attack_structure then
    attacks_data.last_attack_structure = attacks_data.current_attack_structure
    attacks_data.current_attack_structure = nil
  end
end

attacks.resume = function()
  if attacks_data.current_attack_structure == nil then
    attacks_data.current_attack_structure = attacks_data.last_attack_structure
  end
end

attacks.set_attack_structure = function(structure_name)
  if not structure_name then
    attacks_data.last_attack_structure = attacks_data.current_attack_structure
    attacks_data.current_attack_structure = nil
    return
  end
  assert(structures[structure_name],"attacks.set_attack_structure: invalid attack structure name "..structure_name)
  attacks_data.last_attack_structure = attacks_data.current_attack_structure
  attacks_data.current_attack_structure = structure_name
end

attacks.get_attack_structure = function()
  return attacks_data.current_attack_structure
end

local update_pollution_and_attack = function()
  if game.ticks_played % 240 == 0 and attacks_data.current_attack_structure then
    assert(structures[attacks_data.current_attack_structure],
      "attacks.update: attempting to use invalid attack structure name "..attacks_data.current_attack_structure)
    pollution.check_pollution()
    attacks.check_spawn_wave(attacks_data.current_attack_structure,game.forces.enemy)
  end
end

attacks.on_load = function(waves)
  attacks_data = global.attacks_data or attacks_data
  structures = waves
end

attacks.migrate = function()
  if global.CAMPAIGNS_VERSION < 4 then
    attacks_data = {
      current_attack_structure = nil,
      next_wave = nil,
      biter_costs = generate_biter_costs(),
      structures = {},
    }
    global.attacks_data = attacks_data
    game.create_force('pre-placed')
    game.create_force('train-gate')
  end
end

attacks.init = function(_structures)
  game.map_settings.path_finder.use_path_cache = false
  game.map_settings.steering.moving.force_unit_fuzzy_goto_behavior = true
  structures = _structures
  global.attacks_data = attacks_data
  attacks_data.biter_costs = generate_biter_costs()
end


attacks.events = {
  [defines.events.on_tick] = update_pollution_and_attack,
}

return attacks
