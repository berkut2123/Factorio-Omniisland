local main_gui = {}

local gui = require("lib.gui")

local constants = require("constants")
local player_data = require("scripts.player-data")

local tabs = {}
local tab_names = {"depots", "stations", "inventory", "history", "alerts"}
for _, name in ipairs(tab_names) do
  tabs[name] = require("scripts.gui.main-tabs."..name)
end

local string_gsub = string.gsub

gui.add_templates{
  pushers = {
    horizontal = {type = "empty-widget", style_mods = {horizontally_stretchable = true}},
    vertical = {type = "empty-widget", style_mods = {vertically_stretchable = true}},
    both = {type = "empty-widget", style_mods = {horizontally_stretchable = true, vertically_stretchable = true}}
  },
  frame_action_button = {type = "sprite-button", style = "frame_action_button", mouse_button_filter = {"left"}},
  mock_frame_tab = (
    {
      type = "button",
      style = "ltnm_mock_frame_tab",
      mouse_button_filter = {"left"},
      handlers = "main.titlebar.frame_tab"
    }
  ),
  status_indicator = function(name, color, value)
    local actual_color = string.gsub(color, "signal%-", "")
    return {type = "flow", style = "flib_indicator_flow", children = {
      {type = "sprite", style = "flib_indicator", sprite = "flib_indicator_"..actual_color, save_as = name.."_circle"},
      {type = "label", style = "ltnm_depot_button_label", caption = value, save_as = name.."_label"}
    }}
  end,
  search_contents = function(name)
    return (
      {
        type = "flow",
        name = name.."_contents",
        style = "ltnm_search_content_flow",
        elem_mods = {visible = false},
        children = tabs[name].search_template
      }
    )
  end
}

gui.add_handlers{
  main = {
    window = {
      on_gui_closed = function(e)
        local player_table = global.players[e.player_index]
        if not player_table.settings.keep_gui_open and not player_table.flags.toggling_search then
          main_gui.close(game.get_player(e.player_index), player_table)
        end
      end
    },
    titlebar = {
      frame_tab = {
        on_gui_click = function(e)
          local name = e.default_tab or string_gsub(e.element.caption[1], "ltnm%-gui%.", "")
          main_gui.update_active_tab(game.get_player(e.player_index), global.players[e.player_index], name)
        end
      },
      search_button = {
        on_gui_click = function(e)
          main_gui.toggle_search(game.get_player(e.player_index), global.players[e.player_index])
        end
      },
      pin_button = {
        on_gui_click = function(e)
          local player = game.get_player(e.player_index)
          local player_table = global.players[e.player_index]
          local window_data = player_table.gui.main.window
          if player_table.settings.keep_gui_open then
            e.element.style = "frame_action_button"
            e.element.sprite = "ltnm_pin_white"
            player_table.settings.keep_gui_open = false
            window_data.frame.force_auto_center()
            if player_table.flags.search_open then
              local gui_data = player_table.gui.main
              player.opened = gui_data.search.window
            else
              player.opened = window_data.frame
            end
          else
            e.element.style = "flib_selected_frame_action_button"
            e.element.sprite = "ltnm_pin_black"
            player_table.settings.keep_gui_open = true
            window_data.frame.auto_center = false
            player.opened = nil
          end
        end
      },
      refresh_button = {
        on_gui_click = function(e)
          if e.shift then
            local settings = global.players[e.player_index].settings
            if settings.auto_refresh then
              player_data.set_setting(e.player_index, "auto-refresh", false)
              e.element.style = "frame_action_button"
              e.element.sprite = "ltnm_refresh_white"
            else
              player_data.set_setting(e.player_index, "auto-refresh", true)
              e.element.style = "flib_selected_frame_action_button"
              e.element.sprite = "ltnm_refresh_black"
            end
          else
            main_gui.update_active_tab(game.get_player(e.player_index), global.players[e.player_index])
          end
        end
      },
      close_button = {
        on_gui_click = function(e)
          main_gui.close(game.get_player(e.player_index), global.players[e.player_index])
        end
      },
    },
    open_train_button = {
      on_gui_click = function(e)
        local train_id = string_gsub(e.element.name, "ltnm_open_train__", "")
        train_id = tonumber(train_id)
        local train = global.data.trains[train_id]
        if train then
          game.get_player(e.player_index).opened = train.main_locomotive
        else
          game.get_player(e.player_index).print{"ltnm-message.train-invalid-refresh-gui"}
        end
      end
    },
    view_station_button = {
      on_gui_click = function(e)
        local station_id = string_gsub(e.element.name, "ltnm_view_station__", "")
        local player = game.get_player(e.player_index)
        local player_table = global.players[e.player_index]

        -- check station validity
        local station_data = global.data.stations[tonumber(station_id)]
        if station_data and station_data.entity.valid then
          if e.shift then
            -- open LTN combinator
            if remote.interfaces["ltn-combinator"] then
              if not remote.call(
                "ltn-combinator",
                "open_ltn_combinator",
                e.player_index,
                station_data.lamp_control,
                true
              ) then
                player.print{"ltnm-message.ltn-combinator-not-found"}
              end
            else
              player.print{"ltnm-message.ltn-combinator-not-enabled"}
            end
          else
            local entity = station_data.entity
            -- view station on map
            player.zoom_to_world(entity.position, 0.5)
            rendering.draw_circle{
              color = constants.station_indicator_color,
              radius = 1.5,
              width = 6,
              filled = false,
              target = entity,
              surface = entity.surface,
              time_to_live = 180,
              players = {e.player_index}
            }
            if not player_table.gui.main.window.pinned then
              main_gui.close(player, player_table)
            end
          end
        else
          player.print{"ltnm-message.station-invalid"}
        end
      end
    },
    material_button = {
      on_gui_click = function(e)
        local player_table = global.players[e.player_index]
        local on_inventory_tab = player_table.gui.main.tabbed_pane.selected == "inventory"
        main_gui.update(game.get_player(e.player_index), player_table, {
          active_tab = (not on_inventory_tab) and "inventory",
          inventory = string_gsub(e.element.sprite, "/", ",")}
        )
      end
    }
  },
  search = {
    window = {
      on_gui_closed = function(e)
        local player = game.get_player(e.player_index)
        local player_table = global.players[e.player_index]
        if not player_table.flags.toggling_search and not player_table.settings.keep_gui_open then
          main_gui.close_search(player, player_table, player_table.gui.main)
        end
      end
    }
  }
}

