data:extend({
  {
    type = "ammo",
    name = "uranium-shotgun-shell",
    icon = "__Uranium Shotgun Shell__/uranium-shotgun-shell.png",
    icon_size = 32,
    ammo_type =
    {
      category = "shotgun-shell",
      target_type = "direction",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = 20,
          action_delivery =
          {
            type = "projectile",
            projectile = "uranium-shotgun-pellet",
            starting_speed = 1,
            direction_deviation = 0.3,
            range_deviation = 0.3,
            max_range = 18,
          }
        }
      }
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "b[shotgun]-c[uranium]",
    stack_size = 200
  },
  {
    type = "projectile",
    name = "uranium-shotgun-pellet",
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
          damage = {amount = 12, type = "physical"}
        }
      }
    },
    animation =
    {
      filename = "__Uranium Shotgun Shell__/uranium-shotgun-pellet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
  },
{
    type = "recipe",
    name = "uranium-shotgun-shell",
    enabled = false,
    energy_required = 16,
    ingredients =
    {
      {"piercing-shotgun-shell", 1},
      {"uranium-238", 2}
    },
    result = "uranium-shotgun-shell"
  },
{
    type = "technology",
    name = "uranium-shotgun-shell",
    icon = "__Uranium Shotgun Shell__/uranium-shotgun-shell-tech.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "uranium-shotgun-shell"
      },
    },
    prerequisites = {"uranium-processing", "military-4"},
    unit =
    {
      count = 350,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    order = "e-a-c"
  },  
})