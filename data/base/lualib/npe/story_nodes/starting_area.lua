local effect = require(mod_name .. ".lualib.effects")
local quest_gui = require(mod_name .. ".lualib.quest_gui")
local locations = require(mod_name .. ".lualib.locations")
local pollution = require(mod_name .. ".lualib.pollution")
local tracker = require(mod_name .. ".lualib.player_tracker")
local compi = require(mod_name .. '.lualib.compi')
local check = require(mod_name .. ".lualib.check")
local popup = require(mod_name .. ".lualib.popup")
local colony_controller = require(mod_name .. '.lualib.colony_controller')
local attacks = require(mod_name .. '.lualib.attacks')
local gui_helpers = require(mod_name .. '.lualib.npe.gui_helpers')
local story = require('story_2')

local starting_area = {}

starting_area.story_nodes = {}


starting_area.story_nodes['intro'] =
{
  init = function()
    local force = game.forces.player
    force.set_hand_crafting_disabled_for_recipe('electronic-circuit', true)
    force.set_hand_crafting_disabled_for_recipe('copper-cable', true)
    force.set_hand_crafting_disabled_for_recipe('iron-gear-wheel', true)
    force.set_hand_crafting_disabled_for_recipe('automation-science-pack', true)
    force.set_hand_crafting_disabled_for_recipe('iron-stick', true)

    game.forces.player.item_production_statistics.set_output_count('coal', 0)
    --local gear_feed = locations.get_surface_ent_from_tag(locations.get_main_surface(),'gear-feed')
    --gear_feed.destroy()
    --local lab_feed = locations.get_surface_ent_from_tag(locations.get_main_surface(),'lab-feed')
    --lab_feed.destroy()
    local compi_boxes = locations.get_main_surface().find_entities_filtered{ name = 'compilatron-chest'}
    for _, box in pairs(compi_boxes) do
      box.destroy()
    end

    effect.activate_research(false)
    effect.activate_side_menu(false)
    effect.activate_quick_bar(false)
    effect.activate_shortcut_bar(false)
    effect.activate_controller_gui(false)

    -- Remove the copper setup - compi will build it later
    local ents = locations.get_main_surface().find_entities_filtered
    {
      force = 'player',
      area = locations.get_area('iron-patch-construction')
    }
    for _, ent in pairs(ents) do
      ent.destroy()
    end

    -- Remove the gear feed setup - compi will build it later
    ents = locations.get_main_surface().find_entities_filtered
    {
      force = 'player',
      area = locations.get_area('gear-feed-construction')
    }
    for _, ent in pairs(ents) do
      ent.destroy()
    end

    -- Remove the lab feed setup - compi will build it later
    ents = locations.get_main_surface().find_entities_filtered
    {
      force = 'player',
      area = locations.get_area('lab-feed-construction')
    }
    for _, ent in pairs(ents) do
      ent.destroy()
    end

    game.forces.player.technologies['basic-mining'].researched = true
    game.forces.player.technologies['basic-logistics'].researched = true
    popup.clear_all()
    --effect.show_text_window({'introduction.heading'},{
    --    {'introduction.text-1'},
    --    {'introduction.text-2'},
    --    {'introduction.text-3'},
    --    {'introduction.text-4'},
    --    {'introduction.thanks'},
    --  })
    --game.tick_paused = true
  end,
  action = function()
    global.player_closed_text_window = nil

    effect.activate_controller_gui(true)
  end
}


starting_area.story_nodes['explore'] = {
  init = function()
    local quest_layout =
    {
      {
        item_name = 'empty',
        goal = 2,
      },
      {
        item_name = 'remove-mineable-wreckage',
        goal = 1,
      },
    }
    quest_gui.set('explore', quest_layout)
    effect.unlock_technologies('explore', false)
    effect.discover_all_tech_levels()
    quest_gui.visible(true)
    global.compilatron.reset = true
  end,

  condition = function()
    local supplies = check.chests_emptied({'wreck-1','wreck-2'},2)
    local salvage = check.entities_removed_from_area('mineable-wreckage','starting-area',12,1)
    return supplies and salvage
  end,

  action = function()
    quest_gui.add_hint({'quest-hints.info-move-wasd'})
    quest_gui.add_hint({'quest-hints.info-move-click'})
    quest_gui.add_hint({'quest-hints.info-fast-transfer'})
    quest_gui.add_hint({'quest-hints.info-remove-structure'})
    quest_gui.unset()
    global.compilatron.reset = true
  end,
}


