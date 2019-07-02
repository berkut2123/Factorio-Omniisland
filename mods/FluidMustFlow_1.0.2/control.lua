-- -- -- Libraries
local tooltip = require("__FluidMustFlow__/linver-lib/tooltip")
local entity_utils = require("__FluidMustFlow__/linver-lib/entity-utils")

-- name of entity added by the mod
local fmf_entities_prefix             = "duct"
local fmf_duct_part_names             = {"duct-small", "duct", "duct-long", "duct-t-junction", "duct-curve", "duct-cross", "duct-underground"}
local fmf_connection_point_part_names = {"duct-intermediate-point", "duct-end-point-intake-south", "duct-end-point-intake-west", "duct-end-point-intake-north", "duct-end-point-intake-east", "duct-end-point-outtake-south", "duct-end-point-outtake-west", "duct-end-point-outtake-north", "duct-end-point-outtake-east"}
local fmf_end_point_part_names        = {"duct-end-point-intake-south", "duct-end-point-intake-west", "duct-end-point-intake-north", "duct-end-point-intake-east", "duct-end-point-outtake-south", "duct-end-point-outtake-west", "duct-end-point-outtake-north", "duct-end-point-outtake-east"}
local fmf_joinable = 
({
	{entity = "duct-small", predecessor = nil,          successor = "duct"},
	{entity = "duct",       predecessor = "duct-small", successor = "duct-long"},
	{entity = "duct-long",  predecessor = "duct",       successor = nil}
})

-- -- -- Duct connections control

-- if an name of entity is one of entities added by this mod
-- in particular, if is a duct part
function isPartofDucts(entity_name)
	if entity_name:find(fmf_entities_prefix) then
		for _, name in ipairs(fmf_duct_part_names) do
			if name == entity_name then
				return true
			end
		end	
	end
	return false
end

-- if an name of entity is one of entities added by this mod
-- in particular, if is a connection point
function isaConnectionPoint(entity_name)	
	if entity_name:find(fmf_entities_prefix) then
		for _, name in ipairs(fmf_connection_point_part_names) do
			if name == entity_name then
				return true
			end
		end	
	end
	return false
end

function isaEndPoint(entity_name)	
	if entity_name:find(fmf_entities_prefix) then
		for _, name in ipairs(fmf_end_point_part_names) do
			if name == entity_name then
				return true
			end
		end	
	end
	return false
end

-- enforce the player to connected duct part only with other duct part
local function ductConnectionsControlEvent(entity)		
	--ignore controls if is a connection point
	if isaConnectionPoint(entity.name) then return false end
	
	if entity_utils.entityHasFluidbox(entity) then			
		-- if placed entity is of the mod
		entity_belong_mod = isPartofDucts(entity.name)
	
		-- control connected entities
		local connected_neighbours = entity_utils.getConnectedNeighbours(entity)
		local i, connected_neighbour = next(connected_neighbours, nil)	
		
		while connected_neighbour do
			--ignore controls if is a connection point
			if isaConnectionPoint(connected_neighbour.entity.name) then return false end
			connected_entity_belong_mod = isPartofDucts(connected_neighbour.entity.name)
			
			if not (entity_belong_mod == connected_entity_belong_mod) then
				entity.last_user.insert{name=entity.name, count=1}											
				tooltip.showOnSurfaceGreyText(entity.surface, entity.position, "other.duct-connection-error")	
				entity.destroy()
				return true
			end
			
			--pull next
			i, connected_neighbour = next(connected_neighbours, i)		
		end			
	end
	
	return false
end

-- -- -- Ducts join

