if data.raw.technology["military"] then
		table.insert(data.raw.technology["military"].effects, {type="unlock-recipe", recipe="submachine-gun-sn"})
       
end
if data.raw.technology["military"] then
		table.insert(data.raw.technology["military"].effects, {type="unlock-recipe", recipe="gun-sn-mag"})
       
end

if mods["bullet-trails"] then 
		add_trail_to_ammo('gun-sn-mag', "bullet-beam-red-faint")
       
end
