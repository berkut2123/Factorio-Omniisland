---Chests represent a single Loader Chest in-game.
---@class Chest : dbObject
TC = {}

TC.className = "TrackedChest"
TC.dbName = TC.className
DB.register(TC.dbName)
TC.objMT = {
    __index = TC
}

function TC._init()
    -- util.destroyAll(TC.indicators.infinite)
    -- DB.new(TC.dbName)
    global["TC"] = {}
    -- global["TC"]["chestNames"] = TC.findChestNames()
end
Init.registerFunc(TC._init)

function TC._preInit()
    if (not global.DB) then
        return
    end
    local chestFilters = {}
    for id, chest in pairs(DB.getEntries(TC.dbName)) do
        if (chest) and (chest.ent) and (chest.ent.valid) and (chest._entFilter) and (table_size(chest._entFilter) > 0) then
            table.insert(chestFilters, {ent = chest.ent, filters = chest._entFilter, filterMode = chest._entFilterMode})
        end
    end
    global.persist.chestFilters = chestFilters
end
Init.registerPreInitFunc(TC._preInit)

function TC._onLoad()
    for id, obj in pairs(DB.getEntries(TC.dbName)) do
        setmetatable(obj, TC.objMT)
        -- setmetatable(obj._consumers, idQ.objMT)
        -- setmetatable(obj.addQ, idQ.objMT)
        -- setmetatable(obj.slotsInRange, idQ.objMT)
        -- setmetatable(obj._slotsInRangeQ, idQ.objMT)
        -- for item, qList in pairs(obj.provItems) do
        --     if (qList.orphanQ) then
        --         setmetatable(qList.orphanQ, idQ.objMT)
        --     end
        --     if (qList.upgradeQ) then
        --         setmetatable(qList.upgradeQ, idQ.objMT)
        --     end
        --     if (qList.queue) then
        --         setmetatable(qList.queue, idQ.objMT)
        --     end
        -- end
    end
end
Init.registerOnLoadFunc(TC._onLoad)

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
    return DB.getEntries(TC.dbName)
end

---@param ent LuaEntity
function TC.isTrackable(ent)
    -- if (not isValid(ent)) or (not TC.isChestName(ent.name)) or (EntDB.trackedCount(ent, TC.dbName) > 0) then
    if (not isValid(ent)) or (not TC.isChestName(ent.name)) then
        -- or (TC.getChestFromEnt(ent)) then
        return false
    end
    return true
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
    if (not isValid(ent)) then
        return false
    end
    return Map.containsValue(protoNames.chests, ent.name)
end

function TC.isChestName(name)
    if not name then
        return false
    end
    -- return Map.contains(protoNames.chests, name)
    if (string.find(name, "ammo.loader.chest")) then
        return true
    end
    return false
end

---Get Chest from id.
---@return Chest
function TC.getObj(id)
    if (type(id) == "table") and (id.className) and (id.className == TC.className) then
        return id
    end
    return DB.getObj(TC.dbName, id)
end

---@return Chest
function TC.getChestFromEnt(ent)
    if (not isValid(ent)) or (not TC.isChestName(ent.name)) then
        return
    end
    for id, obj in pairs(DB.getEntries(TC.dbName)) do
        if (obj.ent == ent) then
            return obj
        end
    end
    return nil
end

function TC.entDrawRange(ent)
    local chest = TC.getChestFromEnt(ent)
    if not chest then
        return nil
    end
    chest:drawRange()
end

