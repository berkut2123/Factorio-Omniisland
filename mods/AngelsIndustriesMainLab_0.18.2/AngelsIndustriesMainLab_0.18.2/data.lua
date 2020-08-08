if mods["angelsindustries"] and settings.startup["angels-enable-components"].value then
    data:extend
    (
        {
            {
                type="recipe",
                name="angels-main-lab",
                energy_required=5,
                enabled=true,
                ingredients=
                {
                    {"block-electronics-0", 5},
                    {"block-construction-1", 5}
                },
                result="angels-main-lab-1",
                icon_size=32
            }
        }
    )
end