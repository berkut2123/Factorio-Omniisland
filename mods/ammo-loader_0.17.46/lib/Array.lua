--[[--
An integer-key list that keeps keys in consecutive order.
@classmod Array
]]
Array = {}
-- List = Array

--[[-- Metatable for all instances to use.
@table objMT
]]
Array.objMT = {
    __index = Array
}

--[[--
Create new Array.
@return New Array object

]]
function Array.new()
    local obj = setmetatable({}, Array.objMT)
    return obj
end

--[[--
Insert new item while keeping keys consecutive.
@param self
@param val The item to insert
@param ind index Index to insert the item at. Defaults to size of Array + 1.
]]
function Array.insert(self, val, ind)
    local newInd = #self + 1
    if (not ind) or (ind > newInd) then
        ind = newInd
    end
    if (ind < 1) then
        ind = 1
    end
    local i = newInd
    while (i > ind) do
        self[i] = self[i - 1]
        i = i - 1
    end
    self[ind] = val
end

--[[--
Remove all values from Array equivalent to object.
Uses "==" to compare equivalency.
@param self
@param val object to remove
]]
function Array.remove(self, val)
    local ind = Array.getIndex(self, val)
    while (ind) do
        Array.removeIndex(self, ind)
        ind = Array.getIndex(self, val)
    end
end
Array.removeValue = Array.remove

--[[--
Remove index from Array.
@param self
@param ind
]]
function Array.removeIndex(self, ind)
    local size = #self
    for j = ind, size do
        self[j] = self[j + 1]
    end
    return true
end

--[[--
Check for presence of object in Array values.
@param self
@param val Object to check against values for equivalency
@return true if Array contains at least one instance of object in values, otherwise false
]]
function Array.contains(self, val)
    local size = #self
    for i = 1, size do
        if self[i] == val then
            return true
        end
    end
    return false
end

--[[--
Find first index in Array that matches item.
@param self
@param val Item to check for
@return Index of item or nil
]]
function Array.getIndex(self, val, limit)
    local size = #self
    local curOcc = limit or 1
    for i = 1, size do
        local cur = self[i]
        if cur == val then
            if (curOcc <= 1) then
                return i
            else
                curOcc = curOcc - 1
            end
        end
    end
    return nil
end
Array.indexOf = Array.getIndex

--[[--
Combine two or more Arrays. Result is a new Array object separate from the ones passed.
@param args List of Arrays to combine.
@return New Array containing the vales of all.
]]
function Array.combine(args)
    -- local Array = util.Array
    local result = {}
    for argInd = 1, #args do
        local curArray = args[argInd]
        for ind = 1, #curArray do
            local curVal = curArray[ind]
            result[#result + 1] = curVal
            -- Array.insert()
        end
    end
    return result
end

--[[--
Appends one Array to another.
@param t1
@param t2 Array to be appended to Array1.
@return t1
]]
function Array.append(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

--[[--
Check for equivalency of all key/value pairs in two tables.
@param a1
@param a2
@return bool
]]
function Array.equals(a1, a2)
    local size1 = #a1
    local size2 = #a2
    if size1 == size2 then
        for k, v in pairs(a1) do
            if a2[k] ~= v then
                return false
            end
        end
        return true
    end
    return false
end

function Array.insertionSort(self, compareFunc)
    local sorted = {}
    local size = #self
    for i = 1, size do
        local curItem = self[i]
        local sortedSize = #sorted
        local sortedInd = sortedSize + 1
        for j = 1, sortedSize do
            local comp = compareFunc(curItem, sorted[j])
            if (comp > 0) then
                -- Array.insert(sorted, curItem, j)
                sortedInd = j
                break
            end
        end
        Array.insert(sorted, curItem, sortedInd)
    end
    return sorted
end

function Array.mergeSort(self, compareFunc)
    if (not compareFunc) then
        compareFunc = function(x, y)
            if (x < y) then
                return -1
            elseif (x == y) then
                return 0
            elseif (x > y) then
                return 1
            end
        end
    end
    local function merge(arr, l, m, r)
        -- Find sizes of two subarrays to be merged
        local n1 = m - l + 1
        local n2 = r - m

        -- /* Create temp arrays */
        local L = {}
        local R = {}

        -- /*Copy data to temp arrays*/
        for i = 1, n1 do
            L[i] = arr[l - 1 + i]
        end
        for j = 1, n2 do
            R[j] = arr[m + j]
        end

        -- /* Merge the temp arrays */

        -- // Initial indexes of first and second subarrays
        local i = 1
        local j = 1

        -- // Initial index of merged subarry array
        local k = l
        while (i <= n1 and j <= n2) do
            local compRes = compareFunc(L[i], R[j])
            if (compRes <= 0) then
                arr[k] = L[i]
                i = i + 1
            else
                arr[k] = R[j]
                j = j + 1
            end
            k = k + 1
        end

        -- /* Copy remaining elements of L[] if any */
        while (i <= n1) do
            arr[k] = L[i]
            i = i + 1
            k = k + 1
        end

        -- /* Copy remaining elements of R[] if any */
        while (j <= n2) do
            arr[k] = R[j]
            j = j + 1
            k = k + 1
        end
    end
    local function sort(arr, l, r)
        if (l < r) then
            -- // Find the middle point
            local m = r / 2

            -- // Sort first and second halves
            sort(arr, l, m)
            sort(arr, m + 1, r)

            -- // Merge the sorted halves
            merge(arr, l, m, r)
        end
    end
    sort(self, 1, #self)
end

return Array
