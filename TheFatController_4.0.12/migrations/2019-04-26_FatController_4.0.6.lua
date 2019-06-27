if GUI then
    for _, player in pairs(game.players) do
        GUI.revalidate(player)
    end
end