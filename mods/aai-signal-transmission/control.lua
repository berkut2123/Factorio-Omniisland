local mod_prefix = "aai-"
local DEFAULT_CHANNEL = "Default"
is_debug_mode = false
Log = {}
function Log.trace(message)
  if is_debug_mode then game.print(message) end
end

Util = require("scripts/util")
Migrate = require("scripts/migrate")

local TransmissionSender = {}
name_sender = mod_prefix.."signal-sender"
name_sender_gui_root = mod_prefix.."signal-sender"

local TransmissionReceiver = {}
name_receiver = mod_prefix.."signal-receiver"
name_receiver_gui_root = mod_prefix.."signal-receiver"

--global.channels = {} --Each force has its own subtable.  Channel name is used as key.  Value is the central pole it's all hooked up to.
--global.transceivers = {} --The dish's ID is used as a key.  The value is {filter_red=entity, filter_green=entity, connected=true, channel=string}
--global.selected = {} --Player_index -> entity reference

function on_entity_created(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if entity.name == name_sender or entity.name == name_receiver then
    entity.backer_name = ""
    -- don't output logistcs data
    local control = entity.get_or_create_control_behavior()
    control.read_logistics = false

    register_transceiver(entity, event.tags and event.tags.channel)
  end
end

--source_circuit_id==1 is the input.
--source_circuit_id==2 is the output.
function register_transceiver(entity, channel)
  if not (entity.name == name_sender or entity.name == name_receiver) then return end

  local surface = get_surface()
  surface.request_to_generate_chunks(entity.position, 1)
  surface.force_generate_chunk_requests()
  local filter_red = surface.create_entity{name="aai-filter", position=entity.position, force=entity.force}
  local filter_green = surface.create_entity{name="aai-filter", position=entity.position, force=entity.force}
  local circuit_id = 2
  if entity.name == name_sender then
      circuit_id = 1
  end
  -- entity.connect_neighbour{target_entity=filter, wire=defines.wire_type.red, target_circuit_id=circuit_id}
  -- entity.connect_neighbour{target_entity=filter, wire=defines.wire_type.green, target_circuit_id=circuit_id}
  filter_red.get_or_create_control_behavior().parameters = {
      first_signal = {type="virtual", name="signal-anything"},
      output_signal = {type="virtual", name="signal-everything"},
      comparator  = "≠"}
  filter_green.get_or_create_control_behavior().parameters = {
      first_signal = {type="virtual", name="signal-anything"},
      output_signal = {type="virtual", name="signal-everything"},
      comparator  = "≠"}
  global.transceivers[entity.unit_number] = {
    unit_number = entity.unit_number,
    filter_red=filter_red,
    filter_green=filter_green,
    entity=entity,
    channel = channel or DEFAULT_CHANNEL
  }
  subscribe(entity)
end

function make_change_channel_button_flow(player, entity, channel_flow, channel_text)
  channel_flow.clear()
  local channel_horizontal_flow = channel_flow.add { type = "flow", direction = "horizontal"}
  local channel_label = channel_horizontal_flow.add{ type = "label", name="show-channel", caption="Channel: " .. channel_text}
  local change_channel_button = channel_horizontal_flow.add{ type = "sprite-button", name="change_channel", sprite="utility/rename_icon_normal",
    tooltip={"aai-signal-transmission.change-channel", {"entity-name." .. entity.type}}, style="aai_signal_transmission_sprite_button_small"}
  local channel_texts = all_channels_for_force(player)
  local change_channel_dropdown = channel_flow.add{ type = "drop-down", name="change_channel_dropdown",
    items = channel_texts,
    selected_index = selected_channel_index(channel_texts, channel_text)
  }
end

function make_change_channel_confirm_flow(entity, channel_flow, channel_text)
  channel_flow.clear()
  local channel_horizontal_flow = channel_flow.add { type = "flow", direction = "horizontal"}
  local channel_label = channel_horizontal_flow.add{ type = "textfield", name="write-channel", text=channel_text}
  channel_label.select_all()
  channel_label.focus()
  local change_channel_button = channel_horizontal_flow.add{ type = "sprite-button", name="change-channel-confirm", sprite="utility/enter",
        tooltip={"aai-signal-transmission.change-channel", {"entity-name." .. entity.type}}, style="aai_signal_transmission_sprite_button_small"}
end

function gui_click(event)
    if not (event.element and event.element.valid) then return end
    local entity = global.selected[event.player_index]
    local transceiver
    if entity and entity.valid then
      transceiver = global.transceivers[entity.unit_number]
    end
    local element = event.element
    if element.name == "change_channel" then
      if not transceiver then close_gui({element=element}) return end

      -- gui rebuild
      make_change_channel_confirm_flow(entity, element.parent.parent, transceiver.channel)
    elseif element.name == "change-channel-confirm" then
      if not transceiver then close_gui({element=element}) return end
      local channel_text = transceiver.channel
      local new_channel_text = Util.string_trim(element.parent["write-channel"].text)
      if new_channel_text ~= "" and new_channel_text ~= channel_text then
        --do change name stuff
        subscribe(entity, new_channel_text)
      end

      -- gui rebuild
      local player = game.players[event.player_index]
      make_change_channel_button_flow(player, entity, element.parent.parent, new_channel_text)
    elseif element.name == "write-channel" then
      if not transceiver then close_gui({element=element}) return end
      local channel_text = transceiver.channel
      local new_channel_text = Util.string_trim(element.text)
      if new_channel_text ~= "" and new_channel_text ~= channel_text then
        --do change name stuff
        subscribe(entity, new_channel_text)
      end

      -- gui rebuild
      local player = game.players[event.player_index]
      make_change_channel_button_flow(player, entity, element.parent.parent, new_channel_text)
    elseif element.name == mod_prefix .. "-signal-close" then
      element.parent.parent.destroy()
    end
end

function gui_selection_state_changed(event)
  if not (event.element and event.element.valid and  event.element.name == "change_channel_dropdown") then return end
  local entity = global.selected[event.player_index]
  local transceiver
  if entity and entity.valid then
    transceiver = global.transceivers[entity.unit_number]
  end
  local element = event.element
  if not transceiver then close_gui({element=element}) return end
  local channel_text = transceiver.channel
  local new_channel_text = element.get_item(element.selected_index)
  if new_channel_text ~= "" and new_channel_text ~= channel_text then
    --do change name stuff
    subscribe(entity, new_channel_text)
  end

  -- gui rebuild
  local player = game.players[event.player_index]
  make_change_channel_button_flow(player, entity, element.parent, new_channel_text)
end

function open_gui (player, entity)
    if not (entity and entity.valid) then return end
    local transceiver = global.transceivers[entity.unit_number]
    if not transceiver then return end

    local gui = player.gui.screen
    local channel_text = transceiver.channel
    player.opened = nil
    global.selected[player.index] = entity --Not used here, but used in gui_click
    if gui[name_sender_gui_root] then
      gui[name_sender_gui_root].destroy()
    end
    --local container = gui.add{ type = "frame", name = name_sender_gui_root, direction="vertical", style="standalone_inner_frame_in_outer_frame" }
    local container = gui.add{ type = "frame", name = name_sender_gui_root, direction="vertical" }
    player.opened = container
    --Gui may be invalidated by previous line.
    if not (container and container.valid) then return end

    local title_flow = container.add{ type="flow", name="unit_number", direction="horizontal"}
    -- NOTE: [name_rocket_landing_pad_gui_root].unit_number.child_names()[1] gets unit number
    local title = title_flow.add{ type="label", name=entity.unit_number, caption={"entity-name." .. entity.name}, style="heading_1_label"}
    title.ignored_by_interaction = true
    title_flow.drag_target=container

    -- Trying to make the fancy "Drag me" vertical bars...
    local drag_handle = title_flow.add{type = "empty-widget", style = "draggable_space_header", direction="horizontal"}
    drag_handle.drag_target = container
    drag_handle.style.minimal_width = 20
    drag_handle.style.horizontally_stretchable = true
    drag_handle.style.vertically_stretchable = true

    local close = title_flow.add{type="sprite-button", name=mod_prefix .. "-signal-close", sprite = "utility/close_white", style="tool_button"}

    local channel_flow = container.add{ type="flow", name="channel-flow", direction="vertical"}
    channel_flow.style.top_margin = 10

    make_change_channel_button_flow(player, entity, channel_flow, channel_text)

    container.force_auto_center()
end

function on_gui_opened(event)
    if event.entity and event.entity.valid then
        if event.entity.name == name_sender or event.entity.name == name_receiver then

            if not (global.transceivers and global.transceivers[event.entity.unit_number]) then
              -- for whatever reason something is not initialised
              -- most likely situation is a legacy entity
              -- run on created events again to go through normal setup process.
              on_entity_created(event)
            end

            open_gui(game.players[event.player_index], event.entity)
        end
    end
end

function close_gui(event)
    if (event.element and event.element.valid) and (event.element.name == name_sender_gui_root or event.element.name == name_receiver_gui_root) then
        event.element.destroy()
    end
end

function selected_channel_index(channel_texts, channel_text)
    for key, value in pairs(channel_texts) do
        if value == channel_text then return key end
    end
    return 0
end

function all_channels_for_force(player)
    local forcename = player.force.name
    if not (global.channels and global.channels[forcename]) then return {} end
    local channels = {DEFAULT_CHANNEL}
    for channel_name, pole in pairs(global.channels[forcename]) do
      if channel_name ~= DEFAULT_CHANNEL and pole and #pole.circuit_connected_entities.red > 0 then
        table.insert(channels, channel_name)
      end
    end
    return channels
end

function check_power()
  local ded = {}
  for key, transceiver in pairs(global.transceivers) do
    if transceiver.entity.valid then
      local entity = transceiver.entity
      if transceiver.connected then
        --Check for power.
        if entity.energy ~= entity.prototype.electric_energy_source_prototype.buffer_capacity then --This can error for void energy type
          disconnect(entity)
        end
      else
        if entity.energy == entity.prototype.electric_energy_source_prototype.buffer_capacity then --This can error for void energy type
          subscribe(entity)
        end
      end
    else
      table.insert(ded, key)
    end
  end

  --Cleaning time.
  for _, key in pairs(ded) do
    deconstruct(key)
  end
end

function deconstruct(key)
  local transciever_info = global.transceivers[key]
  if not transciever_info then return end
  global.transceivers[key] = nil
  local force_name
  if transciever_info.filter_red and transciever_info.filter_red.valid then
    force_name = transciever_info.filter_red.force.name
    transciever_info.filter_red.destroy()
  end
  if transciever_info.filter_green and transciever_info.filter_green.valid then
    force_name = transciever_info.filter_green.force.name
    transciever_info.filter_green.destroy()
  end
  if not (force_name and global.channels[force_name]) then log("Error, force not initialized") return end
  clean_pole(global.channels[force_name][transciever_info.channel], transciever_info.channel)
end

function transpose(event) -- on_forces_merged
  if not (global.channels and global.channels[event.source_name]) then return end
  local new_name = event.destination.name
  for channel_name, entity in pairs(global.channels[event.source_name]) do
    if not global.channels[new_name] then
      global.channels[new_name] = {}
    end
    if not global.channels[new_name][channel_name] then
      global.channels[new_name][channel_name] = entity
    else
      local new_pole = get_pole(new_name, channel_name)
      for _, connection in pairs(entity.circuit_connection_definitions) do
        new_pole.surface.request_to_generate_chunks(connection.target_entity.position, 1)
        new_pole.surface.force_generate_chunk_requests()
        new_pole.teleport(connection.target_entity.position)
        new_pole.connect_neighbour{target_entity=connection.target_entity, wire=connection.wire, target_circuit_id=connection.target_circuit_id}
      end
      global.channels[event.source_name][channel_name].destroy()
    end
  end
  global.channels[event.source_name] = nil
end
--End events

--Utility functions
function get_surface()
    if game.surfaces[mod_prefix .. "signals"] then
        return game.surfaces[mod_prefix .. "signals"]
    end
    --Still here?  Make it!
    local map_gen_settings = {height=1, width=1, property_expression_names = {}}
    map_gen_settings.autoplace_settings={
      ["decorative"]={treat_missing_as_default=false,settings={}},
      ["entity"]={treat_missing_as_default=false,settings={}},
      ["tile"]={treat_missing_as_default=false,settings={["out-of-map"]={}}},
    }
    local surface = game.create_surface(mod_prefix .. "signals", map_gen_settings)
    surface.request_to_generate_chunks({0,0}, 1)
    surface.force_generate_chunk_requests()
    return surface
end

function get_pole(forcename, signal)
    local signal_surface = get_surface()
    if not global.channels[forcename] then global.channels[forcename] = {} end
    if not signal then game.print("Error, no signal.") end
    local pole = global.channels[forcename][signal]
    if not pole then
      -- 0,0 might get generated as water and invalidate the entity.
      pole = signal_surface.create_entity{name="big-electric-pole", position={77,77}, force=forcename}
      global.channels[forcename][signal] = pole
    end
    return pole
end

function clean_pole(entity, channel)
  if not (entity and entity.valid) then log("Pole doesn't exist!") return end
  if #entity.circuit_connected_entities.red == 0 then
    global.channels[entity.force.name][channel] = nil
    entity.destroy()
  end
end


function subscribe(entity, signal)
  signal = signal or global.transceivers[entity.unit_number].channel
  if not signal then log("Invalid signal!") local a = "1" .. nil end
  local pole = get_pole(entity.force.name, signal)
  local filter_red = global.transceivers[entity.unit_number].filter_red
  local filter_green = global.transceivers[entity.unit_number].filter_green
  if not (pole and pole.valid and filter_red and filter_red.valid and filter_green and filter_green.valid) then
    deconstruct(entity.unit_number)
    return
  end
  global.transceivers[entity.unit_number].channel = signal
  local circuit_id = 1
  local other_id = 2
  if entity.name == name_sender then
      circuit_id = 2
      other_id = 1
  end

  --Need to disconnect from old channel first.
  disconnect(entity)
  connect(entity)
  pole.surface.request_to_generate_chunks(filter_red.position, 1)
  pole.surface.force_generate_chunk_requests()
  pole.teleport(filter_red.position)
  filter_red.connect_neighbour{target_entity = pole, wire=defines.wire_type.red, source_circuit_id=circuit_id}
  filter_green.connect_neighbour{target_entity = pole, wire=defines.wire_type.green, source_circuit_id=circuit_id}
end

function disconnect(entity)
  local transciever_info = global.transceivers[entity.unit_number]
  local filter_red = transciever_info.filter_red
  local filter_green = transciever_info.filter_green
  if filter_red and filter_red.valid and filter_green and filter_green.valid then
    filter_red.disconnect_neighbour(defines.wire_type.red)
    filter_green.disconnect_neighbour(defines.wire_type.green)
    transciever_info.connected = false
  else
    -- has become invalid
    deconstruct(entity.unit_number)
    register_transceiver(entity, transciever_info.channel)
  end
end

function connect(entity)
  local transciever_info = global.transceivers[entity.unit_number]
  local filter_red = transciever_info.filter_red
  local filter_green = transciever_info.filter_green
  local circuit_id = 1
  local other_id = 2
  if entity.name == name_sender then
    circuit_id = 2
    other_id = 1
  end
  if filter_red and filter_green then
    filter_red.connect_neighbour{target_entity=entity, wire=defines.wire_type.red, source_circuit_id=other_id}
    filter_green.connect_neighbour{target_entity=entity, wire=defines.wire_type.green, source_circuit_id=other_id}
    transciever_info.connected = true
  else
    -- has become invalid
    deconstruct(entity.unit_number)
    register_transceiver(entity, transciever_info.channel)
  end
end

function copy_paste_settings(event)
  local player_index = event.player_index
  if player_index and game.players[player_index] and game.players[player_index].connected 
  and event.source and event.source.valid and event.destination and event.destination.valid then
    if not (event.source.name == name_sender or event.source.name == name_receiver) then return end
    if not (event.destination.name == name_sender or event.destination.name == name_receiver) then return end
    local player = game.players[player_index]
    local source_info = global.transceivers[event.source.unit_number]
    if source_info then
      --do change name stuff
      subscribe(event.destination, source_info.channel)
    end
  end
end

function on_player_setup_blueprint(event)
  local player_index = event.player_index
  if player_index and game.players[player_index] and game.players[player_index].connected  then
    local player = game.players[player_index]

    -- this setup code and checks is a workaround for the fact that the event doesn't specify the blueprint on the event
    -- and the player.blueprint_to_setup isn't actually set in the case of copy/paste or blueprint library or select new contents
    local blueprint = nil
    if player and player.blueprint_to_setup and player.blueprint_to_setup.valid_for_read then blueprint = player.blueprint_to_setup
    elseif player and player.cursor_stack.valid_for_read and player.cursor_stack.is_blueprint then blueprint = player.cursor_stack end
    if blueprint and blueprint.is_blueprint_setup() then


      local mapping = event.mapping.get()
      local blueprint_entities = blueprint.get_blueprint_entities()
      if blueprint_entities then
        for _, blueprint_entity in pairs(blueprint_entities) do
          if blueprint_entity.name == name_sender or blueprint_entity.name == name_receiver then
            local entity = mapping[blueprint_entity.entity_number]
            if entity then
              local transceiver_info = global.transceivers[entity.unit_number]
              if transceiver_info then
                local tags = {channel=transceiver_info.channel}
                blueprint.set_blueprint_entity_tags(blueprint_entity.entity_number, tags)
              end
            end
          end
        end
      end
    end
  end
end

script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.script_raised_built, defines.events.script_raised_revive},
    on_entity_created
)

