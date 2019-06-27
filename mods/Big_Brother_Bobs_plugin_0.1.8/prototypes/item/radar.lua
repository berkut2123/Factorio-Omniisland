local radars = {}

if data.raw['radar']['radar-2'] then
	for radar_mark = 2, 5 do
		for radar_amplification_type = 0, 9 do
			for radar_efficiency_type = 0, 9 do
				local radar = table.deepcopy(data.raw.item['radar-' .. radar_mark])
				radar.name = 'big_brother-radar_ra-' .. radar_amplification_type .. '_re-' .. radar_efficiency_type .. '_mk-' .. radar_mark
				radar.place_result = 'big_brother-radar_ra-' .. radar_amplification_type .. '_re-' .. radar_efficiency_type .. '_mk-' .. radar_mark
				table.insert(radars, radar)
			end
		end
	end
	data:extend(radars)
end

-- for radar_amplification_type = 0, 9 do
	-- for radar_efficiency_type = 0, 9 do
		-- local radar = table.deepcopy(data.raw.item['radar'])
		-- radar.name = 'big_brother-radar_ra-' .. radar_amplification_type .. '_re-' .. radar_efficiency_type
		-- radar.place_result = 'big_brother-radar_ra-' .. radar_amplification_type .. '_re-' .. radar_efficiency_type
		-- table.insert(radars, radar)
	-- end
-- end