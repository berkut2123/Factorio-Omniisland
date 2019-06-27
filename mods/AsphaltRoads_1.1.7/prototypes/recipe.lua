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
            primary = {r = 0.130, g = 0.150, b = 0.110, a = 0.300}, 
            secondary = {r = 0.150, g = 0.170, b = 0.150, a = 0.100}, 
            tertiary = {r = 0.450, g = 0.470, b = 0.490, a = 0.400}, 
        }
    }
})