---@class Item
---@field name string
---@field type string @One of "fuel" or "ammo"
---@field category string
---@field score number
---@field rank number
---@field fillLimit number
---@field stackSize number
---@field magSize number
---@field isCartridge boolean

ItemDB = {}

ItemDB.dbName = "ItemDB"

ItemDB.types = {}
ItemDB.types.fuel = "fuel"
ItemDB.types.ammo = "ammo"
ItemDB.types.any = "any"

ItemDB.radiusWeight = 0.3
ItemDB.damageTypeWeights = {}
-- ItemDB.damageTypeWeights = {explosion = 1.05, fire = 1.1, poison = 0.9, laser = 1.05}

Init.registerFunc(
    function()
        -- DB.new(ItemDB.itemDBName)
        -- DB.new(ItemDB.catDBName)
        global["ItemDB"] = {}
        global["ItemDB"]["items"] = {}
        global["ItemDB"]["categories"] = {}
        global["ItemDB"]["exampleStacks"] = {}

        if (global.persist) and (global.persist.ItemDB) then
            if (global.persist.ItemDB.items) then
                global.ItemDB.items = global.persist.ItemDB.items
            end
            if (global.persist.ItemDB.categories) then
                global.ItemDB.categories = global.persist.ItemDB.categories
            end
        end

        -- log(game.get_filtered_item_prototypes({{filter = "type", type = "ammo"}}))

        for name, ammo in pairs(game.get_filtered_item_prototypes({{filter = "type", type = "ammo"}})) do
            ItemDB.newAmmo(ammo)
        end
        for name, fuel in pairs(game.get_filtered_item_prototypes({{filter = "fuel"}})) do
            ItemDB.newFuel(fuel)
        end
        -- for name, proto in pairs(game.item_prototypes) do
        -- ItemDB.newItem(name)
        -- end
        ItemDB.updateRanks()
    end
)

Init.registerPreInitFunc(
    function()
        if (not global.ItemDB) or (not global.ItemDB.items) or (not global.ItemDB.categories) then
            return
        end
        global.persist["ItemDB"] = {}
        global.persist.ItemDB["items"] = global.ItemDB.items
        global.persist.ItemDB["categories"] = global.ItemDB.categories
    end
)

function ItemDB.items()
    return global["ItemDB"]["items"]
end
function ItemDB.cats()
    return global["ItemDB"]["categories"]
end
ItemDB.categories = ItemDB.cats
function ItemDB.ammoCats()
    local res = {}
    local ammoCats = game.ammo_category_prototypes
    for catName, cat in pairs(ItemDB.cats()) do
        if (ammoCats[catName]) then
            res[catName] = cat
        end
    end
    return res
end
function ItemDB.fuelCats()
    local res = {}
    local fuelCats = game.fuel_category_prototypes
    for catName, cat in pairs(ItemDB.cats()) do
        if (fuelCats[catName]) then
            res[catName] = cat
        end
    end
    return res
end
function ItemDB.exampleStacks()
    return global["ItemDB"]["exampleStacks"]
end
function ItemDB.getExampleStack(catName)
    return ItemDB.exampleStacks()[catName]
end
function ItemDB.makeExampleStack(itemName)
    return {name = itemName, count = 1}
end

ItemDB.fillLimit = {}
ItemDB.fillLimit.ammo = 10
ItemDB.fillLimit.artillery = 3
ItemDB.fillLimit.fuel = 10

