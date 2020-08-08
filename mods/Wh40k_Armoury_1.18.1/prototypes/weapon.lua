data:extend(
{
--------------------Boltgun----------------
  {
    type = "gun",
    name = "boltgun",
    icon = "__Wh40k_Armoury__/graphics/icons/boltgun.png",
    icon_size = 32,
    flags = {},
    subgroup = "gun",
    order = "f-a",
    stack_size = 5,
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bolt75",
      cooldown = 12,
      movement_slow_down_factor = 0.5,
      projectile_creation_distance = 0.5,
      --damage_modifier = 1.2, 
      range = 24,
      sound =
      {
        {
          filename = "__Wh40k_Armoury__/sound/Bolt1.wav",
          volume = 0.9
        }
      }
    }
  },
--------------------Stormbolter----------------
  {
    type = "gun",
    name = "stormbolter",
    icon = "__Wh40k_Armoury__/graphics/icons/stormbolter.png",
    icon_size = 32,
    flags = {},
    subgroup = "gun",
    order = "f-b",
    stack_size = 5,
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bolt75",
      cooldown = 6,
      movement_slow_down_factor = 0.7,
      projectile_creation_distance = 0.5,
      --damage_modifier = 1.2, 
      range = 24,
      sound =
      {
        {
          filename = "__Wh40k_Armoury__/sound/Bolt1.wav",
          volume = 0.9
        }
      }
    }
  },
--------------------Bolt Rifle----------------
  {
    type = "gun",
    name = "bolt_rifle",
    icon = "__Wh40k_Armoury__/graphics/icons/bolt_rifle.png",
    icon_size = 32,
    flags = {},
    subgroup = "gun",
    order = "f-c",
    stack_size = 5,
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bolt75",
      cooldown = 12,
      movement_slow_down_factor = 0.6,
      projectile_creation_distance = 0.5,
      damage_modifier = 1.2, 
      range = 30,
      sound =
      {
        {
          filename = "__Wh40k_Armoury__/sound/Bolt1.wav",
          volume = 0.9
        }
      }
    }
  },
--------------------Heavy Bolter----------------
  {
    type = "gun",
    name = "heavy_bolter",
    icon = "__Wh40k_Armoury__/graphics/icons/heavy_bolter.png",
    icon_size = 32,
    flags = {},
    subgroup = "gun",
    order = "f-d",
    stack_size = 5,
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bolt100",
      cooldown = 20,
      movement_slow_down_factor = 0.8,
      projectile_creation_distance = 0.5,
      damage_modifier = 1.2, 
      range = 36,
      sound =
      {
        {
          filename = "__Wh40k_Armoury__/sound/HBolt1.wav",
          volume = 0.9
        }
      }
    }
  },
--------------------Assault Bolter----------------
  {
    type = "gun",
    name = "assault_bolter",
    icon = "__Wh40k_Armoury__/graphics/icons/assault_bolter.png",
    icon_size = 32,
    flags = {},
    subgroup = "gun",
    order = "f-e",
    stack_size = 5,
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bolt100",
      cooldown = 10,
      movement_slow_down_factor = 0.4,
      projectile_creation_distance = 0.5,
      --damage_modifier = 1.2, 
      range = 18,
      sound =
      {
        {
          filename = "__Wh40k_Armoury__/sound/HBolt1.wav",
          volume = 0.9
        }
      }
    }
  },
}
)

