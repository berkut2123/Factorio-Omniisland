local quest_gui = require(mod_name .. ".lualib.quest_gui")

local gui_helpers = {}

local display_slot_dialog = function(message,slot,source)
  if source == nil then source = 'player' end
  game.show_message_dialog({
      text=message,
      point_to={
        type = "item_stack",
        inventory_index = slot,
        item_stack_index = 1,
        source=source
      },
      style="compilatron_gui_message"
  })
end

local display_window_dialog = function(message)
  game.show_message_dialog({
      text=message,
      point_to={
        type = "active_window",
      },
      style = "compilatron_gui_message"
  })
end

local helps = {}

helps.research = function()
  --player.print("You opened the research screen")
  global.player_never_opened.research = 2
end

helps.inventory = function()
  display_window_dialog({'gui-helper.inventory-right'})
  display_slot_dialog({'gui-helper.inventory-left'}, defines.inventory.character_main)
  display_window_dialog({'gui-helper.inventory-hover-recipe-to-view'})
  display_window_dialog({'gui-helper.inventory-click-to-craft'})
  global.player_never_opened.inventory = 2
  quest_gui.add_hint({'quest-hints.info-hover-recipe'})
end

helps.crash_assembler = function()
  display_window_dialog({'gui-helper.assembler-description'})
  display_window_dialog({'gui-helper.assembler-top-slot'})
  display_window_dialog({'gui-helper.assembler-right-slot'})
  --display_window_dialog({'gui-helper.assembler-progress-bar'})
  --display_window_dialog({'gui-helper.assembler-loading'})
  global.player_never_opened.crash_assembler = 2
  quest_gui.add_hint({'quest-hints.info-assembling-machines'})
end

helps.assembling = function()
  display_window_dialog({'gui-helper.assembler-set-recipe'})
  global.player_never_opened.assembling = 2
  quest_gui.add_hint({'quest-hints.info-assembler-set-recipe'})
end

helps.miner = function()
  display_window_dialog({'gui-helper.drill-needs-fuel'})
  --display_window_dialog({'gui-helper.drill-output-arrow'})
  --display_window_dialog({'gui-helper.drill-chest-needed'})
  global.player_never_opened.miner = 2
  quest_gui.add_hint({'quest-hints.info-put-one'})
end

helps.furnace = function()
  display_window_dialog({'gui-helper.furnace-smelts-raw'})
  display_window_dialog({'gui-helper.furnace-ore-slot'})
  display_window_dialog({'gui-helper.furnace-product-slot'})
  display_window_dialog({'gui-helper.furnace-needs-fuel'})
  global.player_never_opened.furnace = 2
  quest_gui.add_hint({'quest-hints.info-take-half'})
end

helps.container = function()
  display_slot_dialog({'gui-helper.container-has-items'},defines.inventory.chest,'target')
  display_slot_dialog({'gui-helper.inventory-left'}, defines.inventory.character_main)
  display_slot_dialog({'gui-helper.container-click-to-collect'},defines.inventory.chest,'target')
  display_slot_dialog({'gui-helper.container-click-to-place'},
                      defines.inventory.character_main,'player')
  display_window_dialog({'gui-helper.container-exit-button'})
  global.player_never_opened.container = 2
end


local on_gui_opened = function (event)
  if global.gui_help_active then
    local unopened = global.player_never_opened
    if event.gui_type == defines.gui_type.research and unopened.research == 0 then
      unopened.research = 1
      global.open_tick = game.ticks_played
    elseif event.gui_type == defines.gui_type.controller and unopened.inventory == 0 then
      if unopened.container > 0 then
        unopened.inventory = 1
        global.open_tick = game.ticks_played
      end
    elseif event.gui_type == defines.gui_type.entity and
           event.entity.name == 'escape-pod-assembler' and
           unopened.crash_assembler == 0 then
      unopened.crash_assembler = 1
      global.open_tick = game.ticks_played
    elseif event.gui_type == defines.gui_type.entity and
           event.entity.name == 'assembling-machine-1' and
           unopened.assembling ==0 then
      unopened.assembling = 1
      global.open_tick = game.ticks_played
    elseif event.gui_type == defines.gui_type.entity and event.entity.name == 'burner-mining-drill' and unopened.miner == 0 then
      unopened.miner = 1
      global.open_tick = game.ticks_played
    elseif event.gui_type == defines.gui_type.entity and event.entity.name == 'stone-furnace' and unopened.furnace == 0 then
      unopened.furnace = 1
      global.open_tick = game.ticks_played
    elseif event.gui_type == defines.gui_type.entity and
           (event.entity.name == 'big-ship-wreck-1' or event.entity.name == 'big-ship-wreck-2') and
           unopened.container == 0 then
      unopened.container = 1
      global.open_tick = game.ticks_played
    end
  end
end

local on_tick = function()
  if global.open_tick < game.ticks_played then
    for guiname,guivalue in pairs(global.player_never_opened) do
      if guivalue == 1 then
        helps[guiname](main_player())
      end
    end
  end
end

gui_helpers.set_opened_state = function(gui_name,state)
  if global.player_never_opened[gui_name] and type(state) == 'number' then
    global.player_never_opened[gui_name] = state
  end
end

gui_helpers.init = function()
  global.player_never_opened = {
    research = 0,
    inventory = 0,
    lab = 0,
    container = 0,
    miner = 0,
    crash_assembler = 0,
    assembling = 0,
    furnace = 0,
  }
  global.gui_help_active = true
  global.open_tick = 0
end

gui_helpers.events =
{
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_tick] = on_tick,
}

return gui_helpers