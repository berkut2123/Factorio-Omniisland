local Informatron = {} -- informatron pages implementation.

function Informatron.menu(player_index)
  local player = game.players[player_index]
  local menu = {
    --jetpack = 1, -- already exists due to mod name
  }
  return menu
end

function Informatron.page_content(page_name, player_index, element)
  local player = game.players[player_index]
  if page_name == "jetpack" then
    element.add{type="label", name="text_1", caption={"jetpack.page_jetpack_text_1"}}
  end
end

return Informatron
