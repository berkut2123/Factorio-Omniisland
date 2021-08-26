local SettingsController = {
  classname = "FNSettingsController",
}

local SettingsGui = require "scripts/settings/gui"
local tabs = "sett-tabs"

function SettingsController.exit()
  out("settings exit")
  Player.get_global()["gui_loc"] = SettingsGui.close_window()
end

function SettingsController.open()
  out("settings open")

  local ret_gui = SettingsGui.open_window(Player.get_global()["gui_loc"])
  SettingsGui.draw_tabs(tabs)
  SettingsController.draw_settings()

  return ret_gui
end

function SettingsController.draw_settings()
  local cur_tab = tabs:get_cur_tab()
  local settings = Settings.get_sett_list()
  local sett_list = {}
  
  sett_list = SettingsController.set_settings_for_tab(settings, cur_tab)
  SettingsGui.add_option_list(sett_list)
end

function SettingsController.set_settings_for_tab(settings, cur_tab)
  local ret_tb = {}

  for name, sett in pairs(settings) do
    if sett.tab == cur_tab then
      table.insert(ret_tb, sett)
    end
  end

  return ret_tb
end

function SettingsController.back_key()
  return true
end

function SettingsController.can_open_gui()
  return true
end

function SettingsController.get_name()
  return SettingsGui.name
end

function SettingsController.is_gui_open()
  return SettingsGui.is_gui_open()
end

function SettingsController.set_new_tab_event(event, gui_name)
  SettingsController.draw_settings(tabs:get_cur_tab())
end

function SettingsController.init_events()
  SettingsGui.init_events()
  Settings.init_events()
  tabs = Tabs:new(tabs, SettingsGui.name, {"main-settings", "crafting-category", "admin-settings"}, "fnei_settings_selected-tab", "fnei_settings_empty-tab", SettingsController.set_new_tab_event)
end

return SettingsController