--[[--
Module containing many utility functions.
@module util
]]
util = {}
util.Map = Map
util.Array = Array

--[[--
Game Utilities
@section Game
]]
--- Checks any game object for valididty.
-- Will not throw an error if passed nil.
-- @param gameObj The factorio game object to check.
-- @treturn bool value
-- @function isValid
function util.isValid(gameObj)
    -- cInform(debug.traceback())
    if (not gameObj) or (not gameObj.valid) then
        return false
    end
    return true
end
isValid = util.isValid

function util.compare(x, y)
    local res = 0
    if (x < y) then
        res = -1
    elseif (x > y) then
        res = 1
    else
        res = 0
    end
    if (type(x) == "string") then
        res = res * -1
    end
    return res
end

--- Print to console if debugging is enabled.
-- @param s String to print
-- @param forceShow If true, print even when debugging is off. Defaults to false.
-- @return nil
-- @function inform
function util.inform(s, forceShow)
    if (not game) then
        -- error("called inform when game was invalid:\n" .. debug.traceback())
        return nil
    end
    local debug = true
    if (gSets) and (gSets.cache()) then
        debug = gSets.debug()
    end
    if (not debug) and (not forceShow) then
        return false
    end
    local str = s
    if type(s) ~= "string" then
        if (type(s) == "table") then
            str = util.table.tostring(s)
        else
            str = tostring(s)
        end
    end
    game.print("[Ammo-Loader]:> " .. str)
end
inform = util.inform

function util.cInform(...)
    -- local numArgs = select("#", ...)
    -- local forceShow = select(numArgs, ...)
    -- local otherArgs = select(-1 * numArgs + 1, ...)
    if (not gSets.debugging()) then
        return nil
    end
    return util.inform(util.string.concat(...))
end
cInform = util.cInform

function util.ctInform(...)
    return util.inform(util.string.concat(...), true)
end
ctInform = util.ctInform

--- Alias for game.surfaces.nauvis.find_entities_filtered
-- @param options Options to use, as a table.
-- @return List of entities.
-- @function nauvisFind
function util.nauvisFind(options)
    local res = game.surfaces.nauvis.find_entities_filtered(options)
    return res
end
util.nFind = util.nauvisFind

--- Find entities on all surfaces.
-- @param options Options to use.
-- @return List of entities.
-- @function allFind
function util.allFind(options)
    local results = {}
    for id, surf in pairs(game.surfaces) do
        local find = surf.find_entities_filtered(options)
        Array.append(results, find)
    end
    return results
end