function lookingforDuctJoin(entity)
	local join_pattern = nil	
	
	for _, pattern in pairs(fmf_joinable) do
		if pattern.entity == entity.name then
			join_pattern = pattern
			break
		end
	end
	
	-- if there isn't a pattern or successor isn't joinable
	if join_pattern and join_pattern.successor then
		-- check for neighbour to join
		local neighbour_ducts = entity_utils.getConnectedNeighboursOfSamePrototype(entity)
		local _, joinable_candidate = next(neighbour_ducts)	
			
		if joinable_candidate then
			--computing correct position
			local in_direction = entity.direction
			local at_position = entity.position		
			local perimenter = entity_utils.getEntityOrientedSize(joinable_candidate.entity)
					
			if in_direction == 2 or in_direction == 6 then
				if joinable_candidate.horizontal_direction == "west" then
					at_position.x = at_position.x - 1  
				elseif perimenter.width > 1 then
					at_position.x = at_position.x + 1
				end
			end
			if in_direction == 0 or in_direction == 4 then
				if joinable_candidate.vertical_direction == "south" then
					at_position.y = at_position.y - 1
				elseif perimenter.height > 1 then
					at_position.y = at_position.y + 1
				end		
			end

			--copy other old entity stats
			local on_surface   = entity.surface
			local of_force     = entity.force
			local with_damage  = joinable_candidate.entity.prototype.max_health - joinable_candidate.entity.health
			local player_owner = entity.last_user
			
			joinable_candidate.entity.destroy()
			entity.destroy()
			
			entity = on_surface.create_entity
			{
				name      = join_pattern.successor, 
				position  = at_position, 
				direction = in_direction, 
				force     = of_force,
				player    = player_owner,
				raise_built = true
			}
			
			local construction_event = 
			{
				created_entity = entity,
				player_index = entity.last_user.index
			}			
			-- script.raise_event(defines.events.script_raised_built, construction_event)	
			
			entity.damage(with_damage, game.forces.neutral)	--user can use this like free repair otherwise
			
			lookingforDuctJoin(entity) -- recursive check other join
		end
	end
end

-- -- Ducts join control on blueprints

function lookingforReverseJoinOfGhostEntity(entity)	
	--if is a joined piece
	local join_pattern = nil		
	for _, pattern in pairs(fmf_joinable) do
		if pattern.successor == entity.ghost_name then
			join_pattern = pattern
			break
		end
	end
		
	if join_pattern then	
		-- get perimenters
		local entity_perimenter = entity_utils.getPrototypeSize(game.entity_prototypes[entity.ghost_name]) -- entity_utils.getEntityOrientedSize(entity)
		local childs_perimenter = entity_utils.getPrototypeSize(game.entity_prototypes[join_pattern.entity])
		
		--copy other old entity stats and destroy it
		local on_surface   = entity.surface
		local of_force     = entity.force
		local player_owner = entity.last_user
		local at_position  = entity.position
		local in_direction = entity.direction			
		entity.destroy()
		
		--iter params
		local child_entity   = nil
		local residual_space = nil
		local de_increment   = nil
		local on_x           = true
		
		if in_direction == 2 or in_direction == 4 then -- horizontal reverse join
			residual_space  = entity_perimenter.height
			de_increment    = childs_perimenter.height
			at_position.x   = at_position.x + entity_utils.downDifferenceToSizeCenter(entity_perimenter)
		else -- vertical reverse join
			residual_space  = entity_perimenter.height
			de_increment    = childs_perimenter.height
			at_position.y   = at_position.y + entity_utils.downDifferenceToSizeCenter(entity_perimenter)
			on_x            = false
		end			
		
		while residual_space > 0 do
			child_entity   = on_surface.create_entity
			{
				name       = "entity-ghost",
				ghost_name = join_pattern.entity, 
				position   = at_position, 
				direction  = in_direction, 
				force      = of_force,
				player     = player_owner,
				raise_built = true
			}				
		
			lookingforReverseJoinOfGhostEntity(child_entity)
			
			if on_x then
				at_position.x = at_position.x - de_increment
			else
				at_position.y = at_position.y - de_increment
			end
			residual_space = residual_space - de_increment
		end
	end	
end

