-- move all drills down by 1 pixel so that the animation is on top
for _, surface in pairs(game.surfaces) do
  for _, entity in pairs(surface.find_entities_filtered{name="se-core-miner-drill"}) do
    entity.teleport({x = entity.position.x, y = entity.position.y + 1/32})
    local e = entity.surface.find_entity("se-core-miner", entity.position)
    if e then e.direction = entity.direction end
  end
end
