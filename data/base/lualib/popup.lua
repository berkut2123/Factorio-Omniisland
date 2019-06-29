--- Test Scenario recipe-pop
-- @module popup
-- Create a popup that appears every time a research is complete to
-- tell you new recipes and effects.


local popup = {}


local popup_data = {}

popup.clear = function(player)
  if player.gui.center['popup-flow'] then
    player.gui.center['popup-flow'].destroy()
  end
end

function popup.create(player, caption)
  popup.clear(player)

  local flow = player.gui.center.add({
    type='flow',
    name='popup-flow',
    direction='vertical'
    })
  --flow.style.width = 420
  flow.style.height = player.display_resolution.height*0.8/player.display_scale
  flow.style.vertical_align="bottom"
  flow.style.horizontal_align="center"

  local frame = flow.add({
    type='frame',
    name='popup',
    direction='vertical',
    caption=caption
    })
  frame.style.vertically_stretchable = false
  frame.ignored_by_interaction = false
  frame.style.use_header_filler = false

  local player_popup_data = {
    flow = flow,
    expire_tick = game.tick + 60 * 20
  }

  popup_data[player.index] = player_popup_data

  return frame
end

function popup.create_technology_popup(player, techname)
  local frame = popup.create(player, {"tutorial-gui.research-tooltip-heading"})

  frame.add({
    type='label',
    caption={"tutorial-gui.new-recipes-available"}
    })
  local t = frame.add({
    type='table',
    column_count = 3
    })
  local prototype = player.force.technologies[techname].prototype
  for _, effect in pairs(prototype.effects) do
    if effect.type == 'unlock-recipe' then
      local recipe = player.force.recipes[effect.recipe]
      local name = {"", "[font=default-bold]", recipe.localised_name, "[/font]", "  ", "[img=", recipe.products[1].type, "/",
                    recipe.products[1].name, "]"}
      t.add({
        type='label',
        caption=name
        })
    end
  end
  local button = t.add({
    type='button',
    name='close',
    caption='X'
  })
  button.style.top_padding = 0
  button.style.bottom_padding = 0
  button.style.height = 23
end

function popup.clear(player)
  if popup_data[player.index] ~= nil then
    popup_data[player.index].flow.destroy()
    popup_data[player.index] = nil
  end
end

function popup.clear_all()
  for player_index, _ in pairs(popup_data) do
    popup.clear(game.players[player_index])
  end
end

local on_gui_click = function(event)
  if event.element then
    if event.element.name == 'close' and event.element.parent.parent.name == 'popup' then
      event.element.parent.parent.visible = false
    elseif event.element.name == 'popup' then
      event.element.visible = false
    end
  end
end

local on_tick = function()
  for player_index, player_popup_data in pairs(popup_data) do
    if game.tick > player_popup_data.expire_tick then
      popup.clear(game.players[player_index])
    end
  end
end

local on_research_finished = function(event)
  local force = event.research.force
  if event.by_script == false then
    for _, player in pairs(force.players) do
      popup.clear(player)
      popup.create_technology_popup(player, event.research.name)
    end
  end
end

popup.init = function()
  global.popup_data = popup_data
end

popup.on_load = function()
  popup_data = global.popup_data or popup_data
end

popup.events = {
  [defines.events.on_gui_click] = on_gui_click,
  [defines.events.on_research_finished] = on_research_finished,
  [defines.events.on_tick] = on_tick,
}

return popup

