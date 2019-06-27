--[[--
TrackedSlot: Class representing a single tracked slot.
@classmod SL
]]
SL = {}
SL.className = "TrackedSlot"
SL.dbName = SL.className
DB.register(SL.dbName)

--[[-- Metatable for all instances to use.
@table objMT
]]
SL.objMT = {
    __index = SL
}
-- local TS = SL
function SL._onLoad()
    for id, obj in pairs(DB.getAll(SL.dbName)) do
        setmetatable(obj, SL.objMT)
    end
end
Init.registerOnLoadFunc(SL._onLoad)

SL.trackableTypes = {}
SL.trackableTypes["artillery-turret"] = true
SL.trackableTypes["ammo-turret"] = true
SL.trackableTypes["artillery-wagon"] = true
SL.trackableTypes["locomotive"] = true
SL.trackableTypes["car"] = true
function SL._init()
    -- HI.destroyAll()
    -- DB.new(SL.dbName)
    global["trackedEntNames"] = {}
    for name, proto in pairs(game.entity_prototypes) do
        if (SL.trackableTypes[proto.type]) or (proto.burner_prototype) then
            if (proto.name ~= protoNames.hiddenInserter) then
                global["trackedEntNames"][proto.name] = {}
            end
        end
    end
end
Init.registerFunc(SL._init)

function SL.highestID()
    return DB.highest(SL.dbName)
end

function SL.emptyStack()
    return {name = nil, count = 0}
end

SL.trackable = {}

SL.trackable.all = function()
    return global["trackedEntNames"]
end
SL.trackedEnts = SL.trackable.all

function SL.trackable.getOrAddEnt(ent)
    local tracked = SL.trackable.all()
    local tEnt = tracked[ent.name]
    if not tEnt then
        tEnt = {}
        tracked[ent.name] = tEnt
    end
    return tEnt
end
SL.trackable.addEnt = SL.trackable.getOrAddEnt

function SL.trackable.getOrAddInv(ent, ind)
    local invs = SL.trackable.getOrAddEnt(ent)
    local inv = invs[ind]
    if not inv then
        inv = {}
        invs[ind] = inv
    end
    return inv
end
SL.trackable.addInv = SL.trackable.getOrAddInv

function SL.trackable.getOrAddSlot(ent, invInd, slotInd)
    local slots = SL.trackable.getOrAddInv(ent, invInd)
    local slot = slots[slotInd]
    if not slot then
        slot = true
        slots[slotInd] = slot
    end
    return slot
end

function SL.isTrackable(ent)
    if (not SL.trackedEnts()[ent.name]) then
        return false
    end
    return true
end

function SL.allSlots()
    return DB.getAll(SL.dbName)
end

function SL.clearAllSlots(forceName)
    -- local slots = SL.allSlots()
    -- for id, slotObj in pairs(slots) do
    --     slotObj:slot().clear()
    -- end
    local slots = Force.get(forceName).slots
    slots:forEach(SL.returnItems, nil, true)
end

function SL.returnAll(forceEmpty)
    local forces = {}
    local slots = SL.allSlots()
    for id, slotObj in pairs(slots) do
        local spillStack = slotObj:returnItems(forceEmpty, false)
        if (spillStack ~= nil) and (spillStack.count > 0) then
            local fName = slotObj:forceName()
            local force = forces[fName]
            if not force then
                force = {}
                forces[fName] = force
            end
            local spill = force
            local amt = spill[spillStack.name]
            if (not amt) then
                amt = 0
                spill[spillStack.name] = amt
            end
            spill[spillStack.name] = amt + spillStack.count
        end
    end
    for forceName, inv in pairs(forces) do
        for item, amt in pairs(inv) do
            local stack = {name = item, count = amt}
            game.surfaces.nauvis.spill_item_stack({x = 0, y = 0}, stack, true, forceName)
        end
    end
end

function SL.getSlotsWithEnt(ent)
    local q = idQ.new(SL)
    local slots = SL.allSlots()
    for id, obj in pairs(slots) do
        if (obj.ent == ent) then
            q:push(obj)
        end
    end
    return q
end

function SL.prepareForRemoval(self)
    local inserter = self:inserter()
    inserter:destroy()
    self:returnItems()
end

