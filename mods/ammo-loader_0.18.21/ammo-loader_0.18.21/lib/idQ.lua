---idQ class module. An idQ is a queue designed for use specifically with dbObjects.
---@class idQ
idQ = {}
idQ.objMT = {__index = idQ}

---Create new idQ
---@param dbName string
---@param unique boolean
---@return idQ
function idQ.new(dbName, unique)
    if (not DB.getDB(dbName)) then
        error("idQ: invalid database name.")
    end

    ---@type idQ
    local q = {first = 0, last = -1}
    setmetatable(q, idQ.objMT)

    q.entries = {}
    q.dbName = dbName
    if (unique) then
        q.idHash = {}
        q.removeHash = {}
    end
    return q
end

--- @param unique boolean
function idQ.newSlotQ(unique)
    return idQ.new(SL.dbName, unique)
end

--- @param unique boolean

function idQ.newChestQ(unique)
    return idQ.new(TC.dbName, unique)
end

--- @param unique boolean

function idQ.newInserterQ(unique)
    return idQ.new(HI.dbName, unique)
end

---Create idQ using an existing array.
---@param dbName string
---@param unique boolean
function idQ.fromArray(array, dbName, unique)
    local q = idQ.new(dbName, unique)
    for i = 1, #array do
        local obj = array[i]
        q:push(obj)
    end
    return q
end

---Reset the idQ.
function idQ:clear()
    self.first = 0
    self.last = -1
    self.entries = {}
    self.list = self.entries
end

---Add an object to the end of the idQ. Must be a valid dbObject (not an id), and must be of the same Class as the idQ.
function idQ:push(value, left)
    if (not value) or (not value.ent) or (not value.ent.valid) or (value.dbName ~= self.dbName) then
        return nil
    end
    local id = value.id
    local hash = self.idHash
    if (hash) then
        if (self.removeHash[id]) then
            self.removeHash[id] = nil
            -- self.removeHashSize = self.removeHashSize - 1
            self.idHash[id] = true
            return
        end
        if (hash[id]) then
            return
        end
        hash[id] = true
    end
    if (not left) then
        self.last = self.last + 1
        self.entries[self.last] = id
    else
        self.first = self.first - 1
        self.entries[self.first] = id
    end
end

---Add an object to the front of the idQ. Must be a valid dbObject (not an id), and must be of the same Class as the idQ.
function idQ:pushleft(value)
    return self:push(value, true)
end

---Get the next object in the idQ. The object is removed from the idQ in the process.
function idQ:pop(ignoreValidCheck)
    local list = self.entries
    -- iterCount = iterCount or 0
    if (self.first > self.last) then
        return nil
    end
    -- iterCount = iterCount + 1
    local value = list[self.first]
    list[self.first] = nil -- to allow garbage collection
    self.first = self.first + 1
    if (not value) then
        return idQ.pop(self)
    end
    if (self.idHash) then
        self.idHash[value] = nil
        if (self.removeHash[value]) then
            self.removeHash[value] = nil
            -- self.removeHashSize = self.removeHashSize - 1
            return self:pop()
        end
    end
    local obj = DB.getObj(self.dbName, value, ignoreValidCheck)
    if (not obj) then
        if (self.idHash) then
            self.idHash[value] = nil
            if (self.removeHash[value]) then
                self.removeHash[value] = nil
            -- self.removeHashSize = self.removeHashSize - 1
            end
        end
        return idQ.pop(self)
    end
    return obj
end

---Get the next object in the idQ and push it back into the idQ.
function idQ:cycle(ignoreValidCheck)
    -- if not iterCount then
    -- iterCount = 0
    -- end
    local val = idQ.pop(self, ignoreValidCheck)
    if (not val) then
        return
    end
    idQ.push(self, val)
    return val
end

