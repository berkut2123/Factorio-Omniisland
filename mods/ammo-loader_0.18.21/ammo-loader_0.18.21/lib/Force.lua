---@class Force
Force = {}
Force.objMT = {__index = Force}

Force._init = function()
    global["Force"] = {}
    global["Force"]["forces"] = {}
    -- for name, frc in pairs(game.forces) do
    -- global["Force"]["forces"][name] = Force.new(name)
    -- end
    -- Force._globs()
end
Init.registerFunc(Force._init)

Force._onLoad = function()
    -- Force._globs()
    for name, frc in pairs(Force.forces()) do
        setmetatable(frc, Force.objMT)
        setmetatable(frc.needRemoveProv, Queue.objMT)
        for key, meta in pairs(Force.metaVars) do
            setmetatable(frc[key], meta)
        end
        -- setmetatable(frc, Force.objMT)
        -- setmetatable(frc.chests, idQ.objMT)
        -- setmetatable(frc.slots, idQ.objMT)
        -- setmetatable(frc.orphans, idQ.objMT)
        -- setmetatable(frc.catQ, Q.objMT)
        -- setmetatable(frc.inserters, idQ.objMT)
        -- setmetatable(frc.providedSlots, idQ.objMT)
        -- setmetatable(frc.slotsNeedReturn, idQ.objMT)
        -- setmetatable(frc.storageChests, idQ.objMT)

        -- for catName, cat in pairs(frc.provs.categories) do
        --     setmetatable(cat.orphans, idQ.objMT)
        -- end
    end
end
Init.registerOnLoadFunc(Force._onLoad)

Force.metaVars = {
    chests = idQ.objMT,
    storageChests = idQ.objMT,
    -- slots = idQ.objMT,
    -- slotsCheckBestProvQ = idQ.objMT,
    slotsNeedReturnQ = idQ.objMT,
    -- orphans = idQ.objMT,
    -- inserters = idQ.objMT,
    providedSlots = idQ.objMT
    -- needReturn = idQ.objMT
}

---@return Force
function Force.new(name)
    ---@type Force
    local obj = {}
    setmetatable(obj, Force.objMT)
    obj.name = name
    obj.chests = idQ.newChestQ(true)
    -- obj.chestCurID = 1
    obj.curChestID = 1
    obj.storageChests = idQ.newChestQ(true)
    obj.forceInv = game.create_inventory(64)
    -- obj.slots = idQ.newSlotQ(true)
    -- obj.slotsCheckBestProvQ = idQ.newSlotQ(true)
    obj.slotsNeedReturnQ = idQ.newSlotQ(true)
    -- obj.slotCurID = 1
    obj.curCheckProvID = 1
    -- obj.orphans = idQ.newSlotQ(true)
    -- obj.inserters = idQ.newInserterQ(true)
    obj.providedSlots = idQ.newSlotQ(true)
    obj.providedSlotCurID = 1
    -- obj.needReturn = idQ.newSlotQ(true)
    -- obj.trackedEnts = {}
    obj.needRemoveProv = Queue.new()
    -- obj.slotsNeedReturn = idQ.new(SL, true)
    -- obj.slotsChecked = 0
    -- obj.tickNext = "chests"
    obj.techs = {}
    obj:getTechs()
    -- if (gSets.rangeIsInfinite()) then
    obj.provCats = {}
    obj.checkProvCats = {}
    -- end
    obj.entFilters = {}
    return obj
end

function Force:getTechs()
    self.techs = {}
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
                recipes[protoNames.chests.loader].enabled = true
            elseif (tech.name == protoNames.tech.requester) then
                recipes[protoNames.chests.requester].enabled = true
                recipes[protoNames.chests.passiveProvider].enabled = true
            elseif (tech.name == protoNames.tech.upgrade) then
                recipes[protoNames.chests.storage].enabled = true
            end
            self.techs[name] = true
        end
    end
    for techName, tech in pairs(forceTechs) do
        local effects = tech.effects
        for _, effect in pairs(effects) do
            if (effect.type == "unlock-recipe") and (effect.recipe:find("ammo.loader.cartridge")) then
                recipes[effect.recipe].enabled = tech.researched
            end
        end
    end
end