function SL.new(ent, inv, index, slotCat, slotType)
    if (not isValid(ent)) or (ent.name == protoNames.hiddenInserter) or (not SL.isTrackable(ent)) or (ent.type == "boiler") then
        -- inform("???????????????????")
        return nil
    end
    if (not slotCat) or (not slotType) then
        return nil
    end
    local ind = index or 1
    if not SL.isValidSlot(inv, ind) then
        -- inform("not a valid slot for " .. ent.name)
        return nil
    end
    -- local f = Force.get(ent.force.name)
    -- local sl = f.slots
    -- local cyc = sl.cycle
    -- for i = 1, sl:size() do
    --     local test = cyc(sl)
    --     if (not test) then
    --         break
    --     end
    --     if (test.ent == ent) and (test:inv() == inv) and (test.slotInd == ind) then
    --         inform("Slot already exists, aborting create.")
    --         return
    --     end
    -- end
    -- inform("creating slot from " .. ent.name)
    local slot = inv[ind]
    -- local slotCat, slotType = SL.getSlotCat(slot)
    -- if not slotCat then
    -- inform("no category for " .. ent.name)
    -- return nil
    -- end
    local obj = {}
    setmetatable(obj, SL.objMT)
    obj.ent = ent
    obj._forceName = ent.force.name
    obj._surfaceName = ent.surface.name
    -- obj.entName = ent.name
    obj.invInd = SL.getInvInd(ent, inv)
    if (not obj.invInd) then
        obj._inv = inv
    end
    obj.slotInd = ind
    -- obj.forceName = ent.force.name
    local force = Force.get(obj.ent.force.name)
    if (not gSets.doTrains()) and (ent.type == "locomotive") then
        return nil
    end
    obj.type = slotType
    -- obj.category = slotCat
    obj.consumerCat = slotCat

    -- if (obj.type ~= "fuel") and (not Map.containsValue(SL.ammoEntTypes, ent.type)) then
    --     return
    -- end
    if (obj.consumerCat == "artillery-shell") and (not force:doArtillery()) then
        return nil
    end
    local pos = ent.position
    if (SL.entCanMove(ent)) then
        -- obj._lastPos = obj.ent.position
        -- pos = nil
        if (not force:doVehicles()) then
            return nil
        end
        obj.isProvided = true
        obj.canMove = true
    elseif (obj.type == "fuel") and (not force:doBurners()) then
        return nil
    end
    -- if (ent.surface.name ~= "nauvis") or (ent.name == "burner-inserter") then
    if (ent.surface.name ~= "nauvis") then
        -- if (obj.canMove) then
        --     return nil
        -- end
        -- if (not obj.canMove) then
        --     pos = ent.position
        -- end
        if (gSets.rangeIsInfinite()) then
            obj.isProvided = true
        end
    -- pos = SMap.getSurfacePosition(ent.surface.name)
    end
    if (not obj.canMove) then
        obj._posX = pos.x
        obj._posY = pos.y
    end
    -- obj._stackCache = {lastTick = 0, stack = SL.emptyStack()}
    obj.id = SL.dbInsert(obj)
    if obj.isProvided then
        obj._inserter = {lastTick = 0}
        obj._slot = inv[index]
    else
        obj.inserterID = SL.newInserter(obj).id
    end
    local force = obj:force()
    force:addSlot(obj)
    force:provCat(obj.consumerCat).orphans[obj.id] = true
    obj.isOrphan = true
    obj:queueAllProvs(true)
    SL.trackable.getOrAddSlot(ent, obj.invInd, obj.slotInd)
    inform("new slot-> name: " .. obj.ent.name .. ", cat: " .. obj.consumerCat)
    return obj
end

function SL.isInRange(self, chest)
    return util.isInRange(self, chest)
end

SL.category = function(self)
    return self.consumerCat
end

SL.getArea = function(self)
    local rad = gSets.chestRadius()
    if rad > 0 then
        return Position.expand_to_area(self:position(), rad)
    end
    return nil
end

SL.surface = function(self)
    return self.ent.surface
end
SL.surfaceName = function(self)
    -- return self.ent.surface.name
    return self._surfaceName
end

