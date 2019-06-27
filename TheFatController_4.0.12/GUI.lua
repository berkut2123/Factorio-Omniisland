function endsWith(String, End)
    return End == "" or string.sub(String, -string.len(End)) == End
end

function sanitizeNumber(number, default)
    return tonumber(number) or default
end

function start_following(carriage, guiSettings, element, player)
    --log("start_following")
    local _, err = pcall(function()
        if guiSettings.followGui and guiSettings.followGui.valid then
            guiSettings.followGui.caption = {"text-controlbutton"}
            guiSettings.followGui.style = "fatcontroller_page_button"
        end
        element.style = "fatcontroller_page_button_selected"
        element.caption = {"text-followbutton"}
        guiSettings.followEntity = carriage
        guiSettings.followGui = element
        if not guiSettings.fatControllerButtons.returnToPlayer then
            guiSettings.fatControllerButtons.add({type = "sprite-button", sprite = "fat_return_to_player", name = "returnToPlayer", style = "fatcontroller_main_button_style"})
        end
        carriage.set_driver(player.character)
        if player.gui.left.farl ~= nil then
            player.gui.left.farl.destroy()
        end
    end)
    if err then
        player.print("Remote controlling currently not possible, requires a Factorio bugfix.")
        return false
    end
    return true
end

function stop_following(guiSettings)
    --log("stop_following")
    guiSettings.followEntity = nil
    if guiSettings.followGui and guiSettings.followGui.valid then
        guiSettings.followGui.caption = {"text-controlbutton"}
        guiSettings.followGui.style = "fatcontroller_page_button"
        guiSettings.followGui = nil
    end
    if guiSettings.fatControllerButtons ~= nil and guiSettings.fatControllerButtons.returnToPlayer ~= nil then
        guiSettings.fatControllerButtons.returnToPlayer.destroy()
    end
end