function Force:isResearched(techName)
    if (not gSets.useTech()) or (self.techs[techName]) then
        -- if (not gSets.useTech()) or (game.forces[self.name].technologies[techName].researched) then
        return true
    end
    return false
end

function Force:doUpgrade()
    if (not gSets.doUpgrade()) or (not self:isResearched(protoNames.tech.upgrade)) then
        return false
    end
    return true
end
function Force:doVehicles()
    if (self:isResearched(protoNames.tech.vehicles)) then
        return true
    end
    return false
end
function Force:doFuel()
    if (self:isResearched(protoNames.tech.burners)) then
        return true
    end
    return false
end
function Force:doArtillery()
    if (not gSets.doArtillery()) or (not self:isResearched(protoNames.tech.artillery)) then
        return false
    end
    return true
end
function Force:doBurners()
    if (not gSets.doBurners()) or (not self:isResearched(protoNames.tech.burners)) then
        return false
    end
    return true
end
function Force:doReturn()
    if (not gSets.doReturn()) or (not self:isResearched(protoNames.tech.returnItems)) then
        return false
    end
    return true
end

---@return table<string, Force>
function Force.forces()
    return global["Force"]["forces"]
end

---Get Force by name
---@param name string
---@return Force
function Force.get(name)
    if not name then
        return nil
    end
    local forces = Force.forces()
    ---@type Force
    local frc = forces[name]
    if not frc then
        frc = Force.new(name)
        forces[name] = frc
    end
    return frc
end

function Force.tickAll()
    for name, frc in pairs(Force.forces()) do
        frc:tick()
    end
end

function Force:tick()
    -- local prof = game.create_profiler()
    -- Profiler.Start()
    -- self.slotsChecked = 0
    -- local chests = self.chests
    -- local slots = self.slots
    -- if (self.needPurge) then
    --     self.needPurge = nil
    --     self:purgeAndSearch()
    -- end
    -- local chestsNum = self.chests:size()
    -- local slotsNum = self.slots:size()
    -- if (chestsNum == 0) or (slotsNum == 0) then
    -- return nil
    -- end
    -- local tick = gSets.tick()

    -- SL.tickForce(self.name)

    -- self:tickReturn()
    -- self:tickOrphans()
    -- Profiler.Start()
    self:tickChests()
    -- Profiler.Stop()
    -- log("tick Chests")
    -- log(prof)
    -- prof.reset()
    -- Profiler.Start()
    self:tickCheckBestProvs3()
    -- Profiler.Stop()
    -- log("tick CheckProv")
    -- log(prof)
    -- prof.reset()
    -- Profiler.Start()
    self:tickReturn()
    -- Profiler.Stop()
    -- log("tick Return")
    -- log(prof)
    -- prof.reset()
    -- self:tickNeedRemoveProv()
    -- Profiler.Start()
    self:tickProvidedSlots()
    -- Profiler.Stop()
    -- log("tick Prov Slots")
    -- log(prof)
    -- prof.reset()
    -- log("Force tick")
    -- log(prof)
    -- Profiler.Stop()
    -- game.show_message_dialog({text = {""}})
end

-- function Force:iterSlots(limit, startID)
--     local slIter = SL.slotIter(limit, startID)
--     --- @return Slot
--     local function iter()
--         local slot = slIter()
--         if (not slot) then
--             return
--         end
--         if (slot._forceName ~= self.name) then
--             return iter()
--         end
--         return slot
--     end
--     return iter
-- end

function Force:getEntFilter(name)
    return self.entFilters[name]
end

function Force:setEntFilter(name, newFilter, newMode)
    if (not name) then
        return
    end
    if (not newFilter) then
        self.entFilters[name] = nil
    else
        newMode = newMode or "whitelist"
        self.entFilters[name] = {filter = newFilter, mode = newMode}
    end
end

---Check that the force filter allows a given slot to be provided a given item
function Force:entFilterAllows(slot, item)
    if (not slot) or (not item) then
        return
    end
    local filterInfo = self:getEntFilter(slot:entName())
    if (not filterInfo) then
        return true
    end
    local filter = filterInfo.filter
    local mode = filterInfo.mode
    if (filter[item]) then
        if (mode == "whitelist") then
            return true
        elseif (mode == "blacklist") then
            return false
        end
    else
        if (mode == "whitelist") then
            return false
        elseif (mode == "blacklist") then
            return true
        end
    end
