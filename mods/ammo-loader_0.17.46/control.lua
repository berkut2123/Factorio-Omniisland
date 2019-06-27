--[[--
Control script where all code is executed.
@script control
]]
-- Mod = require("lib/Import")
protoNames = require "prototypes/names"
require "lib/util"
-- inform = util.inform
-- isValid = util.isValid
require "lib/gSettings"
-- gSettings = gSets
require "lib/Initializer"

require "lib/Queue"
require "lib/PriorityQueue"
require "lib/Array"
-- List = Array
require("lib/Map")

require "lib/createdQ"
require "lib/DB"
require "lib/ItemDB"
-- ItemDB.item
require "lib/Force"
-- FRC = Force
require "lib/TrackedSlot"
require "lib/TrackedChest"
require "lib/HiddenInserter"
require "lib/idQ"

require "lib/Rem"

require "stdlib/area/area"
require "stdlib/string"
require "stdlib/table"
require "stdlib/area/position"

version = {}
version._latest = 78

function version._init()
    global["_ver"] = {}
    global["_ver"]["cur"] = version._latest
end
Init.registerFunc(version._init)
-- version.latest = version._latest
-- version.debugUpdate = true
function version.master()
    -- if global["_ver"] == nil then
    --     global["_ver"] = {}
    --     global["_ver"]["cur"] = 0
    -- end
    return global["_ver"]
end
function version.get()
    return version.master().cur
end
function version.set(val)
    version.master().cur = val
end
function version.latest()
    return version._latest
end
function version.needUpdate()
    local mas = global["_ver"]
    if not mas then
        return true
    end
    local ver = mas.cur
    if not ver then
        return true
    end
    if (version._latest ~= ver) then
        -- inform("need update!")
        return true
    end
    return false
end
function version.update()
    -- local latest = version.latest()
    Init.doInit()
    -- global["_ver"] = {}
    -- global["_ver"].cur = latest
    -- global["_ver"].latest = latest
    -- version.set(version.latest())
    inform("successfully updated globals")
end
-- function version.up()
-- 	version.master()["latest"] = version.latest() + 1
-- end
function checkAllEntities()
    inform("Queueing all entities...")
    local results = util.allFind({})
    local q = createdQ.q()
    for i = 1, #results do
        local ent = results[i]
        if (ent.force.name ~= "neutral") then
            local isChest = TC.isChest(ent)
            if (SL.isTrackable(ent)) or (isChest) then
                if (isChest) then
                    Q.push(q, ent)
                else
                    Q.pushleft(q, ent)
                end
            end
        -- Q.push(q, ent)
        end
    end
    cInform("Queued ", q:size(), " entities for analysis.")
end

function errorStack()
    inform("errorStack:\n" .. debug.traceback(), true)
end

function on_tick(event)
    -- Init.doInit()
    if version.needUpdate() then
        version.update()
        return nil
    end
    -- add_created()
    -- if (not gSets.enabled()) or (event.tick % gSets.ticksBetweenCycles() ~= 0) then
    if (not gSets.enabled()) then
        return nil
    end
    gSets.tick(event.tick)
    TC.tickIndicators()
    createdQ.tick()
    -- if (game.tick % gSettings.ticksPerCycle() ~= 0) then return nil end
    Force.tickAll()
    -- xpcall(Force.tickAll, errorStack)
    -- FRC.tick()
    -- LOGGER.log("profile get cycle1")
end

function handler(func)
    local function h(event)
        if (not gSets.enabled()) or (version.needUpdate()) then
            return nil
        end
        return func(event)
    end
    return h
end

function onEvents(func, eventNames)
    -- local hand = handler(func)
    for i = 1, #eventNames do
        local name = eventNames[i]
        script.on_event(defines.events[name], func)
    end
end

