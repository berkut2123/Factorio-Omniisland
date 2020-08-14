local TGlib = require("lib.TGlib")



data:extend{
  {
	  type = "item-group",
	  name = "transport",
	  order = settings.startup["transportgroup-order"].value,
	  icon = "__base__/graphics/technology/automobilism.png",
	  icon_size = 128,
  },
	{
		type = "item-subgroup",
		name = "vehicles-railway",
		group = "transport",
		order = "b",
	},
	{
		type = "item-subgroup",
		name = "vehicles-civilian",
		group = "transport",
		order = "c",
	},
	{
		type = "item-subgroup",
		name = "vehicles-military",
		group = "transport",
		order = "d",
	},
	{
		type = "item-subgroup",
		name = "vehicle-equipment",
		group = "transport",
		order = "q",
	},
	{
		type = "item-subgroup",
		name = "vehicle-equipment-defense",
		group = "transport",
		order = "r",
	},
}



local dr = data.raw
TGlib.check_set_value(dr, {"item-subgroup", "transport", "group"}, "transport") --"logistics"
TGlib.check_set_value(dr, {"item-subgroup", "transport", "order"}, "a") --"e"

-- Move only vanilla items
-- Basic construction items (e.g., rail, train stop, rail signals) keep using subgroup = "transport"
-- Railway vehicles
TGlib.check_set_value(dr, {"item-with-entity-data", "locomotive", "subgroup"}, "vehicles-railway")
TGlib.check_set_value(dr, {"item-with-entity-data", "cargo-wagon", "subgroup"}, "vehicles-railway")
TGlib.check_set_value(dr, {"item-with-entity-data", "fluid-wagon", "subgroup"}, "vehicles-railway")
TGlib.check_set_value(dr, {"item-with-entity-data", "artillery-wagon", "subgroup"}, "vehicles-railway")
-- Civilian vehicles (non-combat)
TGlib.check_set_value(dr, {"item-with-entity-data", "car", "subgroup"}, "vehicles-civilian")
-- Military vehicles (combat)
TGlib.check_set_value(dr, {"item-with-entity-data", "tank", "subgroup"}, "vehicles-military")

-- Mods should use an optional dependency "? SchallTransportGroup"
-- Then set your own __item__.subgroup = __subgroupname__
-- If needing further subgroups, see SchallTankPlatoon, SchallAlienTech or SchallArmouredTrain for examples
