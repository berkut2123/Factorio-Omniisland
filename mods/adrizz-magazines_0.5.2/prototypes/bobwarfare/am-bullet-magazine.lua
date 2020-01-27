data:extend({
	--Extended Bullet Magazine
	{
    type = "ammo",
    name = "ext-bullet-magazine",
    icon = "__adrizz-magazines__/graphics/bobswarfare/ext-bullet-magazine.png",
    icon_size = 32,
    subgroup = "bob-ammo",
    stack_size = 200,
    magazine_size = 40,
    ammo_type =
    {
      category = "bullet",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            {
              type = "instant",
              source_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-gunshot"
                }
              },
              target_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-gunshot"
                },
                {
                  type = "damage",
                  damage = { amount = 16, type = "physical"}
                }
              }
            }
          }
        }
      }
    },
  },
  --Bullet Drum Magazine
	{
    type = "ammo",
    name = "drum-bullet-magazine",
    icon = "__adrizz-magazines__/graphics/bobswarfare/drum-bullet-magazine.png",
    icon_size = 32,
    subgroup = "bob-ammo",
    stack_size = 200,
    magazine_size = 75,
    ammo_type =
    {
      category = "bullet",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            {
              type = "instant",
              source_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-gunshot"
                }
              },
              target_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-gunshot"
                },
                {
                  type = "damage",
                  damage = { amount = 16, type = "physical"}
                }
              }
            }
          }
        }
      }
    },
  },
    --Bullet Saddle Magazine
	{
    type = "ammo",
    name = "saddle-bullet-magazine",
    icon = "__adrizz-magazines__/graphics/bobswarfare/saddle-bullet-magazine.png",
    icon_size = 32,
    subgroup = "bob-ammo",
    stack_size = 200,
    magazine_size = 100,
    ammo_type =
    {
      category = "bullet",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            {
              type = "instant",
              source_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-gunshot"
                }
              },
              target_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-gunshot"
                },
                {
                  type = "damage",
                  damage = { amount = 16, type = "physical"}
                }
              }
            }
          }
        }
      }
    },
  },

})