---@module alGui
alGui = {}
alGui.templates = {}
alGui.handlers = {}
alGui.informatron = {}

function alGui._init()
    global.alGui = {}
    global.alGui.infoFrames = {}
    global.alGui.renderQ = Queue.new()
    global.alGui.chestsNeedRender = {}
    global.alGui.rendersNeedDestroy = {}
    global.alGui.windows = {}
    global.alGui.selectedEnts = {}
    global.alGui.chestFilters = {}
    global.alGui.chestFilters.playersCurOpenChest = {}
    global.alGui.chestFilterWindows = {}
    global.alGui.windowObjects = {}
    global.alGui.eventListeners = {}
    global.alGui.textToggleButtons = {}
    global.alGui.elements = {}
    alGui.destroyAllModWindows()
end
Init.registerInitFunc(alGui._init)

function alGui._onLoad()
    setmetatable(global.alGui.renderQ, Queue.objMT)
    -- for rank, q in pairs(obj.provItems) do
    --     setmetatable(q, idQ.objMT)
    -- end
end
Init.registerOnLoadFunc(alGui._onLoad)

function alGui.windowObjects()
    return global.alGui.windowObjects
end
function alGui.windowObject(name)
    return global.alGui.windowObjects[name]
end

alGui.names = {}
alGui.names.initDialogue = "amlo_init_dialogue"
alGui.names.initFlow = "amlo_init_flow1"
alGui.names.initBoxArtillery = "amlo_init_artillery"
alGui.names.initBoxBurners = "amlo_init_burners"
alGui.names.initBoxLocomotives = "amlo_init_locos"

alGui.extraOpts = {
    handlers = 1,
    children = 1,
    save_as = 1,
    style_mods = 1,
    template = 1,
    toggle_target = 1,
    post_build_function = 1
}

function alGui.informatron.menu(player_index)
    return {
        ranks = 1
    }
end

function alGui.informatron.pageContent(page_name, player_index, element)
    cInform("page content called")
    -- local mainPage = element["algui_info_main_page"]
    -- if (isValid(mainPage)) then
    --     cInform("destroy main page")
    --     mainPage.destroy()
    -- end
    -- local page = alGui.templates.getChildWithName(element, "(algui%_info%_ranks%_page)")
    -- if (isValid(page)) then
    --     cInform("destroy ranks page")
    --     page.destroy()
    -- end
    -- main page
    -- local temps = alGui.templates.informatron
    -- local winObjs = alGui.windowObjects()
    if page_name == "ammo-loader" then
        -- local mainPage = element["algui_info_main_page"]
        -- if (isValid(mainPage)) then
        --     cInform("destroy main page")
        --     mainPage.destroy()
        -- end
        alGui.build(element, alGui.infoMain.page())
    end
    if page_name == "ranks" then
        -- local page = alGui.templates.getChildWithName(element, "(algui%_info%_ranks%_page)")
        -- if (isValid(page)) then
        --     cInform("destroy ranks page")
        --     page.destroy()
        -- end
        -- element.add({type = "label", caption = "hello"})
        local infoRankElem = alGui.build(element, alGui.infoRanks.templates.page())
    -- alGui.infoRanks.funcs.refreshRanks(infoRankElem)
    -- serpLog(fin)
    end

    -- element.add {type = "button", name = "image_1", style = "mymod_penguin_image_1"}
    --[[
      To make an image you need to require the Informatron mod (so it loads first) then have some code like this in data.lua
      informatron_make_image("mymod_penguin_image_1", "__mymod__/graphics/informatron/pengiun.png", 200, 200)
        "mymod_penguin_image_1" must be unique per image.
        "__mymod__/graphics/informatron/page_1_image.png" is the path to your image.
        200, 200 is the width, height of the image
      ]]
    --
    -- end
end

