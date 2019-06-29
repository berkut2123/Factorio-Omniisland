local pvp = require("pvp")

pvp.add_remote_interface()

local register_events = function()
  for event_name, handler in pairs (pvp.get_events()) do
    script.on_event(event_name, handler)
  end
  for n, handler in pairs (pvp.on_nth_tick) do
    script.on_nth_tick(n, handler)
  end
end

script.on_init(function()
  pvp.on_init()
  register_events()
end)

script.on_load(function()
  pvp.on_load()
  register_events()
end)

script.on_configuration_changed(function()
  pvp.on_configuration_changed()
end)