---Create new TrackedChest object
---@param ent LuaEntity
---@return Chest
function TC.new(ent)
    if (not TC.isTrackable(ent)) then
        cInform("TC.new: entity not valid chest")
        return nil
    end

    ---@type Chest
    local obj = {}
    setmetatable(obj, TC.objMT)
    -- obj.entName = ent.name
    obj.ent = ent
    if (global.persist.chestFilters) then
        for i, filterInfo in pairs(global.persist.chestFilters) do
            if (filterInfo.ent == ent) then
                obj._entFilter = filterInfo.filters
                obj._entFilterMode = filterInfo.filterMode
                global.persist.chestFilters[i] = nil
                if (table_size(global.persist.chestFilters) <= 0) then
                    global.persist.chestFilters = nil
                end
                break
            end
        end
    end
    obj._forceName = ent.force.name
    obj._surfaceName = ent.surface.name
    obj._position = ent.position
    obj._inv = ent.get_inventory(defines.inventory.chest)
    -- obj.inv = ent.get_inventory(defines.inventory.chest)
    -- if not isValid(obj:inv()) then
    -- return nil
    -- end
    local pos = ent.position
    -- obj._posX = pos.x
    -- obj._posY = pos.y
    obj.id = DB.insert(TC.dbName, obj)

    local rad = gSets.chestRadius()
    local force = Force.get(ent.force.name)
    -- obj._consumers = idQ.newSlotQ(true)
    -- obj.addQ = idQ.newSlotQ(true)
    -- obj.consumerQ = obj.consumers
    -- if (rad > 0) then
    --     obj.area = Position.expand_to_area(obj:position(), rad)
    --     obj._slotsInRange = {}
    --     for slot in force.slots:slotIter() do
    --         if (slot:canMove()) or (slot:isInRange(obj)) then
    --             obj._slotsInRange[slot.id] = true
    --         end
    --     end
    -- end
    -- if (ent.name == protoNames.chests.storage) then
    -- obj.isStorage = true
    -- end
    obj._cacheLastTick = 0
    obj._invCache = {}
    obj._removalCache = {}
    obj._addProvList = {}
    obj._removeProvList = {}
    obj._renderInfo = {} --** Has the format [playerIndex] = [slotID=num, count=num]
    -- obj._entFilter = {}
    -- obj._entFilterMode = "whitelist"
    -- obj._render = {highlight = nil, area = nil, players = {}, tooltip = nil}
    -- obj:setupRender()
    -- obj.provItems = {}
    -- obj.slotsInRange = obj:getSlotsInRange(true, false, false)
    force:addChest(obj)

    -- EntDB.addTracked(obj)
    -- EntDB.entHash()[obj.ent] = true
    cInform("created new chest")
    return obj
end

function TC:inv()
    return self._inv or self.ent.get_inventory(defines.inventory.chest)
end

function TC:slotsInRange()
    return self:getSlotsInRange(false, false, false)
end

function TC:isStorage()
    if (self.ent.name == protoNames.chests.storage) then
        return true
    end
    return false
end

function TC:isInRange(slot)
    return util.isInRange(slot, self)
end

function TC:position()
    return self._position or self.ent.position
end

function TC:surface()
    return game.get_surface(self:surfaceName())
end
function TC:surfaceName()
    return self._surfaceName or self.ent.surface.name
end

---Remove Chest from database to open for garbage collection.
function TC:destroy()
    self._destroying = true
    local force = self:force()
    -- for slot in self:slotsInRange():slotIter() do
    -- slot:removeProv(self)
    -- slot.provDist[self.id] = nil
    -- end
    -- force.needRemoveProv:push({chest = self.id, curSlot = 1, type = "remove"})
    force.chests:softRemove(self)
    force.storageChests:softRemove(self)
    DB.deleteID(TC.dbName, self.id)
    force:removeProvID(self.id)
    -- for slot in force.slots:slotIter() do
    -- if (slot:sourceID() == self.id) then
    -- if (slot:canMove()) or (slot:isInRange(self)) then
    -- slot:removeProv(self)
    -- end
    -- end
    -- end
    -- if (self.isStorage) then
    --     force.storageChests:softRemove(self)
    -- else
    --     force.chests:softRemove(self)
    -- end
    -- for slot in self.consumerQ:slotIter(nil, true) do
    -- slot:setProv()
    -- force.orphans:pushleft(slot)
    -- end
end

---Check object validity.
function TC:isValid()
    if not self then
        return false
    end
    if (not self.ent) or (not self.ent.valid) then
        return false
    end
    return true
end

