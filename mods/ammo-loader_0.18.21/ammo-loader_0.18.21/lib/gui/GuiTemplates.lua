alGui.templates = {}
local alGuiTemps = alGui.templates
alGui.templates.basic = {}
local alGuiBasicTemps = alGui.templates.basic
alGui.templates.informatron = {}
local infoTemps = alGui.templates.informatron
infoTemps.main = {}
local infoTempsMain = infoTemps.main
infoTemps.features = {}
local infoTempsFeatures = infoTemps.features

function alGuiTemps.fromString(str)
    local start = alGui.templates
    local cur = start
    local c = 0
    local iter = str:gmatch("%.?(%w+)%.?")
    for ref in iter do
        if (c == 0) then
            if (ref == "basic") then
                cur = alGuiBasicTemps
            elseif (ref == "infoTemps") then
                cur = infoTemps
            elseif (ref == "infoMain") then
                cur = infoTempsMain
            elseif (ref == "infoFeatures") then
                cur = infoTempsFeatures
            elseif (ref == "infoRanks") then
                cur = infoTempsRanks
            elseif (ref == "chestFilter") then
                cur = alGui.chestFilter.templates
            end
        else
            if (not cur[ref]) then
                cInform("could not find template ref")
                -- serpLog("template ref")
                -- serpLog(cur)
                -- serpLog(ref)
                return
            end
            cur = cur[ref]
        end
        c = c + 1
    end
    return cur
end

function alGuiTemps.getAbsTemp(s)
    local split = string.gmatch(s, "([%w%_%d]+)%.?")
    local temp = _G["alGui"]
    for varName in split do
        -- serpLog("varName: ", varName)
        temp = temp[varName]
    end
    return temp
end

--- ***Given a GUI element, find an ancestor with name matching `pattern` (recursive).***
---@param elem LuaGuiElement @***The element to start from.***
---@param pattern string
---@param useRegex boolean @***defaults to true (use string.match), if set to false will use == operator.***
---@return LuaGuiElement @***The first ancestor with a matching name. Nil if no match is found.***
function alGui.templates.getAncestorWithName(elem, pattern, useRegex)
    if (not isValid(elem)) or (not pattern) or (pattern == "") then
        return nil
    end
    if (useRegex == nil) then
        useRegex = true
    end
    local curElem = elem
    while (isValid(curElem.parent)) do
        curElem = curElem.parent
        local curName = curElem.name
        if (useRegex) and (curName:match(pattern)) then
            return curElem
        elseif (not useRegex) and (curName == pattern) then
            return curElem
        end
    end
    return nil
end

---@param elem LuaGuiElement @***The element to start from.***
---@param pattern string
---@param useRegex boolean @***defaults to true (use string.match), if set to false will use == operator.***
---@return LuaGuiElement @***The first sibling with a matching name. Nil if no match is found.***
function alGui.templates.getSiblingWithName(elem, pattern, useRegex)
    if (not isValid(elem)) or (not pattern) or (pattern == "") then
        return nil
    end
    if (useRegex == nil) then
        useRegex = true
    end
    cInform("use regex: ", useRegex)
    local curElem = elem.parent
    for childInd, childElem in pairs(curElem.children) do
        if (useRegex) and (childElem.name:match(pattern)) then
            return childElem
        elseif (not useRegex) and (childElem.name == pattern) then
            return childElem
        end
    end
    return nil
end

---@param elem LuaGuiElement @***The element to start from.***
---@param pattern string
---@param useRegex boolean @***defaults to true (use string.match), if set to false will use == operator.***
---@return LuaGuiElement @***The first descendent with a matching name. Nil if no match is found.***
function alGui.templates.getChildWithName(elem, pattern, useRegex)
    if (not isValid(elem)) or (not pattern) or (pattern == "") then
        return nil
    end
    if (useRegex == nil) then
        useRegex = true
    end
    local curElem = elem
    for childIndex, childElem in pairs(curElem.children) do
        if (useRegex) and (childElem.name:match(pattern)) then
            return childElem
        elseif (not useRegex) and (childElem.name == pattern) then
            return childElem
        end
        local recRes = alGui.templates.getChildWithName(childElem, pattern, useRegex)
        if (recRes) then
            return recRes
        end
    end
    return nil