starting_area.story_nodes['handmining'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = "place-stone-furnace",
        children =
        {
          {
            item_name = "craft-stone-furnace",
            goal = 1,
            icons = { "item/stone-furnace" },
            children =
            {
              {
                item_name = "was-observed-mined_stone",
                icons = { "item/stone" },
              }
            }
          },
        }
      }
    }
    gui_helpers.set_opened_state('container',2)
    quest_gui.set('handmining', quest_layout)
    --campaign_util.set_quick_bar({'stone-furnace'})
    global.compilatron.wait_position = locations.get_pos('crash-site')
    quest_gui.visible(true)
    global.compilatron.reset = true
  end,

  condition = function()
    local crafted = check.player_crafted_list({{name='stone-furnace',goal=1}})
    local placed = check.entity_placed('stone-furnace')
    check.times_behavior_observed('mined_stone',1)
    return placed and crafted
  end,

  action = function()
    quest_gui.add_hint({'quest-hints.info-hand-mining'})
    quest_gui.add_hint({'quest-hints.info-inventory'})
    quest_gui.add_hint({'quest-hints.info-build'})
    quest_gui.unset()
  end,
}


starting_area.story_nodes['smelting'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'craft-burner-mining-drill',
        icons = {'item/burner-mining-drill'},
        goal = 1,

        children =
        {
          {
            item_name = 'craft-iron-plate',
            icons = {'item/iron-plate'},
            goal = 3,
            children =
            {
              {
                item_name = 'furnace-ore',
                icons = {'item/iron-ore'},
              },
              {
                item_name = 'furnace-fuel',
                icons = {'item/coal','item/wood'}
              }
            }
          }
        }
      }
    }

    quest_gui.set('smelting', quest_layout)
    global.compilatron.wait_position = locations.get_pos('crash-site')
    quest_gui.visible(true)
    global.compilatron.reset = true
  end,

  condition = function()
    check.furnace_setup_correct()
    local crafted = check.player_crafted_list({
      {name='burner-mining-drill',goal=1},
      {name='iron-plate',goal=3},
    })
    return crafted
  end,

  action = function()
    quest_gui.add_hint({'quest-hints.info-burner-structures'})
    quest_gui.unset()
  end,
}


starting_area.story_nodes['automining'] = {
  init = function()
    local quest_layout =
    {
      {
        item_name = 'exploit-coal',
        icons = {'item/coal'},
        goal = 9,
      },
      {
        item_name = 'obtain-coal',
        icons = {'item/coal'},
        goal = 5,
      },
    }

    quest_gui.set('automining', quest_layout)
    quest_gui.visible(true)
    global.compilatron.wait_position = locations.get_pos('crash-site')
    global.compilatron.reset = true
  end,

  condition = function()
    local coal_obtain = check.player_inventory_contains(
    {
      {name='coal',goal=5},
    })
    local coal_exploit = check.resources_exploited_by_miners({'coal'},9)

    return coal_obtain and coal_exploit
  end,

  action = function()
    quest_gui.add_hint({'quest-hints.info-burner-structures'})
    quest_gui.add_hint({'quest-hints.info-miner-output'})
    quest_gui.add_hint({'quest-hints.info-fast-transfer'})
    quest_gui.unset()
  end,
}


starting_area.story_nodes['handcrafting'] =
{
  init = function()

    local quest_layout =
    {
      {
        item_name = 'arrive-compi-wait-cutscene-crash',
        children = {
          {
            item_name = 'craft-burner-mining-drill',
            icons = {'item/burner-mining-drill'},
            goal = 2,
          },
          {
            item_name = 'craft-transport-belt',
            icons = {'item/transport-belt'},
            goal = 2,
          },
          {
            item_name = 'craft-burner-inserter',
            icons = {'item/burner-inserter'},
            goal = 1,
          },
        }
      }
    }

    quest_gui.set('handcrafting', quest_layout)
    quest_gui.visible(true)
    global.compilatron.wait_position = locations.get_pos('crash-site')
    global.compilatron.reset = true
  end,

  condition = function()
    local has_crafted = check.player_crafted_list({
      {name='burner-mining-drill',goal=2},
      {name='burner-inserter',goal=1},
      {name='transport-belt',goal=2},
    })
    return has_crafted
  end,

  action = function()
    quest_gui.unset()
  end,
}