function TC:drawRange(player)
    if (not isValid(self.ent)) or (player.surface.name ~= self:surfaceName()) then
        return
    end
    local rad = gSets.chestRadius()
    if (rad <= 0) then
        return
    end
    rendering.draw_circle(
        {
            -- color = util.colors.fuchsia,
            color = {r = 0.05, g = 0.2, b = 0.15, a = 0.05},
            radius = rad,
            width = 8,
            target = self.ent,
            filled = true,
            -- left_top = self.area.left_top,
            -- right_bottom = self.area.right_bottom,
            surface = self:surfaceName(),
            players = {player},
            draw_on_ground = true
        }
    )
    -- rendering.set_players(self._render.area, {player})
    -- rendering.set_visible(self._render.area, true)
end

function TC:highlightConsumers(player)
    -- local slots = self:getConsumers()
    -- local slots = self:getSlotsInRange(false, true, false)
    -- local ents = {}
    -- local e = 0
    if (not isValid(player)) then
        return
    end
    local s = 0
    local force = self:force()
    local renderInfo = self._renderInfo
    local playerInfo = renderInfo[player.index]
    if (not playerInfo) then
        playerInfo = {nextID = 1, count = 0}
        renderInfo[player.index] = playerInfo
        alGui.chestsNeedRender()[self.id] = 1
    end
    for slot in force:iterSlots(gSets.maxRendersPerTick, playerInfo.nextID, {sourceID = self.id}) do
        s = s + 1
        slot:drawLineToProvider(player)
        slot:highlight(player)
        playerInfo.nextID = slot.id + 1
        playerInfo.count = playerInfo.count + 1
    end
    if (playerInfo.nextID > DB.highest(SL.dbName)) or (s <= 0) then
        rendering.draw_text(
            {
                text = {"", tostring(playerInfo.count)},
                surface = self:surface(),
                target = self.ent,
                scale = 1.5,
                target_offset = {-0.25, -1.5},
                color = {1.0, 1.0, 1.0},
                players = {player},
                draw_on_ground = false
                -- scale_with_zoom = true
            }
        )
        renderInfo[player.index] = nil
    end
    -- ents[e] = slot.ent
    -- end
    -- end

    cInform("providing ", s, " slots.")
end

function TC:setupRender()
    local radius = gSets.chestRadius()
    if (radius <= 0) or (radius > 100) then
        radius = 1
    end
    -- local alpha = 0.1
    local color = {r = 0.05, g = 0.2, b = 0.15, a = 0.05}
    self._render.area =
        rendering.draw_circle(
        {
            -- color = util.colors.fuchsia,
            color = color,
            radius = radius,
            width = 8,
            target = self.ent,
            filled = true,
            -- left_top = self.area.left_top,
            -- right_bottom = self.area.right_bottom,
            surface = self:surfaceName(),
            players = {},
            draw_on_ground = true,
            visible = false
        }
    )
    self._render.tooltip =
        rendering.draw_text(
        {
            text = {"", string.toString(s)},
            surface = self:surface(),
            target = self.ent,
            scale = 1.5,
            target_offset = {-0.25, -1.5},
            color = {1.0, 1.0, 1.0},
            players = {},
            draw_on_ground = false,
            visible = false
            -- scale_with_zoom = true
        }
    )
    -- self._render.highlight = render.draw_circle()
end

function TC:setRenderPlayers(players)
    players = players or {}
    self._render.players = players
    for name, rend in pairs(self._render) do
        if (name ~= "players") then
            rendering.set_players(rend, players)
        end
    end
end

function TC:toggleRender(opt, status)
    status = status or (not rendering.get_visible(self._render.highlight))
    for name, rend in pairs(self._render) do
        if (name ~= "players") then
            rendering.set_visible(rend, status)
        end
    end
end

function TC:force()
    -- return Force.get(self.ent.force.name)
    return Force.get(self:forceName())
end
function TC:forceName()
    -- return self.ent.force.name
    return self._forceName or self.ent.force.name
end

