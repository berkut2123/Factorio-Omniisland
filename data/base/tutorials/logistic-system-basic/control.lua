require "story"
local camera = require "camera"
local tags = require "flying_tags"

script.on_init(function()
  global.story = story_init(story_table)
  surface().always_day = true
  game.forces.player.worker_robots_speed_modifier = 0
  game.forces.player.character_logistic_slot_count = 6
  game.forces.player.character_trash_slot_count = 6
end)

script.on_event(defines.events.on_player_created, function(event)
  local player = game.players[event.player_index]
  if player.character then player.character.destroy() end
  player.set_controller{type = defines.controllers.ghost}
  player.game_view_settings =
  {
    show_research_info = false,
    --update_entity_selection = false,
    show_alert_gui = false,
    show_side_menu = false,
    show_entity_info = true,
    show_minimap = false
  }
  game.permissions.get_group(0).set_allows_action(defines.input_action.start_walking, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.remove_cables, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_production_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_kills_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_tutorials_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_logistic_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_technology_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_blueprint_library_gui, false)
  --player.force.disable_all_prototypes()
end)
intermission =
{
  init = function() flying_congrats(global.last_built_position) end,
  condition = story_elapsed_check(2)
}
story_table =
{
  {
    {
      init = function()
        global.camera = camera.init({position = {0,0}, zoom = 1})
        table.insert(global.camera.players, player())
        global.check_to_jump = true
      end
    },
    {
      name = "loop_begin",
      init = function()
        for k, entity in pairs (surface().find_entities()) do
          entity.destroy()
        end
        camera.hold(global.camera, {time = 0.5})
      end,
      update = function()
        camera.update(global.camera)
      end,
      condition = function()
        return camera.idle(global.camera)
      end
    },
    {
      init = function()
        recreate_entities(loop_entities, {filter = {"roboport", "hidden-electric-energy-interface"}})
        camera.hold(global.camera, {time = 0.5})
      end,
      update = function()
        camera.update(global.camera)
      end,
      condition = function()
        return camera.idle(global.camera)
      end
    },
    {
      init = function()
        local tick = game.tick
        local poles = {}
        for k, entity in pairs (loop_entities) do
          if entity.name == "medium-electric-pole" then
            table.insert(poles, entity)
          end
        end
        local poles_on_tick = {}
        for k, pole in pairs (poles) do
          poles_on_tick[(k*10)+tick] = pole
        end
        global.create_entities_on_tick = poles_on_tick
        camera.hold(global.camera, {time = 1.5})
      end,
      update = function()
        create_entities_on_tick()
        camera.update(global.camera)
      end,
      condition = function()
        return camera.idle(global.camera)
      end
    },
    {
      init = function()
        recreate_entities(loop_entities, {filter = {"logistic-chest-passive-provider"}})
        recreate_entities(loop_entities, {filter = {"character"}})
        camera.hold(global.camera, {time = 0.5})
      end,
      update = function()
        create_entities_on_tick()
        camera.update(global.camera)
        local character = surface().find_entities_filtered({name = "character"})[1]
        if not character then return end
        character.walking_state = {walking = true, direction = defines.direction.south}
      end,
      condition = function()
        local character = surface().find_entities_filtered({name = "character"})[1]
        if not character then return end
        return character.position.y > -3.5
      end,
      action = function()
        local character = surface().find_entities_filtered({name = "character"})[1]
        if not character then return end
        character.walking_state = {walking = false, direction = defines.direction.south}
      end
    },
    {
      init = function()
        camera.hold(global.camera, {time = 1})
      end,
      update = function()
        camera.update(global.camera)
      end,
      condition = function()
        return camera.idle(global.camera)
      end
    },
    {
      init = function()
        local chest = surface().find_entities_filtered{name = "logistic-chest-passive-provider"}[1]
        chest.insert{name = "steel-plate", count = 200}
        set_info{text = {"robot-loop-info"}}
        set_info{custom_function = add_button, append = true}
        local character = surface().find_entities_filtered({name = "character"})[1]
        if character then
          character.set_request_slot({name = "steel-plate", count = 50}, 1)
        end
        flash_goal()
      end,
      update = function()
        camera.update(global.camera)
        local chest = surface().find_entities_filtered{name = "logistic-chest-passive-provider"}[1]
        local character = surface().find_entities_filtered({name = "character"})[1]
        if chest and character and (game.tick % 500 == 0) then
          chest.insert{name = "steel-plate", count = 50}
          character.remove_item{name = "steel-plate", count = 50}
        end
      end,
      condition = function()
        return false
      end
    },
    {
      name = "tutorial_begin",
      init = function()
        global.check_to_jump = false
        local player = player()
        local surface = player.surface
        for k, entity in pairs (surface.find_entities()) do
          entity.destroy()
        end
        recreate_entities(loop_entities, {filter = {"medium-electric-pole", "hidden-electric-energy-interface"}})
        player.set_controller{type = defines.controllers.character, character = surface.create_entity{force = "player", name = "character", position = {0, 0}}}
        player.game_view_settings.update_entity_selection = true
        player.game_view_settings.show_alert_gui = true
        game.permissions.get_group(0).set_allows_action(defines.input_action.start_walking, true)
        set_goal{"place-roboport-goal"}
        set_info()
        player.insert{name = "roboport", count = 1}
        player.insert{name = "medium-electric-pole", count = 10}
        player.force.character_trash_slot_count = 0
      end,
      condition = function()
        local surface = surface()
        local roboport = surface.find_entities_filtered{name = "roboport"}[1]
        if not (roboport and roboport.valid) then return false end
        if not roboport.is_connected_to_electric_network() then
          if game.tick % 120 ~= 0 then return end
          surface.create_entity{name = "tutorial-flying-text", text = {"roboport-no-electricity"}, color = {r = 1, g = 0.2, b = 0.2},
            position = {roboport.position.x, roboport.position.y - 2}}
          return false
        end
        return true
      end,
      action = function()
        local roboport = surface().find_entities_filtered{name = "roboport"}[1]
        if roboport and roboport.valid then
          global.last_built_position = roboport.position
          global.roboport = roboport
        end
        for k, entity in pairs (surface().find_entities()) do
          entity.minable = false
        end
      end
    },
    intermission,
    {
      init = function()
        set_goal(nil, false)
        local prototype = game.entity_prototypes["roboport"]
        set_info{text = {"notice-roboport-areas", prototype.logistic_radius * 2, prototype.construction_radius * 2}}
        set_info{custom_function = add_button, append = true}
        player().game_view_settings.update_entity_selection = false
        local roboport = surface().find_entities_filtered{name = "roboport"}[1]
        player().selected = roboport
        global.logistics_tag = tags.create{entity = roboport, offset = {0, -prototype.logistic_radius/2}, text = {"logistic-area"}, color = {r = 1, g = 0.5, b = 0.2}}
        global.construction_tag = tags.create{entity = roboport, offset = {0, -(prototype.logistic_radius + prototype.construction_radius)/2}, text = {"construction-area"}, color = {r = 0.2, g = 1, b = 0.2}}
      end,
      condition = function()
        return global.continue
      end,
      action = function()
        player().game_view_settings.update_entity_selection = true
        global.logistics_tag.destroy()
        global.construction_tag.destroy()
      end
    },
    {
      init = function()
        set_goal({"build-second-roboport"})
        set_info({text = {"build-second-roboport-info"}})
        player().insert{name = "roboport"}
      end,
      condition = function()
        local roboport
        for k, port in pairs (surface().find_entities_filtered{name = "roboport"}) do
          if port ~= global.roboport then
            roboport = port
          end
        end
        if not (roboport and roboport.valid) then return false end
        if not roboport.is_connected_to_electric_network() then
          if game.tick % 120 ~= 0 then return end
          surface().create_entity{name = "tutorial-flying-text", text = {"roboport-no-electricity"}, color = {r = 1, g = 0.2, b = 0.2},
            position = {roboport.position.x, roboport.position.y - 2}}
          return false
        end
        return global.roboport.logistic_cell.neighbours[1]
      end,
      action = function()
        for k, v in pairs (surface().find_entities_filtered{name = "roboport"}) do
          if v ~= global.roboport then
            global.second_roboport = v
            global.last_built_position = v.position
            break
          end
        end
        for k, entity in pairs (surface().find_entities()) do
          entity.minable = false
        end
        player().clear_items_inside()
      end
    },
    intermission,
    {
      init = function()
        set_goal(nil, false)
        set_info({text = {"notice-roboport-connection"}})
        set_info{custom_function = add_button, append = true}
        player().game_view_settings.update_entity_selection = false
        player().selected = global.second_roboport
        global.roboport_tag = tags.create
        {
          entity = global.second_roboport,
          offset =
          {
            x = (global.roboport.position.x - global.second_roboport.position.x) / 2,
            y = ((global.roboport.position.y - global.second_roboport.position.y) / 2) - 1
          },
          text = {"connecting-line"},
          color = {r = 1, g = 1, b = 0.2}
        }
      end,
      condition = function()
        return global.continue
      end,
      action = function()
        player().game_view_settings.update_entity_selection = true
        global.roboport_tag.destroy()
      end
    },
    {
      init = function()
        set_goal{"build-robot"}
        set_info({text = {"build-robot-info"}})
        player().insert{name = "logistic-robot"}
        for k, roboport in pairs (surface().find_entities_filtered{name = "roboport"}) do
          roboport.operable = false
        end
      end,
      condition = function()
        for k, robot in pairs (surface().find_entities_filtered{name = "logistic-robot"}) do
          if robot then
            global.robot = robot
            return true
          end
        end
      end,
      action = function()
        global.robot.minable = false
        global.robot.force = "neutral"
      end
    },
    intermission,
    {
      init = function()
        set_goal(nil, false)
        set_info{text = {"watch-robot"}}
        set_info{custom_function = add_button, append = true}
        player().selected = global.robot
        global.robot.force = player().force
        player().game_view_settings.update_entity_selection = false
      end,
      update = function()
        global.robot.energy = global.robot.prototype.max_energy * 0.8
      end,
      condition = function()
        return global.continue
      end,
      action = function()
        player().game_view_settings.update_entity_selection = true
        for k, roboport in pairs (surface().find_entities_filtered{name = "roboport"}) do
          roboport.operable = true
        end
        global.robot = nil
      end
    },
    {
      init = function()
        set_goal{"build-logistic-chest"}
        set_info()
        player().insert{name = "logistic-chest-passive-provider"}
      end,
      condition = function()
        for k, chest in pairs (surface().find_entities_filtered{name = "logistic-chest-passive-provider"}) do
          return chest.logistic_network ~= nil
        end
      end,
      action = function()
        for k, chest in pairs (surface().find_entities_filtered{name = "logistic-chest-passive-provider"}) do
          chest.minable = false
          global.chest = chest
          break
        end
      end
    },
    intermission,
    {
      init = function()
        set_goal{"place-belts-in-chest"}
        set_info()
        player().insert{name = "transport-belt", count = 100}
      end,
      condition = function()
        return global.chest.get_item_count("transport-belt") == 100
      end,
      action = function()
        global.last_built_position = global.chest.position
      end
    },
    intermission,
    {
      init = function()
        set_goal(nil, false)
        set_info{text = {"logistic-chest-info"}}
        set_info{custom_function = add_button, append = true}
        player().selected = global.chest
        player().game_view_settings.update_entity_selection = false
      end,
      condition = function()
        return global.continue
      end,
      action = function()
        player().game_view_settings.update_entity_selection = true
      end
    },
    {
      init = function()
        set_goal{"set-request-goal"}
        set_info{text = {"set-request-info"}, picture = "file/set-request-image.png"}
      end,
      condition = function()
        local character = surface().find_entities_filtered({name = "character"})[1]
        for k = 1, 5 do
          local stack = character.get_request_slot(k)
          if stack and stack.name == "transport-belt" then
            return true
          end
        end
      end,
      action = function()
        global.last_built_position = {x = player().position.x, y = player().position.y - 5}
      end
    },
    intermission,
    {
      init = function()
        player().clear_items_inside()
        global.chest.insert{name = "transport-belt", count = 100}
        global.chest.operable = false
        player().opened = nil
        set_goal(nil, false)
        set_info{text = {"watch-bots-info"}}
        set_info{custom_function = add_button, append = true}
        player().game_view_settings.update_entity_selection = false
        for k, robot in pairs (surface().find_entities_filtered{name = "logistic-robot"}) do
          player().selected = robot
          global.robot = robot
          global.robot_tag = tags.create{entity = robot, offset = {0,-2}, text = {"picking-item"}, color = {r = 1, g = 1, b = 0.2}}
          break
        end
      end,
      update = function()
        if not (global.robot and global.robot.valid) then return end
        if global.robot.get_item_count("transport-belt") > 0 then
          global.robot_tag.text = {"supplying-item"}
          global.robot_tag.color = {r = 0.2, g = 1, b = 0.2}
        else
          global.robot_tag.text = {"picking-item"}
          global.robot_tag.color = {r = 1, g = 1, b = 0.2}
        end
      end,
      condition = function()
        return global.continue
      end,
      action = function()
        player().game_view_settings.update_entity_selection = true
        global.chest.operable = true
        if global.robot_tag and global.robot_tag.valid then global.robot_tag.destroy() end
        global.robot_tag = nil
      end
    },
    {
      init = function()
        set_goal{"add-more-bots"}
        set_info({text = {"add-more-bots-info"}})
        player().insert{name = "logistic-robot", count = 20}
        global.last_built_position = nil
      end,
      condition = function()
        local count = 0
        for k, roboport in pairs (surface().find_entities_filtered{name = "roboport"}) do
          count = count + roboport.get_item_count("logistic-robot")
        end
        count = count + surface().count_entities_filtered{name = "logistic-robot"}
        return count > 20
      end
    },
    intermission,
    {
      init = function()
        set_goal({"delete-request"})
        set_info({text = {"delete-request-info"}})
      end,
      condition = function()
        local character = player().character
        if not character then return true end
        for k = 1, 5 do
          local stack = character.get_request_slot(k)
          if stack then
            return false
          end
        end
        return true
      end,
      action = function()
        global.last_built_position = {x = player().position.x, y = player().position.y - 5}
      end
    },
    intermission,
    {
      init = function()
        set_goal{"build-storage-chest"}
        set_info()
        player().insert{name = "logistic-chest-storage"}
      end,
      condition = function()
        for k, chest in pairs (surface().find_entities_filtered{name = "logistic-chest-storage"}) do
          return chest.logistic_network ~= nil
        end
      end,
      action = function()
        for k, chest in pairs (surface().find_entities_filtered{name = "logistic-chest-storage"}) do
          chest.minable = false
          global.storage = chest
          break
        end
      end
    },
    intermission,
    {
      init = function()
        set_goal(nil, false)
        set_info{text = {"storage-chest-info"}}
        set_info{custom_function = add_button, append = true}
        --player().game_view_settings.update_entity_selection = false
        --player().selected = global.storage
      end,
      condition = function()
        return global.continue
      end,
      action = function()
        player().game_view_settings.update_entity_selection = true
      end
    },
    {
      init = function()
        player().force.character_trash_slot_count = 6
        for k, name in pairs (junk) do
          player().insert(name)
        end
        set_goal{"trash-items-goal"}
        set_info{picture = "file/trash-items-image.png"}
        set_info{text = {"trash-items-info"}, append = true}
      end,
      condition = function()
        local character = surface().find_entities_filtered{name = "character"}[1]
        if character and character.valid then
          for k, name in pairs (junk) do
            if character.get_inventory(defines.inventory.character_trash).get_item_count(name) > 0 then
              return true
            end
          end
        end
      end,
      action = function()
        global.last_built_position = {x = player().position.x, y = player().position.y - 5}
      end
    },
    intermission,
    {
      init = function()
        player().opened = nil
        set_goal(nil, false)
        set_info{text = {"watch-junk-bots-info"}}
        set_info{custom_function = function(gui) add_button(gui).caption = {"finish"} end, append = true}
        player().game_view_settings.update_entity_selection = false
        for k, robot in pairs (surface().find_entities_filtered{name = "logistic-robot"}) do
          global.robot = robot
          player().selected = robot
          global.robot_tag = tags.create{entity = robot, offset = {0, -2}, text = {"taking-item-from-player"}, color = {r = 1, g = 1, b = 0.2}}
          break
        end
      end,
      update = function()
        if not (global.robot and global.robot.valid) then return end
        if global.robot.get_item_count("stone") > 0 then
          global.robot_tag.text = {"storing-item"}
          global.robot_tag.color = {r = 0.2, g = 1, b = 0.2}
        elseif player().get_inventory(defines.inventory.character_trash).is_empty() then
          global.robot_tag.text = {"returning-to-roboport"}
          global.robot_tag.color = {r = 0.8, g = 0.8, b = 0.8}
        else
          global.robot_tag.text = {"taking-item-from-player"}
          global.robot_tag.color = {r = 1, g = 1, b = 0.2}
        end
      end,
      condition = function()
        return global.continue
      end
    }
  }
}

