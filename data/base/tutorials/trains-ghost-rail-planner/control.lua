require "story"
require "ghost-rails"
required_count = 10
through_wall_path = 50

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
    player().clean_cursor()
    flying_congrats(global.last_built_position)
    set_goal()
    set_info()
  end,
  condition = story_elapsed_check(1)
}

story_table =
{
  {
    {condition = story_elapsed_check(1)},
    {
      init = function()
        global.built_rail = 0
        set_goal({"place-ghost-rail", global.built_rail, 4})
        set_info({text = {"place-ghost-rail-info"}})
        player().insert{name = "rail", count = 1000}
      end,
      update = function(event)
        set_goal({"place-ghost-rail", surface().count_entities_filtered{name = "entity-ghost"}, 4}, true)
      end,
      condition = function(event)
        if event.name == defines.events.on_tick then
          return surface().count_entities_filtered{name = "entity-ghost"} >= 4
        end
      end,
      action = function()
      end
    },
    intermission,
    {
      init = function()
        set_goal({"start-ghost-rail-planning", 0, required_count})
        set_info(
        {
          text = {"start-ghost-rail-planning-info"},
          pictures =
          {
            "file/ghost-plan-1.png",
            "file/ghost-plan-2.png",
            {path = "file/ghost-plan-3.png", split = true}
          }
        })
        global.initial = surface().count_entities_filtered{type = "entity-ghost"}
      end,
      condition = function(event)
        if event.name == defines.events.on_tick then
          local count = 0
          for k, entity in pairs (surface().find_entities_filtered{type = "entity-ghost"}) do
            if entity.ghost_name == "curved-rail" then
              count = count + 1
            end
          end
          local count = count - global.initial
          set_goal({"start-ghost-rail-planning", math.max(count, 0), required_count}, true)
          return  count >= required_count
        end
      end,
      action = function()
        player().clean_cursor()
      end
    },
    intermission,
    {
      init = function()
        deconstruct_on_tick(surface().find_entities_filtered{name = "entity-ghost"})
      end,
      condition = function()
        return deconstruct_on_tick()
      end
    },
    {
      init = function()
        set_goal({"rotate-rail"})
        set_info({text = {"rotate-rail-info"}, picture = "file/rotate-rail.png"})
        local surface = surface()
        for k, v in pairs (surface.find_entities_filtered{name = "entity-ghost"}) do
          v.destroy()
        end
        surface.create_entity
        {
          name = "entity-ghost",
          inner_name = "straight-rail",
          direction = 2,
          position = {-7, -3},
          force = "player",
          expires = false
        }.minable = false
        surface.create_entity
        {
          name = "entity-ghost",
          inner_name = "straight-rail",
          direction = 2,
          position = {9,3},
          force = "player",
          expires = false
        }.minable = false
      end,
      condition = function(event)
        if event.name ~= defines.events.on_tick then return end
        local rails =
        {
          {position = {-2, -2}, area = {{-3, -3}, {-1,-1}}, direction = 3},
          {position = {4, 2}, area = {{5, 1}, {3, 3}}, direction = 7}
        }
        local surface = surface()
        count = 0
        for k, ghost in pairs (surface.find_entities_filtered({name = "entity-ghost"})) do
          for j, rail in pairs (rails) do
            if ghost.ghost_name == "curved-rail" and
               ghost.position.x == rail.position[1] and
               ghost.position.y == rail.position[2] and
               ghost.direction == rail.direction then
              count = count + 1
              break
            end
          end
        end
        if count >= 2 then
          return true
        end
        local any_destroyed = false
        for k, rail in pairs (surface.find_entities_filtered({name = "entity-ghost"})) do
          if rail.name ~= "character" and rail.minable then
            rail.destroy()
            any_destroyed = true
          end
        end
        if any_destroyed then
          game.print({"rotate-rail-not-1-tick"})
          player().clean_cursor()
        end
      end
    },
    intermission,
    {
      init = function()
        deconstruct_on_tick(surface().find_entities_filtered{name = "entity-ghost"})
      end,
      condition = function()
        return deconstruct_on_tick()
      end
    },
    {
      init = function() recreate_entities_on_tick(other, nil, 1) end,
      condition = function() return recreate_entities_on_tick() end
    },
    {
      init = function()
        set_goal({"trace-path"})
        set_info()
        local surface = surface()
        global.text =
        {
          surface.create_entity{name = "tutorial-flying-text", text = {"connect-start"}, position = {-15, -12}},
          surface.create_entity{name = "tutorial-flying-text", text = {"connect-end"}, position = {-15, 10}}
        }
        for k, text in pairs (global.text) do
          text.active = false
        end

      end,
      condition = function()
        local surface = surface()
        local count = 0
        for k, entity in pairs (rails) do
          local ghost = surface.find_entity("entity-ghost", entity.position)
          if ghost then
            count = count + 1
          else
            local area = {{entity.position.x-2, entity.position.y-2}, {entity.position.x+2, entity.position.y+2}}
            for j, ghost in pairs (surface.find_entities_filtered{area = area, name = "entity-ghost"}) do
              if ((ghost.position.x == entity.position.x) and (ghost.position.y == entity.position.y) and (ghost.ghost_name == entity.name)) then
                count = count + 1
                break
              end
            end
          end
        end
        return count >= #rails
      end,
      action = function()
        for k, arrow in pairs (global.text) do
          if arrow.valid then
            arrow.destroy()
          end
        end
        global.arrows = nil
        player().clean_cursor()
      end
    },
    intermission,
    {
      init = function()
        player().clean_cursor()
        player().character_mining_speed_modifier = -1
        set_goal({"force-through-obstacles"})
        set_info({text = {"force-through-obstacles-info"}, picture = "file/through-obstacles.png"})
      end,
      condition = function(event)
        --should deconstruct 3 trees and the stone rock, so 4 in total.
        if event.name ~= defines.events.on_tick then return end
        local count = 0
        local some_rail = false
        local surface = surface()
        for k, tree in pairs (surface.find_entities_filtered{type = "tree"}) do
          if tree.to_be_deconstructed("player") then
            count = count + 1
            if surface.find_entities_filtered{area = tree.bounding_box, name = "entity-ghost"}[1] then
              some_rail = true
            end
          end
        end
        for k, rock in pairs (surface.find_entities_filtered{name = "rock-big"}) do
          if rock.to_be_deconstructed("player") then
            count = count + 1
            if surface.find_entities_filtered{area = rock.bounding_box, name = "entity-ghost"}[1] then
              some_rail = true
            end
          end
        end
        return count >= 4 and some_rail
      end
    },
    intermission,
    {
      init = function()
        local entities = {}
        for k, entity in pairs (surface().find_entities()) do
          if entity.name ~= "character" then
            entities[k] = entity
          end
        end
        deconstruct_on_tick(entities)
      end,
      condition = function()
        return deconstruct_on_tick()
      end
    },
    {
      init = function()
        local entities = {}
        local rand = math.random
        local list = {}
        for k, entity in pairs (game.entity_prototypes) do
          if entity.type == "tree" then
            table.insert(list, entity.name)
          end
        end
        for k = 1, 350 do
          local position = {x = rand(-52,51), y = rand(-51,52)}
          entities[k] = {name = list[rand(#list)], position = position, force = "neutral", minable = true}
        end
        recreate_entities_on_tick(entities, {check_can_place = true}, 1)
      end,
      condition = function()
        return recreate_entities_on_tick()
      end
    },
    {
      init = function()
        set_goal({"crazy-rail", surface().count_entities_filtered{area = {{-50, -50}, {50, 50}}, name = "entity-ghost"}, through_wall_path})
        set_info({text = {"crazy-rail-info"}})
        local surface = surface()
        surface.create_entity{name = "entity-ghost", inner_name = "straight-rail", direction = 2, position = {-59, 1}, force = "player", expires = false}
        surface.create_entity{name = "entity-ghost", inner_name = "straight-rail", direction = 2, position = {59, 1}, force = "player", expires = false}
        surface.create_entity{name = "entity-ghost", inner_name = "straight-rail", direction = 0, position = {1, 59}, force = "player", expires = false}
        surface.create_entity{name = "entity-ghost", inner_name = "straight-rail", direction = 0, position = {1, -59}, force = "player", expires = false}
      end,
      condition = function(event)
        local count = surface().count_entities_filtered{area = {{-50, -50}, {50, 50}}, name = "entity-ghost"}
        set_goal({"crazy-rail", count, through_wall_path}, true)
        return count >= through_wall_path
      end
    },
    intermission,
    {
      init = function()
        set_info{text = {"finish-info"}}
        set_info{custom_function = function(flow) add_button(flow).caption = {"finish"} end, append = true}
        set_goal(nil, false)
      end,
      condition = function()
        return global.continue
      end

    }
  }
}

script.on_init(function()
  game.forces.player.manual_mining_speed_modifier = 4
  game.forces.player.disable_all_prototypes()
  surface().always_day = true
  global.story = story_init(story_table)
end)

script.on_event(defines.events, function(event)
  check_built_real_rail(event)
  story_update(global.story, event, "")
  if event.name == defines.events.on_player_created then
    on_player_created(event)
  end
end)

function check_built_real_rail(event)
  if event.name ~= defines.events.on_tick then return end
  local surface = surface()
  local player = player()
  local create = false
  for k, rail in pairs (surface.find_entities_filtered{type = "straight-rail"}) do
    if rail.minable then
      rail.destroy()
      player.clean_cursor()
      player.insert{name = "rail", count = 1}
      create = true
    end
  end
  for k, rail in pairs (surface.find_entities_filtered{type = "curved-rail"}) do
    if rail.minable then
      rail.destroy()
      player.clean_cursor()
      player.insert{name = "rail", count = 4}
      create = true
    end
  end
  if create then
    surface.create_entity{
      name = "tutorial-flying-text",
      position = {global.last_built_position.x, global.last_built_position.y - 2},
      text = {"built-real-rail"},
      color = {r = 1, g = 0.1, b = 0.1}
    }
  end
end

function current_ghosts_count(area)
  if area then
    return surface().count_entities_filtered{area = area, name = "entity-ghost"}
  else
    return surface().count_entities_filtered{name = "entity-ghost"}
  end
end

script.on_load(function()
  global.story.helpers = make_helpers(story_table)
end)
