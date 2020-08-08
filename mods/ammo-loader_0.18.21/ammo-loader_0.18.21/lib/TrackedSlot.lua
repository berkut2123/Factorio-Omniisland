---Slots represent a single slot on any entity that is being provided to.
---@class Slot
SL = {}
SL.className = "TrackedSlot"
SL.dbName = SL.className
DB.register(SL.dbName)

SL.objMT = {
    __index = SL
}

function SL._onLoad()
    for id, obj in pairs(DB.getEntries(SL.dbName)) do
        setmetatable(obj, SL.objMT)
        -- for rank, q in pairs(obj.provItems) do
        --     setmetatable(q, idQ.objMT)
        -- end
    end
end
Init.registerOnLoadFunc(SL._onLoad)

SL.ammoInvTypes = {
    defines.inventory.turret_ammo,
    defines.inventory.car_ammo,
    defines.inventory.character_ammo,
    defines.inventory.artillery_turret_ammo,
    defines.inventory.artillery_wagon_ammo
}

function SL._init()
    global["SL"] = {}
    global["SL"]["vars"] = {}
    -- global["SL"]["vars"]["prevSourceID"] = {}
    -- global.SL.vars.sourceID = {}
    -- global.SL.vars.checkProv = {}
end
Init.registerFunc(SL._init)

function SL.vars()
    return global.SL.vars
end

function SL:setPrevSourceID(id)
    -- SL.vars().prevSourceID[self.id] = id
    self._prevSourceID = id
end

function SL:prevSourceID()
    -- return SL.vars().prevSourceID[self.id]
    return self._prevSourceID
end

function SL:checkProv()
    return self._checkProv
end

function SL:setCheckProv(val)
    self._checkProv = val
end

---@return ItemStack Empty ItemStack (name="", count=0).
function SL.emptyStack()
    return {name = "", count = 0}
end

---Test an entity to see if it may have trackable inventory slots.
---@param ent LuaEntity
---@return boolean
function SL.entIsTrackable(ent)
    if (not isValid(ent)) or (not SL.entProtoIsTrackable(ent.prototype)) then
        return false
    end
    return true
end

---Test an entity prototype to see if an instance of it might have trackable inventory slots.
---@param proto LuaEntityPrototype
---@return boolean
function SL.entProtoIsTrackable(proto)
    if (not proto) then
        return false
    end
    if (proto.type == "boiler") or (proto.name == HI.protoName) then
        return false
    end
    if (EntDB.ammoTypes[proto.type]) or (proto.guns) or (proto.type == "character") or (proto.burner_prototype) then
        return true
    end
    return false
end

function SL.allSlotsQ()
    local slotQ = idQ.newSlotQ(true)
    for id, obj in pairs(DB.getEntries(SL.dbName)) do
        local slot = SL.getObj(id)
        if (slot) then
            slotQ:push(slot)
        end
    end
    return slotQ
end

function SL.returnAll(forceEmpty)
    for slot in SL.allSlotsQ():slotIter() do
        slot:returnItems(forceEmpty)
    end
end

function SL.entNeedsProvided(ent)
    if (not ent) then
        return false
    end
    if SL.entCanMove(ent) or (ent.type == "inserter") or (ent.name:find("meteor")) then
        return true
    end
end

---@return fun():Slot
function SL.iterDB()
    return DB.iter(SL.dbName)
end

