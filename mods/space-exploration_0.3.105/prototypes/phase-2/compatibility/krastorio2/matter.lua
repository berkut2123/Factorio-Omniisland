local data_util = require("data_util")

local value_multiplier = 2

local matter = require("__Krastorio2__/lib/public/data-stages/matter-util")
--[[matter_func.createMatterRecipe(args) {
  item_name = a, -- (string) the name of raw product.
  minimum_conversion_quantity = b, -- (integer) the quantity of item necessary to make one conversion, is also the returned quantity from one deconversion.
  matter_value = c, -- (integer) how much matter is gained by conversion and necessary to create the item from matter(minimum_conversion_quantity corresponds to matter_value).
  conversion_matter_value = d, -- (optional)(integer) Different value from the matter_value of the item, that specify the matter gained by converting this item to matter (used when wanted different values on conversions).
  return_item = e, -- (optional)(string) if the return item from the decoversion(matter to item) is different from the first one.
  unlocked_by_technology = f, -- (optional)(string) what technology(the name) unlock the recipes, if isn't setted will be the first that make access to matter conversions.
  energy_required = g, -- (optional)(integer) how much time need the conversion.
  only_conversion = h, -- (optional)(boolean) if this param is true will be added only the recipe to get matter from the item, but not the deconversion from matter.
  only_deconversion = i, -- (optional)(boolean) if this param is true will be added only the recipe to get the item(or return_item) from matter, but not the conversion to matter.
  need_stabilizer = l, (optional)(boolean) if the item need stabilizer to be deconverted from matter to the original item(or return_item).
  allow_productivity = m, (optional)(boolean) if true, productivity modules can be used on de-conversion from matter (matter->item).
}
default values:
  wood 2
  iron ore 5
  raw rare metals 8
  stone 3.5
  water 0.5
  uranium ore 8
  copper plate 7.5
  rare metals 14
  plastic bar 6.6
  matter cube 1000
]]

-- matter has a similar role to the fusion-based matter fabricator,
-- but K2 matter is better in almost every way so is the clear upgrade
-- material fabricator is lat energy tech
-- matter system should be deep space tech (deep space tech needs some nice new toys anyway)
-- matter system also shouldn't be too early as it makes the resource logistic challenge much easier.
-- matter system fits well conceptually with deep space theme.
data_util.tech_add_prerequisites("kr-matter-processing", {data_util.mod_prefix .. "space-matter-fusion", data_util.mod_prefix .. "deep-space-science-pack"})

local make_tech = function(name, tech_image)
  data:extend({
    {
      type = "technology",
      name = data_util.mod_prefix .. "kr-matter-"..name.."-processing",
      mod = "space-exploration",
      icons = {
        { icon = "__Krastorio2__/graphics/technologies/backgrounds/matter.png", icon_size = 128},
        { icon = "__space-exploration-graphics__/graphics/technology/"..tech_image..".png", icon_size = 128, scale = 0.5}
      },
      effects = {},
      prerequisites = {"kr-matter-processing"},
      order = "g-e-e",
      unit =
      {
        count = 500,
        ingredients =
        {
          {"production-science-pack", 1},
          {"utility-science-pack", 1},
          {"matter-tech-card", 1}
        },
        time = 60
      }
    }
  })
end

-- add as sand sink
krastorio.matter_func.createMatterRecipe({
  item_name = "sand",
  minimum_conversion_quantity = 10,
  matter_value = 1.5,
  conversion_matter_value = 1,
  energy_required = 0.5,
  need_stabilizer = false,
  unlocked_by_technology = "kr-matter-stone-processing"
})

make_tech("vulcanite", "vulcanite-processing")
krastorio.matter_func.createMatterRecipe({
  item_name = data_util.mod_prefix .. "vulcanite",
  minimum_conversion_quantity = 10,
  matter_value = value_multiplier * 4*8, -- x8
  conversion_matter_value = value_multiplier * 4,
  energy_required = value_multiplier * 4,
  need_stabilizer = true,
  unlocked_by_technology = data_util.mod_prefix .. "kr-matter-vulcanite-processing"
})

make_tech("cryonite", "cryonite-processing")
krastorio.matter_func.createMatterRecipe({
  item_name = data_util.mod_prefix .. "cryonite",
  minimum_conversion_quantity = 10,
  matter_value = value_multiplier * 5*8, -- x8
  conversion_matter_value = value_multiplier * 5,
  energy_required = value_multiplier * 5,
  need_stabilizer = true,
  unlocked_by_technology = data_util.mod_prefix .. "kr-matter-cryonite-processing"
})

make_tech("beryllium", "beryllium-processing")
krastorio.matter_func.createMatterRecipe({
  item_name = data_util.mod_prefix .. "beryllium-ore",
  minimum_conversion_quantity = 10,
  matter_value = value_multiplier * 6*8, -- x8
  conversion_matter_value = value_multiplier * 6,
  energy_required = value_multiplier * 6,
  need_stabilizer = true,
  unlocked_by_technology = data_util.mod_prefix .. "kr-matter-beryllium-processing"
})

make_tech("holmium", "holmium-processing")
krastorio.matter_func.createMatterRecipe({
  item_name = data_util.mod_prefix .. "holmium-ore",
  minimum_conversion_quantity = 10,
  matter_value = value_multiplier * 7*8, -- x8
  conversion_matter_value = value_multiplier * 7,
  energy_required = value_multiplier * 7,
  need_stabilizer = true,
  unlocked_by_technology = data_util.mod_prefix .. "kr-matter-holmium-processing"
})

make_tech("iridium", "iridium-processing")
krastorio.matter_func.createMatterRecipe({
  item_name = data_util.mod_prefix .. "iridium-ore",
  minimum_conversion_quantity = 10,
  matter_value = value_multiplier * 8*8, -- x8
  conversion_matter_value = value_multiplier * 8,
  energy_required = value_multiplier * 8,
  need_stabilizer = true,
  unlocked_by_technology = data_util.mod_prefix .. "kr-matter-iridium-processing"
})
