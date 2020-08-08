Map = {}
Map.objMT = {
    __index = Map
}
-- Map = util.map
Map.new = function(start)
    local obj = start or {}
    return setmetatable(obj, Map.objMT)
end
---Joins multiple tables into a single one, returning a new combined table as the result. Each successive table overwrites any conflicting keys from previous arguments.
---@param ... table
---@return table
function table.join(...)
    local result = {}
    for i, v in pairs({...}) do
        -- local v = ...[i]
        -- if (v) then
        for key, val in pairs(v) do
            result[key] = val
        end
        -- end
    end
    return result
end
Map.join = table.join

---Performs a deep copy on each table given as an argument, then joins them and returns the result as a new table. Each successive table overwrites any conflicting keys from previous arguments.
---@param ... table
---@return table
function table.shallowJoin(t1, t2)
    -- serpLog(arg)
    -- local numArgs = select("#", ...)
    -- local result = table.deepcopy(t1)
    -- for i = 1, numArgs do
    -- local t2Copy = table.deepcopy(t2)
    local result = {}
    for key, val in pairs(t1) do
        result[key] = val
    end
    for key, val in pairs(t2) do
        result[key] = val
    end
    return result
    -- local cur = select(i, ...)
    -- if (type(cur) == "table") then
    --     local copy = table.deepcopy(cur)
    --     for key, val in pairs(cur) do
    --         result[key] = val
    --     end
    -- end
    -- end
    -- return result
    -- for i, v in pairs({...}) do
    --     if (type(v) == "table") then
    --         local copy = table.deepcopy(v)
    --         for key, val in pairs(v) do
    --             result[key] = val
    --         end
    --     end
    -- end
    -- return result
end
Map.shallowJoin = table.shallowJoin
Map.any = function(self)
    for k, v in pairs(self) do
        return v
    end
end
Map.anyVal = Map.any
Map.anyKey = function(self)
    for k, v in pairs(self) do
        return k
    end
end
Map.size = function(self)
    local count = 0
    for k, v in pairs(self) do
        count = count + 1
    end
    return count
end
Map.contains = function(self, val)
    for k, v in pairs(self) do
        if v == val then
            return true
        end
    end
    return false
end
Map.containsValue = Map.contains
table.containsValue = Map.contains

Map.copy = function(self)
    local new = {}
    for k, v in pairs(self) do
        new[k] = v
    end
    return new
end

function Map._deepcopy(o, tables)
    if type(o) ~= "table" then
        return o
    end

    if tables[o] ~= nil then
        return tables[o]
    end

    local new_o = {}
    tables[o] = new_o

    for k, v in next, o, nil do
        local new_k = Map._deepcopy(k, tables)
        local new_v = Map._deepcopy(v, tables)
        new_o[new_k] = new_v
    end

    return new_o
end

function Map.deepcopy(o)
    return Map._deepcopy(o, {})
end

function Map.keys(o)
    local keys = {}
    for key, val in pairs(o) do
        table.insert(keys, key)
    end
    return keys
end

function Map.values(o)
    local vals = {}
    for key, val in pairs(o) do
        table.insert(vals, val)
    end
    return vals
end

-- Map.containsKey = function(self, key)
--     for k, v in pairs(self) do
--         if v == val then
--             return true
--         end
--     end
--     return false
-- end
return Map