starting_area.story_nodes['trigger-build'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'arrive-compi-wait-cutscene-crash',
        children =
        {
          {
            item_name = 'obtain-burner-mining-drill',
            icons = { 'item/burner-mining-drill' },
            goal = 1,
          },
          {
            item_name = 'obtain-transport-belt',
            icons = { 'item/transport-belt' },
            goal = 2,
          },
          {
            item_name = 'obtain-burner-inserter',
            icons = { 'item/burner-inserter' },
            goal = 1,
          },
        }
      }
    }

    quest_gui.set('trigger-build', quest_layout)
    quest_gui.visible(true)
    global.compilatron.reset = true
    game.auto_save("repair-assembler")
  end,

  condition = function()
    local has_in_inventory = check.player_inventory_contains({
      {name='burner-mining-drill',goal=1},
      {name='burner-inserter',goal=1},
      {name='transport-belt',goal=2},
    })
    local arrive = check.player_inside_area('compi-trigger-cutscene-crash', false)
    return arrive and has_in_inventory
  end,

  action = function()
    effect.take_items_from_player({
      {name='burner-mining-drill',count=1},
      {name='burner-inserter',count=1},
      {name='transport-belt',count=2},
    })
    quest_gui.visible(false)
    compi.say()
  end,
}


starting_area.story_nodes['repair-assembler'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'compi-iron-plate',
        icons = {'item/iron-plate'},
        goal = 50,
      },
    }

    quest_gui.set('repair-assembler', quest_layout)
    quest_gui.visible(true)
     quest_gui.add_hint({'quest-hints.info-pickup-items'})
    global.compilatron.wait_position = locations.get_pos('compi-gear-wait')
    global.compilatron.reset = true
    compi.build_area('gear-feed-construction', {force = 'player'})
  end,

  condition = function()
    local default = 0
    local feed, count = check.compi_box_contains('compi-box-gear',{{name='iron-plate',goal=50}})
    count = count or default
    if count > 0 then
      tracker.log_behavior('gear_has_been_fed',1)
    end
    return feed
  end,

  action =  function()
    effect.swap_tagged_with_fixed_recipe('iron-gear-wheel-wreck','iron-gear-wheel')
    effect.replace_compi_box('compi-box-gear',{{name='iron-plate',goal=50}})
    effect.unlock_entities_in_area('gear-feed-construction')

    quest_gui.add_hint({'quest-hints.info-rotate'})
    quest_gui.add_hint({'quest-hints.info-fast-transfer'})
    quest_gui.add_hint({'quest-hints.info-burner-structures'})
    quest_gui.add_hint({'quest-hints.info-move-click'})
    quest_gui.unset()
  end,
}


starting_area.story_nodes['power-assembler'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'power-escape-pod-assembler',
        icons = {'item/escape-pod-assembler'},
        children = {
          {
            item_name = 'craft-small-electric-pole',
            icons = {'item/small-electric-pole'},
            goal = 2,
          }
        }
      },
    }

    quest_gui.set('power-assembler', quest_layout)
    quest_gui.visible(true)
    global.compilatron.wait_position = locations.get_pos('compi-gear-wait')
    global.compilatron.reset = true
  end,

  condition = function()
    local powered = check.entity_powered('escape-pod-assembler')
    local poles = check.player_crafted_list({{name='small-electric-pole',goal=2}})
    return powered and poles
  end,
}


starting_area.story_nodes['repair-lab'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'compi-copper-plate',
        icons = {'item/copper-plate'},
        goal = 50,
      },
      {
        item_name = 'compi-iron-gear-wheel',
        icons = {'item/iron-gear-wheel'},
        goal = 50,
      },
    }

    global.compilatron.reset = true
    quest_gui.set('repair-lab', quest_layout)
    global.compilatron.wait_position = locations.get_pos('compi-lab-wait')
    compi.build_area('lab-feed-construction', {force = 'player'})

    quest_gui.visible(true)
  end,

  condition = function()
    local default = 0
    local feed, count = check.compi_box_contains('compi-box-lab',{
        {name='iron-gear-wheel',goal=50},
        {name='copper-plate',goal=50},
      })
    count = count or default
    if count > 0 then
      tracker.log_behavior('lab_has_been_fed',1)
    end
    return feed
  end,

  action = function()
    effect.swap_tagged_with_fixed_recipe('automation-science-pack-wreck','automation-science-pack')
    effect.swap_tagged_with_fixed_entity('lab-wreck','escape-pod-lab')
    effect.replace_compi_box('compi-box-lab',{{name='copper-plate',goal=50},{name='iron-gear-wheel',goal=50}})
    effect.unlock_entities_in_area('lab-feed-construction')

    quest_gui.add_hint({'quest-hints.info-inserter'})
    quest_gui.add_hint({'quest-hints.info-alt-mode'})
    quest_gui.unset()
  end,
}


