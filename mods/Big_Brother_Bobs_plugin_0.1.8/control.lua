require 'stdlib/string'
require 'stdlib/surface'
require 'stdlib/table'
require 'stdlib/event/event'
require 'stdlib/log/logger'
require 'stdlib/area/position'
require 'stdlib/entity/entity'

LOGGER = Logger.new('Big_Brother_Bobs', 'main', false)

Event.register({defines.events.on_built_entity, defines.events.on_robot_built_entity}, function(event)
    local entity = event.created_entity
    local name = entity.name
	LOGGER.log("Entity placed. name: " .. name)
    if game.item_prototypes["radar-2"] and name == 'radar-2' then
        track_entity('radars', upgrade_radar_entity(entity, 2))
    elseif game.item_prototypes["radar-3"] and name == 'radar-3' then
        track_entity('radars', upgrade_radar_entity(entity, 3))
    elseif game.item_prototypes["radar-4"] and name == 'radar-4' then
        track_entity('radars', upgrade_radar_entity(entity, 4))
    elseif game.item_prototypes["radar-5"] and name == 'radar-5' then
        track_entity('radars', upgrade_radar_entity(entity, 5))
    elseif game.item_prototypes["big-electric-pole-2"] and name == 'big-electric-pole-2' then
        track_entity('power_poles', entity)
        if entity.force.technologies['surveillance-2'].researched then
            update_surveillance(entity, false)
        end
    elseif game.item_prototypes["big-electric-pole-3"] and name == 'big-electric-pole-3' then
        track_entity('power_poles', entity)
        if entity.force.technologies['surveillance-2'].researched then
            update_surveillance(entity, false)
        end
    elseif game.item_prototypes["big-electric-pole-4"] and name == 'big-electric-pole-4' then
        track_entity('power_poles', entity)
        if entity.force.technologies['surveillance-2'].researched then
            update_surveillance(entity, false)
        end
    elseif game.item_prototypes["big-electric-pole-5"] and name == 'big-electric-pole-5' then
        track_entity('power_poles', entity)
        if entity.force.technologies['surveillance-2'].researched then
            update_surveillance(entity, false)
        end
    elseif entity.name == 'big_brother-surveillance-center' then
        entity.backer_name = ''
        track_entity('surveillance_centers', entity)
        update_all_surveillance(entity.force)
    end
    
	if name == "entity-ghost" then
		upgrade_radar_blueprint_entity(entity)
	end
end)

-- Scan the map once if the mod has never been loaded --Code courtosy of legendblade, they are awsome
local function doInitialScan()
    if not global.scanned_map then
        if not global.map_scan_countdown then global.map_scan_countdown = 10 end
        global.map_scan_countdown = global.map_scan_countdown - 1
        if global.map_scan_countdown <= 0 then

            table.each(game.surfaces, function(surface)
                -- track all radars
                local radars = surface.find_entities_filtered({name = 'radar-2'})
                table.each(radars, function(entity) track_entity('radars', entity) end)
                local radars = surface.find_entities_filtered({name = 'radar-3'})
                table.each(radars, function(entity) track_entity('radars', entity) end)
                local radars = surface.find_entities_filtered({name = 'radar-4'})
                table.each(radars, function(entity) track_entity('radars', entity) end)
                local radars = surface.find_entities_filtered({name = 'radar-5'})
                table.each(radars, function(entity) track_entity('radars', entity) end)
                -- track all large poles
                local radars = surface.find_entities_filtered({name = 'big-electric-pole-2'})
				table.each(radars, function(entity) 
					track_entity('power_poles', entity)
					if entity.force.technologies['surveillance-2'].researched then
						update_surveillance(entity, false)
					end
					end)
                local radars = surface.find_entities_filtered({name = 'big-electric-pole-3'})
				table.each(radars, function(entity) 
					track_entity('power_poles', entity)
					if entity.force.technologies['surveillance-2'].researched then
						update_surveillance(entity, false)
					end
					end)
                local radars = surface.find_entities_filtered({name = 'big-electric-pole-4'})
				table.each(radars, function(entity) 
					track_entity('power_poles', entity)
					if entity.force.technologies['surveillance-2'].researched then
						update_surveillance(entity, false)
					end
					end)
                local radars = surface.find_entities_filtered({name = 'big-electric-pole-5'})
				table.each(radars, function(entity) 
					track_entity('power_poles', entity)
					if entity.force.technologies['surveillance-2'].researched then
						update_surveillance(entity, false)
					end
					end)

                -- upgrade radars
                table.each(game.forces, upgrade_radars)
            end)
			
			-- When we need to remove ourselves, set the method to a no-op:
            doInitialScan = function() end
            global.scanned_map = true
        end
    end
