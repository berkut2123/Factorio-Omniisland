data:extend({
    {
      type = "recipe",
      name = "armor-pocket-equipment",
      enabled = false,
      energy_required = 10,
      ingredients =
        {
          {"steel-chest", settings.startup["armor_pockets_slot_amount"].value},
          {"advanced-circuit", settings.startup["armor_pockets_slot_amount"].value},
          {"electronic-circuit", (settings.startup["armor_pockets_slot_amount"].value * 5)},
          {"iron-gear-wheel", (settings.startup["armor_pockets_slot_amount"].value * 2)},
        },
        result = "armor-pocket-equipment"
    }
})