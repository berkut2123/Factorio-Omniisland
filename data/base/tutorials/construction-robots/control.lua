require "story"
local camera = require "camera"
local tags = require "flying_tags"

script.on_init(function()
  global.story = story_init(story_table)
  surface().always_day = true
  game.forces.player.worker_robots_speed_modifier = -0.3
end)

script.on_event(defines.events.on_player_created, function(event)
  local player = game.players[event.player_index]
  if player.character then player.character.destroy() end
  player.set_controller{type = defines.controllers.ghost}
  player.game_view_settings =
  {
    show_side_menu = false,
    show_research_info = false,
    show_alert_gui = false,
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
  --player.force.disable_all_prototypes()
end)

intermission =
{
  init = function()
    flying_congrats(global.last_built_position)
    set_goal()
    set_info()
  end,
  condition = story_elapsed_check(1),
  action = function()
    global.last_built_position = nil
  end
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
      init = function()
        for k, entity in pairs (surface().find_entities()) do
          entity.destroy()
        end
        camera.hold(global.camera, {time = 0.3})
      end,
      condition = function()
        return camera.idle(global.camera)
      end
    },
    {
      init = function()
        recreate_entities(loop_entities, {filter = {"roboport", "hidden-electric-energy-interface"}})
        camera.hold(global.camera, {time = 0.3})
      end,
      condition = function()
        return camera.idle(global.camera)
      end
    },
    {
      init = function()
        recreate_entities(loop_entities, {filter = {"logistic-chest-storage"}})
        camera.hold(global.camera, {time = 0.3})
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
        camera.hold(global.camera, {time = (#poles*(1/6))+0.5})
      end,
      update = function() create_entities_on_tick() end,
      condition = function()
        return camera.idle(global.camera)
      end
    },
    {
      init = function()
        set_info{
          text = {"robot-loop-info"},
          --picture = "technology/construction-robotics"
        }
        set_info{custom_function = add_button, append = true}
        --flash_goal()
        global.roboport = surface().find_entities_filtered{name = "roboport"}[1]
      end
    },
    {name = "loop_begin"},
    {
      --name = "loop_begin",
      init = function()
        global.roboport.clear_items_inside()
        global.ghost_tag = tags.create
        {
          entity = surface().create_entity
          {
            name = "entity-ghost",
            force = "player",
            inner_name = "laser-turret",
            position = {0, -2},
            expires = false
          },
          offset = {0,-2},
          text = {"ghost-placed"}
        }
      end,
      condition = story_elapsed_check(2),
      action = function()
        global.roboport_tag = tags.create{entity = global.roboport, offset = {0,-3}, text = {"dispatching-robot"}}
        global.ghost_tag.destroy()
      end
    },
    {condition = story_elapsed_check(2)},
    {
      init = function()
        global.roboport_tag.destroy()
        global.roboport.insert{name = "construction-robot", count = 1}
        local chest = surface().find_entities_filtered{name = "logistic-chest-storage"}[1]
        chest.insert{name = "laser-turret", count = 2}
        chest.insert{name = "repair-pack", count = 2}
      end,
      update = function()
        if global.robot and global.robot.valid then return end
        local robot = surface().find_entities_filtered{name = "construction-robot"}[1]
        if not robot then return end
        global.robot = robot
        if not (global.robot_tag and global.robot_tag.valid) then
          global.robot_tag = tags.create{entity= robot, offset = {y = -3}, text = {"robot-getting-item"}}
        end
      end,
      condition = function()
        return global.robot and global.robot.valid and global.robot.get_item_count("laser-turret") > 0
      end
    },
    {
      init = function()
        global.robot_tag.text = {"robot-has-item"}
      end,
      condition = function()
        return surface().find_entities_filtered{name = "laser-turret"}[1]
      end
    },
    {
      init = function()
        global.robot_tag.text = {"returning-to-roboport"}
      end,
      condition = function() return global.roboport.get_item_count("construction-robot") > 0 end,
      action = function() global.roboport.clear_items_inside() end
    },
    {
      init = function()
        local surface = surface()
        local turret = surface.find_entities_filtered{name = "laser-turret"}[1]
        game.forces.player.set_turret_attack_modifier("laser-turret", -0.75)
        local biter = surface.create_entity{name = "medium-biter", force = "enemy", position = {-20, 5}}
        biter.set_command{
          type = defines.command.attack,
          target = turret,
          distraction = defines.distraction.none
        }
        tags.create({entity = biter, text = {"biter-bite"}, color = {r = 1, g = 0.2, b = 0.2}})
      end,
      condition = function()
        local turret = surface().find_entities_filtered{name = "laser-turret"}[1]
        return turret.health < turret.prototype.max_health and surface().count_entities_filtered({name = "medium-biter"}) == 0
      end,
      action = function()
        local turret = surface().find_entities_filtered{name = "laser-turret"}[1]
        global.turret = turret
        global.turret_tag = tags.create{entity = turret, offset = {y = -2}, text = {"turret-damaged"}}
      end
    },
    {
      condition = story_elapsed_check(2),
      action = function()
        global.roboport_tag = tags.create{entity = global.roboport, text = {"dispatching-robot"}, offset = {0,-3}}
        global.turret_tag.destroy()
      end
    },
    {condition = story_elapsed_check(2)},
    {
      init = function()
        global.roboport.insert{name = "construction-robot"}
        global.roboport_tag.destroy()
      end,
      update = function()
        if global.robot and global.robot.valid then return end
        local robot = surface().find_entities_filtered{name = "construction-robot"}[1]
        if not robot then return end
        global.robot = robot
        global.robot_tag = tags.create{entity= robot, offset = {y = -3}, text = {"robot-getting-repair-pack"}}
      end,
      condition = function()
        return global.robot and global.robot.valid and global.robot.get_item_count("repair-pack") > 0
      end
    },
    {
      init = function()
        global.robot_tag.text = {"heading-to-repair"}
      end,
      condition = function()
        return global.turret.health == global.turret.prototype.max_health
      end
    },
    {
      init = function()
        global.robot_tag.text = {"returning-to-roboport"}
      end,
      condition = function()
        return not (global.robot and global.robot.valid)
      end
    },
    {
      condition = story_elapsed_check(2)
    },
    {
      init = function()
        local turret = surface().find_entities_filtered{name = "laser-turret"}[1]
        turret.order_deconstruction(turret.force)
        global.turret_tag = tags.create{entity = turret, offset = {y = -2}, text = {"marked-for-deconstruction"}}
        global.roboport.clear_items_inside()
      end,
      condition = story_elapsed_check(2)
    },
    {
      init = function()
        global.turret_tag.destroy()
        global.roboport_tag = tags.create{entity = global.roboport, text = {"dispatching-robot"}, offset = {0, -3}}
      end,
      condition = story_elapsed_check(2)
    },
    {
      init = function()
        global.roboport.insert{name = "construction-robot"}
        global.roboport_tag.destroy()
      end,
      update = function()
        if global.robot and global.robot.valid then return end
        local robot = surface().find_entities_filtered{name = "construction-robot"}[1]
        if not robot then return end
        global.robot = robot
        global.robot_tag = tags.create{entity= robot, offset = {y = -3}, text = {"heading-to-deconstruct"}}
      end,
      condition = function()
        return global.robot and global.robot.valid and global.robot.get_item_count("laser-turret") > 0
      end,
      action = function()
        global.robot_tag.text = {"heading-to-store"}
      end
    },
    {
      condition = function()
        return global.robot.get_item_count("laser-turret") == 0
      end,
      action = function() global.robot_tag.text = {"returning-to-roboport"} end
    },
    {
      condition = function()
        return not (global.robot and global.robot.valid)
      end
    },
    {
      condition = story_elapsed_check(2),
      action = function()
        if not global.continue then
          flash_goal()
          story_jump_to(global.story, "loop_begin")
        end
      end
    },
    {
      name = "tutorial_begin",
      init = function()
        global.camera = nil
        global.check_to_jump = false
        local player = player()
        local surface = player.surface
        for k, entity in pairs (surface.find_entities()) do
          entity.destroy()
        end
        recreate_entities(loop_entities, {filter = {"medium-electric-pole", "hidden-electric-energy-interface", "roboport"}})
        player.set_controller{type = defines.controllers.character, character = surface.create_entity{force = "player", name = "character", position = {0, 0}}}
        player.game_view_settings.update_entity_selection = true
        player.game_view_settings.show_alert_gui = true
        game.permissions.get_group(0).set_allows_action(defines.input_action.start_walking, true)
        set_goal{"place-construction-bot"}
        set_info()
        player.insert{name = "construction-robot"}
      end,
      condition = function()
        local robot = surface().find_entities_filtered{name = "construction-robot"}[1]
        if not robot then return end
        global.robot = robot
        return true
      end,
      action = function()
        global.robot.force = "neutral"
        global.robot.minable = false
      end
    },
    intermission,
    {
      init = function()
        set_goal(nil, false)
        set_info({text = {"notice-robot-info"}})
        set_info{custom_function = add_button, append = true}
        global.robot.force = "player"
        tags.create{entity = global.robot, offset = {0,-3}, text ={"returning-to-roboport"}}
      end,
      condition = function()
        return global.continue
      end,
      update = function()
        global.robot.energy = global.robot.prototype.max_energy * 0.8
      end,
      action = function()
        player().game_view_settings.update_entity_selection = true
      end
    },
    {
      init = function()
        set_goal({"build-ghost-radar"})
        set_info{text = {"build-ghost-radar-info"}}
        player().insert{name = "radar"}
      end,
      condition = function()
        for k, ghost in pairs (surface().find_entities_filtered{ghost_name = "radar"}) do
          local in_network = false
          for j, network in pairs (surface().find_logistic_networks_by_construction_area(ghost.position, ghost.force)) do
            if network.valid then
              in_network = true
              break
            end
          end
          if in_network then
            ghost.minable = false
            global.backup_ghost_position = {x = ghost.position.x, y = ghost.position.y}
            global.ghost = ghost
            return true
          elseif game.tick % 128 == 0 then
            surface().create_entity
            {
              name = "tutorial-flying-text",
              position = {x = ghost.position.x, y = ghost.position.y - 4},
              text = {"outside-of-construction-range"},
              color = {r = 1, g = 0.2, b = 0.2}
            }
          end
        end
      end
    },
    intermission,
    {
      init = function()
        set_goal(nil, false)
        set_info({text = {"notice-radar-ghost"}})
        set_info({custom_function = add_button, append = true})
        player().clear_items_inside()
        for k, radar in pairs (surface().find_entities_filtered{name = "radar"}) do
          radar.destroy()
        end
        if not global.ghost.valid then -- Well, they destroyed the ghost somehow so we make a new one nearby
          local position = surface().find_non_colliding_position("radar", global.backup_ghost_position, 50, 1)
          if position then
            global.ghost = surface().create_entity{name = "entity-ghost", inner_name = "radar", position = position, force = player().force, expires = false}
            global.ghost.minable = false
          else
            error("Lord help us")
          end
        end
        player().game_view_settings.update_entity_selection = false
        player().selected = global.ghost
        global.radar_tag = tags.create{entity = global.ghost, offset = {0,-3}, text = {"entity-ghost-radar"}}
      end,
      condition = function()
        return global.continue
      end,
      action = function()
        player().game_view_settings.update_entity_selection = true
        global.radar_tag.destroy()
      end
    },
    {
      init = function()
        set_goal({"build-storage-chest"})
        set_info()
        player().insert{name = "logistic-chest-storage"}
      end,
      condition = function()
        for k, chest in pairs (surface().find_entities_filtered{name = "logistic-chest-storage"}) do
          if chest.logistic_network then
            chest.minable = false
            global.chest = chest
            return true
          end
        end
      end
    },
    intermission,
    {
      init = function()
        player().insert{name = "radar"}
        set_goal({"insert-radar"})
      end,
      condition = function()
        return global.chest.get_item_count("radar") > 0
      end,
      action = function()
        for k, roboport in pairs (surface().find_entities_filtered{name = "roboport"}) do
          global.roboport = roboport
          break
        end
        global.roboport.clear_items_inside()
        for k, robot in pairs (surface().find_entities_filtered{name = "construction-robot"}) do
          robot.destroy()
        end
      end
    },
    intermission,
    {
      init = function()
        set_goal(nil, false)
        set_info{text = {"notice-storage-chest"}}
        set_info{custom_function = add_button, append = true}
        player().game_view_settings.update_entity_selection = false
        player().selected = global.chest
      end,
      condition = function()
        return global.continue
      end
    },
    {
      init = function()
        flash_goal()
        global.chest.force = player().force
        if not global.ghost.valid then -- Well, they destroyed the ghost somehow so we make a new one nearby
          local position = surface().find_non_colliding_position("radar", global.backup_ghost_position, 50, 1)
          if position then
            global.ghost = surface().create_entity{name = "entity-ghost", inner_name = "radar", position = position, force = player().force, expires = false}
            global.ghost.minable = false
          else
            error("Lord help us")
          end
        end
        set_info{text = {"notice-working-robot"}}
        set_info{custom_function = add_button, append = true}
        global.roboport.insert{name = "construction-robot"}
        player().game_view_settings.update_entity_selection = true
        if global.chest.get_item_count("radar") == 0 then
          global.chest.insert{name = "radar"}
          global.chest.operable = false
          player().opened = nil
        end
      end,
      update = function()
        if global.robot and global.robot.valid then
          global.robot.energy = global.robot.prototype.max_energy * 0.8
          if global.robot.get_item_count("radar") > 0 and global.robot.force.name ~= "neutral" then
            global.robot.force = "neutral"
            global.robot_tag.text = {"robot-item-in-hand"}
            global.chest.operable = true
          end
        else
          for k, robot in pairs (surface().find_entities_filtered{name = "construction-robot"}) do
            global.robot = robot
            if not (global.robot_tag and global.robot_tag.valid) then
              global.robot_tag = tags.create{entity = robot, offset = {0,-3}, text = {"robot-getting-item"}}
            end
            break
          end
        end
      end,
      condition = function()
        return global.continue and global.robot and global.robot.valid and global.robot.get_item_count("radar") > 0
      end
    },
    {
      init = function()
        flash_goal()
        set_info{text = {"notice-robot-built-entity"}}
        set_info{custom_function = add_button, append = true}
        global.chest.force = "neutral"
        global.robot.force = "player"
        global.robot_tag.text = {"robot-has-item"}
      end,
      update = function()
        global.robot.energy = global.robot.prototype.max_energy * 0.8
        if global.robot.get_item_count("radar") == 0 and global.robot.force.name ~= "neutral" then
          global.robot.force = "neutral"
          global.robot_tag.text = {"entity-built"}
        end
      end,
      condition = function()
        return global.continue and global.robot and global.robot.valid and global.robot.get_item_count("radar") == 0
      end
    },
    {
      init = function()
        flash_goal()
        set_info{text = {"notice-robot-return"}}
        set_info{custom_function = add_button, append = true}
        global.robot.force = "player"
        global.robot_tag.text = {"returning-to-roboport"}
      end,
      update = function()
        global.robot.energy = global.robot.prototype.max_energy * 0.8
      end,
      condition = function()
        return global.continue
      end
    },
    {
      init = function()
        player().game_view_settings.update_entity_selection = true
        for k, radar in pairs (surface().find_entities_filtered{name = "radar"}) do
          radar.destroy()
        end
        for k, radar in pairs (surface().find_entities_filtered{ghost_name = "radar"}) do
          radar.destroy()
        end
        global.chest.force = player().force
        set_goal{"place-ghost-entities-goal", 0, 5}
        set_info{text = {"place-ghost-entities-info"}}
        local player = player()
        player.insert{name = "transport-belt", count = 1}
      end,
      update = function()
        set_goal({"place-ghost-entities-goal", surface().count_entities_filtered{ghost_name = "transport-belt"}, 5}, true)
      end,
      condition = function()
        return surface().count_entities_filtered{ghost_name = "transport-belt"} >= 5
      end,
      action = function()
        for k, ghost in pairs (surface().find_entities_filtered{ghost_name = "transport-belt"}) do
          ghost.minable = false
        end
      end
    },
    intermission,
    {
      init = function()
        set_goal{"insert-belts-goal"}
        player().clear_items_inside()
        player().insert{name = "transport-belt", count = 100}
      end,
      condition = function()
        local surface = surface()
        local chest = surface.find_entities_filtered{name = "logistic-chest-storage"}[1]
        if not chest then return end
        return chest.get_item_count("transport-belt") > 0
      end,
      action = function()
        local chest = surface().find_entities_filtered{name = "logistic-chest-storage"}[1]
        chest.insert{name = "transport-belt", count = 200}
        for k, robot in pairs (surface().find_entities_filtered{name = "construction-robot"}) do
          robot.destroy()
        end
        for k, roboport in pairs (surface().find_entities_filtered{name = "roboport"}) do
          roboport.clear_items_inside()
          roboport.insert{name = "construction-robot", count = 20}
        end
        game.forces.player.worker_robots_speed_modifier = 0.5
      end
    },
    intermission,
    {
      condition = function()
        return surface().count_entities_filtered{name = "transport-belt"} >= 5
      end
    },
    {condition = story_elapsed_check(1)},
    {
      init = function()
        local player = player()
        player.insert{name = "blueprint", count = 6}
        set_goal{"make-blueprint-goal"}
        set_info{text = {"make-blueprint-info"}, picture = "file/create-blueprint.png"}
        set_info{text = {"make-blueprint-info-2"}, append = true}
        set_info{
          custom_function = function(gui)
            gui.add{
              type = "sprite-button",
              sprite = "utility/confirm_slot",
              tooltip = {"confirm-button-tooltip"},
              style = "slot_button"
            }
          end,
          append = true
        }
      end,
      condition = function()
        local player = player()
        local blueprint_item
        local cursor = player.cursor_stack
        if cursor.valid and cursor.valid_for_read then
          if cursor.name == "blueprint" then
            blueprint_item = cursor
          end
        end
        if not blueprint_item then
          for k = 1, 10 do
            local inventory = player.get_inventory(k)
            if inventory then
              local stack = inventory.find_item_stack("blueprint")
              if stack then
                blueprint_item = stack
                break
              end
            end
          end
        end
        if not blueprint_item then return end
        if not blueprint_item.is_blueprint_setup() then return end
        local entities = blueprint_item.get_blueprint_entities()
        for k, entity in pairs (entities) do
          if entity.name == "transport-belt" then
            return true
          end
        end
        return false
      end
    },
    intermission,
    {
      init = function()
        set_goal{"build-blueprint-goal"}
        set_info{text = {"build-blueprint-info"}}
        global.check_for_blueprint = true
      end,
      condition = function()
        return global.built_blueprint
      end,
      action = function()
        local chest = surface().find_entities_filtered{name = "logistic-chest-storage"}[1]
        chest.insert{name = "transport-belt", count = 170}
      end
    },
    intermission,
    {condition = story_elapsed_check(2)},
    {
      init = function()
        set_goal{"deconstruct-entities-goal"}
        set_info{text = {"deconstruct-entities-info"}, picture = "file/deconstruct-entities.png"}
        set_info{text = {"deconstruct-entities-info-2"}, append = true}
        global.check_for_deconstruction = true
        player().insert{name = "deconstruction-planner"}
      end,
      condition = function()
        return global.deconstructed_entity
      end
    },
    intermission,
    {name = "me", condition = story_elapsed_check(3)},
    {
      init = function()
        local entities = {}
        for k, entity in pairs (surface().find_entities()) do
          if entity.name ~= "character" then
            table.insert(entities, entity)
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
        for k = 1, 9 do
          local x = k-5
          entities[k] = {name = "transport-belt", force = "player", position = {x = x, y = -6}, direction = 2, minable = true}
        end
        recreate_entities_on_tick(entities)
      end,
      condition = function()
        return recreate_entities_on_tick()
      end
    },
    {
      init = function()
        set_goal{"cancel-deconstruction-goal"}
        set_info{text = {"cancel-deconstruction-info"}, picture = "file/cancel-deconstruction.png"}
        player().character_mining_speed_modifier = -1
        for k, belt in pairs (surface().find_entities_filtered{name = "transport-belt"}) do
          belt.order_deconstruction(player().force.name)
        end
      end,
      condition = function()
        for k, belt in pairs (surface().find_entities_filtered{name = "transport-belt"}) do
          if belt.to_be_deconstructed(player().force) then
            return false
          end
        end
        return true
      end
    },
    intermission,
    {
      init = function()
        recreate_entities_on_tick(loop_entities)
      end,
      condition = function()
        return recreate_entities_on_tick()
      end,
      action = function()
        for k, entity in pairs (surface().find_entities()) do
          entity.minable = true
        end
      end
    },
    {
      init = function()
        local player = player()
        set_goal()
        flash_goal()
        set_info{text = {"experiment-info"}}
        set_info{
          custom_function = function(gui)
            add_button(gui).caption = {"finish"}
          end,
          append = true
        }
        player.character_mining_speed_modifier = 0
        for name, count in pairs (experiment_items) do
          player.insert{name = name, count = count}
        end
        local chest = player.surface.find_entities_filtered{name = "logistic-chest-storage"}[1]
        if chest then
          for name, count in pairs (experiment_items) do
            chest.insert{name = name, count = count}
          end
        end
        local roboport = player.surface.find_entities_filtered{name = "roboport"}[1]
        if roboport then
          roboport.insert{name = "construction-robot", count = 180}
        end
        for k, entity in pairs (surface().find_entities()) do
          if entity.name ~= "hidden-electric-energy-interface" then
            entity.minable = true
          end
        end
      end,
      condition = function()
        return global.continue
      end
    }
  }
}

script.on_event(defines.events.on_player_deconstructed_area, function(event)
  check_deconstruction(event)
end)

function check_deconstruction(event)
  if not global.check_for_deconstruction then return end
  if not event.area then return end
  if event.alt then return end
  local player = game.players[event.player_index]
  local entities = player.surface.find_entities_filtered{area = event.area}
  for k, entity in pairs (entities) do
    if entity.name == "transport-belt" then
      global.deconstructed_entity = true
      global.check_for_deconstruction = nil
      return
    end
  end
end

function check_blueprint_placement(event)
  if not global.check_for_blueprint then return end
  local player = game.players[event.player_index]
  local cursor = player.cursor_stack
  if not cursor.valid_for_read then return end
  if cursor.name ~= "blueprint" then return end
  local entity = event.created_entity
  if entity.name ~= "entity-ghost" then return end
  global.built_blueprint = true
  global.check_for_blueprint = nil
end

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
  camera.update(global.camera)
end)

script.on_event(defines.events.on_gui_click, function (event)
  story_update(global.story, event)
end)

script.on_event(defines.events.on_built_entity, function (event)
  check_blueprint_placement(event)
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
    index = 1,
    minable = false,
    name = "medium-electric-pole",
    operable = true,
    position =
    {
      x = 3.5,
      y = -4.5
    },
    rotatable = true
  },
  {
    backer_name = "",
    destructible = true,
    force = "player",
    index = 2,
    minable = false,
    name = "roboport",
    operable = false,
    position =
    {
      x = 0,
      y = 7
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 3,
    minable = false,
    name = "logistic-chest-storage",
    operable = true,
    position =
    {
      x = 5,
      y = 1
    },
    rotatable = true
  },
  {
    destructible = true,
    force = "player",
    index = 4,
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
    index = 5,
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
    direction = 0,
    force = "player",
    index = 6,
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
    index = 7,
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
    index = 8,
    inventory = {},
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
    index = 9,
    minable = false,
    name = "hidden-electric-energy-interface",
    operable = false,
    position =
    {
      x = 3.5,
      y = 40.5
    },
    rotatable = true
  }
}

experiment_items =
{
  ["pipe"] = 100,
  ["pipe-to-ground"] = 20,
  ["transport-belt"] = 400,
  ["underground-belt"] = 40,
  ["splitter"] = 40,
  ["inserter"] = 100,
  ["steel-furnace"] = 20,
  ["electric-furnace"] = 8,
  ["assembling-machine-2"] = 20,
  ["fast-inserter"] = 100,
  ["long-handed-inserter"] = 100,
  ["medium-electric-pole"] = 50,
  ["solar-panel"] = 200,
  ["accumulator"] = 150,
  ["substation"] = 10,
  ["stone-wall"] = 100,
  ["laser-turret"] = 20,
  ["roboport"] = 5,
  ["construction-robot"] = 50,
  ["logistic-chest-storage"] = 10
}
