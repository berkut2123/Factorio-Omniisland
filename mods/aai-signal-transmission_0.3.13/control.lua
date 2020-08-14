local mod_prefix = "aai-"
local DEFAULT_CHANNEL = "1"

local TransmissionSender = {}
TransmissionSender.name_sender = mod_prefix.."signal-sender"
TransmissionSender.name_sender_gui_root = mod_prefix.."signal-sender"
--TransmissionSender.min_energy = 5000000 * 0.75

local TransmissionReceiver = {}
TransmissionReceiver.name_receiver = mod_prefix.."signal-receiver"
--TransmissionReceiver.name_receiver_combinator = mod_prefix.."signal-receiver-combinator"
TransmissionReceiver.name_receiver_gui_root = mod_prefix.."signal-receiver"
--TransmissionReceiver.min_energy = 1000000 * 0.75

global.channels = {} --Each force has its own subtable.  Channel name is used as key.  Value is the central pole it's all hooked up to.
global.transceivers = {} --The dish's ID is used as a key.  The value is {filter_red=entity, filter_green=entity, connected=true, channel=string}
global.selected = {} --Player_index -> entity reference

function TransmissionSender.on_entity_created(event)
    local entity
    if event.entity and event.entity.valid then
      entity = event.entity
    end
    if event.created_entity and event.created_entity.valid then
      entity = event.created_entity
    end
    if entity.name ~= TransmissionSender.name_sender then return end
    entity.backer_name = ""

    --local default_channel = "1"

    register_transceiver(entity, true)
    --subscribe(entity, default_channel, true)

    -- don't output logistcs data
    local control = entity.get_or_create_control_behavior()
    --control.mode_of_operations = defines.control_behavior.roboport.circuit_mode_of_operation.read_robot_stats
    control.read_logistics = false
end


function gui_click(event)
    if not (event.element and event.element.valid) then return end
    local entity = global.selected[event.player_index]
    local element = event.element
    if element.name == "change_channel" then
      if not (entity and entity.valid) then close_gui({element=element}) return end
      local channel = global.transceivers[entity.unit_number].channel

      local channel_flow = element.parent
      element.destroy()
      channel_flow["show-channel"].destroy()
      local channel_label = channel_flow.add{ type = "textfield", name="write-channel", text=channel}
      channel_label.select_all()
      channel_label.focus()
      local change_channel_button = channel_flow.add{ type = "sprite-button", name="change-channel-confirm", sprite="utility/enter",
        tooltip={"aai-signal-transmission.change-channel", {"entity-name." .. entity.type}}, style="aai_signal_transmission_sprite_button_small"}

    elseif element.name == "change-channel-confirm" then
      if not (entity and entity.valid) then close_gui({element=element}) return end
      local channel = global.transceivers[entity.unit_number].channel
      local channel_flow = element.parent
      local new_name = string_trim(channel_flow["write-channel"].text)
      element.destroy()
      if new_name ~= "" and new_name ~= channel then
        --do change name stuff
        subscribe(entity, new_name, TransmissionSender.name_sender_gui_root == entity.name)
      end
      channel_flow["write-channel"].destroy()
      local channel_label = channel_flow.add{ type = "label", name="show-channel", caption="Channel: " .. new_name}
      local change_channel_button = channel_flow.add{ type = "sprite-button", name="change_channel", sprite="utility/rename_icon_normal",
        tooltip={"aai-signal-transmission.change-channel", {"entity-name." .. entity.type}}, style="aai_signal_transmission_sprite_button_small"}
    elseif element.name == "write-channel" then
      local channel = global.transceivers[entity.unit_number].channel
      local channel_flow = element.parent
      local new_name = string_trim(element.text)
      channel_flow["change-channel-confirm"].destroy()
      if new_name ~= "" and new_name ~= channel then
        --do change name stuff
        subscribe(entity, new_name, TransmissionSender.name_sender_gui_root == entity.name)
      end
      channel_flow["write-channel"].destroy()
      local channel_label = channel_flow.add{ type = "label", name="show-channel", caption="Channel: " .. new_name}
      local change_channel_button = channel_flow.add{ type = "sprite-button", name="change_channel", sprite="utility/rename_icon_normal",
        tooltip={"aai-signal-transmission.change-channel", {"entity-name." .. entity.type}}, style="aai_signal_transmission_sprite_button_small"}

    elseif element.name == mod_prefix .. "-signal-close" then
      element.parent.parent.destroy()
    end
