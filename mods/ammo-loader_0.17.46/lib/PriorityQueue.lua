--[[--
PriorityQueue: stores entries in order based on an arbitrary value.
@classmod PQ
@alias PriorityQueue
]]
local PQ = {}
local PriorityQueue = PQ

PQ.objMT = {}
PQ.objMT.__index = PQ
--     function(table, key)
--     if table[key] ~= nil then
--         return table[key]
--     elseif PQ.properties[key] ~= nil then
--         return PQ.properties[key](table)
--     elseif PQ[key] ~= nil then
--         return setmetatable(
--             {k = key, t = table},
--             {
--                 __call = function(temp, ...)
--                     return PQ[temp.k](temp.t, ...)
--                 end
--             }
--         )
--     end
--     return nil
-- end
function PQ.new()
    local obj = {}
    setmetatable(obj, PQ.objMT)
    obj.priorities = {}
    obj.priors = obj.priorities
    obj.highest = nil
    obj._size = 0
    obj._numPriorities = 0
    return obj
end
-- PQ.properties = {}
-- PQ.properties.priors = function(self)
--     return self.priorities
-- end
function PQ.clear(self)
    self.priorities = nil
    self.priorities = {}
    self.priors = self.priorities
    self.highest = nil
    self._size = 0
    self._numPriorities = 0
end
function PQ.push(self, val, priority)
    if not val then
        error("PriorityQueue cannot push nil")
    end
    local q = self.priors[priority]
    if not q then
        q = Q.new()
        self.priors[priority] = q
        if (not self.highest) or (self.highest < priority) then
            self.highest = priority
        end
        self._numPriorities = self._numPriorities + 1
    end
    Q.push(q, val)
    self._size = self._size + 1
end
function PQ.pop(self)
    if (not self.highest) then
        return nil
    end
    local q = self.priors[self.highest]
    local val = Q.pop(q)
    local popPriority = self.highest
    if (Q.size(q) <= 0) then
        self.priors[self.highest] = nil
        self.highest = nil
        self._numPriorities = self._numPriorities - 1
        for priority, curQ in pairs(self.priors) do
            if (not self.highest) or (self.highest < priority) then
                self.highest = priority
            end
        end
    end
    self._size = self._size - 1
    return val, popPriority
end
function PQ.size(self)
    return self._size
end
function PQ.numPriorities(self)
    return self._numPriorities
end

return PriorityQueue
