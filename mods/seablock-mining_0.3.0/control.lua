-- The current number of modules required to match that force's mining
-- productivity bonus.
function current_module_count(force)
    return math.floor(force.mining_drill_productivity_bonus * 50 + 0.5)
end

function create_beacon_for(entity)
    local beacon = entity.surface.create_entity{
        name = "seablock-mining-prod-provider",
        position = entity.position,
        force = entity.force,
    }
    -- about 3 trillion years worth of energy, if I did the math right
    -- if I didn't, you're losing 10 watts per crystallizer
    if beacon.force.mining_drill_productivity_bonus > 0 then
        beacon.get_module_inventory().insert({
            name="seablock-mining-prod-module",
            count=current_module_count(entity.force)
        })
    end
end

function remove_beacon_for(entity)
    local x = entity.position.x
    local y = entity.position.y
    for _, beacon in pairs(entity.surface.find_entities_filtered{name="seablock-mining-prod-provider", area = {{x, y}, {x+1, y+1}}}) do
        beacon.destroy()
    end
end

function refresh_beacons(force)
    local goal_count = current_module_count(force)
    for _, surface in pairs(game.surfaces) do
        for _, beacon in pairs(surface.find_entities_filtered{name="seablock-mining-prod-provider", force=force}) do
            local current_count = beacon.get_module_inventory().get_item_count("seablock-mining-prod-module")
            if current_count < goal_count then
                beacon.get_module_inventory().insert({name="seablock-mining-prod-module", count=goal_count - current_count})
            elseif current_count > goal_count then
                -- It shouldn't be possible to have more modules than you're supposed to, but it happened
                -- a few times when I used cheats and it doesn't hurt to handle it.
                beacon.get_module_inventory().remove({name="seablock-mining-prod-module", count=current_count - goal_count})
            end
        end
    end
end

function on_entity_built(event)
    if event.created_entity.name == "crystallizer" or event.created_entity.name == "crystallizer-2" then
        create_beacon_for(event.created_entity)
    end
end

function on_entity_removed(event)
    if event.entity.name == "crystallizer" or event.entity.name == "crystallizer-2" then
        remove_beacon_for(event.entity)
    end
end

function on_research_finished(event)
    for _, effect in pairs(event.research.effects) do
        if effect.type == "mining-drill-productivity-bonus" then
            refresh_beacons(event.research.force)
            return
        end
    end
end

script.on_init(function()
    for _, surface in pairs(game.surfaces) do
        for _, entity in pairs(surface.find_entities_filtered{name={"crystallizer", "crystallizer-2"}}) do
            create_beacon_for(entity)
        end
    end
end)

-- Crystallizer is built
script.on_event(defines.events.on_built_entity, on_entity_built)
script.on_event(defines.events.on_robot_built_entity, on_entity_built)

-- Crystallizer is removed
script.on_event(defines.events.on_player_mined_entity, on_entity_removed)
script.on_event(defines.events.on_robot_mined_entity, on_entity_removed)
script.on_event(defines.events.on_entity_died, on_entity_removed)

-- Mining productivity increases
script.on_event(defines.events.on_research_finished, on_research_finished)