on_built =
    handler(
    function(event)
        if (not event.created_entity) or (not event.created_entity.valid) then
            return
        end
        local ent = event.created_entity
        local waitEnt = createdQ.waitQTriggers[ent.name]
        if (waitEnt) then
            -- if (ent.surface.name ~= "nauvis") then
            --     createdQ.tick(ent)
            createdQ.waitQAdd(waitEnt)
        elseif (SL.isTrackable(ent)) or (TC.isChest(ent)) then
            -- local f = Force.get(ent.force.name)
            -- local sl = f.slots
            -- local cyc = sl.cycle
            -- for i = 1, sl:size() do
            --     local test = cyc(sl)
            --     if (not test) then
            --         break
            --     end
            --     if (test.ent == ent) then
            --         inform("Slot already exists, aborting create.")
            --         return
            --     end
            -- end
            createdQ.push(ent)
        end
    end
)
onEvents(on_built, {"on_built_entity", "on_robot_built_entity", "script_raised_built"})
-- script.on_event(defines.events.on_built_entity, on_built)
-- script.on_event(defines.events.on_robot_built_entity, on_built)
-- script.on_event(defines.events.script_raised_built, on_built)
on_removed =
    handler(
    function(event)
        local ent = event.entity
        if (TC.isChest(ent)) then
            local chest = TC.getObjFromEnt(ent)
            if (chest) then
                chest:destroy()
            end
            return
        end
        local tracked = SL.trackable.all()
        if tracked[ent.name] then
            local cause = event.cause
            local slots = SL.getSlotsWithEnt(ent)
            slots:forEach(
                function(slot)
                    if (gSets.doReturn()) and (not cause) then
                        slot:returnItems()
                    end
                    inform("destroy slot")
                    slot:destroy()
                end,
                nil,
                false
            )
        end
    end
)
onEvents(on_removed, {"on_pre_player_mined_item", "on_robot_pre_mined", "on_entity_died"})
-- script.on_event(defines.events.on_pre_player_mined_item, on_removed)
-- script.on_event(defines.events.on_robot_pre_mined, on_removed)
-- script.on_event(defines.events.on_entity_died, on_removed)
Init.registerFunc(
    --_init
    function()
        global["trackedPlayers"] = {}
        local tp = global["trackedPlayers"]
        for pInd, player in pairs(game.players) do
            if (player.surface.name == "nauvis") then
                tp[pInd] = player.position
            end
        end
    end
)
function trackedPlayers()
    return global["trackedPlayers"]
end
function trackedPos(playerInd)
    return trackedPlayers()[playerInd]
end
trackPlayer =
    handler(
    function(event)
        -- local player = game.players[event.player_index]
        -- if (game.surfaces[event.surface_index].name ~= "nauvis") then
        -- if (player.surface.name == "nauvis") then
        -- trackedPlayers()[player.index] = player.position
        -- end
        -- end
    end
)
onEvents(trackPlayer, {"on_player_changed_surface"})
-- script.on_event(defines.events.on_player_changed_surface, trackPlayer)
keyReturn =
    handler(
    function(event)
        inform("returning all items.")
        -- SL.returnAll(true, false)
        local player = game.players[event.player_index]
        if (player) then
            SL.clearAllSlots(player.force.name)
        end
        -- inform(event)
        -- for id, slotObj in pairs(SL.allSlots()) do
        --     slotObj:returnItems(true)
        -- end
    end
)
script.on_event("ammo-loader-key-return", keyReturn)
-- script.on_event("ammo-loader-key-return", keyReturn)
-- function keyUpgrade(event)
-- 	for name, frc in pairs(FRC.forces()) do
-- 		local slots = frc.slots
-- 		for i=1, slots:size() do
-- 			local slotObj = slots:cycle()
-- 			if not slotObj then break end
-- 			slotObj.doUpgrade = true
-- 		end
-- 	end
-- 	inform("upgrading all inventories to best available items.", true)
-- end
-- script.on_event("ammo-loader-key-upgrade", keyUpgrade)
-- keyChestGUI =
--     handler(
--     function(event)
--         local player = game.players[event.player_index]
--         if (not player) then
--             return nil
--         end
--         local entity = player.selected
--         if not (entity) then
--             return
--         end
--         local proto = entity.prototype
--         local params = proto.attack_parameters
--         if (params) then
--             inform(util.table.tostring(params))
--         end
--         -- local slotObj = SL.getSlotsByEnt(entity)[1]
--         -- if (not slotObj) then
--         --     return
--         -- end
--         -- player.opened = slotObj:inserter().ent
--     end
-- )
-- script.on_event("ammo-loader-key-chest-filter-GUI", keyChestGUI)
-- keyChestRangeToggle =
--     handler(
--     function(event)
--         local pInd = event.player_index
--         local player = game.players[pInd]
--         if (not player) then
--             return nil
--         end
--         local fName = player.force.name
--         local inds = TC.indicators()
--         if (inds.toggled) then
--             TC.clearAllIndicators(fName)
--             inds.toggled = nil
--         else
--             TC.queueAllIndicators(fName)
--             inds.toggled = true
--         end
--     end
-- )
-- keyChestRangeToggle =
--     handler(
--     function(event)
--         local pInd = event.player_index
--         local player = game.players[pInd]
--         if (not player) then
--             return nil
--         end
--         local ent = player.selected
--         if not ent then
--     end
-- )
-- script.on_event("ammo-loader-key-toggle-chest-ranges", keyChestRangeToggle)

