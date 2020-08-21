data:extend(
{
    {
        type = "recipe",
        name = "ln-flare-capsule",
        enabled = settings.startup["Clockwork-enable-flares"].value,
        energy_required = 4,
        ingredients =
        {
            {"electronic-circuit", 1},
            {"coal", 2}
        },
        result = "ln-flare-capsule"
    },
})