on_gui_click = {}
GUI = {
    valid = function(element)
        return (element and element.valid) and element
    end,
    revalidate = function(player)
        local guiSettings = global.gui[player.index]
        if GUI.valid(guiSettings.fatControllerGui) and GUI.valid(guiSettings.fatControllerButtons) then
            return
        end
        local init = false
        local player_gui = player.gui
        if not GUI.valid(guiSettings.fatControllerGui) then
            if GUI.valid(player_gui.left.fatController) then
                log("Fixing fatControllerGui")
                guiSettings.fatControllerGui = player_gui.left.fatController
            else
                init = true
            end
        end
        if not GUI.valid(guiSettings.fatControllerButtons) then
            if GUI.valid(player_gui.top.fatControllerButtons) then
                log("Fixing fatControllerButtons")
                guiSettings.fatControllerButtons = player_gui.top.fatControllerButtons
            else
                init = true
            end
        end
        if init and global.unlockedByForce[player.force.name] then
            log("Fixing gui")
            GUI.init_gui(player, true)
            init = true
        end
        return init
    end,
    sanitizeName = function(name)
        return (name:gsub("^%s*(.-)%s*$", "%1"))
    end,
    get_page_button_style = function(direction, current_page, page_count)
        if direction == "back" then
            return current_page > 1 and "fatcontroller_page_button" or "fatcontroller_page_button"
        else
            return current_page < page_count and "fatcontroller_page_button" or "fatcontroller_page_button"
        end
    end,
    new_train_window = function(gui, trainInfo, guiSettings)
        if gui[trainInfo.guiName] == nil then
            gui.add({type = "frame", name = trainInfo.guiName, direction = "horizontal", style = "fatcontroller_thin_frame"})
        end
        local trainGui = gui[trainInfo.guiName]

        --Add buttons
        if trainGui.buttons == nil then
            trainGui.add({type = "flow", name = "buttons", direction = "horizontal", style = "fatcontroller_traininfo_button_flow_horizontal"})
        end

        if guiSettings.indicators then
            local indicator = trainGui.buttons.indicator or trainGui.buttons.add {type = "progressbar", name = "indicator", value = 1, style = "fatcontroller_indicator_style"}
            local t = trainInfo.train.locomotives.front_movers and trainInfo.train.locomotives.front_movers[1]
            t = t or trainInfo.train.locomotives.back_movers and trainInfo.train.locomotives.back_movers[1]
            indicator.style.color = t.color or game.entity_prototypes[t.name].color
        end

        if trainGui.buttons[trainInfo.guiName .. "_toggleManualMode"] == nil then
            trainGui.buttons.add({type = "button", name = trainInfo.guiName .. "_toggleManualMode", caption = "", style = "fatcontroller_page_button", tooltip = {"fat_tooltip_toggle_mode"}})
            local caption = trainInfo.train.manual_mode and ">" or "ll"
            trainGui.buttons[trainInfo.guiName .. "_toggleManualMode"].caption = caption
        end

        if trainInfo.train.manual_mode then
            trainGui.buttons[trainInfo.guiName .. "_toggleManualMode"].caption = ">"
        else
            trainGui.buttons[trainInfo.guiName .. "_toggleManualMode"].caption = "ll"
        end

        if trainGui.buttons[trainInfo.guiName .. "_toggleFollowMode"] == nil then
            trainGui.buttons.add({
                type = "button",
                name = trainInfo.guiName .. "_toggleFollowMode",
                caption = {"text-controlbutton"},
                style = "fatcontroller_page_button",
                tooltip = {"fat_tooltip_controlbutton"}
            })
        end

        if guiSettings.renameTrains then
            trainGui.buttons.add({type = "button", name = trainInfo.guiName .. "_renameTrain", caption = {"text-renamebutton"}, style = "fatcontroller_page_button", tooltip = {"fat_tooltip_renamebutton"}})
        end

        if trainInfo.alarm.active then
            local alarmButton = trainGui.buttons[trainInfo.guiName .. "_alarmButton"] or trainGui.buttons.add({type = "sprite-button", name = trainInfo.guiName .. "_alarmButton", style = "fatcontroller_sprite_button_style"})
            alarmButton.sprite = "fat_" .. trainInfo.alarm.type
        end

        --Add info
        if trainGui.info == nil then
            trainGui.add({type = "flow", name = "info", direction = "vertical", style = "fatcontroller_thin_flow"})
        end

        if trainGui.info.topInfo == nil then
            trainGui.info.add({type = "label", name = "topInfo", style = "fatcontroller_label_style"})
        end
        local show_name = global.gui[gui.player_index].show_names
        local topString = GUI.get_topstring(trainInfo, show_name)
        --trainGui.info.topInfo.style = show_name and "fatcontroller_label_style_small" or "fatcontroller_label_style"
        trainGui.info.topInfo.caption = topString

        if trainGui.info.bottomInfo == nil then
            trainGui.info.add({type = "label", name = "bottomInfo", style = "fatcontroller_label_style"})
        end

        local bottomString = GUI.get_bottomstring(trainInfo)
        trainGui.info.bottomInfo.caption = bottomString

        trainInfo.last_update = game.tick
        return trainGui
    end,
    get_topstring = function(trainInfo, show_name)
        local topString = ""
        local station = trainInfo.current_station
        local state = defines.train_state
        if not station then
            station = ""
        end
        if trainInfo.last_state then
            if trainInfo.last_state == state.no_path or trainInfo.last_state == state.path_lost then
                topString = {"", {"text-no-path"}}
            elseif trainInfo.last_state == state.no_schedule then
                topString = {"", {"text-no-schedule"}}
            elseif trainInfo.last_state == state.wait_signal then
                topString = {"", {"text-signal"}, " || ", station}
            elseif (trainInfo.last_state == state.manual_control_stop or trainInfo.last_state == state.manual_control) then
                topString = {"", {"text-manual"}, ": "}
                if trainInfo.train.speed == 0 then
                    table.insert(topString, {"text-stopped"})
                else
                    table.insert(topString, {"text-moving"})
                end
            elseif trainInfo.last_state == state.arrive_station then
                topString = {"", {"text-stopping"}, " -> ", station}
            elseif trainInfo.last_state == state.wait_station then
                topString = {"", {"text-station"}, ": ", station}
                --topString = {"", "[item=train-stop]", ": ", station}
                if trainInfo.depart_at and trainInfo.depart_at > 0 then
                    table.insert(topString, "(" .. util.formattime(trainInfo.depart_at - game.tick) .. ")")
                end
            else
                topString = {"", {"text-moving"}, " -> ", station}
            end
        end
        if show_name then
            table.insert(topString, " || " .. trainInfo.name)
        end
        return topString
    end,
    get_bottomstring = function(trainInfo)
        local bottomString = ""
        if trainInfo.inventory ~= nil then
            bottomString = trainInfo.inventory
        end
        return bottomString
    end,
    get_toggleButtonCaption = function(guiSettings, player)
        local caption = (guiSettings.activeFilterList or guiSettings.filter_alarms) and {"text-filtered"} or {"text-all"}
        local count = guiSettings.activeFilterList and guiSettings.automatedCount or TrainList.automatedCount(player.force)
        guiSettings.stopButton_state = count == 0
        if guiSettings.stopButton_state then
            caption = {"", {"text-resume"}, " ", caption}
        else
            caption = {"", {"text-stop"}, " ", caption}
        end
        return caption
    end,
    set_toggleButtonCaption = function(guiSettings, player)
        if guiSettings.fatControllerGui and guiSettings.fatControllerGui.trainInfo then
            local caption = GUI.get_toggleButtonCaption(guiSettings, player)
            guiSettings.fatControllerGui.trainInfo.trainInfoControls.control.toggleButton.caption = caption
        end
    end,
    update_single_traininfo = function(trainInfo, update_cargo)
        if trainInfo then
            if trainInfo.train and not trainInfo.train.valid then
                TrainList.remove_invalid(trainInfo.force)
                return
            end
            local cargo_updated = false
            local alarm = trainInfo.alarm.active and trainInfo.alarm.type or false
            for _, gui in pairs(trainInfo.opened_guis) do
                if gui and gui.valid then
                    if alarm then
                        local alarmButton = gui.buttons[trainInfo.guiName .. "_alarmButton"] or gui.buttons.add({type = "sprite-button", name = trainInfo.guiName .. "_alarmButton", style = "fatcontroller_sprite_button_style"})
                        alarmButton.sprite = "fat_" .. trainInfo.alarm.type
                    else
                        if gui.buttons[trainInfo.guiName .. "_alarmButton"] then
                            gui.buttons[trainInfo.guiName .. "_alarmButton"].destroy()
                        end
                    end
                    if update_cargo and not cargo_updated then
                        trainInfo.inventory = getHighestInventoryCount(trainInfo)
                        cargo_updated = true
                    end

                    if gui.buttons.indicator then
                        local t = trainInfo.train.locomotives.front_movers and trainInfo.train.locomotives.front_movers[1]
                        t = t or trainInfo.train.locomotives.back_movers and trainInfo.train.locomotives.back_movers[1]
                        gui.buttons.indicator.style.color = t.color or game.entity_prototypes[t.name].color
                    end

                    local show_name = global.gui[gui.player_index].show_names
                    --gui.info.topInfo.style = show_name and "fatcontroller_label_style_small" or "fatcontroller_label_style"
                    gui.info.topInfo.caption = GUI.get_topstring(trainInfo, show_name)

                    gui.info.bottomInfo.caption = GUI.get_bottomstring(trainInfo)

                    if trainInfo.train.manual_mode then
                        gui.buttons[trainInfo.guiName .. "_toggleManualMode"].caption = ">"
                    else
                        gui.buttons[trainInfo.guiName .. "_toggleManualMode"].caption = "ll"
                    end
                end
            end
        end
    end,
    swapCaption = function(guiElement, captionA, captionB)
        if guiElement ~= nil and captionA ~= nil and captionB ~= nil then
            if guiElement.caption == captionA then
                guiElement.caption = captionB
            elseif guiElement.caption == captionB then
                guiElement.caption = captionA
            end
        end
    end,
    --refreshAllTrainInfoGuis = function(trainsByForce, guiSettings, players, destroy)
    refreshAllTrainInfoGuis = function(force)
        --debugDump(game.tick.." refresh",true)
        update_pageCount(force)
        for _, player in pairs(force.players) do
            local gui = global.gui[player.index]
            if gui.page > gui.pageCount then
                gui.page = gui.pageCount
            end
            gui.page = gui.page > 0 and gui.page or 1
            --debugDump(gui.page, true)
            if gui ~= nil and gui.fatControllerGui.trainInfo ~= nil then
                gui.fatControllerGui.trainInfo.destroy()
                if player.connected then
                    GUI.newTrainInfoWindow(gui, player)
                    gui.filtered_trains = TrainList.get_filtered_trains(player.force, gui)
                    GUI.refreshTrainInfoGui(gui, player)
                end
            end
        end
    end,
    init_gui = function(player, force)
        --debugDump("Init: " .. player.name .. " - " .. player.force.name,true)
        if not force and GUI.valid(player.gui.top.fatControllerButtons) and GUI.valid(player.gui.left.fatController) then
            return
        end

        local player_gui = global.gui[player.index]

        if not GUI.valid(player.gui.left.fatController) then
            player_gui.fatControllerGui = player.gui.left.add {type = "flow", name = "fatController", direction = "vertical", style = "fatcontroller_main_flow_vertical"} --caption="Fat Controller",
        else
            player_gui.fatControllerGui = player.gui.left.fatController
        end
        if not GUI.valid(player.gui.top.fatControllerButtons) then
            player_gui.fatControllerButtons = player.gui.top.add({type = "flow", name = "fatControllerButtons", direction = "horizontal", style = "fatcontroller_main_flow_horizontal"})
        else
            player_gui.fatControllerButtons = player.gui.top.fatControllerButtons
        end
        if not GUI.valid(player_gui.fatControllerButtons.toggleTrainInfo) then
            player_gui.fatControllerButtons.add({type = "sprite-button", sprite = "item/locomotive", name = "toggleTrainInfo", style = "fatcontroller_main_button_style"})
        end

        if GUI.valid(player_gui.fatControllerGui.trainInfo) then
            GUI.newTrainInfoWindow(player_gui, player)
        end

        player_gui.pageCount = getPageCount(player_gui, player)

        return player_gui
    end,
    refresh_gui = function(gui)
        if gui.fatControllerButtons and gui.fatControllerButtons.valid then
            gui.fatControllerButtons.style = "fatcontroller_top_flow"
            if gui.fatControllerButtons.toggleTrainInfo and gui.fatControllerButtons.toggleTrainInfo.valid then
                gui.fatControllerButtons.toggleTrainInfo.destroy()
                gui.fatControllerButtons.add({type = "sprite-button", sprite = "item/locomotive", name = "toggleTrainInfo", style = "fatcontroller_main_button_style"})
            end
            if gui.fatControllerButtons.returnToPlayer and gui.fatControllerButtons.returnToPlayer.valid then
                gui.fatControllerButtons.returnToPlayer.destroy()
                gui.fatControllerButtons.add({type = "sprite-button", sprite = "fat_return_to_player", name = "returnToPlayer", style = "fatcontroller_main_button_style"})
            end
            if gui.fatControllerGui and gui.fatControllerGui.valid then
                gui.fatControllerGui.style = "fatcontroller_main_flow_vertical"
            end
        end
    end,
    onguiclick = function(event)
        local _, err = pcall(function()
            if event.element.type == "checkbox" then
                return
            end
            local refreshGui = false
            local player_index = event.element.player_index
            local guiSettings = global.gui[player_index]
            local player = game.get_player(player_index)
            if not player.connected then
                return
            end
            --debugDump("CLICK! " .. event.element.name .. game.tick,true)
            --log(serpent.block({guiSettings.fatControllerGui, guiSettings.fatControllerGui.valid}))

            if GUI.revalidate(player) then
                return
            end

            if on_gui_click[event.element.name] then
                --log("click end: ")
                --log("click: " .. event.element.name)
                refreshGui = on_gui_click[event.element.name](guiSettings, event.element, player)
            elseif endsWith(event.element.name, "_toggleManualMode") then
                refreshGui = on_gui_click.toggleManualMode(guiSettings, event.element, player)
            elseif endsWith(event.element.name, "_toggleFollowMode") then
                refreshGui = on_gui_click.toggleFollowMode(guiSettings, event.element, player)
            elseif endsWith(event.element.name, "_alarmButton") then
                refreshGui = on_gui_click.unsetAlarm(guiSettings, event.element, player)
            elseif endsWith(event.element.name, "_renameTrain") then
                refreshGui = on_gui_click.renameTrain(guiSettings, event.element, player)
            end

            if refreshGui then
                GUI.newTrainInfoWindow(guiSettings, player)
                GUI.refreshTrainInfoGui(guiSettings, player)
            end
        end)
        if err then
            debugDump(err, true)
            log(serpent.dump(err))
        end
    end,
    on_gui_checked_state_changed = function(event)
        local _, err = pcall(function()
            if event.element.type ~= "checkbox" then
                return
            end
            local refreshGui = false
            local player_index = event.element.player_index
            local guiSettings = global.gui[player_index]
            local player = game.players[player_index]
            if not player.connected then
                return
            end
            --debugDump("CLICK! " .. event.element.name .. game.tick,true)

            if on_gui_click[event.element.name] then
                --log("checked end: ")
                --log("checked: " .. event.element.name)
                refreshGui = on_gui_click[event.element.name](guiSettings, event.element, player)
            elseif endsWith(event.element.name, "_stationFilter") then
                refreshGui = on_gui_click.stationFilter(guiSettings, event.element, player)
            end

            if refreshGui then
                GUI.newTrainInfoWindow(guiSettings, player)
                GUI.refreshTrainInfoGui(guiSettings, player)
            end
        end)
        if err then
            debugDump(err, true)
            log(serpent.dump(err))
        end
    end,
    -- control buttons only
    newTrainInfoWindow = function(guiSettings, player)
        local gui = guiSettings.fatControllerGui
        local newGui
        if gui ~= nil and gui.trainInfo ~= nil then
            gui.trainInfo.destroy()
        end

        if gui ~= nil and gui.trainInfo ~= nil then
            newGui = gui.trainInfo
            debugDump("foo", true)
        else
            newGui = gui.add({type = "flow", name = "trainInfo", direction = "vertical", style = "fatcontroller_main_flow_vertical"})
        end

        if newGui.trainInfoControls == nil then
            newGui.add({type = "frame", name = "trainInfoControls", direction = "horizontal", style = "fatcontroller_thin_frame"})
        end

        if newGui.trainInfoControls.pageButtons == nil then
            newGui.trainInfoControls.add({type = "flow", name = "pageButtons", direction = "horizontal", style = "fatcontroller_button_flow_horizontal"})
        end

        if newGui.trainInfoControls.pageButtons.page_back == nil then
            local pb = newGui.trainInfoControls.pageButtons.add({type = "button", name = "page_back", caption = "<", style = "fatcontroller_page_button"})
            pb.enabled = guiSettings.page > 1
        end

        local caption = guiSettings.page .. "/" .. guiSettings.pageCount
        if newGui.trainInfoControls.pageButtons.page_number == nil then
            newGui.trainInfoControls.pageButtons.add({type = "button", name = "page_number", caption = caption, style = "fatcontroller_pagenumber_button", tooltip = {"fat_tooltip_displayed_trains"}})
        else
            newGui.trainInfoControls.pageButtons.page_number.caption = caption
        end

        if newGui.trainInfoControls.pageButtons.page_forward == nil then
            local pb = newGui.trainInfoControls.pageButtons.add({
                type = "button",
                name = "page_forward",
                caption = ">",
                style = "fatcontroller_page_button"
            })
            pb.enabled = guiSettings.page < guiSettings.pageCount
        end

        if newGui.trainInfoControls.filterButtons == nil then
            newGui.trainInfoControls.add({type = "flow", name = "filterButtons", direction = "horizontal", style = "fatcontroller_button_flow_horizontal"})
        end

        if newGui.trainInfoControls.filterButtons.toggleStationFilter == nil then
            local style = (guiSettings.activeFilterList or guiSettings.filter_alarms) and "fatcontroller_page_button_selected" or "fatcontroller_page_button"
            newGui.trainInfoControls.filterButtons.add({type = "button", name = "toggleStationFilter", caption = {"text-filter-trains"}, style = style, tooltip = {"fat_tooltip_filterbutton"}})
        end

        if newGui.trainInfoControls.filterButtons.clearStationFilter == nil then
            newGui.trainInfoControls.filterButtons.add({
                type = "button",
                name = "clearStationFilter",
                caption = {"text-clear-filter"},
                style = "fatcontroller_page_button",
                tooltip = {"fat_tooltip_clearFilters"}
            })
        end

        if newGui.trainInfoControls.alarm == nil then
            newGui.trainInfoControls.add({type = "flow", name = "alarm", direction = "horizontal", style = "fatcontroller_button_flow_horizontal"})
        end

        if newGui.trainInfoControls.alarm.alarmButton == nil then
            newGui.trainInfoControls.alarm.add({type = "button", name = "alarmButton", caption = {"text-alarmSettings"}, style = "fatcontroller_page_button", tooltip = {"fat_tooltip_alarms"}})
        end

        if newGui.trainInfoControls.control == nil then
            newGui.trainInfoControls.add({type = "flow", name = "control", direction = "horizontal", style = "fatcontroller_button_flow_horizontal"})
        end

        if newGui.trainInfoControls.control.toggleButton == nil then
            newGui.trainInfoControls.control.add({
                type = "button",
                name = "toggleButton",
                caption = GUI.get_toggleButtonCaption(guiSettings, player),
                style = "fatcontroller_button_style",
                tooltip = {"fat_tooltip_stop_all"}
            })
        end

        return newGui
    end,
    refreshTrainInfoGui = function(guiSettings, player)
        if not player.connected then return end
        local character = player.character
        local gui = (guiSettings.fatControllerGui and guiSettings.fatControllerGui.valid) and guiSettings.fatControllerGui.trainInfo
        local trains = (guiSettings.activeFilterList or guiSettings.filter_alarms) and guiSettings.filtered_trains or global.trainsByForce[player.force.name]
        if guiSettings.page > guiSettings.pageCount then
            guiSettings.page = guiSettings.pageCount
        end
        guiSettings.page = guiSettings.page > 0 and guiSettings.page or 1
        if gui ~= nil and gui.valid and trains ~= nil then
            --local pageStart = ((guiSettings.page - 1) * guiSettings.displayCount) + 1
            local pageStart = ((guiSettings.page - 1) * guiSettings.displayCount) + 1
            local remove_invalid = false
            GUI.reset_displayed_trains(guiSettings, player)
            --debugDump({pageStart,pageStart+guiSettings.displayCount-1},true)
            for index = pageStart, pageStart + guiSettings.displayCount - 1 do
                local trainInfo = trains[index]
                if trainInfo and trainInfo.train and trainInfo.train.valid then
                    if trainInfo.train ~= global.trainsByForce[player.force.name][trainInfo.mainIndex].train then
                        player.print("Invalid main index: " .. trainInfo.mainIndex)
                        player.print("Opening and closing the gui should fix it")
                        remove_invalid = true
                    end
                    local i = trainInfo.mainIndex
                    local newGuiName = "Info" .. i
                    if gui[newGuiName] == nil then
                        trainInfo.guiName = newGuiName
                        guiSettings.displayed_trains[i] = trainInfo
                        local trainGui = GUI.new_train_window(gui, trainInfo, guiSettings)
                        trainInfo.opened_guis[player.index] = trainGui
                    end
                    if character ~= nil and character.name == "fatcontroller"
                        and ((character.vehicle.type == "cargo-wagon" or character.vehicle.type == "locomotive") and trainInfo.train == character.vehicle.train)
                    then
                        gui[newGuiName].buttons[newGuiName .. "_toggleFollowMode"].style = "fatcontroller_page_button_selected"
                        gui[newGuiName].buttons[newGuiName .. "_toggleFollowMode"].caption = {"text-followbutton"}
                    else
                        gui[newGuiName].buttons[newGuiName .. "_toggleFollowMode"].style = "fatcontroller_page_button"
                        gui[newGuiName].buttons[newGuiName .. "_toggleFollowMode"].caption = {"text-controlbutton"}
                    end
                    trainInfo.guiName = newGuiName
                end
            end
            if remove_invalid then
                TrainList.remove_invalid(player.force)
            end
        end
    end,
    toggleStationFilterWindow = function(gui, guiSettings, player)
        if gui ~= nil then
            if gui.stationFilterWindow == nil then
                --local sortedList = table.sort(a)
                local window = gui.add({type = "frame", name = "stationFilterWindow", caption = {"msg-stationFilter"}, direction = "vertical", style = "fatcontroller_thin_frame"})
                window.add({type = "flow", name = "buttonFlow"})

                local pageFlow
                if window.buttonFlow.filter_pageButtons == nil then
                    pageFlow = window.buttonFlow.add({type = "flow", name = "filter_pageButtons", direction = "horizontal", style = "fatcontroller_button_flow_horizontal"})
                else
                    pageFlow = window.buttonFlow.filter_pageButtons
                end

                if pageFlow.filter_page_back == nil then
                    local pb = pageFlow.add({type = "button", name = "filter_page_back", caption = "<", style = "fatcontroller_page_button"})
                    pb.enabled = guiSettings.filter_page > 1
                end
                local pageCount = get_filter_PageCount(player.force)
                if pageFlow.filter_page_number == nil then
                    pageFlow.add({type = "button", name = "filter_page_number", enabled = false, caption = guiSettings.filter_page .. "/" .. pageCount, style = "fatcontroller_pagenumber_button"})
                else
                    pageFlow.filter_page_number.caption = guiSettings.filter_page .. "/" .. pageCount
                end

                if pageFlow.filter_page_forward == nil then
                    local pb = pageFlow.add({type = "button", name = "filter_page_forward", caption = ">", style = "fatcontroller_page_button"})
                    pb.enabled = guiSettings.filter_page < pageCount
                end
                window.buttonFlow.add({type = "button", name = "stationFilterClear", caption = {"msg-Clear"}, style = "fatcontroller_button_style", tooltip = {"fat_tooltip_clearFilters"}})
                window.buttonFlow.add({type = "button", name = "stationFilterOK", caption = {"msg-OK"}, style = "fatcontroller_button_style"})
                local style = guiSettings.filter_alarms and "fatcontroller_selected_button" or "fatcontroller_button_style"
                pageFlow.add({type = "button", name = "filterAlarms", caption = {"text-alarms"}, style = style, tooltip = {"fat_tooltip_filterAlarms"}})

                local buttonflow2 = window.add({type = "flow", name = "buttonflow2"})
                local caption = guiSettings.filterModeOr and {"text-filter-or"} or {"text-filter-and"}
                buttonflow2.add({type = "button", name = "toggleFilterMode", caption = caption, style = "fatcontroller_button_style", tooltip = {"fat_tooltip_combine"}})

                window.add({type = "table", name = "checkboxGroup", column_count = 3})
                local i = 0
                local upper = guiSettings.filter_page * global.PAGE_SIZE
                local lower = guiSettings.filter_page * global.PAGE_SIZE - global.PAGE_SIZE
                for name, _ in pairsByKeys(global.station_count[player.force.name]) do
                    if i >= lower and i < upper then
                        local state = false
                        if guiSettings.activeFilterList and guiSettings.activeFilterList[name] then
                            state = true
                        end
                        window.checkboxGroup.add({type = "checkbox", name = name .. "_stationFilter", caption = name, state = state}) --style="filter_group_button_style"})
                    end
                    i = i + 1
                end
            else
                gui.stationFilterWindow.destroy()
            end
        end
    end,
    togglePageSelectWindow = function(gui, guiSettings)
        if gui ~= nil then
            if gui.pageSelect == nil then
                local window = gui.add({type = "frame", name = "pageSelect", caption = {"msg-displayCount"}, direction = "vertical"}) --style="fatcontroller_thin_frame"})
                window.add({type = "textfield", name = "pageSelectValue", text = guiSettings.displayCount .. ""})
                window.pageSelectValue.text = guiSettings.displayCount .. ""
                window.add({type = "button", name = "pageSelectOK", caption = {"msg-OK"}})
            else
                gui.pageSelect.destroy()
            end
        end
    end,
    toggleAlarmWindow = function(gui, player_index)
        local guiSettings = global.gui[player_index]
        if gui ~= nil then
            if gui.alarmWindow == nil then
                local window = gui.add({type = "frame", name = "alarmWindow", caption = {"text-alarmwindow"}, direction = "vertical"})
                local stateTimeToStation = true
                if guiSettings.alarm ~= nil and not guiSettings.alarm.timeToStation then
                    stateTimeToStation = false
                end
                local flow1 = window.add({name = "flowStation", type = "flow", direction = "horizontal"})
                flow1.add({type = "checkbox", name = "alarmTimeToStation", caption = {"text-alarmMoreThan"}, state = stateTimeToStation}) --style="filter_group_button_style"})
                local stationDuration = flow1.add({type = "textfield", name = "alarmTimeToStationDuration", style = "fatcontroller_textfield_small"})
                flow1.add({type = "label", caption = {"text-alarmtimetostation"}})
                local stateTimeAtSignal = true
                if guiSettings.alarm ~= nil and not guiSettings.alarm.timeAtSignal then
                    stateTimeAtSignal = false
                end
                local flow2 = window.add({name = "flowSignal", type = "flow", direction = "horizontal"})
                flow2.add({type = "checkbox", name = "alarmTimeAtSignal", caption = {"text-alarmMoreThan"}, state = stateTimeAtSignal}) --style="filter_group_button_style"})
                local signalDuration = flow2.add({type = "textfield", name = "alarmTimeAtSignalDuration", style = "fatcontroller_textfield_small"})
                flow2.add({type = "label", caption = {"text-alarmtimeatsignal"}})
                local stateNoPath = true
                if guiSettings.alarm ~= nil and not guiSettings.alarm.noPath then
                    stateNoPath = false
                end
                window.add({type = "checkbox", name = "alarmNoPath", caption = {"text-alarmtimenopath"}, state = stateNoPath}) --style="filter_group_button_style"})
                local stateNoFuel = true
                if guiSettings.alarm ~= nil and not guiSettings.alarm.noFuel then
                    stateNoFuel = false
                end
                window.add({type = "checkbox", name = "alarmNoFuel", caption = {"text-alarmtimenofuel"}, state = stateNoFuel})
                window.add({type = "checkbox", name = "renameTrains", caption = {"text-rename-trains"}, state = guiSettings.renameTrains})
                window.add({type = "checkbox", name = "showNames", caption = {"text-show-names"}, state = guiSettings.show_names})
                window.add({type = "checkbox", name = "indicators", caption = {"text-indicators"}, state = guiSettings.indicators})

                local flow3 = window.add({name = "flowButtons", type = "flow", direction = "horizontal"})
                flow3.add({type = "button", name = "alarmOK", caption = {"msg-OK"}})
                flow3.add({type = "button", name = "scanStations", caption = "Update stations", tooltip = "Scans the map for trainstops. Only needed if stations are missing in the filter window."})

                stationDuration.text = global.force_settings[game.players[player_index].force.name].stationDuration / 3600
                signalDuration.text = global.force_settings[game.players[player_index].force.name].signalDuration / 3600
            else
                gui.alarmWindow.destroy()
            end
        end
    end,
    reset_displayed_trains = function(guiSettings, player)
        for _, ti in pairs(guiSettings.displayed_trains) do
            if ti then
                ti.opened_guis[player.index] = nil
            end
        end
        guiSettings.displayed_trains = {}
    end
}
on_gui_click.toggleTrainInfo = function(guiSettings, _, player)
    if guiSettings.fatControllerGui.trainInfo == nil then
        return true
    else
        guiSettings.fatControllerGui.trainInfo.destroy()
        GUI.reset_displayed_trains(guiSettings, player)
        return false
    end