end

---@class betterOrCloserTable Table with chest and item for use with Slot:isBetterOrCloser().
---@field chest Chest
---@field item string

---@class slotIterFilter Table of options for use with Force:iterSlots().
---@field includeDisabled boolean
---@field category string
---@field isBetterOrCloser betterOrCloserTable
---@field inRangeOf chest
---@field filter string
---@field filterWorseThan string
---@field filterBetterThan string
---@field sourceID number
---@field provIsFarther chest
---@field nonMatchReturnID boolean

---Iterate through all slots in DB, returning only those belonging to this Force and that match specified filters.
---@param limit number
---@param startID number
---@param opts slotIterFilter possible values are {includeDisabled=(bool), category=(string), isBetterOrCloser=({chest=chest, item=string}), inRangeOf=chest, filter=string, filterWorseThan=string, filterBetterThan=string, sourceID=number(chestID), provIsFarther=chest}
---@return fun():Slot
function Force:iterSlots(limit, startID, opts)
    startID = startID or 1
    opts = opts or {}
    local i = 1
    local curID = startID
    local curIDFunc = function()
        return curID
    end
    local highest = DB.highest(SL.dbName)
    local getObj = DB.getObj
    local function iter()
        if (curID > highest) or ((limit) and (i > limit)) then
            return
        end
        local nonMatchFunc = iter
        if (opts.nonMatchReturnID) then
            nonMatchFunc = curIDFunc
        end
        --- @type Slot
        local slot = getObj(SL.dbName, curID)
        curID = curID + 1
        if (not slot) or (slot:forceName() ~= self.name) then
            return nonMatchFunc()
        -- return iter()
        end
        if (not slot:enabled()) and (not opts.includeDisabled) then
            return nonMatchFunc()
        -- return iter()
        end
        if (opts.category) and (opts.category ~= slot:category()) then
            return nonMatchFunc()
        -- return iter()
        end
        if (opts.isBetterOrCloser) then
            local newChest = opts.isBetterOrCloser.chest
            local newItem = opts.isBetterOrCloser.item
            if (not slot:itemIsBetterOrCloser(newItem, newChest)) then
                return nonMatchFunc()
            -- return iter()
            end
        end
        if (opts.inRangeOf) and (not slot:isInRange(opts.inRangeOf)) then
            return nonMatchFunc()
        -- return iter()
        end
        if (opts.filter) and (opts.filter ~= slot:filterItem()) then
            return nonMatchFunc()
        -- return iter()
        end
        if
            (opts.filterWorseThan) and (slot:filterItem()) and
                (itemInfo(opts.filterWorseThan).rank > slot:filterInfo().rank)
         then
            return nonMatchFunc()
        -- return iter()
        end
        if
            (opts.filterBetterThan) and
                ((not slot:filterItem()) or (itemInfo(opts.filterBetterThan).rank < slot:filterInfo().rank))
         then
            return nonMatchFunc()
        -- return iter()
        end
        if (opts.sourceID) and (opts.sourceID ~= slot:sourceID()) then
            return nonMatchFunc()
        -- return iter()
        end
        if (opts.provIsFarther) and (not slot:compareProvsByDist(opts.provIsFarther, slot:sourceID())) then
            return nonMatchFunc()
        -- return iter()
        end
        if (not slot.ent) or (not slot.ent.valid) then
            slot:destroy()
            return nonMatchFunc()
        -- return iter()
        end
        i = i + 1
        return slot
    end
    return iter
end

-- function Force:iterCheckProvSlots(limit, startID)
--     limit = limit or math.huge
--     startID = startID or 1
--     local i = startID - 1
--     local highest = DB.highest(SL.dbName)
--     --- @return Slot
--     local function iter()
--         i = i + 1
--         if (i > highest) or (i - startID >= limit) then
--             return
--         end
--         local slot = DB.getObj(SL.dbName, i)
--         if (not slot) or (slot:forceName() ~= self.name) or (not slot) then
--             return iter()
--         end
--         return slot
--     end
--     return iter
-- end

function Force:slotsQ()
    local q = idQ.newSlotQ(true)
    for i = 1, DB.highest(SL.dbName) do
        local slot = DB.getObj(SL.dbName, i)
        if (slot) and (slot:forceName() == self.name) then
            q:push(slot)
        end
    end
    return q
