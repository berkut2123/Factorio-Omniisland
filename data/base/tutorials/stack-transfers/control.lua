require "story"

script.on_init(function() 
  global.story = story_init(story_table)
  game.surfaces[1].always_day = true
  game.disable_tips_and_tricks()
  global.items = init_prototypes()
end)

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
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_blueprint_library_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_logistic_gui, false)
  game.permissions.get_group(0).set_allows_action(defines.input_action.open_technology_gui, false)
  player.character_crafting_speed_modifier = -1 --We don't want them crafting things from the items we give them, until the very end.
end

intermission =
{
  init = function()
    --player().opened = nil
    player().clean_cursor()
    flying_congrats(global.last_built_position)
  end,
  condition = story_elapsed_check(2)
}

damage = function()
  local character = player().character
  if not character then return end
  character.damage(1/1000000, "player")
end

init_prototypes = function()
  local item_prototypes = game.item_prototypes
  local items =
  {
    wood = item_prototypes["wood"],
    stone = item_prototypes["stone"],
    coal = item_prototypes["coal"],
    iron = item_prototypes["iron-ore"],
    plate = item_prototypes["iron-plate"]
  }
  for k, name in pairs ({"wood", "stone", "coal", "iron", "plate"}) do
    if not items[name] then
      game.set_game_state{player_won = false, game_finished = true, can_continue = false}
    end
  end
  return items
end