end

on_gui_click.returnToPlayer = function(guiSettings, element, player)
    if player.opened then
        player.print("Close the train UI before trying to change follower mode")
        return
    end
    if global.character[element.player_index] ~= nil then
        --local player_index = element.player_index
        if player.vehicle ~= nil then
            --log("before set_driver(nil) " .. serpent.block(element.valid))
            player.vehicle.set_driver(nil)
        --log("after " .. serpent.block(element.valid))
        end
        --log("h3")
        --log(serpent.block(element.valid))
        --swapPlayer(player, global.character[player_index])
        --log("h4")
        --global.character[element.player_index] = nil
        --element.destroy()
        stop_following(guiSettings, player)
    end
end

on_gui_click.page_back = function(guiSettings)
    if guiSettings.page > 1 then
        guiSettings.page = guiSettings.page - 1
        return true
    end
end

on_gui_click.page_forward = function(guiSettings)
    if guiSettings.page < guiSettings.pageCount then
        guiSettings.page = guiSettings.page + 1
        return true
    end
end

on_gui_click.page_number = function(guiSettings, _, player)
    GUI.togglePageSelectWindow(player.gui.center, guiSettings)
end

on_gui_click.pageSelectOK = function(guiSettings, _, player)
    local gui = player.gui.center.pageSelect
    if gui ~= nil then
        local newInt = tonumber(gui.pageSelectValue.text)
        if newInt then
            if newInt < 1 then
                newInt = 1
            elseif newInt > 50 then
                newInt = 50
            end
            guiSettings.displayCount = newInt
            guiSettings.pageCount = getPageCount(guiSettings, player)
        else
            player.print({"msg-notanumber"})
        end
        gui.destroy()
        return true
    end
