-- Note: Default entity force will be 'capture', if a player character get near and there are no enemies the player will capture the entity.
local satellite = {
  center = {x = 0, y = 0},
  landing_offset = {0.5,5}, -- only used in the satelliet blueprint, not normal ruins
  force_name = "friendly",
	insert_list = {
    {x=3,  y=2, items={{name = "automation-science-pack", min = 1000, max = 1000},
                       {name = "logistic-science-pack", min = 1000, max = 1000},
                       {name = "chemical-science-pack", min = 1000, max = 1000},
                       {name = mod_prefix.."rocket-science-pack", min = 1000, max = 1000},
                      }},
    {x=3,  y=4, items={{name = "iron-plate", min = 1000, max = 1000},
                       {name = "copper-plate", min = 1000, max = 1000},
                       {name = mod_prefix.."beryllium-plate", min = 1000, max = 1000},
                       {name = mod_prefix.."vulcanite-block", min = 1000, max = 1000},
                      }},
    {x=3,  y=6, items={{name = mod_prefix.."space-platform-plating", min = 100, max = 100},
                       {name = mod_prefix.."space-platform-scaffold", min = 200, max = 200},
                      }},
    {x=-3, y=2, items={{name = "solar-panel", min = 10, max = 10},
                       {name = mod_prefix.."space-science-lab"},
                      }},
    {x=-3, y=4, items={{name = "raw-fish", min = 10, max = 10},
                       {name = mod_prefix.."medpack-4"},
                      }},
                 },
  prebuild = function(surface, ruin_position, ruin) -- surface, position, self (maybe modified)
    -- function that runs before tiles and entities are added
    --game.print("test start")
    local r = math.random(1,3)
    if r == 1 then
      table.insert(ruin.insert_list, {x=-3, y=6, items={{name = mod_prefix.."tesla-gun"},
                                   {name = mod_prefix.."tesla-ammo", min = 200, max = 200}
            }})
    elseif r == 2 then
      table.insert(ruin.insert_list, {x=-3, y=6, items={{name = mod_prefix.."cryogun"},
                                   {name = mod_prefix.."cryogun-ammo", min = 200, max = 200}
            }})
    elseif r == 3 then
      table.insert(ruin.insert_list, {x=-3, y=6, items={{name = mod_prefix.."biogun"},
                                   {name = mod_prefix.."bloater-ammo", min = 100, max = 100}
            }})
    elseif r == 4 then
      table.insert(ruin.insert_list, {x=-3, y=6, items={{name = mod_prefix.."railgun"},
                                   {name = mod_prefix.."railgun-dart", min = 100, max = 100}
            }})
    end
  end,
  postbuild = function(surface, ruin_position, ruin)
    --surface.create_entity({name="iron-chest",position={x=ruin_position.x - ruin.center.x, y=ruin_position.y - ruin.center.y}})
    -- surface, position, self (maybe modified)
    -- function that runs after tiles and entities are added
    -- maybe required to set conditions
    --[[local accumulator = surface.find_entity("accumulator",
      {
        x = 10.5 + ruin_position.x - ruin.center.x,
        y = 8.5 + ruin_position.y - ruin.center.y
      }
    )
    local control = accumulator.get_or_create_control_behavior() -- https://lua-api.factorio.com/latest/LuaControlBehavior.html#LuaAccumulatorControlBehavior
    control.output_signal = {type = "virtual", name = "signal-B"}
    game.print("test end")
    ]]
  end,
  blueprint_strings = {{string =
  "0eNqtmuuOmzAQhd/Fv2GFb9xepVpVDnG2SAQQkKpRxLuXXLpdKXRZ+PonSiLO8fjYZsYzcxG76uTbrqwHkV9EWTR1L/JvF9GXb7Wrrv8N59aLXJSDP4pA1O54/dX7sG9dMX02levC1tW+EmMgynrvf4lcjq+B8PVQDqW/891+nL/Xp+POd9MD70yd27tuIm6bfnq6qa9DTgxRIM4iD9NxDJ7A6nMznrhCaV/snU+92DlGvZpRLjCatYzJAqF9J3RFcTqeKjc0M7qFeoEn/mhYe66aOuxPu35wN5InviW6ZOU8l6aZruRbXIhsLeHSXpHRX8bB+yosfvh+mFuJG42a5ZBf4/iMQq0yw8xy6DVmzFOYVWbEsxx2jRkTxfRyGcrq8WZ5OprJffnM+Lzy7XRqDk13vH0p6zdxteZfBJoSKEogNxPEVIOYahBTDWKqgaUaWKqBpRpYqoGhGhiqgaEaGKqBphpoqoGmGmiqgaIaKKqBohooqoGkGkiqgaQaSKpBRDWIqAYR1SCCGmRQggwqkEEBMjj/FM4/hfNP4fxTOH8aHtLokAaHNDakoSGNDGlgSOPCrwRlfeEOh6bazxLQkIhGRDQc0f9lfAg3DB5vhSu6+ncCDfEG4i3Ex5vxjxAk2+y//yT2GD6BeA3xiuEhHFpvGNwyeMzgW1c+Yhs3Yvs2Ytv2Ad98bB94y4Y3cHjNhlcMLpn1ERpdIjSbOZPdIDTbcTFCs8O29aRDBwn9I3SP0DtC58h8I3ONzDMyx8j8InOLNCCG8TAMh2E0DINheBODFzF2D2PXMHYLgzdoeIGmCQCYQIH5E5g+gdkTmDyDuTOYOoOZM5g4hXlTmDaFWVOYNIc5c5gyhxlzWjShNRNaMqEVE1o4o3UzWjajVTNaPKW1U1o6pZVTWkCn9XNaPqfVc9pEQXsoaAsF7aCgjTS0j4a20dAuGtpMRXupaCsV7aSiDXW0n462063rpnsN7q3O+YfO6ED89F1/Y0wSLaPUaqnkOP4GzTYEdw=="
  }}
}

return satellite
