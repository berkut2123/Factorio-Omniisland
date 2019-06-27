--[[--
Module for creating and mainting databases with unique id's for objects.

]]
DB = {}

DB.registeredNames = {} --: map<string, bool>

function DB.register(name)
    DB.registeredNames[name] = true
end

function DB._init()
    global["DB"] = {}
    global["DBidCounters"] = {}
    for name, t in pairs(DB.registeredNames) do
        DB.new(name)
    end
    return nil
end
Init.registerFunc(DB._init)

function DB.master()
    return global["DB"]
end

DB.deletedLimit = 1000

-- function DB.NtoZ(x, y)
--     return (x >= 0 and (x * 2) or (-x * 2 - 1)), (y >= 0 and (y * 2) or (-y * 2 - 1))
-- end
-- function DB.cantorPair(x, y)
--     x, y = NtoZ(x, y)
--     return (x + y + 1) * (x + y) / 2 + x
-- end
-- function DB.createKey(pos, entName, tick, id)
--     local xStr = tostring(pos.x); local yStr = tostring(pos.y)
--     local tickStr = tostring(tick)
--     local idStr = tostring(id)
--     return
-- end

function DB.new(name)
    local mas = DB.master()
    if mas[name] ~= nil then
        return mas[name]
    end
    mas[name] = {amtDeleted = 0, nextID = 1, idCache = {}}
    return mas[name]
end

function DB.get(name)
    local mas = DB.master()
    local db = mas[name]
    if not db then
        return nil
    end
    return db
end
DB.getOrCreate = function(name)
    local mas = DB.master()
    local db = mas[name]
    if not db then
        return DB.new(name)
    end
    return db
end

function DB.getAll(name)
    local db = DB.get(name)
    if not db then
        -- inform("warning: database not found. skipping...")
        return {}
    end
    return db.idCache
end
DB.getEntries = DB.getAll

function DB.getHighest(name)
    return DB.get(name).nextID - 1
end
DB.highest = DB.getHighest

function DB.reset(name)
    local mas = DB.master()
    mas[name] = nil
    mas[name] = DB.new(name)
end

function DB.insert(name, obj)
    local db = DB.getOrCreate(name)
    -- if not db then return false end
    -- if (type(obj) == "table") and (obj._type ~= nil) then --(obj._type=="TrackedChest")
    -- end
    -- local existingID = DB.getID(name, obj)
    -- if (existingID ~= nil) then return existingID end
    local ind = db.nextID
    db.nextID = db.nextID + 1

    db.idCache[ind] = obj
    return ind
end

function DB.getObj(name, id)
    local db = DB.get(name)
    if db == nil then
        return nil
    end
    local obj = db.idCache[id]
    if (not obj) or (not obj.destroy) or (not obj.isValid) then
        return nil
    end
    if (not obj:isValid()) then
        obj:destroy()
        return nil
    end
    return obj
end

function DB.getAllObj(name, ids)
    result = {}
    for ind, id in pairs(ids) do
        table.insert(result, DB.getObj(id))
    end
    return result
end

function DB.getID(name, obj)
    local db = DB.get(name)
    if not db then
        return nil
    end
    for id, item in pairs(db.idCache) do
        if (item == obj) then
            return id
        end
    end
    return nil
end

function DB.deleteID(name, id)
    local db = DB.get(name)
    if not db.idCache[id] then
        return nil
    end
    db.idCache[id] = nil
    db.amtDeleted = db.amtDeleted + 1
    if db.amtDeleted > DB.deletedLimit then
        local ver = version.get()
        version.set(ver - 1)
    end
end

DB.idCounter = {}
function DB.idCounter.counters()
    return global["DBidCounters"]
end
function DB.idCounter.new(name)
    if (DB.idCounter.counters()[name] == nil) then
        DB.idCounter.counters()[name] = 1
    end
end
function DB.idCounter.up(name)
    local counters = DB.idCounter.counters()
    if (counters[name] == nil) then
        DB.idCounter.new(name)
    end
    local curID = counters[name]
    counters[name] = curID + 1
    return curID
end
DB.idCounter.next = DB.idCounter.up
function DB.idCounter.last(name)
    return DB.idCounter.counters()[name]
end

return DB
