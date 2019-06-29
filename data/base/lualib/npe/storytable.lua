--- NPE Scenario Story Table
-- @module story
-- storage for the story table, and event handler for conditions.lua

local story = require('story_2')
local pollution = require(mod_name .. ".lualib.pollution")
local misc = require(mod_name .. '.lualib.misc')
local technology_manager = require(mod_name .. '.lualib.technology_manager')
local map_expand = require(mod_name .. ".lualib.map_expand")
local cutscene = require(mod_name .. ".lualib.cutscene")
local effects = require(mod_name .. ".lualib.effects")
local locations = require(mod_name .. ".lualib.locations")
local expansions = require(mod_name .. '.lualib.npe.expansions')
local popup = require(mod_name .. ".lualib.popup")
local campaign_util = require(mod_name .. ".lualib.campaign_util")

local cutscenes =
{
  compi_build_iron_cutscene = require('cutscenes.compi_build_iron_cutscene'),
  biters_revealed = require('cutscenes.biters_revealed'),
  biters_close_in = require('cutscenes.biters_close_in'),
  east_flank_worms = require('cutscenes.east_flank_worms'),
  base_destroyed_east_revealed = require('cutscenes.base_destroyed_east_revealed')
}

local stages =
{
  starting_area = require('story_nodes.starting_area'),
  second_base = require('story_nodes.second_base')
}

local story_table = {}

local generate_congrats_node = function(unique_name)
  return
  {
    name = 'congrats_' .. unique_name,
    init = function()
      campaign_util.flying_congrats(game.players[1].position)
      game.forces.player.play_sound({ path = "utility/achievement_unlocked" })
    end,
    condition = function () return story.check_seconds_passed('main_story',2) end
  }
end

local generate_intermission_node = function(unique_name)
  return
  {
    name = 'intermission_' .. unique_name,
    condition = function()
      return story.check_seconds_passed('main_story', 2)
    end
  }
end


local story_nodes
local get_story_nodes = function()
  if story_nodes == nil then
    story_nodes = {}

    local add = function(data)
      if data[1] then -- data is a table of multiple nodes
        for _, node in pairs(data) do
          table.insert(story_nodes, node)
        end
      else -- data is just one node
        table.insert(story_nodes, data)
      end
    end
    add(stages.starting_area.story_nodes['intro'])
    add(stages.starting_area.story_nodes['explore'])
    add(generate_congrats_node("explore"))
    add(stages.starting_area.story_nodes['handmining'])
    add(generate_congrats_node("handmining"))
    add(stages.starting_area.story_nodes['smelting'])
    add(generate_congrats_node("smelting"))
    add(stages.starting_area.story_nodes['automining'])
    add(generate_congrats_node("automining"))
    add(stages.starting_area.story_nodes['handcrafting'])
    add(generate_congrats_node("handcrafting"))
    add(stages.starting_area.story_nodes['trigger-build'])
    add(cutscenes.compi_build_iron_cutscene.generate_cutscene())
    add(stages.starting_area.story_nodes['repair-assembler'])
    add(generate_congrats_node("repair-assembler"))
    add(stages.starting_area.story_nodes['power-assembler'])
    add(generate_congrats_node("power-assembler"))
    add(stages.starting_area.story_nodes['repair-lab'])
    add(generate_congrats_node("repair-lab"))
    add(stages.starting_area.story_nodes['load-lab'])
    add(generate_congrats_node("load-lab"))
    add(stages.starting_area.story_nodes['electronics'])
    add(generate_congrats_node("electronics"))
    add(stages.starting_area.story_nodes['build-radar'])
    add(generate_congrats_node("build-radar"))
    add(stages.starting_area.story_nodes['trigger-radar'])
    add(cutscenes.biters_revealed.generate_cutscene())
    add(generate_intermission_node("west-expansion"))
    add(stages.starting_area.story_nodes['scan-wreck'])
    add(generate_congrats_node("scan-wreck"))
    add(stages.starting_area.story_nodes['trigger-attacks'])
    add(cutscenes.biters_close_in.generate_cutscene())
    add(generate_intermission_node('biters-close-in'))
    add(misc.generate_screenshot_area_node('demo_17_3', 'starting-area', 'a'))
    add(stages.starting_area.story_nodes['prepare'])
    add(generate_congrats_node("prepare"))
    add(stages.starting_area.story_nodes['leave'])
    add(generate_congrats_node("leave"))
    add(cutscenes.base_destroyed_east_revealed.generate_cutscene())
    add(generate_intermission_node('east-expansion'))
    add(stages.second_base.story_nodes['reach-pond'])
    add(generate_congrats_node("reach-pond"))
    add(stages.second_base.story_nodes['rebuild'])
    add(generate_congrats_node("rebuild"))
    add(stages.second_base.story_nodes['military'])
    add(generate_congrats_node("military"))
    add(stages.second_base.story_nodes['entrench'])
    add(generate_congrats_node("entrench"))
    add(stages.second_base.story_nodes['fortify'])
    add(generate_congrats_node("fortify"))
    add(generate_intermission_node('fortify'))
    add(misc.generate_screenshot_area_node('demo_17_3', 'second-base-area','b'))
    --add(stages.second_base.story_nodes['warning-screen'])
    add(stages.second_base.story_nodes['final-expansion'])
    add(generate_intermission_node('final_expansion'))
    add(stages.second_base.story_nodes['trigger-second-wave'])
    add(cutscenes.east_flank_worms.generate_cutscene())
    add(stages.second_base.story_nodes['survive'])
    add(misc.generate_screenshot_area_node('demo_17_3', 'second-base-area','c'))
    add(generate_congrats_node('survive'))
    add(stages.second_base.story_nodes['victory-screen'])
    add(stages.second_base.story_nodes['victory'])
    add(generate_intermission_node('victory'))
    add(stages.second_base.story_nodes['freeplay'])
  end

  return story_nodes