end

function TransmissionReceiver.on_entity_created(event)
    local entity
    if event.entity and event.entity.valid then
      entity = event.entity
    end
    if event.created_entity and event.created_entity.valid then
      entity = event.created_entity
    end
    if not entity then return end
    if entity.name ~= TransmissionReceiver.name_receiver then return end
    entity.backer_name = ""

    local default_channel = "1"

    -- don't output logistcs data
    local control = entity.get_or_create_control_behavior()
    --control.mode_of_operations = defines.control_behavior.roboport.circuit_mode_of_operation.read_robot_stats
    control.read_logistics = false

    register_transceiver(entity)
    --subscribe(entity, default_channel)
end


function open_gui (player, entity)
    local gui = player.gui.screen
    local channel_text = global.transceivers[entity.unit_number].channel
    player.opened = nil
    global.selected[player.index] = entity --Not used here, but used in gui_click
    if gui[TransmissionSender.name_sender_gui_root] then
      gui[TransmissionSender.name_sender_gui_root].destroy()
    end
    --local container = gui.add{ type = "frame", name = TransmissionSender.name_sender_gui_root, direction="vertical", style="standalone_inner_frame_in_outer_frame" }
    local container = gui.add{ type = "frame", name = TransmissionSender.name_sender_gui_root, direction="vertical" }
    player.opened = container
    --Gui may be invalidated by previous line.
    if not container then return end
    
    local title_flow = container.add{ type="flow", name="unit_number", direction="horizontal"}
    -- NOTE: [TransmissionSender.name_rocket_landing_pad_gui_root].unit_number.child_names()[1] gets unit number
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

    local channel_flow = container.add{ type="flow", name="channel-flow", direction="horizontal"}
    channel_flow.style.top_margin = 10
    local channel_label = channel_flow.add{ type = "label", name="show-channel", caption="Channel: " .. channel_text,}
    local change_channel_button = channel_flow.add{ type = "sprite-button", name="change_channel", sprite="utility/rename_icon_normal",
      tooltip={"aai-signal-transmission.change-channel", {"entity-name." .. entity.type}}, style="aai_signal_transmission_sprite_button_small"}

    container.force_auto_center()
end

function on_gui_opened(event)
    if event.entity and event.entity.valid then
        if not (global.transceivers and global.transceivers[event.entity.unit_number]) then
          -- for whatever reason something is not initialised
          -- most likely situation is a legacy entity
          -- run on created events again to go through normal setup process.
          TransmissionSender.on_entity_created(event)
          TransmissionReceiver.on_entity_created(event)
        end
        if event.entity.name == TransmissionSender.name_sender then
            open_gui(game.players[event.player_index], event.entity)
        elseif event.entity.name == TransmissionReceiver.name_receiver then
            open_gui(game.players[event.player_index], event.entity)
        end
    end
end

function close_gui(event)
    if (event.element and event.element.valid) and (event.element.name == TransmissionSender.name_sender_gui_root or event.element.name == TransmissionReceiver.name_receiver_gui_root) then
        event.element.destroy()
    end
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
          --game.print("reconnecting")
          --connect(entity)
          subscribe(entity)
        end
      end
    else
      table.insert(ded, key)
    end
  end

  --Cleaning time.
  for _, key in pairs(ded) do
    local force_name = global.transceivers[key].filter_red.force.name
    local transciever_info = global.transceivers[key]
    global.transceivers[key] = nil
    transciever_info.filter_red.destroy()
    transciever_info.filter_green.destroy()
    if not global.channels[force_name] then log("Error, force not initialized") return end
    clean_pole(global.channels[force_name][transciever_info.channel], transciever_info.channel)
  end
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
    local surface = game.create_surface(mod_prefix .. "signals", {height=1, width=1})
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