function TC:itemAmt(item, new)
    if (new) then
        self._invCache[item] = new
        return new
    end
    local amt = self._invCache[item] or 0
    return amt
end

function TC:cacheRemove(item, amt)
    if (amt <= 0) then
        return
    end
    local newAmt = self:itemAmt(item) - amt
    return self:itemAmt(item, newAmt)
end

function TC:cacheAdd(item, amt)
    return self:itemAmt(item, self:itemAmt(item) + amt)
end

---Insert items into chest while maintaining inventory cache. Returns the number of items inserted.
---@param stack ItemStack
---@return integer
function TC:insert(stack)
    if (util.isEmpty(stack)) then
        return 0
    end
    local amtInserted = self:inv().insert(stack)
    local cache = self._invCache
    if (amtInserted > 0) then
        local item = stack.name
        if not cache[item] then
            cache[item] = amtInserted
        else
            cache[item] = cache[item] + amtInserted
        end
    end
    return amtInserted
end

---Remove items from the chest inventory while maintaining the inventory cache. Returns the number of items removed.
---@param stack ItemStack
---@return integer
function TC:remove(stack)
    if (util.isEmpty(stack)) then
        return 0
    end
    local cache = self._invCache
    local amtRemoved = self:inv().remove(stack)
    local item = stack.name
    if (cache[item]) then
        cache[item] = cache[item] - amtRemoved
    end
    return amtRemoved
end

function TC:slotsInRangeQ()
    if (not self.area) then
        return self:force().slots
    else
        return self._slotsInRangeQ
    end
end

function TC:getSlotsInRange(ignoreMovingSlotDist, checkItems, checkBetter)
    local slots = self:force().slots
    local inRange = self.isInRange
    local q = idQ.newSlotQ(true)
    local push = q.push
    local catItems
    local getCatItems
    if (checkItems) then
        catItems = {}
        getCatItems = self.catItems
    end
    for slot in slots:slotIter() do
        if (inRange(self, slot)) or (slot.canMove and ignoreMovingSlotDist) then
            if (not checkItems) then
                push(q, slot)
            elseif (not empty(slot:category())) then
                local items = catItems[slot:category()]
                if (not items) then
                    items = getCatItems(self, slot:category())
                    catItems[slot:category()] = items
                end
                if (not empty(items)) then
                    if (not checkBetter) then
                        push(q, slot)
                    else
                        for itemName, count in pairs(items) do
                            if (slot:itemIsBetterOrCloser(itemName, self)) then
                                push(q, slot)
                            end
                        end
                    end
                end
            end
        end
    end
    return q
end

function TC:getConsumers()
    local slots = self:force().slots
    local q = idQ.newSlotQ(true)
    for slot in slots:slotIter() do
        if (slot:sourceID() == self.id) then
            q:push(slot)
        end
    end
    return q
end

function TC:hasCat(cat)
    for item, count in pairs(self._invCache) do
        local inf = itemInfo(item)
        if (inf.category == cat) then
            return true
        end
    end
    return false
end

function TC:providedItems()
    local force = self:force()
    local items = {}
    for catName, cat in pairs(force.provs.categories) do
        for itemName, item in pairs(cat.items) do
            local cons = item.ids[self.id]
            if (cons) then
                items[itemName] = cons
            end
        end
    end
    return items
end

function TC:isProvidingCat(catName)
    local cat = self:force().provs.categories[catName]
    for itemName, item in pairs(cat.items) do
        local cons = item.ids[self.id]
        if (cons) then
            return true
        end
    end
    return false
end

---@param itemName string
function TC:isProvidingItem(itemName)
    local inf = itemInfo(itemName)
    if (not inf) then
        return false
    end
    local force = self:force()
    if
        (force.provCats[inf.category]) and (force.provCats[inf.category][inf.rank]) and
            (force.provCats[inf.category][inf.rank][self.id])
     then
        return true
    end
    return false
end

