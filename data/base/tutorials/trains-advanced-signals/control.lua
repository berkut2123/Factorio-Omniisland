require "story"
require "advanced-signals"

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
        for k, entity in pairs (surface().find_entities()) do
          if entity.name == "locomotive" then
            entity.insert"coal"
          end
          entity.minable = false
          entity.operable = false
          entity.rotatable = false
        end
        player().character.destroy()
      end
    },
    {
      init = function()
        set_goal("", false)
        set_info({text = {"chain-green"}})
        set_info({custom_function = add_run_trains_button, append = true})
        find_gui_recursive(player().gui, "reset_all").destroy()
        set_continue_button_style(function (button)
          if button.valid then
            button.enabled = true
          end
        end)
        clear_surface()
        global.this_puzzle = setup.chain_green.entities
        global.this_puzzle_param = nil
        global.this_puzzle_trains = {}
        for k, entity in pairs (global.this_puzzle) do
          entity.minable = false
          entity.operable = false
          if entity.name == "locomotive" then
            if entity.schedule then
              entity.manual_mode = true
            end
            table.insert(global.this_puzzle_trains, entity)
          end
        end
        recreate_entities(global.this_puzzle)
        loop_trains(0)
      end,
      condition = function()
        return global.continue
      end
    },
    {
      init = function()
        set_goal("", false)
        set_info({text = {"chain-blue-go"}})
        set_info({custom_function = add_run_trains_button, append = true})
        find_gui_recursive(player().gui, "reset_all").destroy()
        set_continue_button_style(function (button)
          if button.valid then
            button.enabled = true
          end
        end)
        clear_surface()
        global.this_puzzle = setup.chain_blue_go.entities
        global.this_puzzle_param = nil
        global.this_puzzle_trains = {}
        for k, entity in pairs (global.this_puzzle) do
          entity.minable = false
          entity.operable = false
          if entity.name == "locomotive" then
            if entity.schedule then
              entity.manual_mode = true
            end
            table.insert(global.this_puzzle_trains, entity)
          end
        end
        recreate_entities(global.this_puzzle)
        loop_trains(0)
      end,
      condition = function()
        return global.continue
      end
    },
    {
      init = function()
        set_goal("", false)
        set_info({text = {"chain-blue-stop"}})
        set_info({custom_function = add_run_trains_button, append = true})
        find_gui_recursive(player().gui, "reset_all").destroy()
        set_continue_button_style(function (button)
          if button.valid then
            button.enabled = true
          end
        end)
        clear_surface()
        global.this_puzzle = setup.chain_blue_stop.entities
        global.this_puzzle_param = nil
        global.this_puzzle_trains = {}
        for k, entity in pairs (global.this_puzzle) do
          entity.minable = false
          entity.operable = false
          if entity.name == "locomotive" then
            if entity.schedule then
              entity.manual_mode = true
            end
            table.insert(global.this_puzzle_trains, entity)
          end
        end
        recreate_entities(global.this_puzzle)
        loop_trains(0)
      end,
      condition = function()
        return global.continue
      end
    },
    {
      init = function()
        set_goal("", false)
        set_info({text = {"chain-red"}})
        set_info({custom_function = add_run_trains_button, append = true})
        find_gui_recursive(player().gui, "reset_all").destroy()
        set_continue_button_style(function (button)
          if button.valid then
            button.enabled = true
          end
        end)
        clear_surface()
        global.this_puzzle = setup.chain_red.entities
        global.this_puzzle_param = nil
        global.this_puzzle_trains = {}
        for k, entity in pairs (global.this_puzzle) do
          entity.minable = false
          entity.operable = false
          if entity.name == "locomotive" then
            if entity.schedule then
              entity.manual_mode = true
            end
            table.insert(global.this_puzzle_trains, entity)
          end
        end
        recreate_entities(global.this_puzzle)
        loop_trains(0)
      end,
      condition = function()
        return global.continue
      end
    },
    {
      init = function()
        clear_surface()
        set_goal("", false)
        set_info({text = {"deadlock-1"}})
        set_info({text = {"deadlock-2"}, append = true})
        set_info({custom_function = add_button, append = true})
        global.this_puzzle_trains = {}
        for k, entity in pairs (setup[1].entities) do
          if entity.name == "locomotive" or entity.name == "fluid-wagon" then
            table.insert(global.this_puzzle_trains, entity)
          elseif entity.name == "rail-signal" then
            entity.minable = true
          end
        end
        global.this_puzzle = setup[1].entities
        global.this_puzzle_param = setup[1].param
        recreate_entities(global.this_puzzle, global.this_puzzle_param)
        loop_trains(9*60)
      end,
      condition = function()
        return global.continue
      end
    },
    {
      init = function()
        clear_surface()
        global.this_puzzle = setup[1].entities
        global.this_puzzle_param = setup[1].param
        global.this_puzzle_trains = {}
        for k, entity in pairs (global.this_puzzle) do
          if entity.name == "locomotive" or entity.name == "fluid-wagon" then
            table.insert(global.this_puzzle_trains, entity)
          elseif entity.name == "rail-signal" then
            entity.minable = true
          end
        end
        for k, entity in pairs (recreate_entities(global.this_puzzle, global.this_puzzle_param)) do
          if entity.name == "rail-signal" and
            (
              (
                entity.position.x == -4.5 and
                entity.position.y == 2.5
              )
              or
              (
                entity.position.x == -2.5 and
                entity.position.y == -2.5
              )
            )
          then
            entity.minable = true
            local X = entity.position.x
            local Y = entity.position.y
            local D = entity.direction
            entity.destroy()
            surface().create_entity{name = "rail-chain-signal", position = {X,Y}, direction = D}
          end
        end
        set_goal()
        set_info({text = {"chain-signal-1"}})
        set_info({text = {"chain-signal-2"}, append = true})
        set_info({custom_function = add_button, append = true})
        loop_trains(8*60)
      end,
      condition = function()
        return global.continue
      end
    },
    {
      init = function()
        clear_surface()
        global.required_signals = 4
        set_goal({"fix-intersection"})
        set_info({custom_function = add_run_trains_button})
        global.this_puzzle_trains = {}
        for k, entity in pairs (setup[2].entities) do
          if entity.name == "locomotive" or entity.name == "fluid-wagon" then
            entity.manual_mode = true
            table.insert(global.this_puzzle_trains, entity)
          elseif entity.name == "rail-signal" then
            entity.minable = true
          end
        end
        global.this_puzzle = setup[2].entities
        global.this_puzzle_param = setup[2].param
        recreate_entities(global.this_puzzle, global.this_puzzle_param)
      end,
      condition = function()
        return puzzle_condition()
      end
    },
    {
      init = function()
        clear_surface()
        global.required_signals = 8
        set_goal({"fix-intersection"})
        set_info({custom_function = add_run_trains_button})
        global.this_puzzle_trains = {}
        for k, entity in pairs (setup[3].entities) do
          if entity.name == "locomotive" or entity.name == "fluid-wagon" then
            entity.manual_mode = true
            table.insert(global.this_puzzle_trains, entity)
          elseif entity.name == "rail-signal" then
            entity.minable = true
          end
        end
        global.this_puzzle = setup[3].entities
        global.this_puzzle_param = setup[3].param
        recreate_entities(global.this_puzzle, global.this_puzzle_param)
      end,
      condition = function()
        return puzzle_condition()
      end
    },
    {
      init = function()
        clear_surface()
        global.required_signals = 4
        set_goal({"fix-intersection"})
        set_info({custom_function = add_run_trains_button})
        global.this_puzzle_trains = {}
        for k, entity in pairs (setup[4].entities) do
          if entity.name == "locomotive" or entity.name == "fluid-wagon" then
            entity.manual_mode = true
            table.insert(global.this_puzzle_trains, entity)
          elseif entity.name == "rail-signal" then
            entity.minable = true
          end
        end
        global.this_puzzle = setup[4].entities
        global.this_puzzle_param = setup[4].param
        recreate_entities(global.this_puzzle, global.this_puzzle_param)
      end,
      condition = function()
        return puzzle_condition()
      end
    },
    {
      init = function()
        clear_surface()
        global.required_signals = 6
        set_goal({"fix-intersection"})
        set_info({custom_function = add_run_trains_button})
        global.this_puzzle_trains = {}
        global.this_puzzle = setup[5].entities
        global.this_puzzle_param = setup[5].param
        for k, entity in pairs (global.this_puzzle) do
          if entity.name == "locomotive" or entity.name == "fluid-wagon" then
            entity.manual_mode = true
            table.insert(global.this_puzzle_trains, entity)
          elseif entity.name == "rail-signal" then
            entity.minable = true
          end
        end
        recreate_entities(global.this_puzzle, global.this_puzzle_param)
        for k, player in pairs (game.players) do
          local button = find_gui_recursive(player.gui, "story_continue_button")
          if button then
            button.caption = {"finish-button"}
          end
        end
      end,
      condition = function()
        return puzzle_condition()
      end
    }
  }
}