end

function Force:tickProvidedSlots()
    -- if (self.providedSlots:isEmpty()) then
    -- return
    -- end
    -- local n = 0
    local max = gSets.maxProvideSlots()
    -- for slot in self:iterSlots(nil, self.providedSlotCurID) do
    for slot in self.providedSlots:slotIter(max, true) do
        -- if (slot._forceName == self.name) then
        -- self.providedSlotCurID = slot.id
        if (slot:isProvided()) then
            slot:doProvide()
            -- n = n + 1
            self.providedSlots:push(slot)
        end
        -- if (n >= max) then
        -- break
        -- end
        -- end
    end
    -- if (self.providedSlotCurID >= DB.highest(SL.dbName)) then
    -- self.providedSlotCurID = 1
    -- end
end

---@class iterChestsOptions Table for use with Force:iterChests() defining optional filters.
---@field storage boolean

---Returns a function(iterator) that, when called, gives a single chest in the database belonging to this force and matching all set filters.
---@param limit number Maximum number of iterations to perform.
---@param startID number Start at this ID in the database. Continues up from there.
---@param opts table
---@return fun():Chest
function Force:iterChests(limit, startID, opts)
    limit = limit or nil
    startID = startID or 1
    opts = opts or {}
    local i = 1
    local curID = startID
    local highest = DB.highest(TC.dbName)
    local getObj = DB.getObj
    local function iter()
        if (curID > highest) or ((limit) and (i > limit)) then
            return
        end
        --- @type Chest
        local chest = getObj(TC.dbName, curID)
        curID = curID + 1
        if (not chest) or (chest:forceName() ~= self.name) then
            -- elseif (opts.category) and (opts.category ~= slot:category()) then
            --     return iter()
            -- elseif (opts.filter) and (opts.filter ~= slot:filterItem()) then
            --     return iter()
            -- elseif
            --     (opts.filterWorseThan) and (slot:filterItem()) and
            --         (itemInfo(opts.filterWorseThan).rank > slot:filterInfo().rank)
            --  then
            --     return iter()
            -- elseif
            --     (opts.filterBetterThan) and
            --         ((not slot:filterItem()) or (itemInfo(opts.filterBetterThan).rank < slot:filterInfo().rank))
            --  then
            --     return iter()
            -- elseif (opts.sourceID) and (opts.sourceID ~= slot:sourceID()) then
            --     return iter()
            -- elseif (opts.provIsFarther) and (not slot:compareProvsByDist(opts.provIsFarther, slot:sourceID())) then
            --     return iter()
            return iter()
        end
        if (opts.storage) and (not chest:isStorage()) then
            return iter()
        end
        if (not chest.ent) or (not chest.ent.valid) then
            chest:destroy()
            return iter()
        end
        i = i + 1
        return chest
    end
    return iter
end

function Force:tickChests()
    -- local entries = DB.getEntries(TC.dbName)
    -- local id, chest = next(entries, self.chestCurID)
    -- if (not chest) then
    --     if (not id) then
    --         self.chestCurID = 1
    --     else
    --         entries[id] = nil
    --     end
    -- elseif (not chest:isValid()) then
    --     chest:destroy()
    -- else
    --     self.chestCurID = id
    --     chest:tick()
    -- end
    local i = 0
    for chest in self:iterChests(1, self.curChestID) do
        i = i + 1
        self.curChestID = chest.id + 1
        chest:tick()
    end
    if (i == 0) or (self.curChestID > DB.highest(TC.dbName)) then
        self.curChestID = 1
    end
    -- local chest = self.chests:cycle()
    -- if (chest) then
    -- chest:tick()
    -- end
end
function Force:tickOrphans()
    for orph in self.orphans:slotIter(gSets.orphansPerCycle(), true) do
        if (orph.enabled) then
            self.slotsChecked = self.slotsChecked + 1
            orph:queueAllProvs(true)
        end
    end
end

