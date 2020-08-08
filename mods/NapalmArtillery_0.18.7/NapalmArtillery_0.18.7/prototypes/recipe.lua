local ingred = 		
        {
			{"cluster-grenade",6},			
			{"explosive-cannon-shell", 4},
			{"rocket-control-unit", 2},
			{"artillery-shell", 1}
		}

if data.raw.fluid["liquid-fuel"] then
   table.insert(ingred,{"liquid-fuel-barrel", 6})
   else
   table.insert(ingred,{"heavy-oil-barrel", 6})
   end

data:extend(
{
	{
		type = "recipe",
		name = "napalm-artillery-shell",
		enabled = false,
		energy_required = 120,
		ingredients = ingred,
		result = "napalm-artillery-shell"
	}
}
)