---Check for the existance of an object in the idQ.
function idQ:contains(obj)
    if (not obj) or (obj.dbName ~= self.dbName) then
        return false
    end
    if (self.idHash) then
        if (not self.idHash[obj.id]) then
            return false
        end
        return true
    end
    for ind, val in pairs(self.entries) do
        if (val == obj.id) then
            return true
        end
    end
    return false
    -- local size = (self.last - self.first) + 1
    -- local cur, iterCount = self:cycle()
    -- while (cur) and (iterCount <= size) do
    --     if cur.id == obj.id then
    --         return true
    --     end
    --     cur, iterCount = self:cycle(iterCount)
    -- end
    -- return false
    -- local last = self.last
    -- while (self.first <= last) do
    --     last = last - 1
    --     local cur = self:cycle()
    --     if not cur then
    --         return false
    --     end
    --     if cur.id == obj.id then
    --         return true
    --     end
    -- end
    -- return false
end

---Remove all occurences of an object from the idQ.
function idQ:remove(obj)
    if (not obj) or (obj.dbName ~= self.dbName) then
        return false
    end
    local rm = 0
    local i = 0
    local size = self:size()
    while (i < size) do
        i = i + 1
        local cur = self:pop()
        if cur.id ~= obj.id then
            self:push(cur)
        else
            rm = rm + 1
        end
        size = self:size()
    end
    -- local last = self.last
    -- local first = self.first
    -- local cur, iterCount = self:pop()
    -- while (cur) and (iterCount <= size) do
    --     if cur.id ~= obj.id then
    --         self:push(cur)
    --     else
    --         rm = rm + 1
    --     end
    --     cur, iterCount = self:pop(iterCount)
    --     -- first = self.first
    -- end
    return (rm > 0), rm
end

function idQ:removeID(id)
    if (not id) then
        return false
    end
    local rm = 0
    local i = 0
    local size = self:size()
    while (i < size) do
        i = i + 1
        local cur = self:pop()
        if id ~= cur.id then
            self:push(cur)
        else
            rm = rm + 1
        end
        size = self:size()
    end
    return (rm > 0), rm
end

function idQ:softRemove(obj)
    if (not obj) then
        return false
    end
    if (self.idHash) then
        if (self.idHash[obj.id]) then
            if (not self.removeHash[obj.id]) then
                self.removeHash[obj.id] = true
            -- self.removeHashSize = self.removeHashSize + 1
            end
            self.idHash[obj.id] = nil
            return true
        end
    end
    return false
end

function idQ:size()
    -- local rmAmt = self.removeHashSize or 0
    local size = (self.last - self.first) + 1
    if (size < 0) then
        size = 0
    end
    return size
end

function idQ:isEmpty()
    -- local rmAmt = self.removeHashSize or 0
    local size = self:size()
    -- cInform(size)
    if (size <= 0) then
        return true
    end
    return false
    -- return ((self.last - self.first + 1 - rmAmt) <= 0)
end

---Get iterator for the idQ
function idQ:iter(limit, pop, ignoreValidCheck)
    local size = self:size()
    limit = limit or size
    if (size < limit) then
        limit = size
    end
    local i = 0
    local function func()
        i = i + 1
        if (i > limit) or (i > self:size()) then
            return
        end
        if (pop) then
            local cur = self:pop(ignoreValidCheck)
            -- iterCount = newCount
            return cur
        else
            local cur = self:cycle(ignoreValidCheck)
            -- iterCount = newCount
            return cur
        end
    end
    return func
end

---@param limit number
---@param pop boolean
---@return fun():Slot
function idQ:slotIter(limit, pop, ignoreValidCheck)
    return self:iter(limit, pop, ignoreValidCheck)
end

---@param limit number
---@param pop boolean
---@return fun():Chest
function idQ:chestIter(limit, pop, ignoreValidCheck)
    return self:iter(limit, pop, ignoreValidCheck)
end

---@param limit number
---@param pop boolean
---@return fun():HiddenInserter
function idQ:inserterIter(limit, pop, ignoreValidCheck)
    return self:iter(limit, pop, ignoreValidCheck)
end

---@return idQ
function idQ:copy()
    local res = idQ.new(self.dbName, (self.idHash ~= nil))
    if (self.idHash) then
        res.idHash = Map.deepcopy(self.idHash)
        res.removeHash = Map.deepcopy(self.removeHash)
    -- res.removeHashSize = self.removeHashSize
    end
    res.first = self.first
    res.last = self.last
    res.entries = Map.deepcopy(self.entries)
    return res
end

return idQ
