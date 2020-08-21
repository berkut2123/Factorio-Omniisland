data:extend(
{
  {
    type = "recipe",
    name = "artifact-loot-chest",
    enabled = false,
	energy_required = 5,
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

--Unlock the loot-chest when you research Logistic robotics
table.insert(data.raw["technology"]["logistic-robotics"].effects,{type="unlock-recipe",recipe="artifact-loot-chest"})

--Unlock the loot-chest when you research Deadlock-robotower (Deadlock's Industrial Revolution)
if mods["IndustrialRevolution"] then
table.insert(data.raw["technology"]["deadlock-robotower"].effects,{type="unlock-recipe",recipe="artifact-loot-chest"})
end