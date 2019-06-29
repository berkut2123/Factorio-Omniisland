--- Test Scenario Conditions
-- @module compistory
-- A set of triggers and actions for Compilatron to guide the player

local compi = require(mod_name .. ".lualib.compi")
local activities = require 'helper-activities'
local check = require(mod_name .. ".lualib.check")
local locations = require(mod_name .. ".lualib.locations")
local quest_gui = require(mod_name .. ".lualib.quest_gui")
local math2d = require("math2d")
local story = require("story_2")
local tracker = require(mod_name .. ".lualib.player_tracker")

local get_intermission = function(name)
  return {
    name = "intermission_" .. name,
    condition = function () return story.check_seconds_passed("compi_story",2) end
  }
end

local check_main_story = function(story_node)
  return story.get_current_node_name("main_story") == story_node
end

local check_activities = function()
  if active_player() and game.ticks_played > 0 and game.ticks_played % 30 == 0 then
    local main_story_chapter = story.get_current_node_name("main_story")
    if main_story_chapter and activities[main_story_chapter] then
      for _, activity in pairs(activities[main_story_chapter]) do
        if activity.trigger() then
          global.next_help = activity.story
          break
        end
      end
    end
  end
end

local start_branch =
{
  {
    name = 'initial',
    init = function ()
      global.timers.character_move = game.ticks_played
      global.timers.player_click = game.ticks_played
      global.compilatron.reset = false
      global.helper_memory = {}
    end,

    next = 'goto-idle-spot'
  },
}

local check_loop_branch =
{
  {
    name = 'evaluate-crash-site',
    init = function ()
      --move to closest idle position
      compi.say()
    end,
    update = function ()
      check_activities()
      global.compilatron.reset = false
    end,

    condition = function ()
      return story.check_seconds_passed("compi_story",1)
    end,
    action = function ()
      -- jump to story
      if global.next_help then
        story.jump_to_node("compi_story", global.next_help)

        if campaign_debug_mode then
          print("Compilatron starting next help: "..global.next_help)
        end

        global.next_help = nil
      elseif (not global.compi_is_building) and (not compi.check_range(global.compilatron.wait_position,5)) then
        story.jump_to_node("compi_story", 'goto-idle-spot')
      end
    end,
    next = 'evaluate-crash-site'
  },
}

local goto_idle_spot =
{
  {
    name = 'goto-idle-spot',
    init = function ()
      --move to closest idle position
      global.compilatron.reset = false
      compi.walk_to(global.compilatron.wait_position)
      compi.say()

      if campaign_debug_mode then
        print("compi returning to idle spot")
      end
    end,
    update = function ()
      if game.ticks_played % 120 == 0 then
        compi.walk_to(global.compilatron.wait_position)
      end
    end,
    condition = function ()
      -- is compi at the idle spot
      return compi.check_range(global.compilatron.wait_position,5)
    end,
    next = 'evaluate-crash-site'
  },
}

local new_move_branch =
{
  {
    name = "movement_help"
  },
  {
    name = 'wait_until_leaving_area',
    init = function ()
      compi.say({"compi.teach-use-wasd"})
    end,
    update = function()
      local flip_speed = 1200
      if game.ticks_played % flip_speed == 0 then
        compi.say({"compi.teach-use-wasd"})
      elseif game.ticks_played % (flip_speed/2) == 0 then
        compi.say({"compi.teach-move-outside"})
        compi.indicate(locations.get_area('compi-move-check'))
      end
    end,
    condition = function ()
      return global.compilatron.reset or check.player_inside_area('compi-move-check', false) == false or
      (global.behaviors.moved_up and global.behaviors.moved_down and global.behaviors.moved_left and global.behaviors.moved_right)
    end,
    action = function ()
      compi.remove_display()
    end,
  },
  {
    name = "say_ok",
    init = function ()
      compi.say({"compi.story-assessment-operational"})
      quest_gui.add_hint({'quest-hints.info-move-wasd'})
    end
  },
  get_intermission("move_branch"),
  {
    name = 'move_branch_goto_idle',
    next = 'evaluate-crash-site'
  }
}

