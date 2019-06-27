local setting_recipe_amount = settings.startup["deep-mine-recipe-amount"].value
local setting_recipe_probability = settings.startup["deep-mine-recipe-percentage"].value / 100
local setting_adv_recipe_primary_probability = settings.startup["deep-mine-adv-recipe-primary-percentage"].value / 100
local setting_adv_recipe_secondary_probability = settings.startup["deep-mine-adv-recipe-secondary-percentage"].value / 100
local base_mining_time = 2

local minable_ores = {}
local minable_ores_count = 0

-- find ores
for k, resource in pairs(data.raw["resource"]) do
  if not resource.minable or resource.minable.required_fluid then
    goto skipResource
  end

  if resource.minable.results then
    for _,result in pairs (resource.minable.results) do
      if result.type == "item" and data.raw.item[result.name] and not minable_ores[result.name] then
        -- log( serpent.block(resource) )
        minable_ores[result.name] = { hardness = resource.minable.hardness or 1, mining_time = resource.minable.mining_time }
        minable_ores_count = minable_ores_count + 1
      end
    end
  elseif resource.minable.result and not minable_ores[resource.minable.result] then
    -- log( serpent.block(resource) )
    minable_ores[resource.minable.result] = { hardness = resource.minable.hardness or 1, mining_time = resource.minable.mining_time }
    minable_ores_count = minable_ores_count + 1
  else
    goto skipResource
  end

  ::skipResource::
end

-- log( serpent.block(minable_ores) )


if minable_ores_count == 0 then
  return
end

-- generate basic recipe with equal distribution
local basic_recipe = {
  type = "recipe",
  name = "deep-mining",
  category = "deep-mine",
  enabled = false,
  hidden = false,
  icon = "__DeepMine__/graphics/icons/recipe.png",
  icon_size = 64,
  ingredients = {},
  results = {},
  energy_required = base_mining_time,
  subgroup = "raw-resource",
  order = "a",
}
for k, v in pairs(minable_ores) do
  table.insert(basic_recipe.results, {type = "item", name = k, amount = setting_recipe_amount, probability = setting_recipe_probability})
  basic_recipe.energy_required = basic_recipe.energy_required + v.hardness * v.mining_time * setting_recipe_amount * setting_recipe_probability
end

data:extend({ basic_recipe })

-- add to same tech as mk1 deep mine
if data.raw["technology"]["deep-mine"] then
  table.insert( data.raw["technology"]["deep-mine"].effects,
    {
        type = "unlock-recipe",
        recipe = basic_recipe.name
    } )
end

-- allow productivity
for k,v in pairs(data.raw.module) do
  if v.limitation then
    table.insert(v.limitation, basic_recipe.name)
  end
end


-- generate advanced recipes
i = 1
for ore_name, ore_data in pairs(minable_ores) do
  if data.raw.item[ore_name] then
    local adv_recipe = {
      type = "recipe",
      name = "deep-mining-"..ore_name,
      localised_name = {"recipe-name.deep-mining-advanced", {"item-name." .. ore_name}},
      category = "deep-mine",
      enabled = false,
      hidden = false,
      ingredients = {},
      results = { {type = "item", name = ore_name, amount = setting_recipe_amount, probability = setting_adv_recipe_primary_probability} },
      energy_required = 3 * base_mining_time + ore_data.hardness * ore_data.mining_time * setting_recipe_amount * setting_adv_recipe_primary_probability,
      subgroup = "raw-resource",
      order = "a"..string.format("%02d", i),
    }
    -- use icons or icon from main product for recipe
    if data.raw.item[ore_name].icons then
      adv_recipe.icons = table.deepcopy(data.raw.item[ore_name].icons)
      adv_recipe.icon_size = data.raw.item[ore_name].icon_size
    elseif data.raw.item[ore_name].icon then
      adv_recipe.icon = data.raw.item[ore_name].icon
      adv_recipe.icon_size = data.raw.item[ore_name].icon_size
    else --failsafe
      adv_recipe.icon = "__DeepMine__/graphics/icons/recipe.png"
      adv_recipe.icon_size = 64
    end

    for k, v in pairs(minable_ores) do
      -- populate other ores as low probability results
      if k ~= ore_name then
        table.insert(adv_recipe.results, {type = "item", name = k, amount = setting_recipe_amount, probability = setting_adv_recipe_secondary_probability})
        adv_recipe.energy_required = adv_recipe.energy_required + v.hardness * v.mining_time * setting_recipe_amount * setting_adv_recipe_secondary_probability
      end
    end

    data:extend({ adv_recipe })

    -- add to same tech as mk2 deep mine
    if data.raw["technology"]["deep-mine-2"] then
    table.insert( data.raw["technology"]["deep-mine-2"].effects,
      {
          type = "unlock-recipe",
          recipe = adv_recipe.name
      } )
    end

    -- allow productivity
    for k,v in pairs(data.raw.module) do
      if v.limitation then
        table.insert(v.limitation, adv_recipe.name)
      end
    end

    i = i + 1
  else
    log("[DeepMine] Warning: Ore "..ore_name.." not found in data.raw.item.")
  end
end