---@param name string
---@return Item
function ItemDB.newItem(name)
    if (not name) or (not game.item_prototypes[name]) or (ItemDB.items()[name]) then
        return nil
    end
    -- if (ItemDB.useCartridges()) and (not name:find(protoNames.cartridgePrefix)) then
    -- return
    -- end
    local proto = game.item_prototypes[name]
    local obj = {} ---@type Item
    obj.name = name
    local ammoType = proto.get_ammo_type()
    if (ammoType) then
        -- cInform(ammoType)
        obj.category = ammoType.category
        obj.type = ItemDB.types.ammo
    elseif (proto.fuel_value) then
        obj.category = proto.fuel_category
        obj.type = ItemDB.types.fuel
    end

    if (not obj.category) or (not obj.type) then
        return nil
    end
    -- obj.fillLimit = (obj.category == "artillery-shell") and ItemDB.fillLimit.artillery or (obj.type == "fuel") and ItemDB.fillLimit.fuel or ItemDB.fillLimit.ammo
    cInform("ItemDB type: ", obj.fillLimit)
    if (obj.category == "artillery-shell") then
        obj.fillLimit = ItemDB.fillLimit.artillery
    elseif (obj.type == "fuel") then
        obj.fillLimit = ItemDB.fillLimit.fuel
    elseif (obj.type == "ammo") then
        obj.fillLimit = ItemDB.fillLimit.ammo
    end
    if (obj.type == "ammo") then
        local dmgEffects = ItemDB.getDamageEffects(ammoType)
        local summary = ItemDB.effectsSummary(dmgEffects)
        obj.score = summary.weightedTotal
        -- obj.damageEffects = ItemDB.getDamageEffects(proto.get_ammo_type())
        -- obj.effectsSummary = ItemDB.effectsSummary(obj.damageEffects)
        -- obj.score = obj.effectsSummary.weightedTotal
        obj.magSize = proto.magazine_size
    elseif (obj.type == "fuel") then
        obj.score = proto.fuel_value
    end
    if (not obj.score) then
        obj.score = 1
    end
    -- if obj.score == 0 then
    -- obj.score = 1
    -- end
    obj.stackSize = proto.stack_size
    if obj.stackSize < obj.fillLimit then
        obj.fillLimit = obj.stackSize
    end
    -- if (string.find(obj.name, "ammo.loader.cartridge")) then
    -- obj.isCartridge = true
    -- cInform("isCartridge")
    -- end
    local isCart = string.find(obj.name, "ammo.loader.cartridge")
    if (gSets.useCartridges()) then
        if (not isCart) then
            -- cInform("isCartridge")
            return nil
        end
        obj.isCartridge = true
    elseif (isCart) then
        return nil
    end
    -- obj.insertSize = game.item_prototypes[name]
    -- obj.id = ItemDB.item.dbInsert(obj)
    -- if not cat["_exampleStack"] then cat["_exampleStack"] = {name=obj.name, count=1} end
    ItemDB.items()[name] = obj

    -- local exStacks = ItemDB.exampleStacks()
    -- if exStacks[obj.category] == nil then
    -- exStacks[obj.category] = {name = obj.name, count = 1}
    -- end

    return obj
end

function ItemDB.newAmmo(proto)
    if (not proto) or (ItemDB.items()[proto.name]) then
        return nil
    end
    local obj = {} ---@type Item
    obj.name = proto.name
    local ammoType = proto.get_ammo_type()
    if (not ammoType) then
        return
    end
    obj.category = ammoType.category
    obj.type = ItemDB.types.ammo
    if (obj.category == "artillery-shell") then
        obj.fillLimit = ItemDB.fillLimit.artillery
    else
        obj.fillLimit = ItemDB.fillLimit.ammo
    end
    local dmgEffects = ItemDB.getDamageEffects(proto)
    local summary = ItemDB.effectsSummary(dmgEffects)
    obj.score = summary.weightedTotal
    obj.magSize = proto.magazine_size
    if (not obj.score) then
        obj.score = 0
    end
    obj.stackSize = proto.stack_size
    if obj.stackSize < obj.fillLimit then
        obj.fillLimit = obj.stackSize
    end
    if (gSets.useCartridges()) then
        local isCart = string.find(obj.name, "ammo.loader.cartridge")
        if (not isCart) then
            return nil
        end
        obj.isCartridge = true
    end
    ItemDB.items()[obj.name] = obj
    return obj
end

