--[[--
Module for caching and accessing mod settings (since settings api calls are expensive).
@module gSets
@alias gSettings
]]
gSets = {}
gSettings = gSets
-- gSettings.settings = {}
gSettings._init = function()
    global["settings_cache"] = {}
    gSettings.update()
end

gSettings.cache = function()
    return global["settings_cache"]
end
-- gCache = gSettings.cache
gSettings.value = function(name)
    return gCache()[name]
end
gSettings.getVal = gSettings.value
gSettings.val = gSettings.value
gSettings.lstZeroIsInfinite = {
    ammo_loader_max_items_per_slot = true,
    ammo_loader_max_items_per_inventory = true,
    ammo_loader_chest_radius = true
}
gSettings.requireUpdate = {
    ammo_loader_fill_artillery = true,
    ammo_loader_fill_burner_structures = true,
    ammo_loader_fill_locomotives = true,
    ammo_loader_chest_radius = true,
    ammo_loader_enabled = true
}
function gSettings.update()
    local c = {}
    global["settings_cache"] = c

    -- local pre = "ammo_loader_"
    for k, v in pairs(settings.global) do
        local setName = k
        if (string.find(setName, "ammo_loader")) then
            c[k] = v.value
        end
        --     local i, j = string.find(k, pre)
        --     if (j ~= nil) then
        --         local cName = string.sub(k, j + 1)
        --         local cVal = v.value
        --         -- if (gSettings.lstZeroIsInfinite[k]) and (cVal == 0) then
        --         --     cVal = math.huge
        --         -- end
        --         c[cName] = cVal
        --     end
    end
    c["ammo_loader_bypass_research"] = settings.startup["ammo_loader_bypass_research"].value
end
function gSettings.get(setting)
    return gSettings.cache()[setting]
end
function gSettings.registerListener(setting, class, funcName)
    class[funcName] = function()
        return gSettings.get(setting)
    end
end
function gSets.useTech()
    local val = global["settings_cache"]["ammo_loader_bypass_research"]
    if (val) then
        return false
    end
    return true
end
function gSettings.ticksPerCycle()
    -- return global["settings_cache"]["ammo_loader_ticks_between_cycles"]
    return 3
end
gSets.ticksBetweenCycles = gSets.ticksPerCycle

function gSettings.slotsPerCycle()
    -- return global["settings_cache"]["ammo_loader_max_inventories_per_cycle"]
    -- return 10
    return gSets.maxSlotsPerChestTick()
end

function gSettings.chestsPerCycle()
    -- return global["settings_cache"]["ammo_loader_max_chests_per_cycle"]
    return 5
end

function gSettings.maxSlotsPerChestTick()
    return 10
end

function gSettings.maxReturnSlots()
    return 10
end

function gSettings.doArtillery()
    return global["settings_cache"]["ammo_loader_fill_artillery"]
end

function gSettings.doBurners()
    return global["settings_cache"]["ammo_loader_fill_burner_structures"]
end

function gSettings.doTrains()
    return global["settings_cache"]["ammo_loader_fill_locomotives"]
end

function gSets.enabled()
    return global["settings_cache"]["ammo_loader_enabled"]
end

function gSets.drawRange()
    return global["settings_cache"]["ammo_loader_draw_range"]
end

function gSets.debugging()
    return global["settings_cache"]["ammo_loader_debugging"]
end
gSets.debug = gSets.debugging

function gSets.ticksBetweenChestCache()
    return 30
    -- return global["settings_cache"]["enabled"]
end

function gSets.ticksBeforeCacheRemoval()
    return 180
end
gSets.ticksChestCacheDelay = gSets.ticksBeforeCacheRemoval

function gSets.newInvsPerCycle()
    -- return global["settings_cache"]["ammo_loader_new_invs_checked_per_cycle"]
    return 100
end

function gSets.chestRadius()
    return global["settings_cache"]["ammo_loader_chest_radius"]
end

function gSets.rangeIsInfinite()
    if (gSets.chestRadius() <= 0) then
        return true
    end
    return false
end

function gSets.slotMax()
    return global["settings_cache"]["ammo_loader_max_items_per_slot"]
end

function gSets.slotProvideInterval()
    return 60
end

function gSets.maxProvideSlots()
    -- return 10
    return gSets.slotsPerCycle()
end

function gSets.doReturn()
    return global["settings_cache"]["ammo_loader_return_items"]
end

function gSets.doUpgrade()
    return global["settings_cache"]["ammo_loader_upgrade_ammo"]
end

function gSets.maxIndicatorsPerTick()
    return 100
end

function gSets.maxIndicators()
    return 10000
end

function gSets.tick(new)
    if not new then
        local tick = global["settings_cache"]["tick"] or game.tick
        return tick
    end
    global["settings_cache"]["tick"] = new
end

function gSets.drawReady()
    local interval = 25
    local last = global["lastDrawTick"] or 0
    local tick = gSets.tick()
    if (tick < last + interval) then
        return false
    end
    global["lastDrawTick"] = tick
    return true
end

function gSets.hasIndicators(val)
    if not val then
        return global["hasIndicators"]
    end
    global["hasIndicators"] = val
end

-- gSettings._init()
return gSets