function TC:catItems(catName)
    -- local cat = self:force().provs.categories[catName]
    -- local provItems = self._invCache
    local items = {}
    local itemInfo = itemInfo
    for itemName, count in pairs(self._invCache) do
        local inf = itemInfo(itemName)
        if (inf.category == catName) and (count >= inf.fillLimit) then
            items[itemName] = count
        end
        -- local cons = item.ids[self.id]
        -- if (cons) then
        -- Array.insert(items, itemName)
        -- end
    end
    return items
end

function TC:itemConsumers(item)
    -- local inf = itemInfo(item)
    local f = self:force()
    local provItem = f:provItem(item)
    local reg = provItem.ids[self.id]
    return reg
end

function TC:itemConsumerQ(item)
    local cons = self:itemConsumers(item)
    local q = idQ.newSlotQ()
    if cons then
        for id, t in pairs(cons) do
            local obj = SL.getObj(id)
            if (obj) then
                q:push(id)
            end
        end
    end
    return q
end

---@return fun():Slot
function TC:itemIter(item)
    local qList = self.provItems[item]
    ---@type idQ
    local q = qList.queue
    -- local highest = DB.getHighest(SL.dbName)
    local highest = qList.highest
    local n = 0
    local maxSlots = gSets.maxSlotsPerChestTick()
    local allSlots = DB.getEntries(SL.dbName)

    ---@type fun():Slot
    local ret = function()
        if (n >= maxSlots) then
            return
        end
        n = n + 1
        while (qList.cur < highest) do
            qList.cur = qList.cur + 1
            local slot = allSlots[qList.cur]
            if (slot) then
                return slot
            end
        end
        if (q:size() > 0) then
            local slot = q:pop()
            return slot
        end
    end
    return ret
end

function TC:doQ()
    local force = self:force()
    local maxSlots = gSets.maxSlotsPerChestTick()
    local doUpgrade = force:doUpgrade()
    local consQ = self.consumerQ
    ---@type table<number, Slot>
    local slots = DB.getEntries(SL.dbName)
    local highest = DB.getHighest(SL.dbName)
    local n = 0

    for item, qList in pairs(self.provItems) do
        ---@type idQ
        local q = qList.queue
        ---@type idQ
        local upQ = qList.upgradeQ
        -- if force.slotsChecked >= maxSlots then
        -- break
        -- end
        local itemCount = self:itemAmt(item)
        if (itemCount > 0) and ((q:size() > 0) or (upQ:size() > 0)) then
            local inf = itemInfo(item)
            if (q:size() > 0) then
                -- if (gSets.tick() % 60 == 0) then
                cInform(item, " queue: ", q:size(), " remaining")
                -- end
                for slot in q:slotIter(maxSlots, true) do
                    if (slot:sourceID()) then
                        upQ:push(slot)
                    else
                        if ((not slot.canMove) or (self:isInRange(slot))) and (slot:category() == inf.category) then
                            if (slot:itemIsBetterOrCloser(item, self)) then
                                n = n + 1
                                slot:setProv(self, item)
                                itemCount = self:itemAmt(item)
                            end
                        end
                    end
                    if (itemCount <= 0) or (n >= maxSlots) then
                        return
                    end
                end
            end
            if (upQ:size() > 0) then
                cInform(item, " upgrade queue: ", upQ:size(), " remaining")
                for slot in upQ:slotIter(maxSlots, true) do
                    if ((not slot.canMove) or (self:isInRange(slot))) and (slot:category() == inf.category) then
                        if (slot:itemIsBetterOrCloser(item, self)) then
                            n = n + 1
                            slot:setProv(self, item)
                            itemCount = self:itemAmt(item)
                        end
                    end
                    if (itemCount <= 0) or (n >= maxSlots) then
                        return
                    end
                end
            end
        end
    end
    -- self:doAddQ()
end

function TC:pauseConsumers(itemName)
    local itemInf = itemInfo(itemName)
    if (not itemInf) then
        return
    end
    ---@type slotIterFilter
    local opts = {}
    opts.sourceID = self.id
    opts.category = itemInf.category
    opts.filter = itemName
    local force = self:force()
    for slot in force:iterSlots(nil, nil, opts) do
        slot:pauseInserter()
    end
