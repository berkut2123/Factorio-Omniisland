local check = require(mod_name .. ".lualib.check")
local locations = require(mod_name .. ".lualib.locations")

local check_behavior_not_observed = function(behavior)
  if global.behaviors[behavior] == nil then
      return true
  end
  return false
end

local check_timer = function(timer,wait_ticks,start_timer)
  if global.timers[timer] == nil and start_timer then global.timers[timer] = game.ticks_played end
  if global.timers[timer] then
    if game.ticks_played > global.timers[timer] + (wait_ticks*global.compilatron.wait_time_modifier) then
      return true
    end
  end
  return false
end

local check_timer_and_behavior = function(timer,behavior,wait_ticks,start_timer)
  if global.timers[timer] == nil and start_timer then global.timers[timer] = game.ticks_played end
  if global.timers[timer] and global.behaviors[behavior] == nil then
    if game.ticks_played > global.timers[timer] + (wait_ticks*global.compilatron.wait_time_modifier) then
      return true
    end
  end
  return false
end

local check_timer_and_crafted = function(timer,recipes,wait_ticks,start_timer)
  if global.timers[timer] == nil and start_timer then global.timers[timer] = game.ticks_played end
  if global.timers[timer] and check.player_crafted_list(recipes, false) then
    if game.ticks_played > global.timers[timer] + (wait_ticks*global.compilatron.wait_time_modifier) then
      return true
    end
  end
  return false
end

local check_entity_timer_and_behavior = function(entity_type,entity_quant,timer,behavior,wait_ticks,start_timer)
  local ents = game.surfaces[1].find_entities_filtered({name=entity_type})
  if #ents > entity_quant then
    if global.timers[timer] == nil and start_timer  then global.timers[timer] = game.ticks_played end
    return check_timer_and_behavior(timer,behavior,wait_ticks,start_timer)
  end
  return false
end

local activities = {}

activities['explore'] =
{
  {
    trigger = function()
      return check_timer_and_behavior('character_move','moved',600,true)
    end,
    story = "movement_help"
  },
  {
    trigger = function()
      return check_timer_and_behavior('player_click','opened_ent',60*30,true) and
      not (check.chests_emptied({'wreck-1'},1,false) or check.chests_emptied({'wreck-2'},1,false))
    end,
    story = "click_help"
  },
  {
    trigger = function()
      return check_timer('player_mined',60*45,true) and check.entity_count_in_area('mineable-wreckage','starting-area') > 0
    end,
    story = "show-salvage"
  },
}