end

on_gui_click.toggleStationFilter = function(guiSettings, _, player)
    GUI.toggleStationFilterWindow(player.gui.center, guiSettings, player)
end

on_gui_click.stationFilterClear = function(guiSettings, _, player)
    local refresh = false
    if guiSettings.activeFilterList or guiSettings.filter_alarms then
        guiSettings.activeFilterList = nil
        guiSettings.filter_alarms = false
        refresh = true
    end
    if player.gui.center.stationFilterWindow ~= nil then
        player.gui.center.stationFilterWindow.destroy()
    end
    guiSettings.filtered_trains = false
    guiSettings.pageCount = getPageCount(guiSettings, player)
    return refresh
end

on_gui_click.clearStationFilter = function(guiSettings, element, player)
    return on_gui_click.stationFilterClear(guiSettings, element, player)
end

on_gui_click.stationFilterOK = function(guiSettings, _, player)
    local gui = player.gui.center.stationFilterWindow
    if gui ~= nil and gui.checkboxGroup ~= nil then
        local newFilter = {}
        local listEmpty = true
        for station, _ in pairs(global.station_count[player.force.name]) do
            local checkboxA = gui.checkboxGroup[station .. "_stationFilter"]
            if checkboxA ~= nil and checkboxA.state then
                listEmpty = false
                newFilter[station] = true
            end
        end
        if not listEmpty then
            guiSettings.activeFilterList = newFilter
        else
            guiSettings.activeFilterList = nil
        end
        gui.destroy()
        --guiSettings.page = 1
        return true
    end
