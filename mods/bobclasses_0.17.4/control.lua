require("mod-gui")


remote.add_interface("bobclasses", {
  add_classes = function(data)
    for name, class in pairs(data) do
      add_class(name, class)
    end
  end,

  add_starting_inventory = function(data)
    for i, item in pairs(data) do
      table.insert(global.starting_inventory, item)
    end
  end,

  add_respawn_inventory = function(data)
    for i, item in pairs(data) do
      table.insert(global.respawn_inventory, item)
    end
  end
}
)


function add_class(name, class)
  if name and class then
    global.classes[name] = class
--[[
    global.classes[name] = {}
    for index, value in pairs(class) do
      global.classes[name][index] = class[index]
    end
]]--
  end
end


function add_classes()
-- example call to add a class. Call on on_init.
  remote.call("bobclasses", "add_classes", {
    builder = {
      entity_name = "bob-character-builder",
      button = {
        name = "bob_class_builder",
        tooltip = {"gui.bob-class-builder"},
        sprite = "class-builder-button"
      },
      bonuses = {
        character_crafting_speed_modifier = 1
      },
      starting_inventory = {
        add = {
          {name="burner-inserter", count=2},
          {name="transport-belt", count=10}
        },
        replace = {
          {remove = {name="iron-plate", count=4}, add = {name="burner-inserter", count = 2}},
          {remove = {name="pistol", count = 1}, add = {name="transport-belt", count=5}},
          {remove = {name="firearm-magazine", count = 10}, add = {name="transport-belt", count=5}},
        }
      },
      respawn_inventory = {
        add = {
        }
      }
    }
  }
  )
-- example call to add items on spawn and respawn. Call on on_init.
  remote.call("bobclasses", "add_starting_inventory", {
      {name="iron-plate", count=8},
      {name="copper-plate", count=8}
  })
  remote.call("bobclasses", "add_respawn_inventory", {
      {name="iron-plate", count=4},
      {name="copper-plate", count=4}
  })
end




--[[-- from base game
script.on_event(defines.events.on_player_created, function(event)
  player.insert{name="iron-plate", count=8}
  player.insert{name="pistol", count=1}
  player.insert{name="firearm-magazine", count=10}
  player.insert{name="burner-mining-drill", count = 1}
  player.insert{name="stone-furnace", count = 1}
end)

script.on_event(defines.events.on_player_respawned, function(event)
  player.insert{name="pistol", count=1}
  player.insert{name="firearm-magazine", count=10}
end)
]]--



function create_button(player_index)
  if mod_gui.get_button_flow(game.players[player_index]).bob_avatar_toggle_gui then
    mod_gui.get_button_flow(game.players[player_index]).bob_avatar_toggle_gui.destroy()
  end
  mod_gui.get_button_flow(game.players[player_index]).add{type = "sprite-button", name = "bob_avatar_toggle_gui", tooltip = {"gui.bob-avatar-show-menu"}, sprite = "entity/character", style = "mod_gui_button"}
end





function init()
  if not global.players then
    global.players = {}
  end
  if not global.classes then
    global.classes = {}
  end
  if not global.starting_inventory then
    global.starting_inventory = {}
  end
  if not global.respawn_inventory then
    global.respawn_inventory = {}
  end

  global.classes["ballanced"] = nil
  global.classes["balanced"] = nil
  global.classes["miner"] = nil
  global.classes["fighter"] = nil
  global.classes["builder"] = nil


  add_class("balanced", {
    entity_name = "character",
    button = {
      name = "bob_class_balanced",
      tooltip = {"gui.bob-class-balanced"},
      sprite = "class-balanced-button"
    },
    bonuses = {},
    starting_inventory = {
      add = {
      },
      replace = {
      }
    },
    respawn_inventory = {
      add = {
      }
    }
  })

  add_class("miner", {
    entity_name = "bob-character-miner",
    button = {
      name = "bob_class_miner",
      tooltip = {"gui.bob-class-miner"},
      sprite = "class-miner-button"
    },
    bonuses = {},
    starting_inventory = {
      add = {
      },
      replace = {
        {remove = {name="stone-furnace", count = 1}, add = {name="burner-mining-drill", count = 1}}
      }
    },
    respawn_inventory = {
      add = {
      }
    }
  })

  add_class("fighter", {
    entity_name = "bob-character-fighter",
    button = {
      name = "bob_class_fighter",
      tooltip = {"gui.bob-class-fighter"},
      sprite = "class-fighter-button"
    },
    bonuses = {},
    starting_inventory = {
      add = {
      },
      replace = {
        {remove = {name="iron-plate", count=4}, add = {name="heavy-armor", count=1}},
        {remove = {name="pistol", count = 1}, add = {name="submachine-gun", count = 1}},
        {remove = {name="burner-mining-drill", count = 1}, add = {name="firearm-magazine", count=45}},
        {remove = {name="stone-furnace", count = 1}, add = {name="firearm-magazine", count=45}}
      }
    },
    respawn_inventory = {
      add = {
      },
      replace = {
        {remove = {name="pistol", count = 1}, add = {name="submachine-gun", count = 1}}
      }
    }
  })

  add_class("builder", {
    entity_name = "bob-character-builder",
    button = {
      name = "bob_class_builder",
      tooltip = {"gui.bob-class-builder"},
      sprite = "class-builder-button"
    },
    prerequisites = {},
    bonuses = {
      character_crafting_speed_modifier = 0.2
    },
    starting_inventory = {
      add = {
      },
      replace = {
        {remove = {name="iron-plate", count = 4}, add = {name="burner-inserter", count = 2}},
        {remove = {name="pistol", count = 1}, add = {name="transport-belt", count = 5}},
        {remove = {name="firearm-magazine", count = 10}, add = {name="transport-belt", count = 5}},
      }
    },
    respawn_inventory = {
      add = {
      }
    }
  })

  for i, player in pairs(game.players) do
    create_button(i)
  end
