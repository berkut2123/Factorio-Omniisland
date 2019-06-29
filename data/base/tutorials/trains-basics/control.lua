require "story"
require "rail_ghosts"

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

intermission =
{
  init = function()
    set_goal()
    set_info()
    player().clean_cursor()
    flying_congrats(global.last_built_position)
  end,
  condition = story_elapsed_check(1)
}

story_table =
{
  {
    {condition = story_elapsed_check(1)},
    {
      init = function()
        set_goal({"place-rail-objective", 0, 4})
        set_info({text = {"place-rail"}})
        player().insert{name = "rail", count = 1000}
      end,
      condition = function()
        local count = 0
        for k, entity in pairs (surface().find_entities_filtered{name = "straight-rail"}) do
          if entity.direction == 2 then
            count = count + 1
          end
        end
        set_goal({"place-rail-objective", count, 4}, true)
        return count >= 4
      end
    },
    intermission,
    {
      init = function()
        set_goal({"place-curved-rail", 0, 4})
        set_info({text = {"place-curved-rail-info"},
          pictures =
          {
            {path = "file/place-curved-rail-1.png"},
            {path = "file/place-curved-rail-2.png"},
            {path = "file/place-curved-rail-3.png", split = true}
          }
        })
      end,
      condition = function(event)
        local count = surface().count_entities_filtered{name = "curved-rail"}
        set_goal({"place-curved-rail", count, 4}, true)
        return count >= 4
      end,
      action = function()
        player().clean_cursor()
      end
    },
    intermission,
    {
      init = function()
        deconstruct_on_tick(non_player_entities())
      end,
      condition = function()
        return deconstruct_on_tick()
      end
    },
    {
      init = function()
        recreate_entities_on_tick(ghosts_1, {offset = {0, 20}})
      end,
      condition = function()
        return recreate_entities_on_tick()
      end
    },
    {
      init = function()
        global.initial = surface().count_entities_filtered{name = "entity-ghost"}
        set_goal({"rail-planner-objective", 0, global.initial})
        set_info(
        {
          text = {"rail-planner-info"}
        })
      end,
      condition = function()
        local count = surface().count_entities_filtered{name = "entity-ghost"}
        set_goal({"rail-planner-objective", global.initial-count, global.initial}, true)
        return count <= 0
      end
    },
    intermission,
    {
      init = function()
        deconstruct_on_tick(non_player_entities())
      end,
      condition = function()
        return deconstruct_on_tick()
      end
    },
    {
      init = function()
        for k, entity in pairs (ghosts_1) do
          entity.name = entity.inner_name
        end
        recreate_entities_on_tick(ghosts_1, {offset = {0, 20}})
      end,
      condition = function()
        return recreate_entities_on_tick()
      end
    },
    {
      init = function()
        set_goal({"place-train"})
        set_info({text = {"place-train-info"}, picture = "file/place-train.png"})
        player().clear_items_inside()
        player().insert{name = "locomotive", count = 1}
      end,
      condition = function(event)
        if event.name ~= defines.events.on_built_entity then return end
        local entity = event.created_entity
        if not entity.valid then return end
        return entity.name == "locomotive"
      end,
      action = function(event)
        global.locomotive = event.created_entity
        global.locomotive.minable = false
      end
    },
    intermission,
    {
      init = function()
        global.last_built_position = nil
        set_goal({"place-fuel"})
        player().insert{name = "coal", count = 20}
        player().insert{name = "coal", count = 20}
      end,
      condition = function()
        return global.locomotive.get_item_count("coal") > 0
      end,
      action = function()
        player().clear_items_inside()
      end
    },
    intermission,
    {
      init = function()
        set_goal({"enter-train"})
        set_info({text = {"enter-train-info"}})
      end,
      condition = function()
        return (player().vehicle == global.locomotive)
      end
    },
    intermission,
    {
      init = function()
        set_goal({"drive-forward"})
      set_info({text = {"drive-forward-info"}})
      end,
      condition = function()
        return global.locomotive.train.speed > 0.5
      end
    },
    intermission,
    {
    init = function()
      set_goal({"stop-train"})
      set_info({text = {"stop-train-info"}})
    end,
    condition = function()
      return (global.locomotive.train.speed == 0)
    end
    },
    intermission,
    {
    init = function()
      set_goal({"drive-backward"})
      set_info({text = {"drive-backward-info"}})
    end,
    condition = function()
      return global.locomotive.train.speed <= -0.2
    end
    },
    intermission,
    {
      init = function()
        for k, entity in pairs (ghosts_2) do
          entity.name = entity.inner_name
        end
        recreate_entities_on_tick(ghosts_2, {offset = {0, -2}})
      end,
      condition = function()
        return recreate_entities_on_tick()
      end
    },
    {
    init = function()
      set_goal({"steer-train"})
      set_info({text = {"steer-train-info"}})
    end,
    condition = function()
      return (global.locomotive.position.y > 15)
    end
    },
    intermission,
    {
      init = function()
        flash_goal()
        set_info({text = {"finish-info"}})
        set_info({custom_function = function(flow) add_button(flow).caption = {"finish"} end, append = true})
        for k, entity in pairs (surface().find_entities()) do
          entity.minable = true
        end
        player().insert{name = "rail", count = 1000}
      end,
      condition = function()
        return global.continue
      end
    }
  }
}

script.on_init(function()
  game.forces.player.manual_mining_speed_modifier = 5
  game.forces.player.disable_all_prototypes()
  surface().always_day = true
  global.story = story_init(story_table)
end)

local on_built_entity = function(event)
  local entity = event.created_entity or event.entity
  if not (entity and entity.valid) then return end
  if entity.name ~= "entity-ghost" then return end
  entity.destroy()
end

script.on_event(defines.events, function(event)
  story_update(global.story, event, "")
  if event.name == defines.events.on_player_created then
    return on_player_created(event)
  end
  if event.name == defines.events.on_built_entity then
    return on_built_entity(event)
  end
end)

local clear_types = {"straight-rail", "curved-rail", "entity-ghost"}
function clear_rails(surface)
  for k, rail in pairs (surface.find_entities_filtered{type = clear_types}) do
    rail.destroy()
  end
end

function non_player_entities()
  local entities = {}
  local insert = table.insert
  for k, entity in pairs (surface().find_entities()) do
    if entity.name ~= "character" then
      insert(entities, entity)
    end
  end
  return entities
end

script.on_load(function()
  global.story.helpers = make_helpers(story_table)
end)
