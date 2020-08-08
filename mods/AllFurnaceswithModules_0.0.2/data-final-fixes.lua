for furnaces, entity in pairs(data.raw["furnace"]) do
	if entity.module_specification  == nil then
		data.raw["furnace"][entity.name].module_specification = {module_slots = 2,module_info_icon_shift = {0, 0.8}}
		data.raw["furnace"][entity.name].allowed_effects = {"consumption", "speed", "productivity", "pollution"}
	end
end  

for drills, entity in pairs(data.raw["mining-drill"]) do
	if entity.module_specification  == nil then
		data.raw["mining-drill"][entity.name].module_specification = {module_slots = 2,module_info_icon_shift = {0, 0.8}}
		data.raw["mining-drill"][entity.name].allowed_effects = {"consumption", "speed", "productivity", "pollution"}
	end
end  


for assemblings, entity in pairs(data.raw["assembling-machine"]) do
	if entity.module_specification  == nil then
		data.raw["assembling-machine"][entity.name].module_specification = {module_slots = 2,module_info_icon_shift = {0, 0.8}}
		data.raw["assembling-machine"][entity.name].allowed_effects = {"consumption", "speed", "productivity", "pollution"}
	end
end  



