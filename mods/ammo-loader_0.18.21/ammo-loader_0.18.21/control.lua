-- require("__debugadapter__/debugadapter.lua")

-- Mod = require("lib/Import")
protoNames = require "prototypes/names"

-- if (game.active_mods["profiler"]) then
-- Profiler = require "__profiler__/profiler.lua"
-- end
-- Profiler = require "lib/profiler.lua"

-- fGui = require "__flib__.gui"
-- fGui = require "stdlib.gui"
-- require "__core__/lualib/util"
require "stdlib.util"
require "lib/util"
require "lib/gSettings"
require "lib/Initializer"
require "lib/Version"
require "lib/ModCompat"
require "lib/Remote"
require "lib/Handlers"

require "lib/gui/Gui"
require "lib/gui/GuiTemplates"
require "lib/gui/GuiHandlers"
-- require "lib/ChestFilterGUI"

require "lib/EntDB"
require "lib/ItemDB"
require "lib/createdQ"
require "lib/DB"
require "lib/idQ"

require "lib/Force"
require "lib/TrackedSlot"
require "lib/TrackedChest"
require "lib/HiddenInserter"

-- Init.registerFunc(
--     -- _init
--     function()
--         global["trackedPlayers"] = {}
--         local tp = global["trackedPlayers"]
--         for pInd, player in pairs(game.players) do
--             if (player.surface.name == "nauvis") then
--                 tp[pInd] = player.position
--             end
--         end
--     end
-- )
-- function trackedPlayers()
--     return global["trackedPlayers"]
-- end
-- function trackedPos(playerInd)
--     return trackedPlayers()[playerInd]
-- end

---@class ItemStack
---@field name string
---@field count integer

---@class Position
---@field x number
---@field y number

---@class Profiler : LuaProfiler

---@class dbObject
---@field isValid fun(self:dbObject):boolean
---@field destroy fun(self:dbObject) Does cleanup then removes object from database.