-- Scheduling of ducts join procedures
function ductsJoin(entity)	
	--if entity is a ghost (ignore all entities that isn't duct)
	if entity.name == "entity-ghost" and isPartofDucts(entity.ghost_name) then 
		lookingforReverseJoinOfGhostEntity(entity)
	elseif isPartofDucts(entity.name) then
		lookingforDuctJoin(entity)
	end
end

-- -- -- Endpoint rotating entities
function endpointOnRotating(event)
	local entity = nil
	if event.entity then
		entity = event.entity
	else
		entity = event.created_entity	
	end
	
	if not isaEndPoint(entity.name) then return false end
	
	endpoint_prefix = nil
	
	if entity.name:find("intake") then
		endpoint_prefix = "duct-end-point-intake"
	else
		endpoint_prefix = "duct-end-point-outtake"
	end
		
	local rotated_entity = nil
	entity_fluidbox = entity.fluidbox[1]
		
	if event.previous_direction == defines.direction.south then 
		rotated_entity = entity.surface.create_entity
		{
		    name = endpoint_prefix .."-west",
			position = entity.position,
			direction = defines.direction.west,
			force = entity.force,
			player = entity.last_user,
			create_build_effect_smoke = false,
			raise_built = true
		}
	elseif event.previous_direction == defines.direction.west then
		rotated_entity = entity.surface.create_entity
		{
		    name = endpoint_prefix .."-north",
			position = entity.position,
			direction = defines.direction.north,
			force = entity.force,
			player = entity.last_user,
			create_build_effect_smoke = false,
			raise_built = true
		}
	elseif event.previous_direction == defines.direction.north then
		rotated_entity = entity.surface.create_entity
		{
		    name = endpoint_prefix .."-east",
			position = entity.position,
			direction = defines.direction.east,
			force = entity.force,
			player = entity.last_user,
			create_build_effect_smoke = false,
			raise_built = true
		}
	else
		rotated_entity = entity.surface.create_entity
		{
		    name = endpoint_prefix .."-south",
			position = entity.position,
			direction = defines.direction.south,
			force = entity.force,
			player = entity.last_user,
			create_build_effect_smoke = false,
			raise_built = true
		}
	end	
	rotated_entity.fluidbox[1] = entity_fluidbox 
	
	local pre_construction_event =
	{
		entity = entity,
		player = entity.last_user.index
	}
	local construction_event = 
	{
        created_entity = rotated_entity,
        player_index = entity.last_user.index,
        clamped = true,
        replaced_entity_unit_number = 1
    }

	-- script.raise_event(defines.events.script_raised_destroy, pre_construction_event)
    -- script.raise_event(defines.events.script_raised_built, construction_event)	
	if entity then
        entity.destroy()
    end	
	
	return true
end

-- -- -- Endpoint rotating entities
function endpointOnBuildRightFacing(entity)	
	if not isaEndPoint(entity.name) then return false end
	
	endpoint_prefix = nil
	
	if entity.name:find("intake") then
		endpoint_prefix = "duct-end-point-intake"
	else
		endpoint_prefix = "duct-end-point-outtake"
	end
		
	local rotated_entity = nil
	entity_fluidbox = entity.fluidbox[1]
		
	if entity.direction == defines.direction.south then 
		rotated_entity = entity.surface.create_entity
		{
		    name = endpoint_prefix .."-south",
			position = entity.position,
			direction = defines.direction.south,
			force = entity.force,
			player = entity.last_user,
			raise_built = true
		}
	elseif entity.direction == defines.direction.west then
		rotated_entity = entity.surface.create_entity
		{
		    name = endpoint_prefix .."-west",
			position = entity.position,
			direction = defines.direction.west,
			force = entity.force,
			player = entity.last_user,
			raise_built = true
		}
	elseif entity.direction == defines.direction.north then
		rotated_entity = entity.surface.create_entity
		{
		    name = endpoint_prefix .."-north",
			position = entity.position,
			direction = defines.direction.north,
			force = entity.force,
			player = entity.last_user,
			raise_built = true
		}
	else
		rotated_entity = entity.surface.create_entity
		{
		    name = endpoint_prefix .."-east",
			position = entity.position,
			direction = defines.direction.east,
			force = entity.force,
			player = entity.last_user,
			raise_built = true
		}
	end	
	rotated_entity.fluidbox[1] = entity_fluidbox 
	
	local pre_construction_event =
	{
		entity = entity,
		player = entity.last_user.index
	}
	local construction_event = 
	{
        created_entity = rotated_entity,
        player_index = entity.last_user.index,
        clamped = true,
        replaced_entity_unit_number = 1
    }

	-- script.raise_event(defines.events.script_raised_destroy, pre_construction_event)
    -- script.raise_event(defines.events.script_raised_built, construction_event)	
	if entity then
        entity.destroy()
    end	
	
	return true
end

-- -- -- Adding controls events
local build_events = {defines.events.on_built_entity, defines.events.on_robot_built_entity}

function ductControlEvents(event)
	local entity = event.created_entity	
	local removed = false
	
	if settings.startup["fmf-enable-duct-invariant"].value then
		removed = ductConnectionsControlEvent(entity)
	end
	if not removed then	
		rotated_an_endpoint = endpointOnBuildRightFacing(entity)
		if settings.startup["fmf-enable-duct-auto-join"].value and not rotated_an_endpoint then
			ductsJoin(entity)
		end
	end
end

-- Add duct join and duct ghost control
script.on_event(build_events, ductControlEvents)
script.on_event(defines.events.on_player_rotated_entity, endpointOnRotating)

--[[
FOR DEBUG
game.print
		(
			"width=" .. tostring(entity_perimenter.width) ..
			", height=" .. tostring(entity_perimenter.height) ..
			", in direction=" .. tostring(in_direction) ..
			", right difference=" .. tostring(entity_utils.rightDifferenceToSizeCenter(entity_perimenter)) ..
			", down difference=" .. tostring(entity_utils.downDifferenceToSizeCenter(entity_perimenter))
		)
--]]