story_table =
{
  {
    {
      condition = story_elapsed_check(1)
    },
    {
      --Ctrl click Item stack
      --Everything of this item type should be transferred to the open chest
      init = function()
        set_goal({"ctrl-click-item-stack"})
        set_info()
        chest().minable = false
        player().insert{name= global.items.wood.name, count = global.items.wood.stack_size * 2}
        player().insert{name= global.items.stone.name, count = global.items.stone.stack_size * 2}
      end,
      update = function()
        if chest().get_item_count(global.items.wood.name) > 0 and player().get_item_count(global.items.wood.name) > 0 or player().get_item_count(global.items.stone.name) ~= global.items.stone.stack_size * 2 then
          --They didn't transfer it all in 1 tick, or moved some coal
          --game.print({"ctrl-click-item-stack"})
          damage()
          local item = {name = global.items.wood.name, count = global.items.wood.stack_size * 2}
          chest().remove_item(item)
          player().remove_item(item)
          player().insert(item)
          item = {name = global.items.stone.name, count = global.items.stone.stack_size * 2}
          chest().remove_item(item)
          player().remove_item(item)
          player().insert(item)
        end
      end,
      condition = function()
        if not player().opened then return end
        return player().opened.name == chest().name and player().opened.get_item_count(global.items.wood.name) > 0
      end,
      action = function()
        global.last_built_position = {x = chest().position.x, y = chest().position.y - 2}
      end
    },
    intermission,
    {
      --Ctrl click empty
      --Everything in the inventroy should be transferred
      init = function()
        set_goal({"ctrl-click-empty-stack"})
        chest().clear_items_inside()
        player().clear_items_inside()
        player().insert{name= global.items.wood.name, count = global.items.wood.stack_size * 2}
        player().insert{name= global.items.stone.name, count = global.items.stone.stack_size * 2}
      end,
      update = function()
        if (chest().get_item_count(global.items.wood.name) > 0 or chest().get_item_count(global.items.stone.name) > 0) and 
          (player().get_item_count(global.items.wood.name) > 0 or player().get_item_count(global.items.stone.name) > 0) then
          --They didn't transfer it all in 1 tick
          --game.print({"ctrl-click-empty-stack"})
          damage()
          local item = {name = global.items.wood.name, count = global.items.wood.stack_size * 2}
          chest().remove_item(item)
          player().remove_item(item)
          player().insert(item)
          item = {name = global.items.stone.name, count = global.items.stone.stack_size * 2}
          chest().remove_item(item)
          player().remove_item(item)
          player().insert(item)
        end
      end,
      condition = function()
        if not player().opened then return end
        return player().opened.name == chest().name and player().opened.get_item_count(global.items.wood.name) > 0 and player().opened.get_item_count(global.items.stone.name) > 0
      end,
      action = function()
        global.last_built_position = {x = chest().position.x, y = chest().position.y - 2}
      end
    },
    intermission,
    {action = function() chest().destroy() end},
    {
      --Ctrl click To entity
      init = function()
        furnace()
        player().clear_items_inside()
        player().insert(global.items.coal.name)
        player().insert(global.items.coal.name)
        set_goal({"ctrl-click-to-entity"})
        set_info({picture = "file/ctrl-click-to-entity.png"})
      end,
      update = function()
        if player().opened and player().opened == furnace() then
          --They opened the furnace, which they shouldn't be doing
          if furnace().get_item_count(global.items.coal.name) > 0 then
            --Oh naughty
            furnace().remove_item(global.items.coal.name)
            player().clean_cursor()
            player().insert(global.items.coal.name)
            --player().print({"ctrl-click-to-entity"})
            damage()
          end
        end
      end,
      condition = function()
        return player().opened == nil and furnace().get_item_count(global.items.coal.name) > 0
      end,
      action = function()
        global.last_built_position = furnace().position
      end
    },
    intermission,
    {
      --Ctrl click To entity
      init = function()
        player().clear_items_inside()
        player().insert(global.items.iron.name)
        player().insert(global.items.iron.name)
        set_goal({"ctrl-click-to-entity-2"})
        set_info()
      end,
      update = function()
        if player().opened and player().opened == furnace() then
          --They opened the furnace, which they shouldn't be doing
          if furnace().get_item_count(global.items.iron.name) > 0 then
            --Oh naughty
            furnace().remove_item(global.items.iron.name)
            player().clean_cursor()
            player().clear_items_inside()
            player().insert(global.items.iron.name)
            --player().print({"ctrl-click-to-entity-2"})
            damage()
          end
        end
      end,
      condition = function()
        return player().opened == nil and furnace().get_item_count(global.items.iron.name) > 0
      end,
      action = function()
        player().game_view_settings.show_entity_info = true
        global.last_built_position = furnace().position
      end
    },
    intermission,
    {
      --Ctrl click from entity
      init = function()
        player().clear_items_inside()
        furnace().get_inventory(defines.inventory.furnace_source).insert({name = global.items.iron.name, count = global.items.iron.stack_size / 2})
        furnace().get_inventory(defines.inventory.furnace_result).insert({name = global.items.plate.name, count = global.items.plate.stack_size / 2})
        set_goal({"ctrl-click-from-entity"})
      end,
      update = function()
        if player().opened and player().opened == furnace() then
          if (furnace().get_item_count(global.items.plate.name) < global.items.plate.stack_size / 2) then
            player().clean_cursor()
            player().remove_item({name = global.items.plate.name, count = global.items.plate.stack_size})
            furnace().get_inventory(defines.inventory.furnace_result).insert({name = global.items.plate.name, count = global.items.plate.stack_size / 2})
            --player().print({"ctrl-click-from-entity"})
            damage()
          end
        end
      end,
      condition = function()
        return furnace().get_item_count(global.items.plate.name) < global.items.plate.stack_size / 2
      end,
      action = function()
        global.last_built_position = furnace().position
      end
    },
    intermission,
    {action = function() furnace().destroy() end},
    {
      --Right click single items
      init = function()
        chest()
        player().clear_items_inside()
        player().insert(global.items.plate.name)
        set_goal({"right-click-single-item"})
      end,
      update = function()
        if chest().get_item_count(global.items.plate.name) > 1 then
          --player().print({"right-click-single-item"})
          damage()
          player().clean_cursor()
          player().clear_items_inside()
          player().insert(global.items.plate.name)
          chest().clear_items_inside()
        end
      end,
      condition = function()
        return chest().get_item_count(global.items.plate.name) == 1
      end,
      action = function()
        global.last_built_position = {x = chest().position.x, y = chest().position.y - 2}
      end
    },
    intermission,
    {
      --Shift click stack to and from
      init = function()
        player().clear_items_inside()
        chest().clear_items_inside()
        player().insert(global.items.plate.name)
        player().insert(global.items.plate.name)
        set_goal({"shift-click-stack"})
      end,
      update = function()
        if player().cursor_stack.valid_for_read then
          player().clean_cursor()
          --player().print({"shift-click-stack"})
          damage()
          return
        end
        local count = chest().get_item_count(global.items.plate.name)
        if count == 0 then return end
        if count > global.items.plate.stack_size then
          --player().print({"shift-click-stack"})
          damage()
          player().clear_items_inside()
          player().insert(global.items.plate.name)
          player().insert(global.items.plate.name)
          chest().clear_items_inside()
        end
      end,
      condition = function()
        return chest().get_item_count(global.items.plate.name) == global.items.plate.stack_size
      end,
      action = function()
        global.last_built_position = {x = chest().position.x, y = chest().position.y - 2}
      end
    },
    intermission,
    {
      init = function()
        player().character_crafting_speed_modifier = 0
        set_goal()
        set_info({text = {"table-info"}})
        set_info({custom_function = build_info_table, append = true, text = {"table-info-2"}})
        set_info({custom_function = function(flow) add_button(flow).caption = {"finish"} end, append = true})
        chest()
        furnace()
        for k, name in pairs ({global.items.stone.name, global.items.wood.name, "steel-chest", "stone-furnace", global.items.stone.name, global.items.iron.name}) do
          player().insert(name)
          player().insert(name)
        end
      end,
      condition = function()
        return global.continue
      end
    }
  }
}

