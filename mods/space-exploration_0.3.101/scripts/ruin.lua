local Ruin = {}

--[[
Add more ruins below, eg:
Ruin.ruins["my-ruin"] = require("ruins/my-ruin.lua")
test with
/c remote.call("space-exploration", "build_ruin", {ruin_name = "my-ruin", surface_index = game.player.surface.index, position = game.player.position})

Ruin forces:
"enemy" = turrets are hostile to player, cannot be mined, cannot be opened
"neutral" = can be mined
"capture" = can be captured by nearby player (not implemented yet, defaults to neutral)


When making a ruin it is useful to use the editor, then make a blurprint, then export the string.
In order to blueprint entities they must be your force:
/c for _, e in pairs(game.player.surface.find_entities()) do e.force=game.player.force end
]]--

Ruin.ruins = {}

Ruin.ruins["satellite"] = require("ruins/satellite.lua")
Ruin.ruins["galaxy-ship"] = require("ruins/galaxy-ship.lua")


function Ruin.build(data)
  if not (data.ruin_name and data.surface_index and data.position) then return end
  local ruin_name = data.ruin_name
  local ruin = Ruin.ruins[ruin_name]
  if not ruin then return end

  setup_util_forces()
  local force = "ignore"
  if ruin.force_name then
    force = ruin.force_name
  end
  if data.force_name_override then
    force = data.force_name_override
  end

  local ruin_position = data.position
  ruin_position.x = math.floor((ruin_position.x+1)/2)*2-1
  ruin_position.y = math.floor((ruin_position.y+1)/2)*2-1

  local surface = game.surfaces[data.surface_index]

  surface.request_to_generate_chunks(ruin_position, 2)
  surface.force_generate_chunk_requests() -- must be generated to place

  if ruin.prebuild then
    ruin.prebuild(surface, ruin_position, ruin)
  end

  if ruin.tiles then
    local tiles = {}
    for tile_name, positions in pairs(ruin.tiles) do
      for _, position in pairs(positions) do
        table.insert(tiles, {name = tile_name,
        position = {
          x = ruin_position.x + position[1] - ruin.center.x,
          y = ruin_position.y + position[2] - ruin.center.y}})
      end
    end
    surface.set_tiles(tiles, true)
  end

  for tile_name, positions in pairs(ruin.under_tiles or {}) do
    for _, position in pairs(positions) do
      surface.set_hidden_tile({
        x = ruin_position.x + position[1] - ruin.center.x,
        y = ruin_position.y + position[2] - ruin.center.y}, tile_name)
    end
  end

  for _, bp in pairs(ruin.blueprint_strings or {}) do
    local container = game.surfaces[1].create_entity{name = "iron-chest", position = {0,0}}
    container.insert{name="blueprint", count = 1}
    local inv = container.get_inventory(defines.inventory.chest)
    local blueprint = inv[1]
    blueprint.import_stack(bp.string)

    local tiles = blueprint.get_blueprint_tiles()
    if tiles ~= nil then
      for _, tile in pairs(tiles) do
        tile.position.x = tile.position.x + ruin_position.x + (bp.xadj or 0)
        tile.position.y = tile.position.y + ruin_position.y + (bp.yadj or 0)
      end
      surface.set_tiles(tiles, true)
    end

    local entities = blueprint.build_blueprint{
      surface = surface,
      force = bp.force_override or force,
      position = {ruin_position.x + (bp.xadj or 0), ruin_position.y + (bp.yadj or 0)},
      force_build = true,
      direction=defines.direction.north,
      skip_fog_of_war=false
    }

    for _, entity in pairs(entities) do
      entity.revive()
    end

    container.destroy()
  end

  for entity_name, set in pairs(ruin.entities or {}) do
    for _, entity_data in pairs(set) do
      if type(entity_data.x) == "number" or type(entity_data[1]) then
        local entity_relative_position = {
          x = 0 + (entity_data.x or entity_data[1]),
          y = 0 + (entity_data.y or entity_data[2])
        }
        local entity_position = {
          x = ruin_position.x + entity_relative_position.x - ruin.center.x,
          y = ruin_position.y + entity_relative_position.y - ruin.center.y
        }
        local force_name = entity_data.force_name or force
        if data.force_name_override then
          force_name = data.force_name_override
        end
        local entity = surface.create_entity{
          name = entity_name,
          force = force_name,
          position = entity_position,
          direction = entity_data.direction,
          raise_built = true
        }
        if entity_data.stacks then
          for _, stack in pairs(entity_data.stacks) do
            entity.insert{name = stack.name, count = stack.count}
          end
        end
      end
    end
  end

	--game.print("starting specific chests")
	-- put a few specific items in chests based on the insert_list table
  --  list of items to put in chests
  --   max, min define the range for number of items
  --   odds will only have it appear 1 in odds times
  --   max, min, and odds all default to 1
  for _, ins in pairs(ruin.insert_list or {}) do
		local p = {x = ruin_position.x + ins.x + .5, y = ruin_position.y + ins.y + .5}
		-- find_entities_filtered used because it could be any kind of chest
		local chest = surface.find_entities_filtered({
				position = p,
				radius = .5,
				name = {
          "steel-chest",
          "logistic-chest-buffer",
					"logistic-chest-active-provider",
					"logistic-chest-buffer",
					"logistic-chest-passive-provider",
					"logistic-chest-requester",
					"logistic-chest-storage",
					mod_prefix.."cargo-rocket-cargo-pod"
					}})[1]

		if chest == nil then
			Log.trace(data.ruin_name..": cannot find specific chest at offset "..ins.x..", "..ins.y.." final position "..p.x..", "..p.y, "ruin")
		else
			--game.print(chest.name .. " found at " .. chest.position.x .. ", " .. chest.position.y)
			for _, item in pairs(ins.items) do
        --game.print("attempting to insert up to " .. item.count .. " of " .. item.name)
        if item.odds == nil or math.random(1, item.odds) == 1 then
          chest.insert({name = item.name, count = math.random(item.min or 1, item.max or 1)})
        end
			end
		end
	end

  for wire_type, set in pairs(ruin.wires or {}) do
    for _, wire_data in pairs(set) do
      local from = surface.find_entity(wire_data.from.name,
        {
          x = ruin_position.x + (wire_data.from.position.x or wire_data.from.position[1]) - ruin.center.x,
          y = ruin_position.y + (wire_data.from.position.y or wire_data.from.position[2]) - ruin.center.y
        }
      )
      local to = surface.find_entity(wire_data.to.name,
        {
          x = ruin_position.x + (wire_data.to.position.x or wire_data.to.position[1]) - ruin.center.x,
          y = ruin_position.y + (wire_data.to.position.y or wire_data.to.position[2]) - ruin.center.y
        }
      )
      if from and to then
        from.connect_neighbour({ -- https://lua-api.factorio.com/latest/LuaEntity.html#LuaEntity.connect_neighbour
          wire = wire_type,
          target_entity = to,
          source_circuit_id = wire_data.source_circuit_id,
          target_circuit_id  = wire_data.target_circuit_id
        })
      else
        game.print("can't find wire targets")
      end
    end
  end

  if ruin.postbuild then
    ruin.postbuild(surface, ruin_position, ruin)
  end

  -- make sure there are no test items left in the ruin.
  for _, entity in pairs(surface.find_entities_filtered{type="infinity-pipe"}) do
    entity.destroy()
  end
  for _, entity in pairs(surface.find_entities_filtered{type="infinity-chest"}) do
    entity.destroy()
  end
  for _, entity in pairs(surface.find_entities_filtered{name="electric-energy-interface"}) do
    entity.destroy()
  end
  
end

return Ruin
