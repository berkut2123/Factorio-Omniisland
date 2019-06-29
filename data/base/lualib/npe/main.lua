--- Test Scenario: NPE V0.2
-- @script runtime
-- The script sets up and runs a scenario which should test
-- the basic functionality of the proposed tutorial level.

mod_name = "__base__"
campaign_debug_mode = false

local event_handler = require(mod_name .. ".lualib.event_handler")
local map_expand = require(mod_name .. ".lualib.map_expand")
local locations = require(mod_name .. ".lualib.locations")
local crashsite = require ("crash-site")
local forces = require("forces")
local pollution = require(mod_name .. ".lualib.pollution")
local storytable = require("storytable")
local story = require('story_2')
local quest_gui = require(mod_name .. ".lualib.quest_gui")
local popup = require(mod_name .. ".lualib.popup")
local compi = require(mod_name .. ".lualib.compi")
local helper = require(mod_name .. ".lualib.npe.helper_story")
local tracker = require(mod_name .. ".lualib.player_tracker")
local effect = require(mod_name .. ".lualib.effects")
local attacks = require(mod_name .. ".lualib.attacks")
local command_callback = require(mod_name .. ".lualib.command_callback")
local function_save = require(mod_name .. ".lualib.function_save")
local colony_controller = require(mod_name .. ".lualib.colony_controller")
local gui_helpers = require(mod_name .. '.lualib.npe.gui_helpers')
local cutscene = require(mod_name .. ".lualib.cutscene")
local misc = require(mod_name .. ".lualib.misc")
local scenario_events = require("scenario-events")
local waves = require("waves")
local eastern_cutscene_biters = require(mod_name .. ".lualib.npe.eastern_cutscene_biters")
local technology_manager = require(mod_name .. '.lualib.technology_manager')
local campaigns_version = require(mod_name .. '.lualib.campaigns_version')
local tech_levels = require('tech_levels')
local soft_death = require(mod_name .. '.lualib.soft_death')
local util = require('util')
local position_data = require('position_data')
require('scenario-commands')

-- Unfortunately, we can currently require lua modules in a few different ways, eg one relative path vs another,
-- "in-mod" absolute paths, etc. When we do this, the engine sees them as different files. For now, we will workaround
-- this by using absolute in-mod paths, and this code block asserts that we've done this correctly.
local module_name_mapping = {}
for key, _ in pairs(package.loaded) do
  local split = util.split(key, '.')
  local split_name = split[#split]
  assert(split_name)

  if module_name_mapping[split_name] then
    if module_name_mapping[split_name] ~= key then
      error("Module imported twice with two different paths: " .. key .. ", " .. module_name_mapping[split_name])
    end
  else
    module_name_mapping[split_name] = key
  end
end

main_player = function()
  for _, player in pairs(game.forces['player'].players) do
    if player.controller_type == defines.controllers.character or player.controller_type == defines.controllers.cutscene then
      return player
    end
  end
  return nil
end

active_player = function()
  for _, player in pairs(game.forces['player'].players) do
    if player.controller_type == defines.controllers.character or player.controller_type == defines.controllers.cutscene then
      return player
    end
  end
  return nil
end

local on_player_join = function(event)
  game.players[event.player_index].disable_recipe_groups()
  game.players[event.player_index].disable_recipe_subgroups()
end

local setup_events = function()
  local main_events =
  {
    [defines.events.on_player_joined_game] = on_player_join,
  }

  local event_receivers =
  {
    main_events,
    map_expand.events,
    forces.events,
    storytable.events,
    popup.events,
    compi.events,
    helper.events,
    effect.events,
    tracker.events,
    command_callback.events,
    gui_helpers.events,
    cutscene.events,
    misc.events,
    colony_controller.events,
    quest_gui.events,
    scenario_events.events,
    soft_death.events,
  }

  event_handler.setup_event_handling(event_receivers)
end

local on_game_created_or_loaded = function()
  if campaign_debug_mode then
    print("ON_LOAD: control")
  end
  map_expand.on_load()
  locations.on_load()
  storytable.on_load()
  helper.on_load()
  compi.on_load()
  cutscene.on_load()
  popup.on_load()
  misc.on_load()
  quest_gui.on_load()
  colony_controller.on_load()
  attacks.on_load(waves)
  eastern_cutscene_biters.on_load()
  command_callback.on_load()
  soft_death.on_load()
  technology_manager.on_load(tech_levels)

  if global.CAMPAIGNS_VERSION == campaigns_version.current_version then
    locations.verify_data(position_data.points, position_data.areas)
  end

  if global.scenario_started then
    setup_events()
  end
end
script.on_load(function()
  on_game_created_or_loaded()
end)

local on_game_created_from_scenario = function()
  global.CAMPAIGNS_VERSION = campaigns_version.current_version
  map_expand.init()
  locations.init('nauvis','template')
  crashsite.init()
  forces.init()
  pollution.init(0,0,0.000006,0.1,true)
  storytable.init()
  popup.init()
  command_callback.init()
  compi.init(locations.get_pos('compi-wait-crash'))
  helper.init()
  cutscene.init()
  tracker.init()
  gui_helpers.init()
  popup.init()
  misc.init()
  quest_gui.init()
  colony_controller.init()
  eastern_cutscene_biters.init()
  technology_manager.init()
  attacks.init()
  soft_death.init()
  function_save.init() -- this must stay last, as it ensures other init funcs can register functions
  on_game_created_or_loaded()
  global.playthrough_number = nil

   -- disallow wire dragging in this scenario
  game.permissions.get_group("Default").set_allows_action(defines.input_action.wire_dragging, false)
  game.disable_tips_and_tricks()

  locations.verify_data(position_data.points, position_data.areas)
end

script.on_event(defines.events.on_game_created_from_scenario, function()
  script.on_event(defines.events.on_game_created_from_scenario, nil)
  setup_events()
  on_game_created_from_scenario()
  global.scenario_started = true
end)

local is_global_empty = function()
  local result = true
  for _,_ in pairs(global) do result = false end
  return result
end

local on_configuration_changed = function()
  game.reload_script()
  if is_global_empty() then return end
  -- Migrations can cause this to be reset
  game.forces.compi_res_force.ghost_time_to_live = 99999

  if global.CAMPAIGNS_VERSION == nil then
    global.CAMPAIGNS_VERSION = 1
  end

  if global.CAMPAIGN_MIGRATIONS_APPLIED == nil then
    global.CAMPAIGN_MIGRATIONS_APPLIED = {}
  end
  table.insert(global.CAMPAIGN_MIGRATIONS_APPLIED, {
    global.CAMPAIGNS_VERSION,
    campaigns_version.current_version,
    story.get_current_node_name('main_story')
  })

  if global.CAMPAIGNS_VERSION < 6 then
    global.scenario_started = true
  end

  colony_controller.migrate()
  locations.migrate()
  quest_gui.migrate()
  storytable.migrate()
  attacks.migrate()
  helper.migrate()
  technology_manager.reset()

  if global.CAMPAIGNS_VERSION < 3 then
    global.pollution_unspent = 0
    game.map_settings.enemy_evolution.pollution_factor = 0.000006
  end

  global.CAMPAIGNS_VERSION = campaigns_version.current_version
end
script.on_configuration_changed(on_configuration_changed)
