data:extend(
{
	--Copper Firearm Magazine
  {
    type = "ammo",
    name = "copper-firearm-magazine",
    icon = "__adrizz-magazines__/graphics/CuA1.png",
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
              damage = { amount = 5, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "a[basic-clips]-i[copper-firearm-magazine]",
    stack_size = 200
  },
  --Recipe for Copper Firearm magazine
  {
        type = "recipe",
        name = "copper-firearm-magazine",
        energy_required = 1,
        enabled = true,
        ingredients =
        {
            {type="item", name="copper-plate", amount=4},
        },
        result= "copper-firearm-magazine",
        result_count = 1,
    },
   	--Ext. Copper Firearm Magazine
    {
    type = "ammo",
    name = "ext-copper-firearm-magazine",
    icon = "__adrizz-magazines__/graphics/CuA2.png",
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
              damage = { amount = 5, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 30,
    subgroup = "ammo",
    order = "a[basic-clips]-j[ext-copper-firearm-magazine]",
    stack_size = 200
  },
  --Recipe for Ext. Copper Firearm Magazine
  {
        type = "recipe",
        name = "ext-copper-firearm-magazine",
        energy_required = 1,
        enabled = true,
        ingredients =
        {
            {type="item", name="copper-plate", amount=4},
			{type="item", name="copper-firearm-magazine", amount=1}
        },
        result= "ext-copper-firearm-magazine",
        result_count = 1,
    },
	--Copper Firearm Drum Magazine
    {
    type = "ammo",
    name = "drum-copper-firearm-magazine",
    icon = "__adrizz-magazines__/graphics/CuA3.png",
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
              damage = { amount = 5, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 50,
    subgroup = "ammo",
    order = "a[basic-clips]-k[drum-copper-firearm-magazine]",
    stack_size = 200
  },
  --Recipe for Copper Firearm Drum magazine
  {
        type = "recipe",
        name = "drum-copper-firearm-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["military"].effects, {type = "unlock-recipe", recipe = "drum-copper-firearm-magazine" }),
        ingredients =
        {
            {type="item", name="copper-plate", amount=4},
			{type="item", name="ext-copper-firearm-magazine", amount=1}
        },
        result= "drum-copper-firearm-magazine",
        result_count = 1,
    },
	--Copper Firearm Saddle Magazine
    {
    type = "ammo",
    name = "saddle-copper-firearm-magazine",
    icon = "__adrizz-magazines__/graphics/CuA4.png",
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
              damage = { amount = 5, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 100,
    subgroup = "ammo",
    order = "a[basic-clips]-l[saddle-copper-firearm-magazine]",
    stack_size = 200
  },

  --Recipe for Copper Firearm Saddle magazine
  {
        type = "recipe",
        name = "saddle-copper-firearm-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["military"].effects, {type = "unlock-recipe", recipe = "saddle-copper-firearm-magazine" }),
        ingredients =
        {
            {type="item", name="copper-plate", amount=4},
			{type="item", name="drum-copper-firearm-magazine", amount=1}
        },
        result= "saddle-copper-firearm-magazine",
        result_count = 1,
    },

}
)