end

---@param t table @***The parent table to apply the template to. Must have valid 'template' field.***
---@return table @***A new table with all templates applied recursively (upwards only).***
function alGuiTemps.applyTemplate(t)
    if (not t) or (not t.template) then
        cInform("cannot apply template: invalid.")
        return
    end
    if (type(t.template) ~= "string") then
        error(
            "value of 'template' field must be a string representation of a template in the alGui class. " ..
                type(t.template) .. " given."
        )
    end
    local parent = t.template
    -- if (type(parent) == "table" and parent.func) then
    --     local args = parent.args or {}
    --     template.template = parent.func(unpack(args))
    --     parent = template.template
    -- end
    if (type(parent) == "string") then
        parent = alGuiTemps.getAbsTemp(parent)
    end
    if (type(parent) == "function") then
        local args = t.args or {}
        parent = parent(table.unpack(args))
    end
    if (type(parent) ~= "table") then
        cInform("could not parse template. Aborting...")
        -- serpLog(parent)
        return
    end
    if (parent.template) then
        parent = alGui.templates.applyTemplate(parent)
    end
    -- local res = table.shallowJoin(parent, t)
    local res = t
    for key, val in pairs(parent) do
        res[key] = val
    end
    res.template = nil
    res.args = nil
    -- t.template = nil
    -- serpLog("applyTemplate finished product: ", res)
    return res
end

alGuiBasicTemps.outerFrame = {type = "frame", save_as = "root"}
alGuiBasicTemps.window = {
    type = "frame",
    direction = "vertical",
    save_as = "window",
    style = "standalone_inner_frame_in_outer_frame"
}
alGuiBasicTemps.content = {
    type = "frame",
    style = "inside_shallow_frame_with_padding",
    direction = "vertical",
    save_as = "content"
}
alGuiBasicTemps.frameActionButton = {
    type = "sprite-button",
    style = "frame_action_button",
    mouse_button_filter = {"left"}
}
alGuiBasicTemps.titleLabel = function(title)
    return {
        type = "label",
        style = "frame_title",
        save_as = "titleLabel",
        tooltip = "Ammo Loader+ GUI",
        caption = title
    }
end
alGuiBasicTemps.dragBar = {
    type = "empty-widget",
    style = "draggable_space_header",
    style_mods = {horizontally_stretchable = true, height = 24, right_margin = 4, minimal_width = 20},
    save_as = "dragBar"
}
alGuiBasicTemps.closeButton = {
    template = "templates.basic.frameActionButton",
    -- handlers = "templates.basic.closeButton",
    save_as = "closeButton",
    name = "algui_close_button"
}
alGuiBasicTemps.closeButtonWhite = {
    template = "templates.basic.closeButton",
    sprite = "utility/close_white"
}
alGuiBasicTemps.closeButtonDark = {
    template = "templates.basic.closeButton",
    sprite = "utility/close_dark"
}
alGuiBasicTemps.titleBar = function(title)
    return {
        --** Don't forget to set the caption on the label! **--
        type = "flow",
        save_as = "titleBar",
        direction = "horizontal",
        children = {
            {template = "templates.basic.titleLabel", args = {title}},
            {template = "templates.basic.dragBar"},
            {template = "templates.basic.closeButtonWhite"}
        }
    }
end

alGui.chestFilter = {funcs = {}, templates = {}, postBuildFuncs = {}}
local chestFilterFuncs = alGui.chestFilter.funcs
local chestFilterTemplates = alGui.chestFilter.templates
local chestFilterPostFuncs = alGui.chestFilter.postBuildFuncs

