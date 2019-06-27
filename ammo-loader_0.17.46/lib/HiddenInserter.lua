--[[--
Class with unique id's representing the hidden inserters for slots.
@classmod HI
@alias HiddenInserter
]]
HI = {}
HiddenInserter = HI

HI.className = "HiddenInserter"
HI.dbName = HI.className
DB.register(HI.dbName)
HI.protoName = "ammo-loader-hidden-inserter"
HI.wire = defines.wire_type.green

HI.objMT = {
    __index = HI
}

function HI._init()
    local list = util.allFind({name = HI.protoName})
    for i = 1, #list do
        local ent = list[i]
        local held = ent.held_stack
        if isValid(held) and (held.valid_for_read) then
            local heldStack = {name = held.name, count = held.count}
            local pickup = ent.pickup_target
            if (heldStack.count > 0) and (isValid(pickup)) then
                local amtPickup = pickup.insert(heldStack)
                heldStack.count = heldStack.count - amtPickup
            end
            local drop = ent.drop_target
            if (heldStack.count > 0) and (isValid(drop)) then
                local amtDrop = drop.insert(heldStack)
                heldStack.count = heldStack.count - amtDrop
            end
        end
        ent.destroy()
    end
    -- DB.new(HI.dbName)
end
Init.registerInitFunc(HI._init)

function HI._onLoad()
    for id, obj in pairs(DB.getAll(HI.dbName)) do
        setmetatable(obj, HI.objMT)
        -- setmetatable(obj.connectedQ, idQ.objMT)
    end
end
Init.registerOnLoadFunc(HI._onLoad)

-- function HI.protoName()
--     return "ammo-loader-hidden-inserter"
-- end
function HI.getFuelStack()
    local fuelName = "ammo-loader-superfuel"
    return {name = fuelName, count = 1}
end

function HI.dbInsert(self)
    return DB.insert(HI.dbName, self)
end

function HI.getObj(id)
    return DB.getObj(HI.dbName, id)
end

function HI.destroyAll()
    for id, obj in pairs(DB.getAll(HI.dbName)) do
        obj:destroy()
    end
end

function HI.new(slotObj)
    if (not slotObj) then
        return nil
    end

    local obj = {}
    setmetatable(obj, HI.objMT)

    obj.parentID = slotObj.id
    -- obj.sourcePosition = {}
    -- obj.targetPosition = slotObj.id
    -- obj.itemName = itemName
    local newInserter = slotObj.ent.surface.create_entity({name = protoNames.hiddenInserter, position = slotObj:position(), force = slotObj.ent.force.name})
    if not isValid(newInserter) then
        return nil
    end

    -- newInserter.pickup_position = chestObj.ent.position
    newInserter.drop_position = slotObj:position()
    -- newInserter.set_filter(1, itemName)
    newInserter.destructible = false
    newInserter.operable = false
    newInserter.rotatable = false
    newInserter.minable = false
    newInserter.inserter_stack_size_override = 1
    -- newInserter.burner.inventory.insert(HI.getFuelStack())
    -- newInserter.active = false
    obj.ent = newInserter
    HI.setDropPosition(obj, slotObj:position())
    -- obj.controlBehavior = newInserter.get_or_create_control_behavior()
    -- local control = obj.controlBehavior
    -- control.circuit_mode_of_operation = defines.control_behavior.inserter.circuit_mode_of_operation.set_filters
    -- obj.connectedIDs = {}
    -- obj.connectedQ = idQ.new(TC)
    obj.id = HI.dbInsert(obj)
    obj:force():addInserter(obj)
    -- HI.checkCircuits(obj)
    -- local nextLowest = SL.getNextLowestScore(slotObj)
    -- Array.insert(slotObj.inserterIDs, obj)
    return obj
end

HI.force = function(self)
    return Force.get(self.ent.force.name)
end

-- HI.getControlBehavior = function(self)
--     return self.ent.get_or_create_control_behavior()
-- end
HI.getPickupPosition = function(self)
    if not self.filterName then
        return nil
    end
    return TC.getObj(self.sourceID):position()
end
HI.pickupPosition = HI.getPickupPosition
HI.pickupPos = HI.getPickupPosition

HI.setPickupPosition = function(self, val)
    -- if (not self.sourceID) and (not val) then
    --     return nil
    -- end
    self.ent.pickup_position = val
    -- if (not val) then
    --     self.ent.active = false
    -- else
    --     self.ent.active = true
    -- end
end

HI.getDropPosition = function(self)
    return self.ent.drop_position
end
HI.dropPosition = HI.getDropPosition
HI.dropPos = HI.getDropPosition

