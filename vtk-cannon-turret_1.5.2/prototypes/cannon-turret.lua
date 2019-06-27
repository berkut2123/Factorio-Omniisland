function cannon_turret_sheet(inputs)
return
{
  layers = 
  {
    {
      filename = "__vtk-cannon-turret__/graphics/entity/cannon-turret-sheet.png",
      priority = "medium",
      scale = 0.75,
      width = 128,
      height = 128,
      direction_count = inputs.direction_count and inputs.direction_count or 64,
      frame_count = 1,
      line_length = inputs.line_length and inputs.line_length or 8,
      axially_symmetrical = false,
      run_mode = inputs.run_mode and inputs.run_mode or "forward",
    shift = { 0.35, -0.5 },
    }
  }
}
end

-- entity
data:extend(
{
  {
    type = "ammo-turret",
    name = "vtk-cannon-turret",
    icon = "__vtk-cannon-turret__/graphics/icons/cannon-turret-icon.png",
    icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "vtk-cannon-turret"},
    max_health = 1500,
    corpse = "medium-remnants",
    collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
    selection_box = {{-1, -1 }, {1, 1}},
    rotation_speed = 0.003,
    preparing_speed = 0.04,
    folding_speed = 0.04,
    dying_explosion = "medium-explosion",
    inventory_size = 1,
    automated_ammo_count = 10,
    attacking_speed = 0.5,
    
    alert_when_attacking = true,
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    
    folded_animation = cannon_turret_sheet{direction_count = 8, line_length = 1},
    preparing_animation = cannon_turret_sheet{direction_count = 8, line_length = 1},
    prepared_animation = cannon_turret_sheet{},
    attacking_animation = cannon_turret_sheet{},
    folding_animation = cannon_turret_sheet{direction_count = 8, line_length = 1, run_mode = "backward"},
    
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "cannon-shell-magazine",
      cooldown = 180,
      projectile_creation_distance = 1.75,
      projectile_center = {0, 0},
      damage_modifier = 1,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = 35,
      min_range = 12,
      sound =
      {
        {
            -- filename = "__base__/sound/fight/tank-cannon.ogg",
            filename = "__vtk-cannon-turret__/sounds/CANNHVY5.ogg",
            volume = 1.0
        }
      },
    },
    call_for_help_radius = 46
  },
})

--item
data:extend({
  {
    type = "item",
    name = "vtk-cannon-turret",
    icon = "__vtk-cannon-turret__/graphics/icons/cannon-turret-icon.png",
    icon_size = 32,
    subgroup = "defensive-structure",
    order = "b[turret]-c[base]-a[cannon-turret]",
    place_result = "vtk-cannon-turret",
    stack_size = 20,
  },
})


--recipe
data:extend({
  {
    type = "recipe",
    name = "vtk-cannon-turret",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {"gun-turret", 2},
      {"steel-plate", 2},
      {"electronic-circuit", 2}
    },
    result = "vtk-cannon-turret",
  },
})