function chestFilterFuncs.create(player, chest)
    local win = chestFilterTemplates.window(chest)
    -- if (isValid(player.gui.screen["algui_window__chest_filters"])) then
    -- player.gui.screen["algui_window__chest_filters"].destory()
    -- end
    local elems = alGui.build(player.gui.screen, win)
    elems.dragBar.drag_target = elems.window
    elems.titleLabel.drag_target = elems.window
    elems.window.force_auto_center()
    return elems
end

function chestFilterFuncs.getSelectedFilters(elem)
    if (not isValid(elem)) then
        return
    end
    local container = elem
    if (not elem.name:match("(algui%_container%_%_chest%_filter%_list)")) then
        container = alGui.templates.getAncestorWithName(elem, "(algui%_container%_%_chest%_filter%_list)")
    end
    local res = {}
    local emptyCount = 0
    for elemInd, elem2 in pairs(container.children) do
        if (elem2.elem_value) then
            local itemProto = game.item_prototypes[elem2.elem_value]
            if (itemProto) then
                local entProto = itemProto.place_result
                if (SL.entProtoIsTrackable(entProto)) then
                    res[entProto.name] = itemProto.name
                end
            end
        elseif (emptyCount > 0) then
            elem2.destroy()
        else
            emptyCount = emptyCount + 1
        end
    end
    return res
end

function chestFilterFuncs.getSelectedFilterMode(switch)
    local rawVal = switch.switch_state
    local val = "whitelist"
    if (rawVal == "right") then
        val = "blacklist"
    end
    return val
end

function chestFilterFuncs.saveFilters(player, elem)
    if (not isValid(player)) or (not isValid(elem)) then
        return
    end
    local chest = chestFilterFuncs.curChest(player)
    if (not chest) or (not isValid(elem.parent)) then
        return
    end
    local container = elem.parent
    local filters = chestFilterFuncs.getSelectedFilters(container)
    chest:setEntFilter(filters, chest._entFilterMode)
    -- local filterElems = chestFilterFuncs.chestFilterElems(chest)
    -- container.clear()
    -- for i, elem in pairs(filterElems) do
    --     alGui.build(container, elem)
    -- end
end

function chestFilterFuncs.saveFilterMode(player, elem)
    if (not isValid(player)) or (not isValid(elem)) then
        return
    end
    local chest = chestFilterFuncs.curChest(player)
    if (not chest) then
        return
    end
    local val = chestFilterFuncs.getSelectedFilterMode(elem)
    if (not val) then
        return
    end
    chest._entFilterMode = val
end

function chestFilterFuncs.saveAll(player)
    if not isValid(player) then
        return
    end
    -- local obj = alGui.playerObjs(player).chestFilter
    local chestID = global.alGui.chestFilters.playersCurOpenChest[player.index]
    local chest = TC.getObj(chestID)
    if (not chest) then
        return
    end
    local win = chestFilterFuncs.getWindow(player)
    local mode = "whitelist"
    local switchState = alGui.templates.getChildWithName(win, "(algui%_switch%_%_filter%_mode)").switch_state
    if (switchState == "right") then
        mode = "blacklist"
    end
    chest:setEntFilter(
        alGui.chestFilter.funcs.getSelectedFilters(
            alGui.templates.getChildWithName(win, "(algui%_container%_%_chest%_filter%_list)")
        ),
        mode
    )
    -- serpLog("new filter list")
    -- serpLog(chest._entFilter)
    -- serpLog("new filter mode")
    -- serpLog(chest._entFilterMode)
end

function chestFilterFuncs.getWindow(player)
    if (not isValid(player)) then
        return false
    end
    return player.gui.screen["algui_frame__chest_filters"]
end

function chestFilterFuncs.windowIsOpen(player)
    if (not isValid(player)) then
        return false
    end
    if (isValid(player.gui.screen["algui_frame__chest_filters"])) then
        return true
    end
    return false
end

function chestFilterFuncs.curChest(player)
    if (not chestFilterFuncs.windowIsOpen(player)) then
        return nil
    end
    local curChestID = global.alGui.chestFilters.playersCurOpenChest[player.index]
    local chest = TC.getObj(curChestID)
    if (not chest) then
        return nil
    end
    return chest
    -- local objs = alGui.playerObjs(player)
    -- if (not objs) or (not objs["chestFilter"]) then
    --     return
    -- end
    -- return TC.getObj(objs.chestFilter.chestID)