function main_gui.create(player, player_table)
  -- create base GUI structure
  local gui_data = gui.build(player.gui.screen, {
    {
      type = "frame",
      style = "invisible_frame",
      direction = "vertical",
      handlers = "main.window",
      save_as = "window.frame",
      children = {
        {type = "flow", children = {
          {template = "pushers.horizontal"},
          {
            type = "frame",
            style = "ltnm_search_frame",
            elem_mods = {visible = false},
            handlers = "search.window",
            save_as = "search.window",
            children = {
              gui.templates.search_contents("stations"),
              gui.templates.search_contents("inventory"),
              gui.templates.search_contents("history")
            }
          },
        }},
        {type = "flow", style_mods = {horizontal_spacing = 0, padding = 0}, direction = "horizontal", children = {
          {type = "frame", style = "ltnm_titlebar_tab_filler_frame", children = {
            {template = "mock_frame_tab", caption = {"ltnm-gui.depots"}, save_as = "tabbed_pane.tabs.depots"},
            {template = "mock_frame_tab", caption = {"ltnm-gui.stations"}, save_as = "tabbed_pane.tabs.stations"},
            {template = "mock_frame_tab", caption = {"ltnm-gui.inventory"}, save_as = "tabbed_pane.tabs.inventory"},
            {template = "mock_frame_tab", caption = {"ltnm-gui.history"}, save_as = "tabbed_pane.tabs.history"},
            {template = "mock_frame_tab", caption = {"ltnm-gui.alerts"}, save_as = "tabbed_pane.tabs.alerts"},
          }},
          {type = "frame", style = "ltnm_titlebar_right_frame", save_as = "titlebar.frame", children = {
            {
              type = "empty-widget",
              style = "ltnm_titlebar_drag_handle",
              ignored_by_interaction = true
            },
            {
              template = "frame_action_button",
              sprite = "utility/search_white",
              hovered_sprite = "utility/search_black",
              clicked_sprite = "utility/search_black",
              tooltip = {"ltnm-gui.search-tooltip"},
              handlers = "main.titlebar.search_button",
              save_as = "titlebar.search_button"
            },
            {
              template = "frame_action_button",
              sprite = "ltnm_pin_white",
              hovered_sprite = "ltnm_pin_black",
              clicked_sprite = "ltnm_pin_black",
              tooltip = {"ltnm-gui.keep-open"},
              handlers = "main.titlebar.pin_button",
              save_as = "titlebar.pin_button"
            },
            {
              template = "frame_action_button",
              sprite = "ltnm_refresh_white",
              hovered_sprite = "ltnm_refresh_black",
              clicked_sprite = "ltnm_refresh_black",
              tooltip = {"ltnm-gui.refresh-button-tooltip"},
              handlers = "main.titlebar.refresh_button",
              save_as = "titlebar.refresh_button"
            },
            {
              template = "frame_action_button",
              sprite = "utility/close_white",
              hovered_sprite = "utility/close_black",
              clicked_sprite = "utility/close_black",
              handlers = "main.titlebar.close_button",
              save_as = "titlebar.close_button"
            }
          }}
        }},
        {type = "frame", style = "ltnm_main_content_frame", children = {
          tabs.depots.base_template,
          tabs.stations.base_template,
          tabs.inventory.base_template,
          tabs.history.base_template,
          tabs.alerts.base_template
        }}
      }
    }
  })

  -- other handlers
  gui.update_filters("main.open_train_button", player.index, {"ltnm_open_train"}, "add")
  gui.update_filters("main.view_station_button", player.index, {"ltnm_view_station"}, "add")
  gui.update_filters("main.material_button", player.index, {"ltnm_view_material"}, "add")
  gui.update_filters("alerts.clear_alert_button", player.index, {"ltnm_clear_alert"}, "add")

  -- default settings
  gui_data.window.pinned = false

  gui_data.tabbed_pane.selected = "depots"

  gui_data.depots.active_sort = "composition"
  gui_data.depots.sort_composition = true
  gui_data.depots.sort_status = true

  gui_data.stations.active_sort = "name"
  gui_data.stations.sort_name = true
  gui_data.stations.sort_status = true
  gui_data.stations.search.query = ""
  gui_data.stations.search.network_id = -1

  gui_data.inventory.search.query = ""
  gui_data.inventory.search.network_id = -1

  gui_data.history.active_sort = "finished"
  gui_data.history.sort_depot = true
  gui_data.history.sort_route = true
  gui_data.history.sort_runtime = true
  gui_data.history.sort_finished = false
  gui_data.history.search.query = ""
  gui_data.history.search.network_id = -1

  gui_data.alerts.active_sort = "time"
  gui_data.alerts.sort_time = false
  gui_data.alerts.sort_route = true
  gui_data.alerts.sort_type = true
  gui_data.alerts.clear_all = false

  -- auto-refresh
  if player_table.settings.auto_refresh then
    gui_data.titlebar.refresh_button.style = "flib_selected_frame_action_button"
    gui_data.titlebar.refresh_button.sprite = "ltnm_refresh_black"
  else
    gui_data.titlebar.refresh_button.style = "frame_action_button"
    gui_data.titlebar.refresh_button.sprite = "ltnm_refresh_white"
  end

  -- pinned
  if player_table.settings.keep_gui_open then
    gui_data.titlebar.pin_button.style = "flib_selected_frame_action_button"
    gui_data.titlebar.pin_button.sprite = "ltnm_pin_black"
  else
    gui_data.titlebar.pin_button.style = "frame_action_button"
    gui_data.titlebar.pin_button.sprite = "ltnm_pin_white"
    -- center window
    gui_data.window.frame.force_auto_center()
  end

  gui_data.titlebar.frame.drag_target = gui_data.window.frame
  gui_data.window.frame.visible = false

  player_table.gui.main = gui_data

  main_gui.update(player, player_table, {active_tab = "depots"})
