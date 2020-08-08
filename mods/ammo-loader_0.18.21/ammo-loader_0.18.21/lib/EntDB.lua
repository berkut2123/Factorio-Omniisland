EntDB = {}

EntDB.dbName = "EntDB"

EntDB.ammoTypes = {}
EntDB.ammoTypes["car"] = 1
EntDB.ammoTypes["ammo-turret"] = 1
EntDB.ammoTypes["artillery-wagon"] = 1
EntDB.ammoTypes["artillery-turret"] = 1
EntDB.ammoTypes["character"] = 1

Init.registerFunc(
    function()
        global["EntDB"] = {}
        -- global["EntDB"]["ammoEnts"] = {}
        -- global["EntDB"]["fuelEnts"] = {}
        -- global["EntDB"]["turretAmmoCategories"] = {}
        -- global["EntDB"]["carAmmoCategories"] = {}
        global["EntDB"]["entCategories"] = {}
        global.EntDB.fillLimits = {}
        global.EntDB.entProtos = {}
        -- global["EntDB"]["ents"] = EntDB.findEntNames()
        -- global["EntDB"]["ents"] = {}
        -- global["EntDB"]["ents"][protoNames.hiddenInserter] = nil
        -- global["EntDB"]["tracked"] = {}
        -- global["EntDB"]["hash"] = {}
        -- global["EntDB"]["ammoEnts"] = {}
        -- global["EntDB"]["fuelEnts"] = {}

        -- for name, proto in pairs(
        --     game.get_filtered_entity_prototypes(
        --         {{filter = "turret"}, {filter = "vehicle"}, {filter = "type", type = "character"}}
        --     )
        -- ) do
        --     if (proto.type ~= "car") or (proto.guns) then
        --         global["EntDB"]["ammoEnts"][proto.name] = true
        --     end
        -- end
        -- for name, proto in pairs(game.entity_prototypes) do
        --     if (proto.burner_prototype) then
        --         global["EntDB"]["fuelEnts"][proto.name] = true
        --     end
        -- end
    end
)

function EntDB.ammoEnts()
    return global["EntDB"]["ammoEnts"]
end

function EntDB.fuelEnts()
    return global["EntDB"]["fuelEnts"]
end

function EntDB.entCategories()
    return global["EntDB"]["entCategories"]
end

function EntDB.entProtos()
    return global.EntDB.entProtos
end

function EntDB.proto(name)
    local protos = EntDB.entProtos()
    local proto = protos[name]
    if not proto then
        proto = {}
        protos[name] = proto
    end
    return proto
end

function EntDB.invProto(name, invInd)
    local proto = EntDB.proto(name)
    local invProtos = proto.invProtos
    if not invProtos then
        invProtos = {}
        proto.invProtos = invProtos
    end
    local invProto = invProtos[invInd]
    if not invProto then
        invProto = {}
        invProtos[invInd] = invProto
    end
    return invProto
end

function EntDB.slotProto(name, invInd, slotInd)
    local invProto = EntDB.invProto(name, invInd)
    local slotProto = invProto[slotInd]
    if (not slotProto) then
        slotProto = {}
        invProto[slotInd] = slotProto
    end
    return slotProto
end

function EntDB.fillLimits()
    return global["EntDB"]["fillLimits"]
end

