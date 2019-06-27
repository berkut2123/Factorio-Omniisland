--[[--
Queue for checking newly created entities.
@module createdQ
]]
createdQ = {}

createdQ.waitQTriggers = {}
createdQ.waitQTriggers["heli-placement-entity-_-"] = "heli-entity-_-"

-- createdQ.heliNames = {}
-- createdQ.heliNames.placer = "heli-placement-entity-_-"
-- createdQ.heliNames.ent = "heli-entity-_-"
function createdQ._init()
    global["createdQ"] = {}
    global["createdQ"]["Q"] = Q.new()
    global["createdQ"]["last_tick"] = 0
    global["createdQ"]["isResetting"] = false
    global["createdQ"]["futureQ"] = Q.new()
    global["createdQ"]["waitQ"] = Q.new()
end
Init.registerFunc(createdQ._init)

createdQ._onLoad = Init.registerOnLoadFunc(
function()
    setmetatable(global["createdQ"]["Q"], Q.objMT)
    setmetatable(global["createdQ"]["waitQ"], Q.objMT)
    -- setmetatable(global["createdQ"]["futureQ"], Q.objMT)
end
)

function createdQ.master()
    return global["createdQ"]
end
function createdQ.waitQ()
    return createdQ.master()["waitQ"]
end
function createdQ.get()
    return createdQ.master()["Q"]
end
createdQ.Q = createdQ.get
createdQ.q = createdQ.get
function createdQ.push(obj)
    -- if (isValid(obj)) then
    -- if (obj.surface.name ~= "nauvis") then
    -- createdQ.tick(obj)
    -- else
    return Q.push(createdQ.Q(), obj)
    -- end
    -- end
end
function createdQ.pop()
    return Q.pop(createdQ.Q())
end
function createdQ.size()
    return Q.size(createdQ.Q())
end
function createdQ.getLastTick()
    return createdQ.master()["last_tick"]
end
function createdQ.setLastTick()
    createdQ.master()["last_tick"] = gSets.tick()
end
function createdQ.isResetting()
    return createdQ.master()["isResetting"]
end
function createdQ.startReset()
    createdQ.master()["isResetting"] = true
end
function createdQ.finishReset()
    createdQ.master()["isResetting"] = false
    inform("finished resetting globals.")
end

-- function createdQ.futureQ()
--     return global["createdQ"]["futureQ"]
-- end
-- function createdQ.futureQTick()
--     local futureQ = createdQ.futureQ()
--     local curTick = gSets.tick()
--     for i = 1, futureQ:size() do
--         local inf = futureQ:pop()
--         if (inf.tick <= curTick) then
--             local found = util.allFind(inf.options)
--             for j = 1, #found do
--                 createdQ.push(found[j])
--             end
--         else
--             futureQ:push(inf)
--         end
--     end
-- end
function createdQ.waitQAdd(entName)
    createdQ.waitQ():push({ name = entName, tick = gSets.tick() + 10 })
end

function createdQ.tickWaitQ()
    local waitQ = createdQ.waitQ()
    local size = waitQ:size()
    if size <= 0 then
        return
    end
    for i = 1, size do
        local pop = waitQ:pop()
        if gSets.tick() <= pop.tick then
            local res = util.allFind({ name = pop.name })
            for i = 1, #res do
                local ent = res[i]
                local existingSlots = SL.getSlotsByEnt(ent)
                if (#existingSlots <= 0) then
                    SL.trackAllSlots(ent)
                end
            end
        else
            waitQ:push(pop)
        end
    end
end

function createdQ.tick(cEnt)
    -- createdQ.futureQTick()
    local maxToCheck = gSets.newInvsPerCycle()
    if (cEnt) then
        maxToCheck = 1
        Q.pushleft(createdQ.q(), cEnt)
    end
    local createdQueueSize = createdQ.size()
    if (createdQueueSize < maxToCheck) then
        maxToCheck = createdQueueSize
    end
    -- if (maxToCheck > 0) then
    --     inform("Created Queue: " .. createdQueueSize .. " items remaining.")
    -- end
    if (createdQ.waitQ():size() > 0) then
        createdQ.tickWaitQ()
    end
    for i = 1, maxToCheck do
        local popEnt = createdQ.pop()
        if (isValid(popEnt)) then
            local chestObj = TC.new(popEnt)
            if (not chestObj) then
                SL.trackAllSlots(popEnt)
            end
        end
        -- if (isValid(popEnt)) then
        -- end
    end
    if (createdQ.isResetting()) and (createdQ.size() <= 0) then
        createdQ.finishReset()
    end
end

return createdQ