SL.inv = function(self)
    if (not self.invInd) and (self._inv) and (self._inv.valid) then
        return self._inv
    end
    if (self.invInd) and (self.ent) and (self.ent.valid) then
        return self.ent.get_inventory(self.invInd)
    end
    return nil
end
SL.slot = function(self)
    if (not self._slot) then
        local inv = self:inv()
        if (inv) and (inv.valid) and (inv[self.slotInd]) then
            return inv[self.slotInd]
        end
    else
        return self._slot
    end
    return nil
end

function SL.inserter(self)
    if (self.isProvided) then
        return self._inserter
    end
    return HI.getObj(self.inserterID)
end

function SL.destroy(self)
    -- local obj = self
    -- obj:prepareForRemoval()
    local force = self:force()
    -- force:consumerCat(self.consumerCat)[self.id] = nil
    -- force:purgeConsumer(self.id)
    local ins = self:inserter()
    self:setProv()
    -- self:registerCons()
    -- force:provCat(self.consumerCat).orphans[self.id] = nil
    -- self:unregisterCons()
    if (ins) and (not self.isProvided) then
        local slot = self:slot()
        ins:destroy(slot)
    end
    DB.deleteID(SL.dbName, self.id)
end

function SL.getPosition(self)
    if (self._posX) then
        return {x = self._posX, y = self._posY}
    end
    return self.ent.position
end
SL.position = SL.getPosition

function SL.getForce(self)
    -- return FRC.get(self.ent.force.name)
    return Force.get(self:forceName())
end
SL.force = SL.getForce
SL.forceName = function(self)
    -- return self.ent.force.name
    return self._forceName
end

function SL.getItemInfo(self)
    local stack = self:getItemStack()
    if stack.count > 0 then
        return ItemDB.item.get(stack.name)
    end
    return nil
end
SL.itemInfo = SL.getItemInfo
SL.getCurItemInfo = SL.getItemInfo
SL.stackItemInfo = SL.getItemInfo

--- Return Hidden Inserter's current pickup target.
-- @param self
-- @return Provider
function SL.getCurProvider(self)
    local ins = self:inserter()
    local sourceID = ins.sourceID
    if (not sourceID) then
        return nil
    end
    local chest = TC.getObj(sourceID)
    if not chest then
        self:setProv()
    end
    return chest
end
SL.curProvider = SL.getCurProvider
SL.provider = SL.getCurProvider

function SL.getSourceID(self)
    local ins = self:inserter()
    return ins.sourceID
end
SL.sourceID = SL.getSourceID

function SL.getBestItemInfo(self)
    return itemInfo(self:filterItem())
end
SL.filterInfo = SL.getBestItemInfo
SL.bestItemInfo = SL.getBestItemInfo
SL.provItemInfo = SL.getBestItemInfo

function SL.getFilterScore(self)
    local inf = self:filterInfo()
    if not inf then
        return 0
    end
    return inf.score
end
SL.filterScore = SL.getFilterScore

function SL.getFilterItem(self)
    return self:inserter().filterName
end
SL.filterItem = SL.getFilterItem
SL.filterName = SL.getFilterItem
SL.provItem = SL.getFilterItem

function SL.hasMoved(self)
    if (not self.canMove) then
        return false
    end
    if (not self._lastPos) then
        self._lastPos = self:position()
        return true
    end
    local pos = self:position()
    local dif = (pos.x - self._lastPos.x) + (pos.y - self._lastPos.y)
    -- if (Position.equals(self._lastPos, pos)) then
    if (dif < 1) then
        return false
    end
    self._lastPos = pos
    return true
end

function SL.doProvide(self)
    -- inform("doProvide")
    if (not gSets.rangeIsInfinite()) and (self.canMove) then
        -- inform("provide: canMove")
        -- local chest = self:provider()
        if (self:hasMoved()) then
            -- self:setBestProv(false, true)
            local chest = self:provider()
            if (chest) and (not self:isInRange(chest)) then
                self:setProv()
            end
            self:force():addOrphan(self)
        -- self:queueAllProvs(true)
        end
    end
    -- local ins = self:inserter()
    -- local sourceID = ins.sourceID
    local chest = self:provider()
    if (not chest) then
        return false
    end
    local filterItem = self:filterItem()
    local filterItemInf = itemInfo(filterItem)
    if not filterItemInf then
        return false
    end
    local slotStack = self:getItemStack()
    if (slotStack.count > 0) and (slotStack.name ~= filterItem) then
        return
    end
    local amtToFull = filterItemInf.fillLimit - slotStack.count
    if (amtToFull > filterItemInf.fillLimit / 2) then
        -- inform("need to fill")
        local fillStack = {name = filterItem, count = amtToFull}
        local amtRemoved = chest:remove(fillStack)
        if (amtRemoved > 0) then
            -- inform("provide: set_stack")
            fillStack.count = slotStack.count + amtRemoved
            self:slot().set_stack(fillStack)
        end
    end
