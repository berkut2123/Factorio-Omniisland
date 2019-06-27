--Setup for the reverse factory item, entity, recipe, and tech
require("prototypes.technology")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.pipe-covers")
require("prototypes.entity")
--Setup for the reverse recipe groups and categories
require("prototypes.catgroups")


rf = {}
rf.recipes = {}
rf.vehicles = settings.startup["rf-vehicles"].value
rf.intermediates = settings.startup["rf-intermediates"].value
rf.norecycle_items = {}
rf.norecycle_categories = {}
--table.insert(rf.norecycle_items, "electronic-circuit")
--[[
    Construction Drones adds equipment grid to light armor
    This prevents light armor from being used in reverse recipe
    Robot Army uses light armor in droid-flame recipe
    Therefore, remove droid-flame recipe from being recycled in only this case
]]--
if mods["Construction_Drones"] and mods["robotarmy"] then
	table.insert(rf.norecycle_items, "droid-flame")
end
if mods["bobplates"] and mods["attach-notes"] then
	table.insert(rf.norecycle_items, "heavy-water")
end
table.insert(rf.norecycle_categories, "recycle")
table.insert(rf.norecycle_categories, "recycle-with-fluids")
table.insert(rf.norecycle_categories, "oil-processing")
--table.insert(rf.norecycle_categories, "centrifuging")
--table.insert(rf.norecycle_categories, "smelting")