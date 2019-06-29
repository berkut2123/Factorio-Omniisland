local tree_view = require(mod_name .. ".lualib.tree_view")
local util = require('util')

local quest_gui = {}
local quest_gui_data =
{
  current_quest_name = nil,
  current_quest_gui_data = nil,
  hints = {},
  previous_hints = {}
}

quest_gui.init = function()
  global.quest_controller_data = quest_gui_data
end

quest_gui.on_load = function()
  quest_gui_data = global.quest_controller_data or quest_gui_data
end

-- TODO: index these by name, not by index
local states =
{
  {
    name = 'default',
    icon = '[img=quest_gui_empty_status]',
    color = '1,1,1',
    desc = 'uncomplete'
  },
  {
    name = 'progress',
    icon = '[img=quest_gui_empty_status]',
    color = '1,0.8,0',
    desc = 'progressing'
  },
  {
    name = 'success',
    icon = '[img=virtual-signal/signal-check]',
    color = '0.82353,0.99216,0.56863',
    desc = 'complete'
  },
  {
    name = 'fail',
    icon = '[img=virtual-signal/signal-red]',
    color = '1,0,0',
    desc = 'failed'
  },
  {
    name = 'info',
    icon = '[img=virtual-signal/signal-info]',
    color = '0.50196,0.80784,0.94118',
    desc = 'info'
  },
  {
    name = 'note',
    icon = '',
    color = '1,1,1',
  }
}

local get_quest_gui_wrapper = function(player, create_if_not_found)
  if not player.gui.left.objective_flow then
    if create_if_not_found then
      player.gui.left.add
      {
        type = 'flow',
        column_count = 1,
        direction = 'vertical',
        name = 'objective_flow',
        style = 'quest_vertical_flow'
      }
    else
      return nil
    end
  end

  return player.gui.left.objective_flow
end

local get_quest_gui_section = function(player, name, heading_1, heading_2, create_if_not_found)
  local objective_flow = get_quest_gui_wrapper(player, create_if_not_found)

  if create_if_not_found then
    assert(heading_1)
  end

  if not objective_flow[name] then
    if create_if_not_found then
      local quest_gui_frame = objective_flow.add
      {
        type = 'frame',
        name = name,
        direction = 'vertical',
        style='quest_gui_frame',
        caption = heading_1,
      }
      if heading_2 then
        quest_gui_frame.add
        {
          type = 'label',
          name = 'title-heading',
          style = 'quest_item_subheading',
          caption = heading_2,
        }
      end
    else
      return nil
    end
  end

  return objective_flow[name]
end

local get_hints_gui = function(player)
  local objective_frame = get_quest_gui_section(player, 'hints', {'quest-hints.heading'}, nil,true)

  if not objective_frame.hints_list then
    objective_frame.add
    {
      type = 'table',
      name = 'hints_list',
      style = 'quest_item_table',
      column_count = 1
    }
  end

  return objective_frame.hints_list
end

local get_all_hints_gui = function(player, create_if_not_found)
  if create_if_not_found == nil then
    create_if_not_found = true
  end

  local hints_frame = get_quest_gui_section(player, 'all_hints', { 'quest-hints.heading-all'}, nil, create_if_not_found)
  if not hints_frame then
    return nil
  end

  if not hints_frame.scroll_pane then
    hints_frame.add
    {
      type = 'scroll-pane',
      name = 'scroll_pane',
    }

    hints_frame.scroll_pane.style.maximal_height = 150
  end

  return hints_frame.scroll_pane
end

local get_quest_frame = function(player, heading, create_if_not_found)
  return get_quest_gui_section(player, 'quest', {"gui-goal-description.title"}, heading, create_if_not_found)
end

local add_description = function(parent, state, text)
  local style_mod = states[state].desc

  parent.add
  {
    type = 'flow',
    direction='horizontal',
    name = 'desc_flow',
    style= 'quest_item_description_wrapper'
  }
  .add
  {
    type = 'label',
    style = 'quest_item_description_' .. style_mod,
    caption = text,
    name = "inner"
  }
end

