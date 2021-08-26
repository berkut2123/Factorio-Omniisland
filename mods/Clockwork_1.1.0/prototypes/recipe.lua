local ingredients_table =
{
	{"coal", 2},
	{"iron-plate", 1}
}

if settings.startup["Clockwork-flares-simple"].value then
	table.insert(ingredients_table, {"copper-plate", 1})
else
	table.insert(ingredients_table, {"electronic-circuit", 1})
end

data:extend(
{
    {
        type = "recipe",
        name = "ln-flare-capsule",
        enabled = settings.startup["Clockwork-enable-flares"].value,
        energy_required = 4,
        ingredients = ingredients_table,
        -- {
            -- {"electronic-circuit", 1},
            -- {"coal", 2}
        -- },
        result = "ln-flare-capsule"
    },
})