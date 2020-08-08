alGui.handlers = {}
local handlers = alGui.handlers
alGui.handlers.basic = {}
local basicHands = alGui.handlers.basic
-- alGui.handlers.informatron = {}
-- local infoHands = alGui.handlers.informatron
-- alGui.handlers.infoMain = {}
-- local infoMainHands = alGui.handlers.infoMain
alGui.handlers.infoRanks = {}
local infoRankHands = alGui.handlers.infoRanks
alGui.handlers.chestFilters = {}
local chestFilterHands = alGui.handlers.chestFilters

-- on_gui_switch_state_changed

-- alGui.handlers.on_gui_click_funcs = {}
-- function alGui.handlers._on_gui_click(e)
--     for ind, func in pairs(alGui.handlers.on_gui_click_funcs) do
--         if (not isValid(e.element)) or (not util.eventPlayer(e)) then
--             break
--         end
--         func(e)
--     end
-- end
-- onEvents(alGui.handlers._on_gui_click, {"on_gui_click"})

-- alGui.handlers.on_gui_opened_funcs = {}
-- function alGui.handlers._on_gui_opened(e)
--     for ind, func in pairs(alGui.handlers.on_gui_opened_funcs) do
--         func(e)
--     end
-- end
-- onEvents(alGui.handlers._on_gui_opened, {"on_gui_opened"})

-- alGui.handlers.on_gui_elem_changed_funcs = {}
-- function alGui.handlers._on_gui_elem_changed(e)
--     for ind, func in pairs(alGui.handlers.on_gui_elem_changed_funcs) do
--         if (not isValid(e.element)) or (not util.eventPlayer(e)) then
--             break
--         end
--         func(e)
--     end
-- end
-- onEvents(alGui.handlers._on_gui_elem_changed, {"on_gui_elem_changed"})

-- alGui.handlers.on_gui_switch_state_changed_funcs = {}
-- function alGui.handlers._on_gui_switch_state_changed(e)
--     for ind, func in pairs(alGui.handlers.on_gui_switch_state_changed_funcs) do
--         if (not isValid(e.element)) or (not util.eventPlayer(e)) then
--             break
--         end
--         func(e)
--     end
-- end
-- onEvents(alGui.handlers._on_gui_switch_state_changed, {"on_gui_switch_state_changed"})

---@param str string
function alGui.handlers.fromString(str)
    local start = alGui.handlers
    local cur = start
    local c = 0
    local iter = str:gmatch("%.?(%w+)%.?")
    for ref in iter do
        if (c == 0) then
            if (ref == "infoMain") then
                cur = infoMainHands
            elseif (ref == "infoRanks") then
                cur = infoRankHands
            elseif (ref == "chestFilter") then
                cur = chestFilterHands
            elseif (ref == "basic") then
                cur = basicHands
            end
        else
            if (not cur[ref]) then
                return
            end
            cur = cur[ref]
        end
        c = c + 1
    end
    return cur
end

basicHands.closeButton = {
    on_gui_click = function(e)
        if (not isValid(e.element)) or (not e.element.name:match("(algui%_close%_button)")) then
            return
        end
        e.element.parent.parent.destroy()
        -- local obj = alGui.playerObjs(util.eventPlayer(e))
        -- if (obj) and (obj.chestFilter) then
        --     obj.chestFilter.elems.window.destroy()
        --     obj.chestFilter = nil
        -- end
        -- local rootName = e.element.parent.parent.name
        -- e.element.parent.parent.destroy()
        -- local pObjs = alGui.playerObjs(util.eventPlayer(e))
        -- if (pObjs) and (pObjs[rootName]) then
        --     pObjs[rootName] = nil
        -- end
    end
}
onEvents(basicHands.closeButton.on_gui_click, {"on_gui_click"})
-- table.insert(alGui.handlers.on_gui_click_funcs, basicHands.closeButton.on_gui_click)

alGui.handlers.toggleButton = {
    on_gui_click = function(e)
        if (e.element.type ~= "button") or (not e.element.name:match("(%_%_algui%_toggle%_button)")) then
            return
        end
        local target = alGui.toggleButton.funcs.getFrame(e.element)
        if (not target) then
            return
        end
        alGui.toggleButton.funcs.toggle(e.element)
    end
}
onEvents(alGui.handlers.toggleButton.on_gui_click, {"on_gui_click"})
-- table.insert(alGui.handlers.on_gui_click_funcs, alGui.handlers.toggleButton.on_gui_click)

alGui.handlers.infoMain = {
    on_gui_opened = function(e)
        cInform("gui opened/closed")
    end
}
-- onEvents(alGui.handlers.infoMain.on_gui_opened, {"on_gui_opened", "on_gui_closed"})

