data:extend({
	--Bullet Magazines
	{
		type = "recipe",
		name = "ext-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-bullets"].effects, {type = "unlock-recipe", recipe = "ext-bullet-magazine" }),
		order = "a[basic-clips]-aa[ext-bullet-magazine]",
		energy_required = 2,
		ingredients =
		{
			{"bullet", 10},
			{"magazine", 1},
        },
		result = "ext-bullet-magazine",
    },	

	{
		type = "recipe",
		name = "drum-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-bullets"].effects, {type = "unlock-recipe", recipe = "drum-bullet-magazine" }),
		order = "a[basic-clips]-ab[drum-bullet-magazine]",
		energy_required = 2,
		ingredients =
		{
			{"bullet", 15},
			{"magazine", 1},
        },
		result = "drum-bullet-magazine",
    },

	{
		type = "recipe",
		name = "saddle-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-bullets"].effects, {type = "unlock-recipe", recipe = "saddle-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ac[saddle-bullet-magazine]",
		ingredients =
		{
			{"bullet", 20},
			{"magazine", 1},
        },
		result = "saddle-bullet-magazine",
    },
	--AP Bullet Magazines
	{
		type = "recipe",
		name = "ext-ap-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-ap-bullets"].effects, {type = "unlock-recipe", recipe = "ext-ap-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ad[ext-ap-bullet-magazine]",
		ingredients =
		{
			{"ap-bullet", 10},
			{"magazine", 1},
        },
		result = "ext-ap-bullet-magazine",
    },

	{
		type = "recipe",
		name = "drum-ap-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-ap-bullets"].effects, {type = "unlock-recipe", recipe = "drum-ap-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ae[drum-ap-bullet-magazine]",
		ingredients =
		{
			{"ap-bullet", 15},
			{"magazine", 1},
        },
		result = "drum-ap-bullet-magazine",
    },

	{
		type = "recipe",
		name = "saddle-ap-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-ap-bullets"].effects, {type = "unlock-recipe", recipe = "saddle-ap-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-af[saddle-ap-bullet-magazine]",
		ingredients =
		{
			{"ap-bullet", 20},
			{"magazine", 1},
        },
		result = "saddle-ap-bullet-magazine",
    },
	--HE Bullet Magazines
	{
		type = "recipe",
		name = "ext-he-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-he-bullets"].effects, {type = "unlock-recipe", recipe = "ext-he-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ag[ext-he-bullet-magazine]",
		ingredients =
		{
			{"he-bullet", 10},
			{"magazine", 1},
        },
		result = "ext-he-bullet-magazine",
    },

	{
		type = "recipe",
		name = "drum-he-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-he-bullets"].effects, {type = "unlock-recipe", recipe = "drum-he-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ah[drum-he-bullet-magazine]",
		ingredients =
		{
			{"he-bullet", 15},
			{"bullet-magazine", 1},
        },
		result = "drum-he-bullet-magazine",
    },

	{
		type = "recipe",
		name = "saddle-he-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-he-bullets"].effects, {type = "unlock-recipe", recipe = "saddle-he-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ai[saddle-he-bullet-magazine]",
		ingredients =
		{
			{"he-bullet", 20},
			{"bullet-magazine", 1},
        },
		result = "saddle-he-bullet-magazine",
    },
	--Flame Bullet Magazines
	{
		type = "recipe",
		name = "ext-flame-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-flame-bullets"].effects, {type = "unlock-recipe", recipe = "ext-flame-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-aj[ext-flame-bullet-magazine]",
		ingredients =
		{
			{"flame-bullet", 10},
			{"bullet-magazine", 1},
        },
		result = "ext-flame-bullet-magazine",
    },

	{
		type = "recipe",
		name = "drum-flame-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-flame-bullets"].effects, {type = "unlock-recipe", recipe = "drum-flame-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ak[drum-flame-bullet-magazine]",
		ingredients =
		{
			{"flame-bullet", 15},
			{"bullet-magazine", 1},
        },
		result = "drum-flame-bullet-magazine",
    },

	{
		type = "recipe",
		name = "saddle-flame-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-flame-bullets"].effects, {type = "unlock-recipe", recipe = "saddle-flame-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-al[saddle-flame-bullet-magazine]",
		ingredients =
		{
			{"flame-bullet", 20},
			{"bullet-magazine", 1},
        },
		result = "saddle-flame-bullet-magazine",
    },
	--acid Bullet Magazines
	{
		type = "recipe",
		name = "ext-acid-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-acid-bullets"].effects, {type = "unlock-recipe", recipe = "ext-acid-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-am[ext-acid-bullet-magazine]",
		ingredients =
		{
			{"acid-bullet", 10},
			{"bullet-magazine", 1},
        },
		result = "ext-acid-bullet-magazine",
    },

	{
		type = "recipe",
		name = "drum-acid-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-acid-bullets"].effects, {type = "unlock-recipe", recipe = "drum-acid-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-an[drum-acid-bullet-magazine]",
		ingredients =
		{
			{"acid-bullet", 15},
			{"bullet-magazine", 1},
        },
		result = "drum-acid-bullet-magazine",
    },

	{
		type = "recipe",
		name = "saddle-acid-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-acid-bullets"].effects, {type = "unlock-recipe", recipe = "saddle-acid-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ao[saddle-acid-bullet-magazine]",
		ingredients =
		{
			{"acid-bullet", 20},
			{"bullet-magazine", 1},
        },
		result = "saddle-acid-bullet-magazine",
    },
	--Poison Bullet Magazines
	{
		type = "recipe",
		name = "ext-poison-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-poison-bullets"].effects, {type = "unlock-recipe", recipe = "ext-poison-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ap[ext-poison-bullet-magazine]",
		ingredients =
		{
			{"poison-bullet", 10},
			{"bullet-magazine", 1},
        },
		result = "ext-poison-bullet-magazine",
    },

	{
		type = "recipe",
		name = "drum-poison-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-poison-bullets"].effects, {type = "unlock-recipe", recipe = "drum-poison-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-aq[drum-poison-bullet-magazine]",
		ingredients =
		{
			{"poison-bullet", 15},
			{"bullet-magazine", 1},
        },
		result = "drum-poison-bullet-magazine",
    },

	{
		type = "recipe",
		name = "saddle-poison-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-poison-bullets"].effects, {type = "unlock-recipe", recipe = "saddle-poison-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-ar[saddle-poison-bullet-magazine]",
		ingredients =
		{
			{"poison-bullet", 20},
			{"bullet-magazine", 1},
        },
		result = "saddle-poison-bullet-magazine",
    },
	--Electric Bullet Magazines
	{
		type = "recipe",
		name = "ext-electric-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-electric-bullets"].effects, {type = "unlock-recipe", recipe = "ext-electric-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-as[ext-electric-bullet-magazine]",
		ingredients =
		{
			{"electric-bullet", 10},
			{"bullet-magazine", 1},
        },
		result = "ext-electric-bullet-magazine",
    },

	{
		type = "recipe",
		name = "drum-electric-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-electric-bullets"].effects, {type = "unlock-recipe", recipe = "drum-electric-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-at[drum-electric-bullet-magazine]",
		ingredients =
		{
			{"electric-bullet", 15},
			{"bullet-magazine", 1},
        },
		result = "drum-electric-bullet-magazine",
    },

	{
		type = "recipe",
		name = "saddle-electric-bullet-magazine",
		subgroup = "bob-ammo",
		enabled = "false",
		table.insert(data.raw["technology"]["bob-electric-bullets"].effects, {type = "unlock-recipe", recipe = "saddle-electric-bullet-magazine" }),
		energy_required = 2,
		order = "a[basic-clips]-au[saddle-electric-bullet-magazine]",
		ingredients =
		{
			{"electric-bullet", 20},
			{"bullet-magazine", 1},
        },
		result = "saddle-electric-bullet-magazine",
    },
})