end

function TC:unpauseConsumers(itemName)
    local itemInf = itemInfo(itemName)
    if (not itemInf) then
        return
    end
    ---@type slotIterFilter
    local opts = {}
    opts.sourceID = self.id
    opts.category = itemInf.category
    opts.filter = itemName
    local force = self:force()
    for slot in force:iterSlots(nil, nil, opts) do
        slot:unpauseInserter()
    end
end

function TC:updateCache()
    local gTick = game.tick
    local ticksToWait = gSets.ticksBeforeCacheRemoval()
    local minTicks = gSets.ticksBetweenChestCache()
    local fTick = gTick + ticksToWait
    local newCache = self._invCache
    local oldCache = self._invCache
    local force = self:force()
    local rmCache = self._removalCache
    if (gTick >= self._cacheLastTick + minTicks) then
        self._cacheLastTick = gTick
        newCache = self:inv().get_contents()
        self._invCache = newCache
        for item, count in pairs(newCache) do
            local inf = itemInfo(item)
            if (inf) then
                rmCache[item] = nil
                -- if (not oldCache[item]) or (oldCache[item] <= 0) then
                if
                    (count >= inf.fillLimit) and
                        ((not self:isProvidingItem(item)) or (not oldCache[item]) or (oldCache[item] < inf.fillLimit))
                 then
                    force:registerProv(self, item)
                end
            -- elseif (oldCache[item] <= 0) then
            end
        end
        for item, count in pairs(oldCache) do
            local inf = itemInfo(item)
            if (inf) then
                if (not self._invCache[item]) and (not rmCache[item]) then
                    rmCache[item] = fTick
                end
            end
        end
    end
    for item, tick in pairs(rmCache) do
        if (gTick >= tick) then
            rmCache[item] = nil
            force:removeProv(self, item)
        -- self:removeProv(item)
        end
    end
end

function TC:provItemConsumerQ(item)
    local slots = self.consumerQ
    local q = idQ.newSlotQ(true)
    for slot in slots:slotIter() do
        local filterItem = slot:filterItem()
        if (filterItem) and (filterItem == item) then
            q:push(slot)
        end
    end
    return q
end

function TC:removeProvItem(item)
    local force = self:force()
    self.provItems[item] = nil
    local slots = self.consumerQ
    for slot in slots:slotIter() do
        if (slot:filterItem() == item) then
            slot:setProv()
        -- force.orphans:push(slot)
        -- slots:remove(slot)
        -- if (slot.canMove) then
        -- slot:setProv()
        -- else
        -- slot.isOrphan = true
        -- force.orphans:push(slot)
        -- end
        end
        -- self:force().orphans:push(slot)
        -- slot:queueAllProvs()
    end
end

function TC:addProvItem(item)
    -- local slots = self:getSlotsInRange(true, true, false)
    -- local slots = self:slotsInRange()
    -- local inf = itemInfo(item)
    -- local itemCat = inf.category
    -- self:force().needRemoveProv:push({chest = self.id, item = item, curSlot = 1, type = "add"})
    -- for slot in slots:slotIter() do
    --     if (slot:category() == itemCat) then
    --         if (not slot.canMove) or (slot:isInRange(self)) then
    --             slot:addProv(self, item)
    --         end
    --     end
    -- end
    self._removeProvList[item] = nil
    if (not self._addProvList[item]) then
        self._addProvList[item] = 0
    end
end

function TC:removeProv(item)
    -- local slots = self:getSlotsInRange(true, true, false)
    -- local slots = self:slotsInRange()
    -- local inf = itemInfo(item)
    -- local itemCat = inf.category
    -- self:force().needRemoveProv:push({chest = self.id, item = item, curSlot = 1, type = "remove"})
    -- for slot in slots:slotIter() do
    --     if (slot:category() == itemCat) then
    --         self:force()
    --         slot:removeProv(self, item)
    --     end
    -- end
    self._addProvList[item] = nil
    if (not self._removeProvList[item]) then
        self._removeProvList[item] = 0
    end