infoRankHands.itemRankMove = {
    on_gui_click = function(e)
        -- local parent = e.element.parent
        ---@type string
        local elemName = e.element.name
        local searchPat = "(algui%_button%_%_rank%_)"
        if (not elemName) or (not elemName:match(searchPat)) then
            return
        end
        searchPat = "algui%_button%_%_rank%_(%w+)"
        local direction = elemName:match(searchPat)
        local itemName = elemName:match("([%w%-%_%d]+)%_%_algui%_button")
        local itemObj = itemInfo(itemName)
        if (not itemObj) then
            cInform("itemRankAbort: ", itemName)
            return
        end
        local catRanks = ItemDB.category(itemObj.category)
        if (direction == "up" and itemObj.rank > 1) then
            alGui.infoRanks.funcs.swapItemRank(itemObj.name, itemObj.rank - 1)
        elseif (direction == "down" and itemObj.rank < #catRanks) then
            alGui.infoRanks.funcs.swapItemRank(itemObj.name, itemObj.rank + 1)
        end
        alGui.infoRanks.funcs.refreshRanks(e.element)
    end
}
onEvents(alGui.handlers.infoRanks.itemRankMove.on_gui_click, {"on_gui_click"})
-- table.insert(alGui.handlers.on_gui_click_funcs, alGui.handlers.infoRanks.itemRankMove.on_gui_click)

infoRankHands.resetItemRanksButton = {
    on_gui_click = function(e)
        if (not e.element.name:match("(algui%_button%_%_category%_reset)")) then
            return
        end
        cInform("reset item ranks")
        local catContent = e.element.parent
        local catName = string.gsub(catContent.name, "%_content", "")
        global.ItemDB.categories[catName] = {}
        ItemDB.updateRanks(catName)
        alGui.infoRanks.funcs.refreshRanks(catContent[catName])
    end
}
-- table.insert(alGui.handlers.on_gui_click_funcs, infoRankHands.resetItemRanksButton.on_gui_click)

function alGui.handlers.chestFilters.on_gui_opened(event)
    local player = util.eventPlayer(event)
    if (not isValid(player)) then
        return
    end
    local obj = player.gui.screen["algui_frame__chest_filters"]
    if (not isValid(obj)) then
        return
    end
    obj.destroy()
    -- alGui.playerObjs(player).chestFilter = nil
end
onEvents(alGui.handlers.chestFilters.on_gui_opened, {"on_gui_opened"})
-- table.insert(alGui.handlers.on_gui_opened_funcs, alGui.handlers.chestFilters.on_gui_opened)

chestFilterHands.filterElem = {
    on_gui_elem_changed = function(e)
        if
            (not isValid(e.element.parent)) or (not e.element.parent.name) or
                (not e.element.parent.name:match("(algui%_container%_%_chest%_filter%_list)"))
         then
            return
        end
        local player = util.eventPlayer(e)
        -- local obj = alGui.playerObjs(player).chestFilter
        -- if (not obj) then
        -- return
        -- end
        local chest = alGui.chestFilter.funcs.curChest(player)
        if (not chest) then
            return
        end
        -- serpLog(e.element.elem_value)
        -- local filterList = alGui.chestFilter.funcs.getSelectedFilters(obj.elems.filterListContainer)
        -- serpLog(filterList)
        alGui.chestFilter.funcs.saveAll(player)
        -- serpLog(chest._entFilter)
        local filterList = chest._entFilter or {}
        local filterListContainer =
            alGui.templates.getChildWithName(
            alGui.chestFilter.funcs.getWindow(player),
            "(algui%_container%_%_chest%_filter%_list)"
        )
        filterListContainer.clear()
        for entName, itemName in pairs(filterList) do
            alGui.build(
                filterListContainer,
                {template = "chestFilter.templates.filterList.filterElem", item = itemName}
            )
        end
        alGui.build(filterListContainer, {template = "chestFilter.templates.filterList.filterElem"})
        -- local filterElems = alGui.chestFilter.funcs.chestFilterElems(chest)

        -- local filterElems = {}
        -- for i, elem in pairs(filterElems) do
        --     alGui.build(obj.elems.filterListContainer, elem)
        -- end
        --         {template = "chestFilter.filterList.filterElem", item = itemName}
        --     )
        -- table.insert(filterElems, {template="chestFilter.filterList.filterElem", item=itemName})
        -- end
        -- obj.elems.filterListContainer.destroy()
        -- obj.elems.filterListContainer =
        --     alGui.build(obj.elems.content, alGui.chestFilter.templates.filterList.container(chest)).filterListContainer
    end
}
onEvents(chestFilterHands.filterElem.on_gui_elem_changed, {"on_gui_elem_changed"})
-- table.insert(alGui.handlers.on_gui_elem_changed_funcs, chestFilterHands.filterElem.on_gui_elem_changed)

chestFilterHands.filterModeSwitch = {
    on_gui_switch_state_changed = function(e)
        if (not e.element.name:match("(algui%_switch%_%_filter%_mode)")) then
            return
        end
        -- alGui.chestFilter.funcs.saveFilterMode(util.eventPlayer(e), e.element)
        alGui.chestFilter.funcs.saveAll(util.eventPlayer(e))
    end
}
onEvents(chestFilterHands.filterModeSwitch.on_gui_switch_state_changed, {"on_gui_switch_state_changed"})
-- table.insert(
--     alGui.handlers.on_gui_switch_state_changed_funcs,
--     chestFilterHands.filterModeSwitch.on_gui_switch_state_changed
-- )

-- onChestFilterKey = {
--     id = protoNames.keys.filterWindow,
--     handler = function(e)
--         local player = util.eventPlayer(e)
--         if (not player) then
--             return
--         end
--         local obj = alGui.windows.chestFilters(player)
--         if (obj) then
--             obj.elems.window.destroy()
--             global.alGui.windowObjects[player.index]["chestFilters"] = nil
--         else
--             local chest = TC.getChestFromEnt(player.selected)
--             if (not chest) then
--                 return
--             end
--             local obj = alGui.windows.chestFilters(player, chest)
--         end
--     end
-- }
-- }

-- alGui.postBuildFuncs = {}
-- local postBuildFuncs = alGui.postBuildFuncs
-- postBuildFuncs.
