local allow_in_space = function(type, name)
  if data.raw[type][name] then
    data.raw[type][name].se_allow_in_space = true
  end
end

local add_crafting_category = function(type, name, category)
  if data.raw[type][name] then
    table.insert( data.raw[type][name].crafting_categories, category)
  end
end
-- by Bernd
allow_in_space("storage-tank", "angels-pressure-tank-1")

-- by Walter
for name in pairs(data.raw["assembling-machine"]) do
  if( string.match(name,'[.]*chemical.plant[.]*')) then
    table.insert(data.raw["assembling-machine"][name].crafting_categories, "pressure-washing")
    --add_crafting_category("assembling-machine", name, "pressure-washing")
  end
end


local armor = data.raw.armor

for _, damage_type in pairs({"radioactive", "radiation", "radioactivity"}) do

  if data.raw["damage-type"][damage_type] then

    local resistances = table.deepcopy(armor["se-thruster-suit"].resistances)
    table.insert(resistances, {type = damage_type, decrease = 3, percent = 30})
    armor["se-thruster-suit"].resistances = resistances

    resistances = table.deepcopy(armor["se-thruster-suit-2"].resistances)
    table.insert(resistances, {type = damage_type, decrease = 4, percent = 45})
    armor["se-thruster-suit-2"].resistances = resistances

    resistances = table.deepcopy(armor["se-thruster-suit-3"].resistances)
    table.insert(resistances, {type = damage_type, decrease = 5, percent = 60})
    armor["se-thruster-suit-3"].resistances = resistances

    resistances = table.deepcopy(armor["se-thruster-suit-3"].resistances)
    table.insert(resistances, {type = damage_type, decrease = 6, percent = 80})
    armor["se-thruster-suit-4"].resistances = resistances

  end
end
