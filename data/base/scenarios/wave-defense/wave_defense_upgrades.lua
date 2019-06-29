local to_effect = function(effects)
  local result = {}
  for k, effect in pairs (effects) do
    local type = effect.type
    if type == "ammo-damage" then
      result[k] = function(event)
        local force = game.get_player(event.player_index).force
        force.set_ammo_damage_modifier(effect.ammo_category, force.get_ammo_damage_modifier(effect.ammo_category) + effect.modifier)
      end
    elseif type == "turret-attack" then
      result[k] = function(event)
        local force = game.get_player(event.player_index).force
        force.set_turret_attack_modifier(effect.turret_id, force.get_turret_attack_modifier(effect.turret_id) + effect.modifier)
      end
    elseif type == "gun-speed" then
      result[k] = function(event)
        local force = game.get_player(event.player_index).force
        force.set_gun_speed_modifier(effect.ammo_category, force.get_gun_speed_modifier(effect.ammo_category) + effect.modifier)
      end
    elseif type == "maximum-following-robots-count" then
      result[k] = function(event)
        local force = game.get_player(event.player_index).force
        force.maximum_following_robot_count = force.maximum_following_robot_count + effect.modifier
      end
    elseif type == "mining-drill-productivity-bonus" then
      result[k] = function(event)
        local force = game.get_player(event.player_index).force
        force.mining_drill_productivity_bonus = force.mining_drill_productivity_bonus + effect.modifier
      end
    else error(name.." - This tech has no relevant upgrade effect") end
  end
  return result
end

local floor = math.floor

local upgrades = {}

upgrades.physical_projectile_damage =
{
  modifier = "+10%",
  sprite = "technology/physical-projectile-damage-7",
  caption = {"technology-name.physical-projectile-damage"},
  price = function(x) return floor((1 + x)) * 2500 end,
  effect = to_effect(
  {
    {
      type = "ammo-damage",
      ammo_category = "bullet",
      modifier = 0.1
    },
    {
      type = "turret-attack",
      turret_id = "gun-turret",
      modifier = 0.1
    },
    {
      type = "ammo-damage",
      ammo_category = "shotgun-shell",
      modifier = 0.1
    },
    {
      type = "ammo-damage",
      ammo_category = "cannon-shell",
      modifier = 0.1
    }
  })
}

upgrades.stronger_explosives =
{
  modifier = "+25%",
  sprite = "technology/stronger-explosives-7",
  caption = {"technology-name.stronger-explosives"},
  price = function(x) return floor((1 + x)) * 2500 end,
  effect = to_effect(
  {
    {
      type = "ammo-damage",
      ammo_category = "rocket",
      modifier = 0.25
    },
    {
      type = "ammo-damage",
      ammo_category = "grenade",
      modifier = 0.25
    },
    {
      type = "ammo-damage",
      ammo_category = "landmine",
      modifier = 0.25
    }
  })
}

upgrades.refined_flammables =
{
  modifier = "+10%",
  sprite = "technology/refined-flammables-3",
  caption = {"technology-name.refined-flammables"},
  price = function(x) return floor((1 + x)) * 5000 end,
  effect = to_effect(
  {
    {
      type = "ammo-damage",
      ammo_category = "flamethrower",
      modifier = 0.1
    },
    {
      type = "turret-attack",
      turret_id = "flamethrower-turret",
      modifier = 0.1
    }
  })
}

upgrades.energy_weapons_damage =
{
  modifier = "+20%",
  sprite = "technology/energy-weapons-damage-4",
  caption = {"technology-name.energy-weapons-damage"},
  price = function(x) return floor((1 + x)) * 2500 end,
  effect = to_effect(
  {
    {
      type = "ammo-damage",
      ammo_category = "laser-turret",
      modifier = 0.2
    },
    {
      type = "ammo-damage",
      ammo_category = "combat-robot-laser",
      modifier = 0.2
    }
  })
}

upgrades.laser_turret_shooting_speed =
{
  modifier = "+10%",
  sprite = "technology/laser-turret-speed-6",
  caption = {"technology-name.laser-turret-speed"},
  price = function(x) return floor((1 + x)) * 2500 end,
  effect = to_effect(
  {
    {
      type = "gun-speed",
      ammo_category = "laser-turret",
      modifier = 0.1
    }
  })
}

upgrades.weapon_shooting_speed =
{
  modifier = "+10%",
  sprite = "technology/weapon-shooting-speed-4",
  caption = {"technology-name.weapon-shooting-speed"},
  price = function(x) return floor((1 + x)) * 2500 end,
  effect = to_effect(
  {
    {
      type = "gun-speed",
      ammo_category = "bullet",
      modifier = 0.1
    },
    {
      type = "gun-speed",
      ammo_category = "shotgun-shell",
      modifier = 0.1
    },
    {
      type = "gun-speed",
      ammo_category = "rocket",
      modifier = 0.1
    }
  })
}

upgrades.mining_productivity =
{
  modifier = "+10%",
  sprite = "technology/mining-productivity-1",
  caption = {"technology-name.mining-productivity"},
  price = function(x) return floor((1 + x)) * 5000 end,
  effect = to_effect(
  {
    {
      type = "mining-drill-productivity-bonus",
      modifier = 0.1
    }
  })
}

upgrades.following_robot_count =
{
  modifier = "+5",
  sprite = "technology/follower-robot-count-1",
  caption = {"technology-name.follower-robot-count"},
  price = function(x) return floor((1 + x)) * 1000 end,
  effect = to_effect(
  {
    {
      type = "maximum-following-robots-count",
      modifier = 5
    }
  })
}

upgrades.bounty_bonus =
{
  modifier = "+5%",
  sprite = "technology/energy-shield-equipment",
  caption = {"bounty-bonus"},
  price = function(x) return floor((1 + x)) * 2500 end,
  effect =
  {
    function(event, script_data)
      script_data.bounty_bonus = script_data.bounty_bonus + 0.05
      return true
    end
  }
}


return upgrades