end

on_gui_click.filter_page_forward = function(guiSettings, _, player)
    if guiSettings.filter_page < get_filter_PageCount(player.force) then
        guiSettings.filter_page = guiSettings.filter_page + 1
        GUI.toggleStationFilterWindow(player.gui.center, guiSettings, player)
        GUI.toggleStationFilterWindow(player.gui.center, guiSettings, player)
    end
end

on_gui_click.filter_page_back = function(guiSettings, _, player)
    if guiSettings.filter_page > 1 then
        guiSettings.filter_page = guiSettings.filter_page - 1
        GUI.toggleStationFilterWindow(player.gui.center, guiSettings, player)
        GUI.toggleStationFilterWindow(player.gui.center, guiSettings, player)
    end
end

on_gui_click.alarmOK = function(_, _, player)
    local gui = player.gui.center
    local station = sanitizeNumber(gui.alarmWindow.flowStation.alarmTimeToStationDuration.text, defaults.stationDuration) * 3600
    local signal = sanitizeNumber(gui.alarmWindow.flowSignal.alarmTimeAtSignalDuration.text, defaults.signalDuration) * 3600
    global.force_settings[player.force.name] = {signalDuration = signal, stationDuration = station}
    --debugDump(global.force_settings[player.force.name],true)
    GUI.toggleAlarmWindow(player.gui.center, player.index)
