-- item

data:extend({
    {
    type = "gun",
    name = "submachine-gun-sn",
    icon = "__gun-sn__/graphics/icons/gun-sn.png",
    icon_size = 32,
    --flags = {"goes-to-main-inventory"},
    subgroup = "gun",
    order = "a[basic-clips]-c[submachine-gun-sn]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 45,
      damage_modifier = 6,
      movement_slow_down_factor = 0.7,
      shell_particle =
        {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.3,
        center = {0, 0.01},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = 36,
      sound = make_light_gunshot_sounds()
    },
    stack_size = 5
  },
  {
    type = "ammo",
    name = "gun-sn-mag",
    icon = "__gun-sn__/graphics/icons/gun-sn-mag.png",
    icon_size = 32,
    --flags = {"goes-to-main-inventory"},
    subgroup = "ammo",
    order = "a[basic-clips]-c[gun-sn-mag]",
    stack_size = 200,
    magazine_size = 25,
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
                damage = {amount = 4 , type = "fire"}
		        },
                {
                type = "damage",
                damage = {amount = 8 , type = "physical"}
                },
                {
                type = "damage",
                damage = {amount = 5 , type = "explosion"}
               }
              }
            }
          }
        }
      }
    },
  }

  })
-- recipe

data:extend({
  {
    type = "recipe",
    name = "submachine-gun-sn",
    normal =
    {
      enabled = false,
      energy_required = 5,
      ingredients =
      {
        {"iron-gear-wheel", 10},
        {"copper-plate", 5},
        {"submachine-gun", 1},
        {"iron-plate", 10}
      },
      result = "submachine-gun-sn"
    },
    expensive =
    {
      enabled = false,
      energy_required = 5,
      ingredients =
      {
        {"iron-gear-wheel", 15},
        {"copper-plate", 20},
        {"iron-plate", 30}
      },
      result = "submachine-gun-sn"
    }
  },

    {
    type = "recipe",
    name = "gun-sn-mag",
    enabled = false,
    energy_required = 50,
    ingredients =
    {
      {"piercing-rounds-magazine", 100},
      {"explosives", 1}
    },
    result = "gun-sn-mag",
    result_count = 100
  }
 })
data:extend({
  {
    type = "projectile",
    name = "gun-sn-mag-pellet",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}},
    acceleration = 0,
    direction_only = true,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
          {
			type = "damage",
			entity_name = "fire-flame",
            damage = {amount = 4 , type = "fire"}
		  },
          {
            type = "damage",
            damage = {amount = 8 , type = "physical"}
          },
          {
            type = "damage",
            damage = {amount = 5 , type = "explosion"}
          }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  }
  })