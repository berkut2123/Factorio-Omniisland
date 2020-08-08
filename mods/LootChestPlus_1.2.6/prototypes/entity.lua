require ("util")

local sounds = require("__base__.prototypes.entity.demo-sounds")
local hit_effects = require ("__base__.prototypes.entity.demo-hit-effects")

data:extend({
{
    type = "logistic-container",
    name = "artifact-loot-chest",
    icon = "__LootChestPlus__/graphics/icon-loot-chest.png",
	icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 3.5, result = "artifact-loot-chest"},
    max_health = 400,
    corpse = "small-remnants",
	dying_explosion = "passive-provider-chest-explosion",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.5 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.5 },
	resistances =
    {
      {
        type = "fire",
        percent = 90
      },
	  {	
		type = "impact",
		percent = 60
	  }
    },
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	damaged_trigger_effect = hit_effects.entity(),
	fast_replaceable_group = "container",
    inventory_size = 48,
	logistic_mode = "passive-provider",
    --vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.5 },
	vehicle_impact_sound = sounds.generic_impact,
	picture =
    {
      filename = "__LootChestPlus__/graphics/entity-loot-chest.png",
      priority = "extra-high",
      width = 48,
      height = 34,
	  shift = {0.1875, 0}
	},
    circuit_wire_connection_point =
    {
      shadow =
      {
        red = {0.734375, 0.453125},
        green = {0.609375, 0.515625},
      },
      wire =
      {
        red = {0.40625, 0.21875},
        green = {0.40625, 0.375},
      }
    },
    
	circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
    circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
 }})