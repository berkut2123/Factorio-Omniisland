local effects = require(mod_name .. '.lualib.effects')

local eastern_cutscene_biters = {}
local eastern_cutscene_biters_data =
{
  scout_group = nil,
  close_in_group = nil,
  advance_group = nil,
  east_flank_worm_group = nil,
}

eastern_cutscene_biters.get_scout_group = function(quant)
  if not eastern_cutscene_biters_data.scout_group then
    if quant == nil then quant = 5 end
    local group = effects.spawn_biters(quant, 'spawn-1', 'peaceful','small-biter',true)
    eastern_cutscene_biters_data.scout_group =
    {
      group = group,
      members = group.members
    }
  end
  return eastern_cutscene_biters_data.scout_group.group
end

eastern_cutscene_biters.get_advance_group = function(quant)
  if not eastern_cutscene_biters_data.advance_group then
    if quant == nil then quant = 5 end
    local group = effects.spawn_biters(quant, 'spawn-1', 'peaceful','small-biter',true)
    eastern_cutscene_biters_data.advance_group =
    {
      group = group,
      members = group.members
    }
  end
  return eastern_cutscene_biters_data.advance_group.group
end

eastern_cutscene_biters.get_close_in_group = function(quant)
  if not eastern_cutscene_biters_data.close_in_group then
    if quant == nil then quant = 6 end
    local group = effects.spawn_biters(quant, 'spawn-1', 'peaceful','small-biter',true)
    eastern_cutscene_biters_data.close_in_group =
    {
      group = group,
      members = group.members
    }
  end
  return eastern_cutscene_biters_data.close_in_group.group
end

eastern_cutscene_biters.get_east_flank_worm_group = function(quant)
  if not eastern_cutscene_biters_data.east_flank_worm_group then
    if quant == nil then quant = 6 end
    local group = effects.spawn_biters(quant, 'spawn-2', 'enemy','small-biter',true)
    eastern_cutscene_biters_data.east_flank_worm_group =
    {
      group = group,
      members = group.members
    }
  end
  return eastern_cutscene_biters_data.east_flank_worm_group.group
end

eastern_cutscene_biters.destroy_all = function()
  for _, name in pairs({"scout_group", "close_in_group"}) do
    if eastern_cutscene_biters_data[name] then
      for _, biter in pairs(eastern_cutscene_biters_data[name].members) do
        if biter.valid then
          biter.destroy()
        end
      end
      eastern_cutscene_biters_data[name] = nil
    end
  end
end

eastern_cutscene_biters.init = function()
  global.eastern_cutscene_biters_data = eastern_cutscene_biters_data
end

eastern_cutscene_biters.on_load = function()
  eastern_cutscene_biters_data = global.eastern_cutscene_biters_data or eastern_cutscene_biters_data
end

return eastern_cutscene_biters