function Force:tickReturn()
    if (not self:doReturn()) or (self.slotsNeedReturnQ:isEmpty()) then
        return
    end
    for slot in self.slotsNeedReturnQ:slotIter(gSets.maxReturnSlots(), true) do
        if (slot:needsReturn()) then
            local remain = slot:returnItems()
            if (remain.count > 0) then
                self.slotsNeedReturnQ:push(slot)
            end
        end
        -- local prov = slot:provider()
        -- local filterInf = slot:filterInfo()
        -- local curAmt = prov:itemAmt(filterInf.name)
        -- if (curAmt < filterInf.fillLimit) then
        --     self.needReturn:push(slot)
        -- elseif (slot:needsReturn()) then
        --     slot:returnItems()
        --     prov:itemAmt(filterInf.name, curAmt - filterInf.fillLimit)
        -- end
    end
end

function Force:enableReturn()
    for slot in self:iterSlots() do
        if (slot:needsReturn()) then
            self.slotsNeedReturnQ:push(slot)
        end
    end
end

function Force:enableUpgrade()
    for slot in self:iterSlots() do
        slot:setBestProvider()
    end
end

function Force:checkEnabledSlots()
    for slot in self:iterSlots(nil, nil, {includeDisabled = true}) do
        local enabled = slot:checkEnabled()
        if (not enabled) and (slot:enabled()) then
            slot:disable()
        elseif (enabled) and (not slot:enabled()) then
            slot:enable()
        end
    end
end

function Force:tickNeedRemoveProv()
    local q = self.needRemoveProv
    if (q:size() <= 0) then
        return
    end
    local n = 0
    local max = gSets.slotsPerCycle()
    local rmInfo
    --- @type Chest
    local rmChest
    ---@type Item
    local rmItemInf
    ---@type Slot
    local rmSlot
    ---@type fun(self:Slot, chest:Chest, item:Item)
    local rmFunc
    for i = 1, q:size() do
        rmInfo = self.needRemoveProv:pop()
        if (not rmInfo) then
            return
        end

        rmChest = TC.getObj(rmInfo.chest)
        rmItemInf = itemInfo(rmInfo.item)
        -- local curEmpty = rmInfo.curEmpty
        -- if (rmInfo.type == "add") and (not empty(rmChest)) and (not curEmpty) then
        -- rmInfo.emptyQ = emptyQ
        -- for slot in rmChest:getSlotsInRange(false, true, true):slotIter() do
        -- if (slot:itemStack().count <= 0) then
        -- emptyQ:push(slot)
        -- end
        -- end
        -- curEmpty = rmInfo.curSlot
        -- rmInfo.curEmpty = curEmpty
        -- else
        -- curEmpty = 0
        -- end
        if (rmInfo.type == "add") then
            rmFunc = SL.addProv
        elseif (rmInfo.type == "remove") then
            rmFunc = SL.removeProv
        end
        -- if (not empty(rmChest)) then
        if
            (not rmChest or not rmItemInf) or
                ((rmInfo.type == "add") and (rmChest:itemAmt(rmItemInf.name) >= rmItemInf.fillLimit) or
                    ((rmInfo.type == "remove") and (rmChest:itemAmt(rmItemInf.name) < rmItemInf.fillLimit)))
         then
            -- for slot in SL.slotIter(nil, rmInfo.curSlot) do
            --     if
            --         ((rmInfo.type == "add") and
            --             ((not rmChest or not rmItemInf) or (rmChest:itemAmt(rmItemInf.name) < rmItemInf.fillLimit)))
            --      then
            --         break
            --     end
            --     rmInfo.curSlot = slot.id
            --     local itemName
            --     if (not empty(rmItemInf)) then
            --         itemName = rmItemInf.name
            --     end
            --     local res = rmFunc(slot, rmInfo.chest, rmInfo.item)
            --     if (res) then
            --         n = n + 1
            --     end
            -- end
            local isDone = false
            while (n < max) and
                ((rmInfo.type == "remove") or (not rmChest or not rmItemInf) or
                    (rmChest:itemAmt(rmItemInf.name) >= rmItemInf.fillLimit)) do
                local rmSlot
                -- if (curEmpty > 0) then
                -- rmSlot = SL.getObj(curEmpty)
                -- rmInfo.curEmpty = rmInfo.curEmpty - 1
                -- else
                id, rmSlot = next(DB.getEntries(SL.dbName), rmInfo.curSlot)
                if (not id) then
                    isDone = true
                    break
                end
                rmInfo.curSlot = id
                n = n + 1
                -- rmInfo.curSlot = rmInfo.curSlot + 1
                -- end
                if (not empty(rmSlot)) then
                    -- and (curEmpty <= 0 or rmSlot:itemStack().count <= 0) then
                    local itemName
                    if (not empty(rmItemInf)) then
                        itemName = rmItemInf.name
                    end
                    local res = rmFunc(rmSlot, rmInfo.chest, rmInfo.item)
                -- if (res) then
                -- end
                end
            end
            if (not isDone) then
                self.needRemoveProv:pushleft(rmInfo)
            end
            if (n >= max) then
                break
            end
        else
        end
        -- end
    end