junk = {"stone"}

function create_entities_on_tick()
  if not global.create_entities_on_tick then return end
  local entity = global.create_entities_on_tick[game.tick]
  if not entity then return end
  surface().create_entity(entity)
end

script.on_event(defines.events.on_tick, function(event)
  if global.check_to_jump then
    if global.continue then
      story_jump_to(global.story, "tutorial_begin")
      global.continue = nil
    end
  end
  story_update(global.story, event)
  tags.update()
end)

script.on_event(defines.events.on_gui_click, function (event)
  story_update(global.story, event)
end)

script.on_event(defines.events.on_built_entity, function (event)
  local entity = event.created_entity
  if entity and entity.name == "entity-ghost" then
    entity.destroy()
    return
  end
  story_update(global.story, event)
end)

script.on_load(function()
  global.story.helpers = make_helpers(story_table)
end)

loop_entities =
{
  {
    destructible = true,
    force = "player",
    index = 15,
    minable = false,
    name = "character",
    operable = true,
    position =
    {
      x = 4.5,
      y = -25
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 15,
    minable = false,
    name = "logistic-chest-passive-provider",
    operable = true,
    position =
    {
      x = -4.5,
      y = -3.5
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 17,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = -7.5,
      y = -1.5
    },
    rotatable = true
  },
  {
    backer_name = "",
    destructible = true,
    force = "player",
    index = 18,
    inventory =
    {
      {
        ["logistic-robot"] = 1
      },
      {}
    },
    minable = false,
    name = "roboport",
    operable = true,
    position =
    {
      x = 0,
      y = 0
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 19,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = 7.5,
      y = -1.5
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 20,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = -3.5,
      y = 4.5
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 21,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = 3.5,
      y = 4.5
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 22,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = 3.5,
      y = 13.5
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 23,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = 3.5,
      y = 22.5
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 24,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = 3.5,
      y = 31.5
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 25,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = 3.5,
      y = 40.5
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 26,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = 3.5,
      y = 49.5
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 27,
    minable = false,
    name = "hidden-electric-energy-interface",
    operable = true,
    position =
    {
      x = 3.5,
      y = 59
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 28,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = 3.5,
      y = 58.5
    },
    rotatable = true
  }
}
