local radars = {}

for radar_amplification_type = 0, 9 do --for mk 1 radars
    for radar_efficiency_type = 0, 9 do
        local max_distance_of_sector_revealed = data.raw['radar']['radar'].max_distance_of_sector_revealed + radar_amplification_type * 3
        local max_distance_of_nearby_sector_revealed = data.raw['radar']['radar'].max_distance_of_nearby_sector_revealed + radar_amplification_type * 2
        local extra_energy_cost = 75 * radar_amplification_type

        -- base time to scan is ~40s
        local energy_per_sector = (10000 * (1.5 ^ radar_amplification_type)) / (1 + math.pow(radar_efficiency_type, 1.5))

        local radar = table.deepcopy(data.raw['radar']['radar'])
        radar.name = 'big_brother-radar_ra-' .. radar_amplification_type .. '_re-' .. radar_efficiency_type
        radar.max_distance_of_sector_revealed = max_distance_of_sector_revealed
        radar.max_distance_of_nearby_sector_revealed = max_distance_of_nearby_sector_revealed
        radar.energy_per_sector = energy_per_sector .. "KJ"
        radar.energy_usage = (300 * (1.5 ^ radar_amplification_type)) .. "kW"
        radar.order ="d-c"
        radar.localised_name = {"entity-name.radar"}

        
        table.insert(radars, radar)
    end
end

if data.raw['radar']['radar-2'] then --if there is a radar mk 2 check
	for radar_mark = 2, 5 do
		for radar_amplification_type = 0, 9 do
			for radar_efficiency_type = 0, 9 do
				local max_distance_of_sector_revealed = data.raw['radar']['radar-' ..  radar_mark].max_distance_of_sector_revealed + radar_amplification_type * 3
				local max_distance_of_nearby_sector_revealed = data.raw['radar']['radar-' ..  radar_mark].max_distance_of_nearby_sector_revealed + radar_amplification_type * 2
				local extra_energy_cost = 75 * radar_amplification_type
				local energy_usagestring = data.raw['radar']['radar-' ..  radar_mark].energy_usage
				local energy_usage = tonumber(string.sub(energy_usagestring,1, string.len(energy_usagestring)-2))
		
				-- base time to scan is ~40s
				local energy_per_sector = (10000 * (1.5 ^ radar_amplification_type)) / (1 + math.pow(radar_efficiency_type, 1.5))
		
				local radar = table.deepcopy(data.raw['radar']['radar-' ..  radar_mark])
				radar.name = 'big_brother-radar_ra-' .. radar_amplification_type .. '_re-' .. radar_efficiency_type .. '_mk-' .. radar_mark
				radar.max_distance_of_sector_revealed = max_distance_of_sector_revealed
				radar.max_distance_of_nearby_sector_revealed = max_distance_of_nearby_sector_revealed
				radar.energy_per_sector = energy_per_sector .. "KJ"
				radar.energy_usage = (energy_usage * (1.5 ^ radar_amplification_type)) .. "kW"
				radar.order ="d-c"
				
				table.insert(radars, radar)
			end
		end
	end
end

data:extend(radars)