end

function chestFilterFuncs.chestFilterElems(chest)
    if (not chest) then
        return
    end
    local filterList = chest._entFilter
    if (not filterList) or (table_size(filterList) <= 0) then
        return {{template = "chestFilter.filterList.filterElem"}}
    else
        local elems = {}
        for entName, itemName in pairs(filterList) do
            table.insert(elems, {template = "chestFilter.filterList.filterElem", args = {itemName}})
        end
        table.insert(elems, {template = "chestFilter.filterList.filterElem"})
    end
    return elems
end

chestFilterTemplates.window = function(chest)
    return {
        type = "frame",
        direction = "vertical",
        save_as = "window",
        -- save_as = "root",
        name = "algui_frame__chest_filters",
        children = {
            {template = "templates.basic.titleBar", args = {"AL+: Chest Filters"}},
            {template = "chestFilter.templates.contentMain", args = {chest}}
        }
    }
end

chestFilterTemplates.contentMain = function(chest)
    return {
        type = "frame",
        template = "templates.basic.content",
        save_as = "chestFilterContent",
        name = "algui_container__chest_filters_and_mode__" .. chest.id,
        children = {
            {template = "chestFilter.templates.filterMode.container", args = {chest}},
            {template = "chestFilter.templates.filterList.container", args = {chest}}
        }
    }
end

chestFilterTemplates.filterMode = {}
local filterModeTemps = chestFilterTemplates.filterMode

filterModeTemps.container = function(chest)
    return {
        type = "flow",
        direction = "horizontal",
        name = "chestFilterModeContainer",
        style_mods = {bottom_margin = 15, horizontally_stretchable = true, horizontal_align = "center"},
        children = {
            {template = "chestFilter.templates.filterMode.label"},
            {template = "chestFilter.templates.filterMode.switch", args = {chest}}
        }
    }
end
filterModeTemps.label = {type = "label", caption = "Filter Mode: "}
filterModeTemps.switch = function(chest)
    return {
        type = "switch",
        allow_none_state = false,
        left_label_caption = "whitelist",
        right_label_caption = "blacklist",
        left_label_tooltip = "Only supply these types of entities",
        right_label_tooltip = "Supply all entities except these",
        name = "algui_switch__filter_mode__" .. chest.id,
        save_as = "filterModeSwitch",
        -- handlers = "chestFilter.templates.filterModeSwitch",
        switch_state = chestFilterFuncs.chestSwitchVal(chest)
    }
end
function chestFilterFuncs.chestSwitchVal(chest)
    if (not chest) then
        return "left"
    end
    local mode = "whitelist"
    local val = "left"
    if (chest._entFilterMode) then
        mode = chest._entFilterMode
    end
    if (mode == "blacklist") then
        val = "right"
    end
    return val
end

chestFilterTemplates.filterList = {}
local filterListTemps = chestFilterTemplates.filterList
filterListTemps.container = function(chest)
    local children = {}
    if (not chest) or (not chest._entFilter) or (table_size(chest._entFilter) <= 0) then
        table.insert(children, {template = "chestFilter.templates.filterList.filterElem"})
    else
        for entName, itemName in pairs(chest._entFilter) do
            table.insert(children, {template = "chestFilter.templates.filterList.filterElem", item = itemName})
        end
        table.insert(children, {template = "chestFilter.templates.filterList.filterElem"})
    end
    return {
        type = "flow",
        direction = "horizontal",
        name = "algui_container__chest_filter_list" .. "__" .. chest.id,
        save_as = "filterListContainer",
        children = children
    }
end
filterListTemps.filterElem = {
    type = "choose-elem-button",
    elem_type = "item",
    handlers = "chestFilter.templates.filterElem"
}

