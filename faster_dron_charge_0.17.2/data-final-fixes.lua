data.raw.roboport.roboport.robot_slots_count = 20
data.raw.roboport.roboport.material_slots_count = 10


local robot_ch = settings.startup["mc-robot_charge_speed"].value
local robot_capacity = settings.startup["mc-robot_capacity"].value


if robot_ch ~= 1 then
	for k,_ in pairs(data.raw.roboport) do
		local N = string.gsub(data.raw.roboport[k].charging_energy, "%a", "")
		local W = string.gsub(data.raw.roboport[k].charging_energy, "%A", "")
		data.raw.roboport[k].charging_energy = N * robot_ch .. W
		data.raw.roboport[k].charge_approach_distance = data.raw.roboport[k].charge_approach_distance / robot_ch
	end
	for k,_ in pairs(data.raw.roboport) do
		local N = string.gsub(data.raw.roboport[k].energy_source.input_flow_limit, "%a", "")
		local W = string.gsub(data.raw.roboport[k].energy_source.input_flow_limit, "%A", "")
		data.raw.roboport[k].energy_source.input_flow_limit = N * robot_ch .. W
	end
	for k,_ in pairs(data.raw["roboport-equipment"]) do
		local N = string.gsub(data.raw["roboport-equipment"][k].charging_energy, "%a", "")
		local W = string.gsub(data.raw["roboport-equipment"][k].charging_energy, "%A", "")
		data.raw["roboport-equipment"][k].charging_energy = N * robot_ch .. W
	end
	for k,_ in pairs(data.raw["roboport-equipment"]) do
		local N = string.gsub(data.raw["roboport-equipment"][k].energy_source.input_flow_limit, "%a", "")
		local W = string.gsub(data.raw["roboport-equipment"][k].energy_source.input_flow_limit, "%A", "")
		data.raw["roboport-equipment"][k].energy_source.input_flow_limit = N * robot_ch .. W
	end
end

if robot_capacity ~= 1 then
	for k,_ in pairs(data.raw["logistic-robot"]) do
		local N = string.gsub(data.raw["logistic-robot"][k].max_energy, "%a", "")
		local W = string.gsub(data.raw["logistic-robot"][k].max_energy, "%A", "")
		data.raw["logistic-robot"][k].max_energy = N * robot_capacity .. W
	end
	for k,_ in pairs(data.raw["construction-robot"]) do
		local N = string.gsub(data.raw["construction-robot"][k].max_energy, "%a", "")
		local W = string.gsub(data.raw["construction-robot"][k].max_energy, "%A", "")
		data.raw["construction-robot"][k].max_energy = N * robot_capacity .. W
	end
end

if mods["5dim_logistic"]  then
	require("prototypes.5dim")
end
if mods["boblogistics"] then
	require("prototypes.bob")
end