function alGui.build(parent, t)
    local elems = {}
    local extraOpts = alGui.extraOpts
    local templates = alGui.templates
    if (not t) or (table_size(t) <= 0) or (not isValid(parent)) then
        return elems
    end
    if (t.template) then
        t = alGui.templates.applyTemplate(t)
    end
    local opts = {}
    local optsOther = {}
    if (not t) then
        return
    end
    for key, val in pairs(t) do
        if (not extraOpts[key]) then
            opts[key] = val
        else
            optsOther[key] = val
        end
    end
    for key, val in pairs(optsOther) do
        local valType = type(val)
        if (valType == "function") then
            optsOther[key] = val()
        end
        if (valType == "table") and (val.func) then
            if (val.args) then
                -- optsOther[key] = val.func()
                optsOther[key] = val.func(table.unpack(val.args))
            else
                optsOther[key] = val.func()
            end
        end
    end
    -- serpLog("opts: ", opts)
    local elem = parent.add(opts)
    -- serpLog("optsOther: ", optsOther)
    if (optsOther.children) then
        -- local tabList = {}
        -- if (elem.type == "tabbed-pane") then
        --     for i, childTemplate in pairs(optsOther.children) do
        --         if (childTemplate.type == "tab") then
        --             local catName = string.gsub(childTemplate.save_as, "\\_tab", "")
        --             table.insert(
        --                 tabList,
        --                 {tab = childTemplate.save_as, content = optsOther.children[catName .. "_content"]}
        --             )
        --         end
        --     end
        -- end
        for i, child in pairs(optsOther.children) do
            -- serpLog("child: ", child)
            -- if (type(child) ~= "table") then
            -- break
            -- end
            if (child.template) then
                -- serpLog("child before: ", child)
                child = alGui.templates.applyTemplate(child)
            -- serpLog("child after: ", child)
            end
            local childElems = alGui.build(elem, child)
            if (child.type == "tabbed-pane") then
                -- serpLog(childElems)
                for childName, childElem in pairs(childElems) do
                    if (childElem.type == "tab") then
                        local tabs = childElem.parent.tabs
                        local skip = false
                        for tInd, tabInfo in pairs(tabs) do
                            if (tabInfo.tab == childElem) then
                                skip = true
                                break
                            end
                        end
                        if (not skip) then
                            local catName = string.gsub(childName, "%_tab", "")
                            local contentElem = childElems[catName .. "_content"]
                            -- serpLog(catName, ": ", childElems)
                            -- serpLog(childElems)
                            -- if (catName) and (contentElem) then
                            catName = string.capitalize(catName)
                            catName = string.gsub(catName, "%-", " ")
                            childElem.caption = string.capitalize(catName)
                            contentElem.caption = string.capitalize(catName)
                            -- table.insert(tabList, {tab=childTemplate.save_as, content=optsOther.children[catName.."_content"]})
                            childElem.parent.add_tab(childElem, contentElem)
                        -- end
                        end
                    end
                end
            end
            elems = table.join(elems, childElems)
            -- if (childTemplate.type=="tab") then
            --     local catName = string.gsub(childTemplate.save_as, "\\_tab", "")
            --     table.insert(tabList, {tab=childTemplate.save_as, content=optsOther.children[catName.."_content"]})
            -- end
        end
    -- if (elem.type == "tabbed-pane") then
    --     for i, tabInfo in pairs(tabList) do
    --         elem.add_tab(elems[tabInfo.tab], elems[tabInfo.content])
    --     end
    -- end
    end
    if (optsOther.toggle_target) then
        local targetElems = alGui.build(parent, optsOther.toggle_target)
        if (isValid(targetElems.toggleTarget)) then
        -- alGui.toggleButton.register(elem, targetElems.toggleTarget)
        -- if (not optsOther.handlers) then
        --     optsOther.handlers = "toggleButton"
        -- end
        end
    end
    if (optsOther.save_as) then
        elems[optsOther.save_as] = elem
    -- serpLog(elems)
    end
    if (optsOther.style_mods) and (elem.style) then
        local style = elem.style
        for key, val in pairs(optsOther.style_mods) do
            style[key] = val
        end
    end
    -- if (optsOther.handlers) then
    --     serpLog("optsOther.handlers")
    --     serpLog(optsOther.handlers)
    --     local handlers = alGui.handlers.fromString(optsOther.handlers)
    --     for eventName, func in pairs(handlers) do
    --         cInform("adding callback")
    --         alGui.addCallback(elem, eventName, optsOther.handlers)
    --     end
    -- end
    return elems
end

function alGui.callbacks()
    -- if (not info) then
    -- info = {}
    -- global.alGui.eventListeners[elemID] = info
    -- end
    return global.alGui.eventListeners
end

function alGui.addCallback(elem, event, handlerName)
    local callbacks = alGui.callbacks()
    table.insert(callbacks, {element = elem, event = event, handler = handlerName})
end

function alGui.doCallbacks(e)
    local callbacks = global.alGui.eventListeners
    local elem = e.element
    local eventName = e.name
    if (not isValid(elem)) then
        return
    end
    local rmList = {}
    for i, info in pairs(callbacks) do
        if (isValid(info.element)) then
            cInform("callback elem is valid")
            -- serpLog(info)
            -- serpLog(e.name)
            if (info.element == elem) and (e.name == defines.events[info.event]) then
                -- serpLog(alGui.handlers[info.handler])
                local hand = alGui.handlers.fromString(info.handler)
                return hand[info.event](e)
            else
                cInform("not same event or elem")
            end
        else
            table.insert(rmList, i)
        end
    end
    for i, ind in pairs(rmList) do
        table.remove(callbacks, ind)
    end