end

function SL.setItemStack(self, stack)
    local slot = self:slot()
    -- local cache = self._stackCache
    -- cache.lastTick = gSets.tick()
    if (not stack) or (stack.count <= 0) then
        -- cache.stack = SL.emptyStack()
        slot.clear()
    elseif (slot.can_set_stack(stack)) then
        -- cache.stack = stack
        slot.set_stack(stack)
    end
end

function SL.needReturn(self, val)
    -- if (val) and (not self._needReturn) then
    local prov = self:provider()
    local item = self:filterInfo()
    local q = self:force().slotsNeedReturn
    if (val) and (not self._needReturn) then
        self._needReturn = val
        q:push(self)
    elseif (val == false) then
        self._needReturn = nil
    elseif (val == nil) then
        return self._needReturn
    end
end

function SL.returnIfNeeded(self)
    local force = self:force()
    if (not force:doUpgrade()) then
        return false
    end
    local curProv = self:provider()
    local curInf = self:filterInfo()
    if not curProv then
        return false
    end
    local stack = self:getItemStack()
    if (stack.count <= 0) then
        return false, true
    end
    local stackInf = itemInfo(stack.name)
    if (not stackInf) then
        inform("No item info for current stack of " .. stack.name .. "!")
    elseif (stackInf.rank > curInf.rank) then
        inform("return needed!")
        self:needReturn(true)
        return true
    end
    return false
end

function SL.registerCons(self, chest, item)
    local f = self:force()
    local ins = self:inserter()
    local curID = ins.sourceID
    -- local curProv = TC.getObj(curID)
    if (curID) then
        local pItem = f:provItem(ins.filterName)
        local reg = pItem.ids[curID]
        if (reg) then
            reg[self.id] = nil
        end
    end
    if (not chest) then
        -- f:addOrphan(self)
        f:provCat(self.consumerCat).orphans[self.id] = true
        self.isOrphan = true
    else
        -- f:removeOrphan(self)
        local reg = f:provItem(item).ids[chest.id]
        if (reg) then
            f:provCat(self.consumerCat).orphans[self.id] = nil
            reg[self.id] = true
            self.isOrphan = nil
        end
    end
end
function SL.itemIsBetter(self, item)
    local curInf = self:filterInfo()
    if (not curInf) then
        return true
    end
    if (curInf.rank > itemInfo(item).rank) then
        return true
    end
    return false
end

function SL.provIsBetter(self, chest, item)
    local itemInf = itemInfo(item)
    if (not chest) or (not itemInf) then
        return false
    end
    if (self.consumerCat ~= itemInf.category) then
        return false
    end
    local curProv = self:provider()
    local curInf = self:filterInfo()
    if (not curProv) then
        return true
    end
    if (curProv.id == chest.id) and (item == curInf.name) then
        return false
    end
    if (self.needProvider) then
        return true
    end
    if (curInf.rank > itemInfo(item).rank) then
        return true
    end
    return false
end

function SL.wouldNeedUpgrade(self, item)
    local stack = self:itemStack()
    if (stack.count <= 0) then
        return false
    end
    local stackInf = itemInfo(stack.name)
    local newInf = itemInfo(item)
    if (stackInf) and (stackInf.rank > newInf.rank) then
        return true
    end
    return false
end
SL.wouldNeedReturn = SL.wouldNeedUpgrade

function SL.provMatches(self, chest, item)
    local curProv = self:provider()
    local curItem = self:filterItem()
    if (curProv) and (curProv.id == chest.id) then
        if (not item) or (curItem == item) then
            return true
        end
    end
    return false
end