starting_area.story_nodes['load-lab'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'research-basic-electronics',
        children =
        {
          {
            item_name = 'has-packs',
            icons = {'item/lab','item/automation-science-pack'},
          },
          {
            item_name = 'tech-selected',
          },
        }
      },
    }

    effect.activate_research(true)
    effect.unlock_technologies('load-lab')
    global.compilatron.reset = true
    quest_gui.set('load-lab', quest_layout)
    quest_gui.visible(true)
    global.compilatron.wait_position = locations.get_pos('compi-lab-wait')
  end,

  condition = function()
    check.bottles_and_tech_started('starting-area','basic-electronics')
    local researched = check.research_list_complete({'basic-electronics'})
    return researched
  end,

  action = function()
    quest_gui.add_hint({'quest-hints.info-research-screen'})
    quest_gui.add_hint({'quest-hints.info-science-packs'})
    quest_gui.unset()
  end,
}


starting_area.story_nodes['electronics'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'craft-electronic-circuit',
        icons = {'item/electronic-circuit'},
        goal = 5,
        children =
        {
          {
            item_name = 'power-assembling-machine-1',
            icons = {'item/small-electric-pole'},
          },
          {
            item_name = 'place-assembling-machine-1',
            icons = {'item/assembling-machine-1'},
          },
        }
      },
    }


    global.compilatron.reset = true
    quest_gui.set('electronics', quest_layout)
    quest_gui.visible(true)
  end,

  condition = function()
    local built = check.entity_placed_and_powered('assembling-machine-1')
    local circuits = check.player_crafted_list({{name='electronic-circuit',goal=5}})
    return (built and circuits )
  end,

  action = function()
    quest_gui.add_hint({'quest-hints.info-pole'})
    quest_gui.unset()
  end
}


starting_area.story_nodes['build-radar'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'power-radar',
        icons = {'item/small-electric-pole'},
        children =
        {
           {
            item_name = 'place-radar',
            icons = {'item/radar'},
            children =
            {
              {
                item_name = 'research-basic-mapping',
              },
            }
          },
        }
      },
    }

    global.compilatron.reset = true
    effect.unlock_technologies('build-radar')
    quest_gui.set('build-radar', quest_layout)
    quest_gui.visible(true)
  end,

  condition = function()
    check.research_list_complete({'basic-mapping'})
    local built = check.entity_placed_and_powered('radar')
    return built
  end,

  action = function()
    effect.activate_radar(true)
    quest_gui.visible(false)
  end,
}


starting_area.story_nodes['trigger-radar'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'arrive-compi-trigger-cutscene-crash',
      },
    }

    global.compilatron.reset = true
    quest_gui.set('trigger-radar', quest_layout)
    quest_gui.visible(true)
    game.auto_save("scan-wreck")
  end,

  condition = function()
    local arrive = check.player_inside_area('compi-trigger-cutscene-crash')
    return arrive
  end,

  action = function()
    effect.activate_radar(true)
    quest_gui.visible(false)
    compi.say()
  end,
}


starting_area.story_nodes['scan-wreck'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'research-analyse-ship',
      },
    }

    effect.unlock_technologies('scan-wreck')
    global.compilatron.reset = true
    quest_gui.set('scan-wreck', quest_layout)
    quest_gui.visible(true)
  end,

  condition = function()
    local researched = check.research_list_complete({'analyse-ship'})
    return researched
  end,

  action = function()
    pollution.reset()

    quest_gui.add_hint({'quest-hints.info-fast-transfer'})
    quest_gui.add_hint({'quest-hints.info-alt-mode'})
    quest_gui.unset()
  end,
}


starting_area.story_nodes['trigger-attacks'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'arrive-compi-trigger-cutscene-crash',
      },
    }

    global.compilatron.reset = true
    quest_gui.set('trigger-attacks', quest_layout)
    quest_gui.visible(true)
    game.auto_save("prepare-evacuation")
  end,

  condition = function()
    local arrive = check.player_inside_area('compi-trigger-cutscene-crash')
    return arrive
  end,

  action = function()
    compi.say()
    quest_gui.visible(false)
  end,
}