end

function TC:itemQ(item)
    item = item or ""
    local provItem = self.provItems[item]
    if (provItem) and (provItem.orphanQ) then
        return provItem.orphanQ
    end
    return nil
end

---@return idQ
function TC:itemOrphanQ(item)
    if not item then
        return
    end
    local provItem = self.provItems[item]
    if (provItem) and (provItem.orphanQ) then
        return provItem.orphanQ
    end
end

---@return idQ
function TC:itemUpgradeQ(item)
    if not item then
        return
    end
    local provItem = self.provItems[item]
    if (provItem) and (provItem.upgradeQ) then
        return provItem.upgradeQ
    end
end

function TC:hasProvCat(catName)
    for itemName, t in pairs(self.provItems) do
        local inf = itemInfo(itemName)
        if (inf) and (inf.category == catName) then
            return true
        end
    end
    return false
end

function TC:hasBetterProvItem(itemName, equal)
    local itemInf = itemInfo(itemName)
    if (not itemInf) then
        return true
    end
    for provItem, t in pairs(self.provItems) do
        local inf = itemInfo(provItem)
        if
            (inf.category == itemInf.category) and
                ((inf.rank < itemInf.rank) or ((equal) and (inf.rank == itemInf.rank)))
         then
            return true
        end
    end
    return false
end

---@param slot Slot
function TC:hasBetterOrCloserProvItem(slot)
    local itemInf = slot:filterInfo()
    if (not itemInf) then
        return true
    end
    for provItem, t in pairs(self.provItems) do
        if (slot:itemIsBetterOrCloser(provItem, self)) then
            return true
        end
    end
    return false
end

function TC:iterConsumers()
    local cons = self._consumers
    local consIter = cons:slotIter(nil, true)
    --- @return Slot
    local function iter()
        local slot = consIter()
        if (not slot) then
            return
        end
        if (slot:sourceID() ~= self.id) then
            return iter()
        end
        cons:push(slot)
        return slot
    end
    return iter
end

function TC:tickCheckProv()
    for item, curID in pairs(self._addProvList) do
        local force = self:force()
        local inf = itemInfo(item)
        for slot in force:iterSlots(gSets.maxSlotsPerChestTick(), curID) do
            self._addProvList[item] = slot.id
            if (slot:category() == inf.category) then
                slot:checkProv(true)
            end
            -- if (slot:itemIsBetterOrCloser(item, self)) then
            -- end
        end
    end
end

function TC:tickAddProvList(startItem)
    local addItem, curSlotID = next(self._addProvList, startItem)
    if (not addItem) then
        return
    end
    if (curSlotID == 0) then
        curSlotID = nil
    end
    local curAmt = self:itemAmt(addItem)
    local itemInf = itemInfo(addItem)
    if (curAmt <= 0) then
        return self:tickAddProvList(addItem)
    end
    local limit = gSets.maxSlotsPerChestTick()
    local c = 0
    local slotsInRange = self._slotsInRange
    if (not slotsInRange) then
        slotsInRange = self:force().slots.idHash
    end
    while (next(slotsInRange, curSlotID)) and (c < limit) do
        local slotID = next(slotsInRange, curSlotID)
        local slot = SL.getObj(slotID)
        if (not slot) then
            if (self._slotsInRange) then
                self._slotsInRange[slotID] = nil
            end
        else
            if (slot:category() == itemInf.category) then
                if (self:itemAmt(addItem) < slot:fillLimit()) then
                    break
                end
                c = c + 1
                slot:addProv(self, addItem)
            end
        end
        curSlotID = slotID
        self._addProvList[addItem] = slotID
    end
    -- for slot, c in SL.slotIter(limit, curSlotID) do
    --     if (self:itemAmt(addItem) < itemInf.fillLimit) then
    --         break
    --     end
    --     self._addProvList[addItem] = slot.id
    --     if
    --         (slot:forceName() ~= self:forceName()) or ((slot:sourceID() == self.id) and (slot:filterItem() == addItem)) or
    --             (slot:category() ~= itemInf.category) or
    --             (not slot:isInRange(self))
    --      then
    --         c = c - 1
    --     else
    --         slot:addProv(self, addItem)
    --     end
    -- end
    if (not next(DB.getEntries(SL.dbName), curSlotID)) then
        self._addProvList[addItem] = nil
    end
