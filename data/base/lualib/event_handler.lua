local event_handler = {}

event_handler.setup_event_handling = function(receivers)
  script.on_event(defines.events, function(event)
    for _, receiver in pairs(receivers) do
      if event and event.name and receiver[event.name] then
        receiver[event.name](event)
      end
    end
  end)
end

return event_handler
