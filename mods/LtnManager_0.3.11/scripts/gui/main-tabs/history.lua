local history_tab = {}

local gui = require("lib.gui")

local constants = require("constants")
local util = require("scripts.util")

local string = string

gui.add_handlers{
  history = {
    sort_checkbox = {
      on_gui_checked_state_changed = function(e)
        local _,_,clicked_type = string.find(e.element.name, "^ltnm_sort_history_(.-)$")
        local player_table = global.players[e.player_index]
        local gui_data = player_table.gui.main.history
        if gui_data.active_sort ~= clicked_type then
          -- update styles
          gui_data[gui_data.active_sort.."_sort_checkbox"].style = "ltnm_sort_checkbox_inactive"
          e.element.style = "ltnm_sort_checkbox_active"
          -- reset the checkbox value and switch active sort
          e.element.state = not e.element.state
          gui_data.active_sort = clicked_type
        else
          -- update the state in global
          gui_data["sort_"..clicked_type] = e.element.state
        end
        -- update GUI contents
        history_tab.update(game.get_player(e.player_index), player_table, {history = true})
      end
    },
    delete_button = {
      on_gui_click = function(e)
        global.flags.deleted_history = true
        history_tab.update(game.get_player(e.player_index), global.players[e.player_index], {history = true})
      end
    },
    search = {
      name_textfield = {
        on_gui_text_changed = function(e)
          local player_table = global.players[e.player_index]
          local gui_data = player_table.gui.main.history
          gui_data.search.query = e.text
          history_tab.update(game.get_player(e.player_index), player_table, {history = true})
        end
      },
      network_id_textfield = {
        on_gui_text_changed = function(e)
          local player_table = global.players[e.player_index]
          local gui_data = player_table.gui.main.history
          local input = tonumber(e.text) or -1
          gui_data.search.network_id = input
          history_tab.update(game.get_player(e.player_index), player_table, {history = true})
        end
      }
    }
  }
}

function history_tab.update(player, player_table, state_changes, gui_data, data, material_translations)
  gui_data = gui_data or player_table.gui.main
  data = data or global.data
  material_translations = material_translations or player_table.translations.materials
  -- HISTORY
  if state_changes.history then
    local history_gui_data = gui_data.history
    local history_table = history_gui_data.table
    history_table.clear()

    local active_sort = gui_data.history.active_sort
    local sort_value = gui_data.history["sort_"..active_sort]
    local sorted_history = data.sorted_history[active_sort]

    -- skip if the history is empty
    if #sorted_history > 0 and not global.flags.deleted_history then
      history_gui_data.delete_button.enabled = true

      local history = data.history
      local start = sort_value and 1 or #sorted_history
      local finish = sort_value and #sorted_history or 1
      local delta = sort_value and 1 or -1

      local query = string.lower(history_gui_data.search.query)
      for pattern, replacement in pairs(constants.input_sanitisers) do
        query = string.gsub(query, pattern, replacement)
      end
      local network_id_query = history_gui_data.search.network_id

      for i = start,finish,delta do
        local entry = history[sorted_history[i]]

        -- check search criteria
        if
          string.find(string.lower(entry.from.." -> "..entry.to), query)
          and bit32.btest(entry.network_id, network_id_query)
        then
          local table_add = gui.build(history_table, {
            {type = "label", style = "bold_label", style_mods = {width = 140}, caption = entry.depot},
            {
              type = "flow",
              style_mods = {
                horizontally_stretchable = true,
                vertical_spacing = -1,
                top_padding = -2,
                bottom_padding = -1
              },
              direction = "vertical",
              children = {
                {
                  type = "label",
                  name = "ltnm_view_station__"..entry.from_id,
                  style = "ltnm_hoverable_bold_label",
                  caption = entry.from,
                  tooltip = {"ltnm-gui.view-station-on-map"}
                },
                {type = "flow", children = {
                  {type = "label", style = "caption_label", caption = "->"},
                  {
                    type = "label",
                    name = "ltnm_view_station__"..entry.to_id,
                    style = "ltnm_hoverable_bold_label",
                    caption = entry.to,
                    tooltip = {"ltnm-gui.view-station-on-map"}
                  }
                }}
              }
            },
            {
              type = "label",
              style_mods = {right_margin = 8, width = 66, horizontal_align = "right"},
              caption = util.ticks_to_time(entry.runtime)
            },
            {
              type = "label",
              style_mods = {right_margin = 8, width = 64, horizontal_align = "right"},
              caption = util.ticks_to_time(entry.finished)
            },
            {type = "frame", style = "deep_frame_in_shallow_frame", children = {
              {type = "scroll-pane", style = "ltnm_train_slot_table_scroll_pane", children = {
                {type = "table", style = "ltnm_small_slot_table", column_count = 4, save_as = "table"}
              }}
            }}
          }).table.add
          local mi = 0
          for name, count in pairs(entry.actual_shipment or entry.shipment) do
            mi = mi + 1
            table_add{
              type = "sprite-button",
              name = "ltnm_view_material__"..mi,
              style = "ltnm_small_slot_button_default",
              sprite = string.gsub(name, ",", "/"),
              number = count,
              tooltip = (material_translations[name] or name).."\n"..util.comma_value(count)
            }
          end
        end
      end
    else
      history_gui_data.delete_button.enabled = false
    end
  end
