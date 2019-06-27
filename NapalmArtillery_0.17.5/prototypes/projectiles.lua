
local napalmFire = table.deepcopy(data.raw["fire"]["fire-flame"])
napalmFire.name = "napalm-art-flame"
napalmFire.initial_lifetime = 1000
napalmFire.damage_per_tick = { amount = 200 / 60, type = "fire" }
napalmFire.on_fuel_added_action = nil
napalmFire.damage_multiplier_decrease_per_tick = 0.0005
napalmFire.maximum_damage_multiplier = 1
napalmFire.fade_out_duration = 100
napalmFire.lifetime_increase_by = 0



local math3d = require "math3d"


data:extend(
{
napalmFire,

  {
    type = "sticker",
    name = "napalm-art-sticker",
    flags = {"not-on-map"},

    animation =
    {
      filename = "__base__/graphics/entity/fire-flame/fire-flame-13.png",
      line_length = 8,
      width = 60,
      height = 118,
      frame_count = 25,
      axially_symmetrical = false,
      direction_count = 1,
      blend_mode = "normal",
      animation_speed = 1,
      scale = 0.2,
      tint = { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }, --{ r = 1, g = 1, b = 1, a = 0.35 },
      shift = math3d.vector2.mul({-0.078125, -1.8125}, 0.1),
    },

    duration_in_ticks = 60 * 60,
    target_movement_modifier = 0.7,
    damage_per_tick = { amount = 100 / 60, type = "fire" },
    spread_fire_entity = "fire-flame-on-tree",
    fire_spread_cooldown = 40,
    fire_spread_radius = 0.1,
  },

  
  
  

	{
		type = "artillery-projectile",
		name = "napalm-artillery-projectile",
		flags = {"not-on-map"},
		acceleration = 0,
		direction_only = true,
		reveal_map = true,
		map_color = {r=1, g=0, b=0},
		picture =
		{
			filename = "__NapalmArtillery__/graphics/hr-napalm-shell.png",
			width = 64,
			height = 64,
			scale = 0.5,
		},
		shadow =
		{
			filename = "__base__/graphics/entity/artillery-projectile/hr-shell-shadow.png",
			width = 64,
			height = 64,
			scale = 0.5,
		},
		chart_picture =
		{
			filename = "__NapalmArtillery__/graphics/napalm-shoot-map.png",
			flags = { "icon" },
			frame_count = 1,
			width = 64,
			height = 64,
			priority = "high",
			scale = 0.25,
		},
		action =
		{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						repeat_count = settings.startup["settings-napalm-art-area"].value,
						type = "create-trivial-smoke",
						smoke_name = "nuclear-smoke",
						offset_deviation = {{-1, -1}, {1, 1}},
						slow_down_factor = 1,
						starting_frame = 3,
						starting_frame_deviation = 5,
						starting_frame_speed = 0,
						starting_frame_speed_deviation = 5,
						speed_from_center = 0.5,
						speed_deviation = 0.2
					},
					{
						type = "create-entity",
						entity_name = "explosion"
					},
					{
						type = "damage",
						damage = {amount = 400, type = "explosion"}
					},
					{
						type = "damage",
						damage = {amount = 500, type = "fire"}
					},
					{
						type = "create-entity",
						entity_name = "small-scorchmark",
						check_buildability = true
					},
					{
						type = "nested-result",
						action =
						{
							type = "cluster",
							cluster_count = settings.startup["settings-napalm-art-clusters"].value,
							distance = 2,
							distance_deviation = settings.startup["settings-napalm-art-area"].value,
							action_delivery =
							{
								type = "projectile",
								projectile = "napalm-fire",
								direction_deviation = 0.6,
								starting_speed = 0.3,
								starting_speed_deviation = 0.1
							}
						}
					}
				}
			},
		},

        {
                type = "area",
                radius = 10,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                       -- {
                      --      type = "damage",
                      --      damage = { amount = 100, type = "fire" }
                      --  },
                        {
                            type = "create-fire",
                            entity_name = "napalm-art-flame"
                        },
                        {
                            type = "create-sticker",
                            sticker = "napalm-art-sticker"
                        }
                    }
                }
        }

			
		},
		final_action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "small-scorchmark",
						check_buildability = true
					}
				}
			}
		},
		animation =
		{
			filename = "__base__/graphics/entity/bullet/bullet.png",
			frame_count = 1,
			width = 3,
			height = 50,
			priority = "high"
		}
	},
	
	
	
	
	{
		type = "projectile",
		name = "napalm-fire",
		flags = {"not-on-map"},
		acceleration = 0.005,
		action =
		{
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "create-fire",
							entity_name = "napalm-art-flame",
							initial_ground_flame_count = 30,
						},
					}
				}
			},
			{
				type = "area",
				radius = 10,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
					{
						type = "create-sticker",
						sticker = "napalm-art-sticker"
					},
				--	{
			--			type = "damage",
				--		damage = { amount = 10, type = "fire" }
			--		}
					}
				}
			},
		},
		light = {intensity = 0.5, size = 10},
		animation =
		{
			filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
			frame_count = 1,
			width = 24,
			height = 24,
			priority = "high"
		},
		shadow =
		{
			filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
			frame_count = 1,
			width = 24,
			height = 24,
			priority = "high"
		}
	},	

}
)