data:extend(
{

  {
    type = "sticker",
    name = "slow-sticker",
    flags = {"not-on-map"},
    duration_in_ticks = 5*60,
    target_movement_modifier = 0.5
  },
--------------------75----------------------
-------------------Mk2----------------
  {
    type = "projectile",
    name = "mk2boom75",
    flags = {"not-on-map"},
	collision_box = {{-1.00, -1.00}, {1.00, 1.00}},
    acceleration = 0,
	piercing_damage = 500,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
		  type = "damage",
          damage = {amount = 20, type = "physical"}
		  },
		  {
		   type = "push-back",
		   distance = 1,
		  }
        }
      }
    },
	final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
--[[
		  {
			type = "destroy-cliffs",
			radius = 8,
		  },
--]]  
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 3,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = 50, type = "explosion"}
                  },
                }
              }
            }
          },
		  --[[{
            type = "nested-result",
            action =
            {
              type = "area",
              target_entities = false,
			  trigger_from_target = true,
              repeat_count = 1,
              radius = 5,
              action_delivery =
              {
                type = "projectile",
                projectile = "shockwave",
                starting_speed = 0.75
              }
            }
          }--]]
        }
      }
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm75.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
  },
--------------------Metal Storm--------------------
  {
    type = "projectile",
    name = "metalstorm75",
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
          damage = {amount = 10, type = "physical"}
        }
      }
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm75.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  },
--------------------Kraken--------------------
{
    type = "projectile",
    name = "kraken75",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}}, --{{-3.00, -3.00}, {3.00, 3.00}},
    acceleration = 0,
    direction_only = true,
	piercing_damage = 3000,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
		  type = "damage",
          damage = {amount = 100, type = "piercing"}
		  },
		  {
		   type = "push-back",
		   distance = 2,
		  },
		  {type = "create-sticker",	sticker = "slow-sticker" }
        }
      }
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm75.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
},
--------------------Hellfire--------------------
  {
    type = "projectile",
    name = "hellfire75",
    flags = {"not-on-map"},
	collision_box = {{-1.00, -1.00}, {1.00, 1.00}},
    acceleration = 0,
    action =
	{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 50, type = "acid"}
					},
					{
						type = "create-entity",
						show_in_tooltip = true,
						entity_name = "hellfire75smoke"
					}
				}
			}
		}
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm75.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
 },
--------------------Inferno--------------------
  {
    type = "projectile",
    name = "inferno75",
    flags = {"not-on-map"},
	collision_box = {{-1.00, -1.00}, {1.00, 1.00}},
    acceleration = 0,
    action =
	{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 50, type = "fire"}
					},
					{
						type = "create-entity",
						show_in_tooltip = true,
						entity_name = "Inferno-napalm-flame-75"
					},
					{
						type = "create-sticker", 
						show_in_tooltip = true,
						sticker = "fire-sticker"
					}
				}
			}
		}
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm75.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
  },
--------------------100----------------------
-------------------Mk2----------------
  {
    type = "projectile",
    name = "mk2boom100",
    flags = {"not-on-map"},
	collision_box = {{-1.00, -1.00}, {1.00, 1.00}},
    acceleration = 0,
	piercing_damage = 1000,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
		  type = "damage",
          damage = {amount = 40, type = "physical"}
		  },
		  {
		   type = "push-back",
		   distance = 2,
		  }
        }
      }
    },
	final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
--[[
		  {
			type = "destroy-cliffs",
			radius = 8,
		  },
--]]  
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 3,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = 100, type = "explosion"}
                  },
                }
              }
            }
          },
		  --[[{
            type = "nested-result",
            action =
            {
              type = "area",
              target_entities = false,
			  trigger_from_target = true,
              repeat_count = 1,
              radius = 5,
              action_delivery =
              {
                type = "projectile",
                projectile = "shockwave",
                starting_speed = 0.75
              }
            }
          }--]]
        }
      }
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm100.png",
      frame_count = 1,
      width = 5,
      height = 75,
      priority = "high"
    },
  },
--------------------Metal Storm--------------------
  {
    type = "projectile",
    name = "metalstorm100",
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
          damage = {amount = 20, type = "physical"}
        }
      }
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm100.png",
      frame_count = 1,
      width = 5,
      height = 75,
      priority = "high"
    },
  },
--------------------Kraken--------------------
{
    type = "projectile",
    name = "kraken100",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}}, --{{-3.00, -3.00}, {3.00, 3.00}},
    acceleration = 0,
    direction_only = true,
	piercing_damage = 6000,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
		  type = "damage",
          damage = {amount = 200, type = "piercing"}
		  },
		  {
		   type = "push-back",
		   distance = 4,
		  },
		  {type = "create-sticker",	sticker = "slow-sticker" }
        }
      }
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm100.png",
      frame_count = 1,
      width = 5,
      height = 75,
      priority = "high"
    },
},
--------------------Hellfire--------------------
  {
    type = "projectile",
    name = "hellfire100",
    flags = {"not-on-map"},
	collision_box = {{-1.00, -1.00}, {1.00, 1.00}},
    acceleration = 0,
    action =
	{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 100, type = "acid"}
					},
					{
						type = "create-entity",
						show_in_tooltip = true,
						entity_name = "hellfire100smoke"
					}
				}
			}
		}
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm100.png",
      frame_count = 1,
      width = 5,
      height = 75,
      priority = "high"
    },
 },
--------------------Inferno--------------------
  {
    type = "projectile",
    name = "inferno100",
    flags = {"not-on-map"},
	collision_box = {{-1.00, -1.00}, {1.00, 1.00}},
    acceleration = 0,
    action =
	{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 100, type = "fire"}
					},
					{
						type = "create-entity",
						show_in_tooltip = true,
						entity_name = "Inferno-napalm-flame-100"
					},
					{
						type = "create-sticker", 
						show_in_tooltip = true,
						sticker = "fire-sticker"
					}
				}
			}
		}
    },
    animation =
    {
      filename = "__Wh40k_Armoury__/graphics/entity/metalstorm100.png",
      frame_count = 1,
      width = 5,
      height = 75,
      priority = "high"
    },
  }, 
}
)