local show_click_branch =
{
  {
    name = "click_help"
  },
  {
    name = 'wait_click_wreck_1',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local wreck = locations.get_surface_ent_from_tag(locations.get_main_surface(),'wreck-1')
      compi.stand_next_to(wreck, true, {"compi.teach-open-entity"})
    end,
    condition = function ()
      return global.behaviors.opened_ent or global.compilatron.reset or global.behaviors.used_quick_take or
      check.chests_emptied({'wreck-1'}, 1, false)
    end,
    action = function ()
      compi.remove_display()
      quest_gui.add_hint({'quest-hints.info-move-click'})
    end
  },
  get_intermission("show_click_branch"),
  {
    name = 'wait_click_wreck_2',
    init = function ()
      local wreck = locations.get_surface_ent_from_tag(locations.get_main_surface(),'wreck-2')
      compi.stand_next_to(wreck, true, {"compi.teach-fast-transfer"})
    end,
    condition = function ()
      return check.chests_emptied({'wreck-2'},1,false) or global.compilatron.reset
    end,
    action = function ()
      quest_gui.add_hint({'quest-hints.info-fast-transfer'})
    end,
    next = 'evaluate-crash-site'
  },
}

local show_fuel_branch =
{
  {
    name = "fuel_help"
  },
  {
    name = 'wait_by_fuel_ent',
    init = function ()
      local burners = check.get_list_of_unpowered_burners()
      global.burners_counted = #burners
      if #burners > 0 then
        compi.stand_next_to(burners[math.random(1,#burners)], true, {"compi.teach-add-fuel"})
      end
    end,
    condition = function ()
      local burners = check.get_list_of_unpowered_burners()
      if (#burners) < 1 then tracker.reset_timer('no_fuel') end
      return #burners < 1  or not (#burners == global.burners_counted) or global.compilatron.reset
    end,
    action = function ()
      quest_gui.add_hint({'quest-hints.info-burner-structures'})
      compi.say()
      compi.indicate()
    end,
    next = 'evaluate-crash-site'
  },
}

local second_panic_branch =
{
  {
    name = "packup_panic"
  },
  {
    name = 'goto_player_leave',
    init = function ()
      global.compilatron.wait_position = locations.get_pos('compi-wait-crash')
      compi.walk_to(locations.get_pos('compi-wait-crash'))
      compi.say({"compi.story-suggest-evacuate"})
    end,
    condition = function ()
      local collected = tracker.was_observed('player_collected_important_structures')
      return collected or global.compilatron.reset
    end,
  },
  {
    name = 'goto_leave_spot',
    init = function ()
      compi.walk_to(locations.get_pos('compi-wait-leave'))
    end,
    condition = function ()
      return compi.check_range(locations.get_pos('compi-wait-leave'),5) or global.compilatron.reset
    end,
  },
  {
    name = 'wait_at_leave',
    init = function()
      compi.say({"compi.story-suggest-evacuate"})
    end,
    condition = function ()
      return check_main_story("reach-pond") or global.compilatron.reset
    end,
    next = 'evaluate-crash-site'
  },
}

local scout_pond_branch =
{
  {
    name = "scout_pond"
  },
  {
    name = 'goto_pond_first',
    init = function ()
      compi.walk_to(locations.get_pos('pond'))
    end,
    condition = function ()
      return compi.check_range(locations.get_pos('pond'),5) or global.compilatron.reset
    end,
  },
  {
    name = 'wait_at_pond',
    init = function()
      compi.say({"compi.story-found-water"})
      global.compilatron.wait_position = locations.get_pos('pond')
    end,
    condition = function ()
      return story.check_seconds_passed('compi_story', 60) or
        check_main_story("rebuild") or global.compilatron.reset
    end,
  },
  {
    name = 'goto_player_scout',
    update = function ()
      if game.ticks_played % 180 == 0 then

        compi.walk_to(active_player().position)
        compi.say({"compi.story-found-water"})
      end
    end,
    condition = function ()
      return compi.check_range(active_player().position,5) or global.compilatron.reset
    end,
    action = function()

    end
  },
  {
    name = 'show_pond',
    init = function ()

      compi.walk_to(locations.get_pos('pond'))
      compi.say({"compi.story-found-water"})
    end,
    condition = function ()
      return compi.check_range(locations.get_pos('pond'),5) or global.compilatron.reset
    end,
  },
  {
    name = 'wait_at_pond_before_rescout',
    init = function()
      compi.say({"compi.story-found-water"})
    end,
    condition = function ()
      return story.check_seconds_passed('compi_story', 10) or global.compilatron.reset
    end,
    action = function ()

      if global.compilatron.reset then
        story.jump_to_node('compi_story', 'evaluate-crash-site')
      else
        story.jump_to_node('compi_story', 'goto_player_scout')
      end
    end
  },
}

local show_stone_branch =
{
  {
    name = "stone_help"
  },
  {
    name = 'wait_at_stone',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local position = locations.get_pos('crash-stone-patch')
      local stone = locations.get_main_surface().find_entities_filtered({position=position,name='stone'})[1]
      compi.stand_next_to(stone, true, {"compi.teach-mine-stone"})
    end,
    condition = function ()
      return global.behaviors.mined_stone or global.compilatron.reset
    end,
    action = function()
      quest_gui.add_hint({'quest-hints.info-hand-mining'})
    end,
    next = 'evaluate-crash-site'
  },
}

local show_research_branch =
{
  {
    name = "research_help"
  },
  {
    name = 'show_t_button',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local lab = locations.get_structure_in_area('escape-pod-lab','starting-area')
      compi.stand_next_to(lab)
      compi.say_later({"compi.teach-open-research-menu"})
    end,
    condition = function ()
      return global.behaviors.opened_technology or global.compilatron.reset
    end,
    action = function ()
      global.timers.no_bottles = game.ticks_played
      quest_gui.add_hint({'quest-hints.info-research-screen'})
    end,
    next = 'evaluate-crash-site'
  },
}

local show_alt_mode_branch =
{
  {
    name = "alt_mode_help"
  },
  {
    name = 'show_alt_button',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local position = locations.get_pos('crash-site')
      compi.walk_to(position)
      compi.say_later({"compi.teach-alt-mode"})
    end,
    condition = function ()
      return global.behaviors.used_alt_mode or global.compilatron.reset
    end,
    action = function ()
      quest_gui.add_hint({'quest-hints.info-alt-mode'})
    end,
    next = 'evaluate-crash-site'
  },
}

local show_bottles_branch =
{
  {
    name = "bottles_help"
  },
  {
    name = 'show_bottles',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local lab = locations.get_structure_in_area('escape-pod-lab','starting-area')
      compi.stand_next_to(lab)
      compi.say_later({"compi.teach-bottles"})
      compi.indicate(lab.selection_box)
    end,
    condition = function ()
      tracker.check_lab()
      return global.behaviors.loaded_bottles or global.compilatron.reset
    end,
    action = function ()
      quest_gui.add_hint({'quest-hints.info-science-packs'})
    end,
    next = 'evaluate-crash-site'
  }
}

local show_chest_branch =
{
  {
    name = "chest_help"
  },
  {
    name = 'wait_by_blocked_ent',
    init = function ()
      local blocked = check.get_list_of_powered_blocked_miners()
      global.blocked_counted = #blocked
      if #blocked > 0 then
        local box = math2d.bounding_box.create_from_centre(blocked[math.random(1,#blocked)].drop_position,1)
        compi.stand_next_to(box, true, {"compi.teach-miner-output"})
      end
    end,
    condition = function ()
      local blocked = check.get_list_of_powered_blocked_miners()
      if (#blocked) < 1 then tracker.reset_timer('blocked_miner') end
      return #blocked < 1  or not (#blocked == global.blocked_counted) or global.compilatron.reset
    end,
    action = function ()
      quest_gui.add_hint({'quest-hints.info-miner-output'})
      compi.remove_display()
    end,
    next = 'evaluate-crash-site'
  },
}

local set_pond_wait_branch =
{
  {
    name = "set_pond_wait",
    init = function ()
      global.compilatron.wait_position = locations.get_pos('compi-wait-pond')
    end,
    condition = function() return true end,

    next = 'evaluate-crash-site'
  }
}

local show_inv_help =
{
  {
    name = "inv_help"
  },
  {
    name = 'show_e_button',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local position = main_player().position
      compi.walk_to(position)
      compi.say_later({"compi.teach-open-inventory"})
      --quests.expand_subquests(true)
    end,
    condition = function()
      return global.behaviors.opened_inventory
    end,
    action = function ()
      quest_gui.add_hint({'quest-hints.info-inventory'})
      global.timers.no_stone = game.ticks_played
    end,
    next = 'evaluate-crash-site'
  },
}

local show_control_click =
{
  {
    name = "ctrl_click_help"
  },
  {
    name = 'show_ctrl_click',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local chest = tracker.check_chest_for_coal()
      if chest then
        compi.stand_next_to(chest, true, {"compi.teach-fast-transfer"})
      end
    end,
    condition = function()
      return tracker.check_chest_for_coal() == nil or global.compilatron.reset or
        tracker.was_observed('used_quick_take_coal') or
        story.check_seconds_passed('compi_story',60)
    end,
    action = function()
      quest_gui.add_hint({'quest-hints.info-fast-transfer'})
    end,
    next = 'evaluate-crash-site'
  },
}

local show_iron_stocked =
{
  {
    name = "stockpile_help"
  },
  {
    name = 'show_iron',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local chest = tracker.check_chest_for_items({'iron-plate'},50)
      if chest then
        global.helper_memory.stockpile_chest = chest
        compi.stand_next_to(chest, true, {"compi.teach-fast-transfer"})
      else
        tracker.reset_timer('full_item_chest')
        global.compilatron.reset = true
      end
    end,
    condition = function()
      return global.helper_memory.stockpile_chest == nil or
        global.helper_memory.stockpile_chest.valid == false or
        global.helper_memory.stockpile_chest.get_inventory(defines.inventory.chest).is_empty() or
        story.check_seconds_passed('compi_story',60) or
        global.compilatron.reset
    end,
    action = function()
      global.helper_memory.stockpile_chest = nil
      quest_gui.add_hint({'quest-hints.info-fast-transfer'})
      tracker.reset_timer('full_item_chest')
    end,
    next = 'evaluate-crash-site'
  },
}

local show_repair_pack =
{
  {
    name = "show_repair_pack"
  },
  {
    name = 'show_pack',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local turrets = locations.get_main_surface().find_entities_filtered({name='gun-turret'})
      local damaged = {}
      for _, turret in pairs(turrets) do
        if turret.health < turret.prototype.max_health then
          table.insert(damaged,turret)
        end
      end

      local pond_pos = locations.get_pos('pond')
      local closest = check.closest_entity(pond_pos,damaged)
      if closest then
        compi.stand_next_to(closest, true, {"compi.teach-repair-turret"})
      end
    end,
    condition = function()
      return global.behaviors.has_repaired or global.compilatron.reset or
        story.check_seconds_passed('compi_story',120)
    end,
    action = function ()
      quest_gui.add_hint({'quest-hints.info-repair-pack'})
    end,
    next = 'evaluate-crash-site'
  },
}

local check_ammo_branch =
{
  {
    name = "check_ammo"
  },
  {
    name = 'goto_nearest_turret',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      global.nearest_empty_turret = check.closest_entity(global.compilatron.entity.position,
                                                         check.which_turrets_are_empty('east-expansion'))
      if global.nearest_empty_turret then
        local closest_warning_point = check.closest_position(global.nearest_empty_turret.position,
                                                             {locations.get_pos('compi-east-warning'),
                                                              locations.get_pos('compi-west-warning')})
        compi.walk_to(closest_warning_point)
        compi.indicate(global.nearest_empty_turret.selection_box)
        compi.say({"compi.teach-load-turret"})
      end
    end,
    condition = function ()
      return global.nearest_empty_turret == nil or global.compilatron.moving == false or global.compilatron.reset
    end,
  },
  {
    name = 'wait_at_turret',
    condition = function ()
      return global.nearest_empty_turret == nil or
      check.is_turret_empty(global.nearest_empty_turret) == false or global.compilatron.reset or
        #check.which_turrets_are_empty('east-expansion') == 0 or
        story.check_seconds_passed('compi_story',30)
    end,
    action = function ()
      tracker.reset_timer('ammo_warning')
      quest_gui.add_hint({'quest-hints.info-turret-ammo'})
      if #check.which_turrets_are_empty('east-expansion') > 0 and global.compilatron.reset == false then
        story.jump_to_node('compi_story','check_ammo')
      else
        global.nearest_empty_turret = nil
        story.jump_to_node('compi_story','evaluate-crash-site')
      end
    end
  },
}

local check_turret_health_branch =
{
  {
    name = "check_health"
  },
  {
    name = 'goto_nearest_broken_turret',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      global.nearest_broken_turret = check.closest_entity(global.compilatron.entity.position,
                                                          check.which_turrets_are_broken('east-expansion'))
      if global.nearest_broken_turret then
        local closest_warning_point = check.closest_position(global.nearest_broken_turret.position,
                                                             {locations.get_pos('compi-east-warning'),
                                                              locations.get_pos('compi-west-warning')})

        compi.walk_to(closest_warning_point)
        compi.indicate(global.nearest_broken_turret.selection_box)
        compi.say({"compi.teach-repair-turret"})
      end
    end,
    condition = function()
      return global.nearest_broken_turret == nil or global.compilatron.moving == false or global.compilatron.reset
    end,
  },
  {
    name = 'wait_at_broken_turret',
    init = function()
    end,
    condition = function()
      return global.nearest_broken_turret == nil or
      check.is_turret_broken(global.nearest_broken_turret) == false or global.compilatron.reset or
      #check.which_turrets_are_broken('east-expansion') == 0 or
        story.check_seconds_passed('compi_story',30)
    end,
    action = function ()
      tracker.reset_timer('repair_warning')
      quest_gui.add_hint({'quest-hints.info-repair-pack'})
      if #check.which_turrets_are_broken('east-expansion') > 0 and global.compilatron.reset == false then
        story.jump_to_node('compi_story','check_health')
      else
        global.nearest_broken_turret = nil
        story.jump_to_node('compi_story','evaluate-crash-site')
      end
    end
  },
}

local place_quest_chest_and_wait =
{
  {
    name = "place_quest_chest",
  },
  {
    name = "go_to_chest_location",
    init = function()
      local template_compi_box = locations.get_surface_ent_from_tag(locations.get_template_surface(),'compi-box-machine')
      compi.stand_next_to(template_compi_box.bounding_box)
    end,
  },
  {
    name = "do_place_chest",
    condition = function ()
      return not compi.moving()
    end,

    action = function()
      local template_compi_box = locations.get_surface_ent_from_tag(locations.get_template_surface(),'compi-box-machine')

      -- make sure we don't do anything silly, like... trap the player inside a box...
      -- https://forums.factorio.com/viewtopic.php?t=65924
      local new_position = locations.get_main_surface().find_non_colliding_position(template_compi_box.prototype.name,
                                                                           template_compi_box.position,
                                                                           0, -- radius
                                                                           1, -- precision
                                                                           true) -- force_to_tile_center

      local new_box = template_compi_box.clone({
        position=new_position,
        surface=locations.get_main_surface(),
        force= template_compi_box.force
      })
      new_box.minable = false
      compi.stand_next_to(new_box, true, {"compi.story-waiting-quest-items"})
    end,
  },
  {
    name = "chest_placed_wait",

    condition = function()
      return global.compilatron.reset
    end,

    next = 'evaluate-crash-site'
  }
}

local gear_feed_help_branch =
{
  {
    name = "gear_feed_help",
  },
  {
    name = "go_to_gear_feed",
    init = function()
      if locations.get_surface_ent_from_tag(locations.get_main_surface(),'compi-box-gear') then
        compi.stand_next_to(locations.get_surface_ent_from_tag(locations.get_main_surface(),'compi-box-gear'))
      else
        global.compilatron.reset = true
      end
    end,
  },
  {
    name = "gear_feed_arrive",
    condition = function ()
      return not compi.moving()
    end,
    action = function()
      local main_feed = locations.get_surface_ent_from_tag(locations.get_main_surface(),'compi-box-gear')
      compi.say({"compi.teach-feed-plates"})
      compi.indicate(main_feed.selection_box)
    end,
  },
  {
    name = 'gear_feed_wait',
    update = function()
      if game.ticks_played % 240 ~= 0 then
        return
      end
      if check.compi_box_contains('compi-box-gear',{{name='iron-plate',goal=1}},false) then
        global.behaviors.compi_box_has_been_fed = true
      end
    end,
    condition = function()
      return global.compilatron.reset or story.check_seconds_passed('compi_story', 30) or global.behaviors.compi_box_has_been_fed
    end,
    action = function()
      quest_gui.add_hint({'quest-hints.info-rotate'})
      global.behaviors.compi_box_has_been_fed = false
      compi.remove_display()
    end,

    next = 'evaluate-crash-site'
  }
}

local lab_feed_help_branch =
{
  {
    name = "lab_feed_help",
  },
  {
    name = "go_to_lab",
    init = function()
      if locations.get_surface_ent_from_tag(locations.get_main_surface(),'compi-box-lab') then
        compi.stand_next_to(locations.get_surface_ent_from_tag(locations.get_main_surface(),'compi-box-lab'))
      else
        global.compilatron.reset = true
      end
    end,
  },
  {
    name = "lab_arrive",
    init = function()
    end,
    condition = function ()
      return not compi.moving()
    end,
    action = function()
      local main_feed = locations.get_surface_ent_from_tag(locations.get_main_surface(),'compi-box-lab')
      compi.indicate(main_feed.selection_box)
      compi.say({"compi.teach-feed-items"})
    end,
  },
  {
    name = "lab_wait",
    update = function()
      if game.ticks_played % 240 ~= 0 then
        return
      end
      if check.compi_box_contains('compi-box-lab',{{name='iron-gear-wheel',goal=1}},false) or
      check.compi_box_contains('compi-box-lab',{{name='copper-plate',goal=1}},false) then
        global.behaviors.compi_box_has_been_fed = true
      end
    end,
    condition = function()
      return global.compilatron.reset or story.check_seconds_passed('compi_story', 30) or global.behaviors.compi_box_has_been_fed
    end,
    action = function()
      compi.remove_display()
    end,

    next = 'evaluate-crash-site'
  }
}

local place_help_branch =
{
  {
    name = "place_help",
  },
  {
    name = 'goto_player_place',
    init = function()
      tracker.log_behavior('compi_helped',300)
    end,
    update = function ()
      if game.ticks_played % 180 == 0 then
        compi.stand_next_to(active_player().character)
        compi.say_later({"compi.teach-take-in-hand"})
      end
    end,
    condition = function()
      return compi.check_range(active_player().position,5) or global.compilatron.reset
    end
  },
  {
    name = "tell_take_item",
    condition = function ()
      return (active_player().cursor_stack.valid_for_read and active_player().cursor_stack.name == 'stone-furnace') or
        global.compilatron.reset or
        story.check_seconds_passed('compi_story', 60) or
        global.behaviors.built_entity
    end,
    action = function()
      if not (active_player().cursor_stack.valid_for_read and active_player().cursor_stack.name == 'stone-furnace') then
        global.compilatron.reset = true
      end
    end
  },
  {
    name = "tell_place_item",
    init = function()
      compi.say({"compi.teach-build-structure"})
      local free_spot = locations.get_main_surface().find_non_colliding_position('stone-furnace',active_player().position,10,1)
      local box = table.deepcopy(game.entity_prototypes['stone-furnace'].selection_box)
      local w,h = box.right_bottom.x - box.left_top.x, box.right_bottom.y - box.left_top.y
      box.left_top.x =  free_spot.x - w
      box.left_top.y = free_spot.y - h
      box.right_bottom.x = free_spot.x + w
      box.right_bottom.y = free_spot.y + h
      compi.indicate(box)
    end,
    update = function()
      if game.ticks_played % 60 ~= 0 then return end
      if main_player().cursor_stack.valid_for_read == false then
        compi.remove_display()
        global.compilatron.reset = true
      end
    end,
    condition = function()
      return global.compilatron.reset or story.check_seconds_passed('compi_story', 60) or global.behaviors.built_entity
    end,
    action = function()
      quest_gui.add_hint({'quest-hints.info-build'})
      compi.remove_display()
      tracker.reset_timer('no_placed')
    end,
    next = 'evaluate-crash-site'
  }
}

local wait_for_cutscene_crash =
{
  {
    name = "wait_for_cutscene_crash",
  },
  {
    name = 'goto_cutscene_trigger_crash',
    init = function ()
      compi.walk_to(locations.get_pos('compi-wait-cutscene-crash'))
      compi.say_later({"compi.story-waiting-for-player"})
    end,
    condition = function()
      return global.compilatron.reset
    end,
    next = 'evaluate-crash-site'
  },
}

local wait_for_cutscene_pond =
{
  {
    name = "wait_for_cutscene_pond",
  },
  {
    name = 'goto_cutscene_trigger_pond',
    init = function ()
      compi.walk_to(locations.get_pos('compi-wait-cutscene-pond'))
      compi.say_later({"compi.story-waiting-for-player"})
    end,
    condition = function()
      return check.player_inside_area('compi-trigger-cutscene-pond', false) or global.compilatron.reset
    end,
    next = 'evaluate-crash-site'
  },
}

local demonstrate_power_connection =
{
  {
    name = "show_power",
  },
  {
    name = 'goto_crash_power',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local ship_power = locations.get_surface_ent_from_tag(locations.get_main_surface(),'ship-power')
      compi.stand_next_to(ship_power)
      compi.indicate(ship_power)
      compi.say_later({"compi.teach-power"})
    end,
    condition = function()
      return check.entity_types_on_same_electric_network_in_area(
        {
          'escape-pod-power',
          'assembling-machine-1'
        },
        'starting-area',false) or global.compilatron.reset
    end,
    action = function()
      quest_gui.add_hint({'quest-hints.info-pole'})
    end,
    next = 'evaluate-crash-site'
  },
}

local demonstrate_tree =
{
  {
    name = "show_tree",
  },
  {
    name = 'goto_random_tree',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local trees = locations.get_main_surface().find_entities_filtered({type='tree',area=locations.get_area('tree-demo-area')})
      if #trees > 0 then
        local random_tree = trees[math.random(1,#trees)]
        compi.stand_next_to(random_tree)
        compi.indicate(random_tree)
        compi.say_later({"compi.teach-harvest-tree"})
      end
    end,
    condition = function()
      return global.compilatron.reset or
        story.check_seconds_passed('compi_story', 10) or
        check.player_crafted_list({'wooden-chest'}, false) or
        check.player_inventory_contains({'wood'}, false)
    end,
    next = 'evaluate-crash-site'
  },
}

local demonstrate_loading =
{
  {
    name = "show-loading",
  },
  {
    name = 'goto_fixed_assembling_machine',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local gear_assemblers = locations.get_main_surface().find_entities_filtered({name='escape-pod-assembler'})
      if #gear_assemblers > 0 then
        local position = {
          x = gear_assemblers[1].position.x - 2,
          y = gear_assemblers[1].position.y - 1,
        }
        local box = math2d.bounding_box.create_from_centre(position,1)
        compi.stand_next_to(gear_assemblers[1])
        compi.indicate(box)
        compi.say_later({"compi.teach-inserting"})
      end
    end,
    condition = function()
      return global.compilatron.reset or
        story.check_seconds_passed('compi_story', 30) or
      check.consumer_contains('gear-feed',{'iron-gear-wheel'}) or
      check.entity_count_with_contents_in_area('escape-pod-assembler',{'iron-gear-wheel'},'starting-area',1)
    end,
    action = function()
      quest_gui.add_hint({'quest-hints.info-inserter'})
      tracker.log_behavior('player_loaded_gear_assembler',1)
    end,
    next = 'evaluate-crash-site'
  },
}

local demonstrate_salvage =
{
  {
    name = "show-salvage",
  },
  {
    name = 'goto_mineable_salvage',
    init = function ()
      tracker.log_behavior('compi_helped',300)
      local first_scrap = locations.get_surface_ent_from_tag(locations.get_main_surface(),'wreck-3')
      local scraps = locations.get_main_surface().find_entities_filtered({name='mineable-wreckage'})
      local target = first_scrap
      if target == nil then
        target = scraps[1]
      end
      compi.stand_next_to(target)
      compi.indicate(target)
      compi.say_later({"compi.teach-mine-salvage"})
    end,
    condition = function()
      return global.compilatron.reset or
        story.check_seconds_passed('compi_story', 30) or
      global.behaviors.mined_wreckage or
      check.entity_count_in_area('mineable-wreckage','starting-area') == 0
    end,
    action = function()
      quest_gui.add_hint({'quest-hints.info-remove-structure'})
    end,
    next = 'evaluate-crash-site'
  },
}

local chapters =
{
  start_branch,
  goto_idle_spot,
  check_loop_branch,
  new_move_branch,
  show_click_branch,
  place_help_branch,
  show_research_branch,
  show_bottles_branch,
  show_stone_branch,
  show_fuel_branch,
  show_alt_mode_branch,
  show_chest_branch,
  second_panic_branch,
  scout_pond_branch,
  set_pond_wait_branch,
  show_inv_help,
  show_control_click,
  show_iron_stocked,
  show_repair_pack,
  check_ammo_branch,
  check_turret_health_branch,
  place_quest_chest_and_wait,
  gear_feed_help_branch,
  lab_feed_help_branch,
  wait_for_cutscene_crash,
  wait_for_cutscene_pond,
  demonstrate_power_connection,
  demonstrate_tree,
  demonstrate_loading,
  demonstrate_salvage,
}

local flatten_array_of_arrays = function(arrays)
  local result = {}

  for _, array in pairs(arrays) do
    for _, value in pairs(array) do
      table.insert(result, value)
    end
  end

  return result
end

return flatten_array_of_arrays(chapters)