-- function util.multiFind(const, multis)
--     local queries = {}
--     queries[1] = const
--     for name, opts in pairs(multis) do
--         local optQueries = {}
--         for j = 1, #opts do
--             local opt = opts[j]
--             for i = 1, #queries do
--                 local query = queries[i]
--                 local copy = util.table.shallowCopy(query)
--                 copy[name] = opt
--                 optQueries[#optQueries + 1] = copy
--             end
--         end
--         queries = optQueries
--     end
--     local res = {}
--     for i = 1, #queries do
--         local query = queries[i]
--         Array.append(res, util.allFind(query))
--     end
--     return res
-- end

function util.filterEnts(ents, conditions)
    local res = ents
    for optName, opts in pairs(conditions) do
        local matches = {}
        for k, opt in pairs(opts) do
            for i, ent in pairs(res) do
                if (ent[optName] == opt) then
                    matches[#matches + 1] = ent
                end
            end
        end
        res = matches
    end
    return res
end

function util.multiFind(const, multis)
    local res = util.allFind(const)
    -- for optName, opts in pairs(multis) do
    --     local matches = {}
    --     for k, opt in pairs(opts) do
    --         for i, ent in pairs(res) do
    --             if (ent[optName] == opt) then
    --                 matches[#matches + 1] = ent
    --             end
    --         end
    --     end
    --     res = matches
    -- end
    return util.filterEnts(res, multis)
end

--- Destroy all entities with a given name.
-- @param name Prototype name of entity
-- @return nil
function util.destroyAll(name)
    local found = util.allFind({name = name})
    for i = 1, #found do
        found[i].destroy()
    end
end

util.iterator = {}

function util.iterator.new(iterClass, options, secondary)
    if not iterClass then
        error("util.iterator: no class given.")
    end
    local iter = {
        className = iterClass.className,
        id = DB.highest(iterClass.className)
    }
    local opts = options
    local id = options.id
    if (id) then
        iter.selfID = id
        opts = secondary
        local obj = options
        iter.force = obj:forceName()
        if (obj.isInRange) then
            iter.area = obj.area
        else
            iter.position = obj:position()
        end
        iter.category = obj:category()
    -- iter.storage = false
    end
    if (opts) then
        for k, v in pairs(opts) do
            iter[k] = v
        end
    end
    setmetatable(iter, util.iterator.objMT)
    return iter
end

function util.iterator.iter(self)
    return util.iterator.next, self, nil
end
-- iter = util.iterator.iter
function util.iterator.next(self)
    -- local force = self.force
    -- local pos = self.position
    -- local area = self.area
    -- local cat = self.category
    -- local storage = self.storage
    -- local item = self.item
    while (self.id > 0) do
        local skip = false
        -- inform("iter: id #" .. tostring(self.id))
        local cur = DB.getObj(self.className, self.id)
        self.id = self.id - 1
        if (not cur) then
            -- inform("iter: exit 1")
            skip = true
        elseif (self.force) and (cur:forceName() ~= self.force) then
            -- elseif (cur.isStorage) and (not self.storage) then
            -- inform("iter: exit 3")
            -- skip = true
            -- inform("iter: exit 2")
            skip = true
        elseif (self.item) and (cur:filterItem()) and (cur:filterItem() ~= self.item) then
            -- inform("iter: exit 4")
            skip = true
        elseif (self.area) and (not Area.inside(self.area, cur:position())) then
            -- elseif (pos) and (cur.area) and (not Area.inside(cur.area, pos)) then
            --     skip = true
            -- inform("iter: exit 5")
            skip = true
        elseif (self.position) and (not cur:isInRange(self.position)) then
            -- inform("iter: exit 6")
            skip = true
        elseif (self.category) and (self.category ~= cur:category()) then
            -- if (not self.storage) or (not cur.isStorage) then
            -- inform("iter: exit 7")
            skip = true
        -- end
        end
        if not skip then
            return cur
        end
    end
    return nil
end
-- iterNext = util.iterator.next
util.iterator._mt = {
    __index = util.iterator
}
util.iterator.objMT = util.iterator._mt

function util.perimeter(area)
    local xHigh = area.right_bottom.x
    local xLow = area.left_top.x
    local yLow = area.left_top.y
    local yHigh = area.right_bottom.y
    -- local anchors = {1=}
    local sides = {
        {x = {value = xLow}, y = {low = yLow, high = yHigh}},
        {x = {value = xHigh}, y = {low = yLow, high = yHigh}},
        {x = {low = xLow, high = xHigh}, y = {value = yLow}},
        {x = {low = xLow, high = xHigh}, y = {value = yHigh}}
    }
    -- inform("xHigh: " .. tostring(xHigh) .. ", xLow: " .. tostring(xLow) .. ", yHigh: " .. tostring(yHigh) .. ", yLow: " .. tostring(yLow))
    -- local xRange = xHigh
    local res = {}
    local count = 0

    for sideNum = 1, 4 do
        local side = sides[sideNum]
        if (side.x.value) then
            local x = side.x.value
            for y = side.y.low, side.y.high do
                count = count + 1
                res[count] = {x = x, y = y}
            end
        elseif (side.y.value) then
            local y = side.y.value
            for x = side.x.low, side.x.high do
                count = count + 1
                res[count] = {x = x, y = y}
            end
        end
    end

    -- for i = xLow, xHigh do
    --     for j = yLow, yHigh do
    --         count = count + 1
    --         res[count] = {x = i, y = j}
    --     end
    -- end
    return res, count

    -- local iter = {
    --     xHigh = area.right_bottom.x,
    --     xLow = area.left_top.x,
    --     yHigh = area.left_top.y,
    --     yLow = area.right_bottom.y,
    -- }
    -- function iter.iterate(self)
    --     local
    --     local curPos = self.curPos
    --     local curX = curPos.x
    --     local curY = curPos.y
    --     if (curY > self.yLow) then
    --         curPos.y = curPos.y - 1
    --     elseif (curX < self.xHigh) then
    --         curPos.x
    --     end
    --     if (self.curX <)
    -- end
    -- return iterator.iterate, iter, 0
end

function util.isInRange(slot, chest)
    if (not chest.area) then
        return true
    end
    local surfName = chest:surfaceName()
    if (slot:surfaceName() == surfName) and (Area.inside(chest.area, slot:position())) then
        return true
    end
    return false
end

--[[--
Table Utilities.
@section Table
]]
util.table = {}

function util.table.shallowCopy(tab)
    local new = {}
    for key, val in pairs(tab) do
        new[key] = val
    end
    return new
end

---
-- @function val_to_str
-- function util.table.val_to_str(v)
--     if "string" == type(v) then
--         v = string.gsub(v, "\n", "\\n")
--         if string.match(string.gsub(v, '[^'"]', ""), '^"+$') then
--             return "'" .. v .. "'"
--         end
--         return '"' .. string.gsub(v, '"', '\\"') .. '"'
--     else
--         return "table" == type(v) and util.table.tostring(v) or tostring(v)
--     end
-- end
---
-- @function key_to_str
function util.table.key_to_str(k)
    if "string" == type(k) and string.match(k, "^[_%a][_%a%d]*$") then
        return k
    else
        return "[" .. util.table.val_to_str(k) .. "]"
    end
end

---
-- @function tostring
function util.table.tostring(tbl)
    local result, done = {}, {}
    for k, v in ipairs(tbl) do
        table.insert(result, util.table.val_to_str(v))
        done[k] = true
    end
    for k, v in pairs(tbl) do
        if not done[k] then
            table.insert(result, util.table.key_to_str(k) .. " = " .. util.table.val_to_str(v))
        end
    end
    return " { " .. table.concat(result, ", ") .. " } "
end

---
-- @function clear
function util.table.clear(t)
    for k, v in pairs(t) do
        t[k] = nil
    end
    return t
end
table.clear = util.table.clear

---
-- @function anyTableItem
function util.table.anyTableItem(t)
    -- for k, v in pairs(t) do
    --     return v
    -- end
    return Moses.select(
        t,
        function()
            return true
        end
    )
end

---
-- @function combineTables
function util.table.combineTables(tList)
    local result = {}
    for k, v in pairs(tList) do
        for k2, v2 in pairs(v) do
            if (tonumber(k2) ~= nil) then
                table.insert(result, v2)
            end
        end
    end
    return result
end

---
-- @function combine
function util.table.combine(args)
    local result = {}
    for ind, arg in pairs(args) do
        for key, val in pairs(arg) do
            result[#result + 1] = val
        end
    end
    return result
end
table.combine = util.table.combine

---
-- @function combineValues
function util.table.combineValues(args)
    local newResult = {}
    for i = 1, #args do
        local curTable = args[i]
        for key, val in pairs(curTable) do
            newResult[#newResult + 1] = val
        end
    end
    return newResult
end
table.combineValues = util.table.combineValues

---
-- @function isEmpty
function util.table.isEmpty(t)
    if (t == nil) then
        return true
    end
    for k, v in pairs(t) do
        if (v ~= nil) then
            return false
        end
    end
    return true
end
table.isEmpty = util.table.isEmpty

---
-- @function contains
function util.table.contains(t, val)
    for k, v in pairs(t) do
        if (v == val) then
            return true
        end
    end
    return false
end
util.table.containsValue = util.table.contains
table.contains = util.table.contains

---
-- @function size
function util.table.size(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

--- String Utilities
-- @section string
util.string = {}

function util.string.concat(...)
    local fin = ""
    for i = 1, select("#", ...) do
        fin = fin .. tostring(select(i, ...))
    end
    return fin
end
concat = util.string.concat

--- Check for presence of pattern in a string.
-- Uses str-find(test).
-- @param str String to be tested
-- @param test Pattern to use
-- @return bool
-- @function contains
function util.string.contains(str, test)
    if (str:find(test)) then
        return true
    end
    return false
end

return util
--, uTab, uStr