end


script.on_init(init)
script.on_configuration_changed(init)



script.on_event(defines.events.on_player_created, function(event)
  create_button(event.player_index)

  if not global.players[event.player_index] then
    global.players[event.player_index] = {}
  end

  global.players[event.player_index].respawn = false
  class_select(event.player_index)
end)


script.on_event(defines.events.on_player_respawned, function(event)
--player_index :: uint
--player_port :: LuaEntity (optional): The player port used to respawn if one was used.

  if not global.players[event.player_index] then
    global.players[event.player_index] = {}
  end

  global.players[event.player_index].respawn = true
  class_select(event.player_index)
end)


script.on_event(defines.events.on_built_entity, function(event)
  if event.created_entity.type == "character" then
 --when a player builds a character entity, it gets associated to them.
    game.players[event.player_index].associate_character(event.created_entity)
--    event.created_entity.associated_player = game.players[event.player_index] -- an alternate that should do the same thing as above.
    refresh_avatar_gui(event.player_index)

    for i, class in pairs(global.classes) do
      if event.created_entity.name == class.entity_name then
        for i, bonus in pairs(class.bonuses) do
          event.created_entity[i] = bonus
        end
      end
    end

  end
-- due to how I want this to work, character entities can't have ghosts.
  if event.created_entity.type == "entity-ghost" and event.created_entity.ghost_type == "character" then
    event.created_entity.destroy()
  end
end)



-- Calls when a player dies. we're going to use it to force you to switch to a backup body on death instead of respawning.
script.on_event(defines.events.on_pre_player_died, function(event)
  next_character(event.player_index)
end)


--script.on_event(defines.events.on_player_died, function(event)
--player_index :: uint
--cause :: LuaEntity (optional)
--end)


-- Called when an entity dies. we're going to refresh the GUI if it was one of our entities that died.
script.on_event(defines.events.on_entity_died, function(event)
  if event.entity.type == "character" then
    local player = event.entity.associated_player
    if player then
      player.disassociate_character(event.entity)
--      event.entity.associated_player = nil --alternate method
      refresh_avatar_gui(player.index)
    end
  end
end)




script.on_event(defines.events.on_gui_click, function(event)
  local player = game.players[event.player_index]
  if event.element.valid and event.element.name == "bob_avatar_toggle_gui" then
    toggle_avatar_gui(event.element.player_index)
  end

  if event.element.valid and string.find(event.element.name, "bob_avatar_list_character_") then
    local characters = game.players[event.player_index].get_associated_characters()
    local i = tonumber(string.match(event.element.name, "%d+"))
    local character = characters[i]
    if character then
      switch_character(event.player_index, character)
    end
  end

  if event.element.valid and event.element.name == "bob_avatar_god" then
    switch_to_god(event.player_index)
  end

  for i, class in pairs(global.classes) do
    if event.element.valid and event.element.name == class.button.name then
      create_character(event.player_index, class)
      player.gui.center.bob_class_gui.destroy()
    end
  end
end)




script.on_event(defines.events.on_player_toggled_map_editor, function(event)
  local player = game.players[event.player_index]
  if player.gui.center.bob_class_gui then
    player.gui.center.bob_class_gui.destroy()
  end
end)




function class_select(player_index)
  local player = game.players[player_index]
  if player.controller_type == defines.controllers.character and player.character and player.character.valid then
    draw_class_gui(player_index)
  end
end


function draw_class_gui(player_index)
  local player = game.players[player_index]
  if not player.gui.center.bob_class_gui then
    local gui = player.gui.center.add{type = "frame", name = "bob_class_gui", caption = {"gui.bob-class-pick"}, direction = "vertical"}
    gui.add({type = "table", name = "table", column_count = 5})
    for i, class in pairs(global.classes) do
      local add_it = true
      if class.prerequisites then
        for i, technology in pairs(class.prerequisites) do
          if player.force.technologies[technology] and player.force.technologies[technology].researched == false then
            add_it = false
          end
        end
      end
      if add_it then
        gui.table.add{type = "sprite-button", name = class.button.name, tooltip = class.button.tooltip, sprite = class.button.sprite, style = "mod_gui_button"}
      end
    end
  end
