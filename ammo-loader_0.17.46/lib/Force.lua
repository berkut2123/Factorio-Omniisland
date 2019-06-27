--[[--
Class representing a LuaForce.
@classmod Force
@alias FRC
]]
Force = {}
FRC = Force
Force.objMT = {
    __index = Force
}

Force._init = function()
    global["Force"] = {}
    global["Force"]["forces"] = {}
    for name, frc in pairs(game.forces) do
        global["Force"]["forces"][name] = Force.new(name)
    end
    -- Force._globs()
end
Init.registerFunc(Force._init)

Force._onLoad = function()
    -- Force._globs()
    for name, frc in pairs(Force.forces()) do
        setmetatable(frc, Force.objMT)
        setmetatable(frc.chests, idQ.objMT)
        setmetatable(frc.slots, idQ.objMT)
        setmetatable(frc.orphans, idQ.objMT)
        -- setmetatable(frc.catQ, Q.objMT)
        setmetatable(frc.inserters, idQ.objMT)
        setmetatable(frc.providedSlots, idQ.objMT)
        setmetatable(frc.slotsCanMove, idQ.objMT)
        setmetatable(frc.slotsToCheck, idQ.objMT)
        setmetatable(frc.slotsNeedReturn, idQ.objMT)
        setmetatable(frc.storageChests, idQ.objMT)

        -- for catName, cat in pairs(frc.provs.categories) do
        --     setmetatable(cat.orphans, idQ.objMT)
        -- end
    end
end
Init.registerOnLoadFunc(Force._onLoad)

function Force.new(name)
    local obj = {}
    setmetatable(obj, Force.objMT)
    obj.name = name
    obj.chests = idQ.new(TC)
    obj.provCats = {}
    obj.provs = {categories = {}}
    obj.storageChests = idQ.new(TC, true)
    obj.slots = idQ.new(SL, true)
    obj.orphans = idQ.new(SL, true)
    -- obj.catQ = Q.new()
    obj.inserters = idQ.new(HI, true)
    obj.consumerCats = {}
    obj.providedSlots = idQ.new(SL, true)
    obj.slotsCanMove = idQ.new(SL, true)
    obj.slotsToCheck = idQ.new(SL, true)
    obj.slotsNeedReturn = idQ.new(SL, true)
    obj.slotsChecked = 0
    obj._inv = {}
    obj.techs = {}
    obj:getTechs()
    return obj
end

function Force.getTechs(self)
    local force = game.forces[self.name]
    local forceTechs = force.technologies
    local recipes = force.recipes
    local useTech = gSets.useTech()
    for key, name in pairs(protoNames.tech) do
        local tech = forceTechs[name]
        if not tech then
            return
        end
        if (useTech) then
            tech.enabled = true
        else
            tech.enabled = false
        end
        if (not tech.enabled) or (tech.researched) then
            if (tech.name == protoNames.tech.loader) then
                recipes[protoNames.loaderChest].enabled = true
            elseif (tech.name == protoNames.tech.requester) then
                recipes[protoNames.requesterChest].enabled = true
            elseif (tech.name == protoNames.tech.upgrade) then
                recipes[protoNames.storageChest].enabled = true
            end
            self.techs[name] = true
        end
    end
end

function Force.doUpgrade(self)
    if (not gSets.doUpgrade()) then
        return false
    end
    if (self.techs[protoNames.tech.upgrade]) then
        return true
    end
    return false
end
function Force.doVehicles(self)
    if (self.techs[protoNames.tech.vehicles]) then
        return true
    end
    return false
end
function Force.doArtillery(self)
    if (not gSets.doArtillery()) then
        return false
    end
    if (self.techs[protoNames.tech.artillery]) then
        return true
    end
    return false
end
function Force.doBurners(self)
    if (not gSets.doBurners()) then
        return false
    end
    if (self.techs[protoNames.tech.burners]) then
        return true
    end
    return false
