local function sum(t) local s = 0 for _,v in pairs(t) do s = s + v end return s end

local function sum_input_output(statistics)
    local input, output = 0, 0
    for _, statistic in pairs(statistics) do
         input =  input + sum(statistic. input_counts)
        output = output + sum(statistic.output_counts)
    end
    return input, output
end


local function collect_electric_statistics(combinator)
    local statistics = {}
    for wire_type, _ in pairs(defines.wire_type) do
        for _, entity in pairs(combinator.circuit_connected_entities[wire_type] or {}) do
            if entity.electric_network_id and entity.prototype.type == "electric-pole" then
                statistics[entity.electric_network_id] = entity.electric_network_statistics
            end
        end
    end
    return statistics
end


local function diff(a,b) return a - (b or a) end
local function is_int32(n) return math.abs(n) <= 2^31 end

local I,O = {type="virtual", name="power-consumption"}, {type="virtual", name="power-production"}
local function update(event)
    local t = settings.global['power-combinator-update-tick'].value
    if event.tick % t > 0 then return end
    local invalid = {}
    for id, state in pairs(global) do
        if not (state.entity and state.entity.valid) then
            table.insert(invalid, id)
        elseif state.tick < event.tick then
            local control = state.entity.get_control_behavior()
            if control.enabled then
                local variance = 60 / (event.tick - state.tick)
                local statistics = collect_electric_statistics(state.entity)
                local input, output = sum_input_output(statistics)
                local  input_diff = diff( input, state. input) * variance
                local output_diff = diff(output, state.output) * variance
                state.input, state.output, state.tick = input,output, event.tick
                if is_int32(input_diff) and is_int32(output_diff) then
                    control.set_signal(1, {signal=I, count= input_diff })
                    control.set_signal(2, {signal=O, count=output_diff })
                end
            end
        end
    end
    for _, id in ipairs(invalid) do global[id] = nil end
end


local function alloc(event)
    local entity = event.created_entity
    if entity.unit_number and entity.prototype.name == "power-combinator" then
        global[entity.unit_number] = {entity=entity, tick=0}
    end
end

local function cleanup(event)
    if event.entity and event.entity.unit_number then
        global[event.entity.unit_number] = nil
    end
end

local function init()
    local keys = {} for k,_ in pairs(global) do keys[k] = k end
    for k,_ in pairs(keys) do global[k] = nil end
    for _, surface in pairs(game.surfaces) do
        for _, combinator in pairs(surface.find_entities_filtered{name="power-combinator"}) do
              alloc{created_entity=combinator}
        end
    end
end

--------------------------------------------------------------------------------

local filters = {{filter = "name", name = "power-combinator"}}

local add_events = {
    defines.events.on_built_entity,
    defines.events.on_robot_built_entity,
}

local remove_events = {
    defines.events.on_entity_died,
    defines.events.on_robot_mined_entity,
    defines.events.on_player_mined_entity,
}

--------------------------------------------------------------------------------

script.on_init(init)
script.on_event(add_events, alloc)
script.on_event(remove_events, cleanup)
script.on_event(defines.events.on_tick, update)

for _,events in ipairs({add_events, remove_events}) do
    for _,event in ipairs(events) do
        script.set_event_filter(event, filters)
    end
end
