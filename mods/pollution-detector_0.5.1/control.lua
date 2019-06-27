
---- Mod Settings ----
-- local update_interval = 120
local update_interval = settings.global["pollution_detector_update_interval"].value
local floor = math.floor

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  if not event then return end
  if event.setting == "pollution_detector_update_interval" then
    update_interval = settings.global["pollution_detector_update_interval"].value
  end
end)


---- runtime Events ----
function OnEntityCreated(event)
	if event.created_entity.name == "pollution-detector" then
    table.insert(global.Pollution_Detectors, event.created_entity)
    
    -- register to events after placing the first sensor
    if #global.Pollution_Detectors == 1 then
      script.on_event(defines.events.on_tick, OnTick)
      script.on_event({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died}, OnEntityRemoved)
    end
	end
end

function OnEntityRemoved(event)
	if event.entity.name == "pollution-detector" then

    for i=#global.Pollution_Detectors, 1, -1 do
      if global.Pollution_Detectors[i].unit_number == event.entity.unit_number then
        table.remove(global.Pollution_Detectors, i)
      end
    end
    
    -- unregister when last sensor was removed
    if #global.Pollution_Detectors == 0 then
      script.on_event(defines.events.on_tick, nil)
      script.on_event({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died}, nil)
    end
  end
end

-- stepping from tick modulo with stride by eradicator
function OnTick(event)
  local offset = event.tick % update_interval
  for i=#global.Pollution_Detectors - offset, 1, -1 * update_interval do  
    local pollution_detector = global.Pollution_Detectors[i]    
    local pollution_count = floor(pollution_detector.surface.get_pollution({pollution_detector.position.x, pollution_detector.position.y}) * 60)
    local params = {parameters={
      {index = 1, signal = {type = "virtual", name = "pd-pollution"}, count = pollution_count}
    }}
    pollution_detector.get_control_behavior().parameters = params
  end
end


do---- Init ----
local function init_Pollution_Detectors()
  -- gather all pollution detectors on every surface in case another mod added some
	global.Pollution_Detectors = {}
   for _, surface in pairs(game.surfaces) do
    pollution_detectors = surface.find_entities_filtered {
      name = "pollution-detector",
    }
    for _, pollution_detector in pairs(pollution_detectors) do
      table.insert(global.Pollution_Detectors, pollution_detector)
    end
  end
end

local function init_events()
	script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, OnEntityCreated)
	if global.Pollution_Detectors and next(global.Pollution_Detectors) then
		script.on_event(defines.events.on_tick, OnTick)
		script.on_event({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died}, OnEntityRemoved)
	end
end

script.on_load(function()
  init_events()
end)

script.on_init(function()
  init_Pollution_Detectors()
  init_events()
end)

script.on_configuration_changed(function(data)
  init_Pollution_Detectors()
	init_events()
end)

end
