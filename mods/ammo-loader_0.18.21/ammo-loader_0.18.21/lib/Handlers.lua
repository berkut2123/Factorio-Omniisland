Handlers = {}

---@class eventFuncInfo
---@field func fun(event:table)
---@field filters table

---@alias eventName string

Handlers.eventFuncs = {} ---@type table<eventName, eventFuncInfo[]>

function Handlers.enabled()
    if (gSets.enabled()) and (not version.needUpdate()) then
        return true
    end
    return false
end

---@param eventName string
function Handlers.eventIgnoresEnabled(eventName)
    if (not eventName) then
        return false
    end
    if (eventName:match("(ammo%-loader%-key)")) then
        return true
    end
    local allowed = {
        on_runtime_mod_setting_changed = true,
        on_load = true,
        on_configuration_changed = true,
        on_init = true,
        on_tick = true
    }
    if (allowed[eventName]) then
        return true
    end
    return false
end

function Handlers.callEventFuncs(e)
    local eName = util.eventName(e)
    -- serpLog("eName: ", eName)
    if (not Handlers.enabled()) and (not Handlers.eventIgnoresEnabled(eName)) then
        return
    end
    -- serpLog("event.name: ", e.name, " defines.events[e.name]: ", defines.events[e.name])
    if (not eName) or (not Handlers.eventFuncs[eName]) then
        return
    end
    local funcInfoList = Handlers.eventFuncs[eName]
    for i = 1, #funcInfoList do
        local funcInfo = funcInfoList[i]
        funcInfo.func(e)
    end
end

function Handlers.onEvents(func, eventNames, filters, ignoreEnabled)
    -- local hand = handler(func)
    for i = 1, #eventNames do
        local name = eventNames[i]
        -- serpLog("event name: ", name)
        local funcList = Handlers.eventFuncs[name]
        if (not funcList) then
            Handlers.eventFuncs[name] = {}
            funcList = Handlers.eventFuncs[name]
            local eventID = defines.events[name]
            if (eventID) then
                script.on_event(eventID, Handlers.callEventFuncs)
            else
                -- serpLog("unknown event name: ", name)
                script.on_event(name, Handlers.callEventFuncs)
            end
        end
        -- script.on_event(event, newFunc)
        ---@type eventFuncInfo
        local funcInfo = {func = func, filters = filters}
        table.insert(funcList, funcInfo)
    end
end
onEvents = Handlers.onEvents

function Handlers.onRemoved(event)
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
    if (TC.isChestName(ent.name)) then
        local chest = TC.getChestFromEnt(ent)
        if (chest) then
            chest:destroy()
        end
        return
    end
    if SL.entIsTrackable(ent) then
        local entPos = ent.position
        for slot in SL.slotIter() do
            if (slot.ent == ent) then
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
end
onEvents(
    Handlers.onRemoved,
    {"on_pre_player_mined_item", "on_robot_pre_mined", "on_entity_died", "script_raised_destroy"}
)

function Handlers.playerGunChanged(event)
    local player = util.eventPlayer(event)
    if (not player) or (not isValid(player.character)) then
        return
    end
    local char = player.character
    local force = Force.get(player.force.name)
    for slot in force:iterSlots() do
        if (slot:isCharacter()) and (slot.ent == char) then
            slot:charCheckGunMatchesCat()
        end
    end
end
onEvents(Handlers.playerGunChanged, {"on_player_gun_inventory_changed"})

function Handlers.settingChange(event)
    if (gSets.requireUpdate[event.setting]) then
        version.update()
    elseif (event.setting:find("ammo_loader")) then
        util.clearRenders()
        -- version.update()
        gSets.update()
        for slot in SL.iterDB() do
            slot:checkEnabled()
        end
    end
end
onEvents(Handlers.settingChange, {"on_runtime_mod_setting_changed"})

function Handlers.preTick(event)
    gSets.tick(event.tick)
    if version.needUpdate() then
        version.update()
        return false
    end
    if (not gSets.enabled()) then
        return false
    end
    return true
end
function Handlers.onNthTick(event)
    if not Handlers.preTick(event) then
        return
    end
end
function Handlers.onEveryTick(event)
    if not Handlers.preTick(event) then
        return
    end
    createdQ.tick()
    if (createdQ.size() <= 0) then
        Force.tickAll()
        alGui.renderTick()
    end
end
onEvents(Handlers.onEveryTick, {"on_tick"})

function Handlers.updateRenders(event)
    if not Handlers.preTick(event) then
        return
    end
    if (global.draw_toggle.count > 0) then
        for pIndex, t in pairs(global.draw_toggle) do
            if (pIndex ~= "count") then
                Handlers.keyChestRangeToggle({player_index = pIndex})
                Handlers.keyChestRangeToggle({player_index = pIndex})
            end
        end
    end
end
script.on_nth_tick(30, Handlers.updateRenders)

script.on_configuration_changed(version.update)
script.on_init(Init.doInit)

function Handlers.onLoad()
    if not version.needUpdate() then
        Init.doOnLoad()
    end
end
script.on_load(Handlers.onLoad)

