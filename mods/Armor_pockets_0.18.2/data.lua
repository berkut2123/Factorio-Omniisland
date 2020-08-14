require("prototypes.item")
require("prototypes.recipe")
require("prototypes.entity")
require("prototypes.technology")


--Base Game
--Night Vision
if settings.startup["small_night_vision"].value then
    for _, nve in pairs(data.raw["night-vision-equipment"]) do
      if nve.shape.width == 2 then
        nve.shape = {
          width = 1,
          height = 1,
          type = "full"
        }
        end
    end
end

--Armor pocket MK2
if settings.startup["armor_pocket_mk2"].value then
    data:extend({
        {
            type = "battery-equipment",
            name = "armor-pocket-mk2-equipment",
            sprite =
            {
              filename = "__Armor_pockets__/graphics/icons/armor-pocket-mk2-64.png",
              width = 64,
              height = 64,
              priority = "medium"
            },
            shape =
            {
              width = 2,
              height = 2,
              type = "full"
            },
            energy_source =
            {
              type = "electric",
              buffer_capacity = nil,
              input_flow_limit = nil,
              usage_priority = "primary-input"
            },
            energy_input = nil,
            tint = {r = 0, g = 0.1, b = 0, a = 0.2},
            categories = {"armor"}
        },
		--item
    	{
            type = "item",
            name = "armor-pocket-mk2-equipment",
            icon = "__Armor_pockets__/graphics/icons/armor-pocket-mk2-64.png",    
            placed_as_equipment_result = "armor-pocket-mk2-equipment",
            subgroup = "equipment",
            order = "f[armor-pocket]-b[armor-pocket-mk2-equipment]",
            stack_size = 20,
            icon_size = 64,
            icon_mipmaps = 0
        },
	   --recipe
        {
            type = "recipe",
            name = "armor-pocket-mk2-equipment",
            enabled = false,
            energy_required = 10,
            ingredients =
            {
              {"armor-pocket-equipment", math.floor(settings.startup["armor_pockets_mk2_mult"].value)},
              {"low-density-structure", math.floor(settings.startup["armor_pockets_mk2_mult"].value * settings.startup["armor_pockets_slot_amount"].value)},
            },
            result = "armor-pocket-mk2-equipment"
        },
        --technology
        {
            type = "technology",
            name = "armor-pocket-mk2-equipment",
            icon = "__Armor_pockets__/graphics/icons/armor-pocket-mk2-technology.png",
            icon_size = 128,
            prerequisites = {"armor-pocket-equipment", "power-armor"},
            effects =
            {
              {
                type = "unlock-recipe",
                recipe = "armor-pocket-mk2-equipment"
              }
            },
            unit =
            {
              count = 100,
              ingredients = 
	        	{
                    { "automation-science-pack", 1 },
                    { "logistic-science-pack", 1 },
	        		{ "chemical-science-pack", 1 },
                },
              time = 30
            },
            order = "g-g"
        }
    })
end