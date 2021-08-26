--LTN code cleaned up by Optera
script.on_init(function()
    if remote.interfaces["logistic-train-network"] then
        script.on_event(remote.call("logistic-train-network", "on_dispatcher_updated"), OnDispatcherUpdated)
        script.on_event(remote.call("logistic-train-network", "on_delivery_completed"), OnDeliveryCompleted)
        script.on_event(remote.call("logistic-train-network", "on_delivery_failed"), OnDeliveryFailed)
    end
end)

script.on_load(function()
    if remote.interfaces["logistic-train-network"] then
        script.on_event(remote.call("logistic-train-network", "on_dispatcher_updated"), OnDispatcherUpdated)
        script.on_event(remote.call("logistic-train-network", "on_delivery_completed"), OnDeliveryCompleted)
        script.on_event(remote.call("logistic-train-network", "on_delivery_failed"), OnDeliveryFailed)
    end
end)

function OnDispatcherUpdated(event)
    global.deliveries = event.deliveries
    global.dispatcher = true
end

function OnDeliveryCompleted(event)
    LTN_unpaint(event.train_id)
end

function OnDeliveryFailed(event)
    LTN_unpaint(event.train_id)
end

function LTN_check(train)
    if global.dispatcher == true then
        local delivery = global.deliveries[train.id]
        if delivery and train.get_item_count() == 0 and train.get_fluid_count() == 0 then
            LTN_paint(train)
            global.painted_ltn_trains = global.painted_ltn_trains or {} -- move to on_init and on_configuration_changed
            global.painted_ltn_trains[train.id] = train -- remember each LTN train for unpainting later
            return true
        end
    end
    return false
end

function LTN_read(train)
    local delivery = global.deliveries[train.id]
    local inventory = {}
    if not delivery then
        return inventory
    end

    for item, count in pairs(delivery.shipment) do
        local split_string = split(item, ",")
        local name = split_string[2]
        inventory[name] = count
    end
    return inventory
end

function LTN_paint(train)
    --LTN train content
    local LTN_content = LTN_read(train)

    --color mixing calculator
    local final_color, flag = color_calculator(LTN_content, colors)

    --check if mixed_colors were initialized
    if flag == false then
        return
    end

    --paint locomotives
    paint_locomotive(train, 'front_movers', final_color)
    paint_locomotive(train, 'back_movers', final_color)

    --paint cargo wagons
    paint_wagons(train.cargo_wagons, 'paint-cargo-wagon', default_color("u-cargo-wagon"), final_color)
    paint_wagons(train.fluid_wagons, 'paint-fluid-wagon', default_color("u-fluid-wagon"), final_color)
end

function LTN_unpaint(train_id)
    if global.painted_ltn_trains ~= nil then
        local train = global.painted_ltn_trains[train_id]
        if not train or not train.valid then
            global.painted_ltn_trains[train_id] = nil
            return
        end
        local check = exemption_check(train)
        if check == true then
            global.painted_ltn_trains[train_id] = nil
            return
        else
            unpaint_empty(train)
            unpaint_wagons(train)
            global.painted_ltn_trains[train_id] = nil
        end
    end
end