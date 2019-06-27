local MOD_NAME = "DeepMine"
local Mine_Names = {
  ["deep-mine"] = true,
  ["deep-mine-2"] = true,
}
local Beacon_Name = "deep-mine-beacon"
local Productivity_Module_Name = "deep-mine-prod-module"
local Productivity_Module_Bonus = 0.1 -- 0.17.6 changed productivity to 10% increments


-- set modules in hidden beacons to match mining productivity bonus
function UpdateBeaconProductivity(beacon, total_modules)
  local module_inventory = beacon.get_module_inventory()
  if module_inventory then
    -- module_inventory.clear() -- much slower than counting existing modules
    local added_modules = total_modules - module_inventory.get_item_count(Productivity_Module_Name)
    if added_modules >= 1 then
      module_inventory.insert( {name = Productivity_Module_Name, count = added_modules} )
    end
  end
end

function OnResearchFinished(event)
  -- TODO: delay execution when event.by_script == true
  local force = event.research.force
  if force and force.get_entity_count(Beacon_Name) > 0 then -- only update when beacons exist for force
    local module_count = math.floor(force.mining_drill_productivity_bonus / Productivity_Module_Bonus + 0.5)
    for _, effect in pairs(event.research.effects) do
      if effect.type == "mining-drill-productivity-bonus" then
        for _, surface in pairs(game.surfaces) do
          local beacons = surface.find_entities_filtered { name = Beacon_Name, force = force }
          for _, beacon in pairs(beacons) do
            UpdateBeaconProductivity(beacon, module_count)
          end
        end
        return
      end
    end
  end
end

function OnForceReset(event)
  local force = event.force or event.destination
  if force and force.get_entity_count(Beacon_Name) > 0 then -- only update when beacons exist for force
    local module_count = math.floor(force.mining_drill_productivity_bonus / Productivity_Module_Bonus + 0.5)
    for _, surface in pairs(game.surfaces) do
      local beacons = surface.find_entities_filtered { name = Beacon_Name, force = force }
      for _, beacon in pairs(beacons) do
        UpdateBeaconProductivity(beacon, module_count)
      end
    end
  end
end


---- Remove and create ----

function OnEntityCreated(event)
  local entity = event.created_entity
  if Mine_Names[entity.name] then
    -- prevent creating multiple beacons
    if entity.surface.count_entities_filtered { name = Beacon_Name, position = entity.position } == 0 then
      local beacon = entity.surface.create_entity{name = Beacon_Name, position = entity.position, force = entity.force}
      beacon.destructible = false
      beacon.minable = false
      local module_count = math.floor(entity.force.mining_drill_productivity_bonus / Productivity_Module_Bonus + 0.5)
      UpdateBeaconProductivity(beacon, module_count)
    end
  elseif entity.name == Beacon_Name then -- handle beacons being created before mines
    local module_count = math.floor(entity.force.mining_drill_productivity_bonus / Productivity_Module_Bonus + 0.5)
    UpdateBeaconProductivity(entity, module_count)
  end
end


function OnEntityRemoved(event)
  local entity = event.entity
  if Mine_Names[entity.name] then
    local beacons = entity.surface.find_entities_filtered { name = Beacon_Name, position = entity.position }
    for _, beacon in pairs(beacons) do
      beacon.destroy()
    end
  end
end


--[[
Event table returned with the event
    player_index = player_index, --The index of the player who moved the entity
    moved_entity = entity, --The entity that was moved
    start_pos = position --The position that the entity was moved from
]]--
function OnEntityMoved(event)
  local entity = event.moved_entity

  if entity and Mine_Names[entity.name] then
    local beacons = entity.surface.find_entities_filtered { name = Beacon_Name, position = event.start_pos }
    for _, beacon in pairs(beacons) do
      beacon.teleport(entity.position)
    end
  end

end

---- Initialize ----

function init_events()
  --register to PickerExtended
  if remote.interfaces["picker"] and remote.interfaces["picker"]["dolly_moved_entity_id"] then
    script.on_event(remote.call("picker", "dolly_moved_entity_id"), OnEntityMoved)
  end
  --register to PickerDollies
  if remote.interfaces["PickerDollies"] and remote.interfaces["PickerDollies"]["dolly_moved_entity_id"] then
    script.on_event(remote.call("PickerDollies", "dolly_moved_entity_id"), OnEntityMoved)
  end

  script.on_event({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died}, OnEntityRemoved)
  script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, OnEntityCreated)
  script.on_event({defines.events.on_technology_effects_reset, defines.events.on_forces_merging}, OnForceReset)
  script.on_event({defines.events.on_research_finished}, OnResearchFinished)
end


script.on_load(function()
  init_events()
end)

script.on_init(function()
  init_events()
end)


script.on_configuration_changed(function(event)
  -- recreate beacons for older mod versions
  if event.mod_changes[MOD_NAME] and event.mod_changes[MOD_NAME].old_version then
    game.print("[Deep Mine] old version: "..event.mod_changes[MOD_NAME].old_version..", updating mining productivity beacons.")
    for _, surface in pairs(game.surfaces) do
      entities = surface.find_entities_filtered { name = Beacon_Name }
      for _, entity in pairs(entities) do
        entity.destroy()
      end

      local entities = surface.find_entities_filtered { name = {"deep-mine", "deep-mine-2"} }
      for _, entity in pairs(entities) do
        local beacon = entity.surface.create_entity{name = Beacon_Name, position = entity.position, force = entity.force}
        beacon.destructible = false
        beacon.minable = false
        local module_count = math.floor(beacon.force.mining_drill_productivity_bonus / Productivity_Module_Bonus + 0.5)
        UpdateBeaconProductivity(beacon, module_count)
      end
    end
  else
    -- update beacons and productivity in case other mods changed something
    for _, surface in pairs(game.surfaces) do
      entities = surface.find_entities_filtered { name = Beacon_Name }
      for _, beacon in pairs(entities) do
        local module_count = math.floor(beacon.force.mining_drill_productivity_bonus / Productivity_Module_Bonus + 0.5)
        UpdateBeaconProductivity(beacon, module_count)
      end
    end
  end
end)