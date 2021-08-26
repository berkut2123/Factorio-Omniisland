local Migrate = {}

function Migrate.migrations()
  global.old_version = global.version or "0.0.0"
  global.version = game.active_mods["aai-programmable-vehicles"]

  if Util.dot_string_less_than(global.old_version, "0.3.10", false) then
    Migrate.v0_3_10 ()
  end

  if Util.dot_string_less_than(global.old_version, "0.3.24", false) then
    Migrate.v0_3_24 ()
  end

  if Util.dot_string_less_than(global.old_version, "0.5.7", false) then
    Migrate.v0_5_7 ()
  end

  if Util.dot_string_less_than(global.old_version, "0.6.2", false) then
    Migrate.v0_6_2 ()
  end

  if Util.dot_string_less_than(global.old_version, "0.7.6", false) then
    Migrate.v0_7_6 ()
  end
end


function Migrate.v0_3_10 ()
  -- depots are running 3 time more than required
  -- they are going per entity not per depot
  -- updated depots to new struct structure

  if global.vehicle_depot then
    global.structures = global.structures or {}
    global.structure_unit_numbers = global.structure_unit_numbers or {}
    global.next_struct_id = global.next_struct_id or 1

    for _, struct in pairs(global.vehicle_depot) do

        struct.type = "vehicle-depot"
        struct.struct_id = global.next_struct_id
        global.next_struct_id = global.next_struct_id + 1
        global.structures[struct.struct_id] = struct

        if struct.entity and struct.entity.valid then
          global.structure_unit_numbers[struct.entity.unit_number] = struct.struct_id
        end

        struct.sub = struct.sub or {}
        if struct.sub.base and struct.sub.base.valid then
          global.structure_unit_numbers[struct.sub.base.unit_number] = struct.struct_id
        end
        if struct.sub.base and struct.sub.base.valid then
          global.structure_unit_numbers[struct.sub.base.unit_number] = struct.struct_id
        end
        if struct.sub.combinator and struct.sub.combinator.valid then
          global.structure_unit_numbers[struct.sub.combinator.unit_number] = struct.struct_id
        end

    end
    global.vehicle_depot = nil
  end


  -- find and manage deployers
  for _, surface in pairs(game.surfaces) do
      for _, entity in pairs(surface.find_entities_filtered{name="vehicle-deployer"}) do
          struct_manage_entity(entity)
      end
  end
end


function Migrate.v0_3_24 ()
  if global.unit and global.unit.units then
      for _, unit in pairs(global.unit.units) do
        if unit.data then
          local unit_type = unit_get_type(unit)
          if unit_type and unit_type.is_hauler then
              Util.signal_container_add(unit.data, {type = "virtual", name="signal-minimum-fuel"}, 800)
          end
        end
      end
  end
end


function Migrate.v0_5_7 ()

  -- move all paths to specific surfaces
  global.forces = global.forces or {}
  for _, forcedata in pairs(global.forces) do
    if forcedata.paths then
      -- remove old visualisations
      for _, path in pairs(forcedata.paths) do
        if path.visualisation then
          local vis = path.visualisation
          if vis.lines then
            for _, line in pairs(vis.lines) do
              line.destroy()
              vis.lines[_] = nil
            end
          end
          if vis.markers then
            for _, marker in pairs(vis.markers) do
              marker.destroy()
              vis.markers[_] = nil
            end
          end
        end
        path.visualisation = nil
        path.surface_index = 1
      end
      -- move path data to surface-specific location
      forcedata.surface_paths = {}
      forcedata.surface_paths[1] = {-- Nauvis
          surface_index = 1,
          paths = forcedata.paths
      }
      forcedata.paths = nil
    end
  end

  -- move all unit type tables to surface-specific tables
  if global.unit.unit_types then
    global.unit.surface_units_by_type = global.unit.surface_units_by_type or {}
    global.unit.surface_units_by_type[1] = global.unit.surface_units_by_type[1] or {}
    for unit_type, unit_types in pairs(global.unit.unit_types) do
      global.unit.surface_units_by_type[1][unit_type] = global.unit.surface_units_by_type[1][unit_type] or {}
      for _, unit in pairs(unit_types) do
        table.insert(global.unit.surface_units_by_type[1][unit_type], unit)
        unit.surface_index = 1
      end
    end
    global.unit.unit_types = nil
  end

  -- remove old indivators
  for _, unit in pairs(global.unit.units) do
    if unit.navpath_indicator and not (unit.navpath_indicator.final and type(unit.navpath_indicator.final) == "number") then
      local navpath_indicator = unit.navpath_indicator
      if navpath_indicator.lines then
        for _, line in pairs(navpath_indicator.lines) do
          if line and line.valid then
            line.destroy()
          end
        end
      end
      if navpath_indicator.waypoints then
        for _, waypoint in pairs(navpath_indicator.waypoints) do
          if waypoint and waypoint.valid then
            waypoint.destroy()
          end
        end
      end
      if navpath_indicator.final then
        if navpath_indicator.final and navpath_indicator.final.valid then
          navpath_indicator.final.destroy()  navpath_indicator.final = nil
        end
      end
      unit.navpath_indicator = nil
    end
  end
end


function Migrate.v0_6_2 ()
  for _, unit in pairs(global.unit.units) do
    local unit_type = unit_get_type(unit)
    if not unit_type then
      if unit.vehicle and unit.vehicle.valid then
        -- remove from old list
        if global.unit.surface_units_by_type and global.unit.surface_units_by_type[unit.surface_index] and global.unit.surface_units_by_type[unit.unit_type] then
          for i, comp_unit in ipairs(global.unit.surface_units_by_type[unit.surface_index][unit.unit_type]) do
              if comp_unit == unit then
                  remove_index = i
                  break
              end
          end
          if remove_index > 0 then
              table.remove(global.unit.surface_units_by_type[unit.surface_index][unit.unit_type], remove_index)
              update_surface_unit_type_ids(unit.surface_index, unit.unit_type)
          end
        end
        -- new name
        local suffix = 0
        if unit.vehicle.prototype.guns then
          for name, gun in pairs(unit.vehicle.prototype.guns) do
            suffix = name
          end
        end
        unit.unit_type = unit.unit_type .. "-"..suffix
        -- add to a list
        global.unit.surface_units_by_type[unit.surface_index][unit.unit_type] = global.unit.surface_units_by_type[unit.surface_index][unit.unit_type] or {}
        table.insert(global.unit.surface_units_by_type[unit.surface_index][unit.unit_type], unit)
      end
    end
  end
end

function Migrate.v0_7_6 ()
  --[[ position_beacons and vehicle_depots format change
  global.forces[force_name].position_beacons[beacon_id]
  global.forces[force_name].surfaces[surface_id].position_beacons[beacon_id]
  ]]
  if global.forces then
    for _, force in pairs(global.forces) do
      if force.position_beacons then
        for _, struct_set in pairs(force.position_beacons) do
          for _, struct in pairs(struct_set.structs) do
            update_position_beacon_from_entity(struct.entity)
          end
        end
        force.position_beacons = nil
      end
      if force.vehicle_depots then
        for _, struct_set in pairs(force.vehicle_depots) do
          for _, struct in pairs(struct_set.structs) do
            update_vehicle_depot_from_entity(struct.entity)
          end
        end
        force.vehicle_depots = nil
      end
    end
  end
end


return Migrate