function SL.setSourceID(self, id)
    local chest = TC.getObj(id)
    if (not chest) then
        id = nil
    end
    if (self.isProvided) then
        self._inserter.sourceID = id
    else
        self:inserter():setPickupTarget(TC.getObj(id))
    end
end

function SL.setFilterItem(self, item)
    if (self.isProvided) then
        self._inserter.filterName = item
    else
        self:inserter():setFilter(item)
    end
end

function SL.setProv(self, chestObj, item)
    if (not chestObj) or (not item) then
        self:registerCons()
        self:setSourceID(nil)
        self:setFilterItem(nil)
        return false
    else
        -- local wasOrphan = self.isOrphan
        self:registerCons(chestObj, item)
        self:setSourceID(chestObj.id)
        self:setFilterItem(item)
        local stack = self:itemStack()
        local itemInf = itemInfo(item)
        local f = self:force()
        if (stack.count > 0) then
            if (itemInfo(stack.name).rank > itemInf.rank) then
                -- f.slotsChecked = f.slotsChecked + 1
                self:returnItems()
                local itemCount = chestObj:itemAmt(item) - itemInf.fillLimit
                chestObj:itemAmt(item, itemCount)
            end
        else
            local itemCount = chestObj:itemAmt(item) - itemInf.fillLimit
            chestObj:itemAmt(item, itemCount)
        end
        return true
    end
end

function SL.provItems(self)
    return self:force():provItems(self.consumerCat)
end

function SL.provItem(self, itemName)
    return self:force():provItem(itemName)
end

function SL.addProv(self, chest, item)
    local provItem = self:provItem(item)
    if (not provItem) then
        return false
    end
    if (not provItem.ids[chest.id]) then
        provItem.ids[chest.id] = true
        provItem.count = provItem.count + 1
        local didAdd = self:setBestProv()
        return didAdd
    end
    return false
end

function SL.removeProv(self, chestObj, item)
    local provs = self:provItems()
    local function rm(curProvs)
        if (curProvs.ids[chestObj.id]) then
            curProvs.ids[chestObj.id] = nil
            curProvs.count = curProvs.count - 1
        end
    end
    if (not item) then
        for provItem, curProvs in pairs(provs) do
            rm(curProvs)
        end
    else
        if (provs[item]) then
            rm(provs[item])
        end
    end
    local curProv = self:provider()
    if (curProv) and (curProv.id == chestObj.id) then
        if (not item) or (item == self:filterItem()) then
            -- self.needCheck = true
            self:setBestProv()
        end
    end
end

function SL.nextBestProv(self, useCur, checkCount)
    local f = self:force()
    local best = {chest = nil, item = nil, itemInf = nil, rank = math.huge}
    if (useCur) then
        local bInf = self:filterInfo()
        if (bInf) then
            best = {chest = self:provider(), item = bInf.name, rank = bInf.rank}
        end
    end
    local dbItems = ItemDB.cat(self.consumerCat).items
    for i = 1, #dbItems do
        local dbItem = dbItems[i]
        local itemInf = itemInfo(dbItem)
        local rank = itemInf.rank
        if (best.rank <= rank) then
            break
        end
        local provItem = f:provItem(dbItem)
        -- local chest = nil
        for provID, t in pairs(provItem.ids) do
            local chest = TC.getObj(provID)
            if (chest) and (self:isInRange(chest)) then
                -- local qList = chest._addCache[dbItem]
                -- if qList and qList.orphanQ then
                -- qList.orphanQ:push(self)
                -- end
                local itemCount = chest:itemAmt(dbItem)
                if (itemCount > 0) then
                    -- if (self:isInRange(chest)) then
                    best.chest = chest
                    best.item = dbItem
                    best.itemInf = itemInf
                    best.rank = itemInf.rank
                    return best
                -- break
                -- end
                end
            end
        end
    end
    -- inform("best prov: " .. tostring(best.item) .. ", rank " .. tostring(best.rank))
    -- return best.chest, best.item
    return best