end
function Force.doReturn(self)
    if (not gSets.doReturn()) then
        return false
    end
    if (self.techs[protoNames.tech.returnItems]) then
        return true
    end
    return false
end

function Force.provItems(self, cat)
    return self:provCat(cat).items
end

function Force.provCat(self, catName)
    local cats = self.provs.categories
    local cat = cats[catName]
    if not cat then
        -- cat = { items = {}, orphans = idQ.new(SL) }
        cat = {items = {}, orphans = {}, provs = {}}
        cats[catName] = cat
    -- self.catQ:push(catName)
    end
    return cat
end

function Force.provCatBest(self, cat)
    local provCat = self:provCat(cat)
    local bestProvID = provCat.bestProvID
    local bestItem = provCat.bestItem
    if (bestProvID) and (bestItem) then
        local bestChest = TC.getObj(best)
        if (bestChest) and (bestChest:itemAmt(bestItem)) then
            return bestChest, bestItem
        end
    end
    local rankedItems = ItemDB.category(cat).items
    for i = 1, #rankedItems do
        local itemName = rankedItems[i]
        local provItem = provCat[itemName]
        if (provItem) and (provItem.count > 0) then
            for id, cons in pairs(provItem.ids) do
                local chest = TC.getObj(id)
                if (chest) then
                    if (chest:itemAmt(itemName) > 0) then
                        provCat.bestProvID = chest.id
                        provCat.bestItem = itemName
                        return chest, itemName
                    end
                else
                    provItem.ids[id] = nil
                end
            end
        end
    end
    return nil
end

function Force.provItem(self, item)
    local inf = itemInfo(item)
    if not inf then
        return
    end
    local cat = self:provCat(inf.category)
    local provItem = cat.items[item]
    if not provItem then
        provItem = {ids = {}, idArray = {}, count = 0}
        cat.items[item] = provItem
    end
    return provItem
end

function Force.addProv(self, chest, item)
    local inf = itemInfo(item)
    if not inf then
        inform("Force.addProv: invalid item " .. tostring(item))
        return
    end
    local cat = inf.category
    local fProvItem = self:provItem(item)
    local provCat = self:provCat(cat)
    local provObj = fProvItem.ids[chest.id]
    if (not provObj) then
        provObj = {}
        fProvItem.ids[chest.id] = provObj
        fProvItem.count = fProvItem.count + 1
    -- provCat.provs[chest.id] =
    end
end

function Force.removeProv(self, chest, item, softRemove)
    inform("force rm prov")
    local inf = itemInfo(item)
    -- local provCats = self.provs.categories
    local provItem = self:provItem(item)
    local reg = provItem.ids[chest.id]
    provItem.ids[chest.id] = nil
    provItem.count = provItem.count - 1
    if (reg) then
        -- local provIDs = provItem.ids
        for consID, t in pairs(reg) do
            local slot = SL.getObj(consID)
            if (slot) then
                -- self:addOrphan(slot)
                -- else
                -- reg[consID] = nil
                -- slot:setBestProv()
                -- self:provCat(slot.consumerCat).orphans[slot.id] = true
                -- self:addOrphan(slot, true)
                -- slot:setBestProv(false, true)
                -- slot:setProv()
                slot:setProv()
                slot:queueAllProvs()

            -- else
            -- self:provCat(slot.consumerCat).orphans[slot.id] = true
            end
        end
    end
end

function Force.catProvsQ(self, catName)
    local cat = self:provCat(catName)
    local provQ = idQ.new(TC, true)
    for itemName, item in pairs(cat.items) do
        for id, cons in pairs(item.ids) do
            provQ:push(id)
        end
    end
    return provQ
end

function Force.consumerList(self, chest, item)
    local provItem = self:provItem(item)
    if (not provItem.ids[chest.id]) then
        return nil
    end
    return provItem.ids[chest.id]
end

function Force.consumerUpgradeList(self, chest, item)
    local provItem = self:provItem(item)
    if (not provItem.ids[chest.id]) then
        return nil
    end
    return self:provItem(item).ids[chest.id].needUpgrade