script.on_init(function()
  surface().always_day = true
  game.forces.player.manual_mining_speed_modifier = 4
  game.forces.player.disable_all_prototypes()
  global.story = story_init(story_table)
end)

script.on_event(defines.events.on_tick, function(event)
  story_update(global.story, event, "")
  limit_camera({0,0}, 20)
  loop_trains()
end)

script.on_event(defines.events.on_gui_click, function (event)
  story_update(global.story, event, "")
end)

script.on_event(defines.events.on_player_created, on_player_created)

story_gui_click = function(event)
  local element = event.element
  if not element.valid then return end
  local player = game.players[event.player_index]
  local name = element.name
  if name == "start_trains" then
    if not element.enabled then return end
    for k, train in pairs (surface().find_entities_filtered{name = "locomotive"}) do
      if train.train.schedule then
        train.train.manual_mode = false
      end
    end
    element.enabled = false
    player.set_controller{type = defines.controllers.ghost}
    return
  end
  if name == "reset_trains" then
    for k, train in pairs (surface().find_entities_filtered{name = "locomotive"}) do
      train.destroy()
    end
    for k, train in pairs (surface().find_entities_filtered{name = "fluid-wagon"}) do
      train.destroy()
    end
    recreate_entities(global.this_puzzle_trains, global.this_puzzle_param)
    for k, child in pairs (element.parent.children) do
      if child.name ~= "story_continue_button" then
        child.enabled = true
      end
    end
    player.set_controller{type = defines.controllers.god}
    if global.required_signals then
      local difference = global.required_signals - (player.surface.count_entities_filtered{name = "rail-chain-signal"} + player.get_item_count("rail-chain-signal"))
      if difference > 0 then
        player.insert{name = "rail-chain-signal", count = difference}
      end
    end
    return
  end
  if name == "reset_all" then
    clear_surface()
    recreate_entities(global.this_puzzle, global.this_puzzle_param)
    for k, child in pairs (element.parent.children) do
      if child.name ~= "story_continue_button" then
        child.enabled = true
      end
    end
    player.set_controller{type = defines.controllers.god}
    if player.get_item_count("rail-chain-signal") < global.required_signals then
      player.remove_item"rail-chain-signal"
      player.insert{name = "rail-chain-signal", count = global.required_signals}
    end
    return
  end
