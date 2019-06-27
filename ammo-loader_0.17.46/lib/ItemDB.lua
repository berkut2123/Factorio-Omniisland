--[[--
Module for easy access of item categories, scores(damage or fuel value), and other item info.
Necessary because there is no easy api method for getting the total damage of an ammo.
@module ItemDB
]]
ItemDB = {}
ItemDB.itemDBName = "ItemDBItems"
ItemDB.catDBName = "ItemDBCats"
ItemDB.item = {}

ItemDB.types = {}
ItemDB.types.fuel = "fuel"
ItemDB.types.ammo = "ammo"
ItemDB.types.any = "any"

ItemDB.item.types = ItemDB.types
invTypes = ItemDB.types

-- exStacks = {}
-- exStacks.ironPlates = {name = "iron-plates", count = 1}
Init.registerFunc(
    function()
        -- DB.new(ItemDB.itemDBName)
        -- DB.new(ItemDB.catDBName)
        global["ItemDB"] = {}
        global["ItemDB"]["entries"] = {}
        global["ItemDB"]["categories"] = {}
        global["ItemDB"]["exampleStacks"] = {}

        for name, proto in pairs(game.item_prototypes) do
            ItemDB.item.new(name)
        end
        ItemDB.updateRanks()
    end
)

function ItemDB.master()
    return global["ItemDB"]
end
function ItemDB.items()
    return ItemDB.master()["entries"]
end
function ItemDB.cats()
    return ItemDB.master()["categories"]
end
function ItemDB.exampleStacks()
    return ItemDB.master()["exampleStacks"]
end
function ItemDB.getExampleStack(catName)
    return ItemDB.exampleStacks()[catName]
end
function ItemDB.makeExampleStack(itemName)
    return {name = itemName, count = 1}
end
ItemDB.fillLimit = {}
ItemDB.fillLimit.ammo = 5
ItemDB.fillLimit.artillery = 1
ItemDB.fillLimit.fuel = 5

function ItemDB.item.new(name)
    if not name then
        return nil
    end
    local proto = game.item_prototypes[name]
    if (not proto) then
        return nil
    end

    local obj = {}
    obj.name = name
    -- obj.type = proto.type
    -- obj.type = ItemDB.item.getType(name)
    -- if not obj.type then
    --     return nil
    -- end
    local cat, itemType = ItemDB.item.getCat(name)
    obj.category = cat
    obj.cat = obj.category
    obj.type = itemType
    if not obj.category then
        return nil
    end
    obj.fillLimit = ItemDB.fillLimit.ammo
    if (obj.category == "artillery-shell") then
        obj.fillLimit = ItemDB.fillLimit.artillery
    elseif (obj.type == "fuel") then
        obj.fillLimit = ItemDB.fillLimit.fuel
    end
    obj.score = ItemDB.item.getScore(name)
    if (not obj.score) then
        return nil
    end
    if obj.score == 0 then
        obj.score = 1
    end
    obj.stackSize = ItemDB.item.getStackSize(name)
    if obj.stackSize < obj.fillLimit then
        obj.fillLimit = obj.stackSize
    end
    obj.magSize = proto.magazine_size or 0
    -- obj.insertSize = game.item_prototypes[name]
    -- obj.id = ItemDB.item.dbInsert(obj)
    -- if not cat["_exampleStack"] then cat["_exampleStack"] = {name=obj.name, count=1} end
    ItemDB.items()[name] = obj
    inform("ItemDB new item: " .. name)
    ItemDB.catInsert(obj.category, obj.name)

    local exStacks = ItemDB.exampleStacks()
    if exStacks[obj.category] == nil then
        exStacks[obj.category] = {name = obj.name, count = 1}
    end

    return obj
end

function ItemDB.category(name)
    local cats = ItemDB.cats()
    local cat = cats[name]
    if (not cat) then
        cat = {ranks = {}, items = {}}
        cats[name] = cat
    end
    return cat
end
ItemDB.cat = ItemDB.category