alGui.templates.singleLineFalse = {single_line = false}
alGui.templates.styleModsMultiLine = {style_mods = alGui.templates.singleLineFalse}
local multiLineMod = alGui.templates.styleModsMultiLine
alGui.templates.heading2bot3 = {style = "heading_2_label", style_mods = {bottom_margin = 3}}
local infoHeading2 = alGui.templates.heading2bot3

alGui.infoMain = {funcs = {}, temps = {}}
local infoMain = alGui.infoMain
function infoMain.temps.featFrame(name, caption, features)
    return {
        type = "flow",
        visible = false,
        save_as = "toggleTarget",
        direction = "vertical",
        style_mods = {padding = 5, top_margin = 5, bottom_margin = 5},
        name = name .. "__algui_toggle_but_frame",
        children = features
    }
end
function infoMain.temps.featButton(name, caption, features)
    return {
        type = "button",
        caption = caption,
        style_mods = {font = "heading-2", bottom_margin = 3, width = 300},
        enabled = true,
        toggle_target = infoMain.temps.featFrame(name, caption, features),
        name = name .. "__algui_toggle_button"
    }
end
infoMain.temps.featsAmmoLoading = {
    alGui.label(
        "The first Ammo Loader+ research enables the use of the Loader Chest. Simply plop this chest down, fill it with ammo, and it will begin to automatically supply ammo turrets in range. Note that the chest requires a minimum amount of items before it will supply them to entities (10 for most ammo).\n\nThe chest will also supply the player character with ammo based on which guns they have equipped.",
        multiLineMod
    )
}
infoMain.temps.featsFuelLoading = {
    alGui.label(
        "The Loader Chest may be filled with fuel to supply fuel-using entities that are in range, just like it does for ammo. This functionality requires the Ammo Loader: Fuel research for fuel-using structures, and the Ammo Loader: Vehicles research for cars, tanks, trains, etc.\n",
        multiLineMod
    ),
    alGui.label(
        "This functionality must also be enabled in the per-map mod options (the Burner Structures and Locomotives checkboxes) in order to work. This is so players may disable this functionality if desired.",
        {style_mods = {font = "default-bold", single_line = false, top_margin = 3, bottom_margin = 3}}
    )
}
infoMain.temps.featsSmartLoading = {
    alGui.label(
        "Loader Chests aren't just dumb inserters. They actively search for the best ammo and fuel available when supplying entities.\n\nFor instance, if a Loader Chest has both basic Firearm Magazines and Piercing Rounds Magazines available, it will use all available Piercing Rounds Magazines before supplying Firearm Magazines. Same for fuel -- Rocket Fuel will be supplied before Coal.\n\nThis also applies when multiple chests are in range of a single entity. A chest with only Coal will defer supply priveledges to a chest with Rocket Fuel if both are in range of the same car.",
        {style_mods = {single_line = false}}
    )
}
infoMain.temps.featsUpgrading = {
    alGui.label(
        "After the Ammo Loader: Upgrade research is completed, Loader Chests will be able to upgrade ammo and fuel that has already been supplied to an entity. This is useful, for example, when you have a turret perimeter of 1000 turrets full of Firearm Magazines, and you'd like to upgrade them to Piercing Rounds Magazines without waiting for them to use up the rest of their ammo.\n\nThe Loader Chest will try to put the old ammo/fuel into the Loader Chest it came from if possible. Failing this, it will follow the Ammo/Fuel Return Rules (see below) until it finds somewhere to put the inferior ammo/fuel. If no place can be found, the Loader Chest will wait for some time before trying again. For this reason, it is wise to always have extra space available in Ammo Loader Storage Chests.\n",
        {style_mods = {single_line = false}}
    ),
    alGui.label(
        "This functionality must be enabled in the per-map mod settings (Upgrade ammo/fuel).",
        {style_mods = {font = "default-bold", single_line = false}}
    )
}
infoMain.temps.featsReturning = {
    alGui.label(
        "Once the Ammo Loader: Return Items research is completed, Loader Chests and Loader Storage Chests will take extra ammo and fuel recieved when the player picks up an entity. This is useful for keeping the player's inventory clear of unwanted items.\n\nFor example, when the player picks up a car that has some fuel, the fuel is returned to any available Loader Chests in range before going to the player's inventory. The Loader Chest can then re-insert the fuel whenever the player places back down the car, eliminating the need for manual insertion of fuel altogether.\n",
        multiLineMod
    ),
    alGui.label(
        "This functionality must be enabled in the per-map mod settings (Return items on pickup).",
        {style_mods = {font = "default-bold", single_line = false}}
    )
}
infoMain.page = function()
    return {
        type = "frame",
        style = "inside_shallow_frame_with_padding",
        save_as = "info_pages_main",
        direction = "vertical",
        name = "algui_info_main_page",
        children = {
            alGui.label(
                "Ammo Loader+ is a mod designed to make loading ammo turrets and fuel burning structures easier. For example, it allows you to expand turret perimeters or create ammo turret defended outposts without having to run a whole new belt line just for ammo.",
                {style = "menu_message", style_mods = {single_line = false}}
            ),
            alGui.label(
                "Features Overview",
                {style = "heading_1_label", style_mods = {top_margin = 15, bottom_margin = 10}}
            ),
            infoMain.temps.featButton("ammo_loading", "Automatic Ammo Loading", infoMain.temps.featsAmmoLoading),
            infoMain.temps.featButton("fuel_loading", "Automatic Fuel Loading", infoMain.temps.featsFuelLoading),
            infoMain.temps.featButton("smart_selection", "Smart Ammo/Fuel Selection", infoMain.temps.featsSmartLoading),
            infoMain.temps.featButton("upgrading", "Ammo/Fuel Upgrading", infoMain.temps.featsUpgrading),
            infoMain.temps.featButton("returning", "Ammo/Fuel Return", infoMain.temps.featsReturning)
        }
    }
