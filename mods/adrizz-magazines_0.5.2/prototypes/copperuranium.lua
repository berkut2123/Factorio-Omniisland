data:extend(
{
	--Copper Uranium Magazine
  {
    type = "ammo",
    name = "copper-uranium-magazine",
    icon = "__adrizz-magazines__/graphics/CuU1.png",
    icon_size = 32,
    ammo_type =
    {
      category = "bullet",
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
              damage = { amount = 23, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "a[basic-clips]-t[copper-uranium-magazine]",
    stack_size = 200
  },
  --Recipe for Copper Uranium magazine
  {
        type = "recipe",
        name = "copper-uranium-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["uranium-ammo"].effects, {type = "unlock-recipe", recipe = "copper-uranium-magazine" }),
        ingredients =
        {
            
            {type="item", name="uranium-238", amount=2},
			{type="item", name="copper-plate", amount=2},
			{type="item", name="piercing-rounds-magazine", amount=1}
        },
        result= "copper-uranium-magazine",
        result_count = 1,
    },
   	--Ext. Uranium Magazine
    {
    type = "ammo",
    name = "ext-copper-uranium-magazine",
    icon = "__adrizz-magazines__/graphics/CuU2.png",
    icon_size = 32,
    ammo_type =
    {
      category = "bullet",
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
              damage = { amount = 23, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 30,
    subgroup = "ammo",
    order = "a[basic-clips]-u[ext-copper-uranium-magazine]",
    stack_size = 200
  },
  --Recipe for Ext. Copper Firearm Magazine
  {
        type = "recipe",
        name = "ext-copper-uranium-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["uranium-ammo"].effects, {type = "unlock-recipe", recipe = "ext-copper-uranium-magazine" }),
        ingredients =
        {
            {type="item", name="uranium-238", amount=2},
			{type="item", name="copper-plate", amount=2},
			{type="item", name="uranium-rounds-magazine", amount=1}
        },
        result= "ext-copper-uranium-magazine",
        result_count = 1,
    },
	--Copper Firearm Drum Magazine
    {
    type = "ammo",
    name = "drum-copper-uranium-magazine",
    icon = "__adrizz-magazines__/graphics/CuU3.png",
    icon_size = 32,
    ammo_type =
    {
      category = "bullet",
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
              damage = { amount = 23, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 50,
    subgroup = "ammo",
    order = "a[basic-clips]-v[drum-copper-uranium-magazine]",
    stack_size = 200
  },
  --Recipe for Copper Firearm Drum magazine
  {
        type = "recipe",
        name = "drum-copper-uranium-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["uranium-ammo"].effects, {type = "unlock-recipe", recipe = "drum-copper-uranium-magazine" }),
        ingredients =
        {
            {type="item", name="uranium-238", amount=2},
			{type="item", name="copper-plate", amount=2},
			{type="item", name="ext-copper-uranium-magazine", amount=1}
        },
        result= "drum-copper-uranium-magazine",
        result_count = 1,
    },
	--Copper Firearm Saddle Magazine
    {
    type = "ammo",
    name = "saddle-copper-uranium-magazine",
    icon = "__adrizz-magazines__/graphics/CuU4.png",
    icon_size = 32,
    ammo_type =
    {
      category = "bullet",
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
              damage = { amount = 23, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 100,
    subgroup = "ammo",
    order = "a[basic-clips]-w[saddle-copper-uranium-magazine]",
    stack_size = 200
  },

  --Recipe for Copper Firearm Saddle magazine
  {
        type = "recipe",
        name = "saddle-copper-uranium-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["uranium-ammo"].effects, {type = "unlock-recipe", recipe = "saddle-copper-uranium-magazine" }),
        ingredients =
        {
            {type="item", name="uranium-238", amount=2},
			{type="item", name="copper-plate", amount=2},
			{type="item", name="drum-copper-uranium-magazine", amount=1}
        },
        result= "saddle-copper-uranium-magazine",
        result_count = 1,
    },

}
)
