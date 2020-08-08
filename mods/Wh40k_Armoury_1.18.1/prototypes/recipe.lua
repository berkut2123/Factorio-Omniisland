data:extend(
{
----------------------------------------
-----------------Weapons----------------
----------------------------------------
--------------------Boltgun----------------
  {
    type = "recipe",
    name = "boltgun",
    enabled = "false",
    ingredients =
    {
	  {"submachine-gun", 1},
      {"combat-shotgun", 1},
	  {"iron-gear-wheel", 20},
	  {"engine-unit", 1},
	  {"advanced-circuit", 10},
      {"steel-plate", 20}
    },
    result = "boltgun",
    energy_required = 60
  },
--------------------Stormbolter----------------
  {
    type = "recipe",
    name = "stormbolter",
    enabled = "false",
    ingredients =
    {
      {"boltgun", 2},
	  --{"electric-engine-unit", 1},
	  {"advanced-circuit", 20},
	  {"effectivity-module", 1},
      {"steel-plate", 5}
    },
    result = "stormbolter",
    energy_required = 60
  },
--------------------Bolt Rifle----------------
  {
    type = "recipe",
    name = "bolt_rifle",
    enabled = "false",
    ingredients =
    {
      {"boltgun", 1},
	  --{"engine-unit", 1},
	  {"advanced-circuit", 20},
	  {"effectivity-module-2", 2},
      {"steel-plate", 5}
    },
    result = "bolt_rifle",
    energy_required = 60
  },
--------------------Heavy Bolter----------------
  {
    type = "recipe",
    name = "heavy_bolter",
    enabled = "false",
    ingredients =
    {
      {"boltgun", 2},
	  {"electric-engine-unit", 1},
	  {"advanced-circuit", 30},
	  --{"effectivity-module-2", 3},
      {"steel-plate", 25}
    },
    result = "heavy_bolter",
    energy_required = 60
  },
--------------------Assault Bolter----------------
  {
    type = "recipe",
    name = "assault_bolter",
    enabled = "false",
    ingredients =
    {
      {"heavy_bolter", 1},
	  --{"electric-engine-unit", 1},
	  --{"advanced-circuit", 20},
	  {"effectivity-module-2", 1},
      --{"steel-plate", 25}
    },
    result = "assault_bolter",
    energy_required = 60
  },
----------------------------------------
--------------------AMMO----------------
----------------------------------------
--------------------75----------------------
--------------------Mk1----------------
  {
    type = "recipe",
    name = "bolt75mk1",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {"explosives", 1},
	  {"advanced-circuit", 1},
      {"steel-plate", 2}
    },
    result = "bolt75mk1"
  },
--------------------Mk2----------------
  {
    type = "recipe",
    name = "bolt75mk2",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
	  {"bolt75mk1", 1},
      {"explosives", 5},
	  {"processing-unit", 1}
    },
    result = "bolt75mk2"
  },
--------------------Metal Storm----------------
  {
    type = "recipe",
    name = "bolt75metalstorm",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
	  {"bolt75mk1", 1},
      {"steel-plate", 3},
	  {"processing-unit", 1}
    },
    result = "bolt75metalstorm"
  },
--------------------Kraken----------------
  {
    type = "recipe",
    name = "bolt75kraken",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {"bolt75mk2", 1},
      {"steel-plate", 5},
	  {"processing-unit", 2}
    },
    result = "bolt75kraken"
  },
--------------------Hellfire----------------
  {
    type = "recipe",
    name = "bolt75hellfire",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {"bolt75mk2", 1},
      {"poison-capsule", 1},
	  {"processing-unit", 2}
    },
    result = "bolt75hellfire"
  },
--------------------Inferno----------------
  {
    type = "recipe",
    name = "bolt75inferno",
	category = "chemistry",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {"bolt75mk2", 1},
	  {type="fluid", name="heavy-oil", amount=5},
	  {type="fluid", name="light-oil", amount=5},
	  {"processing-unit", 2}
    },
    result = "bolt75inferno"
  },
--------------------100----------------------
--------------------Mk1----------------
  {
    type = "recipe",
    name = "bolt100mk1",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
      {"explosives", 2},
	  {"advanced-circuit", 2},
      {"steel-plate", 4}
    },
    result = "bolt100mk1"
  },
--------------------Mk2----------------
  {
    type = "recipe",
    name = "bolt100mk2",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
	  {"bolt100mk1", 1},
      {"explosives", 10},
	  {"processing-unit", 2}
    },
    result = "bolt100mk2"
  },
--------------------Metal Storm----------------
  {
    type = "recipe",
    name = "bolt100metalstorm",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
	  {"bolt100mk1", 1},
      {"steel-plate", 6},
	  {"processing-unit", 2}
    },
    result = "bolt100metalstorm"
  },
--------------------Kraken----------------
  {
    type = "recipe",
    name = "bolt100kraken",
    enabled = false,
    energy_required = 3,
    ingredients =
     {
      {"bolt100mk2", 1},
      {"steel-plate", 10},
	  {"processing-unit", 3}
    },
    result = "bolt100kraken"
  },
--------------------Hellfire----------------
  {
    type = "recipe",
    name = "bolt100hellfire",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
      {"bolt100mk2", 1},
      {"poison-capsule", 2},
	  {"processing-unit", 3}
    },
    result = "bolt100hellfire"
  },
--------------------Inferno----------------
  {
    type = "recipe",
    name = "bolt100inferno",
	category = "chemistry",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
      {"bolt100mk2", 1},
	  {type="fluid", name="heavy-oil", amount=10},
	  {type="fluid", name="light-oil", amount=10},
	  {"processing-unit", 3}
    },
    result = "bolt100inferno"
  },
}
)

