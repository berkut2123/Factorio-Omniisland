Rem = {}
Rem.interfaceName = "ammo-loader"

Rem.funcs = {}

function Rem.funcs.printItemDB(args)
    local printList = {}
    for name, item in pairs(ItemDB.items()) do
        local doPrint = true
        if (args) then
            doPrint = false
            if (args.item) and (args.item == name) then
                doPrint = true
            end
            if (args.category) and (args.category == item.category) then
                doPrint = true
            end
        end
        if (doPrint) then
            -- inform(concat(name, "-> category: ", item.category, ", score: ", item.score, ", rank: ", item.rank), true)
            Array.insert(printList, item)
        end
    end
    local sorted =
        Array.insertionSort(
        printList,
        function(item1, item2)
            local res = util.compare(item1.category, item2.category)
            if (res == 0) then
                res = util.compare(item1.rank, item2.rank)
                res = res * -1
            end
            return res
        end
    )
    for i = 1, #sorted do
        local item = sorted[i]
        -- inform(concat(item.name, "-> category: ", item.category, ", score: ", item.score, ", rank: ", item.rank), true)
        ctInform("category: ", item.category, ", rank: ", item.rank, ", score: ", item.score, ", name: ", item.name)
    end
    ctInform(#sorted, " items printed.")
end

Rem.funcs.on_entity_replaced = function(data)
    on_built({created_entity = data.new_entity})
end

remote.add_interface("ammo-loader", Rem.funcs)

return Rem
