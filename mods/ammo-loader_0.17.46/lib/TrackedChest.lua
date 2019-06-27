--[[--
TrackedChest: Class representing a single loader chest.
@classmod TC
@alias TrackedChest
]]
TC = {}
TC.className = "TrackedChest"
TC.dbName = TC.className
DB.register(TC.dbName)
TC.rangeIndicator = "ammo-loader-range-indicator"
--[[--
Metatable
@table objMT
]]
TC.objMT = {
    __index = TC
}

function TC._init()
    util.destroyAll({name = TC.rangeIndicator})
    -- util.destroyAll(TC.indicators.infinite)
    -- DB.new(TC.dbName)
    global["TC"] = {}
    global["TC"]["chestNames"] = TC.findChestNames()
    global["TC"]["indicators"] = {count = 0, queue = Q.new()}
end
Init.registerFunc(TC._init)
function TC._onLoad()
    for id, obj in pairs(DB.getAll(TC.dbName)) do
        setmetatable(obj, TC.objMT)
        -- setmetatable(obj._slotsInRangeQ, idQ.objMT)

        for item, qList in pairs(obj._addCache) do
            if (qList.orphanQ) then
                setmetatable(qList.orphanQ, idQ.objMT)
            end
            if (qList.upgradeQ) then
                setmetatable(qList.upgradeQ, idQ.objMT)
            end
        end
        -- setmetatable(obj.slotQ, idQ.objMT)
        -- if (obj.slotIter) then
        -- setmetatable(obj.slotIter, util.iterator.objMT)
        -- end
        -- if (obj.slotIter) then
        --     setmetatable(obj.slotIter.slotQ, idQ.objMT)
        -- end
        -- setmetatable(obj.movingInRangeQ, idQ.objMT)
        -- for item, cons in pairs(obj._cache) do
        --     setmetatable(cons.searchQ, idQ.objMT)
        -- end
        -- for item, q in pairs(obj._removalQueues) do
        --     setmetatable(q, idQ.objMT)
        -- end
    end
end
Init.registerOnLoadFunc(TC._onLoad)

function TC.dbInsert(chest)
    return DB.insert(TC.dbName, chest)
end

function TC.master()
    return global["TC"]
end
function TC.chestNames(listType)
    if not listType then
        return TC.master()["chestNames"]
    end
    return TC.master()["chestNames"][listType]
end
function TC.chestDB()
    return DB.getAll(TC.dbName)
end

function TC.indicators()
    return global["TC"]["indicators"]
end

--- Create new TrackedChest object
-- @param ent Entity to use to create new chest.
-- @return Tracked Chest object
function TC.new(ent)
    if (not isValid(ent)) or (not TC.isChest(ent)) then
        return nil
    end

    local f = Force.get(ent.force.name)
    local ch = f.chests
    if (ent.name == protoNames.chests.storage) then
        ch = f.storageChests
    end
    local cyc = ch.cycle
    for i = 1, ch:size() do
        local chest = cyc(ch)
        if (not chest) then
            break
        end
        if (chest.ent == ent) then
            inform("chest already exists; aborting TC.new...")
        end
    end
    local obj = {}
    setmetatable(obj, TC.objMT)
    obj.entName = ent.name
    obj.ent = ent
    obj._forceName = ent.force.name
    obj._surfaceName = ent.surface.name
    obj.inv = ent.get_inventory(defines.inventory.chest)
    if not isValid(obj.inv) then
        return nil
    end
    local pos = ent.position
    -- if (obj.surfaceName ~= "nauvis") then
    -- local player = ent.last_user
    -- if not player then
    --     return nil
    -- end
    -- pos = trackedPos(player.index)
    -- if not pos then
    --     return nil
    -- end
    -- end
    obj._posX = pos.x
    obj._posY = pos.y
    -- obj.type = TC.getType(ent)
    -- if obj.type == nil then return nil end
    obj.id = TC.dbInsert(obj)

    local rad = gSets.chestRadius()
    local force = obj:force()
    -- obj._slotsInRangeQ = idQ.new(SL)
    obj.consumers = {}
    if (rad > 0) then
        obj.area = Position.expand_to_area(obj:position(), rad)
    -- obj.consumersInRange = {}
    -- force.slots:forEach(
    --     function(slot)
    --         if (not slot.canMove) and (obj:isInRange(slot)) then
    --             obj._slotsInRangeQ:push(slot)
    --         end
    --     end,
    --     nil,
    --     true
    -- )
    end
    -- obj.provItem = nil
    if (ent.name == protoNames.chests.storage) then
        obj.isStorage = true
    end
    obj._cacheLastTick = 0
    obj._invCache = {}
    obj._removalCache = {}
    obj._addCache = {}
    -- obj._reserveCache = {}
    -- obj.canUpgrade = false
    -- obj.slotsToAdd = {}
    -- obj.slotQ = idQ.new(SL)
    obj._indicators = {count = 0, ents = {}}
    if (obj.isStorage) and (force.storageChests:size() <= 0) then
        local slots = force.slots
        for i = 1, slots:size() do
            local s = slots:cycle()
            if not s then
                break
            end
            force:addOrphan(s)
        end
    end
    force:addChest(obj)
    -- obj.slotsInRange = {}
    -- obj:tick()
    if (TC.indicators().toggled) then
        obj:drawRange()
    end
    return obj
