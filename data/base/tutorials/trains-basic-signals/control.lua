require "story"
require "basic-signals"

function on_player_created(event)
  local player = game.players[event.player_index]
  player.game_view_settings =
  {
    show_side_menu = false,
    show_research_info = false,
    show_alert_gui = false,
    show_minimap = false
  }
  game.permissions.get_group(0).set_allows_action(defines.input_action.remove_cables, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_production_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_kills_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_tutorials_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_logistic_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_technology_gui, false)
  player.force.disable_all_prototypes()
end

story_table =
{
  {
    {
      init = function()
        if player().character then
          player().character.destroy()
        end
        global.this_puzzle_trains = {}
        global.this_puzzle_param = {offset = {0,10}}
        for k, entity in pairs (basic_signals.upper_track) do
          if entity.name == "locomotive" then
            table.insert(global.this_puzzle_trains, entity)
          end
          if entity.color == nil then
            entity.manual_mode = false
          end
        end
        set_info({text = {"locomotive-crash-info"}})
        set_info({custom_function = add_button, append = true})
        for k, entity in pairs (recreate_entities(basic_signals.upper_track, global.this_puzzle_param)) do
          if entity.name == "rail-signal" then
            entity.destroy()
          end
        end
        loop_trains(3*60)
      end,
      condition = function(event)
        return global.continue
      end
    },
    {
      init = function(event)
        clear_surface()
        recreate_entities(basic_signals.upper_track, global.this_puzzle_param)
        player().game_view_settings = {show_rail_block_visualisation = true}
        set_info({text = {"signal-info"}})
        set_info({custom_function = add_button, append = true})
        loop_trains(3*60)
      end,
      condition = function(event)
        return global.continue
      end
    },
    {
      init = function()
        loop_trains(-1)
        for k, entity in pairs (surface().find_entities_filtered{name = "locomotive"}) do
          entity.destroy()
        end
        for k, entity in pairs (recreate_entities(global.this_puzzle_trains, global.this_puzzle_param)) do
          if entity.color then
            global.other_locomotive = entity
          else
            global.locomotive = entity
          end
        end
        global.other_locomotive.train.schedule =
        {
          current = 1,
          records =
          {
            {
              station = "Branch",
              wait_conditions =
              {
                {
                  compare_type = "or",
                  ticks = 18000,
                  type = "time"
                }
              }
            }
          }
        }
        set_goal({"still-blocked"})
        set_info({text = {"still-blocked-info"}})
        global.locomotive.operable = false
        player().insert{name = "rail-signal", count = 2}
      end,
      condition = function()
        return global.locomotive.train.state == defines.train_state.wait_station
      end
    },
    {
      condition = story_elapsed_check(2)
    },
    {
      init = function(event)
        if event.name ~= defines.events.on_tick then return end
        clear_surface()
        for k, entity in pairs (recreate_entities(basic_signals.lower_track, {offset = {0, -10}})) do
          if entity.name == "locomotive" and entity.color == nil then
            global.locomotive = entity
            global.locomotive.operable = false
            break
          end
        end
        player().insert{name = "rail-signal", count = 4}
        set_goal({"siding-signals"})
        set_info({text = {"siding-signals-info"}})
      end,
      condition = function(event)
        if event.name ~= defines.events.on_tick then return end
        return global.locomotive.train.state == defines.train_state.wait_station
      end
    },
    {
      init = function(event)
        if event.name ~= defines.events.on_tick then return end
        clear_surface()
        for k, entity in pairs (recreate_entities(basic_signals.two_way, {offset = {2, -20}})) do
          if entity.name == "locomotive" then
            if entity.color == nil then
              global.locomotive = entity
              break
            end
          end
        end
        set_goal({"siding-signals"})
        set_info()
        player().insert{name = "rail-signal", count = 4}
      end,
      condition = function(event)
        if event.name ~= defines.events.on_tick then return end
        return global.locomotive.train.state == defines.train_state.wait_station
      end
    },
    {
      init = function()
        set_goal({"siding-signals"})
        clear_surface()
        for k, entity in pairs (recreate_entities(basic_signals.crossroads, {offset = {0, 50}})) do
          if entity.name == "locomotive" then
            if entity.color == nil then
              global.locomotive = entity
              break
            end
          end
        end
        player().insert{name = "rail-signal", count = 4}
      end,
      condition = function(event)
        if event.name ~= defines.events.on_tick then return end
        return global.locomotive.train.state == defines.train_state.wait_station
      end
    },
    {
      condition = story_elapsed_check(2),
      action = function ()
        set_goal()
        set_info()
        game.show_message_dialog({text = {"finish"}})
      end
    }
  }
}

script.on_init(function()
  game.forces.player.manual_mining_speed_modifier = 4
  game.forces.player.disable_all_prototypes()
  surface().always_day = true
  global.story = story_init(story_table)
  limit_camera({0,0}, 20)
end)

script.on_event(defines.events.on_tick, function(event)
  story_update(global.story, event, "")
  loop_trains()
end)

script.on_event(defines.events.on_gui_click, function(event)
  story_update(global.story, event, "")
end)

script.on_event(defines.events.on_player_created, on_player_created)

function clear_surface()
  local entities = surface().find_entities()
  for k, entity in pairs (entities) do
    if entity.valid and entity.name ~= "character" then
      entity.destroy()
    end
  end
  for k, entity in pairs (surface().find_entities()) do
    if entity.valid and entity.name ~= "character" then
      entity.destroy()
    end
  end
end

function loop_trains(interval)
  if interval then
    global.loop_interval = interval
    global.loop_tick = game.tick + global.loop_interval
    return
  end
  if not global.loop_tick then return end
  if game.tick ~= global.loop_tick then return end
  for k, train in pairs (surface().find_entities_filtered{name = "locomotive"}) do
    train.destroy()
  end
  for k, train in pairs (surface().find_entities_filtered{name = "fluid-wagon"}) do
    train.destroy()
  end
  recreate_entities(global.this_puzzle_trains, global.this_puzzle_param)
  global.loop_tick = game.tick + global.loop_interval
end

script.on_load(function()
  global.story.helpers = make_helpers(story_table)
end)
