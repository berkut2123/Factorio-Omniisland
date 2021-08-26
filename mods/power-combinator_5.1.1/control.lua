local I,O,F,C,P = unpack{
    {type="virtual", name="power-consumption"},
    {type="virtual", name="power-production"},
    {type="virtual", name="power-factor"},
    {type="virtual", name="power-max-consumption"},
    {type="virtual", name="power-max-production"},
}
local INT32_MAX = 2^31
local DEFAULT_F = {signal=F, count=3, index=1}
local DEFAULTS  = {
    DEFAULT_F,
    {signal=I, count=0, index=2},
    {signal=O, count=0, index=3},
    {signal=C, count=0, index=4},
    {signal=P, count=0, index=5},
}

local IDX = 6 -- index of filter signal
local MK1 = "power-combinator"
local MK2 = "power-combinator-MK2"
local MK = {[MK1]=true,[MK2]=true}

--------------------------------------------------------------------------------

local function diff(a,b) return a - (b or a) end
local function is_int32(n) return math.abs(n) <= INT32_MAX end

local PRECISION_INDEX = defines.flow_precision_index.one_second   -- factorio <  1.1.25
                     or defines.flow_precision_index.five_seconds -- factorio >= 1.1.25
local PRECISION = 8
local function floor(x) return math.floor(x * 10^PRECISION) * 10^-PRECISION end
local function ceil(x) return math.ceil(floor(x)) end -- head → ceiling → table edge

local function add(a,b,c,d,e,f) return a+d,b+e,c+f end

--------------------------------------------------------------------------------

local function max_consumption(name)
    if name == 'power-combinator-meter-satisfaction' then return 0 end -- remove meter lamp from max consumption
    local prototype = game.entity_prototypes[name] or {}
    local source = prototype.electric_energy_source_prototype or {}
    local usage  = prototype.max_energy_usage or 0
    local drain  = source.drain or 0
    return usage + drain
end

local function max_production(name)
    local  prototype = game.entity_prototypes[name]
    return prototype and prototype.max_energy_production or 0
end

local function statistic_value(statistic, name, input)
    return statistic.get_flow_count{
        precision_index = PRECISION_INDEX,
        input = input,
        count = true,
        name  = name,
    }
end

local function sum_stats(statistic, input, filter)
    local sum,maxs,counts = 0,0,0
    local f      = input and max_consumption or max_production
    local values = input and statistic.input_counts or statistic.output_counts
    if filter then values = {[filter]=values[filter]} end
    for name,value in pairs(values) do
        local count = statistic_value(statistic, name, input)
        counts = counts + count
        maxs = maxs + count * f(name)
        sum  = sum  + value
    end
    return sum, maxs, counts
end

local function calculate_values(statistics,satisfaction, filter)
    local sat, input, output, maxin, maxout, count = 0, 0, 0, 0, 0, 0
    for electric_network_id, statistic in pairs(statistics) do
        if satisfaction[electric_network_id] then
            sat = sat + satisfaction[electric_network_id]
             input, maxin , count = add( input, maxin , count, sum_stats(statistic, true , filter))
            output, maxout, count = add(output, maxout, count, sum_stats(statistic, false, filter))
        end
    end
    local f = sat == 0 and 0 or (1 / sat)
    return f, input, output, maxin, maxout, count
end

local function collect_electric_statistics(net,sat, filter)
    local statistics,satisfaction = {},{}
    if net and net.electric_network_id then
        statistics[net.electric_network_id] = net.electric_network_statistics
    end
    if sat and sat.electric_network_id and sat.electric_buffer_size and sat.electric_buffer_size > 0 then
        satisfaction[sat.electric_network_id] = sat.energy / sat.electric_buffer_size
    end
    return calculate_values(statistics,satisfaction, filter)
end

--------------------------------------------------------------------------------

local function find_entities(entity, name)
    return entity.surface.find_entities_filtered{name=name, position=entity.position}
end

local function find_single_entity(parent, name)
    local result
    for i,entity in pairs(find_entities(parent, name)) do
        if i == 1 then result = entity else entity.destroy() end
    end
    return result
end

local function create_hidden_entity(surface, options)
    local entity = surface.create_entity(options)
    entity.destructible = false
    entity.minable = false
    return entity
end

local function default_entity(parent, name)
    return find_single_entity(parent, name)
        or create_hidden_entity(parent.surface, {
               name = name,
               position = parent.position,
               force = parent.force,
           })
end

local function same_signal(a,b)
    return a.type == b.type and a.name == b.name
end

local function default_signal(control, default)
    local a,b = control.get_signal(default.index),default
    if a and a.signal and same_signal(a.signal, b.signal) then return a end
    control.set_signal(default.index, default)
    return default
end

local function connect_wires(a,b)
    for _,color in ipairs{'red','green'} do
        local wire = defines.wire_type[color]
        if not a.get_circuit_network(wire) then
            a.connect_neighbour{target_entity=b, wire=wire}
        end
    end
end

local function toggle_light(state, value)
    local circuit = state.light.circuit_condition
    if circuit.fullfilled == value then return end
    local condition = circuit.condition
    condition.constant = value and 0 or 1
    state.light.circuit_condition = circuit
end