end

function TC:tickRemoveProvList(startItem)
    local rmItem, curSlotID = next(self._removeProvList, startItem)
    if (not rmItem) then
        return
    end
    if (curSlotID == 0) then
        curSlotID = nil
    end
    local curAmt = self:itemAmt(rmItem)
    local itemInf = itemInfo(rmItem)
    if (curAmt > 0) then
        return self:tickRemoveProvList(rmItem)
    end
    local limit = gSets.maxSlotsPerChestTick()
    local c = 0
    local slotsInRange = self._slotsInRange
    if (not slotsInRange) then
        slotsInRange = self:force().slots.idHash
    end
    while (next(slotsInRange, curSlotID)) and (c < limit) do
        local slotID = next(slotsInRange, curSlotID)
        curSlotID = slotID
        self._removeProvList[rmItem] = slotID
        local slot = SL.getObj(slotID)
        if (not slot) then
            if (self._slotsInRange) then
                self._slotsInRange[slotID] = nil
            end
        else
            if (slot:category() == itemInf.category) then
                c = c + 1
                slot:removeProv(self, rmItem)
            end
        end
    end
    -- for slot, c in SL.slotIter(limit, curSlotID) do
    --     self._removeProvList[rmItem] = slot.id
    --     if (slot:sourceID() ~= self.id) or (slot:filterItem() ~= rmItem) then
    --         c = c - 1
    --     else
    --         slot:removeProv(self, rmItem)
    --     end
    -- end
    -- local endID = self._removeProvList[rmItem]
    -- if (endID == 0) then
    --     endID = nil
    -- end
    if (not next(DB.getEntries(SL.dbName), curSlotID)) then
        self._removeProvList[rmItem] = nil
    end
end

function TC:tickProvLists()
    self:tickAddProvList()
    self:tickRemoveProvList()
end

function TC:tick()
    if (self:isStorage()) then
        return
    end
    local gTick = gSets.tick()
    -- local minTicks = gSets.ticksBetweenChestCache()
    -- if (gTick >= self._cacheLastTick + minTicks) then
    -- self._cacheLastTick = gTick
    self:updateCache()
    -- end
    -- self:tickAddProvList()
    -- self:tickRemoveProvList()
    -- self:doQ()
    -- self:doAddQ()
end

function TC:setEntFilter(newFilter, newMode)
    if (not newFilter) or (table_size(newFilter) <= 0) then
        self._entFilter = nil
        self._entFilterMode = nil
        self:force():removeProvID(self.id)
        self._invCache = {}
        return
    end
    self._entFilter = newFilter
    self._entFilterMode = newMode or "whitelist"
    self:force():removeProvID(self.id)
    self._invCache = {}
end

---Check chest's entity filters to see if a slot will pass
---@param slot Slot
function TC:filterAllows(slot)
    if (not self._entFilter) then
        return true
    end
    local entName = slot:entName()
    if (self._entFilter[entName]) then
        if (self._entFilterMode == "whitelist") then
            return true
        elseif (self._entFilterMode == "blacklist") then
            return false
        end
    else
        if (self._entFilterMode == "whitelist") then
            return false
        elseif (self._entFilterMode == "blacklist") then
            return true
        end
    end
end

function TC:amtCanReturn(stack)
    if (not stack) or (stack.count <= 0) then
        return 0
    end
    local inv = self:inv()
    local firstStack = inv.find_item_stack(stack.name)
    if (not firstStack) then
        return 0
    end
    local amtCanInsert = inv.get_insertable_count(stack.name)
    if (stack.count < amtCanInsert) then
        amtCanInsert = stack.count
    end
    return amtCanInsert
end

return TC
