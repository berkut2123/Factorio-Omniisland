require("util")
require "mod-gui"

local function artillery_swap(wagon,new_name)
	local shellname = {}
	local shellcount = {}
	local inventory = table.deepcopy(wagon.get_inventory(defines.inventory.artillery_wagon_ammo))
	for i=1,(#inventory) do
		if inventory[i].valid_for_read then
			shellname[#shellname+1] = inventory[i].name
			shellcount[#shellcount+1] = inventory[i].count
		end
	end
	
	local name = wagon.name
	local surface = wagon.surface.name
	local position = wagon.position
	local direction = wagon.direction
	local force = wagon.force
	local kills = wagon.kills
	local damage = wagon.damage_dealt
	local health = wagon.health
	wagon.destroy()
	local new_wagon = game.surfaces[surface].create_entity{name=new_name, position=position, direction=direction, force=force, create_build_effect_smoke=false}
	if new_wagon then
		new_wagon.kills = kills
		new_wagon.damage_dealt = damage
		new_wagon.health = health
		for i=1,(#shellcount) do
			if new_wagon.can_insert({name=shellname[i],count=shellcount[i]}) == true then
				new_wagon.insert({name=shellname[i],count=shellcount[i]})
			end
		end
	else
		game.print("Could not replace artillery wagon. Wagon was in a bad possition.")
	end
	return new_wagon
end

function EnableDisableTrain(train, disable)
	
	if train == nil then 
		return
	end
	
	local count = 0
	for _, wagon in pairs(train.carriages) do
		if disable == true and wagon.name == "artillery-wagon" then
			local name = wagon.name
			local new_name = ("disabled-" .. name)
			local new_wagon = artillery_swap(wagon,new_name)
			if new_wagon then 
				rendering.draw_sprite{sprite="virtual-signal.signal-disabled", x_scale=1.5, y_scale=1.5, target_offset={0.0,-0.5}, render_layer="entity-info-icon", target=new_wagon, surface=new_wagon.surface, forces={new_wagon.force}}
			end
		elseif disable == false and wagon.name == "disabled-artillery-wagon" then
			local name = wagon.name
			local new_name = (string.sub(name,10,#name))
			artillery_swap(wagon,new_name)
		end
	end
end

local function TrainIsDisabled(train)
	for _, wagon in pairs(train.carriages) do
		if wagon.name == "disabled-artillery-wagon" then
			return true
		end
	end
	return false
end

function ChangeFrame(player)

	if not mod_gui.get_frame_flow(player).as_main_frame then
		return
	else
		mod_gui.get_frame_flow(player).as_main_frame.destroy()
	end
	
	if player.vehicle~= nil and player.vehicle.train ~= nil then -- player is in a train
	
		local frame = mod_gui.get_frame_flow(player).add{ type = "frame", name = "as_main_frame", caption = "Artillery Switch", direction = "vertical" }
		local flow = frame.add{ type = "flow", name = "lsm_main_button_flow", direction = "vertical" }
		flow.add{ type = "checkbox", name = "as_disable", caption="Disable Artillery", state = TrainIsDisabled(player.vehicle.train) }
	else -- player is not in a train
		local frame = mod_gui.get_frame_flow(player).add{ type = "frame", name = "as_main_frame", caption = "Artillery Switch", direction = "vertical" }
		local flow = frame.add{ type = "flow", name = "lsm_main_button_flow", direction = "vertical" }
		flow.add{ type = "label", name = "as_text", caption="You are not in a train" }
	end
end

script.on_event(defines.events.on_player_driving_changed_state, function(event)

    local player = game.players[event.player_index]
	ChangeFrame(player)
end)

function ToggleMaximizedFrame(player)

	if mod_gui.get_frame_flow(player).as_main_frame then -- frame exists
		mod_gui.get_frame_flow(player).as_main_frame.destroy()
	elseif player.vehicle~= nil and player.vehicle.train ~= nil then -- player is in a train
		local frame = mod_gui.get_frame_flow(player).add{ type = "frame", name = "as_main_frame", caption = "Artillery Switch", direction = "vertical" }
		local flow = frame.add{ type = "flow", name = "lsm_main_button_flow", direction = "vertical" }
		flow.add{ type = "checkbox", name = "as_disable", caption="Disable Artillery", state = TrainIsDisabled(player.vehicle.train) }
	else -- player is not in a train
		local frame = mod_gui.get_frame_flow(player).add{ type = "frame", name = "as_main_frame", caption = "Artillery Switch", direction = "vertical" }
		local flow = frame.add{ type = "flow", name = "lsm_main_button_flow", direction = "vertical" }
		flow.add{ type = "label", name = "as_text", caption="You are not in a train" }
	end
end

script.on_event(defines.events.on_gui_click, function(event)
	local player = game.players[event.player_index]
    local element = event.element
	
	if (element.name == "as_maximize_button") then
        ToggleMaximizedFrame(player)
    elseif (element.name == "as_disable") then
		if player.vehicle ~= nil and player.vehicle.train ~= nil and player.vehicle.train.speed ~= 0 then
			element.state = not element.state
			player.print("Train must be stopped before enabling/disabling artillery")
		elseif player.vehicle ~= nil and player.vehicle.train ~= nil then
			local state = element.state
			EnableDisableTrain(player.vehicle.train, state)
		end
	else
        log("Unknown element name:" .. element.name)
    end
	if player.vehicle == nil or player.vehicle.train == nil then
		ChangeFrame(player)
	end
end)

script.on_event(defines.events.on_built_entity, function(event)
	local entity = event.created_entity
	local player = game.players[event.player_index]
	if entity ~= nil and entity.train ~= nil then
		if TrainIsDisabled(entity.train) then
			EnableDisableTrain(entity.train, true)
		end
	end
end)

local function CreateMinimizedButton(player)

	local flow = mod_gui.get_button_flow(player)

    if flow.as_maximize_button then 
		flow.as_maximize_button.destroy()
	end

    mod_gui.get_button_flow(player).add({
        type = "sprite-button",
        name = "as_maximize_button",
        sprite= "item/artillery-wagon",
        tooltip = "Artillery Switch",
        style = mod_gui.button_style
    })
end

local function initialize()
    for _, player in pairs(game.players) do
        CreateMinimizedButton(player)
    end
end

script.on_init(initialize)
script.on_configuration_changed(initialize)
script.on_event(defines.events.on_player_joined_game, function(event)
	local player = game.players[event.player_index]
    CreateMinimizedButton(player)
end)