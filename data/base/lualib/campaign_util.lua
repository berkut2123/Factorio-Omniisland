require 'util'

local campaign_util = {}

campaign_util.flying_congrats = function()
  local position = main_player().position
  if not position.x then position.x = position[1] end
  if not position.y then position.y = position[2] end
  game.surfaces[1].create_entity{name = "tutorial-flying-text", text = {"tutorial-gui.objective-complete"},
                                 position = {position.x, position.y - 1.5}, color = {r = 12, g = 243, b = 56}}
end

campaign_util.flying_tech_unlocked = function()
  local position = main_player().position
  if not position.x then position.x = position[1] end
  if not position.y then position.y = position[2] end
  position.y = position.y - 1
  game.surfaces[1].create_entity{name = "tutorial-flying-text", text = {"tutorial-gui.new-technologies-available"},
                                 position = {position.x, position.y - 1.5}, color = {r = 1, g = 0.8, b = 0}}
end

campaign_util.set_quick_bar = function(item_list)
  for _, player in pairs(game.connected_players) do
    for s = 1, 20 do
      if item_list[s] and game.item_prototypes[item_list[s]] then
        player.set_quick_bar_slot(s,item_list[s])
      end
    end
  end
end

return campaign_util