end

local check_story_and_pollution = function(event)
  if active_player() then
    story.update("main_story", event)
  end

  pollution.check_pollution()
end

story_table.init = function()
  if campaign_debug_mode then
    print("ON_INIT: storytable")
  end
  story.init("main_story", get_story_nodes())

  if campaign_debug_mode then
    story.set_debug("main_story", true)
  end
end

story_table.on_load = function()
  if campaign_debug_mode then
    print("ON_LOAD: storytable")
  end
  story.on_load("main_story", get_story_nodes())
end

story_table.migrate = function()
  local current_story_node = story.get_current_node_name('main_story')
  local do_jump = false

  if global.CAMPAIGNS_VERSION < 2 then
    -- migration from ad-hoc enabling technologies to using technology_manager. pre-dates global.CAMPAIGNS_VERSION
    if global.technology_manager_data == nil then
      technology_manager.migrate_old_npe_save(get_story_nodes(), story.get_current_node_name('main_story'))
    end

    local old_second_half_nodes =
    {
      "trigger-second-wave",
      "biters-from-east",
      "intermission_biters-from-east",
      "fortify",
      "screenshot_area_b",
      "congrats_fortify",
      "intermission_fortify",
      "survive",
    }

    local old_finished_nodes =
    {
      "screenshot_area_c",
      "congrats_survive",
      "victory-screen",
      "victory",
      "intermission_victory",
      "final-expansion",
      "intermission_final-expansion",
      "freeplay",
    }

    local jump_to_fortify = false
    local jump_to_freeplay = false

    for _, node_name in pairs(old_second_half_nodes) do
      if current_story_node == node_name then
        jump_to_fortify = true
        break
      end
    end

    for _, node_name in pairs(old_finished_nodes) do
      if current_story_node == node_name then
        jump_to_freeplay = true
        break
      end
    end

    -- If we are past a certain point in the old version, just reset to the fortify quest
    if jump_to_fortify then
      current_story_node = 'fortify'
      do_jump = true

      local biters_on_map = locations.get_main_surface().find_entities_filtered
      {
        type = "unit",
        force = "enemy"
      }

      for _, biter in pairs(biters_on_map) do
        biter.destroy()
      end

      global.pollution_unspent = 0

      map_expand.clear_old_data()
      cutscene.cancel()
      for _, player in pairs(game.players) do
        popup.clear(player)
      end

      effects.show_text_window({'campaign-migrated-message.heading'}, {{'campaign-migrated-message.text'}})
      game.tick_paused = true

    elseif jump_to_freeplay then
      current_story_node = "freeplay"
      do_jump = true

      map_expand.clear_old_data()
      cutscene.cancel()
      for _, player in pairs(game.players) do
        popup.clear(player)
      end

      -- Detect if we have already done the expansion (save could be in a cutscene or intermission node just before)
      if global.expand_surface_sizes.nauvis.right_bottom.y ~= 192 then
        effects.expand_map(expansions['final'], true)
      end

      effects.show_text_window({'campaign-migrated-message.heading'}, {{'campaign-migrated-message.text'}})
      game.tick_paused = true
    end

  end

  if global.CAMPAIGNS_VERSION < 4 then

    if current_story_node == "repair-assembler" then
      local old_assembler_main = locations.get_surface_ent_from_tag(locations.get_main_surface(), 'iron-gear-wheel-wreck')
      old_assembler_main.teleport{-87.5, 17.5}
    end

    if current_story_node == "repair-assembler" or current_story_node == "repair-lab" then
      do_jump = true

      local old_loaders = locations.get_main_surface().find_entities_filtered{ name = 'loader'}
      for _, loader in pairs(old_loaders) do
        loader.destroy()
      end
      old_loaders = locations.get_template_surface().find_entities_filtered{ name = 'loader'}
      for _, loader in pairs(old_loaders) do
        loader.destroy()
      end

      local gear_chest = locations.get_template_surface().create_entity
      {
        name = 'compilatron-chest',
        position = {-90.5, 16.5},
        force = 'player'
      }
      gear_chest.operable = false
      gear_chest.minable = false
      gear_chest.destructible = false
      gear_chest.rotatable = false
      locations.patch_entity('compi-box-gear', gear_chest)

      local gear_inserter = locations.get_template_surface().create_entity
      {
        name = "burner-inserter",
        position = {-90.5, 17.5},
        force = 'player',
        direction = defines.direction.south
      }
      gear_inserter.minable = false
      gear_inserter.destructible = false
      gear_inserter.rotatable = false

      local gear_belt = locations.get_template_surface().create_entity
      {
        name = "transport-belt",
        position = {-90.5, 18.5},
        force = 'player',
        direction = defines.direction.north
      }
      gear_belt.operable = false
      gear_belt.minable = false
      gear_belt.destructible = false
      gear_belt.rotatable = false

      local lab_chest = locations.get_template_surface().create_entity
      {
        name = 'compilatron-chest',
        position = {-96.5, 9.5},
        force = 'player'
      }
      lab_chest.operable = false
      lab_chest.minable = false
      lab_chest.destructible = false
      lab_chest.rotatable = false

      locations.patch_entity('compi-box-lab', lab_chest)

      local lab_inserter = locations.get_template_surface().create_entity
      {
        name = "burner-inserter",
        position = {-96.5, 10.5},
        force = 'player',
        direction = defines.direction.south
      }
      lab_inserter.minable = false
      lab_inserter.destructible = false
      lab_inserter.rotatable = false

      local lab_belt = locations.get_template_surface().create_entity
      {
        name = "transport-belt",
        position = {-96.5, 11.5},
        force = 'player',
        direction = defines.direction.north
      }
      lab_belt.operable = false
      lab_belt.minable = false
      lab_belt.destructible = false
      lab_belt.rotatable = false

      local old_assembler_template = locations.get_surface_ent_from_tag(locations.get_template_surface(), 'iron-gear-wheel-wreck')
      old_assembler_template.teleport{-87.5, 17.5}
    end


    -- I used this snippet to dump the data from a new map:
    --local dump_pos = function(name)
    --  local pos = game.surfaces['template'].get_script_positions(name)[1].position
    --  local str = 'locations.patch_pos("' .. name .. '", {x=' .. pos.x .. ',y=' .. pos.y .. '})'
    --  print(str)
    --end
    --for _, pos in pairs(game.surfaces['template'].get_script_positions()) do
    --  dump_pos(pos.name)
    --end
    --
    --local dump_area = function(name)
    --  local area = game.surfaces['template'].get_script_areas(name)[1].area
    --  local str = 'locations.patch_area("' .. name .. '", {left_top={x=' .. area.left_top.x .. ',y=' .. area.left_top.y ..
    --  '},right_bottom={x=' .. area.right_bottom.x .. ',y=' .. area.right_bottom.y .. '}})'
    --  print(str)
    --end
    --for _, area in pairs(game.surfaces['template'].get_script_areas()) do
    --  dump_area(area.name)
    --end

    locations.patch_pos("crash-site", {x=-97.5,y=13.5})
    locations.patch_pos("crash-stone-patch", {x=-86.5,y=3.5})
    locations.patch_pos("crash-copper-patch", {x=-120.5,y=1.5})
    locations.patch_pos("compi-wait-crash", {x=-93.5,y=-2.5})
    locations.patch_pos("compi-wait-biter", {x=-127.5,y=27.5})
    locations.patch_pos("exit-left", {x=-159.5,y=23.5})
    locations.patch_pos("exit-right", {x=-11.5,y=-20.5})
    locations.patch_pos("compi-wait-leave", {x=-6.5,y=0.5})
    locations.patch_pos("spawn-1", {x=-302.5,y=18.5})
    locations.patch_pos("spawn-2", {x=338.5,y=13.5})
    locations.patch_pos("rally-1", {x=295.5,y=-35.5})
    locations.patch_pos("rally-2", {x=308.5,y=15.5})
    locations.patch_pos("rally-3", {x=287.5,y=59.5})
    locations.patch_pos("target-1", {x=106.5,y=8.5})
    locations.patch_pos("target-2", {x=168.5,y=-36.5})
    locations.patch_pos("compi-wait-pond", {x=152.5,y=39.5})
    locations.patch_pos("target-3", {x=131.5,y=35.5})
    locations.patch_pos("target-4", {x=198.5,y=10.5})
    locations.patch_pos("spawn-3", {x=-48.5,y=-4.5})
    locations.patch_pos("biter-close-in-1", {x=-231.5,y=18.5})
    locations.patch_pos("biter-close-in-2", {x=-178.5,y=23.5})
    locations.patch_pos("biter-close-in-3", {x=-141.5,y=-10.5})
    locations.patch_pos("rally-4", {x=50.5,y=-7.5})
    locations.patch_pos("crash-player-spawn", {x=-91.5,y=-0.5})
    locations.patch_pos("pond-player-spawn", {x=133.5,y=52.5})
    locations.patch_pos("rally-5", {x=-277.5,y=18.5})
    locations.patch_pos("rally-6", {x=-201.5,y=29.5})
    locations.patch_pos("pond", {x=138.5,y=27.5})
    locations.patch_pos("biter-wreckage", {x=-276.5,y=17.5})
    locations.patch_pos("target-5", {x=114.5,y=-12.5})
    locations.patch_pos("compi-lab-wait", {x=-96.5,y=9.5})
    locations.patch_pos("compi-gear-wait", {x=-91.5,y=19.5})
    locations.patch_pos("compi-east-warning", {x=187.5,y=24.5})
    locations.patch_pos("compi-west-warning", {x=128.5,y=11.5})
    locations.patch_pos("compi-wait-cutscene-crash", {x=-119.5,y=34.5})
    locations.patch_pos("compi-wait-cutscene-pond", {x=138.5,y=-10.5})
    locations.patch_pos("exit-left-2", {x=-159.5,y=15.5})
    locations.patch_pos("exit-left-3", {x=-159.5,y=32.5})
    locations.patch_pos("spawn-north", {x=117.5,y=-187.5})
    locations.patch_pos("spawn-west", {x=-348.5,y=16.5})
    locations.patch_pos("spawn-east", {x=350.5,y=48.5})
    locations.patch_pos("target-south-iron", {x=215.5,y=158.5})
    locations.patch_pos("target-north-coal", {x=305.5,y=-157.5})
    locations.patch_pos("target-north-iron", {x=-243.5,y=-154.5})
    locations.patch_pos("target-copper-south", {x=-117.5,y=134.5})
    locations.patch_pos("rally-south-shallow", {x=132.5,y=152.5})
    locations.patch_pos("cutscene-east-worms", {x=273.5,y=17.5})
    locations.patch_area("crash-packup-targets", {left_top={x=-127,y=-4},right_bottom={x=-114,y=7}})
    locations.patch_area("defend-2", {left_top={x=151,y=-59},right_bottom={x=252,y=92}})
    locations.patch_area("north-expansion", {left_top={x=-352,y=-192},right_bottom={x=352,y=-64}})
    locations.patch_area("south-expansion", {left_top={x=-352,y=96},right_bottom={x=352,y=192}})
    locations.patch_area("safe-1", {left_top={x=-76,y=-22},right_bottom={x=-60,y=-8}})
    locations.patch_area("safe-2", {left_top={x=-57,y=16},right_bottom={x=-43,y=33}})
    locations.patch_area("safe-4", {left_top={x=3,y=-63},right_bottom={x=22,y=28}})
    locations.patch_area("pond-iron-targets", {left_top={x=94,y=-21},right_bottom={x=124,y=18}})
    locations.patch_area("pond-copper-targets", {left_top={x=184,y=-5},right_bottom={x=211,y=27}})
    locations.patch_area("pond-stone-targets", {left_top={x=148,y=-54},right_bottom={x=188,y=-26}})
    locations.patch_area("pond", {left_top={x=123,y=19},right_bottom={x=197,y=51}})
    locations.patch_area("starting-area", {left_top={x=-160,y=-64},right_bottom={x=0,y=96}})
    locations.patch_area("west-expansion", {left_top={x=-352,y=-64},right_bottom={x=-160,y=96}})
    locations.patch_area("east-expansion", {left_top={x=0,y=-64},right_bottom={x=352,y=96}})
    locations.patch_area("crashsite-nest-5", {left_top={x=-106,y=34},right_bottom={x=-94,y=43}})
    locations.patch_area("crashsite-nest-4", {left_top={x=-104,y=18},right_bottom={x=-92,y=27}})
    locations.patch_area("crashsite-nest-1", {left_top={x=-130,y=-3},right_bottom={x=-113,y=8}})
    locations.patch_area("crashsite-nest-2", {left_top={x=-113,y=3},right_bottom={x=-99,y=15}})
    locations.patch_area("crashsite-nest-3", {left_top={x=-99,y=8},right_bottom={x=-84,y=18}})
    locations.patch_area("compi-move-check", {left_top={x=-94,y=-3},right_bottom={x=-89,y=2}})
    locations.patch_area("iron-production-targets", {left_top={x=-111,y=29},right_bottom={x=-86,y=45}})
    locations.patch_area("tree-demo-area", {left_top={x=-80,y=-8},right_bottom={x=-58,y=25}})
    locations.patch_area("second-base-area", {left_top={x=62,y=-59},right_bottom={x=252,y=92}})
    locations.patch_area("iron-patch-construction", {left_top={x=-102,y=31},right_bottom={x=-88,y=42}})
    locations.patch_area("defend-1", {left_top={x=-134,y=-59},right_bottom={x=151,y=92}})
    locations.patch_area("gear-feed-construction", {left_top={x=-91,y=16},right_bottom={x=-90,y=19}})
    locations.patch_area("lab-feed-construction", {left_top={x=-97,y=9},right_bottom={x=-96,y=12}})
    locations.patch_area("compi-trigger-cutscene-crash", {left_top={x=-123,y=32},right_bottom={x=-118,y=36}})
    locations.patch_area("exit-right", {left_top={x=-9,y=-2},right_bottom={x=-4,y=3}})
    locations.patch_area("compi-trigger-cutscene-pond", {left_top={x=137,y=-12},right_bottom={x=140,y=-9}})
    locations.patch_area("spawn-west", {left_top={x=-352,y=-34},right_bottom={x=-346,y=75}})
    locations.patch_area("spawn-east", {left_top={x=345,y=-64},right_bottom={x=352,y=96}})
    locations.patch_area("spawn-north", {left_top={x=8,y=-192},right_bottom={x=140,y=-186}})
    locations.patch_area("spawn-south", {left_top={x=-259,y=186},right_bottom={x=-71,y=192}})
    locations.patch_area("south-copper-nest", {left_top={x=-210,y=149},right_bottom={x=-162,y=183}})
    locations.patch_area("cake-nest", {left_top={x=-191,y=-119},right_bottom={x=-152,y=-87}})
    locations.patch_area("iron-north-targets", {left_top={x=-262,y=-166},right_bottom={x=-231,y=-138}})
    locations.patch_area("copper-south-targets", {left_top={x=-142,y=119},right_bottom={x=-89,y=148}})
    locations.patch_area("iron-south-targets", {left_top={x=192,y=135},right_bottom={x=239,y=175}})
    locations.patch_area("south-iron-nest", {left_top={x=303,y=130},right_bottom={x=344,y=167}})
    locations.patch_area("north-coal-nest", {left_top={x=226,y=-123},right_bottom={x=261,y=-91}})
    locations.patch_area("coal-north-targets", {left_top={x=282,y=-178},right_bottom={x=331,y=-139}})
    locations.patch_area("north-west-canyon-rally", {left_top={x=-311,y=-63},right_bottom={x=-285,y=-46}})
    locations.patch_area("south-west-canyon-rally", {left_top={x=-239,y=83},right_bottom={x=-213,y=95}})
    locations.patch_area("south-east-canyon-rally", {left_top={x=275,y=52},right_bottom={x=301,y=71}})
    locations.patch_area("north-east-canyon-rally", {left_top={x=271,y=-62},right_bottom={x=294,y=-44}})
    locations.patch_area("south-shallows-rally", {left_top={x=134,y=141},right_bottom={x=160,y=161}})
    locations.patch_area("south-crash-rally", {left_top={x=-128,y=46},right_bottom={x=-113,y=57}})
    locations.patch_area("north-crash-rally", {left_top={x=-147,y=4},right_bottom={x=-135,y=18}})
    locations.patch_area("canyon-middle-rally", {left_top={x=-23,y=-21},right_bottom={x=-7,y=-5}})
    locations.patch_area("safe-3", {left_top={x=-42,y=-37},right_bottom={x=-15,y=22}})
    locations.patch_area("colony-crash-west", {left_top={x=-158,y=22},right_bottom={x=-145,y=34}})
    locations.patch_area("colony-wreck-mid", {left_top={x=-208,y=13},right_bottom={x=-191,y=27}})
    locations.patch_area("colony-wreck-far", {left_top={x=-279,y=12},right_bottom={x=-268,y=26}})
    locations.patch_area("colony-crash-copper", {left_top={x=-141,y=8},right_bottom={x=-136,y=13}})
    locations.patch_area("colony-crash-iron", {left_top={x=-118,y=46},right_bottom={x=-111,y=53}})
    locations.patch_area("colony-east-top", {left_top={x=260,y=-8},right_bottom={x=271,y=2}})
    locations.patch_area("colony-east-mid", {left_top={x=267,y=12},right_bottom={x=281,y=22}})
    locations.patch_area("colony-east-bottom", {left_top={x=260,y=34},right_bottom={x=274,y=47}})
  end

  if global.CAMPAIGNS_VERSION < 5 then
    if story.get_current_node_name('main_story') == 'trigger-build' then
      do_jump = true
    end
  end

  if do_jump then
    story.jump_to_node('main_story', current_story_node)
  end
end

story_table.events = {
  [defines.events.on_tick] = check_story_and_pollution,
  [defines.events.on_built_entity] = check_story_and_pollution,
}

return story_table


