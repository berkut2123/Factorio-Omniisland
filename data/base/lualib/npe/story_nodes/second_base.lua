local effect = require(mod_name .. ".lualib.effects")
local pollution = require(mod_name .. ".lualib.pollution")
local quest_gui = require(mod_name .. ".lualib.quest_gui")
local check = require(mod_name .. ".lualib.check")
local attacks = require(mod_name .. ".lualib.attacks")
local story = require("story_2")
local locations = require(mod_name .. ".lualib.locations")
local popup = require(mod_name .. ".lualib.popup")
local attack = require(mod_name .. ".lualib.attacks")
local cutscene = require(mod_name .. ".lualib.cutscene")
local scenes = require(mod_name .. '.lualib.npe.scenes')
local expansions = require(mod_name .. '.lualib.npe.expansions')
local soft_death = require(mod_name .. '.lualib.soft_death')

local second_base = {}

second_base.story_nodes = {}

second_base.story_nodes['reach-pond'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'arrive',
      },
    }

    global.compilatron.reset = true
    game.forces['player'].set_spawn_position(locations.get_pos('pond-player-spawn'),locations.get_main_surface())
    quest_gui.set('reach-pond', quest_layout)
    effect.turn_biters_hostile('starting-area')
    quest_gui.visible(true)
  end,

  update = function()
    effect.turn_biters_around({'safe-1','safe-2','safe-3','safe-4'},'crash-site')
  end,

  condition = function()
    return check.player_inside_area('pond', false)
  end,

  action = function()
    effect.turn_biters_hostile('starting-area')
    quest_gui.visible(false)
  end,
}


second_base.story_nodes['rebuild'] =
{
  init = function()
    effect.activate_quick_bar(true)
    effect.activate_shortcut_bar(true)
    local quest_layout =
    {
      {
        item_name = 'research-improved-equipment',
      },
      {
        item_name = 'power-lab',
        icons = {'item/lab'},
        children =
        {
          {
            item_name = 'connection',
            icons = {'item/small-electric-pole'},
          },
          {
            item_name = 'provide-steam',
            icons = {'item/steam-engine','fluid/steam'},
            children =
            {
              {
                item_name = 'provide-water',
                icons = {'item/boiler','fluid/water','item/coal'},
                children =
                {
                  {
                    item_name = 'build-offshore-pump',
                    icons = {'item/offshore-pump'},
                  },
                }
              },
            }
          },
        }
      },
    }

    effect.unlock_technologies('rebuild')
    global.compilatron.reset = true
    quest_gui.set('rebuild', quest_layout)
    quest_gui.visible(true)
    game.auto_save("rebuild")
  end,

  condition = function(event)
    -- these checks are expensive, so only do them once a second
    if event.tick % 60 ~= 0 then return end

    check.steam_engine_operational()
    check.entity_powered('lab')
    local researched = check.research_list_complete({'improved-equipment'})
    return researched
  end,

  action = function()
    quest_gui.visible(false)
  end
}

second_base.story_nodes['military'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'player-loaded',
        children =
        {
          {
            item_name = 'craft-firearm-magazine',
            icons = {'item/firearm-magazine'},
            goal = 10
          },
        }
      },
      {
        item_name = 'craft-pistol',
        icons = {'item/pistol'},
        goal = 1,
        children =
        {
          {
            item_name = 'research-basic-military',
          },
        }
      },
    }

    locations.get_main_surface().always_day = false
    effect.unlock_technologies('military')
    global.compilatron.reset = true
    quest_gui.set('military', quest_layout)
    quest_gui.add_hint({'quest-hints.info-handcrafting'})
    quest_gui.visible(true)
  end,

  condition = function()
    local researched = check.research_list_complete({'basic-military'})
    local crafted = check.player_crafted_list(
      {
        {name='pistol',goal=1},
        {name='firearm-magazine',goal=10}
      })
    local loaded = check.player_is_loaded()
    return researched and crafted and loaded
  end,

  action = function()
    pollution.reset()
    quest_gui.visible(false)
  end,
}


