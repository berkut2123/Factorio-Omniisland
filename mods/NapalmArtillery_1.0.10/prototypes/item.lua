data:extend(
{
	{
		type = "ammo",
		name = "napalm-artillery-shell",
		icon = "__NapalmArtillery__/graphics/napalm-artillery-shell.png",
		icon_size = 64, icon_mipmaps = 3,
		ammo_type =
		{
			category = "artillery-shell",
			target_type = "position",
			action =
			{
				type = "direct",
				action_delivery =
				{
					type = "artillery",
					projectile = "napalm-artillery-projectile",
					starting_speed = 1,
					direction_deviation = 0,
					range_deviation = 0,
					source_effects =
					{
						type = "create-explosion",
						entity_name = "artillery-cannon-muzzle-flash"
					},
				}
			},
		},
		subgroup = "ammo",
		order = "d[explosive-cannon-shell]-d[artillery]",
		stack_size = settings.startup["settings-napalm-art-stack"].value,
	}
}
)