end
function SL.setBestProv(self, ...)
    -- self.isOrphan = true
    local force = self:force()
    force:addOrphan(self)
    -- self:queueAllProvs()
    local bestInfo = self:nextBestProv(...)
    local prov = bestInfo.chest
    local item = bestInfo.item
    local inf = bestInfo.itemInf
    self:setProv(prov, item)
    -- if (not prov) then
    -- force:addOrphan(self)
    -- local curProvID = self:inserter().sourceID
    -- if (curProvID) then
    -- self:setProv()
    -- end
    -- return false
    -- end
    -- local curProv = self:provider()
    -- if (not curProv) then
    -- local fill = self:setProv(prov, item)
    -- if (fill) then
    -- local curAmt = prov:itemAmt(item)
    -- prov:itemAmt(item, curAmt - inf.fillLimit)
    -- end
    -- return true
    -- else
    -- force:removeOrphan(self)
    -- end
    -- return true
end

function SL.queueAllProvs(self, rush)
    local f = self:force()
    local provCat = f:provCat(self.consumerCat)
    for itemName, provItem in pairs(provCat.items) do
        for id, cons in pairs(provItem.ids) do
            local prov = TC.getObj(id)
            if prov then
                -- provItem.ids[id] = nil
                -- else
                if (self:isInRange(prov)) then
                    local q = prov._addCache[itemName].orphanQ
                    if (not q) then
                        inform("no q...")
                    else
                        if (rush) then
                            q:pushleft(self)
                        else
                            q:push(self)
                        end
                    end
                end
            end
        end
    end
end

function SL.provID(self)
    local ins = self:inserter()
    if (not ins.sourceID) then
        return 0
    end
    return ins.sourceID
end

function SL.newInserter(self)
    local newIns = HI.new(self)
    return newIns
end

function SL.isValid(self)
    if not self then
        return false
    end
    if (not self.ent) or (not self.ent.valid) then
        return false
    end
    return true
end

function SL.insert(self, stack)
    local curStack = self:stackCache()
    local newAmt = stack.count
    if (curStack.count > 0) then
        if (curStack.name ~= stack.name) then
            return 0
        end
        newAmt = stack.count + curStack.count
    end
    local itemInf = ItemDB.item.get(stack.name)
    local stackSize = itemInf.stackSize
    if (stackSize < newAmt) then
        newAmt = stackSize
    end
    if (newAmt > curStack.count) then
        self:setItemStack({name = stack.name, count = newAmt})
        return newAmt - curStack.count
    else
        return 0
    end
end

function SL.remove(self, stack)
    local curStack = self:stackCache()
    local newAmt = stack.count
    if (curStack.count <= 0) or (curStack.name ~= stack.name) then
        return 0
    end
    newAmt = stack.count - curStack.count
    -- local itemInf = ItemDB.item.get(stack.name)
    -- local stackSize = itemInf.stackSize
    if (newAmt <= 0) then
        newAmt = 0
    end
    if (newAmt < curStack.count) then
        self:setItemStack({name = stack.name, count = newAmt})
        return curStack.count - newAmt
    end
    return 0
end

function SL.transferTo(self, target, stack)
    if (not stack) or (stack.count <= 0) then
        return 0
    end
    local amtRem = self:remove(stack)
    if (amtRem <= 0) then
        return 0
    end
    local amtIns = target:insert({name = stack.name, count = amtRem})
    if (amtIns < amtRem) then
        local newAmt = amtRem - amtIns
        self:insert({name = stack.name, count = newAmt})
        return newAmt
    end
    return amtIns
end

function SL.returnItems(self, matchFilter)
    local force = self:force()
    if (force.storageChests:size() <= 0) then
        return
    end
    local curStack = self:itemStack()
    if (curStack.count <= 0) then
        return
    end
    local filterName = self:filterItem()
    if (matchFilter) and (curStack.name == filterName) then
        return
    end
    local slot = self:slot()
    -- local doSpill = spill or true
    local chests = force.storageChests
    for i = 1, chests:size() do
        local chest = chests:cycle()
        if not chest then
            break
        end
        local inserted = chest.inv.insert(curStack)
        curStack.count = curStack.count - inserted
        if (curStack.count <= 0) then
            slot.clear()
            return curStack
        end
    end
    slot.set_stack(curStack)
    -- chests:forEach(
    -- function(chest)
    --     if (curStack.count <= 0) then
    --         return
    --     end
    --     local inserted = chest:insert(curStack)
    --     curStack.count = curStack.count - inserted
    --     if curStack.count <= 0 then
    --         slot.clear()
    --     else
    --         slot.set_stack(curStack)
    --     end
    -- end,
    -- nil,
    -- true
    -- )
    return curStack