end

alGui.toggleButton = {
    funcs = {
        ---@param button LuaGuiElement
        getFrame = function(button)
            if (not isValid(button)) then
                return
            end
            -- "([%w%d%-%_]+)"
            local butName = button.name
            butName = butName:gsub("button", "but")
            local frameName = butName .. "_frame"
            local sib = alGui.templates.getSiblingWithName(button, frameName, false)
            if (not isValid(sib)) then
                cInform("Toggle failed: could not find toggle frame.")
                return
            end
            return sib
        end,
        toggle = function(button)
            local elem = alGui.toggleButton.funcs.getFrame(button)
            if (not elem) then
                return
            end
            cInform("toggleButton toggling...")
            if (elem.visible) then
                elem.visible = false
            else
                elem.visible = true
            end
        end
    },
    temps = {}
}
local toggleBut = alGui.toggleButton
local togButFuncs = toggleBut.funcs
-- infoTemps.ranks = {}
-- infoRanks = infoTemps.ranks

alGui.infoRanks = {
    funcs = {},
    templates = {}
}
-- alGui.infoRanks = infoRanks
-- alGui.infoRanks.funcs = infoRankFuncs
-- alGui.infoRanks.templates = infoRankTemps
local infoRanks = alGui.infoRanks
local infoRankFuncs = alGui.infoRanks.funcs
local infoRankTemps = alGui.infoRanks.templates