end

function TC.isInRange(self, slot)
    return util.isInRange(slot, self)
end

TC.position = function(self)
    return {x = self._posX, y = self._posY}
end

TC.surface = function(self)
    return self.ent.surface
end
TC.surfaceName = function(self)
    -- return self:surface().name
    return self._surfaceName
end

function TC.destroy(self)
    self:clearIndicators()
    local force = self:force()
    -- local slots = idQ.new(SL, true)
    -- for item, qList in pairs(self._addCache) do
    for catName, cat in pairs(force.provs.categories) do
        for itemName, item in pairs(cat.items) do
            local cons = item.ids[self.id]
            item.ids[self.id] = nil
            item.count = item.count - 1
            if (cons) then
                for id, t in pairs(cons) do
                    local slot = SL.getObj(id)
                    if (slot) then
                        -- slot:setBestProv(false, true)
                        -- slot.isOrphan = true
                        slot:setProv()
                        slot:queueAllProvs()
                    -- cat.orphans[id] = true
                    end
                end
            end
        end
    end
    -- local provItem = force:provItem(item)
    -- local cons = provItem.ids[self.id]
    -- provItem.ids[self.id] = nil
    -- provItem.count = provItem.count - 1
    -- if (cons) then
    --     for slotID, t in pairs(cons) do
    --         local slot = SL.getObj(slotID)
    --         if (slot) then
    --             -- slots:push(slot)
    --             -- slot:setBestProv(false, true)
    --             slot:setProv()
    --             -- slot:queueAllProvs()
    --             force:addOrphan(slot)
    --         end
    --     end
    -- end
    -- end
    -- local slots = force.slots
    -- for i = 1, slots:size() do
    --     local slot = slots:cycle()
    --     if (not slot) then
    --         break
    --     end
    --     local prov = slot:curProvider()
    --     if (prov) and (prov == self.id) then
    --         -- slot:setBestProv(false, true)

    --         slot:queueAllProvs(true)
    --         slot:setProv()
    --     -- force:addOrphan(slot, true)
    --     end
    -- end
    DB.deleteID(TC.dbName, self.id)
end

function TC.isValid(self)
    if not self then
        return false
    end
    if (not self.ent) or (not self.ent.valid) then
        return false
    end
    return true
end

function TC.newIndicator(self, position)
    local new = self:surface().create_entity {name = TC.rangeIndicator, position = position}
    new.minable = false
    new.destructible = false
    new.active = false
    local inds = self._indicators

    inds.count = inds.count + 1
    inds.ents[inds.count] = new
    return new
end

function TC.clearIndicators(self)
    local inds = self._indicators
    local ents = inds.ents
    local allInds = TC.indicators()
    allInds.count = allInds.count - inds.count
    for i = 1, inds.count do
        local ent = ents[i]
        if (ent) then
            ent.destroy()
        end
    end
    self._indicators = {count = 0, ents = {}}