local function has_energy(entity) -- prototype
    return (entity.max_energy_usage      or 0) > 0
        or (entity.max_energy_production or 0) > 0
end

local function get_filter(control)
    if control.signals_count < IDX then return end -- not for MK1
    local filter = control.get_signal(IDX)
    if filter and filter.signal and filter.signal.type == "item" then
        local item = game.item_prototypes[filter.signal.name]
        local entity = item and item.place_result
        if entity and has_energy(entity) then
            return entity.name
        end
    end
    return "?" -- nothing to see
end

--------------------------------------------------------------------------------

local function State(entity)
    local state = {entity=entity, tick=game.tick}
    state.net = default_entity(entity, 'power-combinator-meter-network')
    state.sat = default_entity(entity, 'power-combinator-meter-satisfaction')
    if state.net and state.sat then connect_wires(state.sat, state.net) end
    state.control = entity.get_or_create_control_behavior()
    local parameters = {unpack(DEFAULTS)}
    parameters[DEFAULT_F.index] = default_signal(state.control, DEFAULT_F)       -- remember factor
    parameters[DEFAULT_F.index].index = DEFAULT_F.index
    if state.control.signals_count == IDX then
        parameters[IDX] = state.control.get_signal(IDX)                          -- remember filter
        parameters[IDX].count = 0 -- but clear value
        parameters[IDX].index = IDX
    end
    state.control.parameters = parameters -- clears all signals
    state.light = state.sat.get_or_create_control_behavior()
    state.light.circuit_condition = {condition={
        comparator = "=",
        first_signal = F,
        constant = 1, -- 0 means on and 1 means off
    }}
    return state
end

local function write(state, tick)
    connect_wires(state.sat, state.net)
    local control = state.control
    if not control.enabled then return toggle_light(state, false) end
    local signal = default_signal(control, DEFAULT_F)
    local filter = get_filter(control)
    local scale = 10 ^ -signal.count
    local variance = 60 / (tick - state.tick)
    local f, input, output, maxin, maxout, count = collect_electric_statistics(state.net,state.sat, filter)
    local  input_diff = (diff( input, state. input) * variance * f) * scale
    local output_diff =  diff(output, state.output) * variance      * scale
    state.input, state.output, state.tick = input, output, tick
    maxin, maxout = ceil(maxin * 60 * scale), ceil(maxout * 60 * scale)
    input_diff, output_diff = ceil(input_diff),ceil(output_diff)
    local enabled = (filter ~= "?") and is_int32(input_diff) and is_int32(output_diff) and is_int32(maxin) and is_int32(maxout)
    if not enabled then
        input_diff,output_diff,maxin,maxout = 0, 0, 0, 0 -- don't show anything
    end
    toggle_light(state, enabled)
    control.set_signal(2, {signal=I, count= input_diff})
    control.set_signal(3, {signal=O, count=output_diff})
    control.set_signal(4, {signal=C, count=maxin })
    control.set_signal(5, {signal=P, count=maxout})
    if control.signals_count == IDX then -- not for MK1
        local filter = control.get_signal(6)
        if filter and filter.signal then
            filter.count = count
            control.set_signal(6, filter)
        end
    end
end

--------------------------------------------------------------------------------

local function alloc(entity)
    if entity and entity.unit_number and MK[entity.prototype.name] then
        global.state[entity.unit_number] = State(entity)
        script.register_on_entity_destroyed(entity)
    end
end

local function cleanup(entity)
    if entity and entity.unit_number then
        local state = global.state[entity.unit_number]
        if state then
            if state.net and state.net.valid then state.net.destroy() end
            if state.sat and state.sat.valid then state.sat.destroy() end
            global.state[entity.unit_number] = nil
            state.net = nil
            state.sat = nil
        end
    end
end

local function update(tick)
    local t = settings.global['power-combinator-update-tick'].value
    if tick % t > 0 then return end
    local invalid = {}
    for id, state in pairs(global.state) do
        if not (state.entity and state.entity.valid) then
            table.insert(invalid, id)
        elseif state.tick < tick then
            write(state, tick)
        end
    end
    for _, id in ipairs(invalid) do cleanup{unit_number=id} end
end

local function init()
    global.state = {}
    for _, surface in pairs(game.surfaces) do
        for _, combinator in pairs(surface.find_entities_filtered{name={MK1,MK2}}) do
            alloc(combinator)
        end
    end
end

--------------------------------------------------------------------------------

local filters = {
    {filter = "name", name = MK1},
    {filter = "name", name = MK2},
}

local events = {
    entity = {
        added = {
            defines.events.on_built_entity,
            defines.events.script_raised_built,
            defines.events.script_raised_revive,
            defines.events.on_robot_built_entity,
        },
        removed = {
            defines.events.register_on_entity_destroyed,
        },
    },
}

--------------------------------------------------------------------------------

script.on_init(init)
script.on_configuration_changed(init)

script.on_event(events.entity.added, function (event)
    alloc(event.created_entity or event.entity)
end)
script.on_event(events.entity.removed, function (event)
    cleanup(event)
end)
script.on_event(defines.events.on_tick, function (event)
    update(event.tick)
end)

for _,event in ipairs(events.entity.added) do
    script.set_event_filter(event, filters)
end
