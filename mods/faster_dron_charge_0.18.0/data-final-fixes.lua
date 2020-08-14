data.raw.roboport.roboport.robot_slots_count = 20
data.raw.roboport.roboport.material_slots_count = 10


local robot_ch = settings.startup["mc-robot_charge_speed"].value
local robot_capacity = settings.startup["mc-robot_capacity"].value


if robot_ch ~= 1 then
	for k,i in pairs(data.raw.roboport) do
		local N = i.charging_energy:gsub("%a", "")
		local W = i.charging_energy:gsub("%A", "")
		i.charging_energy = N * robot_ch .. W
		i.charge_approach_distance = i.charge_approach_distance / robot_ch
	end
	for k,i in pairs(data.raw.roboport) do
		if i.energy_source.input_flow_limit then
			local N = i.energy_source.input_flow_limit:gsub("%a", "")
			local W = i.energy_source.input_flow_limit:gsub("%A", "")
			i.energy_source.input_flow_limit = N * robot_ch .. W
		end
	end
	for k,i in pairs(data.raw["roboport-equipment"]) do
		local N = i.charging_energy:gsub("%a", "")
		local W = i.charging_energy:gsub("%A", "")
		i.charging_energy = N * robot_ch .. W
	end
	for k,i in pairs(data.raw["roboport-equipment"]) do
		if i.energy_source.input_flow_limit then
			local N = i.energy_source.input_flow_limit:gsub("%a", "")
			local W = i.energy_source.input_flow_limit:gsub("%A", "")
			i.energy_source.input_flow_limit = N * robot_ch .. W
		end
	end
end

if robot_capacity ~= 1 then
	for k,i in pairs(data.raw["logistic-robot"]) do
		local N = i.max_energy:gsub("%a", "")
		local W = i.max_energy:gsub("%A", "")
		i.max_energy = N * robot_capacity .. W
	end
	for k,i in pairs(data.raw["construction-robot"]) do
		local N = i.max_energy:gsub("%a", "")
		local W = i.max_energy:gsub("%A", "")
		i.max_energy = N * robot_capacity .. W
	end
end

if mods["5dim_logistic"]  then
	require("prototypes.5dim")
end
if mods["boblogistics"] then
	require("prototypes.bob")
end