end

function main_gui.destroy(player, player_table)
  gui.update_filters("main", player.index, nil, "remove")
  gui.update_filters("search", player.index, nil, "remove")
  for _, name in ipairs(tab_names) do
    gui.update_filters(name, player.index, nil, "remove")
  end
  local window_frame = player_table.gui.main.window.frame
  if window_frame.valid then
    window_frame.destroy()
  end
  player_table.gui.main = nil

  player_table.flags.gui_open = false
  player_table.flags.can_open_gui = false
  player.set_shortcut_available("ltnm-toggle-gui", false)
end

function main_gui.update(player, player_table, state_changes)
  local gui_data = player_table.gui.main
  local data = global.data
  local material_translations = player_table.translations.materials

  if state_changes.active_tab then
    local tabbed_pane_data = gui_data.tabbed_pane
    -- close previous tab, if there was a previous tab
    if tabbed_pane_data.selected then
      tabbed_pane_data.tabs[tabbed_pane_data.selected].enabled = true
      tabbed_pane_data.contents[tabbed_pane_data.selected].visible = false
    end
    -- set new tab to focused
    tabbed_pane_data.tabs[state_changes.active_tab].enabled = false
    tabbed_pane_data.contents[state_changes.active_tab].visible = true
    -- update selected tab in global
    tabbed_pane_data.selected = state_changes.active_tab

    local search_button = gui_data.titlebar.search_button
    if tabs[state_changes.active_tab].search_template then
      search_button.sprite = "utility/search_white"
      search_button.enabled = true
      search_button.tooltip = {"ltnm-gui.search-tooltip"}
    else
      search_button.sprite = "ltnm_search_disabled"
      search_button.enabled = false
      search_button.tooltip = {"ltnm-message.search-not-supported"}
    end
  end

  -- active tab
  local active_tab = state_changes.active_tab or gui_data.tabbed_pane.selected
  tabs[active_tab].update(player, player_table, state_changes, gui_data, data, material_translations)
