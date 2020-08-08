Init = {}
Initializer = Init
Initializer.funcBackup = {}
Initializer.localBackup = {}
Init._resetFuncs = {}
Init.preInitFuncs = {}

-- Initializer.globals = {}
-- function Init.funcs()
--     return Init.initFuncs
-- end
-- function Init.localFuncs()
--     if global["_initLocalFuncs"] == nil then
--         global["_initLocalFuncs"] = Init.localBackup
--     end
--     return global["_initLocalFuncs"]
-- end
function Init.resetFuncs()
    return Init._resetFuncs
end
function Init.registerFunc(f)
    table.insert(Init.funcBackup, f)
    return f
end
Init.registerInitFunc = Init.registerFunc
function Init.registerOnLoadFunc(f)
    table.insert(Init.localBackup, f)
    return f
end
function Init.registerResetFunc(f)
    table.insert(Init._resetFuncs, f)
    return f
end

function Init.registerPreInitFunc(f)
    table.insert(Init.preInitFuncs, f)
    return f
end

function Init.doInit()
    cInform("Initializing")
    -- Init.reset()
    -- if (global["DB"] ~= nil) then
    --     HI.destroyAll()
    -- end
    local initFuncs = Init.funcBackup
    local persist = global.persist
    if (not persist) then
        persist = {}
        global.persist = persist
    end
    for ind, func in pairs(Init.preInitFuncs) do
        func()
    end
    -- local trackedPlayers = global["trackedPlayers"]
    global = {}
    global.persist = persist
    gSets._init()
    for ind, func in pairs(initFuncs) do
        func()
    end
    cInform(#initFuncs .. " functions successfully executed.")
    -- if (trackedPlayers) then
    --     for playerInd, pos in pairs(trackedPlayers) do
    --         if not global["trackedPlayers"][playerInd] then
    --             global["trackedPlayers"][playerInd] = pos
    --         end
    --     end
    -- end
    if not gSets.enabled() then
        return nil
    end
    ctInform("resetting global tables...")
    createdQ.startReset()
    -- checkAllEntities()
    createdQ.checkAllEntities()
    return true
end
function Init.doOnLoad()
    -- local localFuncs = Init.localBackup
    for ind, func in pairs(Init.localBackup) do
        func()
    end
end

return Init
