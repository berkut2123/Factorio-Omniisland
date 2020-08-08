if not game.surfaces["aai-signals"] then
  game.create_surface("aai-signals", {height=1, width=1})
end

for k,v in pairs(game.surfaces["aai-signals"].find_entities_filtered{name="aai-filter"}) do
    v.destroy()
end

local function register_transceiver(transceiver)
    local surface = game.surfaces["aai-signals"]
    local filter_red = surface.create_entity{name="aai-filter", position=transceiver.position, force=transceiver.force}
    local filter_green = surface.create_entity{name="aai-filter", position=transceiver.position, force=transceiver.force}
    local channel = global.transceivers[transceiver.unit_number].channel
    local circuit_id = 2
    if transceiver.name == "aai-signal-sender" then
        circuit_id = 1
    end
    -- transceiver.connect_neighbour{target_entity=filter, wire=defines.wire_type.red, target_circuit_id=circuit_id}
    -- transceiver.connect_neighbour{target_entity=filter, wire=defines.wire_type.green, target_circuit_id=circuit_id}
    filter_red.get_or_create_control_behavior().parameters = {parameters = {first_signal = {type="virtual", name="signal-anything"}, output_signal = {type="virtual", name="signal-everything"}, comparator  = "≠"}}
    filter_green.get_or_create_control_behavior().parameters = {parameters = {first_signal = {type="virtual", name="signal-anything"}, output_signal = {type="virtual", name="signal-everything"}, comparator  = "≠"}}
    global.transceivers[transceiver.unit_number] = {filter_red=filter_red, filter_green=filter_green, entity=transceiver, channel = channel}
    subscribe(transceiver, channel)
end

local function get_pole(forcename, signal)
    local signal_surface = game.surfaces["aai-signals"]
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

local function subscribe(transceiver, signal)
    signal = signal or global.transceivers[transceiver.unit_number].channel
    if not signal then log("Invalid signal!") local a = "1" .. nil end
    local pole = get_pole(transceiver.force.name, signal)
    local filter_red = global.transceivers[transceiver.unit_number].filter_red
    local filter_green = global.transceivers[transceiver.unit_number].filter_green
    global.transceivers[transceiver.unit_number].channel = signal
    local circuit_id = 1
    local other_id = 2
    if transceiver.name == "aai-signal-sender" then
        circuit_id = 2
        other_id = 1
    end

    --Need to disconnect from old channel first.
    --disconnect(transceiver)
    connect(transceiver)
    pole.teleport(filter_red.position)
    filter_red.connect_neighbour{target_entity = pole, wire=defines.wire_type.red, source_circuit_id=circuit_id}
    filter_green.connect_neighbour{target_entity = pole, wire=defines.wire_type.green, source_circuit_id=circuit_id}
  end

for surface_name, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered{name="aai-signal-sender"}) do
        register_transceiver(entity, true)
    end
    for _, entity in pairs(surface.find_entities_filtered{name="aai-signal-receiver"}) do
        register_transceiver(entity)
    end
end