end
-- onEvents(
--     alGui.doCallbacks,
--     {
--         -- "on_gui_click",
--         "on_gui_closed",
--         "on_gui_elem_changed",
--         "on_gui_location_changed",
--         "on_gui_opened",
--         "on_gui_switch_state_changed"
--     }
-- )

function alGui.playerObjs(player)
    local objs = global.alGui.windowObjects[player.index]
    if (not objs) then
        objs = {}
        global.alGui.windowObjects[player.index] = objs
    end
    return objs
end

alGui.windows = {}

-- alGui.windows.chestFilter = function(player, chest)
--     if (not isValid(player)) then
--         return
--     end
--     local playerObjs = alGui.playerObjs(player)
--     if (playerObjs["chestFilter"]) then
--         return playerObjs["chestFilter"]
--     elseif (not chest) then
--         return
--     end
--     local obj = {}
--     -- local outer = alGui.build(player.gui.screen, alGui.templates.outerFrame).root
--     -- outer.auto_center = true
--     local win = alGui.chestFilter.templates.create(chest)
--     local elems = alGui.build(player.gui.screen, win)
--     elems.dragBar.drag_target = elems.window
--     elems.titleLabel.drag_target = elems.window
--     elems.window.location = {x = 500, y = 300}
--     -- elems.window.force_auto_center()
--     -- local elem = player.gui.screen.add({type = "frame", caption = "Hello"})
--     -- local elems = {window = elem}
--     obj.chestID = chest.id
--     obj.playerInd = player.index
--     obj.elems = elems
--     obj.name = "chestFilter"
--     playerObjs["chestFilter"] = obj
--     return obj
-- end

function alGui.createInitialDialogue(player)
    local window = player.gui.screen.add {type = "frame", name = alGui.names.initDialogue, direction = "vertical"}
    window.style.bottom_padding = 4
    -- local titlebar =
    --     titlebar.create(
    --     window,
    --     "amlo_enable_titlebar",
    --     {label = {"gui-initial-dialog.titlebar-label-caption"}, draggable = true}
    -- )
    local intro = window.add {type = "label", name = "amlo_init_header", caption = "Ammo Loader Options"}
    local intro =
        window.add {
        type = "label",
        name = "amlo_init_intro",
        caption = "Turn on the features you would like Ammo Loader to use."
    }
    local flow = window.add {type = "flow", name = alGui.names.initFlow, direction = "horizontal"}
    flow.add {
        type = "checkbox",
        name = alGui.names.initBoxArtillery,
        -- style = "stretchable_button",
        caption = "Artillery",
        tooltip = {"gui-initial-dialog.yes-off-button-tooltip"},
        state = false
    }
    flow.add {
        type = "checkbox",
        name = alGui.names.initBoxBurners,
        -- style = "stretchable_button",
        caption = "Burner Structures",
        tooltip = {"gui-initial-dialog.yes-off-button-tooltip"},
        state = false
    }
    flow.add {
        type = "checkbox",
        name = alGui.names.initBoxLocomotives,
        -- style = "stretchable_button",
        caption = "Trains",
        tooltip = {"gui-initial-dialog.yes-off-button-tooltip"},
        state = false
    }
    window.force_auto_center()
    return window
end

function alGui.toggleWindow(window)
    if (window.visible) then
        window.visible = false
    else
        window.visible = true
    end
end

function alGui.onFilterWindowKey(event)
    local player = util.eventPlayer(event)
    if (isValid(player)) then
        -- local obj = alGui.playerObjs(player).chestFilter
        -- if (obj) and (obj.elems) and (isValid(obj.elems.window)) then
        if (player.gui.screen["algui_frame__chest_filters"]) then
            player.gui.screen["algui_frame__chest_filters"].destroy()
            return
        end
        -- obj.elems.window.destroy()
        -- alGui.playerObjs(player).chestFilter = nil
        -- cInform("destroying window and unsetting playerObj[chestFilter]")
        -- return
        -- end
        local chest = TC.getChestFromEnt(player.selected)
        if (not chest) then
            cInform("no selected ent")
            return
        end
        global.alGui.chestFilters.playersCurOpenChest[player.index] = chest.id
        -- obj = alGui.windows.chestFilter(player, chest)
        obj = alGui.chestFilter.funcs.create(player, chest)
        -- alGui.playerObjs(player).chestFilter = {chestID = chest.id, elems = obj}
        cInform("created window")
    -- serpLog(obj)
    end
end
script.on_event(protoNames.keys.filterWindow, alGui.onFilterWindowKey)

--- @return Queue
function alGui.renderQ()
    return global.alGui.renderQ
end

function alGui.chestsNeedRender()
    return global.alGui.chestsNeedRender
end