end

-- Always run our function, just change the function itself
Event.register(defines.events.on_tick, function(event)
    doInitialScan()
 end)


Event.register(defines.events.on_research_finished, function(event)
    local tech_name = event.research.name
    local force = event.research.force
    if tech_name:starts_with('radar-amplifier') or tech_name:starts_with('radar-efficiency') then
        -- update radars in 1 tick
        if not global.queued_updates then
            global.queued_updates = {}
        end
        -- attempt to avoid upgrading radars more than once when a player decides to research all techs at once
        if not global.queued_updates[force.name] or global.queued_updates[force.name] ~= event.tick then
            global.queued_updates[force.name] = event.tick
            Event.register(defines.events.on_tick, function(event)
                upgrade_radars(force)
                global.queued_updates[force.name] = nil
                Event.remove(defines.events.on_tick, event._handler)
            end)
        end
    elseif tech_name == 'surveillance-2' then
        if global.power_poles and global.surveillance_centers then
            Event.register(defines.events.on_tick, function(event)
                update_all_surveillance(force)
                Event.remove(defines.events.on_tick, event._handler)
            end)
        end
    end
end)

Event.register({defines.events.on_entity_died, defines.events.on_robot_pre_mined, defines.events.on_pre_player_mined_item}, function(event)
    local entity = event.entity
    local name = entity.name
	local namelength = tonumber(string.len(name))
	if namelength > 17 then
		if string.sub(name, 1, 17) == 'big-electric-pole' then
			if entity.force.technologies['surveillance-2'].researched then
				remove_surveillance(entity, false)
			end
        end
    end
end)


function update_all_surveillance(force)
    table.each(table.filter(global.vehicles or {}, Game.VALID_FILTER), function(vehicle) update_surveillance(vehicle, true) end)
    table.each(table.filter(global.trains or {}, Game.VALID_FILTER), function(train) update_surveillance(train, true) end)

    if global.power_poles and force.technologies['surveillance-2'].researched then
        global.power_poles = table.each(table.filter(global.power_poles, Game.VALID_FILTER), function(entity)
            update_surveillance(entity, false)
        end)
    end
end

function update_surveillance(entity, follow)
    local surv_center = get_nearest_surveillance_center(entity.position, entity.surface, entity.force)
    if surv_center then
        local data = Entity.get_data(entity)
        if not data then
            if not follow then
                local surveillance = entity.surface.create_entity({name = 'big_brother-surveillance-small', position = entity.position, force = entity.force})
                surveillance.destructible = false
                surveillance.operable = false
                surveillance.minable = false
                data = { surveillance = surveillance }
                Entity.set_data(entity, data)
            else
                track_entity('following', entity)
            end
        end
    else
        remove_surveillance(entity, follow)
    end
end

function remove_surveillance(entity, follow)
    if follow then
        global.following = table.filter(global.following or {}, function(followed) return followed ~= entity end)
    else
        local data = Entity.get_data(entity)
        if data and data.surveillance and data.surveillance.valid then
            data.surveillance.destroy()
            Entity.set_data(entity, nil)
        end
    end
end

function get_nearest_surveillance_center(position, surface, force)
    if global.surveillance_centers then
        global.surveillance_centers = table.filter(global.surveillance_centers, Game.VALID_FILTER)
        local list = table.filter(global.surveillance_centers, function(entity)
            return entity.surface == surface and entity.force == force
        end)
        table.sort(list, function(a, b)
            return Position.distance_squared(a.position, position) < Position.distance_squared(b.position, position)
        end)
        return table.first(list)
    end
