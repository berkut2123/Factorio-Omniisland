
local ingred = 		
        {
			{"cluster-grenade",1},			
			{"explosive-cannon-shell", 3},
			{"effectivity-module-2", 1},
			{"radar", 1}
		}

if data.raw.fluid["liquid-fuel"] then
   table.insert(ingred,{"liquid-fuel-barrel", 4})
   else
   table.insert(ingred,{"heavy-oil-barrel", 4})
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