end

function TC.clearAllIndicators(forceName)
    if (forceName) then
        -- error(forceName)
        local f = Force.get(forceName)
        local chests = f.chests
        chests:forEach(TC.clearIndicators, nil, true)
        f.storageChests:forEach(TC.clearIndicators, nil, true)
    else
        for fName, force in pairs(Force.forces()) do
            force.chests:forEach(TC.clearIndicators, nil, true)
            force.storageChests:forEach(TC.clearIndicators, nil, true)
        end
    end
    local allInds = TC.indicators()
    allInds.queue = Q.new()
    allInds.count = 0
end

function TC.tickIndicators()
    local inds = TC.indicators()
    local q = inds.queue
    local size = Q.size(q)
    if (size <= 0) then
        return nil
    end
    local max = gSets.maxIndicatorsPerTick()
    if (size < max) then
        max = size
    end
    for i = 1, max do
        local info = Q.pop(q)
        local chest = TC.getObj(info.parentID)
        if (chest) then
            -- local newInd = chest:newIndicator(info.position)
            chest:newIndicator(info.position)
        -- chest._indicators.count = chest._indicators.count + 1
        -- chest._indicators.ents[chest._indicators.count] = newInd
        -- inds.count = inds.count + 1
        end
    end
end

function TC.queueAllIndicators(forceName)
    if (forceName) then
        local chests = Force.get(forceName).chests
        local function qChest(chest)
            return chest:drawRange()
        end
        chests:forEach(qChest, nil, true)
    else
        for chest in TC.chests():iter() do
            chest:drawRange()
        end
    end
end

-- function TC.drawRange(self)
--     if (gSets.rangeIsInfinite()) then
--         return nil
--     end
--     -- TC.queueIndicators(self.surfaceName, self.area, self.id)
--     -- local surfName = ent.surface.name
--     local area = self.area
--     local inds = TC.indicators()
--     local count = inds.count
--     local q = inds.queue
--     local per, amt = util.perimeter(area)
--     local maxInds = gSets.maxIndicators()
--     -- for x, y in Area.iterate(area) do
--     for i = 1, amt do
--         if (count + Q.size(q) >= maxInds) then
--             break
--         end
--         local pos = per[i]
--         Q.push(q, {surface = self:surfaceName(), position = pos, parentID = self.id})
--     end
-- end
function TC.drawRange(self, player)
    if (gSets.rangeIsInfinite()) then
        return nil
    end
    local alpha = 0.1
    local color = {r = 0.02, g = 0.05, b = 0.12, a = alpha}
    if (player.force.name ~= self:force().name) then
        color = {r = 0.5, g = 0.125, b = 0.03, a = alpha}
    end
    -- local opts = {}
    local opts = {
        color = color,
        width = 1.5,
        filled = true,
        left_top = self.area.left_top,
        right_bottom = self.area.right_bottom,
        surface = self:surface().name,
        forces = {self:force().name},
        players = {player.index},
        draw_on_ground = true
    }
    -- opts["color"] = {r = 0.5, g = 0.5, b = 0.5, a = 0.75}
    -- opts["width"] = 2.0
    -- opts["filled"] = false
    -- opts["left_top"] = self.area
    -- opts["right_bottom"] = {x = 1, y = 1}
    -- opts["surface"] = game.surfaces.nauvis
    -- opts["forces"] = {game.forces.player}
    -- opts["draw_on_ground"] = true
    -- cInform(opts.width)
    local id = rendering.draw_rectangle(opts)
    local slots = self:force().slots
    slots:forEach(
        function(slot)
            if (slot:isInRange(self)) then
                local prov = slot:provider()
                if (prov) and (prov.id == self.id) then
                    rendering.draw_line(
                        {
                            color = {r = 0.5, g = 0.125, b = 0.03, a = alpha},
                            width = 1.0,
                            from = self.ent,
                            to = slot.ent,
                            surface = self:surface().name,
                            forces = {player.force.name},
                            players = {player.index},
                            draw_on_ground = false
                        }
                    )
                end
                slot:highlight(player)
            end
        end,
        nil,
        true
    )
end