function ItemDB.catInsert(cat, item)
    local items = ItemDB.cat(cat).items
    items[#items + 1] = item
end

function ItemDB.updateRanks()
    local cats = ItemDB.cats()
    for catName, cat in pairs(cats) do
        -- local items = cat.items
        cat.items =
            Array.insertionSort(
            cat.items,
            function(item1, item2)
                local inf1 = itemInfo(item1)
                local inf2 = itemInfo(item2)
                local res = util.compare(inf1.score, inf2.score)
                if (res == 0) then
                    res = util.compare(inf1.magSize, inf2.magSize)
                    if (res == 0) then
                        res = util.compare(inf1.name, inf2.name)
                    end
                -- res = res * -1
                end
                return res
                -- if (inf1.score < inf2.score) then
                --     return -1
                -- elseif (inf1.score > inf2.score) then
                --     return 1
                -- else
                --     if (inf1.name < inf2.name) then
                --         return 1
                --     elseif (inf1.name > inf2.name) then
                --         return -1
                --     else
                --         return 0
                --     end
                -- end
            end
        )
        -- local ranks = cat.ranks
        for i, itemName in pairs(cat.items) do
            itemInfo(itemName).rank = i
        end
    end
end

-- function ItemDB.catInsert(catName, newItem)
--     local cats = ItemDB.cats()
--     local cat = cats[catName]
--     if not cat then
--         cat = {ranks = {}, count = 0, totalScore = 0}
--         cats[catName] = cat
--     end
--     local ranks = cat.ranks
--     local rank = #cat + 1
--     for i = 1, rank - 1 do
--         local cur = ItemDB.items.get(ranks[i])
--         if (cur.score < newItem.score) then
--             rank = i
--             break
--         end
--     end
--     Array.insert(ranks, newItem.name, rank)
--     cat.count = cat.count + 1
--     cat.totalScore = cat.totalScore + newItem.score
--     ItemDB.updateRanks(catName)
-- end
-- function ItemDB.updateRanks(catName)
--     local cats = ItemDB.cats()
--     local cat = cats[catName]
--     for i = 1, #cat do
--         local item = ItemDB.item.get(cat[i])
--         item.rank = i
--     end
-- end
function ItemDB.item.get(name)
    if not name then
        return nil
    end
    local info = ItemDB.items()[name]
    return info
end
itemInfo = ItemDB.item.get
itemScore = function(name)
    local item = ItemDB.item.get(name)
    if not item then
        return 0
    end
    return item.score
end
function ItemDB.item.dbInsert(obj)
    return DB.insert(ItemDB.item.dbName, obj)
end
-- function ItemDB.item.getType(name)
-- local item = ItemDB.item.get(name)
-- local cat
-- if (not item) then
--     cat = ItemDB.item.getCat(name)
--     if not cat then
--         return nil
--     end
-- else
--     cat = item.category
-- end
-- if (cat == "fuel") then
--     return cat
-- end
-- return "ammo"
-- end
-- ItemDB.item.type = ItemDB.item.getType
function ItemDB.item.getCat(name)
    local itemObj = ItemDB.items()[name]
    if (itemObj ~= nil) and (itemObj.category ~= nil) then
        return itemObj.category
    end

    local proto = game.item_prototypes[name]
    if not proto then
        return nil
    end
    local ammoType = proto.get_ammo_type()
    if (ammoType) then
        return ammoType.category, "ammo"
    end
    local fuelCat = proto.fuel_category
    if (fuelCat) then
        return "fuel-" .. fuelCat, "fuel"
    end
    return nil

    -- local type = ItemDB.item.getType(name)
    -- if (type == ItemDB.types.fuel) then
    --     return "fuel"
    -- elseif (type == ItemDB.types.ammo) then
    --     local ammoType = game.item_prototypes[name].get_ammo_type()
    --     return ammoType.category
    -- end
    -- return nil
end
function ItemDB.item.getScore(name)
    if not name then
        return nil
    end
    -- local itemObj = ItemDB.items()[name]
    -- if (itemObj ~= nil) and (itemObj.score ~= nil) then
    -- return itemObj.score
    -- end
    local cat, itemType = ItemDB.item.getCat(name)
    local proto = game.item_prototypes[name]
    -- local type = proto.type
    local types = ItemDB.types
    if (itemType == types.fuel) then
        return proto.fuel_value
    elseif (itemType == types.ammo) then
        return ItemDB.item.ammo.getTotalDamage(name)
    end
    return nil
end
ItemDB.item.ammo = {}
function ItemDB.item.ammo.getDamageEffects(ammoName)
    local proto = game.item_prototypes[ammoName]
    if proto == nil then
        return nil
    end
    local ammoType = proto.get_ammo_type()
    if ammoType == nil then
        return nil
    end

    local searchList = Q.new()
    local de = {}
    Q.pushright(searchList, ammoType)
    while Q.getsize(searchList) > 0 do
        for k, v in pairs(Q.popleft(searchList)) do
            if (k == "target_effects") then
                for k2, effect in pairs(v) do
                    if (effect["type"] == "damage") then
                        local newVal = effect["damage"]
                        de[#de + 1] = newVal
                    else
                        Q.pushright(searchList, effect)
                    end
                end
            end
            if (k == "projectile") then
                local projProto = game.entity_prototypes[v]
                if (projProto ~= nil) then
                    local ar = projProto.attack_result
                    local far = projProto.final_attack_result
                    if ar ~= nil then
                        Q.pushright(searchList, projProto.attack_result)
                    end
                    if far ~= nil then
                        Q.pushright(searchList, projProto.final_attack_result)
                    end
                end
            end
            if (type(v) == "table") then
                Q.pushright(searchList, v)
            end
        end
    end
    return de
end
function ItemDB.item.ammo.getTotalDamage(name)
    local total = 0
    for ind, effect in pairs(ItemDB.item.ammo.getDamageEffects(name)) do
        total = total + effect.amount
    end
    return total
end
function ItemDB.item.getStackSize(name)
    if not name then
        return nil
    end
    local itemObj = ItemDB.items()[name]
    if (itemObj ~= nil) and (itemObj.stackSize ~= nil) then
        return itemObj.stackSize
    end

    local proto = game.item_prototypes[name]
    if (proto == nil) then
        return nil
    end
    return proto.stack_size
end

-- ItemDB.category = {}
-- ItemDB.cat = ItemDB.category
-- function ItemDB.category.get(name)
--     local cats = ItemDB.cats()
--     local cat = cats[name]
--     if (cat ~= nil) then
--         return cat
--     end
--     cats[name] = {}
--     return cats[name]
-- end
-- function ItemDB.category.contains(catName, itemName)
--     local cat = ItemDB.category.get(catName)
--     if (cat[itemName] ~= nil) then
--         return true
--     end
--     return false
-- end
-- function ItemDB.category.getPriorityQueue(name)
--     local catObj = ItemDB.category.get(name)
--     local pq = PQ.new()
--     for itemName, info in pairs(catObj) do
--         pq.push(info, info.score)
--     end
--     return pq
-- end
-- function ItemDB.category.addItem(name)
--     local catName = ItemDB.item.getCat(name)
--     local cat = ItemDB.category.get(catName)
--     cat[name] =
-- end
-- Item = {}
-- function Item.isFuel(name)
-- 	local itemProto = game.item_prototypes[name]
-- 	if (itemProto.fuel_value > 0) then return true end
-- 	return false
-- end
-- function Item.isAmmo(name)
-- 	local itemProto = game.item_prototypes[name]
-- 	local ammoType = itemProto.get_ammo_type()
-- 	if (ammoType ~= nil) then return true end
-- 	return false
-- end
-- function Item.getType(name)
-- 	if (Item.isFuel(name)) then return invTypes.fuel end
-- 	if (Item.isAmmo(name)) then return invTypes.ammo end
-- 	return nil
-- end
-- function Item.getCat(name)
-- 	if (Item.isFuel(name)) then return "fuel" end
-- 	if (Item.isAmmo(name)) then return AmmoDB.getAmmoCat(name) end
-- 	return nil
-- end
-- function Item.getStackSize(name)
-- 	local itemProto = game.item_prototypes[name]
-- 	return itemProto.stack_size
-- end
return ItemDB