activities['handmining'] =
{
  {
    trigger = function()
      return check_timer_and_behavior('no_inventory','opened_inventory',60*30,true)
    end,
    story = "inv_help"
  },
  {
    trigger = function()
      return check_timer_and_behavior('no_stone','mined_stone',60*40,true)
    end,
    story = "stone_help"
  },
  {
    trigger = function()
      local built = check_behavior_not_observed('built_entity')
      local inventory = check_behavior_not_observed('opened_inventory')
      local time_craft = check_timer_and_crafted('no_placed',{{name='stone-furnace',goal=1}},60*30,true)
      return built and (not inventory) and time_craft

    end,
    story = "place_help"
  }
}
activities['smelting'] =
{
  {
    trigger = function()
      local burners = check.get_list_of_unpowered_burners()
      local timer = check_timer('no_fuel',(60*30),false)
      return (#burners > 0) and timer
    end,
    story = "fuel_help"
  },
}
activities['automining'] =
{
  {
    trigger = function()
      local burners = check.get_list_of_unpowered_burners()
      local timer = check_timer('no_fuel_automining',(60*60),true)
      return (#burners > 0) and timer
    end,
    story = "fuel_help"
  },
  {
    trigger = function()
      return check_timer_and_behavior('blocked_miner', 'mined_wood',60*15,true) and
        not (
          check.player_crafted_list({ 'wooden-chest'}, false) or
          check.player_inventory_contains({ 'wood' }, false)
        )
    end,
    story = "show_tree"
  },
  {
    trigger = function()
      return check_entity_timer_and_behavior('burner-mining-drill',0,'blocked_miner',
        'placed_output',(60*5),false)
    end,
    story = "chest_help"
  },
  {
    trigger = function()
      return check_timer_and_behavior('full_coal_chest','used_quick_take_coal',(60*15),false)
    end,
    story = "ctrl_click_help"
  },

}
activities['handcrafting'] =
{

}

activities['trigger-build'] =
{
  {
    trigger = function() return true end,
    story = "wait_for_cutscene_crash"
  }
}

activities['repair-assembler'] =
{
  {
    trigger = function()
      if global.compi_is_building then
        return false
      end

      local burners = check.get_list_of_unpowered_burners()
      local timer = check_timer('no_fuel_repair',(60*60),true)
      return (#burners > 0) and timer
    end,
    story = "fuel_help"
  },
  {
    trigger = function()
      if global.compi_is_building then
        return false
      end
      return check_timer_and_behavior('full_coal_chest','used_quick_take_coal',(60*60),false)
    end,
    story = "ctrl_click_help"
  },
  {
    trigger = function()
      return check_timer('full_item_chest',60,false)
    end,
    story = "stockpile_help"
  },
  {
    trigger = function()
      if global.compi_is_building then
        return false
      end
      return locations.get_surface_ent_from_tag(locations.get_main_surface(),'compi-box-gear') and
      (not check.consumer_contains('compi-box-gear',{'iron-plate'})) and
      check_behavior_not_observed('compi_box_has_been_fed')
    end,
    story = "gear_feed_help"
  },
}

activities['power-assembler'] = {
  {
    trigger = function()
      return check_timer('power-assembler-begins',60*30,true)
    end,
    story = "show_power"
  }
}

activities['repair-lab'] =
{
  {
    trigger = function()
      if global.compi_is_building then
        return false
      end
      return check_timer_and_behavior('repair-lab-begins','used_alt_mode',60*5,true)
    end,
    story = "alt_mode_help"
  },
  {
    trigger = function()
      if global.compi_is_building then
        return false
      end
      return check.entity_count_in_area('escape-pod-assembler','starting-area',1) and
        (not check.consumer_contains('compi-box-gear',{ 'iron-gear-wheel'})) and
        check_behavior_not_observed('player_loaded_gear_assembler') and
        check_timer('repair-lab-begins',60*20,true)
    end,
    story = "show-loading"
  },
  {
    trigger = function()
      if global.compi_is_building then
        return false
      end
      return global.behaviors.compi_box_has_been_fed == false
    end,

    story = "lab_feed_help" },
}

activities['load-lab'] =
{
  {
    trigger = function()
      return check_timer_and_behavior('no_research','opened_technology',60*15,true)
    end,
    story = "research_help"
  },
  {
    trigger = function()
      return check_timer_and_behavior('no_research','loaded_bottles',60*30)
    end,
    story = "bottles_help"
  }
}

activities['electronics'] =
{

}

activities['trigger-radar'] = {
  {
    trigger = function() return true end,
    story = "wait_for_cutscene_crash"
  }
}

activities['scan-wreck'] =
{
  {
    trigger = function()
      return check_timer_and_behavior('full_coal_chest','used_quick_take_coal',(60*15),false)
    end,
    story = "ctrl_click_help"
  },
  {
    trigger = function()
      return check_timer_and_behavior('scan-begins','used_alt_mode',(60*10),true)
    end,
    story = "alt_mode_help"
  }
}

activities['trigger-attacks'] = {
  {
    trigger = function() return true end,
    story = "wait_for_cutscene_crash"
  }
}

activities['prepare'] =
{

}

activities['leave'] =
{
  {trigger = function() return true end, story = "packup_panic" },
}

activities['reach-pond'] =
{
  {trigger = function() return true end, story = "scout_pond" },
}

activities['rebuild'] =
{
  {
    trigger = function()
      return (global.compilatron.wait_position.x == locations.get_pos('compi-wait-pond').x and
        global.compilatron.wait_position.y == locations.get_pos('compi-wait-pond').y) == false
    end, story = "set_pond_wait"
  }
}

activities['military'] =
{
  {
    trigger = function()
      return (global.compilatron.wait_position.x == locations.get_pos('compi-wait-pond').x and
        global.compilatron.wait_position.y == locations.get_pos('compi-wait-pond').y) == false
    end,
    story = "set_pond_wait"
  }
}

activities['trigger-second-wave'] = {
  {
    trigger = function() return true end,
    story = "wait_for_cutscene_pond"
  }
}

activities['entrench'] =
{
  {
    trigger = function()
      return (global.compilatron.wait_position.x == locations.get_pos('compi-wait-pond').x and
        global.compilatron.wait_position.y == locations.get_pos('compi-wait-pond').y) == false
    end, story = "set_pond_wait"
  },
  {
    trigger = function()
      return check.research_list_complete({'repair-tech'}, false) and
        check_timer_and_behavior('turret_damaged','has_repaired',(60*15),false)
    end,
    story = "show_repair_pack"
  },
  {
    trigger = function()
      return #check.which_turrets_are_empty('east-expansion') > 0 and
        check_timer('ammo_warning',60*30,true)
    end,
    story = "check_ammo"
  }
}

activities['fortify'] =
{
  {
    trigger = function()
      return (global.compilatron.wait_position.x == locations.get_pos('compi-wait-pond').x and
        global.compilatron.wait_position.y == locations.get_pos('compi-wait-pond').y) == false
    end,
    story = "set_pond_wait"
  },
  {
    trigger = function()
      return #check.which_turrets_are_empty('east-expansion') > 0 and
        check_timer('ammo_warning',60*15,true)
    end,
    story = "check_ammo"
  },
  {
    trigger = function()
      return check.research_list_complete({ 'repair-tech'}, false) and #check.which_turrets_are_broken('east-expansion') > 0 and
        check_timer('repair_warning',60*15,true)
    end,
    story = "check_health"
  }
}


activities['survive'] =
{
  {
    trigger = function()
      return (global.compilatron.wait_position.x == locations.get_pos('compi-wait-pond').x and
        global.compilatron.wait_position.y == locations.get_pos('compi-wait-pond').y) == false
    end,
    story = "set_pond_wait"
  },
  {
    trigger = function()
      return #check.which_turrets_are_empty('east-expansion') > 0 and
        check_timer('ammo_warning',60*15,true)
    end,
    story = "check_ammo"
  },
  {
    trigger = function()
      return check.research_list_complete({ 'repair-tech'}, false) and #check.which_turrets_are_broken('east-expansion') > 0 and
        check_timer('repair_warning',60*15,true)
    end,
   story = "check_health"
  }
}

return activities