script.on_event(defines.events.on_entity_cloned, function(ev)
  local event = {entity=ev.destination}
  on_entity_created(event)
  subscribe(ev.destination, global.transceivers[ev.source.unit_number].channel)
end, {{filter="name", name=name_sender}, {filter="name", name=name_receiver}})

script.on_event(defines.events.on_entity_settings_pasted, copy_paste_settings)
script.on_event(defines.events.on_player_setup_blueprint, on_player_setup_blueprint)
script.on_event(defines.events.on_gui_opened, on_gui_opened)
script.on_event(defines.events.on_gui_closed, close_gui)
script.on_event(defines.events.on_gui_click, gui_click)
script.on_event(defines.events.on_gui_confirmed, gui_click)
script.on_event(defines.events.on_gui_selection_state_changed, gui_selection_state_changed)
script.on_event(defines.events.on_forces_merged, transpose)
script.on_nth_tick(30, check_power)

script.on_configuration_changed(function ()
  Migrate.migrations()
end)

script.on_init(function ()
  global.channels = {} --Each force has its own subtable.  Channel name is used as key.  Value is the central pole it's all hooked up to.
  global.transceivers = {} --The dish's ID is used as a key.  The value is {filter_red=entity, filter_green=entity, connected=true, channel=string}
  global.selected = {} --Player_index -> entity reference
end)