end

function SL.returnEntItems(ent)
    for id, slotObj in pairs(SL.allSlots()) do
        if (slotObj.ent == ent) then
            slotObj:returnItems()
        end
    end
end

function SL.getSlotItemStack(slot)
    local stack = {name = nil, count = 0}
    if (not isValid(slot)) or (not slot.valid_for_read) then
        return stack
    end
    stack.name = slot.name
    stack.count = slot.count
    return stack
end

function SL.isValidSlot(inv, ind)
    if not isValid(inv) then
        return false
    end
    local maxSlot = #inv
    if (maxSlot < ind) then
        return false
    end
    local slot = inv[ind]
    if not isValid(slot) then
        return false
    end
    return true
end

function SL.isBurner(ent, inv)
    if (not ent.burner) or (not ent.burner.inventory) then
        return false
    end
    if (ent.burner.inventory == inv) then
        return true
    end
    return false
end

function SL.getInvInd(ent, inv)
    for name, ind in pairs(defines.inventory) do
        local newInv = ent.get_inventory(ind)
        if (newInv == inv) then
            return ind
        end
    end
    return nil
end

function SL.getPossibleInventories(ent)
    -- local allResults = {}
    -- local burner = ent.burner
    -- local ents = {}
    -- ents[#ents+1] = ent
    -- ents[#ents+1] = burner
    -- for entInd, ent in pairs(ents) do
    local entResults = {}
    for name, invInd in pairs(defines.inventory) do
        if not entResults[invInd] then
            local newInv = ent.get_inventory(invInd)
            if (newInv ~= nil) and (#newInv > 0) then
                local newSlot = newInv[1]
                if (newSlot ~= nil) and (SL.getSlotCat(newSlot) ~= nil) then
                    entResults[invInd] = newInv
                end
            end
        end
    end
    if (ent.burner ~= nil) then
        -- inform("slotCreate adding burner inventory")
        local burnerInv = ent.burner.inventory
        local skip = false
        for ind, inv in pairs(entResults) do
            if (inv == burnerInv) then
                skip = true
                break
            end
        end
        if not skip then
            entResults[defines.inventory.fuel] = ent.burner.inventory
        end
    end
    -- allResults = table.combineValues({allResults, entResults})
    -- end
    return entResults
end

SL.invTypes = {
    defines.inventory.turret_ammo,
    defines.inventory.car_ammo
}
SL.ammoEntTypes = {
    "artillery-turret",
    "ammo-turret",
    "artillery-wagon",
    "car"
}

function SL.trackAllSlots(ent)
    if not isValid(ent) or (not SL.isTrackable(ent)) then
        return nil
    end
    -- local f = Force.get(ent.force.name)
    -- local sl = f.slots
    -- local cyc = sl.cycle
    -- for i = 1, sl:size() do
    --     local test = cyc(sl)
    --     if (not test) then
    --         break
    --     end
    --     if (test.ent == ent) then
    --         inform("Slot already exists, aborting create.")
    --         return
    --     end
    -- end
    if (ent.burner) and (#ent.burner.inventory > 0) then
        local slotCat, slotType = SL.getSlotCat(ent.burner.inventory[1])
        SL.new(ent, ent.burner.inventory, 1, slotCat, slotType)
    end
    if (not Array.contains(SL.ammoEntTypes, ent.type)) then
        return nil
    end
    local invTypes = SL.invTypes
    local invs = {}
    -- local ammoInvs = {}
    -- local main = ent.get_main_inventory()
    -- if (isValid(main)) then
    --     invs[#invs + 1] = main
    -- end
    for ind, invType in pairs(invTypes) do
        local newInv = ent.get_inventory(invType)
        if (isValid(newInv)) and (#newInv > 0) and (not Array.contains(invs, newInv)) then
            invs[#invs + 1] = newInv
        end
    end

    local _i = 0
    local _s = 0
    for ind, inv in pairs(invs) do
        _i = _i + 1
        local slotsToCreate = 1
        if (ent.prototype.guns ~= nil) then
            slotsToCreate = #inv
        end
        for i = 1, slotsToCreate do
            _s = _s + 1
            local slotCat, slotType = SL.getSlotCat(inv[i])
            if (slotType) and (slotType == "ammo") then
                local newSlot = SL.new(ent, inv, i, slotCat, slotType)
            end
        end
    end
    -- if (doInform) then
    -- inform("tested " .. tostring(_i) .. " inventories, attempted " .. tostring(_s) .. " new slots.")
    -- end
end

function SL.dbInsert(slotObj)
    return DB.insert(SL.dbName, slotObj)
end

function SL.getType(slot)
    local cat, type = SL.getSlotCat(slot)
    return type
    -- if not cat then
    --     return nil
    -- end
    -- if (cat == "fuel") then
    --     return cat
    -- end
    -- return "ammo"
end

function SL.entCanMove(ent)
    if (ent.speed ~= nil) then
        -- (ent.type == "car") or
        -- (ent.type == "locomotive") or
        -- (string.contains(ent.type, "wagon"))
        return true
    end
    return false
end

function SL.getObj(id)
    return DB.getObj(SL.dbName, id)
end

function SL.getSlotsByEnt(ent)
    local slots = DB.getEntries(SL.dbName)
    local result = {}
    for id, slotObj in pairs(slots) do
        if (slotObj.ent == ent) then
            result[#result + 1] = slotObj
        end
    end
    return result
end
function SL.getItemStack(self, returnRef)
    local slot = self:slot()
    -- if (self.slot ~= nil) then slot = self.slot end
    -- local emptyStack = {name = nil, count = 0}
    if (not slot.valid_for_read) then
        return SL.emptyStack()
    else
        return {name = slot.name, count = slot.count}
    end
end
SL.itemStack = SL.getItemStack
SL.stackCache = SL.getItemStack

function SL.getSlotCat(slot)
    local canInsert = slot.can_set_stack
    if (canInsert({name = "iron-plate", count = 1})) then
        return nil
    end
    for name, info in pairs(ItemDB.items()) do
        if (canInsert({name = name, count = 1})) then
            return info.category, info.type
        end
    end
    return nil
end

function SL.iterator(self, sec)
    return util.iterator.new(SL, self, sec)
end
SL.slots = SL.iterator

function SL.chests(self, sec)
    return util.iterator.new(TC, self, sec)
end

function SL.iterProviders(self, onlyBetter)
    local list, size = self:releventProvs(onlyBetter, true)
    local ind = 1
    local function nextChest()
        if (ind > size) then
            return nil
        end
        local chest = list[ind]
        ind = ind + 1
        return chest
    end
    return nextChest, nil
end
SL.iterProvs = SL.iterProviders

function SL.iterStorage(self)
    local chests = self:force().storageChests
    local size = chests:size()
    local i = 0
    local pos = self:position()
    local function nextChest()
        if (i >= size) then
            return nil
        end
        i = i + 1
        local chest = chests:cycle()
        if not chest then
            return nil
        end
        if (chest:isInRange(self)) then
            return chest
        end
    end
    return nextChest, nil
end

function SL.releventProvs(self, onlyBetter, getObjects)
    -- local testBetter = onlyBetter
    local pos = self:position()
    local filterInf = self:filterInfo()
    local curScore = 0
    if (onlyBetter) and (filterInf) then
        curScore = filterInf.score
    end
    local cat = self:force():provCat(self.consumerCat)
    local catItems = cat.items
    local res = {}
    local n = 0
    for i = 1, #catItems do
        local item = catItems[i]
        if (item.score > curScore) then
            local provs = item.providers
            for id, t in pairs(provs) do
                local chest = TC.getObj(id)
                if (chest) and (chest:canProvide(pos)) then
                    n = n + 1
                    if (getObjects) then
                        res[n] = chest
                    else
                        res[n] = id
                    end
                end
            end
        end
    end
    return res, n
end

function SL.highlight(self, player)
    local rend =
        rendering.draw_circle(
        {
            color = {r = 0.5, g = 0.125, b = 0.03, a = 0.2},
            radius = 0.75,
            width = 1.0,
            filled = true,
            target = self.ent,
            surface = self:surface().name,
            forces = {player.force.name},
            players = {player.index},
            visible = true,
            draw_on_ground = false
        }
    )
end

return SL