end

function upgrade_radar_entity(radar, mark)
    if not radar.valid then return nil end

    local force = radar.force
    local radar_efficiency_level = calculate_tech_level(force, 'radar-efficiency', 9)
    local radar_amplifier_level = calculate_tech_level(force, 'radar-amplifier', 9)
    local radar_name = 'big_brother-radar_ra-' .. radar_amplifier_level .. '_re-' .. radar_efficiency_level .. '_mk-' .. mark
    local pos = radar.position
    local direction = radar.direction
    local health = radar.health
    local surface = radar.surface
    LOGGER.log("Upgrading radar {" .. radar.name .. "} at " .. serpent.line(pos, {comment=false}))
    radar.destroy()
    local new_radar = surface.create_entity({ name = radar_name, position = pos, direction = direction, force = force})
    new_radar.health = health
    return new_radar
end

function upgrade_radar_blueprint_entity(entity)
    if not entity.valid then return nil end

	local ghostname = entity.ghost_name
	local namelength = tonumber(string.len(ghostname))
	if namelength > 17 then
		if string.sub(ghostname, 1, 17) == 'big_brother-radar' then
			LOGGER.log("Replaceing bluepring ghost")
			local tier= get_tier(ghostname)
			local entforce = entity.force
			local radar_name = ''
			if tier == "1" then
				radar_name = 'radar'				
			else
				radar_name = 'radar-' .. tier
			end
			if tier ~= "1" then
				local pos = entity.position
				local direction = entity.direction
				local surface = entity.surface
				entity.destroy()
				local origonal_ttl = entforce.ghost_time_to_live
				entforce.ghost_time_to_live = 60*60*60*24*365
				local target = surface.create_entity({ name = 'entity-ghost', position = pos, inner_name = radar_name, force = entforce})
				entforce.ghost_time_to_live = origonal_ttl
			end
		end
	end
end

function get_tier(name)
	local namelength = tonumber(string.len(name))
	local tiername = string.sub(name, namelength-3, namelength -1)
	local tier = 0
	if tiername == "mk-" then
		tier = string.sub(name, namelength)
	else
		tier = "1"
	end
	return tier
end

function upgrade_radars(force)
    if not global.radars then return end

    local radar_efficiency_level = calculate_tech_level(force, 'radar-efficiency', 9)
    local radar_amplifier_level = calculate_tech_level(force, 'radar-amplifier', 9)
    local radar_name = 'big_brother-radar_ra-' .. radar_amplifier_level .. '_re-' .. radar_efficiency_level
    LOGGER.log("Upgrading " .. force.name .. "'s radars to " .. radar_name)
    
    for i = #global.radars, 1, -1 do
        local radar = global.radars[i]        
		LOGGER.log("Checking:" .. i)
		
        if not radar.valid then
            table.remove(global.radars, i)
			LOGGER.log("Removeing: Invalid")
		elseif radar.force == force then
			local name = radar.name		
			LOGGER.log("name: " .. name.. " force: " .. radar.force.name)
			local namelength = tonumber(string.len(name))
			local tiername = string.sub(name, namelength)
			LOGGER.log("Tier: " .. tiername)			
			local tier = tonumber(tiername)
			
			
            global.radars[i] = upgrade_radar_entity(radar, tier)
        else
			LOGGER.log("Something went wrong")
        end
    end
end

function calculate_tech_level(force, tech_name, max_levels)
    for i = max_levels, 1, -1 do
        local full_tech_name = tech_name
        if i > 1 then
            full_tech_name = tech_name .. '-' .. i
        end

        if force.technologies[full_tech_name].researched then
            return i
        end
    end
    return 0
end

function track_entity(category, entity)
    if not entity then return end
    
    if not global[category] then global[category] = {} end
	
    local entity_list = global[category]
    for i = #entity_list, 1, -1 do
        local e = entity_list[i]
        if not e.valid then
            table.remove(entity_list, i)
        elseif e == entity then
            return false
        end
    end

    table.insert(entity_list, entity)
    return true
end
