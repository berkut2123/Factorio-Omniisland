function placedTiles(entity, tiles, item)
  if item.name == "blasting-charge" then
    local surface = entity.surface
    for i, tile in pairs(tiles) do
      local victim = surface.create_entity({name = "fish", position = {tile.position.x+0.5, tile.position.y+0.5}})
      surface.create_entity({name = "blasting-projectile", force = entity.force, speed = 0, target = victim, position = victim.position})
      victim.destroy()
    end
  end
end

script.on_event(defines.events.on_player_built_tile, function(event)
  if event.item and event.item.valid then
    placedTiles(game.players[event.player_index], event.tiles, event.item)
  end
end)

script.on_event(defines.events.on_robot_built_tile, function(event)
  if event.item and event.item.valid then
    placedTiles(event.robot, event.tiles, event.item)
  end
end)