function EntDB.getCategories(ent, invInd, slotInd)
    if (not ent) or (not ent.valid) or (not invInd) or (not slotInd) then
        return {}
    end
    local entObj = EntDB.entCategories()[ent.name]
    if (not entObj) then
        entObj = {}
        EntDB.entCategories()[ent.name] = entObj
    end
    local invObj = entObj[invInd]
    if (not invObj) then
        invObj = {}
        entObj[invInd] = invObj
    end
    local cats = invObj[slotInd]
    local type = "ammo"
    if (not cats) then
        local inv = ent.get_inventory(invInd)
        if (not inv) or (not inv.valid) then
            return {}
        end
        local slot = inv[slotInd]
        if (not slot) or (not slot.valid) then
            return {}
        end
        cats = EntDB.getSlotCategory(slot)
        if (cats) and (#cats > 0) then
            invObj[slotInd] = cats
            return cats
        end
    else
        return cats
    end
end

function EntDB.getCategory(ent, invInd, slotInd)
    local cats = EntDB.getCategories(ent, invInd, slotInd)
    if (cats) and (#cats > 0) then
        return cats[1]
    end
end

--- Test a LuaItemStack against all items to find its ammo/fuel category
--- @param itemSlot LuaItemStack
function EntDB.getSlotCategories(itemSlot)
    local canInsert = itemSlot.can_set_stack
    if (canInsert({name = "iron-plate", count = 1})) then
        return nil
    end
    local cats = {}
    local type = "ammo"
    for name, ranks in pairs(ItemDB.cats()) do
        local item = itemInfo(ranks[1])
        if (item) and (canInsert({name = item.name, count = 1})) then
            -- if (canInsert({name = name, count = 1})) then
            -- if (item.category == "artillery-shell") then
            -- cInform("get cat artillery shell")
            -- end
            table.insert(cats, item.category)
            type = item.type
        -- return info.category, info.type
        end
    end
    return cats, type
end

---Get names of all LuaEntities that are trackable as Slots. Is in hash form.
function EntDB.names()
    return global.EntDB.ents
end
EntDB.protoNames = EntDB.names

function EntDB.entHash()
    return global["EntDB"]["hash"]
end

function EntDB.contains(name)
    if (global["EntDB"].ents[name]) then
        return true
    end
    return false
end

function EntDB.findEntNames(class)
    local res = {}
    local protos = game.entity_prototypes
    local count = 0
    for name, proto in pairs(protos) do
        if (not class or class == TC.className) and (TC.isChestName(name)) then
            res[name] = true
        end
        local burnerProto = proto.burner_prototype
        if
            ((not class) or (class == SL.className)) and ((burnerProto) and (burnerProto.fuel_inventory_size > 0)) or
                ((proto.guns) or (proto.automated_ammo_count) or (EntDB.ammoTypes[proto.type]))
         then
            count = count + 1
            res[proto.name] = true
        end
    end
    return res
end

function EntDB.isProtoName(name)
    if (EntDB.protoNames()[name]) then
        return true
    end
    return false
end

function EntDB.tracked()
    return global.EntDB.tracked
end

function EntDB.addTracked(obj, ent)
    ent = ent or obj.ent
    local id = EntDB.entID(ent)
    local list = global.EntDB.tracked[id]
    if (not list) then
        list = {}
        global.EntDB.tracked[id] = list
    end
    -- local dbList = list[obj.dbName]
    -- if (not dbList) then
    --     dbList = {}
    --     list[obj.dbName] = dbList
    -- end
    table.insert(list, {dbName = obj.dbName, id = obj.id})
end

function EntDB.iterTracked(ent, dbName)
    local tracked = EntDB.tracked()
    local id = EntDB.entID(ent)
    local list = tracked[id] or {}
    local key, info
    local function iter()
        key, info = next(list, key)
        if (not key) then
            return
        end
        if (dbName) and (info.dbName ~= dbName) then
            return iter()
        end
        local obj = DB.getObj(info.dbName, info.id)
        if (not obj) then
            list[key] = nil
            if (Map.size(list) <= 0) then
                tracked[id] = nil
                return
            end
            return iter()
        end
        if (obj.ent == ent) then
            return obj
        end
        return iter()
    end
    return iter
end

---@return fun():Slot
function EntDB.iterTrackedSlots(ent)
    return EntDB.iterTracked(ent, SL.dbName)
end

---@return fun():HiddenInserter
function EntDB.iterTrackedInserters(ent)
    return EntDB.iterTracked(ent, HI.dbName)
end

function EntDB.trackedCount(ent, dbName)
    local c = 0
    for obj in EntDB.iterTracked(ent, dbName) do
        c = c + 1
    end
    return c
end

function EntDB.entID(ent)
    if (not isValid(ent)) then
        return ""
    end
    local id = ""
    id = id .. ent.name
    id = id .. ent.force.name
    id = id .. ent.surface.name
    if (not SL.entCanMove(ent)) then
        local pos = ent.position
        -- id = id .. math.floor(pos.x)
        -- id = id .. math.floor(pos.y)
        id = id .. pos.x
        id = id .. pos.y
    end
    return id
end

function EntDB.purgeTracked()
    local tracked = EntDB.tracked()
    for entID, list in pairs(tracked) do
        for key, info in pairs(list) do
            local obj = DB.getObj(info.dbName, info.id)
            if (not obj) then
                list[key] = nil
            end
        end
        if (Map.size(list) <= 0) then
            tracked[entID] = nil
        end
    end
end