second_base.story_nodes['entrench'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'stockpile-firearm-magazine',
        icons = {'item/firearm-magazine'},
        goal = 100
      },
      {
        item_name = 'loaded-east-expansion',
        icons = {'item/gun-turret'},
        goal = 1,
        children =
        {
          {
            item_name = 'research-active-defense',
          },
        }
      },
    }

    effect.unlock_technologies('entrench')
    global.compilatron.reset = true
    quest_gui.set('entrench', quest_layout)
    quest_gui.add_hint({'quest-hints.info-test-fire'})
    quest_gui.add_hint({'quest-hints.info-production'})
    quest_gui.visible(true)
  end,

  condition = function(event)
    -- these checks are expensive, so only do them once a second
    if event.tick % 60 ~= 0 then return end

    local stockpile = check.player_stockpiled_list(
    {
      {name='firearm-magazine',goal=100}
    })
    local loaded = check.number_of_loaded_turrets_in_areas({'east-expansion'}, 1, false)
    loaded = loaded or check.number_of_loaded_turrets_in_areas({'starting-area'}, 1, false)
    if loaded then
      quest_gui.update_count('loaded-east-expansion', 1, 1)
    else
      quest_gui.update_count('loaded-east-expansion', 0, 1)
    end

    local researched = check.research_list_complete({'active-defense'})
    return researched and loaded and stockpile
  end,
  update = function()
    attacks.check_spawn_wave('pistol')
  end,
  action = function()
    quest_gui.add_hint({'quest-hints.info-turret-ammo'})
    quest_gui.add_hint({'quest-hints.info-repair-pack'})
    quest_gui.unset()
  end,
}


second_base.story_nodes['fortify'] =
{
  init = function()
    -- This node is used as a migration target.
    -- This means that this init function can be called multiple times, so care must be taken to make sure it's ok to do that.

    local quest_layout =
    {
      {
        item_name = 'per-time-firearm-magazine',
        icons ={'item/firearm-magazine'},
        goal = 50,
        unit = 'pm',
      },
      {
        item_name = 'per-time-automation-science-pack',
        icons ={'item/automation-science-pack'},
        goal = 12,
        unit = 'pm',
      },
    }

    global.compilatron.reset = true
    effect.unlock_technologies('fortify')
    quest_gui.set('fortify', quest_layout)
    quest_gui.add_hint({'quest-hints.info-expand-defense'})
    quest_gui.add_hint({'quest-hints.info-turret-ammo'})
    quest_gui.add_hint({'quest-hints.info-copy-paste-settings'})
    quest_gui.visible(true)
  end,

  update = function()
    if game.tick % 360 ~= 0 then
      return
    end
    local lowest_turret_number = check.lowest_number_of_turrets_in_areas({'defend-1'})
    if lowest_turret_number > 4 then
      attacks.check_spawn_wave('fortify-4')
    elseif lowest_turret_number >3 then
      attacks.check_spawn_wave('fortify-3')
    elseif lowest_turret_number > 2 then
      attacks.check_spawn_wave('fortify-2')
    else
      attacks.check_spawn_wave('fortify-1')
    end
  end,

  condition = function()
    local firearm = check.item_produced_per_time('firearm-magazine',defines.flow_precision_index.one_minute,50)
    local packs = check.item_produced_per_time('automation-science-pack',defines.flow_precision_index.one_minute,12)
    local time =  story.check_seconds_passed('main_story',120)
    return firearm and packs and time
  end,

  action = function()
    quest_gui.add_hint({'quest-hints.info-repair-pack'})
    quest_gui.add_hint({'quest-hints.info-turret-ammo'})
    quest_gui.unset()
  end,
}


second_base.story_nodes['warning-screen'] =
{
  init = function()
    popup.clear_all()
    effect.show_text_window({'warning.heading'},{
      {'warning.text-1'},
      {'warning.text-2'},
      {'warning.text-3'},
      {'warning.text-4'},
      {'warning.thanks'},
    })
    game.tick_paused = true
  end,

  condition = function()
    return global.player_closed_text_window
  end,

  action = function()
    global.player_closed_text_window = nil
  end
}


second_base.story_nodes['final-expansion'] =
{
  init = function()
    effect.expand_map(expansions['final'])
  end,

  condition = function()
    return not cutscene.is_any_cutscene_playing()
  end
}