---@return Slot[]
function SL.trackAllSlots(ent)
    -- cInform("track all slots")
    local newSlots = {}
    if (not SL.entIsTrackable(ent)) then
        -- cInform("SL.trackAllSlots: ent not trackable")
        return newSlots
    end
    if (isValid(ent.burner)) then
        newSlots = Array.merge(newSlots, SL.createSlots(ent, ent.burner.inventory, true))
    -- elseif (isValid(ent.get_inventory(defines.inventory.fuel))) then
    -- local fuelInv = ent.get_inventory(defines.inventory.fuel)
    -- newSlots = Array.merge(newSlots, SL.createSlots(ent, fuelInv))
    end
    -- local burnerInv = ent.get_fuel_inventory()
    -- if (burnerInv) and (#burnerInv > 0) then
    --     -- local slotCat, slotType = EntDB.getSlotCategory(burnerInv[1])
    --     for i = 1, #burnerInv do
    --         -- local stack = burnerInv[i]
    --         local burnerSlot = SL.new(ent, defines.inventory.fuel, i)
    --         if burnerSlot then
    --             table.insert(newSlots, burnerSlot)
    --         end
    --     end
    -- end
    if (ent.type == "car") then
        -- if (isValid(ammoInv)) then
        --     for i = 1, #ammoInv do
        --         local newSlot = SL.new(ent, defines.inventory.car_ammo, i)
        --         if (newSlot) then
        --             table.insert(newSlots, newSlot)
        --         end
        --     end
        -- end
        local ammoInv = ent.get_inventory(defines.inventory.car_ammo)
        newSlots = Array.merge(newSlots, SL.createSlots(ent, ammoInv))
    elseif (ent.type == "character") then
        local ammoInv = ent.get_inventory(defines.inventory.character_ammo)
        newSlots = Array.merge(newSlots, SL.createSlots(ent, ammoInv))
        -- if (isValid(ammoInv)) then
        --     for i = 1, #ammoInv do
        --         local newSlot = SL.new(ent, defines.inventory.character_ammo, i)
        --         if (newSlot) then
        --             table.insert(newSlots, newSlot)
        --         end
        --     end
        -- end
        local ammoInv = ent.get_inventory(defines.inventory.character_ammo)
        newSlots = Array.merge(newSlots, SL.createSlots(ent, ammoInv))
    elseif (ent.type == "ammo-turret") then
        local ammoInv = ent.get_inventory(defines.inventory.turret_ammo)
        newSlots = Array.merge(newSlots, SL.createSlots(ent, ammoInv))
    elseif (ent.type == "artillery-turret") then
        local ammoInv = ent.get_inventory(defines.inventory.artillery_turret_ammo)
        newSlots = Array.merge(newSlots, SL.createSlots(ent, ammoInv))
    elseif (ent.type == "artillery-wagon") then
        cInform("attempt track artillery wagon")
        local ammoInv = ent.get_inventory(defines.inventory.artillery_wagon_ammo)
        newSlots = Array.merge(newSlots, SL.createSlots(ent, ammoInv))
    end
    -- if (not EntDB.ammoTypes[ent.type]) then
    -- local params = ent.prototype.attack_parameters
    -- if (not ent.prototype.automated_ammo_count) and (not ent.prototype.guns) and (not ent.type == "character") then
    -- cInform("SL.trackAll: ent type not ammo type")
    -- return newSlots
    -- end
    -- local invs = {}
    -- local ammoInvs = {}
    -- local main = ent.get_main_inventory()
    -- if (isValid(main)) then
    --     invs[#invs + 1] = main
    -- end
    -- for ind, invType in pairs(SL.ammoInvTypes) do
    --     local newInv = ent.get_inventory(invType)
    --     if (isValid(newInv)) and (#newInv > 0) and (not Array.contains(invs, newInv)) then
    --         invs[#invs + 1] = newInv
    --     end
    -- end
    -- if (#invs > 0) then
    -- cInform("SL.trackAll: found inventory")
    -- else
    -- cInform("SL.trackAll: no invs found")
    -- end
    -- local _i = 0
    -- local _s = 0
    -- for ind, inv in pairs(invs) do
    --     _i = _i + 1
    --     local slotsToCreate = 1
    --     local isCharAmmo = ((ent.type == "character") and (inv.index == defines.inventory.character_ammo))
    --     if (ent.prototype.guns ~= nil) or isCharAmmo then
    --         slotsToCreate = #inv
    --     end
    --     for i = 1, slotsToCreate do
    --         _s = _s + 1
    --         local slotCat, slotType = SL.getSlotCat(inv[i])
    --         if (isCharAmmo) then
    --             slotType = "ammo"
    --             slotCat = ""
    --         end
    --         if (slotType) and (slotType == "ammo") then
    --             local newSlot = SL.new(ent, inv.index, i)
    --             if (newSlot) then
    --                 newSlots[#newSlots + 1] = newSlot
    --             end
    --         end
    --     end
    -- end
    -- if (#newSlots > 0) then
    -- EntDB.entHash()[ent] = true
    -- end
    return newSlots
end

function SL.createSlots(ent, inv, isBurner)
    if (not isValid(ent)) or (not isValid(inv)) then
        return {}
    end
    local res = {}
    local limit = 1
    if (not isBurner) and (ent.type == "car" or ent.type == "character") then
        limit = #inv
    end
    for i = 1, limit do
        local newSlot = SL.new(ent, inv.index, i, isBurner)
        if (newSlot) then
            table.insert(res, newSlot)
        end
    end
    return res
end

---Attempt to create new Slot
---@param ent LuaEntity
---@param inv LuaInventory
---@param index integer
---@param slotCat string
---@param slotType string
---@return Slot
function SL.new(ent, invIndex, slotIndex, isBurner)
    if (not isValid(ent)) then
        return
    end
    slotIndex = slotIndex or 1
    local ind = slotIndex
    local burner
    local inv
    local itemSlot
    if (isBurner) then
        burner = ent.burner
        -- ent = ent.owner
        inv = burner.inventory
        invIndex = "burner"
        if (isValid(inv)) and (#inv >= slotIndex) and (isValid(inv[slotIndex])) then
            itemSlot = inv[slotIndex]
        end
    else
        inv = ent.get_inventory(invIndex)
        if (isValid(inv)) and (#inv >= slotIndex) and (isValid(inv[slotIndex])) then
            itemSlot = inv[slotIndex]
        end
    end
    if (not isValid(inv)) or (not isValid(itemSlot)) then
        -- cInform("not valid slot")
        return
    end
    local slot = itemSlot
    local perfMode = gSets.performanceModeEnabled()
    ---@type Slot
    local obj = {}
    setmetatable(obj, SL.objMT)
    obj.ent = ent
    local entName = ent.name
    if (perfMode) then
        obj._entName = entName
        obj._forceName = ent.force.name
        obj._surfaceName = ent.surface.name
    end
    local protoInfo = EntDB.proto(entName)
    if (invIndex ~= 1) then
        obj._invInd = invIndex
    end
    if (slotIndex ~= 1) then
        obj._slotInd = slotIndex
    end
    local force = Force.get(obj.ent.force.name)
    local slotCat, slotType = EntDB.getSlotCategories(itemSlot)
    if (not slotCat) or (#slotCat <= 0) then
        return
    end
    local slotProto = EntDB.slotProto(entName, invIndex, slotIndex)
    slotProto.categories = slotCat
    slotProto.category = slotCat[1]
    slotProto.type = slotType
    -- local pos = ent.position
    if (SL.entCanMove(ent)) then
        -- obj:isProvided() = true
        -- obj:canMove() = true
        protoInfo.canMove = true
    elseif (perfMode) then
        obj._position = ent.position
    end
    if (SL.entNeedsProvided(ent)) then
        -- obj:isProvided() = true
        protoInfo.needsProvided = true
        obj._slot = slot
    end
    if (perfMode) then
        obj._inv = inv
        obj._slot = itemSlot
    end
    if (itemSlot.valid_for_read) then
    -- obj._slotItem = itemSlot.name
    end
    -- if (not obj:canMove()) then
    -- obj._posX = pos.x
    -- obj._posY = pos.y
    -- end
    if (ent.type == "character") then
        protoInfo.isCharacter = true
        protoInfo.isChar = true
        obj._category = ""
    end
    -- obj:isProvided() = true
    -- obj:isCharacter() = true
    -- obj:canMove() = true
    -- end
    -- obj._slot = slot
    -- EntDB.fillLimits()[obj._entName] = ent.prototype.automated_ammo_count or 10
    if (slotType == "fuel") then
        slotProto.fillLimit = 5
    else
        slotProto.fillLimit = ent.prototype.automated_ammo_count or 10
        if (slotProto.category == "artillery-shell") then
            -- cInform("artillery slot create")
            slotProto.fillLimit = 5
        end
    end
    -- slotProto.fillLimit = ent.prototype.automated_ammo_count or 10
    -- if (slotProto.category == "artillery-shell") then
    --     slotProto.fillLimit = 1
    -- elseif (ent.get_fuel_inventory()) then
    --     slotProto.fillLimit = 5
    -- end
    -- obj._fillLimit = ent.prototype.automated_ammo_count or 10
    -- obj._inserter = {lastTick = 0}
    -- obj._inserterLastTick = 0
    -- obj._sourceID = nil
    -- obj._filterName = nil
    -- obj._provItems = {}
    -- if (SL.entNeedsProvided(obj.ent)) then
    -- obj._needsProvided = true
    -- end
    -- obj._render = {provLine = nil, highlight = nil, players = {}}
    -- obj:setupRender()
    -- if (slotType == "fuel") and (not obj._canMove) then
    -- obj.useWorst = true
    -- end
    -- obj:checkEnabled()
    -- if (not obj:checkEnabled()) then
    --     return
    -- end
    obj.id = DB.insert(SL.dbName, obj)

    if (not protoInfo.needsProvided) then
        -- obj._inserterID = HI.new(obj).id
        local insEnt = HI.new(obj)
        if (perfMode) then
            obj._inserterEnt = insEnt
        end
    end
    -- if obj:isProvided() then
    --     obj._slot = slot
    -- else
    -- if (obj:isCharacter()) then
    -- obj:updateCategory()
    -- end
    -- obj.provsInRange = obj:getProvsInRange(true, false)
    -- obj._provItems = {}
    -- obj.provDist = {}
    -- obj:addProvsInRange()
    -- if (gSets.chestRadius() > 0) then
    --     local chestsInRange = obj:getProvsInRange(true, false, false)
    --     for chest in chestsInRange:chestIter() do
    --         chest._slotsInRange[obj.id] = true
    --     end
    -- end
    -- obj:setNextProvider()
    -- obj._needsCheckBestProv = true
    -- obj:checkProv(true)
    force:addSlot(obj)
    local enabled = obj:checkEnabled()
    if (not enabled) then
        cInform("disable")
        obj:disable()
    end
    obj:setBestProvider()
    cInform("created slot: ", obj.ent.name)
    -- EntDB.addTracked(obj)
    -- cInform("new slot-> name: ", obj.ent.name, ", cat: ", obj.category)
    return obj
end

function SL:entName()
    return self._entName or self.ent.name
end

function SL:protoInfo()
    return EntDB.proto(self:entName())
end

function SL:slotProto()
    return EntDB.slotProto(self:entName(), self:invInd(), self:slotInd())
end

function SL:fillLimit()
    return self:slotProto().fillLimit
end

function SL:needsProvided()
    -- if (self._needsProvided) then
    --     return true
    -- end
    -- return false
    return self:protoInfo().needsProvided
end

function SL:isCharacter()
    -- if (self.ent.type == "character") then
    --     return true
    -- end
    -- return false
    -- if (self._isChar) then
    --     return true
    -- end
    -- return false
    return self:protoInfo().isChar
end

function SL:invInd()
    return self._invInd or 1
end

function SL:slotInd()
    return self._slotInd or 1
end

function SL:category()
    return self._category or self:slotProto().category
end

-- function SL:slotType()
--     return self:slotProto().type
-- end

-- function SL:fillLimit()
--     return self._fillLimit or self.ent.prototype.automated_ammo_count or 10
-- end

function SL:useWorst()
    if (obj.type == "fuel") and (not obj:canMove()) then
        return true
    end
    return false
end

function SL:canMove()
    -- if (self._canMove) then
    --     return true
    -- end
    -- return false
    return self:protoInfo().canMove
end

function SL:inserterID()
    if (self._inserterID) then
        return self._inserterID
    end
    return nil
end

--- @return Item
function SL:getItemInfo(arg)
    local t = type(arg)
    local inf
    if (t == "number") then
        inf = itemInfo(ItemDB.category(self:category())[arg])
    elseif (t == "string") then
        inf = itemInfo(arg)
    elseif (t == "table") then
        inf = arg
    end
    return inf
end

function SL:provItem(item)
    if (not item) then
        return
    end
    local inf = self:getItemInfo(item)
    local q = idQ.newChestQ(true)
    local itemList = self._provItems[inf.rank]
    for i = 1, #itemList do
        q:push(itemList[i])
    end
    return q
end

function SL:provItems()
    local items = {}
    --- @type idQ
    local provs
    -- if (betterOnly) then
    -- provs = self:getProvsInRange(false, true, true)
    -- else
    provs = self:getProvsInRange(false, true, false)
    -- end
    for chest in provs:chestIter() do
        local catItems = chest:catItems(self:category())
        for itemName, count in pairs(catItems) do
            local itemInf = itemInfo(itemName)
            local itemQ = items[itemInf.rank]
            if (not itemQ) then
                itemQ = idQ.newChestQ(true)
                items[itemInf.rank] = itemQ
            end
            itemQ:push(chest)
        end
    end
    -- for rank, provs in pairs(self._provItems) do
    --     items[rank] = self:provItem(rank)
    -- end
    return items
end

function SL:betterProvItems()
    local items = {}
    --- @type idQ
    local provs
    provs = self:getProvsInRange(false, true, true)
    for chest in provs:chestIter() do
        local catItems = chest:catItems(self:category())
        for itemName, count in pairs(catItems) do
            if (self:itemIsBetterOrCloser(itemName, chest)) then
                local itemInf = itemInfo(itemName)
                local itemQ = items[itemInf.rank]
                if (not itemQ) then
                    itemQ = idQ.newChestQ(true)
                    items[itemInf.rank] = itemQ
                end
                itemQ:push(chest)
            end
        end
    end
    return items
end

function SL:charGunSlot()
    -- if not self:isCharacter() then
    --     return nil
    -- end
    -- return self.ent.get_inventory(defines.inventory.character_guns)[self:slotInd()]
    return self:slot()
end

function SL:isProvided()
    if (self:needsProvided()) then
        return true
    end
    -- if (self:canMove()) or (SL.entNeedsProvided(self.ent)) then
    --     self._isProvided = true
    --     return true
    -- end
    local sourceID = self:sourceID()
    if (sourceID) then
        local prov = DB.getObj(TC.dbName, sourceID)
        -- if (prov) and (prov.ent) and (prov.ent.valid) then
        if (prov) then
            if (prov:surfaceName() ~= self:surfaceName()) then
                return true
            end
        else
            self:setSourceID(nil)
            return false
        end
    end
    return false
end

--- @param chest Chest
function SL:isInRange(chest)
    local rad = gSets.chestRadius()
    if (rad <= 0) then
        return true
    end
    if (self:surfaceName() == chest:surfaceName()) then
        if (self:distanceSquared(chest) <= rad * rad) then
            return true
        end
    end
    return false
    -- return util.isInRange(self, chest)
end

function SL:area()
    local rad = gSets.chestRadius()
    if rad > 0 then
        return Position.expand_to_area(self:position(), rad)
    end
    return nil
end

---Get this Slot's LuaSurface.
---@return LuaSurface
function SL:surface()
    return game.get_surface(self:surfaceName())
end

---@return string
function SL:surfaceName()
    return self._surfaceName or self.ent.surface.name
end

---@return LuaInventory
function SL:inv()
    if (self._inv) then
        return self._inv
    end
    local invInd = self:invInd()
    if (invInd == "burner") then
        -- cInform("burner inv")
        return self.ent.burner.inventory
    end
    return self.ent.get_inventory(invInd)
end

---Get the LuaItemStack corresponding to this object's inventory slot.
---@return LuaItemStack
function SL:slot()
    return self._slot or self:inv()[self:slotInd()]
    -- if (not s) then
    --     local inv = self:inv()
    --     local slotInd = self:slotInd()
    --     if (inv) and (inv[slotInd]) then
    --         s = inv[slotInd]
    --     end
    -- end
    -- return s
end

function SL:slotItem()
    if (self._slotItem) then
        return self._slotItem
    end
    local stack = self:itemStack()
    if (not stack) or (stack.count <= 0) then
        return
    end
    return stack.name
end

function SL:slotItemInfo()
    return itemInfo(self:slotItem())
end

---Get this Slot's inserter if it has one, otherwise return the inner table this slot uses for filterItem and providerID.
---@return HiddenInserter | table
function SL:inserter()
    local insID = self:inserterID()
    if (insID) then
        return DB.getEntries(HI.dbName)[insID]
    end
    return nil
end

---@return LuaEntity
function SL:inserterEnt()
    if (not isValid(self.ent)) then
        HI.destroyOrphans2()
        return
    end
    if (self:needsProvided()) then
        -- cInform("inserterEnt needs prov")
        return
    end
    if (self._inserterEnt) then
        return self._inserterEnt
    end
    return self:surface().find_entities_filtered {area = self.ent.bounding_box, name = HI.protoName, limit = 1}[1]
    -- return self:surface().find_entity(HI.protoName, self:position())
end

---@return LuaItemStack
function SL:inserterHeldStack()
    local insEnt = self:inserterEnt()
    if (insEnt) and (insEnt.valid) then
        local heldStack = insEnt.held_stack
        if (heldStack) and (heldStack.valid) and (heldStack.valid_for_read) then
            return heldStack
        end
    end
    return SL.emptyStack()
end

---Remove Slot from database and destroy its inserter.
function SL:destroy()
    self._destroying = true
    local insEnt = self:inserterEnt()
    if (isValid(insEnt)) then
        local heldStack = self:inserterHeldStack()
        if (heldStack.count > 0) then
            local remain = self:tryReturnStack({name = heldStack.name, count = heldStack.count})
        end
        insEnt.destroy()
    end
    DB.deleteID(SL.dbName, self.id)
end

---@return Position
function SL:position()
    -- if (self._posX) then
    -- return {x = self._posX, y = self._posY}
    -- end
    return self._position or self.ent.position
end

---Get the Force this Slot belongs to.
---@return Force
function SL:force()
    return Force.get(self:forceName())
end

---Get the name of this Slot's force
---@return string
function SL:forceName()
    return self._forceName or self.ent.force.name
end

---@return Item
function SL:stackInfo()
    local slot = self:slot()
    if (not util.isEmpty(slot)) then
        return itemInfo(slot.name)
    end
    return nil
end

---@return number Integer representing the current provider's ID. Nil if no current provider.
function SL:sourceID()
    -- if (self:needsProvided()) then
    -- return self._sourceID
    -- end
    -- return self._sourceID or self:inserterEnt().pickup_target
    -- local ins = self:inserter()
    -- return SL.vars().sourceID[self.id]
    return self._sourceID
end

---Return Slot's current provider
---@return Chest
function SL:provider()
    return TC.getObj(self:sourceID())
    -- local sourceID = self:sourceID()
    -- if (not sourceID) then
    --     return nil
    -- end
    -- local chest = TC.getObj(sourceID)
    -- if not chest then
    --     return nil
    -- end
    -- return chest
end

---@return Chest
function SL:previousProvider()
    return TC.getObj(self:prevSourceID())
end

---@return Item
function SL:filterInfo()
    return itemInfo(self:filterItem())
end

---@return number Shortcut for getting the score of the current filter item. Returns 0 if no current filter.
function SL:filterScore()
    local inf = self:filterInfo()
    if not inf then
        return 0
    end
    return inf.score
end

---@return string
function SL:filterItem()
    if (self:needsProvided()) then
        return self._filterName
    end
    local insEnt = self:inserterEnt()
    if (isValid(insEnt)) then
        return insEnt.get_filter(1)
    end
    return self._filterName
    -- return self._filterName or self:inserterEnt().get_filter(1)
    -- return self._filterName or self
    -- if (self._filterName) or (self:needsProvided()) then
    -- return self._filterName
    -- end
    -- return self._filterName or self:inserterEnt().get_filter(1)
    -- if (SL.entNeedsProvided(self.ent)) then
    --     return self._filterName
    -- end
    -- return self:inserterEnt().get_filter(1)
end

function SL:hasMoved()
    if (not self:canMove()) then
        return false
    end
    if (not self._lastPos) then
        self._lastPos = self:position()
        return true
    end
    local pos = self:position()
    if (Position.distance_squared(pos, self._lastPos) < 1) then
        return false
    end
    -- if (pos.x ~= self._lastPos.x) or (pos.y ~= self._lastPos.y) then
    self._lastPos = pos
    return true
    -- end
    -- return false
end

---@return Chest
function SL:bestProvider()
    local chests = self:force().chests
    local best = {chest = nil, item = nil, rank = math.huge, dist = math.huge}
    for chest in chests:chestIter() do
        if (self:isInRange(chest)) then
            local items = chest:catItems(self:category())
            for itemName, count in pairs(items) do
                -- local itemName = items[i]
                local inf = itemInfo(itemName)
                if inf.rank < best.rank then
                    best.chest = chest
                    best.item = inf
                    best.rank = inf.rank
                    best.dist = dist2
                elseif (inf.rank == best.rank) then
                    local dist2 = math.huge
                    if (self:surfaceName() == chest:surfaceName()) then
                        dist2 = Position.distance_squared(self:position(), chest:position())
                    end
                    if (dist2 < best.dist) then
                        best.chest = chest
                        best.item = inf
                        best.rank = inf.rank
                        best.dist = dist2
                    end
                end
            end
        end
    end

    return best.chest, best.item
end

--- @param chest Chest
function SL:distanceSquared(chest)
    if (chest:surfaceName() ~= self:surfaceName()) then
        return math.huge
    end

    if (not self:canMove()) then
        local provDist = self.provDist or {}
        if (isPositive(provDist[chest.id])) then
            return provDist[chest.id]
        else
            local dist = Position.distance_squared(self:position(), chest:position())
            provDist[chest.id] = dist
            return dist
        end
    else
        return Position.distance_squared(self:position(), chest:position())
    end
end

function SL:charCheckGunMatchesCat()
    local gunInv = self.ent.get_inventory(defines.inventory.character_guns)
    local ammoInv = self.ent.get_inventory(defines.inventory.character_ammo)
    local gunSlot = gunInv[self:slotInd()]
    if (not isValid(gunSlot)) or (not gunSlot.valid_for_read) then
        if (self._category ~= "") then
            self:setProv()
            self:returnItems(true)
            self._category = ""
        end
    else
        local gunProto = game.item_prototypes[gunSlot.name]
        if (gunProto) and (gunProto.attack_parameters) then
            local ammoCat = gunProto.attack_parameters.ammo_category
            if (not ammoCat) and (gunProto.attack_parameters.ammo_categories) then
                ammoCat = gunProto.attack_parameters.ammo_categories[1]
            end
            if (not ammoCat) then
                if (self._category ~= "") then
                    self:setProv()
                    self:returnItems(true)
                    self._category = ""
                end
            else
                if (self._category ~= ammoCat) then
                    self:setProv()
                    self:returnItems(true)
                    self._category = ammoCat
                    self:setBestProvider()
                end
            end
        end
    end
end

---Check slot inventory and refill if necessary.
function SL:doProvide()
    if (self:isCharacter()) then
        -- self:charCheckGunMatchesCat()
        if (self:category() == "") then
            return
        end
        local cursorStack = self.ent.cursor_stack
        local handLoc = self.ent.player.hand_location
        -- serpLog("handLoc: ", handLoc)
        -- if
        --     (cursorStack) and (cursorStack.valid) and (cursorStack.valid_for_read) and (cursorStack.count > 0) and
        --         (itemInfo(cursorStack.name))
        --  then
        --     -- cInform("cursor stack not empty. abort provide")
        --     return
        -- end
        if
            (handLoc) and (handLoc.inventory) and
                (handLoc.inventory == self.ent.get_inventory(defines.inventory.character_guns))
         then
            return
        end
    end
    local bestProvCalled = false
    if (self:canMove()) then
        if (self:hasMoved()) then
            -- self:addProv(self:nextProvider())
            -- if (self:needsReturn()) then
            -- self:force().needReturn:push(self)

            -- end
            -- self:force().orphans:push(self)
            -- cInform("slot has moved!")
            if (self:sourceID()) and (not self:isInRange(self:provider())) then
                self:setProv()
            -- return
            end
            self:setBestProvider()
            bestProvCalled = true
        end
    -- if (not chest) then
    -- self:setBestProvider()
    -- chest = self:provider()
    -- end
    end
    if
        (not bestProvCalled) and (self:sourceID()) and (self:canMove()) and
            (self:provider():itemAmt(self:filterItem()) <= 0)
     then
        self:setBestProvider()
        bestProvCalled = true
    end
    if (not self:sourceID()) then
        return
    end
    local chest = self:provider()
    local filterItemInf = self:filterInfo()
    if (self.ent.name == "burner-inserter") then
    -- cInform("burnerIns filter: ", filterItemInf.name)
    end
    if (not filterItemInf) then
        return
    end
    local filterItem = filterItemInf.name
    local slot = self:slot()
    local valid = isValid(slot)
    canRead = (valid and slot.valid_for_read)
    if (not valid) or ((canRead) and (slot.count > 0) and (slot.name ~= filterItem)) then
        -- serpLog("doProv not same")
        return
    end
    local sCount = 0
    if (canRead) then
        sCount = slot.count
    end
    local fillLimit = self:slotProto().fillLimit
    if (filterItemInf.stackSize < fillLimit) then
        fillLimit = filterItemInf.stackSize
    end
    local amtToFull = fillLimit - sCount
    if (amtToFull > 0) then
        -- inform("need to fill")
        local fillStack = {name = filterItem, count = amtToFull}
        local amtRemoved = chest:remove(fillStack)
        if (amtRemoved > 0) then
            -- cInform("provide: set_stack")
            -- if (canRead) then
            -- slot.count = sCount + amtRemoved
            -- else
            fillStack.count = sCount + amtRemoved
            slot.set_stack(fillStack)
        -- end
        end
    end
end

---set the sourceID of this Slot's HiddenInserter. For internal use only.
function SL:setSourceID(id)
    local chest = TC.getObj(id)
    if (not chest) then
        id = nil
    end
    -- SL.vars().sourceID[self.id] = id
    self._sourceID = id
    local insEnt = self:inserterEnt()
    if (insEnt) and (insEnt.valid) then
        if (not chest) then
            insEnt.pickup_position = nil
        else
            insEnt.pickup_position = chest:position()
        end
    end
end

---set the filter of this Slot's HiddenInserter. For internal use only.
function SL:setFilterItem(item)
    -- local insID = self:inserterID()
    local insEnt = self:inserterEnt()
    if (insEnt) and (insEnt.valid) then
        insEnt.set_filter(1, item)
        if (not item) then
            insEnt.active = false
        else
            insEnt.active = true
        end
    else
        self._filterName = item
    end
    -- local insEnt = self:inserterEnt()
    -- if (insEnt) and (insEnt.valid) then
    -- local ins = global["DB"]["HiddenInserter"]["idCache"][insID]
    -- if (ins) then
    -- ins:setFilter(item)
    -- end
    -- insEnt.set_filter(1, val)
    -- end
end

---Check if item is better than Slot's current filtered item.
function SL:itemIsBetter(item, equal)
    local curInf = self:filterInfo()
    local newInf = itemInfo(item)
    if (not newInf) or (newInf.category ~= self:category()) then
        return false
    elseif (not curInf) then
        return true
    elseif (newInf.rank < curInf.rank) then
        return true
    elseif (equal) and (newInf.rank == curInf.rank) then
        return true
    end
    return false
end

---Test a provider and item to see if the item is better or the provider is closer to this slot
---@param item string
---@param chest Chest
function SL:itemIsBetterOrCloser(item, chest)
    if (not item) or (not chest) then
        return false
    end
    if (not self:force():entFilterAllows(self, item)) then
        return false
    end
    local curInf = self:filterInfo()
    local newInf = itemInfo(item)
    if (curInf) and (curInf.name == "coal") and (self.ent.name == "burner-inserter") then
    -- serpLog("cur: coal rank ", curInf.rank, ", new: ", item, " rank ", newInf.rank)
    end
    if
        (not newInf) or (newInf.category ~= self:category()) or (not chest) or (not self:isInRange(chest)) or
            (not chest:filterAllows(self))
     then
        return false
    elseif (not curInf) then
        return true
    elseif (newInf.rank < curInf.rank) then
        return true
    elseif (newInf.rank == curInf.rank) and (self:compareProvsByDist(chest, self:provider())) then
        return true
    end
    return false
end

---set this Slot's provider and item filter.
---@param chestObj Chest
---@param item string
function SL:setProv(chestObj, item)
    -- self:clearRender()
    -- if (not self.enabled) then
    -- return
    -- end
    -- self:unpauseInserter()
    local curID = self:sourceID()
    local curFilterItem = self:filterItem()
    if (not curID) and (not curFilterItem) and (not chestObj) and (not item) then
        -- cInform("setprov abort 1")
        return
    elseif (curID) and (chestObj) and (curID == chestObj.id) and (curFilterItem) and (item) and (curFilterItem == item) then
        -- cInform("setprov abort 2")
        return
    end
    if (curID) and (curFilterItem) then
        -- self._slotItem = curFilterItem
        -- local chest = TC.getObj(curID)
        -- if (chest) then
        -- chest.consumerQ:softRemove(self)
        -- end
        self:setPrevSourceID(curID)
    else
        self:setPrevSourceID(nil)
    end
    local force = self:force()
    local insEnt = self:inserterEnt()
    -- if (self._inserterID) then
    -- ins = DB.getObj(HI.dbName, self._inserterID, true)
    -- end
    -- local curProv = self:provider()
    if (not chestObj) or (not item) then
        -- self:setSourceID(nil)
        -- self:setFilterItem(nil)
        -- if (curProv) then
        -- curProv._consumers:softRemove(self)
        -- end
        -- force.orphans:push(self)
        -- if (not self:isProvided()) then
        --     force.providedSlots:softRemove(self)
        -- end
        -- self:toggleRender("all", false)
        -- self:setProvLineTarget()
        -- end
        -- self.isOrphan = true
        -- self:registerCons()
        -- self:force().orphans:push(self)
        -- if (curID) then
        -- self:setSourceID(nil)
        self._sourceID = nil
        self:setFilterItem(nil)
        -- self._filterName = nil
        if (insEnt) and (insEnt.valid) then
            --     insEnt.active = false
            --     -- local prof = game.create_profiler()
            insEnt.pickup_position = nil
        --     insEnt.set_filter(1, nil)
        -- -- else
        -- -- util.printProfiler(prof, "setProv set ins pickup pos")
        -- -- self._filterName = nil
        end
    else
        -- self:setSourceID(chestObj.id)
        -- self:setFilterItem(item)
        -- chestObj._consumers:push(self)
        -- if (curProv) then
        -- curProv._consumers:softRemove(self)
        -- end
        -- if (self._needsProvided) or (chestObj.ent.surface.name ~= self.ent.surface.name) then
        -- if (self:isProvided()) then
        --     force.providedSlots:pushleft(self)
        --     if (insEnt) and (insEnt.valid) then
        --         insEnt.active = false
        --     end
        -- else
        --     force.providedSlots:softRemove(self)
        --     if (insEnt) and (insEnt.valid) then
        --         insEnt.active = true
        --     end
        -- end
        -- self:toggleRender("all", true)
        -- self:setProvLineTarget(chestObj.ent)
        -- end
        -- local stackInf = self:stackInfo()
        -- if (not stackInf) then
        -- local inv = self:inv()
        -- if (not self.gunSlot) and (not inv.is_empty()) then
        --     inv.sort_and_merge()
        --     stackInf = self:stackInfo()
        -- end
        -- if (not stackInf) then
        -- chestObj:itemAmt(item, chestObj:itemAmt(item) - self.fillLimit)
        -- end
        -- end
        -- if (stackInf) and (force:doUpgrade()) then
        -- if (stackInf) and (stackInf.rank > itemInfo(item).rank) then
        -- self:returnItems()
        -- force.needReturn:push(self)
        -- chestObj:itemAmt(item, chestObj:itemAmt(item) - self.fillLimit)
        -- end
        -- end
        -- chestObj.consumerQ:push(self)
        -- force.orphans:softRemove(self)
        -- self.isOrphan = nil
        -- chestObj.provItems[item]:push(self)
        -- local wasOrphan = self.isOrphan
        -- local stack = self:itemStack()
        -- local heldStack = self:heldStack()
        -- local slot = self:slot()
        -- local itemInf = itemInfo(item)
        -- if (slot) and (slot.count > 0) and (itemInfo(slot.name).rank > itemInf.rank) then
        -- end
        -- if (chestObj.id ~= curID) or (item ~= self:filterItem()) then
        -- self:setSourceID(chestObj.id)
        self._sourceID = chestObj.id
        self:setFilterItem(item)
        -- self._filterName = item
        if (insEnt) and (insEnt.valid) then
            -- insEnt.active = true
            -- insEnt.set_filter(1, item)
            -- util.printProfiler(prof, "setProv set ins pickup pos")
            -- local prof = game.create_profiler()
            -- cInform("set prov")
            insEnt.pickup_position = chestObj:position()
        else
            -- cInform("not set prov? ", insEnt)
        end
    end
    if (self:isProvided()) then
        force.providedSlots:pushleft(self)
        if (insEnt) and (insEnt.valid) then
            insEnt.active = false
        end
    else
        force.providedSlots:softRemove(self)
        if (insEnt) and (insEnt.valid) then
            insEnt.active = true
        end
    end
end

function SL:toggleRender(opt, state)
    if (not opt) then
        opt = "all"
    end
    local doHighlight = false
    local doProvLine = false
    if (not state) then
        if (opt == "provLine") then
            state = (not rendering.get_visible(self._render.provLine))
            doProvLine = true
        elseif (opt == "highlight") then
            state = (not rendering.get_visible(self._render.highlight))
            doHighlight = true
        else
            state = (not rendering.get_visible(self._render.highlight))
            doHighlight = true
            doProvLine = true
        end
    end
    if (doHighlight) then
        rendering.set_visible(self._render.highlight, state)
    end
    if (doProvLine) then
        rendering.set_visible(self._render.provLine, state)
    end
end

function SL:setProvLineTarget(ent)
    ent = ent or self.ent
    if (ent.surface.name ~= self:surfaceName()) then
        return
    end
    rendering.set_to(self._render.provLine, ent)
end

function SL:setRenderPlayers(players)
    players = players or {}
    self._render.players = players
    for name, rend in pairs(self._render) do
        if (name ~= "players") then
            rendering.set_players(rend, players)
        end
    end
    -- render.set_players(self._render.highlight, players)
    -- render.set_players(self._render.provLine, players)
end

---Queue this slot to be checked against all chests that are in range and possible providers.
---@param rush boolean
function SL:queueAllProvs(rush)
    -- cInform("queueAllProvs called")
    if not self.enabled then
        return
    end
    local f = self:force()
    local chests = f:chestsFiltered({slot = self, category = self:category()})
    -- local chests = f.chests
    -- local best = {chest = nil, inf = nil}
    for chest in chests:chestIter() do
        -- chest.addQ:push(self)
        -- if (chest:isInRange(self)) then
        for itemName, t in pairs(chest.provItems) do
            local inf = itemInfo(itemName)
            if (inf.category == self:category()) then
                local q = t.queue
                --             -- if (not best.chest) or (inf.rank < best.inf.rank) then
                --             -- best.chest = chest
                --             -- best.inf = inf
                --             -- end
                --             -- local q = chest:itemQ(itemName)
                if (q) then
                    -- inform("no q...")
                    if (rush) then
                        q:pushleft(self)
                    else
                        q:push(self)
                    end
                end
            end
        end
        -- end
    end
    -- if (best.chest) then
    --     self:setProv(best.chest, best.inf.name)
    -- end
end

---Check if this Slot is valid.
function SL:isValid()
    if not self then
        return false
    end
    if (not self.ent) or (not self.ent.valid) then
        return false
    end
    return true
end

---Return items currently in slot to provider or storage.
---@param forceReturn boolean
---@return ItemStack
function SL:returnItems(forceReturn)
    local force = self:force()
    local stackRemain = SL.emptyStack()
    local heldRemain = SL.emptyStack()

    local slot = self:slot()
    if (not util.isEmpty(slot)) then
        stackRemain.name = slot.name
        stackRemain.count = slot.count
    end
    local heldStack = self:inserterHeldStack()
    if (not util.isEmpty(heldStack)) then
        heldRemain.name = heldStack.name
        heldRemain.count = heldStack.count
    end
    if (stackRemain.count + heldRemain.count <= 0) then
        -- cInform("no items to return")
        return stackRemain, heldRemain
    end

    local function clear()
        if (not util.isEmpty(slot)) then
            slot.clear()
        -- self._slotItem = self:filterItem()
        -- self:inv().sort_and_merge()
        end
        if (not util.isEmpty(heldStack)) then
            heldStack.clear()
        end
        local inv = self:inv()
        if (not self:canMove()) and (not inv.is_empty()) then
            for i, c in pairs(inv.get_contents()) do
                local remain = force:sendToStorage({name = i, count = c})
                local ins = c - remain.count
                if (ins > 0) then
                    inv.remove({name = i, count = ins})
                end
            end
        end
    end
    local function returnToChest(chest)
        if not chest then
            return
        end
        if (chest:itemAmt(stackRemain.name) > 0) then
            local stackIns = chest:insert(stackRemain)
            stackRemain.count = stackRemain.count - stackIns
        end
        if (chest:itemAmt(heldRemain.name) > 0) then
            local heldIns = chest:insert(heldRemain)
            heldRemain.count = heldRemain.count - heldIns
        end
    end
    returnToChest(self:previousProvider())
    returnToChest(self:provider())
    stackRemain.count = force:sendToStorage(stackRemain).count
    heldRemain.count = force:sendToStorage(heldRemain).count
    if (stackRemain.count + heldRemain.count <= 0) then
        clear()
        return stackRemain, heldRemain
    end
    if (forceReturn) then
        if (stackRemain.count > 0) then
            util.spillStack(
                {stack = stackRemain, position = self:position(), surface = self:surface(), force = self.ent.force}
            )
        end
        if (heldRemain.count > 0) then
            util.spillStack(
                {stack = heldRemain, position = self:position(), surface = self:surface(), force = self.ent.force}
            )
        end
        clear()
        stackRemain.count = 0
        heldRemain.count = 0
        return stackRemain, heldRemain
    end
    if (not util.isEmpty(slot)) and (not util.isEmpty(stackRemain)) then
        slot.count = stackRemain.count
    end
    if (not util.isEmpty(heldStack)) and (not util.isEmpty(heldRemain)) then
        heldStack.count = heldRemain.count
    end
    return stackRemain, heldRemain
end

function SL.isValidSlot(ent, invIndex, slotIndex)
    if (not isValid(ent)) then
        return false
    end
    local inv = ent.get_inventory(invIndex)
    if not isValid(inv) then
        return false
    end
    local maxSlot = #inv
    if (maxSlot < slotIndex) then
        return false
    end
    local slot = inv[slotIndex]
    if not isValid(slot) then
        return false
    end
    return true
end

---@return integer
function SL.getInvInd(ent, inv)
    for name, ind in pairs(defines.inventory) do
        local newInv = ent.get_inventory(ind)
        if (newInv == inv) then
            return ind
        end
    end
    return nil
end

SL.typesCanMove = {}
SL.typesCanMove["character"] = true
SL.typesCanMove["car"] = true
SL.typesCanMove["artillery-wagon"] = true
SL.typesCanMove["locomotive"] = true

---@param ent LuaEntity
function SL.entCanMove(ent)
    -- if (ent.speed ~= nil) or (ent.type == "character") then
    if (SL.typesCanMove[ent.type]) then
        return true
    end
    return false
end

---@return Slot
function SL.getObj(id)
    return DB.getObj(SL.dbName, id)
end

---Get an array of existing slots whose parent is ent.
---@param ent LuaEntity
---@return Slot[]
function SL.getSlotsFromEnt(ent)
    if (not isValid(ent)) then
        return {}
    end
    local slots = DB.getEntries(SL.dbName)
    local result = {}
    local c = 0
    for id, slotObj in pairs(slots) do
        if (slotObj) and (slotObj.ent == ent) then
            c = c + 1
            result[c] = slotObj
        end
    end
    return result
end

---@param ent LuaEntity
function SL.getSlotsFromEntQ(ent)
    local result = idQ.newSlotQ(true)
    if (not isValid(ent)) then
        return result
    end
    local slots = Force.get(ent.force.name).slots
    for slot in slots:slotIter() do
        if (slot.ent == ent) then
            result:push(slot)
        end
    end
    return result
end

---@return ItemStack
function SL:itemStack()
    local slot = self:slot()
    if (util.isEmpty(slot)) then
        return SL.emptyStack()
    end
    return {name = slot.name, count = slot.count}
    -- if (self.slot ~= nil) then slot = self.slot end
    -- local emptyStack = {name = nil, count = 0}
    -- if (not slot.valid_for_read) then
    --     return SL.emptyStack()
    -- else
    --     return {name = slot.name, count = slot.count}
    -- end
end

function SL:setStack(stack)
    local slot = self:slot()
    if (not stack) or (not stack.name) or (stack.count <= 0) then
        slot.clear()
        return true
    end
    local curStack = self:itemStack()
    if (curStack.count > 0) and (curStack.name ~= stack.name) then
    -- cInform("warning: slot already contains different item. Current items will be overwritten")
    end
    if (slot.can_set_stack(stack)) then
        slot.set_stack(stack)
        return true
    end
    return false
end

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

function SL:slotType()
    return self:slotProto().type
end

function SL:checkEnabled()
    local enabled = true
    local force = self:force()
    local type = self:slotType()
    if (type == "fuel") and (not force:doFuel()) then
        enabled = false
    elseif (type == "fuel") and (not self:canMove()) and (not force:doBurners()) then
        enabled = false
    elseif (self:category() == "artillery-shell") and (not force:doArtillery()) then
        -- cInform("not artillery")
        enabled = false
    elseif ((self.ent.type == "car") or (self.ent.type == "locomotive")) and (not force:doVehicles()) then
        enabled = false
    elseif (self.ent.type == "locomotive") and (not gSets.doTrains()) then
        enabled = false
    end
    return enabled
end

function SL:disable()
    self:setProv()
    self._disabled = true
end

function SL:enable()
    self._disabled = nil
    self:setBestProvider()
end

function SL:enabled()
    if (self._disabled) then
        return false
    end
    return true
end

function SL:renders(player)
    local rend = self.render
    if (not rend[player.index]) then
        rend[player.index] = {}
    end
    return rend[player.index]
end

SL.slotWithProviderColor = {r = 0, g = 0, b = 0.2, a = 0.05}
function SL:highlight(player, color)
    -- rendering.set_players(self._render.highlight, {player})
    -- rendering.set_visible(self._render.highlight, true)
    if (not isValid(self.ent)) or (player.surface.name ~= self:surfaceName()) or (not self:sourceID()) then
        return
    end
    rendering.draw_circle(
        {
            color = SL.slotWithProviderColor,
            radius = 0.75,
            width = 1,
            filled = true,
            target = self.ent,
            surface = self:surface().name,
            players = {player},
            draw_on_ground = false
        }
    )
end

function SL:drawLineToProvider(player)
    -- rendering.set_players(self._render.provLine, {player})
    -- rendering.set_visible(self._render.provLine, true)
    if (not isValid(self.ent)) or (player.surface.name ~= self:surfaceName()) then
        return
    end
    local prov = self:provider()

    if (not prov) or (prov:surfaceName() ~= self:surfaceName()) then
        return
    end
    rendering.draw_line(
        {
            color = {r = 0.5, g = 0, b = 0.5, a = 0.2},
            -- color = util.colors.purple,
            width = 1,
            from = self.ent,
            to = prov.ent,
            surface = self.ent.surface,
            players = {player},
            draw_on_ground = false
        }
    )
end

function SL:setupRender()
    self._render.provLine =
        rendering.draw_line(
        {
            -- color = {r = 0.5, g = 0.125, b = 0.03, a = 0.1},
            color = util.colors.purple,
            width = 1,
            from = self.ent,
            to = self.ent,
            visible = false,
            surface = self:surfaceName(),
            players = {},
            draw_on_ground = false
        }
    )

    self._render.highlight =
        rendering.draw_circle(
        {
            color = util.colors.blue,
            radius = 0.75,
            width = 1,
            filled = true,
            target = self.ent,
            surface = self:surface().name,
            players = {},
            draw_on_ground = false,
            visible = false
        }
    )
end

function SL:provIsCloser(chest)
    if (not chest) or (not self:isInRange(chest)) then
        return false
    end
    local cur = self:provider()
    if (not cur) then
        return true
    end
    local curDist = self:distanceSquared(cur)
    local newDist = self:distanceSquared(chest)
    if (newDist < curDist) then
        return true
    end
    return false
end

function SL:getProvsInRange(ignoreDistForMoveable, checkItems, checkBetter)
    local chests = self:force().chests
    local q = idQ.newChestQ(true)
    for chest in chests:chestIter() do
        if (self:canMove() and ignoreDistForMoveable) or (self:isInRange(chest)) then
            if (not checkItems) then
                q:push(chest)
            else
                local catItems = chest:catItems(self:category())
                if (not empty(catItems)) then
                    if (not checkBetter) then
                        q:push(chest)
                    else
                        for itemName, count in pairs(catItems) do
                            if (self:itemIsBetterOrCloser(itemName, chest)) then
                                q:push(chest)
                            end
                        end
                    end
                end
            end
        end
    end
    return q
end

function SL:nextProvider()
    if (empty(self:category())) then
        return
    end
    local itemRank, provs
    local provItems = self._provItems
    if (gSets.rangeIsInfinite()) then
    end
    while (next(self._provItems, itemRank)) do
        itemRank, provs = next(self._provItems, itemRank)
        if (not itemRank) then
            return
        end
        local provRank, prov
        local canMove = self:canMove()
        while (next(provs, provRank)) do
            provRank, prov = next(provs, provRank)
            local chest = TC.getObj(prov)
            if (chest) and ((not canMove) or self:isInRange(chest)) then
                return chest, self:getItemInfo(itemRank).name
            end
        end
    end
    -- __DebugAdapter.breakpoint()
    return

    -- -- local items = self.provItems
    -- local items = self:betterProvItems()
    -- -- local items = self:getProvsInRange(false, true, true)
    -- local catItems = ItemDB.category(self:category())
    -- local catSize = #catItems
    -- local rad = gSets.chestRadius()
    -- rad = rad * rad
    -- for i = 1, catSize do
    --     --- @type idQ
    --     local provQ = items[i]
    --     if (not empty(provQ)) then
    --         --- @type Item
    --         local itemInf = itemInfo(catItems[i])
    --         local bestDist = math.huge
    --         --- @type Chest
    --         local bestProv
    --         local myPos = self:position()
    --         -- local getDist = Position.distance_squared
    --         for chest in provQ:chestIter() do
    --             if (chest:itemAmt(itemInf.name) >= itemInf.fillLimit) then
    --                 -- if (isPositive(chest._invCache[itemInf.name])) then
    --                 local dist = self:distanceSquared(chest)
    --                 -- if (rad <= 0 or dist <= rad*rad) and (dist <= bestDist) then
    --                 if (dist <= bestDist) then
    --                     bestProv = chest
    --                     bestDist = dist
    --                 end
    --             end
    --             -- provQ:push(chest)
    --             -- end
    --         end
    --         -- if (provQ:size() <= 0) then
    --         --     items[i] = nil
    --         -- end
    --         if (not empty(bestProv)) then
    --             return bestProv, itemInf.name
    --         end
    --     end
    -- end
end

function SL:setNextProvider()
    local curProv = self:provider()
    if (curProv) then
        curProv._consumers:softRemove(self)
    end
    local chest, item = self:nextProvider()
    local itemInf = itemInfo(item)
    self:setProv(chest, item)
    curProv = self:provider()
    if (curProv) then
        curProv._consumers:push(self)
    else
        return
    end
    -- local isEmpty = (self:itemStack().count <= 0)
    if (self:needsReturn()) then
        self:returnItems()
    end
    local stack = self:itemStack()
    local amtToInsert = 0
    if (stack.count <= 0) or (stack.name == itemInf.name) then
        amtToInsert = self:fillLimit() - stack.count
    end
    if (amtToInsert > 0) then
        local curAmt = chest:itemAmt(item)
        chest:itemAmt(item, curAmt - amtToInsert)
    end
end

function SL:setBestProvider()
    if (not self:enabled()) then
        return
    end
    -- local prof = game.create_profiler()
    -- Profiler.Start()
    local cat = self:category()
    if (cat == "") then
        return
    end
    local force = self:force()
    if (self:sourceID()) and (not force:doUpgrade()) then
        return
    end
    -- if (gSets.rangeIsInfinite()) then
    local catItems = force.provCats[cat] or {}
    local bestItemRank = nil
    local bestItem = nil
    local itemRank, provs
    local bestProv = nil --- @type Chest
    local getObj = DB.getObj
    local tSize = table_size
    local itemInfo = itemInfo
    local fillLimit = self:fillLimit()
    local itemsByRank = ItemDB.cats()[cat]
    for i = 1, #itemsByRank do
        if (bestProv) then
            break
        end
        local provs = catItems[i]
        if (provs) and (tSize(provs) > 0) then
            bestItemRank = i
            bestItem = itemInfo(itemsByRank[i])
            if (force:entFilterAllows(self, bestItem.name)) then
                for provID, _ in pairs(provs) do
                    local curProv = getObj(TC.dbName, provID) ---@type Chest
                    if
                        (curProv) and (curProv:filterAllows(self)) and (self:isInRange(curProv)) and
                            (curProv:itemAmt(bestItem.name) >= fillLimit)
                     then
                        -- if (curProv:itemAmt(bestItem.name) >= fillLimit) then
                        if (not bestProv) then
                            bestProv = curProv
                        elseif (not self:compareProvsByDist(curProv, bestProv)) then
                            bestProv = curProv
                        end
                    -- end
                    end
                end
            end
        end
    end
    if (bestProv) then
        self:setProv(bestProv, bestItem.name)
        local slotInfo = self:slotItemInfo()
        if (slotInfo) then
            if (slotInfo.rank > bestItem.rank) then
                if (force:doReturn()) then
                    force.slotsNeedReturnQ:push(self)
                    bestProv:cacheRemove(bestItem.name, fillLimit)
                end
            end
        else
            bestProv:cacheRemove(bestItem.name, fillLimit)
        end
    end
    return bestProv, bestItem
end

function SL:getCompareProvsByDistFunc()
    return function(id1, id2)
        return self:compareProvsByDist(id1, id2)
    end
end

--- returns true if id1 is closer to the TrackedSlot than id2
--- @param id1 number
---@param id2 number
---@return boolean
function SL:compareProvsByDist(id1, id2)
    local prov1 = TC.getObj(id1)
    local prov2 = TC.getObj(id2)
    if (prov1) and (not prov2) then
        return true
    end
    if (not prov1) then
        return false
    end
    local dist1 = self:distanceSquared(prov1)
    local dist2 = self:distanceSquared(prov2)
    if (dist1 < dist2) then
        return true
    end
    return false
end

--- @param chest Chest
--- @param item Item
function SL:addProv(chest, item)
    if (empty(self:category())) then
        return false
    end
    local chestID
    if (type(chest) == "number") then
        chestID = chest
    elseif (not empty(chest.id)) then
        chestID = chest.id
    end
    chest = TC.getObj(chestID)
    if (not chest) then
        return false
    end
    local items = self._provItems
    local itemInf = self:getItemInfo(item)

    local provs = items[itemInf.rank]
    if (not provs) then
        provs = {}
        items[itemInf.rank] = provs
    end
    provs[#provs + 1] = chestID
    table.sort(provs, self:getCompareProvsByDistFunc())
    local filterInf = self:filterInfo()
    local isBetter = false
    if (not filterInf) then
        isBetter = true
    elseif (itemInf.rank < filterInf.rank) then
        isBetter = true
    elseif (itemInf.rank == filterInf.rank) and (self:compareProvsByDist(chestID, self:sourceID())) then
        isBetter = true
    end
    if (isBetter) then
        self:setNextProvider()
        return true
    -- self:force().needReturn:push(self)
    end
    return false
end

--- @param chest Chest
--- @param item Item
function SL:removeProv(chest, item)
    if (empty(self:category())) then
        return false
    end
    local chestID
    if (type(chest) == "number") then
        chestID = chest
    elseif (not empty(chest.id)) then
        chestID = chest.id
    end
    -- local items = self.provItems
    -- if (not item) then
    -- self:removeChestProvs(chest)
    -- else
    local itemInf = self:getItemInfo(item)
    local provItems = self._provItems
    if (not item) then
        local curRank, provs
        while (next(provItems, curRank)) do
            curRank, provs = next(provItems, curRank)
            Array.remove(provs, chestID)
            if (not next(provs)) then
                provItems[curRank] = nil
            end
        end
    else
        local provs = provItems[itemInf.rank]
        if (not provs) then
            return
        end
        Array.remove(provs, chestID)
        if (not next(provs)) then
            provItems[itemInf.rank] = nil
        end
    end
    -- local q = items[itemInf.rank]
    -- self.provDist[chest.id] = nil
    -- if (not q) then
    --     return
    -- end
    -- q:softRemove(chest)
    -- if (q:size() <= 0) then
    --     items[itemInf.rank] = nil
    -- end
    if ((not item) or (self:filterItem() == item)) and (chestID == self:sourceID()) then
        local curProv = self:provider()
        if (curProv) then
            curProv._consumers:softRemove(self)
        end
        -- self:setProv()
        self:setNextProvider()
        -- local firstItemRank, firstProvs = next(provItems)
        -- if (firstItemRank) then
        --     local firstItemInfo = self:getItemInfo(firstItemRank)
        --     local firstProvInd, firstProv = next(firstProvs)
        --     if (firstProvInd) then
        --         local setItem = firstItemInfo.name
        --         local setChest = TC.getObj(firstProv)
        --         if (setChest) then
        --             self:setProv(setChest, setItem)
        --         end
        --     end
        -- end
        curProv = self:provider()
        if (curProv) then
            curProv._consumers:push(self)
        end
        return true
    end
    return false
    -- end
end

---@param chest Chest
function SL:removeChestProvs(chest)
    if (empty(self:category())) then
        return
    end
    -- local items = self.provItems
    local items = self:provItems()
    local cat = ItemDB.category(self:category())
    for i = 1, #cat do
        if (not empty(items[i])) then
            self:removeProv(chest, itemInfo(cat[i]).name)
        end
    end
end

function SL:addProvsInRange()
    self._provItems = {}
    if (empty(self:category())) then
        return
    end
    for chest in self:getProvsInRange(true, true, false):chestIter() do
        for itemName, count in pairs(chest:catItems(self:category())) do
            self:addProv(chest, itemName)
        end
    end
end

function SL:needsReturn()
    if (not self:force():doReturn()) then
        return false
    end
    -- local slotInf = itemInfo(self:itemStack().name)
    local slotInf = self:slotItemInfo()
    if (not slotInf) then
        return false
    end
    local filterInf = self:filterInfo()
    if (not filterInf) then
        return false
    end
    if (filterInf.rank < slotInf.rank) then
        return true
    end
    return false
end

function SL:willNeedReturn(item)
    if (not self:force():doReturn()) then
        return false
    end
    -- local slotInf = itemInfo(self:itemStack().name)
    local slotInf = self:slotItemInfo()
    if (not slotInf) then
        return false
    end
    local filterInf = itemInfo(item)
    if (filterInf.rank < slotInf.rank) then
        return true
    end
    return false
end

function SL:tick()
    --- @type Chest
    local bestChest
    --- @type Item
    local bestItemInf
    bestChest, bestItem = self:nextProvider()
    bestItemInf = itemInfo(bestItem)
    local curID = self:sourceID()

    if (not bestChest) then
        if (not empty(curID)) then
            self:setProv()
        end
    elseif (empty(curID)) or (bestChest.id ~= curID) or (bestItemInf.name ~= self:filterItem()) then
        self:setProv(bestChest, bestItemInf.name)
    -- local curAmt = bestChest:itemAmt(bestItemInf.name)
    -- bestChest:itemAmt(bestItemInf.name, curAmt - bestItemInf.fillLimit)
    end
end

function SL.tickForce(forceName, limit)
    if not forceName then
        return
    end
    if not limit then
        limit = gSets.slotsPerCycle()
    end
    local force = Force.get(forceName)
    for slot in force.slots:slotIter(limit, false) do
        slot:tick()
    end
end

function SL.tickAll()
    local limit = gSets.slotsPerCycle()
    for forceName, force in pairs(Force.forces()) do
        SL.tickForce(forceName, limit)
    end
end

--- @return fun():Slot
function SL.slotIter(limit, startID)
    return DB.iter(SL.dbName, limit, startID)
end

function SL.onPlayerMinedReturnInventory(e)
    local ent = e.entity
    local buffer = e.buffer
    if (not gSets.doReturn()) or (not SL.entIsTrackable(ent)) then
        return
    end
    local slots = SL.getSlotsFromEnt(ent)
    if (not slots[1]) or (not slots[1]:force():doReturn()) then
        return
    end
    for i, slot in pairs(slots) do
        for item, count in pairs(buffer.get_contents()) do
            local info = itemInfo(item)
            if (info) then
                local remain = slot:tryReturnStack({name = item, count = count})
                buffer.remove({name = item, count = count - remain.count})
            end
        end
        slot:destroy()
    end
end
onEvents(SL.onPlayerMinedReturnInventory, {"on_player_mined_entity"})

---@param stack ItemStack
---@return ItemStack Stack of items that were unable to be returned.
function SL:tryReturnStack(stack)
    if (not stack) or (stack.count <= 0) then
        return SL.emptyStack()
    end
    local prov = self:provider()
    local prevProv = self:previousProvider()
    if (stack.count > 0) and (prov) then
        local amtToInsert = prov:amtCanReturn(stack)
        if (amtToInsert > 0) then
            local amtInserted = prov:insert({name = stack.name, count = amtToInsert})
            stack.count = stack.count - amtInserted
        end
    end
    if (stack.count > 0) and (prevProv) then
        local amtToInsert = prevProv:amtCanReturn(stack)
        if (amtToInsert > 0) then
            local amtInserted = prevProv:insert({name = stack.name, count = amtToInsert})
            stack.count = stack.count - amtInserted
        end
    end
    if (stack.count > 0) then
        local remain = self:force():sendToStorage(stack, self)
        stack.count = remain.count
    end
    return stack
end

function SL.onRemoveSlotDestroy(e)
    ---@type LuaEntity
    local ent = event.entity
    if (not isValid(ent)) then
        return
    end
    local forceName = ent.force.name
    local cause = event.cause
    if (forceName == "neutral") or (forceName == "enemy") then
        return
    end
    -- if (ent.name == HI.protoName) then
    --     for ins in DB.iter(HI.dbName) do
    --         if (ins.ent == ent) then
    --             ins:destroy()
    --             return
    --         end
    --     end
    -- end
    if (TC.isChestName(ent.name)) then
        local chest = TC.getChestFromEnt(ent)
        if (chest) then
            chest:destroy()
        end
        return
    end
    -- local tracked = EntDB.names()
    -- if EntDB.contains(ent.name) then
    -- for slot in EntDB.iterTrackedSlots(ent) do
    if SL.entIsTrackable(ent) then
        -- local prof = game.create_profiler()
        local entPos = ent.position
        -- for slot in Force.get(ent.force.name).slots:slotIter() do
        -- for i = 1, DB.highest(SL.dbName) do
        for slot in SL.slotIter() do
            -- local slot = SL.getObj(i)
            -- if (slot) then
            if (slot.ent == ent) then
                -- if (Position.distance_squared(entPos, slot:position()) < 1) and (slot.ent == ent) then
                local retBool = slot:force():doReturn()
                if (retBool) and (not cause) then
                    cInform("try to return for destroy...")
                    slot:returnItems()
                end
                inform("destroy slot")
                slot:destroy()
            end
        end
    end
    -- util.printProfiler(prof, "onRemove")
    -- __DebugAdapter.print(game.to,alsoLookIn)
    -- end
    -- end
    -- end
end
-- onEvents(
--     SL.onRemoveSlotDestroy,
--     {"on_robot_pre_mined", "on_entity_died", "script_raised_destroy"}
-- )

---@return boolean @true if inserter.active was changed. Otherwise false.
function SL:pauseInserter()
    local ins = self:inserterEnt()
    if (not isValid(ins)) or (not ins.active) then
        return false
    end
    ins.active = false
    return true
end

---@return boolean @true if inserter.active was changed. Otherwise false.
function SL:unpauseInserter()
    local ins = self:inserterEnt()
    if (not isValid(ins)) or (ins.active) then
        return false
    end
    ins.active = true
end

return SL
