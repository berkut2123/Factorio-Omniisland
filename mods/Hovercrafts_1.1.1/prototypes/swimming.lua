-- prototypes.swimming.lua


-- only add if not already there (from CanalBuilder mod)
for i=1,10 do

	data:extend{{
		type = "smoke-with-trigger",
		name = "water-splash-smoke-"..i,
		flags = {"not-on-map", "placeable-off-grid"},
		render_layer = "decorative",
		show_when_smoke_off = true,
		deviation = {0, 0},
		start_scale = 1,
		end_scale = 1,
		animation =
		{
			filename = "__Hovercrafts__/graphics/water-splash.png",
			priority = "extra-high",
			width = 92,
			height = 66,
			frame_count = 15,
			line_length = 5,
			shift = {-0.437, 0.5},
			--tint={r=0.6,g=0.6,b=0.6,a=0.5},
			animation_speed = 0.28, --0.35
			scale = 0.5+i/9,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 43,
		fade_away_duration = 0,
		spread_duration = 0,
		color = { r = 0.8, g = 0.8, b = 0.8 },
		action = nil,
		action_cooldown = 0
	}}
end


if data.raw["smoke-with-trigger"]["water-ripple1-smoke"] == nil then
-- ripple animations
	for i=1,4 do
		data:extend{{
			type = "smoke-with-trigger",
			name = "water-ripple" .. i .. "-smoke",
			flags = {"not-on-map", "placeable-off-grid"},
			render_layer = "tile-transition",
			show_when_smoke_off = true,
			deviation = {0, 0},
			animation =
			{
				filename = "__Hovercrafts__/graphics/ripple" .. i .. ".png",
				priority = "extra-high",
				width = 192,
				height = 128,
				frame_count = 48,
				line_length = 8,
				shift = {0, 0.5},
				animation_speed = 0.25
			},
			slow_down_factor = 0,
			affected_by_wind = false,
			cyclic = false,
			duration = 192,
			fade_away_duration = 0,
			spread_duration = 0,
			color = {r = 0.3, g = 0.8, b = 0.9},
			action = nil,
			action_cooldown = 0
		}}
	end
end

 


