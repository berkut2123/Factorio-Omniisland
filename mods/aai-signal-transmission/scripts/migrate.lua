local Migrate = {}

function Migrate.migrations()
  global.old_version = global.version or "0.0.0"
  global.version = game.active_mods["aai-signal-transmission"]

  if Util.dot_string_less_than(global.old_version, "0.3.21", false) then
    Migrate.v0_3_21 ()
  end
end


function Migrate.v0_3_21 ()
  local transceivers = {}
  
  global.channels = global.channels or {}
  global.transceivers = global.transceivers or {}
  global.selected = global.selected or {}
  for key, transceiver in pairs(global.transceivers) do
    if transceiver.entity.valid then
      local entity = transceiver.entity
      local channel = transceiver.channel
      if channel and entity and entity.valid then
        transceivers[entity.unit_number] = {entity = entity, channel = channel}
      end
      deconstruct(key)
    end
  end

  global.transmission_receivers = nil
  global.transmission_senders = nil
  global.transmission_receivers_by_channel = nil
  global.transmission_senders_by_channel = nil
  global.tick_skip = nil
  global.signals_by_channel = nil
  global.playerdata = nil

  for surface_name, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered{name={"aai-signal-sender", "aai-signal-receiver"}}) do
      if not transceivers[entity.unit_number] then
        transceivers[entity.unit_number] = {entity = entity, channel = DEFAULT_CHANNEL}
      end
    end
  end

  for _, transceiver in pairs(transceivers) do
    register_transceiver(transceiver.entity, transceiver.channel)
  end

end

return Migrate