function TC.entDrawRange(ent)
    local chest = TC.getObjFromEnt(ent)
    if not chest then
        return nil
    end
    chest:drawRange()
end

function TC.force(self)
    -- return Force.get(self.ent.force.name)
    return Force.get(self:forceName())
end
function TC.forceName(self)
    -- return self.ent.force.name
    return self._forceName
end

function TC.filterItem(self)
    return self.provItem
end

function TC.itemInfo(self)
    local name = self.provItem
    if not name then
        return nil
    end
    return ItemDB.item.get(name)
end
TC.filterInfo = TC.itemInfo

function TC.category(self)
    local inf = self:itemInfo()
    if (not inf) then
        return nil
    end
    return inf.category
end

function TC.itemAmt(self, item, new)
    if (new) then
        self._invCache[item] = new
        return new
    end
    local amt = self._invCache[item] or 0
    return amt
end

function TC.allChests()
    local q = idQ.new(TC.dbName)
    for id, chest in pairs(DB.getEntries(TC.dbName)) do
        idQ.push(q, chest)
    end
    return q
end
function TC.findChestNames()
    local result = {list = {}, hash = {}}
    local hash = result.hash
    local list = result.list
    for key, name in pairs(protoNames.chests) do
        hash[name] = true
        list[#list + 1] = name
    end
    return result
end

function TC.isChest(ent)
    if (not ent) then
        return false
    end
    -- inform("checking chest in entity named "..ent.name)
    -- if (not isValid(ent)) then
    -- elseif (TC.chestNames("hash")[ent.name]) then
    -- return false
    if (Map.containsValue(protoNames.chests, ent.name)) then
        return true
    end
    return false
end

function TC.getObj(id)
    return DB.getObj(TC.dbName, id)
end

function TC.highestID()
    return DB.get(TC.dbName).nextID - 1
end

function TC.getObjFromEnt(ent)
    for id, obj in pairs(DB.getAll(TC.dbName)) do
        if (obj.ent == ent) then
            return obj
        -- if (obj:isValid()) then
        -- return obj
        -- else
        -- obj:destroy()
        -- return nil
        -- end
        end
    end
end

function TC.insert(self, stack)
    if (not stack) or (stack.count <= 0) then
        return 0
    end
    local amtInserted = self.inv.insert(stack)
    local cache = self._invCache
    local item = stack.name
    if (amtInserted > 0) then
        if not cache[item] then
            cache[item] = amtInserted
        else
            cache[item] = cache[item] + amtInserted
        end
    end
    return amtInserted
end

function TC.remove(self, stack)
    local cache = self._invCache
    if (not stack) or (stack.count <= 0) then --or (not cache[stack.name]) or (cache[stack.name] <= 0) then
        return 0
    end
    local amtRemoved = self.inv.remove(stack)
    local item = stack.name

    if (cache[item]) then
        -- if (cache[item] <= 0) then
        --     cache[item] = nil
        -- end
        cache[item] = cache[item] - amtRemoved
    end
    return amtRemoved
end

function TC.pushSlot(self, slotObj, front)
    -- if (not self.provItem) then
    --     return false
    -- elseif (self.slotIter) and (table.containsValue(self.slotIter.list, slotObj.id)) then
    --     return false
    -- end
    if (front) then
        self.slotQ:pushleft(slotObj)
    else
        self.slotQ:push(slotObj)
    end
end

function TC.setProvItem(self, itemName)
    local itemInf = ItemDB.item.get(itemName)
    if not itemInf then
        return nil
    end
    local oldInf = self:filterInfo()
    local force = self:force()
    if (oldInf) then
        Array.removeValue(force:provItem(oldInf.name).providers, self.id)
    -- for slot in self:iterCons() do
    --     slot:removeProvider(self)
    -- end
    end
    -- self.provItem = nil
    -- self.slotIter = nil
    -- self.slotQ = nil
    Array.insert(force:provItem(itemName).providers, self.id)
    self.provItem = itemName
    -- self.slotIter = self:iterConsObj(true)
    -- self.slotQ = idQ.new(SL)
end

function TC.findValidItemInfo(inv)
    for item, count in pairs(inv) do
        local inf = ItemDB.item.get(item)
        if (inf ~= nil) then
            return inf
        end
    end
    return nil
end

function TC.slotsInRangeQ(self)
    if (not self.area) then
        return self:force().slots
    else
        return self._slotsInRangeQ
    end
end

function TC.hasCat(self, cat)
    for item, count in pairs(self._invCache) do
        local inf = itemInfo(item)
        if (inf.category == cat) then
            return true
        end
    end
    return false
end

function TC.itemConsumers(self, item)
    -- local inf = itemInfo(item)
    local f = self:force()
    local provItem = f:provItem(item)
    local reg = provItem.ids[self.id]
    return reg
    -- if (not reg) then
    --     reg = {}
    --     provItem.ids[self.id] = reg
    -- end
    -- return reg
end

function TC.doQ(self)
    local force = self:force()
    local maxSlots = gSets.maxSlotsPerChestTick()
    local addCache = self._addCache

    for item, qList in pairs(addCache) do
        if force.slotsChecked >= maxSlots then
            break
        end
        local itemCount = self:itemAmt(item)

        if (itemCount > 0) then
            local inf = itemInfo(item)
            local orphs = force:provCat(inf.category).orphans
            local orphQ = qList.orphanQ
            local upQ = qList.upgradeQ
            if (orphQ:size() > 0) then
                -- if (orphQ:size() <= 0) then
                -- qList.orphanQ = nil
                -- end
                local qSize = orphQ:size()
                cInform("processing orphQ for ", item, " -- ", qSize, " entries remaining")
                local n = 0
                while (n < qSize) and (itemCount > 0) and (force.slotsChecked < maxSlots) do
                    n = n + 1
                    local slot = orphQ:pop()
                    if not slot then
                        break
                    end
                    -- local curProv = slot:curProvider()
                    -- local curItemInf = slot:filterInfo()
                    -- local curFilter = slot:filterItem()
                    if (slot:filterItem()) then
                        inform("not orphan, moving to upgrade queue.")
                        upQ:push(slot)
                    else
                        if (not slot.canMove) or (self:isInRange(slot)) then
                            -- force.slotsChecked = force.slotsChecked + 1

                            slot:setProv(self, item)
                            itemCount = self:itemAmt(item)

                        -- if (fill) then
                        -- itemCount = itemCount - inf.fillLimit
                        -- self:itemAmt(item, itemCount)
                        -- end
                        end
                    end
                    -- if (force.slotsChecked >= maxSlots) then
                    --     return
                    -- end
                end
            elseif (upQ:size() > 0) then
                -- cInform("checking upgrades!")
                -- if (upQ:size() <= 0) then
                -- qList.upgradeQ = nil
                -- end
                local qSize = upQ:size()
                cInform("processing upQ for ", item, " -- ", qSize, " entries remaining")
                local n = 0
                while (n < qSize) and (itemCount >= inf.fillLimit) and (force.slotsChecked < maxSlots) do
                    n = n + 1
                    local slot = upQ:pop()
                    if not slot then
                        break
                    end
                    -- local curProv = slot:curProvider()
                    local curItemInf = slot:filterInfo()
                    -- local curFilter = slot:filterItem()
                    if (not curItemInf) or (curItemInf.rank > inf.rank) then
                        if (not slot.canMove) or (self:isInRange(slot)) then
                            -- force.slotsChecked = force.slotsChecked + 1
                            slot:setProv(self, item)
                            itemCount = self:itemAmt(item)

                        -- local stack = slot:itemStack()
                        -- if (stack.count > 0) then
                        --     if (itemInfo(stack.name).rank < inf.rank) then
                        --         slot:returnItems()
                        --         itemCount = itemCount - inf.fillLimit
                        --         self:itemAmt(item, itemCount)
                        --     end
                        -- else
                        --     itemCount = itemCount - inf.fillLimit
                        --     self:itemAmt(item, itemCount)
                        -- end
                        -- local fill =
                        -- if (fill) then
                        -- itemCount = itemCount - inf.fillLimit
                        -- self:itemAmt(item, itemCount)
                        -- end
                        end
                    end
                    -- if (force.slotsChecked >= maxSlots) then
                    --     return
                    -- end
                end
            -- else
            -- addCache[item] = nil
            end
        else
            cInform("itemcount <= 0!")
        end
    end
end

function TC.updateCache(self)
    local gTick = gSets.tick()
    local ticksToWait = gSets.ticksBeforeCacheRemoval()
    local fTick = gTick + ticksToWait
    local newCache = self.inv.get_contents()
    local oldCache = self._invCache
    self._invCache = newCache
    local force = self:force()
    local rmCache = self._removalCache
    local addCache = self._addCache
    for item, count in pairs(self._invCache) do
        local inf = ItemDB.item.get(item)
        if (inf) then
            rmCache[item] = nil
            if (not oldCache[item]) and (not addCache[item]) then
                force:addProv(self, item)
                local orphQ = idQ.new(SL, true)
                local upQ = idQ.new(SL, true)
                addCache[item] = {orphanQ = orphQ, upgradeQ = upQ}
                local orphs = force:provCat(inf.category).orphans
                for slotID, t in pairs(orphs) do
                    local slot = SL.getObj(slotID)
                    if (not slot) then
                        orphs[slotID] = nil
                    elseif (self:isInRange(slot)) then
                        orphQ:push(slot)
                    end
                end
                local dbItems = ItemDB.cat(inf.category).items
                for i = inf.rank + 1, #dbItems do
                    local provItm = force:provItem(dbItems[i])
                    for chestID, cons in pairs(provItm.ids) do
                        for slotID, t in pairs(cons) do
                            local slot = SL.getObj(slotID)
                            if (slot) then
                                if (self:isInRange(slot)) then
                                    upQ:push(slot)
                                end
                            else
                                cons[slotID] = nil
                            end
                        end
                    end
                end
            end
        -- inform("adding provider")
        end
    end
    for item, count in pairs(oldCache) do
        local inf = itemInfo(item)
        if (inf) and (not self._invCache[item]) and (not rmCache[item]) then
            rmCache[item] = fTick
        end
    end
    for item, tick in pairs(rmCache) do
        if (gTick >= tick) then
            rmCache[item] = nil
            addCache[item] = nil
            force:removeProv(self, item)
        end
    end
end

function TC.tick(self)
    if not self then
        inform("null chest sent to TC.tick")
        return
    end
    -- inform("TC Tick")
    if (self.isStorage) then
        return
    end
    local gTick = gSets.tick()
    local minTicks = gSets.ticksBetweenChestCache()
    if (gTick >= self._cacheLastTick + minTicks) then
        self._cacheLastTick = gTick
        self:updateCache()
    end
    self:doQ()
end

function TC.updateProvItem(self)
    local cache = self._invCache
    local newItemInfo = TC.findValidItemInfo(cache)
    if not newItemInfo then
        -- inform("no best item for chest...")
        return nil
    end
    local curItem = self.provItem
    if (curItem) and (cache[curItem]) then
        return nil
    end
    inform("setProv " .. newItemInfo.name)
    self:setProvItem(newItemInfo.name)
end

function TC.iterator(self, sec)
    return util.iterator.new(TC, self, sec)
end
TC.chests = TC.iterator
function TC.slots(self, sec)
    return util.iterator.new(SL, self, sec)
end

function TC.iterCons(self, onlyWorse)
    local list, size = self:releventCons(onlyWorse, true)
    local ind = 1
    local function nextSlot()
        if (ind > size) then
            return nil
        end
        local chest = list[ind]
        ind = ind + 1
        return chest
    end
    return nextSlot, nil
end

function TC.iterConsObj(self, onlyWorse)
    local obj = {}
    local l, s = self:releventCons(onlyWorse)
    obj.list = l
    obj.size = s
    obj.ind = 1
    return obj
end

function TC.nextCon(iter)
    -- if (not iter) then return nil
    while (iter.size >= iter.ind) do
        local slot = SL.getObj(iter.list[iter.ind])
        iter.ind = iter.ind + 1
        if (slot) then
            return slot
        end
    end
    return nil
end

return TC