function alGui.rendersNeedDestroy()
    return global.alGui.rendersNeedDestroy
end

function alGui.renderTick()
    alGui.tickRenderDestroy()
    alGui.tickRenderChests()
end

function alGui.tickRenderChests()
    local chests = global.alGui.chestsNeedRender
    for chestID, _ in pairs(chests) do
        local chest = TC.getObj(chestID)
        if (not chest) then
            chests[chestID] = nil
        else
            for playerID, info in pairs(chest._renderInfo) do
                chest:highlightConsumers(game.get_player(playerID))
            end
            if (table_size(chest._renderInfo) <= 0) then
                chests[chestID] = nil
            end
        end
    end
end

function alGui.tickRenderDestroy()
    local renders = alGui.rendersNeedDestroy()
    local c = 0
    for id, _ in pairs(renders) do
        if (c >= 500) then
            break
        end
        rendering.destroy(id)
        renders[id] = nil
        c = c + 1
    end
end

function alGui.onPlayerSelectionChangedRender(e)
    if not Handlers.enabled() then
        return
    end
    local player = game.players[e.player_index]
    if (not player) or (not gSets.drawRange(player)) or (gSets.drawToggle(player)) then
        return
    end
    util.clearPlayerRenders(player)
    local selected = player.selected
    if (not selected) or (not selected.valid) or (selected.force.name ~= player.force.name) then
        local chestsNeedRender = alGui.chestsNeedRender()
        for chestID, _ in pairs(chestsNeedRender) do
            local chest = TC.getObj(chestID)
            if (not chest) then
                chestsNeedRender[chestID] = nil
            else
                chest._renderInfo[player.index] = nil
            end
        end
        return
    end
    if (TC.isChestName(selected.name)) then
        -- elseif (EntDB.contains(selected.name)) then
        local chest = TC.getChestFromEnt(selected)
        if (chest) then
            chest:drawRange(player)
            chest:highlightConsumers(player)
        end
    elseif (SL.entIsTrackable(selected)) then
        -- local slots = SL.getSlotsFromEntQ(selected)
        for slot in SL.slotIter() do
            if (slot.ent == selected) then
                local prov = slot:provider()
                local slotColor = util.colors.red
                if (prov) then
                    slotColor = util.colors.blue
                    slot:drawLineToProvider(player)
                end
                slot:highlight(player, slotColor)
            end
        end
    end
end
onEvents(alGui.onPlayerSelectionChangedRender, {"on_selected_entity_changed"})

-- function alGui.onPlayerCursorChangedDrawChest(e)
--     local player = util.eventPlayer(e)
--     if (not isValid(player)) then
--         return
--     end
--     local ghost = player.cursor_ghost
--     if (ghost) then

--     end
-- end
-- onEvents(alGui.onPlayerCursorChangedDrawChest, {"on_player_cursor_stack_changed"})

function alGui.destroyAllModWindows()
    for ind, player in pairs(game.players) do
        for sectionName, section in pairs(player.gui.children) do
            for winName, win in pairs(section.children) do
                local mod = win.get_mod()
                if (mod) and (mod == "ammo-loader") then
                    win.destroy()
                end
            end
        end
    end
end

-- alGui.toggleButton = {
--     register = function(button, element)
--         if (not isValid(button)) or (not isValid(element)) then
--             return
--         end
--         table.insert(global.alGui.textToggleButtons, {button = button, element = element})
--     end,
--     getElement = function(button)
--         if (not isValid(button)) then
--             return
--         end
--         local toggles = global.alGui.textToggleButtons
--         local rmList = {}
--         for i, info in pairs(toggles) do
--             local but = info.button
--             local elem = info.element
--             if (not isValid(but)) or (not isValid(elem)) then
--                 table.insert(rmList, i)
--             elseif (but == button) then
--                 return elem
--             end
--         end
--         for i, ind in pairs(rmList) do
--             table.remove(toggles[ind])
--         end
--     end,
--     toggle = function(button)
--         local elem = alGui.toggleButton.getElement(button)
--         if (not elem) then
--             return
--         end
--         cInform("toggleButton toggling...")
--         if (elem.visible) then
--             elem.visible = false
--         else
--             elem.visible = true
--         end
--     end,
--     onClick = function(e)
--         local target = alGui.toggleButton.getElement(e.element)
--         if (not target) then
--             return
--         end
--         alGui.toggleButton.toggle(e.element)
--     end
-- }
-- onEvents(alGui.toggleButton.onClick, {"on_gui_click"})

function alGui.label(text, opts)
    opts = opts or {}
    return table.join({type = "label", caption = text}, opts)
end

function alGui.button(text, opts)
    opts = opts or {}
    return table.join({type = "label", caption = text}, opts)
end

return alGui