end

on_gui_click.alarmButton = function(_, _, player)
    GUI.toggleAlarmWindow(player.gui.center, player.index)
end

on_gui_click.alarmTimeToStation = function(guiSettings, element, _)
    guiSettings.alarm.timeToStation = element.state
end

on_gui_click.alarmTimeAtSignal = function(guiSettings, element, _)
    guiSettings.alarm.timeAtSignal = element.state
end

on_gui_click.alarmNoPath = function(guiSettings, element, _)
    guiSettings.alarm.noPath = element.state
end

on_gui_click.alarmNoFuel = function(guiSettings, element, _)
    guiSettings.alarm.noFuel = element.state
end

on_gui_click.toggleButton = function(guiSettings, _, player)
    --run/stop the trains
    local trains = guiSettings.activeFilterList and guiSettings.filtered_trains or global.trainsByForce[player.force.name]
    local requested_state = not guiSettings.stopButton_state
    for _, trainInfo in pairs(trains) do
        if trainInfo.train.valid then
            trainInfo.train.manual_mode = requested_state
        end
    end
    guiSettings.stopButton_state = requested_state
    return true
end

on_gui_click.toggleManualMode = function(_, element, player)
    local trains = global.trainsByForce[player.force.name]
    local option1 = element.name:match("Info(%w+)_")
    option1 = tonumber(option1)
    --debugDump(option1,true)
    local trainInfo = trains[option1]
    if trainInfo ~= nil and trainInfo.train ~= nil and trainInfo.train.valid then
        trainInfo.train.manual_mode = not trainInfo.train.manual_mode
        GUI.update_single_traininfo(trainInfo)
    end
