local data_util = require("data-util")

require("prototypes/recipe/recipe-final")

-- if another mod has changed labs but not burner lab
data.raw.lab["burner-lab"].inputs = data.raw.lab["lab"].inputs


if data.raw.item["electronics-machine-1"] and data.raw.recipe["electronic-circuit-stone"] then
  data.raw.recipe["electronic-circuit-stone"].category = "electronics"
end

--log( serpent.block( data.raw.wall, {comment = false, numformat = '%1.8g' } ) )
--log( serpent.block( data.raw, {comment = false, numformat = '%1.8g' } ) )

local max_level = nil
for i = 2, 5 do
  local tech = data.raw.technology["toolbelt-" .. i]
  if tech and tech.max_level then
    max_level = tech.max_level
    tech.max_level = nil
  end
end
if max_level and (type(max_level) ~= "number" or max_level > 6) then
  data.raw.technology["toolbelt-6"].max_level = max_level
end

local enable_tech_list = {"basic-logistics", "basic-automation", "radar", "electricity", "basic-fluid-handling", "steam-power", "electric-lab", "electric-mining"}
for _, tech_name in pairs(enable_tech_list) do
  if data.raw.technology[tech_name] then
    data.raw.technology[tech_name].enabled = true
    if data.raw.technology[tech_name].normal then
      data.raw.technology[tech_name].normal.enabled = true
    end
    if data.raw.technology[tech_name].expensive then
      data.raw.technology[tech_name].expensive.enabled = true
    end
  end
end

if data.raw["fuel-category"]["processed-chemical"] then
  -- add fuel category to burner types
  for _, type in pairs({"assembling-machine", "beacon", "boiler", "burner-generator", "car", "spider-vehicle", "furnace", "inserter", "lab", "locomotive", "mining-drill", "reactor", "generator-equipment"}) do
    for _, proto in pairs(data.raw[type]) do
      if proto.name ~= "fuel-processor" then
        for _, burner_slot in pairs({"burner", "energy_source"}) do
          if proto[burner_slot] then
            local burner = proto[burner_slot]
            if burner.fuel_category then
              burner.fuel_categories = {burner.fuel_category}
              burner.fuel_category = nil
            end
            if not (burner.fuel_category or burner.fuel_categories) then
              burner.fuel_categories = {"chemical"}
            end
            if burner.fuel_categories then
              if data_util.table_contains( burner.fuel_categories, "chemical") then
                table.insert( burner.fuel_categories, "processed-chemical")
              end
            end
          end
        end
      end
    end
  end
else -- scrub all techs from having it as a prereq
  for _, tech in pairs (data.raw.technology) do
    data_util.tech_remove_prerequisites (tech.name, "fuel-processing")
    if tech.prerequisites and table_size(tech.prerequisites) == 0 then
      tech.prerequisites = {"basic-automation"}
    end
  end
end

require("prototypes/compatibility/krastorio2")
require("prototypes/compatibility/dectorio")