function infoRankFuncs.swapItemRank(item, newRank)
    cInform("swapping item ranks")
    local itemObj = itemInfo(item)
    local oldRank = itemObj.rank
    local catRanks = ItemDB.category(itemObj.category)
    local replaceItemObj = itemInfo(catRanks[newRank])
    if (itemObj) and (replaceItemObj) and (newRank ~= oldRank) and (newRank <= #catRanks) and (newRank >= 1) then
        catRanks[oldRank] = catRanks[newRank]
        catRanks[newRank] = itemObj.name
        itemObj.rank = newRank
        replaceItemObj.rank = oldRank
    -- ItemDB.updateRanks(itemObj.category)
    end
end
function infoRankFuncs.refreshRanks(elem)
    -- cat .. "__algui_container__category_table"
    local container = alGui.templates.getAncestorWithName(elem, "(%_%_algui%_container%_%_category%_table)")
    if (not container) then
        return
    end
    local catName = container.name:match("([%w%_%-%d]+)%_%_algui")
    cInform("refreshing ranks: ", catName)
    local itemElems = alGui.infoRanks.templates.catItems(catName)
    container.clear()
    for ind, elemTemp in pairs(itemElems) do
        if (elemTemp.name) and (isValid(container[elemTemp.name])) then
            container[elemTemp.name].destroy()
        end
        alGui.build(container, elemTemp)
    end
end

function infoRankFuncs.selectedCatContent()
    local rankWin = alGui.windowObject("infoRank")
    if (not rankWin) or (not rankWin.cat_types) or (not rankWin.cat_types.selected_tab_index) then
        return
    end
    local selectedTypeInfo = rankWin.cat_types.tabs[rankWin.cat_types.selected_tab_index]
    if (not selectedTypeInfo) or (not isValid(selectedTypeInfo.content)) then
        return
    end
    local catTabs = selectedTypeInfo.content
    if (not catTabs.selected_tab_index) then
        return
    end
    local container = catTabs.tabs[catTabs.selected_tab_index].content
    if (not isValid(container)) then
        return
    end
    return container
end

infoRankTemps.page = function()
    return {
        type = "scroll-pane",
        -- style = "inside_shallow_frame_with_padding",
        save_as = "info_pages_ranks",
        style_mods = {vertically_squashable = true, vertically_stretchable = true, natural_height = 500},
        -- direction = "vertical",
        -- children = {func = infoTemps.ranks.allCats}
        name = "algui_info_ranks_page",
        children = {
            {
                type = "tabbed-pane",
                save_as = "cat_types",
                style_mods = {horizontally_stretchable = true},
                children = {
                    {type = "tab", save_as = "ammo_tab", caption = "Ammo"},
                    {type = "tab", save_as = "fuel_tab", caption = "Fuel"},
                    {template = "infoRanks.templates.cats", args = {"ammo"}},
                    {template = "infoRanks.templates.cats", args = {"fuel"}}
                }
            }
        }
    }
end

infoRankTemps.cats = function(catType)
    local res = {
        type = "tabbed-pane",
        style = "frame_tabbed_pane",
        style_mods = {horizontally_stretchable = true},
        save_as = catType .. "_content",
        children = {}
    }

    local cats = {}
    if (catType == "ammo") then
        cats = ItemDB.ammoCats()
    elseif (catType == "fuel") then
        cats = ItemDB.fuelCats()
    end
    for catName, cat in pairs(cats) do
        -- serpLog("catName: " .. catName)
        local catElems = infoRankTemps.cat(catName)
        res.children = Array.merge(res.children, catElems)
    end
    return res
end
infoRankTemps.cat = function(cat)
    local tab = {type = "tab", caption = cat, save_as = cat .. "_tab", name = cat .. "_tab"}
    local content = {
        type = "flow",
        caption = cat,
        direction = "horizontal",
        save_as = cat .. "_content",
        name = cat .. "_content",
        style_mods = {vertically_stretchable = true, padding = 10},
        children = {
            {
                type = "table",
                column_count = 4,
                name = cat .. "__algui_container__category_table",
                save_as = cat .. "_table",
                -- tooltip = tooltip,
                draw_horizontal_lines = true,
                -- draw_horizontal_line_after_headers = true,
                -- draw_vertical_lines = true,
                vertical_centering = true,
                direction = "horizontal",
                style_mods = {
                    horizontal_spacing = 10,
                    vertical_spacing = 10
                    -- vertical_align = "center",
                    -- horizontal_align = "center"
                },
                children = infoRankTemps.catItems(cat)
            },
            -- {
            --     type = "flow",
            --     style_mods = {
            --         horizontal_align = "right",
            --         horizontally_stretchable = false,
            --         horizontally_squashable = true,
            --         natural_width = 40
            --     }
            -- },
            {
                type = "button",
                caption = "Reset to Default",
                enabled = false,
                -- handlers = "resetItemRanksButton",
                name = cat .. "__algui_button__category_reset",
                save_as = cat .. "_resetButton",
                style_mods = {left_margin = 50}
            }
        }
    }
    return {tab, content}
end
infoRankTemps.catItems = function(cat)
    local itemElems = {}
    local ranks = ItemDB.cat(cat)
    for rank, itemName in pairs(ranks) do
        local itemComponents = infoRankTemps.item(itemName)
        for i, itemComponent in pairs(itemComponents) do
            table.insert(itemElems, itemComponent)
        end
    end
    return itemElems
end

function infoRankFuncs.itemTooltip(name)
    local info = itemInfo(name)
    if (not info) then
        return
    end
    local tooltip = ""
    local dmgEffects = ItemDB.getDamageEffects(name)
    if (not dmgEffects) then
        return
    end
    local dirDmg = 0
    local dirDmgStr = "Direct Damage:\n"
    local aoeDmg = 0
    local aoeDmgStr = "AOE Damage:\n"
    local typeDmg = {}
    for i, effect in pairs(dmgEffects) do
        if (not typeDmg[effect.type]) then
            typeDmg[effect.type] = 0
        end
        typeDmg[effect.type] = typeDmg[effect.type] + effect.amount
        if (not effect.radius) then
            dirDmg = dirDmg + effect.amount
            dirDmgStr = dirDmgStr .. effect.amount .. " " .. effect.type .. "\n"
        else
            aoeDmg = aoeDmg + effect.amount
            aoeDmgStr = aoeDmgStr .. effect.amount .. " " .. effect.type .. " (radius " .. effect.radius .. ")\n"
        end
    end
    dirDmgTotalStr = "\nDirect Damage Total: " .. dirDmg
    aoeDmgTotalStr = "\nAOE Damage Total: " .. aoeDmg
    subtotalStr = "\nDamage Subtotal: " .. dirDmg + aoeDmg
    scoreStr = "\nFinal Score (weighted): " .. info.score
    tooltip = dirDmgStr .. "\n" .. aoeDmgStr .. dirDmgTotalStr .. aoeDmgTotalStr .. subtotalStr .. scoreStr .. "\n"
    -- local typeDmgStr = "By Type: \n"
    -- for typeName, dmg in pairs(typeDmg) do
    --     typeDmgStr = typeDmgStr .. typeName .. ": " .. dmg .. "\n"
    -- end
    -- tooltip = tooltip .. typeDmgStr
    return tooltip
end

infoRankTemps.item = function(name)
    local tooltip = infoRankFuncs.itemTooltip(name)
    local info = itemInfo(name)
    return {
        {type = "label", save_as = name .. "_rank", caption = tostring(info.rank)},
        -- alGui.label(tostring(info.rank) {save_as = name .. "_rank"}),
        {type = "sprite-button", sprite = "item/" .. name, tooltip = tooltip, save_as = name .. "_icon"},
        -- alGui.label({"item-name." .. name}, {tooltip = tooltip, save_as = name .. "_name"}),
        {type = "label", caption = {"item-name." .. name}, tooltip = tooltip, save_as = name .. "_name"},
        infoRankTemps.itemMoveButs(name)
    }
end
infoRankTemps.itemMoveButs = function(item)
    return {
        type = "flow",
        direction = "vertical",
        name = item .. "__algui_container__single_item",
        save_as = item .. "_move_buttons",
        children = {
            {
                type = "button",
                caption = "▲",
                -- handlers = "itemRankUp",
                name = item .. "__algui_button__rank_up",
                save_as = item .. "_rank_up",
                style_mods = {vertically_squashable = true, height = 18}
            },
            {
                type = "button",
                caption = "▼",
                -- handlers = "itemRankDown",
                name = item .. "__algui_button__rank_down",
                save_as = item .. "_rank_down",
                style_mods = {vertically_squashable = true, height = 18}
            }
        }
    }
end