function ItemDB.newFuel(proto)
    if (not proto) or (ItemDB.items()[proto.name]) then
        return nil
    end
    local obj = {} ---@type Item
    obj.name = proto.name
    obj.category = proto.fuel_category
    if (not obj.category) then
        return
    end
    obj.type = ItemDB.types.fuel
    obj.fillLimit = ItemDB.fillLimit.fuel
    obj.score = proto.fuel_value
    if (not obj.score) or (obj.score < 0) then
        obj.score = 0
    end
    obj.stackSize = proto.stack_size
    if obj.stackSize < obj.fillLimit then
        obj.fillLimit = obj.stackSize
    end
    if (gSets.useCartridges()) then
        local isCart = string.find(obj.name, "ammo.loader.cartridge")
        if (not isCart) then
            return nil
        end
        obj.isCartridge = true
    end
    ItemDB.items()[obj.name] = obj
    return obj
end

function ItemDB.getDamageEffects(ammo)
    local t = type(ammo)
    if (t == "string") then
        ammo = game.item_prototypes[ammo]
    end
    local ammoType = ammo.get_ammo_type()
    if (ammoType) and (ammoType.action) then
        return ItemDB.parseAction(ammoType.action)
    end
end

function ItemDB.parseAction(action)
    if not action then
        return
    end
    local res = {}
    for i, actionInfo in pairs(action) do
        local radius = actionInfo["radius"]
        -- if (actionInfo["radius"]) then
        --     serpLog(actionInfo.radius)
        -- end
        local delivery = actionInfo.action_delivery
        if (delivery) then
            for j, deliveryInfo in pairs(delivery) do
                -- serpLog(deliveryInfo)
                local ent = deliveryInfo.projectile or deliveryInfo.stream
                if (ent) then
                    -- serpLog(deliveryInfo)
                    local projProto = game.entity_prototypes[ent]
                    -- serpLog(projProto.name)
                    local ar = projProto.attack_result
                    local far = projProto.final_attack_result
                    if (far) then
                        res = Array.merge(res, ItemDB.parseAction(far))
                    end
                    if (ar) then
                        res = Array.merge(res, ItemDB.parseAction(ar))
                    end
                end
                local effects = deliveryInfo.target_effects
                if (effects) then
                    for i, effect in pairs(effects) do
                        if (effect["action"]) then
                            res = Array.merge(res, ItemDB.parseAction(effect["action"]))
                        elseif (effect["type"] == "damage") then
                            local dmg = {type = effect.damage.type, amount = effect.damage.amount}
                            if (radius) then
                                dmg.radius = radius
                            end
                            res[#res + 1] = dmg
                        -- log(serpent.block(effect["damage"]))
                        end
                    end
                end
            end
        end
    end
    -- serpLog(res)
    return res
end

function ItemDB.catItems(catName)
    -- local orderBy = orderBy or "rank"
    local catItems = {}
    for itemName, item in pairs(ItemDB.items()) do
        if (item.category == catName) then
            catItems[item.rank] = item
        end
    end
end

function ItemDB.category(name)
    local cats = ItemDB.cats()
    local cat = cats[name]
    if (not cat) then
        cat = {}
        cats[name] = cat
    end
    return cat
end
ItemDB.cat = ItemDB.category

function ItemDB.catInsert(cat, item)
    local items = ItemDB.cat(cat).items
    items[#items + 1] = item
end

function ItemDB.updateRanks(catName)
    local cats = ItemDB.cats()
    for itemName, item in pairs(ItemDB.items()) do
        if (not catName) or (item.category == catName) then
            local cat = cats[item.category]
            if not cat then
                cat = {}
                cats[item.category] = cat
            end
            if (not table.containsValue(cat, itemName)) then
                Array.insert(cat, itemName)
            end
        end
    end

    if (not catName) then
        global["ItemDB"]["categories"] = {}
    end
    for catName, cat in pairs(cats) do
        table.sort(cat, ItemDB.compare)
        local size = #cat
        for rank, itemName in pairs(cat) do
            local item = itemInfo(itemName)
            item.rank = rank
            item.catSize = size
        end
        global["ItemDB"]["categories"][catName] = cat
    end
    -- global["ItemDB"]["categories"] = cats
end

---Get stored info about an item.
---@param name string
---@return Item
function ItemDB.getItem(name)
    if not name then
        return nil
    end
    local info = ItemDB.items()[name]
    return info
end
ItemDB.get = ItemDB.getItem
itemInfo = ItemDB.getItem

function ItemDB.getItemByRank(cat, rank)
    if (not cat) or (not rank) then
        return
    end
    local items = global["ItemDB"]["items"]
    for name, item in pairs(items) do
        if (item.category == cat) and (item.rank == rank) then
            return item
        end
    end
    -- local name, item = next(items)
    -- while (name) do
    --     if (item.category == cat) and (item.rank == rank) then
    --         return item
    --     end
    --     name, item = next(items, name)
    -- end
end

function ItemDB.getItemScore(name)
    local item = ItemDB.get(name)
    if (item) and (item.score) then
        return item.score
    end

    -- local itemType = ItemDB.getType(name)
    local proto = game.item_prototypes[name]
    -- local types = ItemDB.types
    if (proto.fuel_category) then
        return proto.fuel_value
    elseif (proto.get_ammo_type()) then
        return ItemDB.getTotalDamage(name)
    end
    return nil
end

function ItemDB.getType(name)
    local itemObj = ItemDB.items()[name]
    if (itemObj) and (itemObj.type) then
        return itemObj.type
    end

    local proto = game.item_prototypes[name]
    if not proto then
        return nil
    end
    local ammoType = proto.get_ammo_type()
    if (ammoType) then
        return "ammo"
    end
    local fuelCat = proto.fuel_category
    if (fuelCat) then
        return "fuel"
    end
    return nil
end

-- function ItemDB.getDamageEffects(t, radius)
--     local de = {}
--     for k, v in pairs(t) do
--         if type(v) == "table" and v.radius then
--             cInform("found radius!")
--             radius = v.radius
--         end
--         if (k == "projectile") then
--             local proto = game.entity_prototypes[v]
--             if (proto) then
--                 local action = proto.attack_result
--                 local final_action = proto.final_attack_result
--                 if (action) then
--                     de = Array.merge(de, ItemDB.getDamageEffects(action, radius))
--                 end
--                 if (final_action) then
--                     de = Array.merge(de, ItemDB.getDamageEffects(final_action, radius))
--                 end
--             end
--         end
--         if (k == "damage") then
--             local copy = Map.deepcopy(v)
--             copy.radius = radius
--             Array.insert(de, copy)
--         elseif (type(v) == "table") then
--             de = Array.merge(de, ItemDB.getDamageEffects(v, radius))
--         end
--     end
--     return de
-- end
function ItemDB.effectsSummary(de)
    local res = {total = 0, weightedTotal = 0, types = {}}
    if (not de) then
        return res
    end
    -- serpLog(de)
    for _, effect in pairs(de) do
        res.total = res.total + effect.amount
        res.weightedTotal = res.weightedTotal + ItemDB.weightedDamage(effect)
        local typeCur = res.types[effect.type] or 0
        res.types[type] = typeCur + effect.amount
    end
    return res
end
function ItemDB.weightedDamage(effect)
    local weight = ItemDB.damageTypeWeights[effect.type] or 1
    local amt = effect.amount * weight
    if not effect.radius then
        return amt
    end
    return amt * (effect.radius * ItemDB.radiusWeight)
end
function ItemDB.getStackSize(name)
    if not name then
        return nil
    end
    local itemObj = ItemDB.get(name)
    if (itemObj) and (itemObj.stackSize) then
        return itemObj.stackSize
    end

    local proto = game.item_prototypes[name]
    if (proto == nil) then
        return nil
    end
    return proto.stack_size
end

---Compare 2 Items. Return true if item1 > item2.
---@param item1 Item
---@param item2 Item
---@return boolean
function ItemDB.compare(item1, item2)
    local item1 = itemInfo(item1)
    local item2 = itemInfo(item2)

    if (item1.rank) and (item2.rank) then
        if (item1.rank < item2.rank) then
            return true
        elseif (item1.rank > item2.rank) then
            return false
        end
        return false
    end
    if item1.score > item2.score then
        return true
    elseif item1.score < item2.score then
        return false
    elseif item1.name > item2.name then
        return true
    end
    return false
end

return ItemDB