end

function Force.amtConsumersNeedReturn(self, chest, item)
    local cons = self:consumerList(chest, item)
    if not cons then
        return 0, 0
    end
    local amt = 0
    for slotID, t in pairs(cons) do
        local slot = SL.getObj(slotID)
        if (slot) and (not slot.needProvider) and (slot:needReturn()) then
            amt = amt + 1
        end
    end
    return amt, itemInfo(item).fillLimit * amt
end

function Force.consumerCat(self, catName)
    local res = self.consumerCats[catName]
    if not res then
        res = {slots = {}, items = {{name = "_noItem", score = 0, category = catName, consumers = {}}}}
        res._noItem = res.items[1]
        self.consumerCats[catName] = res
    end
    return res
end
Force.consCat = Force.consumerCat

function Force.consumerItem(self, itemName)
    local inf = ItemDB.item.get(itemName)
    if not inf then
        return nil
    end
    local cat = self:consumerCat(inf.category).items
    local rank = #cat + 1
    for i = 1, rank - 1 do
        local item = cat[i]
        if item.name == itemName then
            return cat[i]
        end
        if (item.score < inf.score) then
            rank = i
            break
        end
    end
    local item = {name = itemName, score = inf.score, category = inf.category, consumers = {}}
    Array.insert(cat, item, rank)
    return item
end
Force.consItem = Force.consumerItem

function Force.addConsumerToCategory(self, slotID, catName)
    local cat = self:consCat(catName)
    cat.slots[slotID] = true
end

function Force.addConsumer(self, slotID, item)
    inform("addCons")
    local slot = SL.getObj(slotID)
    if not slot then
        return
    end
    local consItem = self:consItem(item)
    if not item then
        local consCat = self:consCat(slot.consumerCat)
        consItem = consCat._noItem
    end
    consItem[slotID] = true
end
Force.addCons = Force.addConsumer

function Force.removeConsumer(self, slotID, item)
    inform("removeCons")
    local slot = SL.getObj(slotID)
    if not slot then
        return
    end
    local consItem = self:consItem(item)
    if not item then
        local consCat = self:consCat(slot.consumerCat)
        consItem = consCat._noItem
    end
    consItem[slotID] = nil
end
Force.removeCons = Force.removeConsumer

function Force.purgeConsumer(self, slotID)
    local cats = self.consumerCats
    -- local chestID = chest.id
    for catName, cat in pairs(cats) do
        cat.slots[slotID] = nil
        for rank, item in pairs(cat.items) do
            item[slotID] = nil
        end
    end
end

function Force.forces()
    return global["Force"]["forces"]
end

function Force.get(name)
    local forces = Force.forces()
    local frc = forces[name]
    if not frc then
        frc = Force.new(name)
        forces[name] = frc
    end
    return frc
end

function FRC.getIdentifyingInfo(ent)
    if (not isValid(ent)) then
        return
    end
    local makeInt = math.floor
    -- local ent = obj.ent
    local n = ent.name
    local s = ent.surface.name
    local p = ent.position
    local px = tostring(makeInt(p.x))
    local py = tostring(makeInt(p.y))
    -- local f = ent.force.name
    local id = n .. s .. px .. py
    return id
end