HI.setDropPosition = function(self, val)
    -- self.ent.drop_position = {x = val.x - 0.25, y = val.y + 0.25}
    self.ent.drop_position = val
    -- inform("HI: new drop target = " .. self.ent.drop_target.name .. ", pos = {" .. tostring(val.x) .. ", " .. tostring(val.y) .. "}")
    -- inform("HI: new pos = {" .. tostring(val.x) .. ", " .. tostring(val.y) .. "}")
    local parentpos = self:parent():position()
    -- inform("{" .. parentpos.x .. ", " .. parentpos.y .. "}")
end

HI.getPickupTarget = function(self)
    if (not self.sourceID) then
        return nil
    end
    local chest = TC.getObj(self.sourceID)
    if not chest then
        self:setPickupTarget(nil)
    end
    return chest
end
HI.pickupTarget = HI.getPickupTarget

HI.setPickupTarget = function(self, chestObj)
    if (not chestObj) then
        self.sourceID = nil
        -- if (self.filterName) then
        --     self:setFilter(nil)
        -- end
        return
    end
    self.sourceID = chestObj.id
    return self:setPickupPosition(chestObj:position())
end

HI.getDropTarget = function(self)
    return self.ent.drop_target
end
HI.dropTarget = HI.getDropTarget

HI.getFilterInfo = function(self)
    return ItemDB.item.get(self.filterName)
end
HI.filterInfo = HI.getFilterInfo
HI.itemInfo = HI.filterInfo
HI.filter = HI.filterInfo

HI.setFilter = function(self, val)
    self.filterName = val
    self.ent.set_filter(1, val)
    -- if (not val) then
    --     self.ent.active = false
    -- else
    --     self.ent.active = true
    -- end
    -- if (not val) and (self.sourceID) then
    --     self:setPickupTarget(nil)
    -- end
end

HI.getItemScore = function(self)
    return self:getFilterInfo().score
end

HI.getSlotObj = function(self)
    return SL.getObj(self.parentID)
end
HI.slotObj = HI.getSlotObj
HI.parent = HI.getSlotObj

function HI.isValid(self)
    if (not self) then
        return false
    end
    if (not self.ent) or (not self.ent.valid) or (not DB.getEntries(SL.dbName)[self.parentID]) then
        return false
    end
    return true
end

function HI.setSourceAndItem(self, chestObj, item)
    if (not chestObj) or (not item) then
        self.sourceID = nil
        self:setFilter(nil)
        -- self.ent.active = false
        inform("HI: source and filter set to nil")
        return
    else
        self:setPickupTarget(chestObj)
        self:setFilter(item)
        -- self.ent.active = true
        inform("HI: pickup_target=" .. self:getPickupTarget().ent.name .. ", item=" .. item)
    end
end

function HI.giveHeld(self, slot)
    local ent = self.ent
    if (not isValid(ent)) then
        return
    end
    local heldStack = ent.held_stack
    if (not heldStack) or (not heldStack.valid_for_read) then
        return -1
    end
    -- local amt = heldStack.count
    -- local itemName = heldStack.name
    -- local slotObj = self:parent()
    -- local slot = slotObj:slot()
    if (slot) and (slot.valid) then
        if (heldStack.count > 0) then
            local newStack = {name = nil, count = 0}
            if (slot.valid_for_read) then
                newStack = {name = slot.name, count = slot.count}
            end
            if (not newStack.name) or (newStack.name == heldStack.name) then
                newStack.name = heldStack.name
                newStack.count = newStack.count + heldStack.count
                if (slot.can_set_stack(newStack)) then
                    slot.set_stack(newStack)
                    -- local slotStack = slotObj:itemStack()
                    -- local remaining = newStack.count - slotStack.count
                    -- heldStack.count = remaining
                    heldStack.clear()
                    return 0
                end
            end
        end
    end
    local source = self:pickupTarget()
    if (heldStack.count > 0) and (source ~= nil) then
        local amtSource = source.inv.insert(heldStack)
        if (amtSource >= heldStack.count) then
            heldStack.clear()
            return 0
        else
            heldStack.count = heldStack.count - amtSource
        end
    end
    if (heldStack.count > 0) then
        ent.surface.spill_item_stack(ent.position, heldStack)
        heldStack.clear()
        return 0
    end
end

function HI.destroy(self, slot)
    inform("destroying inserter")
    -- if not self then
    --     return nil
    -- end
    -- local insList = self.slotObj.inserterIDs
    -- Array.remove(insList, self.id)
    self:giveHeld(slot)
    DB.deleteID(HI.dbName, self.id)
    if (isValid(self.ent)) then
        self.ent.destroy()
    end
    return true
end
return HiddenInserter