local add_icons = function(parent,icons)
  local icon_text = ""
  for _, icon in pairs(icons) do
    icon_text = icon_text..'[img='..icon..']'
  end

  parent.add
  {
    type = 'flow',
    direction='horizontal',
    style= 'quest_item_icons_wrapper'
  }
  .add
  {
    type = 'label',
    caption = icon_text,
    name = "inner",
    style = 'quest_item_icons_label'
  }
end

local add_count = function(parent, state, max)
  local style_mod = states[state].desc

  parent.add
  {
    type = 'flow',
    direction='horizontal',
    name = 'count_flow',
    style= 'quest_item_count_wrapper'
  }
  .add
  {
    type = 'label',
    style = 'quest_item_description_'..style_mod,
    caption = "0/" .. max,
    name = "inner"
  }
end

local add_state = function(parent, state)
  parent.add
  {
    type = 'flow',
    direction = 'horizontal',
    name = "state_flow",
    style= 'quest_item_state_icon_wrapper'
  }
  .add
  {
    type = 'label',
    caption = states[state].icon,
    name = "inner",
    style = 'quest_item_state_icon_label'
  }
end

local set_player_quest_gui = function(player, quest_name, tree_view_rows)
  local quest_frame = get_quest_frame(player, { 'quest-'..quest_name..'.heading'}, true)
  local tree_view_data = tree_view.add_tree_view_to_frame(quest_frame, tree_view_rows, 'quest_main_table')
  tree_view_data.table.style = 'quest_item_table'

  for _, row in pairs(tree_view_data.rows) do
    local state = 1
    local item_data = row.original_data_row
    local text = {'quest-' .. quest_name .. '.' .. item_data.item_name}

    add_description(row.row_flow, state, text)

    local push_remaining_to_right = row.row_flow.add{ type = "flow", direction = "horizontal", name = "push_remaining_to_right"}
    push_remaining_to_right.style.horizontally_stretchable = true
    push_remaining_to_right.style.vertically_stretchable = true

    if item_data.goal then
      add_count(row.row_flow, state, item_data.goal or 0)
    end

    if item_data.icons then
      add_icons(row.row_flow, item_data.icons)
    end

    add_state(row.row_flow, state)
  end
end

local do_add_hint = function(hints_list, item_text)
  local hint_row = hints_list.add
  {
    type = 'flow',
    direction='horizontal',
    style= 'quest_hint_row'
  }

  -- Add info icon to the row in a wrapper flow
  hint_row.add
  {
    type = 'flow',
    direction='horizontal',
    style = 'quest_hint_wrapper'
  }
  .add
  {
    type = 'label',
    caption = '[img=virtual-signal/signal-info]',
    style = 'quest_hint_icon_label'
  }

  -- Add the text line to the row in a wrapper flow
  hint_row.add
  {
    type = 'flow',
    direction='horizontal',
    style = 'quest_hint_description_wrapper'
  }
  .add
  {
    type = 'label',
    caption = item_text,
    style = 'quest_hint_description',
  }
end

local rebuild_player_gui = function(player, all_hints_visible)
  local objective_flow = player.gui.left.objective_flow
  if objective_flow then
    objective_flow.destroy()
  end

  local data = quest_gui_data.current_quest_gui_data
  if data then
    set_player_quest_gui(player, data.quest_name, data.tree_view_rows)
  end

  if #quest_gui_data.hints > 0 then
    local hints_list = get_hints_gui(player)
    for _, item in pairs(quest_gui_data.hints) do
      do_add_hint(hints_list, item)
    end
  end

  if #quest_gui_data.previous_hints > 0 then
    player.gui.left.objective_flow.add
    {
      name = 'expand_hints_button',
      type = 'button',
      direction = 'vertical',
      style='quest_gui_more_button',
      caption = {"quest-hints.expand-hints"},
    }

    local all_hints_list = get_all_hints_gui(player)
    for _, item in pairs(quest_gui_data.previous_hints) do
      do_add_hint(all_hints_list, item)
    end

    if not all_hints_visible then
      player.gui.left.objective_flow.all_hints.visible = false
    end
  end
end