starting_area.story_nodes['prepare'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'obtain-lab',
        icons = {'item/lab'},
        goal = 1,
      },
      {
        item_name = 'obtain-assembling-machine-1',
        icons = {'item/assembling-machine-1'},
        goal = 3,
      },
      {
        item_name = 'obtain-offshore-pump',
        icons = {'item/offshore-pump'},
        goal = 1,
      },
      {
        item_name = 'obtain-steam-engine',
        icons = {'item/steam-engine'},
        goal = 1,
      },
      {
        item_name = 'obtain-boiler',
        icons = {'item/boiler'},
        goal = 1,
      },
      {
        item_name = 'obtain-small-electric-pole',
        icons = {'item/small-electric-pole'},
        goal = 4,
      },
    }

    global.compilatron.reset = true
    quest_gui.set('prepare', quest_layout)
    pollution.reset()
    quest_gui.visible(true)
    local close_wreck_colony = colony_controller.register('colony-crash-west',0,1,'peaceful',true)
    close_wreck_colony.next_build.cost = 45
    close_wreck_colony.next_update = game.ticks_played - 1
  end,

  update = function()
    if game.tick % (60 * 10) ~= 0 then
      return
    end
    effect.turn_biters_around({'safe-1','safe-2','safe-3'},'crash-site')
    if tracker.times_observed('player_attacked_with_pickaxe') > 2 then
      attacks.check_spawn_wave('packup')
    end
  end,

  condition = function()
    local power = check.player_inventory_contains(
    {
      {name='assembling-machine-1',goal=3},
      {name='lab',goal=1},
      {name='offshore-pump',goal=1},
      {name='boiler',goal=1},
      {name='steam-engine',goal=1},
      {name='small-electric-pole',goal=4},
    })

    return power
  end,

  action = function()
    quest_gui.visible(false)
  end,
}


starting_area.story_nodes['leave'] =
{
  init = function()
    local quest_layout =
    {

      {
        item_name = 'arrive-exit-right',
        children = {
          {
            item_name = 'wait-for-entity-in-exit-right',
          },
        }
      },
      {
        item_name = 'collect',
      },
    }
    global.entities_mined_at_quest_start = tracker.times_observed('mined_entity')
    global.compilatron.reset = true
    effect.make_peaceful_biters_wander('starting-area')
    game.forces['player'].set_spawn_position(locations.get_pos('exit-right'),locations.get_main_surface())
    quest_gui.set('leave', quest_layout)
    pollution.reset()
    quest_gui.visible(true)
    local iron_colony = colony_controller.register('colony-crash-iron',0,1,'peaceful')
    iron_colony.next_build.cost = 29
    game.auto_save("leave")
  end,

  update = function()
    if game.tick % (60 * 10) ~= 0 then
      return
    end
    effect.turn_biters_around({'safe-1','safe-2','safe-3'},'crash-site')

    if colony_controller.exists('colony-crash-iron') and (not colony_controller.exists('colony-crash-copper'))
      and story.check_minutes_passed('main_story',3) then
      local copper_colony = colony_controller.register('colony-crash-copper',0,1,'peaceful')
      copper_colony.next_build.cost = 29
    end

    if colony_controller.exists('colony-crash-copper') and (not colony_controller.exists('crashsite-nest-1'))
      and story.check_minutes_passed('main_story',5) then
      local close_colony = colony_controller.register('crashsite-nest-1',0,1,'peaceful')
      close_colony.next_build.cost = 29
    end

    if colony_controller.exists('colony-crash-iron') and (not colony_controller.exists('crashsite-nest-5'))
      and story.check_minutes_passed('main_story',8) then
      local close_colony_2 = colony_controller.register('crashsite-nest-5',0,1,'peaceful')
      close_colony_2.next_build.cost = 29
    end

    if tracker.times_observed('player_attacked_with_pickaxe') > 2 then
      attacks.check_spawn_wave('packup')
    end
  end,

  condition = function()
    local collected = check.entities_removed_since(global.entities_mined_at_quest_start,5)
    local important_entities_remaining = locations.get_main_surface().find_entities_filtered({
      name = {
        'assembling-machine-1',
        'burner-mining-drill',
        'stone-furnace',
        'inserter',
        'small-electric-pole',
      },
    })
    if collected or #important_entities_remaining == 0 then
      quest_gui.update_state('collect',3)
      tracker.log_behavior('player_collected_important_structures',1)
    end
    local ran = check.player_inside_area('exit-right')
    local compilatron_is_there = check.entity_inside_area('exit-right',global.compilatron.entity)
    return ran and compilatron_is_there and (collected or #important_entities_remaining == 0)
  end,

  action = function()
    quest_gui.visible(false)
    compi.say()
    colony_controller.deregister('crashsite-nest-1')
    colony_controller.deregister('crashsite-nest-5')
  end,
}


for name, node in pairs(starting_area.story_nodes) do
    node.name = name
end

return starting_area