settingChange = function(event) -- handler(
    if gSettings.requireUpdate[event.setting] then
        version.update()
    else
        gSets.update()
    end
end
-- )
onEvents(settingChange, {"on_runtime_mod_setting_changed"})
-- script.on_event(defines.events.on_runtime_mod_setting_changed, settingChange)
-- Init.registerFunc(mainGlobals)
-- remote.add_interface(
--     "ammo-loader",
--     {
--         on_entity_replaced = function(data)
--             on_built({created_entity = data.new_entity})
--         end
--     }
-- )
-- script.on_event(defines.events.on_tick, on_tick)
-- script.on_nth_tick(settings.global["ammo_loader_ticks_between_cycles"].value, on_tick)
script.on_nth_tick(gSets.ticksBetweenCycles(), on_tick)
script.on_configuration_changed(
    function()
        version.update()
    end
)

script.on_init(
    function()
        Init.doInit()
    end
)

script.on_load(
    function()
        if not version.needUpdate() then
            Init.doOnLoad()
        end
    end
)

onSelectedEntity =
    handler(
    function(event)
        if (gSets.rangeIsInfinite()) or (not gSets.drawRange()) or (gSets.chestRadius() > 100) then
            return nil
        end
        local player = game.players[event.player_index]
        if not player then
            return nil
        end
        -- if (gSets.hasIndicators()) then
        -- TC.clearAllIndicators(player.force.name)
        -- gSets.hasIndicators(false)
        -- end
        local ids = rendering.get_all_ids("ammo-loader")
        for i, id in pairs(ids) do
            local players = rendering.get_players(id)
            if (players and players[1] and players[1].index == player.index) then
                rendering.destroy(id)
            end
        end
        local selected = player.selected
        if (not selected) or (not selected.valid) then
            return
        end
        if (TC.chestNames("hash")[selected.name]) then
            local chest = TC.getObjFromEnt(selected)
            if (chest) then
                chest:drawRange(player)
            end
        elseif (SL.isTrackable(selected)) then
            local slots = SL.getSlotsWithEnt(selected)
            for i = 1, slots:size() do
                local slot = slots:pop()
                if not slot then
                    break
                end
                local prov = slot:provider()
                if (prov) then
                    slot:highlight(player)
                    rendering.draw_line(
                        {
                            color = {r = 0.5, g = 0.125, b = 0.03, a = 0.1},
                            width = 1.0,
                            from = slot.ent,
                            to = prov.ent,
                            surface = slot:surface().name,
                            forces = {player.force.name},
                            players = {player.index},
                            draw_on_ground = false
                        }
                    )
                end
            end
        end

        -- gSets.hasIndicators(true)
    end
)
onEvents(onSelectedEntity, {"on_selected_entity_changed"})

-- onCursorStackChanged = handler(function(event)
--     if (gSets.rangeIsInfinite()) or (not gSets.drawRange()) then
--         return nil
--     end
--     local player = game.players[event.player_index]
--     if (not player) or (not player.cursor_stack) or (not player.cursor_stack.valid_for_read) then
--         return nil
--     end
--     local itemName = player.cursor_stack.name
--     if (TC.chestNames("hash")[itemName]) then

--     end
-- end)
-- onEvents(onCursorStackChanged, {"on_player_cursor_stack_changed"})

onResearch =
    handler(
    function(event)
        local tech = event.research
        if (Map.containsValue(protoNames.tech, tech.name)) then
            -- Force.get(tech.force.name).techs[tech.name] = true
            version.update()
        else
            local fName = event.research.force.name
            local force = Force.get(fName)
            force.needPurge = true
        end
    end
)
onEvents(onResearch, {"on_research_finished"})
-- script.on_event(defines.events.on_selected_entity_changed, onSelectedEntity)
