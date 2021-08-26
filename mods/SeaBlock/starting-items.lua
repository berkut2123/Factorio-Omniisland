seablock = seablock or {}

function seablock.populate_starting_items(dest, items)
  dest.starting_items = {
    ['stone'] = 65,
    ['small-electric-pole'] = 50,
    ['small-lamp'] = 12,
    ['iron-plate'] = 1200,
    ['basic-circuit-board'] = 200,
    ['stone-pipe'] = 100,
    ['stone-pipe-to-ground'] = 50,
    ['stone-brick'] = 500,
    ['pipe'] = 22,
    ['copper-pipe'] = 5,
    ['iron-gear-wheel'] = 20,
    ['iron-stick'] = 108,
    ['pipe-to-ground'] = 2
  }

  -- Starting power production
  if items['wind-turbine-2'] then
    dest.starting_items['wind-turbine-2'] = 120
  else
    dest.starting_items['solar-panel'] = 38
    dest.starting_items['accumulator'] = 32
  end

  -- Starting landfill
  local landfill
  setting = settings.startup['sb-default-landfill']
  if setting and items[setting.value] then
    landfill = setting.value
  else
    landfill = 'landfill'
  end
  dest.starting_items[landfill] = 2000
end
