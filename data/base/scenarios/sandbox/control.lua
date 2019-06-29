local silo_script = require("silo-script")
local mod_gui = require("mod-gui")
local version = 1

script.on_event(defines.events.on_player_created, function(event)
  local player = game.players[event.player_index]
  local character = player.character
  player.character = nil
  if character then
    character.destroy()
  end

  local r = global.chart_distance or 200
  player.force.chart(player.surface, {{player.position.x - r, player.position.y - r}, {player.position.x + r, player.position.y + r}})

  if not global.skip_intro then
    if game.is_multiplayer() then
      player.print({"msg-introduction"})
    else
      game.show_message_dialog{text = {"msg-introduction"}}
    end
  end

  if not global.skip_cheat_menu then
    create_technologies_frame(player)
  end
  silo_script.on_player_created(event)
end)

script.on_init(function()
  global.version = version
  silo_script.on_init()
end)

script.on_configuration_changed(function(event)
  if global.version ~= version then
    global.version = version;
    local forces = game.forces
    if global.satellite_sent ~= nil then
      for force_name,rockets_launched in pairs(global.satellite_sent) do
        local force = forces[force_name]
        if force ~= nil then
          force.rockets_launched = rockets_launched
        end
      end
    end
  end
  silo_script.on_configuration_changed(event)
end)

script.on_event(defines.events.on_rocket_launched, function(event)
  silo_script.on_rocket_launched(event)
end)

script.on_init(function()
  silo_script.on_init()
end)

silo_script.add_remote_interface()
silo_script.add_commands()

script.on_event(defines.events.on_gui_click, function(event)
  local player = game.players[event.player_index]
  local gui = event.element
  if gui.name == "button_technologies_researched" then
    player.force.research_all_technologies()
    gui.parent.destroy()
    create_item_frame(player)
    return
  end
  if gui.name == "button_technologies_normal" then
    gui.parent.destroy()
    create_item_frame(player)
    return
  end
  if gui.name == "button_yes_items" then
    give_items(player)
    gui.parent.destroy()
    create_cheat_frame(player)
    return
  end
  if gui.name =="button_no_items" then
    gui.parent.destroy()
    create_cheat_frame(player)
    return
  end
  if gui.name == "button_use_cheat_mode" then
    player.cheat_mode = true
    gui.parent.destroy()
    create_day_frame(player)
    return
  end
  if gui.name == "button_no_cheat_mode" then
    gui.parent.destroy()
    create_day_frame(player)
    return
  end
  if gui.name == "button_yes_day" then
    player.surface.always_day = true
    gui.parent.destroy()
    return
  end
  if gui.name =="button_no_day" then
    gui.parent.destroy()
    return
  end
  silo_script.on_gui_click(event)
end)

function give_items(player)
  local items =
  {
    ["wood"] = "100",
    ["coal"] = "100",
    ["stone"] = "100",
    ["iron-plate"] = "400",
    ["copper-plate"] = "400",
    ["steel-plate"] = "100",
    ["iron-gear-wheel"] = "200",
    ["electronic-circuit"] = "200",
    ["advanced-circuit"] = "200",
    ["offshore-pump"] = "20",
    ["pipe"] = "50",
    ["boiler"] = "50",
    ["electric-mining-drill"] = "50",
    ["steam-engine"] = "10",
    ["stone-furnace"] = "50",
    ["transport-belt"] = "200",
    ["underground-belt"] = "50",
    ["splitter"] = "20",
    ["fast-transport-belt"] = "50",
    ["express-transport-belt"] = "50",
    ["inserter"] = "50",
    ["fast-inserter"] = "50",
    ["long-handed-inserter"] = "50",
    ["filter-inserter"] = "50",
    ["small-electric-pole"] = "50",
    ["assembling-machine-1"] = "50",
    ["assembling-machine-2"] = "30",
    ["rail"] = "200",
    ["train-stop"] = "10",
    ["rail-signal"] = "50",
    ["locomotive"] = "5",
    ["cargo-wagon"] = "10"
  }
  for name, count in pairs (items) do
    if game.item_prototypes[name] then
      player.insert{name = name, count = count}
    else
      log("Item to insert not valid: "..name)
    end
  end
end

function create_item_frame(player)
  local frame = mod_gui.get_frame_flow(player).add{name = "items_frame", type = "frame", direction = "horizontal", caption={"msg-give-items"}}
  frame.add{type = "button", name="button_yes_items", caption={"button-yes-items"}}
  frame.add{type = "button", name="button_no_items", caption={"button-no-items"}}
end

function create_technologies_frame(player)
  local frame = mod_gui.get_frame_flow(player).add{name = "technologies_frame", type = "frame", direction = "horizontal", caption={"msg-ask-technologies"}}
  frame.add{type = "button", name = "button_technologies_researched", caption = {"button-technologies-researched"}}
  frame.add{type = "button", name = "button_technologies_normal", caption = {"button-technologies-normal"}}
end

function create_cheat_frame(player)
  local frame = mod_gui.get_frame_flow(player).add{name = "cheat_frame", type = "frame", direction = "horizontal", caption={"msg-ask-cheat-mode"}}
  frame.add{type = "button", name="button_use_cheat_mode", caption={"button-use-cheat-mode"}}
  frame.add{type = "button", name="button_no_cheat_mode", caption={"button-no-cheat-mode"}}
end

function create_day_frame(player)
  local frame = mod_gui.get_frame_flow(player).add{name = "day_frame", type = "frame", direction = "horizontal", caption={"msg-ask-always-day"}}
  frame.add{type = "button", name="button_yes_day", caption={"button-yes-day"}}
  frame.add{type = "button", name="button_no_day", caption={"button-no-day"}}
end

remote.add_interface("sandbox",
{
  set_skip_intro = function(bool)
    global.skip_intro = bool
  end,
  set_chart_distance = function(value)
    global.chart_distance = tonumber(value)
  end,
  set_skip_cheat_menu = function(bool)
    global.skip_cheat_menu = bool
  end
})