end

function main_gui.update_active_tab(player, player_table, name)
  local changes
  if name then
    changes = {active_tab = name}
    -- close search
    if player_table.flags.search_open then
      main_gui.close_search(player, player_table, player_table.gui.main, true)
    end
  else
    name = player_table.gui.main.tabbed_pane.selected
    changes = {}
  end
  if name == "depots" then
    changes.depot_buttons = true
    changes.selected_depot = player_table.gui.main.depots.selected or true
  elseif name == "stations" then
    changes.stations_list = true
  elseif name == "inventory" then
    changes.inventory = true
  elseif name == "history" then
    changes.history = true
  elseif name == "alerts" then
    changes.alerts = true
  end
  main_gui.update(player, player_table, changes)
end

function main_gui.open(player, player_table, skip_update)
  local window_frame = player_table.gui.main.window.frame
  if not window_frame.valid then
    player.print{"ltnm-message.invalid-gui-error"}
    main_gui.close(player, player_table)
    main_gui.destroy(player, player_table)
    player_data.refresh(player, player_table)
    return
  end

  if not skip_update then
    main_gui.update_active_tab(player, player_table)
  end

  if not player_table.gui.main.window.pinned then
    player.opened = player_table.gui.main.window.frame
  end

  player_table.flags.gui_open = true
  player_table.gui.main.window.frame.visible = true

  player.set_shortcut_toggled("ltnm-toggle-gui", true)
end

function main_gui.close(player, player_table)
  player_table.flags.gui_open = false

  local window_frame = player_table.gui.main.window.frame
  if window_frame.valid then
    window_frame.visible = false
  end

  if player_table.flags.search_open then
    main_gui.close_search(player, player_table, player_table.gui.main, true)
  end

  player.set_shortcut_toggled("ltnm-toggle-gui", false)

  player.opened = nil
end

function main_gui.toggle(player, player_table)
  if player_table.flags.gui_open then
    main_gui.close(player, player_table)
  else
    main_gui.open(player, player_table)
  end
end

function main_gui.open_search(player, player_table, gui_data, skip_update)
  local selected_tab = gui_data.tabbed_pane.selected

  gui_data.titlebar.search_button.style = "flib_selected_frame_action_button"
  gui_data.titlebar.search_button.sprite = "utility/search_black"

  -- set initial state
  tabs[selected_tab].set_search_initial_state(player, player_table, gui_data)

  -- set frame location offset
  local main_window = gui_data.window.frame
  local location = main_window.location
  main_window.location = {x = location.x, y = (location.y - constants.search_frame_height)}

  -- actually show the frame
  local search_window = gui_data.search.window
  search_window[selected_tab.."_contents"].visible = true
  search_window.visible = true

  -- opened logic
  if not player_table.settings.keep_gui_open then
    player_table.flags.toggling_search = true
    player.opened = search_window
    player_table.flags.toggling_search = false
  end
  player_table.flags.search_open = true

  if not skip_update then
    main_gui.update_active_tab(player, player_table)
  end
end

function main_gui.close_search(player, player_table, gui_data, skip_update)
  local search_window = gui_data.search.window
  local selected_tab = gui_data.tabbed_pane.selected
  if search_window.valid then
    search_window[selected_tab.."_contents"].visible = false
    search_window.visible = false

    -- set frame location offset
    local main_window = gui_data.window.frame
    local location = main_window.location
    main_window.location = {x = location.x, y = (location.y + constants.search_frame_height)}

    if not player_table.settings.keep_gui_open then
      player_table.flags.toggling_search = true
      player.opened = gui_data.window.frame
      player_table.flags.toggling_search = false
    end

    gui_data.titlebar.search_button.style = "frame_action_button"
    gui_data.titlebar.search_button.sprite = "utility/search_white"

    if not skip_update then
      main_gui.update_active_tab(player, player_table)
    end
  end

  player_table.flags.search_open = false

end

function main_gui.toggle_search(player, player_table)
  local gui_data = player_table.gui.main
  local active_tab = gui_data.tabbed_pane.selected
  if player_table.flags.search_open then
    main_gui.close_search(player, player_table, gui_data)
  elseif tabs[active_tab].search_template then
    main_gui.open_search(player, player_table, gui_data)
  else
    player.print{"ltnm-message.search-not-supported"}
  end
end

return main_gui
