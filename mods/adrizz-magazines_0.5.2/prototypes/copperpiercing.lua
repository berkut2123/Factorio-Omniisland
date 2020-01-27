data:extend(
{
	--Copper piercing-rounds Magazine
  {
    type = "ammo",
    name = "copper-piercing-rounds-magazine",
    icon = "__adrizz-magazines__/graphics/CuP1.png",
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
              damage = { amount = 7, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "a[basic-clips]-m[copper-piercing-rounds-magazine]",
    stack_size = 200
  },
  --Recipe for Copper piercing-rounds magazine
  {
        type = "recipe",
        name = "copper-piercing-rounds-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe", recipe = "copper-piercing-rounds-magazine" }),
        ingredients =
        {
            {type="item", name="copper-plate", amount=4},
			{type="item", name="copper-firearm-magazine", amount=4}
        },
        result= "copper-piercing-rounds-magazine",
        result_count = 1,
    },
   	--Ext. Copper piercing-rounds Magazine
    {
    type = "ammo",
    name = "ext-copper-piercing-rounds-magazine",
    icon = "__adrizz-magazines__/graphics/CuP2.png",
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
              damage = { amount = 7, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 30,
    subgroup = "ammo",
    order = "a[basic-clips]-n[ext-copper-piercing-rounds-magazine]",
    stack_size = 200
  },
  --Recipe for Ext. Copper piercing-rounds Magazine
  {
        type = "recipe",
        name = "ext-copper-piercing-rounds-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe", recipe = "ext-copper-piercing-rounds-magazine" }),
        ingredients =
        {
            {type="item", name="copper-plate", amount=4},
			{type="item", name="copper-piercing-rounds-magazine", amount=1}
        },
        result= "ext-copper-piercing-rounds-magazine",
        result_count = 1,
    },
	--Copper piercing-rounds Drum Magazine
    {
    type = "ammo",
    name = "drum-copper-piercing-rounds-magazine",
    icon = "__adrizz-magazines__/graphics/CuP3.png",
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
    order = "a[basic-clips]-o[drum-copper-piercing-rounds-magazine]",
    stack_size = 200
  },
  --Recipe for Copper piercing-rounds Drum magazine
  {
        type = "recipe",
        name = "drum-copper-piercing-rounds-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe", recipe = "drum-copper-piercing-rounds-magazine" }),
        ingredients =
        {
            {type="item", name="copper-plate", amount=4},
			{type="item", name="ext-copper-piercing-rounds-magazine", amount=1}
        },
        result= "drum-copper-piercing-rounds-magazine",
        result_count = 1,
    },
	--Copper piercing-rounds Saddle Magazine
    {
    type = "ammo",
    name = "saddle-copper-piercing-rounds-magazine",
    icon = "__adrizz-magazines__/graphics/CuP4.png",
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
              damage = { amount = 7, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 100,
    subgroup = "ammo",
    order = "a[basic-clips]-p[saddle-copper-piercing-rounds-magazine]",
    stack_size = 200
  },

  --Recipe for Copper piercing-rounds Saddle magazine
  {
        type = "recipe",
        name = "saddle-copper-piercing-rounds-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe", recipe = "saddle-copper-piercing-rounds-magazine" }),
        ingredients =
        {
            {type="item", name="copper-plate", amount=4},
			{type="item", name="drum-copper-piercing-rounds-magazine", amount=1}
        },
        result= "saddle-copper-piercing-rounds-magazine",
        result_count = 1,
    },

}
)