end

on_gui_click.toggleFollowMode = function(guiSettings, element, player)
    if player.opened or player.opened_self then
        player.opened = nil
    --player.print("Close the train UI before trying to change follower mode")
    --return
    end
    local trains = global.trainsByForce[player.force.name]
    local option1 = element.name:match("Info(%w+)_")
    option1 = tonumber(option1)
    local trainInfo = trains[option1]
    --local trainInfo = getTrainInfoFromElementName(trains, element.name)
    if not trainInfo or not trainInfo.train or not trainInfo.train.valid then
        return
    end
    local carriage = trainInfo.train.speed >= 0 and trainInfo.train.locomotives.front_movers[1] or trainInfo.train.locomotives.back_movers[1]
    if not carriage then
        carriage = trainInfo.train.carriages[1]
    end

    if player.surface ~= carriage.surface then
        player.print("Cant't follow a train on a different surface.")
        return
    end

    -- Player is controlling his own character
    if global.character[element.player_index] == nil then
        if carriage.get_driver() ~= nil then
            player.print({"msg-intrain"})
            return
        end
        if player.vehicle then
            player.print("Can't follow a train while already in a vehicle. Please leave the train first.")
            return
        --script.raise_event(getOrLoadSwitchedEvent(), {carriage=player.vehicle})
        end
        global.character[element.player_index] = player.character
        swapPlayer(player, newFatControllerEntity(player))
        if not start_following(carriage, guiSettings, element, player) then
            swapPlayer(player, global.character[element.player_index])
            global.character[element.player_index] = nil
            stop_following(guiSettings)
        end
        return
    end
    --return to player
    if guiSettings.followEntity and guiSettings.followEntity.train == trainInfo.train then
        swapPlayer(player, global.character[element.player_index])
        global.character[element.player_index] = nil
        stop_following(guiSettings, player)
        if player.vehicle and player.vehicle.name == "farl" then
            script.raise_event(defines.events.on_player_driving_changed_state, {tick = game.tick, player_index = player.index, name = defines.events.on_player_driving_changed_state})
        end
        return
    end
    -- switch to another train
    if guiSettings.followEntity then
        if carriage.get_driver() ~= nil then
            player.print({"msg-intrain"})
            return
        end
        local driver = guiSettings.followEntity.get_driver()
        if driver and driver.name == "fatcontroller" then
            guiSettings.followEntity.get_driver().destroy()
        end
        swapPlayer(player, newFatControllerEntity(player))
        guiSettings.followEntity = nil
        if guiSettings.followGui and guiSettings.followGui.valid then
            guiSettings.followGui.caption = {"text-controlbutton"}
            guiSettings.followGui.style = "fatcontroller_page_button"
            guiSettings.followGui = nil
        end
        if not start_following(carriage, guiSettings, element, player) then
            swapPlayer(player, global.character[element.player_index])
            global.character[element.player_index] = nil
            stop_following(guiSettings)
        end
    end
