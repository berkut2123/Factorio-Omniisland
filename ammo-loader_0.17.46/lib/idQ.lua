--[[--
Queue that automatically converts from id to object.
@classmod idQ
@alias idQueue
]]
-- require("lib/Queue")

idQ = {}

idQ.objMT = {
    __index = idQ
}

function idQ.new(c, unique)
    if (not c.isValid) or (not c.dbName) or (not c.getObj) then
        error("idQ: invalid class argument.")
    end
    local q = {first = 0, last = -1}
    setmetatable(q, idQ.objMT)
    q.entries = {}
    q.dbName = c.dbName
    if (unique) then
        q.idHash = {}
    end
    -- q.class
    -- q._getObj = class.getObj
    -- q.isValid = class.isValid
    return q
end

function idQ.getObj(self, id)
    return DB.getObj(self.dbName, id)
    -- return self._getObj(id)
end

function idQ.clear(self)
    self.first = 0
    self.last = -1
    self.entries = {}
    self.list = self.entries
end

function idQ.pushright(self, value)
    if (not value) then
        return nil
    end
    if (value.id == nil) then
        error("idQ: value has no id field")
    end
    local id = value.id
    local hash = self.idHash
    if (hash) then
        if (hash[id]) then
            return
        end
        hash[id] = true
    end
    self.last = self.last + 1
    self.entries[self.last] = id
end
idQ.push = idQ.pushright

function idQ.pushleft(self, value)
    if (not value) then
        return nil
    end
    if (not value.id) then
        error("idQ: value has no id field")
    end
    local id = value.id
    local hash = self.idHash
    if (hash) then
        if (hash[id]) then
            return
        end
        hash[id] = true
    end
    local list = self.entries
    self.first = self.first - 1
    list[self.first] = id
end

function idQ.popleft(self)
    local list = self.entries
    if idQ.size(self) <= 0 then
        return nil
    end
    local value = list[self.first]
    list[self.first] = nil -- to allow garbage collection
    self.first = self.first + 1
    if (self.idHash) then
        self.idHash[value] = nil
    end
    local obj = self:getObj(value)
    -- if (not obj) or (not isValid(obj.ent)) then return idQ.popleft(self) end
    if (not obj) then
        return idQ.popleft(self)
    end
    -- if ()
    return obj
end
idQ.pop = idQ.popleft

function idQ.cycle(self)
    local val = idQ.pop(self)
    if not val then
        return nil
    end
    idQ.push(self, val)
    return val
end

function idQ.contains(self, obj)
    if (not obj) then
        return false
    end
    if (self.idHash) then
        return self.idHash[obj.id]
    end
    local s = self:size()
    for i = 1, s do
        local cur = self:cycle()
        if not cur then
            return false
        end
        if cur.id == obj.id then
            return true
        end
    end
    return false
end

function idQ.remove(self, obj)
    if (not obj) then
        return false
    end
    local s = self:size()
    local rm = 0
    for i = 1, s do
        local cur = self:pop()
        if not cur then
            return false
        end
        if cur.id ~= obj.id then
            self:push(cur)
        else
            rm = rm + 1
        end
    end
    if (rm > 0) then
        return true
    end
    return false
end

function idQ.size(self)
    return (self.last - self.first) + 1
end

function idQ.isEmpty(self)
    return (idQ.size(self) <= 0)
end

function idQ.forEach(self, func, limit, cycle)
    local size = self:size()
    if (size <= 0) then
        return
    end
    -- inform("qSize: " .. tostring(size))
    local lim = limit or size
    if (size < lim) then
        lim = size
    end
    for i = 1, lim do
        local cur = self:pop()
        if cur ~= nil then
            func(cur)
            if (cycle) then
                self:push(cur)
            end
        end
    end
end

return idQ
