local cost_lvl = settings.startup["AR-research-cost"].value

local research_cost = {
	["level-0"] = {
		unit = {
			count = 250,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1}
			},
			time = 30},
		prerequisites = {
			"concrete", 
			"oil-processing"
		}},
	["level-1"] = {
		unit = {
			count = 50,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
			},
			time = 45},
		prerequisites = {
			"concrete", 
			"oil-processing"
		}},
	["level-2"] = {
		unit = {
			count = 350,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1}
			},
			time = 60},
		prerequisites = {
			"concrete", 
			"production-science-pack"
		}}
	}

data:extend(
{
    {
        type = "technology",
        name = "Arci-asphalt",
        icon = "__AsphaltRoads__/graphics/technology/tech-asphalt.png",
        icon_size = 128,
        prerequisites = research_cost[cost_lvl].prerequisites,
        unit = research_cost[cost_lvl].unit,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "Arci-asphalt"
            }
        },
        order = "c-c-d"	
    } 
}
)	

	  
	  