function FRC.purgeAndSearch(self)
    local getID = FRC.getIdentifyingInfo
    local slots = self.slots
    local chests = self.chests
    local stores = self.storageChests
    local ents = {}
    for i = 1, slots:size() do
        local slot = slots:cycle()
        if not slot then
            break
        end
        local id = getID(slot.ent)
        ents[id] = true
    end
    for i = 1, chests:size() do
        local chest = chests:cycle()
        if not chest then
            break
        end
        local id = getID(chest.ent)
        ents[id] = true
    end
    for i = 1, stores:size() do
        local chest = stores:cycle()
        if not chest then
            break
        end
        local id = getID(chest.ent)
        ents[id] = true
    end

    local forceEnts = util.allFind({force = self.name})
    local isTrackable = SL.isTrackable
    local isChest = TC.isChest
    for i = 1, #forceEnts do
        local ent = forceEnts[i]
        local id = getID(ent)
        if (not ents[id]) then
            -- if (isTrackable(ent)) then
            --     -- local f = Force.get(ent.force.name)
            --     -- local sl = self.slots
            --     local dup = false
            --     local cyc = slots.cycle
            --     for i = 1, slots:size() do
            --         local test = cyc(slots)
            --         if (not test) then
            --             break
            --         end
            --         if (test.ent == ent) then
            --             inform("Slot already exists, aborting create.")
            --             dup = true
            --             break
            --         end
            --     end
            --     if (not dup) then
            --         createdQ.push(ent)
            --     end
            -- elseif (isChest(ent)) then
            -- createdQ.push(ent)
            -- end
            if (isTrackable(ent)) or (isChest(ent)) then
                createdQ.push(ent)
            end
        else
            inform("is in list!")
        end
    end
end

function FRC.tickAll()
    for name, frc in pairs(Force.forces()) do
        frc:tick()
    end
end

function FRC.tick(self)
    self.slotsChecked = 0
    local chests = self.chests
    local slots = self.slots
    -- inform("Force " .. self.name .. " has " .. tostring(chestsNum) .. " chests and " .. tostring(slotsNum) .. " slots.")
    if (self.needPurge) then
        self.needPurge = nil
        self:purgeAndSearch()
    end
    local chestsNum = chests:size()
    local slotsNum = slots:size()
    if (chestsNum == 0) or (slotsNum == 0) then
        return nil
    end
    local slotsPer = gSets.slotsPerCycle()
    local chestsPer = gSets.chestsPerCycle()

    local chest = chests:cycle()
    if (chest) then
        chest:tick()
    end

    -- local n = 0
    -- local numChests = chests:size()
    -- self.chests:forEach(TC.tick, chestsPer, true)
    -- while (n < numChests) and (n < chestsPer) and (self.slotsChecked < slotsPer) do
    --     n = n + 1
    --     local chest = chests:cycle()
    --     if (not chest) then
    --         break
    --     end
    --     -- if (chest) then
    --     chest:tick()
    --     -- end
    -- end
    -- if (self.slotsChecked < slotsPer) then
    -- self.orphans:forEach(Force.checkOrphan, slotsPer, false)
    -- self:checkOrphans()
    -- end
    local numOrphs = self.orphans:size()
    n = 0
    while (n < numOrphs) and (n < slotsPer) do
        n = n + 1
        -- local orph = self:nextOrphan()
        local orph = self.orphans:pop()
        if (not orph) then
            break
        end
        -- if (orph.isOrphan) then
        self.slotsChecked = self.slotsChecked + 1
        orph:queueAllProvs()
        -- end
        -- orph:setBestProv()
    end
    -- end
    -- self.slots:forEach(SL.setBestProvider, slotsPer, true)
    self.providedSlots:forEach(SL.doProvide, gSets.maxProvideSlots(), true)
    if (self:doUpgrade()) and (self.storageChests:size() > 0) and (self.slotsChecked < slotsPer) then
        -- self.slotsNeedReturn:forEach(Force.returnSlot, slotsPer - self.slotsChecked, false)
        local nr = self.slotsNeedReturn
        n = 0
        local nrSize = nr:size()
        while (n < nrSize) and (self.slotsChecked < slotsPer) do
            n = n + 1
            local slot = nr:pop()
            if (not slot) then
                break
            end
            Force.returnSlot(slot)
        end
    end
    self.inserters:cycle()
    -- self.inserters:forEach(Force.checkInserter, slotsPer, true)
end

function Force.addOrphan(self, slot, rush)
    -- if (not slot.isOrphan) then
    slot.isOrphan = true
    -- local cat = self:provCat(slot.consumerCat)
    local orphs = self.orphans
    if (rush) then
        orphs:pushleft(slot)
    else
        orphs:push(slot)
    end
    -- end