-- If there is a quest in progress, insert the correct gui into the new player
local on_player_joined_game = function(event)
  if not quest_gui_data.current_quest_gui_data then
    return
  end

  local player = game.players[event.player_index]
  rebuild_player_gui(player)
end

quest_gui.set = function(quest_name, tree_view_rows)
  quest_gui.unset()

  quest_gui_data.current_quest_gui_data =
  {
    quest_name = quest_name,
    tree_view_rows = tree_view_rows,
    flat_rows = tree_view.flatten_rows(tree_view_rows)
  }

  for _, player in pairs(game.forces.player.players) do
    rebuild_player_gui(player)
  end
end

quest_gui.add_hint = function(hint)
  for _, previous_hint in pairs(quest_gui_data.hints) do
    if util.table.compare(previous_hint, hint) then
      return
    end
  end

  table.insert(quest_gui_data.hints, hint)

  for _, player in pairs(game.forces.player.players) do
    rebuild_player_gui(player)
  end
end

quest_gui.visible = function(state)
  for _, player in pairs(game.forces.player.players) do
    local objective_flow = player.gui.left.objective_flow
    if objective_flow then
      objective_flow.visible = state
    end
  end
end

quest_gui.unset = function()
  for _, player in pairs(game.forces.player.players) do
    local objective_flow = player.gui.left.objective_flow
    if objective_flow then
      objective_flow.destroy()
    end
  end

  quest_gui_data.current_quest_gui_data = nil

  for _, hint in pairs(quest_gui_data.hints) do

    local already_exists = false
    for _, previous_hint in pairs(quest_gui_data.previous_hints) do
      if util.table.compare(previous_hint, hint) then
        already_exists = true
        break
      end
    end

    if not already_exists then
      table.insert(quest_gui_data.previous_hints, hint)
    end
  end

  quest_gui_data.hints = {}

end

local get_item_gui = function(player, item_name)
  local player_quest_gui = get_quest_frame(player, nil, false)
  if not player_quest_gui then
    return
  end
  player_quest_gui = player_quest_gui.quest_main_table

  local quest_data = quest_gui_data.current_quest_gui_data
  if quest_data.quest_name == quest_gui_data.current_quest_gui_data.quest_name then
    for index, item in pairs(quest_data.flat_rows) do
      if item.item_name == item_name then
        return player_quest_gui.children[index]
      end
    end
  end

  error("Cannot find quest item " .. item_name)
end

quest_gui.update_count = function(item_name, count, goal)
  for _, player in pairs(game.forces.player.players) do
    local item_gui = get_item_gui(player, item_name)

    if item_gui then
      local state = 1
      if count >= goal then
        count = goal
        state = 3
      elseif count > 0 then
        state = 2
      end

      local desc_style = 'quest_item_description_'..states[state].desc
      local state_caption = states[state].icon
      item_gui.count_flow.inner.caption = count.."/"..goal
      item_gui.count_flow.inner.style = desc_style
      item_gui.desc_flow.inner.style = desc_style
      item_gui.state_flow.inner.caption = state_caption
    end
  end
end

quest_gui.update_state = function(item_name, state)
  for _, player in pairs(game.forces.player.players) do
    local item_gui = get_item_gui(player, item_name)

    if item_gui then
      local desc_style = 'quest_item_description_' .. states[state].desc
      local state_caption = states[state].icon

      item_gui.desc_flow.inner.style = desc_style
      item_gui.state_flow.inner.caption = state_caption
    end
  end
end

local on_gui_click = function(event)
  if event.element.name and event.element.name == "expand_hints_button" then
    local player = game.players[event.player_index]
    local currently_showing_all_hints = player.gui.left.objective_flow.all_hints.visible

    rebuild_player_gui(player, not currently_showing_all_hints)
  end
end

quest_gui.migrate = function()
  if global.CAMPAIGNS_VERSION < 4 and global.quest_controller_data then
    global.quest_controller_data.previous_hints = {}
  end
end

quest_gui.events =
{
  [defines.events.on_player_joined_game] = on_player_joined_game,
  [defines.events.on_gui_click] = on_gui_click,
}

return quest_gui