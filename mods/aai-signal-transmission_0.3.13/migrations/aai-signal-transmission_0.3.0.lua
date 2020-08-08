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

global.channels = {} --Each force has its own subtable.  Channel name is used as key.  Value is the central pole it's all hooked up to.
global.transceivers = {} --The dish's ID is used as a key.  The value is {filter_red=entity, filter_green=entity, connected=true, channel=string}
global.selected = {} --Player_index -> entity reference

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
    filter_red.get_or_create_control_behavior().parameters = {parameters = {first_signal = {type="virtual", name="signal-each"}, output_signal = {type="virtual", name="signal-each"}, operation  = "+"}}
    filter_green.get_or_create_control_behavior().parameters = {parameters = {first_signal = {type="virtual", name="signal-each"}, output_signal = {type="virtual", name="signal-each"}, operation  = "+"}}
    global.transceivers[transceiver.unit_number] = {filter_red=filter_red, filter_green=filter_green, entity=transceiver, channel = DEFAULT_CHANNEL}
end

if global.transmission_receivers then
    for _, entry in pairs(global.transmission_receivers) do
        register_transceiver(entry.main)
        global.transceivers[entry.main.unit_number].channel = entry.channel
    end
end
if global.transmission_senders then
    for _, entry in pairs(global.transmission_senders) do
        register_transceiver(entry.main)
        global.transceivers[entry.main.unit_number].channel = entry.channel
    end
end
global.transmission_receivers=nil
global.transmission_senders=nil
global.transmission_receivers_by_channel=nil
global.transmission_senders_by_channel=nil
global.tick_skip = nil
global.signals_by_channel = nil
global.playerdata = nil
