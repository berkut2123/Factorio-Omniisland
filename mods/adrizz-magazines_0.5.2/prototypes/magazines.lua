data:extend(
{
   	--Ext. Firearm Magazine
    {
    type = "ammo",
    name = "ext-firearm-magazine",
    icon = "__adrizz-magazines__/graphics/A2.png",
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
    order = "a[basic-clips]-d[ext-firearm-magazine]",
    stack_size = 200
  },
  --Recipe for Ext. Firearm Magazine
  {
        type = "recipe",
        name = "ext-firearm-magazine",
        energy_required = 1,
        enabled = true,
        ingredients =
        {
            {type="item", name="copper-cable", amount=1},
            {type="item", name="firearm-magazine", amount=1},
            {type="item", name="iron-plate", amount=2}
        },
        result= "ext-firearm-magazine",
        result_count = 1,
    },
	--Copper Firearm Drum Magazine
    {
    type = "ammo",
    name = "drum-firearm-magazine",
    icon = "__adrizz-magazines__/graphics/A3.png",
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
    order = "a[basic-clips]-e[drum-firearm-magazine]",
    stack_size = 200
  },
  --Recipe for Firearm Drum magazine
  {
        type = "recipe",
        name = "drum-firearm-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["military"].effects, {type = "unlock-recipe", recipe = "drum-firearm-magazine" }),
        ingredients =
        {
            {type="item", name="copper-cable", amount=2},
            {type="item", name="iron-plate", amount=2},
			{type="item", name="firearm-magazine", amount=3}
        },
        result= "drum-firearm-magazine",
        result_count = 1,
    },
	--Firearm Saddle Magazine
    {
    type = "ammo",
    name = "saddle-firearm-magazine",
    icon = "__adrizz-magazines__/graphics/A4.png",
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
    order = "a[basic-clips]-e[saddle-firearm-magazine]",
    stack_size = 200
  },

  --Recipe for Firearm Saddle magazine
  {
        type = "recipe",
        name = "saddle-firearm-magazine",
        energy_required = 1,
        enabled = false,
		table.insert(data.raw["technology"]["military"].effects, {type = "unlock-recipe", recipe = "saddle-firearm-magazine" }),
        ingredients =
        {
            {type="item", name="copper-cable", amount=5},
            {type="item", name="firearm-magazine", amount=5},
            {type="item", name="iron-plate", amount=5}
        },
        result= "saddle-firearm-magazine",
        result_count = 1,
    },

}
)