--source_circuit_id==1 is the input.
--source_circuit_id==2 is the output.
function register_transceiver(transceiver)
    local surface = get_surface()
    local filter_red = surface.create_entity{name="aai-filter", position=transceiver.position, force=transceiver.force}
    local filter_green = surface.create_entity{name="aai-filter", position=transceiver.position, force=transceiver.force}
    local circuit_id = 2
    if transceiver.name == TransmissionSender.name_sender then
        circuit_id = 1
    end
    -- transceiver.connect_neighbour{target_entity=filter, wire=defines.wire_type.red, target_circuit_id=circuit_id}
    -- transceiver.connect_neighbour{target_entity=filter, wire=defines.wire_type.green, target_circuit_id=circuit_id}
    filter_red.get_or_create_control_behavior().parameters = {parameters = {first_signal = {type="virtual", name="signal-anything"}, output_signal = {type="virtual", name="signal-everything"}, comparator  = "≠"}}
    filter_green.get_or_create_control_behavior().parameters = {parameters = {first_signal = {type="virtual", name="signal-anything"}, output_signal = {type="virtual", name="signal-everything"}, comparator  = "≠"}}
    global.transceivers[transceiver.unit_number] = {filter_red=filter_red, filter_green=filter_green, entity=transceiver, channel = DEFAULT_CHANNEL}
end

function subscribe(transceiver, signal)
  signal = signal or global.transceivers[transceiver.unit_number].channel
  if not signal then log("Invalid signal!") local a = "1" .. nil end
  local pole = get_pole(transceiver.force.name, signal)
  local filter_red = global.transceivers[transceiver.unit_number].filter_red
  local filter_green = global.transceivers[transceiver.unit_number].filter_green
  global.transceivers[transceiver.unit_number].channel = signal
  local circuit_id = 1
  local other_id = 2
  if transceiver.name == TransmissionSender.name_sender then
      circuit_id = 2
      other_id = 1
  end

  --Need to disconnect from old channel first.
  disconnect(transceiver)
  connect(transceiver)
  pole.teleport(filter_red.position)
  filter_red.connect_neighbour{target_entity = pole, wire=defines.wire_type.red, source_circuit_id=circuit_id}
  filter_green.connect_neighbour{target_entity = pole, wire=defines.wire_type.green, source_circuit_id=circuit_id}
end

function disconnect(transceiver)
  local transciever_info = global.transceivers[transceiver.unit_number]
  local filter_red = transciever_info.filter_red
  local filter_green = transciever_info.filter_green
  filter_red.disconnect_neighbour(defines.wire_type.red)
  filter_green.disconnect_neighbour(defines.wire_type.green)
  transciever_info.connected = false
  --clean_pole(global.channels[filter_red.force][transciever_info.channel])
end

function connect(transceiver)
  local filter_red = global.transceivers[transceiver.unit_number].filter_red
  local filter_green = global.transceivers[transceiver.unit_number].filter_green
  local circuit_id = 1
  local other_id = 2
  if transceiver.name == TransmissionSender.name_sender then
      circuit_id = 2
      other_id = 1
  end
  filter_red.connect_neighbour{target_entity=transceiver, wire=defines.wire_type.red, source_circuit_id=other_id}
  filter_green.connect_neighbour{target_entity=transceiver, wire=defines.wire_type.green, source_circuit_id=other_id}
  global.transceivers[transceiver.unit_number].connected = true
end

function string_trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.script_raised_built, defines.events.script_raised_revive},
    function(event) TransmissionSender.on_entity_created(event) TransmissionReceiver.on_entity_created(event) end
)

script.on_event(defines.events.on_entity_cloned, function(ev)
  local event = {entity=ev.destination}
  TransmissionSender.on_entity_created(event)
  TransmissionReceiver.on_entity_created(event)
  subscribe(ev.destination, global.transceivers[ev.source.unit_number].channel)
end, {{filter="name", name=TransmissionSender.name_sender}, {filter="name", name=TransmissionReceiver.name_receiver}})

script.on_event(defines.events.on_gui_opened, on_gui_opened)
script.on_event(defines.events.on_gui_closed, close_gui)
script.on_event(defines.events.on_gui_click, gui_click)
script.on_event(defines.events.on_gui_confirmed, gui_click)
script.on_event(defines.events.on_forces_merged, transpose)
script.on_nth_tick(30, check_power)