end
function Force.removeOrphan(self, slot)
    slot.isOrphan = nil
    -- if (slot.isOrphan) then
    -- local orphs = self:provCat(slot.consumerCat).orphans
    -- local orphs = self.orphans
    -- for i = 1, orphs:size() do
    --     local orph = orphs:pop()
    --     if not orph then break end
    --     if (orph.id == slot.id) then
    --         return true
    --     end
    --     orphs:push(orph)
    -- end
    -- return Force.removeOrphanID(self, slot.id)
    -- end
    return false
end
function Force.nextOrphan(self)
    local orphs = self.orphans
    local next = orphs:pop()
    if (next) then
        if (not next.isOrphan) then
            return self:nextOrphan()
        end
        -- next.isOrphan = false
        -- orphs:push(next)
        return next
    end
    return nil
end

function Force.checkOrphan(slot)
    local f = slot:force()
    if (f.slotsChecked >= gSets.slotsPerCycle()) then
        return
    end
    f.slotsChecked = f.slotsChecked + 1
    local foundProv = slot:setBestProv(false, true)
    if not (foundProv) then
        f:addOrphan(slot)
    end
end

function Force.returnSlot(slot)
    local f = slot:force()

    local prov = slot:provider()
    local filterInf = slot:filterInfo()
    if (not prov) then
        return false
    end
    local stack = slot:itemStack()
    if (stack.count <= 0) then
        return false
    end
    local itemInf = itemInfo(stack.name)
    if (itemInf.rank <= filterInf.rank) then
        return false
    end
    f.slotsChecked = f.slotsChecked + 1
    local amt = prov:itemAmt(filterInf.name)
    if (amt >= filterInf.fillLimit) then
        slot:returnItems()
        prov:itemAmt(filterInf.name, amt - filterInf.fillLimit)
        return true
    else
        -- slot._needReturn = true
        f.slotsNeedReturn:push(slot)
    end
    return false
end

function Force.checkSlot(slot)
    slot.needCheck = false
    slot:setBestProvider()
end

function Force.checkInserter(ins)
    -- if (not ins) then
    --     return
    -- end
    if (not ins:isValid()) then
        ins:destroy()
    end
end

Force.inv = {}
function Force.inv.insert(self, stack)
    if (not stack) or (stack.count <= 0) then
        return 0
    end
    local inv = self._inv
    if (not inv[stack.name]) then
        inv[stack.name] = 0
    end
    inv[stack.name] = inv[stack.name] + stack.count
    return stack.count
end
function Force.inv.remove(self, stack)
    if (not stack) or (stack.count <= 0) then
        return 0
    end
    local inv = self._inv
    if (not inv[stack.name]) then
        inv[stack.name] = 0
    end
    local amt = inv[stack.name]
    if (stack.count > amt) then
        stack.count = amt
    end
    inv[stack.name] = inv[stack.name] - stack.count
    return stack.count
end
function Force.inv.count(self, item)
    return self._inv[item] or 0
end

function FRC.addChest(self, chestObj)
    if (chestObj.isStorage) then
        self.storageChests:push(chestObj)
    else
        self.chests:push(chestObj)
    end
end
function FRC.addSlot(self, slotObj)
    -- local cat = self:consumerCat(slotObj.consumerCat)
    -- cat[slotObj.id] = true
    if (slotObj.isProvided) then
        self.providedSlots:pushleft(slotObj)
    end
    if (slotObj.canMove) then
        self.slotsCanMove:push(slotObj)
    end
    self.slots:push(slotObj)
    self:provCat(slotObj.consumerCat).orphans[slotObj.id] = true
end

function Force.addInserter(self, ins)
    self.inserters:push(ins)
end

function FRC.isValid(self)
    if (not self) then
        return false
    end
    if game.forces[self.name] ~= nil then
        return true
    end
    return false
end

return Force