-- function Handlers.itemInfoGUI(player, item)
--     local inf = itemInfo(item)
--     local playerGUI = player.gui.left
--     local gui =
--         playerGUI[gSets.itemInfoGUIName()] or
--         playerGUI.add({type = "frame", name = gSets.itemInfoGUIName(), direction = "vertical"})
--     if not gui then
--         return
--     end
--     if not inf then
--         gui.enabled = false
--         gui.visible = false
--         return
--     end
--     gui.enabled = true
--     gui.visible = true
--     local itemName = game.item_prototypes[inf.name].localised_name or {"item-name." .. inf.name}
--     gui.caption = itemName
--     local tab = gui
--     local cat = tab["category"] or tab.add({type = "label", name = "category", caption = "Category: " .. inf.category})
--     cat.caption = "Category: " .. inf.category
--     local rank = tab["rank"] or tab.add({type = "label", name = "rank", caption = "Rank: " .. inf.rank})
--     rank.caption = string.concat("Rank: ", inf.rank, "/", inf.catSize)
--     local dmg = tab["dmg"] or tab.add({type = "label", name = "dmg", caption = "Score (total): " .. inf.score})
--     dmg.caption = "Score (total): " .. inf.score
-- end

-- function Handlers.onGUI(event)
--     local player = game.get_player(event.player_index)
--     if (not player) then
--         return
--     end
--     local stack = player.cursor_stack
--     if (stack) and (stack.valid_for_read) and (stack.count > 0) then
--         -- cInform(stack.name, stack.count, player.opened_gui_type)
--         local inf = itemInfo(stack.name)
--         if (inf) then
--             Handlers.itemInfoGUI(player, inf.name)
--         -- local gui = Handlers.playerGUI(player)
--         -- gui.enabled = true
--         -- gui.caption = {"item-name." .. inf.name}
--         -- local rankLabel = gui.add({type = "label", name = gSets.itemInfoGUIName() .. "RankLabel", caption = "Rank: " .. inf.rank})
--         end
--     else
--         Handlers.itemInfoGUI(player)
--     end

--     -- cInform(player.cursor_stack, player.opened, player.opened_gui_type)
-- end
-- onEvents(Handlers.onGUI, {"on_player_cursor_stack_changed"})

function Handlers.onResearch(event)
    -- serpLog(event)
    if not Handlers.enabled() then
        return
    end
    local tech = event.research
    if (Map.containsValue(protoNames.tech, tech.name)) then
        -- Force.get(tech.force.name).techs[tech.name] = true
        -- version.update()
        local force = Force.get(tech.force.name)
        force:getTechs()
        force:checkEnabledSlots()
        if (tech.name == protoNames.tech.upgrade) then
            force:enableUpgrade()
        elseif (tech.name == protoNames.tech.returnItems) then
            force:enableReturn()
        end
    elseif (gSets.checkAfterResearch()) then
        version.update()
    end
end
onEvents(Handlers.onResearch, {"on_research_finished"})

function Handlers.keyReturn(event)
    inform("returning all items.")
    -- SL.returnAll(true, false)
    local player = game.players[event.player_index]
    if (player) then
        for slot in Force.get(player.force.name):iterSlots() do
            slot:returnItems()
        end
    end
    -- inform(event)
    -- for id, slotObj in pairs(SL.allSlots()) do
    --     slotObj:returnItems(true)
    -- end
end
onEvents(Handlers.keyReturn, {"ammo-loader-key-return"})
-- function Handlers.toggleInitDialogue(event)
--     local player = game.get_player(event.player_index)
--     if (not player) then
--         return
--     end
--     local screen = player.gui.screen
--     local init = screen[gui.names.initDialogue] or gui.createInitialDialogue(player)
--     if (init.enabled) and (init.visible) then
--         init.visible = false
--         init.enabled = false
--     end
--     init.enabled = true
--     init.visible = true
-- end
-- onEvents(Handlers.toggleInitDialogue, {"ammo-loader-key-return"})

function Handlers.keyReset()
    version.update()
end
onEvents(Handlers.keyReset, {"ammo-loader-key-reset"})

function Handlers.keyToggleEnabled()
    local isEnabled = gSets.enabled()
    if isEnabled then
        settings.global["ammo_loader_enabled"] = {value = false}
        version.update()
        ctInform("Ammo Loader Mod disabled")
    else
        settings.global["ammo_loader_enabled"] = {value = true}
        version.update()
        ctInform("Ammo Loader Mod enabled")
    end
end
-- script.on_event("ammo-loader-key-toggle-enabled", Handlers.keyToggleEnabled)
onEvents(Handlers.keyToggleEnabled, {"ammo-loader-key-toggle-enabled"})

function Handlers.keyChestRangeToggle(event)
    local pInd = event.player_index
    local player = game.players[pInd]
    if (not player) then
        return nil
    end
    util.clearPlayerRenders(player)
    local isOn = gSets.drawToggle(player)
    if (isOn) then
        gSets.drawToggle(player, false)
        return
    end
    local chests = Force.get(player.force.name).chests
    for chest in chests:chestIter() do
        chest:drawRange(player)
        chest:highlightConsumers(player)
    end
    gSets.drawToggle(player, true)
end
onEvents(Handlers.keyChestRangeToggle, {"ammo-loader-key-toggle-chest-ranges"})