end

function Force:slotsFiltered(opts)
    local q = idQ.newSlotQ(true)
    local bestItem = opts.item
    local bestItemInf = itemInfo(opts.item)
    local bestItemCat
    if (bestItemInf) then
        bestItemCat = bestItemInf.category
    end
    local cat = opts.category or bestItemCat
    local area = opts.area
    ---@type Chest
    local inRangeOf = opts.chest
    ---@type Chest
    local chest = opts.chest
    for slot in self.slots:slotIter() do
        if (slot.enabled) then
            local catBool = ((not cat) or (slot:category() == cat))
            local betterBool = ((not bestItem) or (slot:itemIsBetterOrCloser(bestItem, chest)))
            local inRangeBool = ((not inRangeOf) or (slot:isInRange(inRangeOf)))
            if (catBool) and (betterBool) and (inRangeBool) then
                q:push(slot)
            end
        end
    end
    return q
end

function Force:chestsFiltered(opts)
    local q = idQ.newChestQ(TC, true)
    ---@type Slot
    local slot = opts.slot
    local minItem = opts.minItem
    local cat = opts.category
    if (slot) then
        minItem = slot:filterItem()
        cat = slot:category()
    end
    for chest in self.chests:chestIter() do
        local hasEqual = chest:hasBetterProvItem(minItem, true)
        if
            ((not cat) or (chest:hasProvCat(cat))) and ((not minItem) or (chest:hasBetterOrCloserItem(opts.slot))) and
                ((not slot) or (chest:isInRange(slot)))
         then
            q:push(chest)
        end
    end
    return q
end

---@param chestObj Chest
function Force:addChest(chestObj)
    if (chestObj:isStorage()) then
        local isFirst = self.storageChests:isEmpty()
        self.storageChests:push(chestObj)
        if (isFirst) then
            for slot in self:iterSlots() do
                slot:setBestProvider()
                -- self.orphans:push(slot)
                -- slot.isOrphan = true
            end
        end
    else
        self.chests:push(chestObj)
    end
end

---@param slotObj Slot
function Force:addSlot(slotObj)
    -- self.slots:push(slotObj)
    -- self.slotsCheckBestProvQ:pushleft(slotObj)
    if (slotObj:isProvided()) then
        self.providedSlots:pushleft(slotObj)
    end
    -- slotObj.isOrphan = true
    -- if (slotObj:isCharacter()) then
    -- slotObj:updateCategory()
    -- end
    -- slotObj:queueAllProvs(true)
    -- self.orphans:pushleft(slotObj)
end

---@param ins HiddenInserter
function Force:addInserter(ins)
    self.inserters:push(ins)
end

function Force:isValid()
    if (not self) then
        return false
    end
    if game.forces[self.name] ~= nil then
        return true
    end
    return false
end

---@param stack ItemStack
---@param slot Slot Slot that this stack will come from, used to test range.
---@return ItemStack Stack of items that were unable to be put in storage.
function Force:sendToStorage(stack, slot)
    if (not stack) or (stack.count <= 0) then
        return SL.emptyStack()
    end
    -- local chests = self.storageChests
    -- if (chests:size() <= 0) then
    -- return 0
    -- end
    -- local amt = stack.count
    ---@type iterChestsOptions
    local iterOpts = {storage = true}
    for chest in self:iterChests(nil, nil, iterOpts) do
        -- for chest in chests:chestIter() do
        local inserted = chest:inv().insert(stack)
        stack.count = stack.count - inserted
        if (stack.count <= 0) then
            stack.count = 0
            return stack
        end
    end
    return stack
end

