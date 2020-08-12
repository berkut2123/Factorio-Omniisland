local function on_configuration_changed(data)
  if not game.active_mods["space-exploration"] then
    game.print("[color=red]You do not have Space Exploration installed. DO NOT SAVE THE GAME. Exit without saving, install Space Exploration and reload.[/color]")
  end
end

script.on_configuration_changed(on_configuration_changed)
