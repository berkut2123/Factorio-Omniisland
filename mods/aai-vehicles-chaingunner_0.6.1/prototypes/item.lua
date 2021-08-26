local sounds = require("__base__/prototypes/entity/sounds")

data:extend({{
	type = "item-with-entity-data",
	name = "vehicle-chaingunner",
	icon = "__aai-vehicles-chaingunner__/graphics/icons/chaingunner.png",
	icon_size = 64, icon_mipmaps = 1,
	subgroup="transport",
    order = "ac[basic-vehicles]-a[chaingunner]",
	stack_size = 1,
	place_result = "vehicle-chaingunner",
},
{
    type = "gun",
    name = "vehicle-chaingunner-gun",
    icon = "__aai-vehicles-chaingunner__/graphics/icons/chaingunner-gun.png",
		icon_size = 64, icon_mipmaps = 1,
    flags = {"hidden"},
    subgroup = "gun",
    order = "a[basic-clips]-b[tank-machine-gun]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 5,
      movement_slow_down_factor = 0.7,
      damage_modifier = 2,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0},
        creation_distance = -0.6875,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_center = {0, 0},
      projectile_creation_distance = 1.2,
      range = 20,
      sound = sounds.heavy_gunshot,
    },
    stack_size = 1
}})