end


function toggle_avatar_gui(player_index)
  local player = game.players[player_index]
  if not player.gui.left.bob_avatar_gui then
    draw_avatar_gui(player_index)
  else
    player.gui.left.bob_avatar_gui.destroy()
  end
end


function draw_avatar_gui(player_index)
  local player = game.players[player_index]
  if player.gui.left.bob_avatar_gui then
    player.gui.left.bob_avatar_gui.destroy()
  end
  local gui = player.gui.left.add{type = "frame", name = "bob_avatar_gui", caption = "Avatar switcher GUI", direction = "vertical"}

  gui.add{type = "scroll-pane", style = "scroll_pane", name = "bob_avatar_list", vertical_scroll_policy = "auto", horizontal_scroll_policy = "never"}
  gui.bob_avatar_list.style.minimal_height = 0
  gui.bob_avatar_list.style.maximal_height = 250
  draw_characters_list(gui.bob_avatar_list, player_index)
--  gui.add({type = "button", name = "bob_avatar_god", caption = {"gui.god_mode"}})
end


function draw_characters_list(gui, player_index)
  local characters = game.players[player_index].get_associated_characters()
  gui.add{type = "table", column_count = 5, name = "table", style = "slot_table", draw_horizontal_lines = true, draw_vertical_lines = false}
  for i, entity in pairs(characters) do
    gui.table.add({type = "label", name = "bob_avatar_list_number_" .. i, caption = string.format("#%d ", i)})
    gui.table.add{type = "sprite-button", name = "bob_avatar_list_character_" .. i, sprite = "entity/" .. entity.name, style = "mod_gui_button"}
    gui.table.add({type = "label", name = "bob_avatar_list_name_" .. i, caption = {"entity-name." .. entity.name}})
    gui.table.add({type = "label", name = "bob_avatar_list_position_x_" .. i, caption =  " Pos: " .. entity.position.x .. ", "})
    gui.table.add({type = "label", name = "bob_avatar_list_position_y_" .. i, caption =  entity.position.y})
  end
end


function refresh_avatar_gui(player_index)
  local player = game.players[player_index]
  if player.gui.left.bob_avatar_gui and player.gui.left.bob_avatar_gui.bob_avatar_list then
    if player.gui.left.bob_avatar_gui.bob_avatar_list.table then
      player.gui.left.bob_avatar_gui.bob_avatar_list.table.destroy()
    end
    draw_characters_list(player.gui.left.bob_avatar_gui.bob_avatar_list, player_index)
  end
end




function create_character(player_index, class)
  local player = game.players[player_index]

  if player.controller_type == defines.controllers.character and player.character ~= nil and player.character.valid then
    local position = player.character.position
    local surface = player.surface
    local force = player.force

    if player.character ~= nil and player.character.name ~= class.entity_name then
      player.character = surface.create_entity{name = class.entity_name, position = position, force = force, fast_replace = true}
    end

    if class and player.character then
      for i, bonus in pairs(class.bonuses) do
        player.character[i] = bonus
      end
      if global.players[player_index].respawn then

        for i, item in pairs(global.respawn_inventory) do
          player.insert(item)
        end

        if class.respawn_inventory.replace then
          for i, item in pairs(class.respawn_inventory.add) do
            player.insert(item)
          end
          for i, item in pairs(class.respawn_inventory.replace) do
            if item.remove and item.add and player.get_item_count(item.remove.name) >= item.remove.count then
              player.remove_item(item.remove)
              player.insert(item.add)
            end
          end
        end

      else

        for i, item in pairs(global.starting_inventory) do
          player.insert(item)
        end

        if class.starting_inventory then
          for i, item in pairs(class.starting_inventory.add) do
            player.insert(item)
          end
          for i, item in pairs(class.starting_inventory.replace) do
            if item.remove and item.add and player.get_item_count(item.remove.name) >= item.remove.count then
              player.remove_item(item.remove)
              player.insert(item.add)
            end
          end
        end

      end

    end
  end
end


--Switches to the first character in the association list.
function next_character(player_index)
  local characters = game.players[player_index].get_associated_characters()
  if characters[1] then
    switch_character(player_index, characters[1])
  end
end

--Switches to the new character, then adds the old one to the (end of the) association list.
function switch_character(player_index, new_character)
  local old_character = game.players[player_index].character
  if new_character.surface ~= game.players[player_index].surface then --are we looking at the same surface as the new character?
    game.players[player_index].character = nil --we're not, disconnect the player
    game.players[player_index].teleport(new_character.position, new_character.surface) --look at the new surface
  end
  game.players[player_index].character = new_character
  if old_character then
    game.players[player_index].associate_character(old_character)
  end
  refresh_avatar_gui(player_index)
end

--Switches to the god controller, then adds the connected character to the (end of the) association list.
function switch_to_god(player_index)
  local old_character = game.players[player_index].character
  game.players[player_index].set_controller{type = defines.controllers.god}
  if old_character then
    game.players[player_index].associate_character(old_character)
  end
  refresh_avatar_gui(player_index)
end
