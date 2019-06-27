
data:extend({
  -- ammo
  {
    type = "ammo",
    name = "mustard-artillery-shell",
    icon = "__MustardArtilleryShell__/graphics/mustard-artillery-shell.png",
    icon_size = 32,
    --flags = {"goes-to-main-inventory"},
    ammo_type =
    {
      category = "artillery-shell",
      target_type = "position",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "artillery",
          projectile = "artillery-mustard-projectile",
          starting_speed = 1,
          direction_deviation = 0,
          range_deviation = 0,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "artillery-cannon-muzzle-flash"
          },
        }
      },
    },
    subgroup = "ammo",
    order = "d[explosive-cannon-shell]-d[artillery]",
    stack_size = 1
  },
  -- projectile
  {
    type = "artillery-projectile",
    name = "artillery-mustard-projectile",
    flags = {"not-on-map"},
    acceleration = 0,
    direction_only = true,
    reveal_map = true,
    map_color = {r=0.2, g=1, b=0},
    picture =
    {
      filename = "__base__/graphics/entity/artillery-projectile/hr-shell.png",
      width = 64,
      height = 64,
      scale = 0.5,
    },
    shadow =
    {
      filename = "__base__/graphics/entity/artillery-projectile/hr-shell-shadow.png",
      width = 64,
      height = 64,
      scale = 0.5,
    },
    chart_picture =
    {
      filename = "__base__/graphics/entity/artillery-projectile/artillery-shoot-map-visualization.png",
      flags = { "icon" },
      frame_count = 1,
      width = 64,
      height = 64,
      priority = "high",
      scale = 0.25,
    },
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 3.0,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = 400 , type = "physical"}
                  },
                  {
                    type = "damage",
                    damage = {amount = 250 , type = "explosion"}
                  }
                }
              }
            }
          },
          {
            type = "create-entity",
            show_in_tooltip = true,
            entity_name = "mustard-cloud",
          },      
          {
            type = "create-entity",
            entity_name = "big-artillery-explosion"
          },		  
          {
            type = "show-explosion-on-chart",
            scale = 8/32,
          }
        }
      }
    },    
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
  },
  -- cloud
  {
    type = "smoke-with-trigger",
    name = "mustard-cloud",
    flags = {"not-on-map"},
    show_when_smoke_off = true,
    animation =
    {
      filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
      flags = { "compressed" },
      priority = "low",
      width = 256,
      height = 256,
      frame_count = 45,
      animation_speed = 0.5,
      line_length = 7,
      scale = 4.5,
    },
    slow_down_factor = 0,
    affected_by_wind = true,
    cyclic = true,
    duration = 60 * 50,
    fade_away_duration = 2 * 60,
    spread_duration = 10,
    color = { r = 0.8, g = 0.8, b = 0 },
    action =
	{
		{
		  type = "direct",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
			  type = "nested-result",
			  action =
			  {
				type = "area",
				radius = 15,
				entity_flags = {"breaths-air"},
				force = "enemy",
				--forces = {"ally","enemy"},
				action_delivery =
				{
				  type = "instant",
				  target_effects =
				  {
					  {
						type = "damage",
						damage = { amount = 20, type = "poison"}
					  },
					  {
						type = "create-sticker",
						sticker = "slowdown-sticker-mgas"
					  }
				  }
				}
			  }
			}
		  }
		},
		{
		  type = "direct",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
			  type = "nested-result",
			  action =
			  {
				type = "area",
				radius = 15,
				entity_flags = {"not-repairable"},
				force = "ally",
				--forces = {"ally","enemy"},
				action_delivery =
				{
				  type = "instant",
				  target_effects =
				  {
					  {
						type = "damage",
						damage = { amount = 20, type = "poison"}
					  },
					  {
						type = "create-sticker",
						sticker = "slowdown-sticker-mgas"
					  }	
				  }
				}
			  }
			}
		  }
		}
	},
    action_cooldown = 30
  },
  
  -- slowdown
  {
    type = "sticker",
    name = "slowdown-sticker-mgas",
    --icon = "base/graphics/icons/slowdown-sticker.png",
    flags = {},
    animation =
    {
      filename = "__base__/graphics/entity/slowdown-sticker/slowdown-sticker.png",
      priority = "extra-high",
      width = 11,
      height = 11,
      frame_count = 13,
      animation_speed = 0.4
    },
    duration_in_ticks = 60*1,
    target_movement_modifier = 0.5
  },
  
  
  -- technology
  {
    type = "technology",
    name = "mustard-artillery-shell",
    icon = "__MustardArtilleryShell__/graphics/mustard-artillery-shell-tech.png",
    icon_size = 64,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "mustard-artillery-shell"
      }
    },
    prerequisites = {"artillery"},
    unit =
    {
      ingredients =
      {
        {"automation-science-pack", 1},
	    {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 30,
      count = 1000
    },
    order = "a-h-d"
  },  
  -- recipe
  {
    type = "recipe",
    name = "mustard-artillery-shell",
	category = "crafting-with-fluid",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {"artillery-shell", 1},
      {"poison-capsule", 4},
	  {"plastic-bar", 2},
	  {type="fluid", name="sulfuric-acid", amount=40}
    },
    result = "mustard-artillery-shell"
  },
})


