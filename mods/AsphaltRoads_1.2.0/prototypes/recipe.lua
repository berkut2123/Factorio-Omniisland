data:extend(
{
    {
        type = "recipe",
        name = "Arci-asphalt",
        energy_required = 10,
        enabled = false,
        category = "chemistry",
        ingredients =
        {
            {type="fluid", name="crude-oil", amount=30},
            {type="fluid", name="heavy-oil", amount=30},
            {type="item", name="stone-brick", amount=4}
        },
        result= "Arci-asphalt",
        result_count = 10,
        crafting_machine_tint =
        {
			primary = {r = 0.05, g = 0.05, b = 0.0, a = 1}, 
            secondary = {r = 0.1, g = 0.03, b = 0.1, a = 0.5}, 
            tertiary = {r = 0.1, g = 0.03, b = 0.1, a = 0.8}, 
			quaternary = {r = 0.05, g = 0.05, b = 0.0, a = 1}
        }
    }
})