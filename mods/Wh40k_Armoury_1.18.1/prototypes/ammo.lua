data:extend(
{
--------------------75----------------------
--------------------mk1----------------
{
    type = "ammo",
    name = "bolt75mk1",
    icon = "__Wh40k_Armoury__/graphics/icons/bolt75mk1.png",
    icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bolt75",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
              type = "create-explosion",
              entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-hit"
            },
            {
              type = "damage",
              damage = { amount = 20 , type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "b[bolt]-a[75]-a",
    stack_size = 100
},
-------------------Mk2----------------
{
    type = "ammo",
    name = "bolt75mk2",
    icon = "__Wh40k_Armoury__/graphics/icons/bolt75mk2.png",
    icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bolt75",
      action =
	 	{
			type = "direct",
			repeat_count = 1,
			action_delivery =
			{
				type = "projectile",
				projectile = "mk2boom75",
				starting_speed = 3,
				direction_deviation = 0,
				range_deviation = 0,
				max_range = 30,
				min_range = 3,
			},
		},
	},
	magazine_size = 10,
    subgroup = "ammo",
    order = "b[bolt]-a[75]-b",
    stack_size = 100
},
--------------------Metal Storm----------------
{
    type = "ammo",
    name = "bolt75metalstorm",
    icon = "__Wh40k_Armoury__/graphics/icons/bolt75metalstorm.png",
    icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bolt75",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = 20,
          action_delivery =
          {
            type = "projectile",
            projectile = "metalstorm75",
            starting_speed = 2,
            direction_deviation = 0.5,
            range_deviation = 0.5,
            max_range = 30
          }
        }
      }
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "b[bolt]-a[75]-c",
    stack_size = 100
},
-------------------Kraken----------------
{
    type = "ammo",
    name = "bolt75kraken",
    icon = "__Wh40k_Armoury__/graphics/icons/bolt75kraken.png",
    icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bolt75",
      action =
      {
				type = "direct",
				repeat_count = 1,
				action_delivery =
				{
					type = "projectile",
					projectile = "kraken75",
					starting_speed = 4,
					direction_deviation = 0,
					range_deviation = 0,
					max_range = 50,
					--min_range = 0.1,
            },
          },
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "b[bolt]-a[75]-d",
    stack_size = 100
},
-----------------Hellfire----------------
{
		type = "ammo",
		name = "bolt75hellfire",
		icon = "__Wh40k_Armoury__/graphics/icons/bolt75hellfire.png",
		icon_size = 32,
		flags = {},
		ammo_type =
		{
			category = "bolt75",
			action =
			{
				type = "direct",
				repeat_count = 1,
				action_delivery =
				{
					type = "projectile",
					projectile = "hellfire75",
					starting_speed = 4,
					direction_deviation = 0,
					range_deviation = 0,
					max_range = 30,
					--min_range = 0,
				}
			},
		},
    magazine_size = 10,
    subgroup = "ammo",
    order = "b[bolt]-a[75]-e",
    stack_size = 100
},
-----------------Inferno----------------
{
		type = "ammo",
		name = "bolt75inferno",
		icon = "__Wh40k_Armoury__/graphics/icons/bolt75inferno.png",
		icon_size = 32,
		flags = {},
		ammo_type =
		{
			category = "bolt75",
			action =
			{
				type = "direct",
				repeat_count = 1,
				action_delivery =
				{
					type = "projectile",
					projectile = "inferno75",
					starting_speed = 4,
					direction_deviation = 0,
					range_deviation = 0,
					max_range = 30,
					--min_range = 0,
				}
			},
		},
    magazine_size = 10,
    subgroup = "ammo",
    order = "b[bolt]-a[75]-f",
    stack_size = 100
},
--------------------100----------------------
--------------------mk1----------------  
{
    type = "ammo",
    name = "bolt100mk1",
    icon = "__Wh40k_Armoury__/graphics/icons/bolt100mk1.png",
    icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bolt100",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
              type = "create-explosion",
              entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-hit"
            },
            {
              type = "damage",
              damage = { amount = 40 , type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 20,
    subgroup = "ammo",
    order = "b[bolt]-b[100]-a",
    stack_size = 100
},
-------------------Mk2----------------
{
    type = "ammo",
    name = "bolt100mk2",
    icon = "__Wh40k_Armoury__/graphics/icons/bolt100mk2.png",
    icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bolt100",
      action =
	 	{
			type = "direct",
			repeat_count = 1,
			action_delivery =
			{
				type = "projectile",
				projectile = "mk2boom100",
				starting_speed = 3,
				direction_deviation = 0,
				range_deviation = 0,
				max_range = 40,
				min_range = 3,
			},
		},
	},
	magazine_size = 20,
    subgroup = "ammo",
    order = "b[bolt]-b[100]-b",
    stack_size = 100
},
--------------------Metal Storm----------------
{
    type = "ammo",
    name = "bolt100metalstorm",
    icon = "__Wh40k_Armoury__/graphics/icons/bolt100metalstorm.png",
    icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bolt100",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = 20,
          action_delivery =
          {
            type = "projectile",
            projectile = "metalstorm100",
            starting_speed = 2,
            direction_deviation = 0.7,
            range_deviation = 0.7,
            max_range = 40
          }
        }
      }
    },
    magazine_size = 20,
    subgroup = "ammo",
    order = "b[bolt]-b[100]-c",
    stack_size = 100
},
-------------------Kraken----------------
{
    type = "ammo",
    name = "bolt100kraken",
    icon = "__Wh40k_Armoury__/graphics/icons/bolt100kraken.png",
    icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bolt100",
      action =
      {
				type = "direct",
				repeat_count = 1,
				action_delivery =
				{
					type = "projectile",
					projectile = "kraken100",
					starting_speed = 4,
					direction_deviation = 0,
					range_deviation = 0,
					max_range = 60,
					--min_range = 0.1,
            },
          },
    },
    magazine_size = 20,
    subgroup = "ammo",
    order = "b[bolt]-b[100]-d",
    stack_size = 100
},
-----------------Hellfire----------------
{
		type = "ammo",
		name = "bolt100hellfire",
		icon = "__Wh40k_Armoury__/graphics/icons/bolt100hellfire.png",
		icon_size = 32,
		flags = {},
		ammo_type =
		{
			category = "bolt100",
			action =
			{
				type = "direct",
				repeat_count = 1,
				action_delivery =
				{
					type = "projectile",
					projectile = "hellfire100",
					starting_speed = 4,
					direction_deviation = 0,
					range_deviation = 0,
					max_range = 40,
					--min_range = 0,
				}
			},
		},
    magazine_size = 20,
    subgroup = "ammo",
    order = "b[bolt]-b[100]-e",
    stack_size = 100
},
-----------------Inferno----------------
{
		type = "ammo",
		name = "bolt100inferno",
		icon = "__Wh40k_Armoury__/graphics/icons/bolt100inferno.png",
		icon_size = 32,
		flags = {},
		ammo_type =
		{
			category = "bolt100",
			action =
			{
				type = "direct",
				repeat_count = 1,
				action_delivery =
				{
					type = "projectile",
					projectile = "inferno100",
					starting_speed = 4,
					direction_deviation = 0,
					range_deviation = 0,
					max_range = 40,
					--min_range = 0,
				}
			},
		},
    magazine_size = 20,
    subgroup = "ammo",
    order = "b[bolt]-b[100]e-f",
    stack_size = 100
},
}
)