end

history_tab.base_template = {
  type = "frame",
  style = "inside_shallow_frame",
  direction = "vertical",
  elem_mods = {visible = false},
  save_as = "tabbed_pane.contents.history",
  children = {
    -- toolbar
    {type = "frame", style = "ltnm_toolbar_frame", children = {
      {
        type = "checkbox",
        name = "ltnm_sort_history_depot",
        style = "ltnm_sort_checkbox_inactive",
        style_mods = {width = 140, left_margin = 8},
        state = true,
        caption = {"ltnm-gui.depot"},
        handlers = "history.sort_checkbox",
        save_as = "history.depot_sort_checkbox"
      },
      {
        type = "checkbox",
        name = "ltnm_sort_history_route",
        style = "ltnm_sort_checkbox_inactive",
        state = true,
        caption = {"ltnm-gui.route"},
        handlers = "history.sort_checkbox",
        save_as = "history.route_sort_checkbox"
      },
      {template = "pushers.horizontal"},
      {
        type = "checkbox",
        name = "ltnm_sort_history_runtime",
        style = "ltnm_sort_checkbox_inactive",
        style_mods = {right_margin = 8},
        state = true,
        caption = {"ltnm-gui.runtime"},
        handlers = "history.sort_checkbox",
        save_as = "history.runtime_sort_checkbox"
      },
      {
        type = "checkbox",
        name = "ltnm_sort_history_finished",
        style = "ltnm_sort_checkbox_active",
        style_mods = {right_margin = 8},
        state = false,
        caption = {"ltnm-gui.finished"},
        handlers = "history.sort_checkbox",
        save_as = "history.finished_sort_checkbox"
      },
      {type = "label", style = "caption_label", style_mods = {width = 124}, caption = {"ltnm-gui.shipment"}},
      {
        type = "sprite-button",
        style = "tool_button_red",
        sprite = "utility/trash",
        tooltip = {"ltnm-gui.clear-history"},
        handlers = "history.delete_button",
        save_as = "history.delete_button"
      }
    }},
    -- listing
    {
      type = "scroll-pane",
      style = "ltnm_blank_scroll_pane",
      style_mods = {horizontally_stretchable = true, vertically_stretchable = true},
      vertical_scroll_policy = "always",
      save_as = "history.pane",
      children = {
        {
          type = "table",
          style = "ltnm_rows_table",
          style_mods = {vertically_stretchable = true},
          column_count = 5,
          save_as = "history.table"
        }
      }
    }
  }
}

history_tab.search_template = {
  {
    type = "textfield",
    lose_focus_on_confirm = true,
    handlers = "history.search.name_textfield",
    save_as = "history.search.name_textfield"
  },
  {type = "label", style = "caption_label", style_mods = {left_margin = 12}, caption = {"ltnm-gui.network-id"}},
  {
    type = "textfield",
    style_mods = {width = 80},
    lose_focus_on_confirm = true,
    numeric = true,
    allow_negative = true,
    handlers = "history.search.network_id_textfield",
    save_as = "history.search.network_id_textfield"
  }
}

function history_tab.set_search_initial_state(player, player_table, gui_data)
  local search_gui_data = gui_data.history.search
  search_gui_data.name_textfield.text = search_gui_data.query
  search_gui_data.network_id_textfield.text = tostring(search_gui_data.network_id)
  search_gui_data.name_textfield.focus()
end

return history_tab