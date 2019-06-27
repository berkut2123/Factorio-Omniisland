data:extend(
{
  {
    type = "recipe",
    name = "artifact-loot-chest",
    enabled = false,
	ingredients =
	{
	  {"steel-plate", 24},
	  {"electronic-circuit", 25},
	  {"advanced-circuit", 5},
	},	
    result = "artifact-loot-chest",
	requester_paste_multiplier = 1
  }
})

--Unlock the Loot Chest when you research Logistic-robotics
table.insert(data.raw["technology"]["logistic-robotics"].effects,{type="unlock-recipe",recipe="artifact-loot-chest"})