function chest()
  local chest_name = "iron-chest"
  local entities = game.entity_prototypes
  if not entities[chest_name] then
    for name, prototype in pairs (entities) do
      if prototype.type == "container" and prototype.get_inventory_size(1) > 5 then
        chest_name = name
        break
      end
    end
  end
  local entities = surface().find_entities_filtered{name = chest_name}
  if entities and entities[1] then return entities[1] end
  local position = surface().find_non_colliding_position(chest_name, {player().position.x + 3,player().position.y-3}, 32, 2)
  local chest
  if position then
    chest = surface().create_entity{name = chest_name, position = position, force = player().force}
    chest.minable = false
  else
    error("Well whaddya know")
  end
  return chest
end

function furnace()
  local furnace_name = "stone-furnace"
  local entities = game.entity_prototypes
  if not entities[furnace_name] then
    for name, prototype in pairs (entities) do
      if prototype.type == "furnace" then
        furnace_name = name
        break
      end
    end
  end
  local entities = surface().find_entities_filtered{name = furnace_name}
  if entities and entities[1] then return entities[1] end
  local furnace
  local position = surface().find_non_colliding_position(furnace_name, {player().position.x,player().position.y-5}, 32, 2)
  if position then
    furnace = surface().create_entity{name = furnace_name, position = position, force = "player"}
    furnace.minable = false
  else
    error("Well whaddya know")
  end
  return furnace
end

--story_init_helpers(story_table)

script.on_event(defines.events.on_tick, function(event)
  story_update(global.story, event)
end)

script.on_event(defines.events.on_gui_click, function (event)
  story_update(global.story, event)
end)

function build_info_table (gui)
  local table = gui.add{type = "table", column_count = 3}
  table.style.horizontal_spacing = 20
  table.style.vertical_spacing = 5
  for k, name in pairs ({
    "",
    "left-click",
    "right-click",
    "ctrl",
    "transfer-all",
    "transfer-half",
    "shift",
    "transfer-stack",
    "transfer-half-stack",
    "none",
    "pick-drop-stack",
    "pick-half-drop-one"
  }) do
    table.add{type = "label", caption = {name}}
  end
  table.draw_horizontal_line_after_headers = true
  table.draw_vertical_lines = true
end

script.on_load(function()
  global.story.helpers = make_helpers(story_table)
end)

script.on_event(defines.events.on_player_created, on_player_created)