function Force:forceInvInsert(stack)
    local inv = self.forceInv
    if (not stack) or (stack.count <= 0) then
        return 0
    end
    local insertable = inv.get_insertable_count(stack.name)
    if (insertable < stack.count) then
        if (inv.count_empty_stacks() <= 0) then
            inv.resize(#inv + 2)
            return self:forceInvInsert(stack)
        else
            cInform("warning: could not insert into force inventory for unknown reasons.")
            return 0
        end
    end
    return inv.insert(stack)
end

function Force:forceInvRemove(stack)
    local inv = self.forceInv
    if (not stack) or (stack.count <= 0) then
        return 0
    end
    return inv.remove(stack)
end

---@param forceEmpty bool
function Force:returnAll(forceEmpty)
    for slot in self:iterSlots() do
        slot:returnItems(forceEmpty)
    end
end

---Register a chest as a provider for a specific item with the force's provider table
---@param chest Chest
---@param item string
function Force:registerProv(chest, item)
    -- Profiler.Start()
    if (not chest) or (not item) then
        return
    end
    local itemInf = itemInfo(item)
    local provItems = self.provCats[itemInf.category]
    if (not provItems) then
        provItems = {}
        self.provCats[itemInf.category] = provItems
    end
    local chestID = chest.id
    local provs = provItems[itemInf.rank]
    if (not provs) then
        provs = {}
        provItems[itemInf.rank] = provs
    end
    --*prioritize character/vehicles for new provider*
    self:checkProvidedBestProvs(chest, item)
    if (provs[chestID]) then
        return
    end
    provs[chestID] = 1
    self.checkProvCats[itemInf.category] = 1
end

function Force:removeProv(chest, item)
    local inf = itemInfo(item)
    self.provCats[inf.category][inf.rank][chest.id] = nil
    self.checkProvCats[inf.category] = 1
    -- local provItems = self.provCats[inf.category]
    -- if (provItems) then
    --     for rank, provList in pairs(provItems) do
    --         for provID, curSlotID in pairs(provList) do
    --             provList[provID] = 1
    -- end
    --     end
    -- end
    ---@type slotIterFilter
    local opts = {
        category = inf.category,
        sourceID = chest.id,
        filter = item
    }
    for slot in self:iterSlots(nil, nil, opts) do
        -- local id = slots.entries[i]
        -- local slot = DB.getObj(SL.dbName, id)
        -- local sourceID = slot:sourceID()
        -- local filterItem = slot:filterItem()
        -- if (sourceID) and (filterItem) and (sourceID == chest.id) and (filterItem == item) then
        -- serpLog(slot:filterItem())
        -- local filterItem = slot:filterItem()
        -- if (not filterItem) or (filterItem == item) or (not chest:isProvidingItem(filterItem)) then
        slot:setProv()
        slot:setBestProvider()
        -- end
        -- self.slotsCheckBestProvQ:push(slot)
        -- slot:checkProv(true)
        -- end
    end
end

function Force:removeProvID(chestID)
    for cat, items in pairs(self.provCats) do
        for itemRank, provs in pairs(items) do
            provs[chestID] = nil
        end
    end
    -- local slots = self.slots
    for slot in self:iterSlots(nil, nil, {sourceID = chestID}) do
        -- local id = slots.entries[i]
        -- local slot = DB.getObj(SL.dbName, id)
        -- local sourceID = slot:sourceID()
        -- if (sourceID) and (sourceID == chestID) then
        slot:setProv()
        slot:setBestProvider()
        -- self.slotsCheckBestProvQ:push(slot)
        -- slot:checkProv(true)
        -- end
    end
end

---@param chest Chest
---@param itemName string
function Force:checkProvidedBestProvs(chest, itemName)
    local itemInf = itemInfo(itemName)
    if (not chest) or (not itemInf) then
        return
    end
    for slot in self.providedSlots:slotIter() do
        if
            (slot:enabled()) and (slot:canMove()) and (slot:category() == itemInf.category) and
                (slot:itemIsBetterOrCloser(itemInf.name, chest))
         then
            slot:setProv(chest, itemInf.name)
            local needRet = slot:needsReturn()
            local fillLimit = slot:fillLimit()
            if (not needRet) then
                local slotStack = slot:itemStack()
                if (slotStack.count <= 0) then
                    chest:cacheRemove(itemInf.name, fillLimit)
                else
                    chest:cacheRemove(itemInf.name, fillLimit - slotStack.count)
                end
            elseif (self:doUpgrade()) then
                self.slotsNeedReturnQ:push(slot, true)
                -- slot:returnItems()
                chest:cacheRemove(itemInf.name, fillLimit)
            end
        end
    end
end

function Force:tickCheckBestProvs3()
    local itemInfo = itemInfo
    local slotLimit = gSets.maxSlotsCheckProvPerTick
    local highest = DB.highest(SL.dbName)
    local doUpgrade = self:doUpgrade()
    local doReturn = self:doReturn()
    for cat, provItems in pairs(self.provCats) do
        local catItemsByRank = ItemDB.cat(cat)
        for rank, provs in pairs(provItems) do
            local item = itemInfo(catItemsByRank[rank])
            for provID, curSlotID in pairs(provs) do
                local abortProv = false
                local c = 0
                if (curSlotID <= highest) then
                    local prov = TC.getObj(provID)
                    if (not prov) then
                        provs[provID] = nil
                    else
                        -- if (provs[provID] == 0) then
                        --     self:checkProvidedBestProvs()
                        --     provs[provID] = 1
                        -- end
                        -- if (curSlotID == provs[provID]) then
                        --     provs[provID] = highest + 1
                        -- end
                        if (prov:itemAmt(item.name) >= item.fillLimit) and (provs[provID] <= highest) then
                            for slot in self:iterSlots(
                                slotLimit,
                                curSlotID,
                                {
                                    category = cat,
                                    isBetterOrCloser = {chest = prov, item = item.name},
                                    nonMatchReturnID = true
                                }
                            ) do
                                -- c = c + 1
                                -- if (c > slotLimit) then
                                --     break
                                -- end
                                if (type(slot) == "number") then
                                    provs[provID] = slot + 1
                                else
                                    -- if (c > slotLimit) then
                                    --     break
                                    -- end
                                    local fillLimit = slot:fillLimit()
                                    -- if (prov:itemAmt(item.name) < slot:fillLimit()) then
                                    --     break
                                    -- end

                                    if (slot:itemIsBetterOrCloser(item.name, prov)) then
                                        slot:setProv(prov, item.name)
                                        local needsRet = slot:needsReturn()
                                        local slotStack = slot:itemStack()
                                        if (needsRet) then
                                            self.slotsNeedReturnQ:push(slot, true)
                                            -- slot:returnItems()
                                            prov:cacheRemove(item.name, fillLimit)
                                        elseif (slotStack.count <= 0) then
                                            prov:cacheRemove(item.name, fillLimit)
                                        else
                                            prov:cacheRemove(item.name, fillLimit - slotStack.count)
                                        end
                                    -- if (slot:itemIsBetterOrCloser(item.name, prov)) then
                                    -- local curStackInfo = slot:slotItemInfo()
                                    -- local curStack = slot:itemStack()
                                    -- local curStackInfo = itemInfo(curStack.name)
                                    -- if (not curStackInfo) then
                                    --     prov:cacheRemove(item.name, fillLimit)
                                    -- elseif (curStackInfo.rank > item.rank) then
                                    --     if (doReturn) then
                                    --         self.slotsNeedReturnQ:push(slot)
                                    --         prov:cacheRemove(item.name, fillLimit)
                                    --     end
                                    -- elseif (curStackInfo.rank == item.rank) then
                                    --     local dif = fillLimit - curStack.count
                                    --     prov:cacheRemove(item.name, dif)
                                    -- end
                                    -- slot:setProv(prov, item.name)
                                    end
                                    provs[provID] = slot.id + 1
                                    c = c + 1
                                    if
                                        (prov:itemAmt(item.name) < fillLimit) or (c > slotLimit) or
                                            (provs[provID] > highest)
                                     then
                                        break
                                    end
                                end
                                -- if (provs[provID] > highest) then

                                -- serpLog("provID ", provID, " checkBestQ finished")
                                -- else
                                -- cInform("provID ", provID, " curSlotID is ", provs[provID])
                                -- end
                            end
                        end
                    end
                -- if (prov) and (prov:itemAmt(item.name) >= item.fillLimit) then
                -- end
                end
            end
        end
        -- if (c >= slotLimit) then
        --     break
        -- end
    end
end

return Force
