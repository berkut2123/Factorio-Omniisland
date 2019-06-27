data:extend(
{
   	--Ext. Uranium Magazine
    {
    type = "ammo",
    name = "ext-uranium-rounds-magazine",
    icon = "__adrizz-magazines__/graphics/U2.png",
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
              damage = { amount = 24, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 30,
    subgroup = "ammo",
    order = "a[basic-clips]-q[ext-uranium-rounds-magazine]",
    stack_size = 200
  },
  --Recipe for Ext. Copper Firearm Magazine
  {
        type = "recipe",
        name = "ext-uranium-rounds-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["uranium-ammo"].effects, {type = "unlock-recipe", recipe = "ext-uranium-rounds-magazine" }),
        ingredients =
        {
            {type="item", name="uranium-238", amount=4},
			{type="item", name="uranium-rounds-magazine", amount=1}
        },
        result= "ext-uranium-rounds-magazine",
        result_count = 1,
    },
	--Copper Firearm Drum Magazine
    {
    type = "ammo",
    name = "drum-uranium-rounds-magazine",
    icon = "__adrizz-magazines__/graphics/U3.png",
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
              damage = { amount = 24, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 50,
    subgroup = "ammo",
    order = "a[basic-clips]-r[drum-uranium-rounds-magazine]",
    stack_size = 200
  },
  --Recipe for Copper Firearm Drum magazine
  {
        type = "recipe",
        name = "drum-uranium-rounds-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["uranium-ammo"].effects, {type = "unlock-recipe", recipe = "drum-uranium-rounds-magazine" }),
        ingredients =
        {
            {type="item", name="uranium-238", amount=4},
			{type="item", name="ext-uranium-rounds-magazine", amount=1}
        },
        result= "drum-uranium-rounds-magazine",
        result_count = 1,
    },
	--Copper Firearm Saddle Magazine
    {
    type = "ammo",
    name = "saddle-uranium-rounds-magazine",
    icon = "__adrizz-magazines__/graphics/U4.png",
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
              damage = { amount = 24, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 100,
    subgroup = "ammo",
    order = "a[basic-clips]-s[saddle-uranium-rounds-magazine]",
    stack_size = 200
  },

  --Recipe for Copper Firearm Saddle magazine
  {
        type = "recipe",
        name = "saddle-uranium-rounds-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["uranium-ammo"].effects, {type = "unlock-recipe", recipe = "saddle-uranium-rounds-magazine" }),
        ingredients =
        {
            {type="item", name="uranium-238", amount=4},
			{type="item", name="drum-uranium-rounds-magazine", amount=1}
        },
        result= "saddle-uranium-rounds-magazine",
        result_count = 1,
    },

}
)
