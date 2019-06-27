data:extend({
	--Extended AP Bullet Magazine
	{
    type = "ammo",
    name = "ext-ap-bullet-magazine",
    icon = "__adrizz-magazines__/graphics/bobswarfare/ext-ap-bullet-magazine.png",
    icon_size = 32,
    subgroup = "bob-ammo",
    stack_size = 200,
    magazine_size = 40,
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
              type = "create-entity",
              entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-gunshot"
            },
            {
              type = "damage",
              damage = { amount = 12, type = "physical"}
            },
            {
              type = "damage",
              damage = { amount = 12, type = "bob-pierce"}
            }
          }
        }
      }
    },
  },
  --Drum AP Bullet Magazine
	{
    type = "ammo",
    name = "drum-ap-bullet-magazine",
    icon = "__adrizz-magazines__/graphics/bobswarfare/drum-ap-bullet-magazine.png",
    icon_size = 32,
    subgroup = "bob-ammo",
    stack_size = 200,
    magazine_size = 75,
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
              type = "create-entity",
              entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-gunshot"
            },
            {
              type = "damage",
              damage = { amount = 12, type = "physical"}
            },
            {
              type = "damage",
              damage = { amount = 12, type = "bob-pierce"}
            }
          }
        }
      }
    },
  },
  --Saddle AP Bullet Magazine
	{
    type = "ammo",
    name = "saddle-ap-bullet-magazine",
    icon = "__adrizz-magazines__/graphics/bobswarfare/saddle-ap-bullet-magazine.png",
    icon_size = 32,
    subgroup = "bob-ammo",
    stack_size = 200,
    magazine_size = 100,
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
              type = "create-entity",
              entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-gunshot"
            },
            {
              type = "damage",
              damage = { amount = 12, type = "physical"}
            },
            {
              type = "damage",
              damage = { amount = 12, type = "bob-pierce"}
            }
          }
        }
      }
    },
  },
})