second_base.story_nodes['trigger-second-wave'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'arrive-compi-trigger-cutscene-pond',
      },
    }

    global.compilatron.reset = true
    quest_gui.set('trigger-second-wave', quest_layout)
    quest_gui.visible(true)
    game.auto_save("final-wave-before")
  end,

  update = function()
    if game.tick % 600 ~= 0 then
      return
    end
    attacks.check_spawn_wave('one-turret-one-vector')
  end,

  condition = function()
    local arrive = check.player_inside_area('compi-trigger-cutscene-pond')
    return arrive
  end,

  action = function()
    quest_gui.visible(false)
  end
}


second_base.story_nodes['biters-from-east'] =
{
  init = function()
    local spawn = locations.get_pos('spawn-east')
    local rally = locations.get_area('pond-copper-targets')
    local target = locations.get_area('pond-copper-targets')
    if spawn and rally and target then
      --make some biters!
      attack.spawn_attack_wave_no_groups(5,spawn,rally,{'burner-mining-drill','electric-mining-drill'},target,50000,'enemy')
    end
    popup.clear_all()
    cutscene.play(scenes['biters-from-east'])
  end,
  condition = function()
    return not cutscene.is_any_cutscene_playing()
  end
}

second_base.story_nodes['survive'] =
{
  init = function()
    local quest_layout =
    {
      {
        item_name = 'research-demo-science-pack',
      },
    }

    global.compilatron.reset = true
    effect.unlock_technologies('survive')
    quest_gui.set('survive', quest_layout)
    soft_death.active(false)
    pollution.reset()
    quest_gui.visible(true)
    quest_gui.add_hint({'quest-hints.info-no-respawning'})
    quest_gui.add_hint({'quest-hints.info-turrets-loaded'})
    game.auto_save("final-wave-start")
    game.autosave_enabled = false
  end,


  update = function()
    if game.tick % 60 ~= 0 then
      return
    end
    if not story.check_minutes_passed("main_story", 5) then
      attacks.check_spawn_wave('survive')
    else
      local lowest_turret_number = check.lowest_number_of_turrets_in_areas({'defend-1','defend-2'},false)
      if lowest_turret_number > 3 then
        attacks.check_spawn_wave('survive-4')
      elseif lowest_turret_number == 3 then
        attacks.check_spawn_wave('survive-3')
      elseif lowest_turret_number == 2 then
        attacks.check_spawn_wave('survive-2')
      elseif lowest_turret_number < 2 then
        attacks.check_spawn_wave('survive-1')
      end
    end
  end,

  condition = function()
    local researched = check.research_list_complete({'demo-science-pack'})
    return researched
  end,

  action = function()
    effect.activate_side_menu(true)
    quest_gui.add_hint({'quest-hints.info-repair-pack'})
    quest_gui.add_hint({'quest-hints.info-turret-ammo'})
    quest_gui.unset()
    soft_death.active(true)
    game.autosave_enabled = true
  end,
}


second_base.story_nodes['victory-screen'] =
{
  init = function()
    popup.clear_all()
    effect.show_text_window({'victory.heading'},{
      {'victory.text-1'},
      {'victory.text-2'},
      {'victory.text-3'},
      {'victory.text-4'},
      {'victory.text-5'},
      {'victory.thanks'},
    })
    game.tick_paused = true
  end,
  condition = function() return global.player_closed_text_window end,
  action = function()
    global.player_closed_text_window = nil
  end
}


second_base.story_nodes['victory'] =
{
  init = function()
    game.set_game_state({game_finished=true, player_won=true, can_continue=true})
  end,
}


second_base.story_nodes['freeplay'] =
{
  init = function()
    popup.create_technology_popup(main_player(),'improved-equipment')
    effect.unlock_technologies('freeplay')
    game.forces.enemy.ai_controllable = true
  end,
  condition = function()
    return false
  end,
  update = function ()
    if game.tick % 60 ~= 0 then
      return
    end
    attack.check_spawn_wave('freeplay')
  end
}

for name, node in pairs(second_base.story_nodes) do
    node.name = name
end

return second_base