end

on_gui_click.unsetAlarm = function(_, element, player)
    local trains = global.trainsByForce[player.force.name]
    local option1 = element.name:match("Info(%w+)_")
    option1 = tonumber(option1)
    local trainInfo = trains[option1]
    if trainInfo and trainInfo.train and trainInfo.train.valid then
        trainInfo.alarm.active = false
        trainInfo.alarm.type = false
        GUI.update_single_traininfo(trainInfo)
    end
end

on_gui_click.updateFilter = function(guiSettings, player)
    guiSettings.filtered_trains = TrainList.get_filtered_trains(player.force, guiSettings)
    guiSettings.pageCount = getPageCount(guiSettings, player)
end

on_gui_click.stationFilter = function(guiSettings, element, player)
    local stationName = string.gsub(element.name, "_stationFilter", "")
    if element.state then
        if guiSettings.activeFilterList == nil then
            guiSettings.activeFilterList = {}
        end

        guiSettings.activeFilterList[stationName] = true
    elseif guiSettings.activeFilterList ~= nil then
        guiSettings.activeFilterList[stationName] = nil
        if tableIsEmpty(guiSettings.activeFilterList) then
            guiSettings.activeFilterList = nil
        end
    end
    on_gui_click.updateFilter(guiSettings, player)
    return true
end

on_gui_click.toggleFilterMode = function(guiSettings, element, player)
    guiSettings.filterModeOr = not guiSettings.filterModeOr
    element.caption = guiSettings.filterModeOr and {"text-filter-or"} or {"text-filter-and"}
    on_gui_click.updateFilter(guiSettings, player)
    return true
end

on_gui_click.filterAlarms = function(guiSettings, element, player)
    guiSettings.filter_alarms = not guiSettings.filter_alarms
    element.style = guiSettings.filter_alarms and "fatcontroller_selected_button" or "fatcontroller_button_style"
    on_gui_click.updateFilter(guiSettings, player)
    return true
end

on_gui_click.findCharacter = function(guiSettings, _, player)
    local _, err = pcall(function()
        if player.connected then
            if player.character.name == "fatcontroller" then
                if global.character[player.index] and global.character[player.index].name ~= "fatcontroller" then
                    swapPlayer(game.players[player.index], global.character[player.index])
                    global.character[player.index] = nil
                    if guiSettings.fatControllerButtons ~= nil and guiSettings.fatControllerButtons.returnToPlayer ~= nil then
                        guiSettings.fatControllerButtons.returnToPlayer.destroy()
                    end
                    guiSettings.followEntity = nil
                    if guiSettings.followGui and guiSettings.followGui.valid then
                        guiSettings.followGui.caption = {"text-controlbutton"}
                        guiSettings.followGui.style = "fatcontroller_page_button"
                        guiSettings.followGui = nil
                    end
                    TrainList.reset_manual(global.gui[player.index].vehicle)
                    global.gui[player.index].vehicle = false
                end
            end
        end
    end)
    if err then
        debugDump(err, true)
    end
end

on_gui_click.scanStations = function(_, _, _)
    findStations(true, true)
end

on_gui_click.renameTrains = function(guiSettings, element, _)
    guiSettings.renameTrains = element.state
    return guiSettings.fatControllerGui.trainInfo ~= nil
end

on_gui_click.renameTrain = function(guiSettings, element, player)
    local trains = global.trainsByForce[player.force.name]
    local option1 = element.name:match("Info(%w+)_")
    option1 = tonumber(option1)
    local trainInfo = trains[option1]
    local textfield_name = "Info" .. option1 .. "_name"
    guiSettings.renameTrain[option1] = not guiSettings.renameTrain[option1]
    if trainInfo and trainInfo.train and trainInfo.train.valid then
        local flow = element.parent
        if flow and flow.valid then
            if guiSettings.renameTrain[option1] then
                flow.add({type = "textfield", name = textfield_name, text = ""})
                element.style = "fatcontroller_page_button_selected"
            else
                if not flow[textfield_name] then
                    guiSettings.renameTrain[option1] = nil
                    GUI.refreshTrainInfoGui(guiSettings, player)
                    return
                end
                local name = GUI.sanitizeName((flow[textfield_name].text))
                if name ~= "" then
                    for _, locos in pairs(trainInfo.train.locomotives) do
                        for _, loco in pairs(locos) do
                            loco.backer_name = name
                        end
                    end
                    if name:len() > 20 then
                        trainInfo.name = trainInfo.name:sub(1, 20) .. "..."
                    else
                        trainInfo.name = name
                    end
                end
                flow[textfield_name].destroy()
                element.style = "fatcontroller_page_button"
            end
        end
        GUI.update_single_traininfo(trainInfo)
    end
end

on_gui_click.showNames = function(guiSettings, _, _)
    guiSettings.show_names = not guiSettings.show_names
    return guiSettings.fatControllerGui.trainInfo ~= nil
end

on_gui_click.indicators = function(guiSettings, _, _)
    guiSettings.indicators = not guiSettings.indicators
    return guiSettings.fatControllerGui.trainInfo ~= nil
end