end

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

function add_run_trains_button(gui)
  local flow = gui.add{type = "table", column_count = 10}
  flow.style.horizontal_spacing = 2
  local button = flow.add{type = "button", name = "start_trains", caption = {"start-trains"}}
  local button = flow.add{type = "button", name = "reset_trains", caption = {"reset-trains"}}
  local button = flow.add{type = "button", name = "reset_all", caption = {"reset-all"}}
  add_button(flow)
  set_continue_button_style(function (button)
    if button.valid then
      button.enabled = false
    end
  end)
  local player = player()
  player.set_controller{type = defines.controllers.god}
  player.remove_item"rail-chain-signal"
  if global.required_signals and global.required_signals > 0 then
    player.insert{name = "rail-chain-signal", count = global.required_signals}
  end
  global.intermission = 0
  global.loop_interval = 0
  global.loop_tick = nil
end

function puzzle_condition()
  if global.continue then return true end
  for k, train in pairs (surface().find_entities_filtered{name = "locomotive"}) do
    if train.train.speed ~= 0 then
      return false
    end
    if train.color == nil then
      if train.train.state ~= defines.train_state.wait_station then
        return false
      end
      if train.health ~= 1000 then
        return false
      end
    end
    if train.train.state == defines.train_state.no_path then
      return false
    end
  end
  for k, wagon in pairs (surface().find_entities_filtered{name = "fluid-wagon"}) do
    if wagon.health ~= 600 then
      return false
    end
  end
  global.intermission = global.intermission + 1
  if global.intermission == 90 then
    flash_goal()
    set_continue_button_style(function (button)
      if button.valid then
        button.enabled = true
      end
    end)
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




