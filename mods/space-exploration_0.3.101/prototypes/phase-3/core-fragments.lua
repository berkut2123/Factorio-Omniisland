local data_util = require("data_util")

local resource_image = {
    filename = "__space-exploration-graphics__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
    variation_count = 1,
}

-- core fragments (cooled magma)
-- A generic mining recipe is used, the actual output item is chosen by script
-- default is 1, set 0 to exclude
se_core_fragment_resources = se_core_fragment_resources or {}
se_core_fragment_resources["water"] = se_core_fragment_resources["water"] or { multiplier = 0, omni_multiplier = 0.1}
se_core_fragment_resources["crude-oil"] = se_core_fragment_resources["crude-oil"] or { multiplier = 1, omni_multiplier = 0.1}
se_core_fragment_resources["stone"] = se_core_fragment_resources["stone"] or { multiplier = 1, omni_multiplier = 1}
se_core_fragment_resources["iron-ore"] = se_core_fragment_resources["iron-ore"] or { multiplier = 1.2, omni_multiplier = 1.2}
se_core_fragment_resources["copper-ore"] = se_core_fragment_resources["copper-ore"] or { multiplier = 1, omni_multiplier = 1}
se_core_fragment_resources["coal"] = se_core_fragment_resources["coal"] or { multiplier = 1, omni_multiplier = 0.5}
se_core_fragment_resources["uranium-ore"] = se_core_fragment_resources["uranium-ore"] or { multiplier = 0.2, omni_multiplier = 0.01}
se_core_fragment_resources[data_util.mod_prefix .. "vulcanite"] = se_core_fragment_resources[data_util.mod_prefix .. "vulcanite"] or  { multiplier = 1, omni_multiplier = 0.4}

se_core_fragment_resources[data_util.mod_prefix .. "beryllium-ore"] = se_core_fragment_resources[data_util.mod_prefix .. "beryllium-ore"] or { multiplier = 1, omni_multiplier = 0}
se_core_fragment_resources[data_util.mod_prefix .. "iridium-ore"] = se_core_fragment_resources[data_util.mod_prefix .. "iridium-ore"] or { multiplier = 1, omni_multiplier = 0}
se_core_fragment_resources[data_util.mod_prefix .. "holmium-ore"] = se_core_fragment_resources[data_util.mod_prefix .. "holmium-ore"] or { multiplier = 1, omni_multiplier = 0}
se_core_fragment_resources[data_util.mod_prefix .. "vitamelange"] = se_core_fragment_resources[data_util.mod_prefix .. "vitamelange"] or { multiplier = 1, omni_multiplier = 0}
se_core_fragment_resources[data_util.mod_prefix .. "cryonite"] = se_core_fragment_resources[data_util.mod_prefix .. "cryonite"] or { multiplier = 1, omni_multiplier = 0}

se_core_fragment_resources[data_util.mod_prefix .. "water-ice"] = se_core_fragment_resources[data_util.mod_prefix .. "water-ice"] or { multiplier = 0, omni_multiplier = 0}
se_core_fragment_resources[data_util.mod_prefix .. "methane-ice"] = se_core_fragment_resources[data_util.mod_prefix .. "methane-ice"] or { multiplier = 0, omni_multiplier = 0}
se_core_fragment_resources[data_util.mod_prefix .. "naquium-ore"] = se_core_fragment_resources[data_util.mod_prefix .. "naquium-ore"] or { multiplier = 0, omni_multiplier = 0}

local fragments = {}
local omni_name = data_util.mod_prefix .. "core-fragment-omni"
fragments[omni_name] = {name = omni_name, divisor = 1, products = {}}

for _, resource in pairs(data.raw.resource) do
  --log("add fragment resource " ..  resource.name )
  if resource.autoplace then -- don't add removed resources?
    local fragment = {
      name = data_util.mod_prefix .. "core-fragment-" .. resource.name,
      item_name = "entity-name."..resource.name
    }
    --log(resource.name)
    local products = {}
    if resource.minable.result and type(resource.minable.result) == "string" then
      products[resource.minable.result] = {name = resource.minable.result, amount = 1}
    elseif type(resource.minable.result) == "table" then
      local product = data_util.collapse_product(resource.minable.result)
      products[product.name] = product
    elseif resource.minable.results and resource.minable.results.name then
      products = {data_util.collapse_product(resource.minable.results)}
    elseif resource.minable.results and resource.minable.results[1] and type(resource.minable.results[1]) == "table" then
      for _, p in pairs(resource.minable.results) do
        table.insert(products, data_util.collapse_product(p))
      end
    elseif resource.minable.results then
      products = data_util.collapse_product(resource.minable.results)
    end
    local valid_products = 0
    if table_size(products) > 0 then
      fragment.products = products
      for _, product in pairs(products) do
        local amount = 0
        if product.amount then
          amount = product.amount
        elseif product.amount_min and product.amount_max then
          amount = (product.amount_min + product.amount_max) / 2
        end
        if product.probability then amount = amount * product.probability end

        product.amount = amount
        if se_core_fragment_resources[product.name] and se_core_fragment_resources[product.name].multiplier then
          product.amount = amount * se_core_fragment_resources[product.name].multiplier
        end

        product.amount_min = nil
        product.amount_max = nil
        product.probability = 1

        if product.amount == 0 then
          products[product.name] = nil
        else
          valid_products = valid_products + 1
        end

        local omni_multiplier = 1
        if se_core_fragment_resources[product.name] and se_core_fragment_resources[product.name].omni_multiplier then
          omni_multiplier = se_core_fragment_resources[product.name].omni_multiplier
        end
        if omni_multiplier > 0 then
          fragments[omni_name].products[product.name] = fragments[omni_name].products[product.name] or {name = product.name, amount = 0, type = product.type}
          fragments[omni_name].divisor = fragments[omni_name].divisor + 1
          fragments[omni_name].products[product.name].amount = fragments[omni_name].products[product.name].amount + amount * omni_multiplier
        end
      end
    end
    if valid_products > 0 then
      fragments[fragment.name] = fragment
    end
  end
end

-- water, can be hard to find on some planets,
-- adding water to the omni measn there's a small chance that
-- a different fragment type breaks down into something with water
if not fragments[omni_name].products["water"] then
  fragments[omni_name].products.water = {name = "water", type = "fluid", amount = 5}
end

-- TODO: test with high fluid resource modpack
local omni_fluids = 0
for _, product in pairs(fragments[omni_name].products) do
  if product.type == "fluid" then
    omni_fluids = omni_fluids + 1
  end
end
if omni_fluids > 4 then -- water infinite anyway
  fragments[omni_name].products.water = nil
  omni_fluids = omni_fluids - 1
end
if omni_fluids > 4 then -- crude-oil infinite anyway
  fragments[omni_name].products["crude-oil"] = nil
  omni_fluids = omni_fluids - 1
end
if omni_fluids > 4 then
  local safe_products = {}
  omni_fluids = 0
  for _, product in pairs(fragments[omni_name].products) do
    if product.type == "fluid" then
      if omni_fluids < 4 then
        safe_products[product.name] = product
        omni_fluids = omni_fluids + 1
      end
    else
      safe_products[product.name] = product
    end
  end
  fragments[omni_name].products = safe_products
end


local c = 0
for _, fragment in pairs(fragments) do
    c = c + 1
    local key_product = fragment.products[1]
    local locale
    if fragment.resource_name then
      locale = "resource-name." .. fragment.resource_name
    end
    local item =
    {
      type = "item",
      name = fragment.name,
      icon_size = 32,
      icons = {
        {icon = "__space-exploration-graphics__/graphics/icons/core-fragment.png", scale = 1, icon_size = 32}
      },
      subgroup = "core-fragments",
      order = "a"..c,
      stack_size = 100,
      localised_name = {"item-name.core-fragment", {fragment.item_name}}
    }
    if table_size(fragment.products) == 1 then
      for _, product in pairs(fragment.products) do
        if product.type == "fluid" and  data.raw.fluid[product.name] and  data.raw.fluid[product.name].icon then
          table.insert(item.icons, {
            icon = data.raw.fluid[product.name].icon,
            icon_size = data.raw.fluid[product.name].icon_size,
            scale = 32 / data.raw.fluid[product.name].icon_size,
            tint = {r = 0.5, g = 0.5, b = 0.5, a = 0.5},
          })
        elseif data.raw.item[product.name] and data.raw.item[product.name].icon then
          table.insert(item.icons, {
            icon = data.raw.item[product.name].icon,
            icon_size = data.raw.item[product.name].icon_size,
            scale = 32 / data.raw.item[product.name].icon_size,
            tint = {r = 0.5, g = 0.5, b = 0.5, a = 0.5}
          })
        end
      end
    end
    local recipe_products = { }
    if _ ~= omni_name then
      table.insert(recipe_products, {name = omni_name, amount = 5})
    else
      item.localised_name  = nil
    end
    local has_stone = false
    --local has_vulcanite = false
    for _, product in pairs(fragment.products) do
      if product.name == "stone" then has_stone = true end
      --if product.name ==  data_util.mod_prefix.."vulcanite" then has_vulcanite = true end
      local prod = {type = product.type, name = product.name}
      if product.amount * 10 >= 1 then
        prod.amount = product.amount * 10
      else
        prod.amount = nil
        prod.probability = product.amount * 10
        prod.amount_min = 1
        prod.amount_max = 1
      end
      table.insert(recipe_products, prod)
    end
    if not has_stone then
      table.insert(recipe_products, {name = "stone", amount = 1})
    end
    --if not has_vulcanite then
    --  table.insert(recipe_products, {name = data_util.mod_prefix.."vulcanite", amount = 1})
    --end
    local recipe = {
      type = "recipe",
      name = fragment.name,
      icon_size = 32,
      icons = item.icons,
      subgroup = "core-fragments",
      category = "core-fragment-processing",
      order = "a"..c,
      flags = {
        "goes-to-main-inventory"
      },
      ingredients = {{name = item.name, amount = 16}},
      results = recipe_products,
      allow_as_intermediate = false, -- prevent being sown as a base resource?
      energy_required = 16,
      enabled = false,
      localised_name = {"recipe-name.core-fragment", {fragment.item_name}},
      always_show_made_in = true,
    }
    if _ == omni_name then
      recipe.localised_name  = nil
    end
    local core_resource_patch = {
      type = "resource",
      name = fragment.name,
      category = data_util.mod_prefix.."core-mining",
      collision_box = { { -1.4, -1.4  }, { 1.4, 1.4 } },
      selection_box = { { -1.4, -1.4  }, { 1.4, 1.4 } },
      selectable_in_game = false,
      --collision_mask = {"not-colliding-with-itself"},
      flags = { "placeable-neutral" },
      highlight = false,
      icon_size = 32,
      icons = item.icons,
      infinite = true,
      infinite_depletion_amount = 0,
      map_color = { b = 0, g = 0, r = 0, a = 0 },
      map_grid = false,
      minable = {
        mining_time = 12.5,
        results = {
          {
            amount_max = 1,
            amount_min = 1,
            name = fragment.name,
            probability = 1,
          }
        }
      },
      minimum = 1,
      normal = 1000000,
      order = "a-b-a",
      resource_patch_search_radius = 0,
      stage_counts = { 0 },
      stages = { sheet = resource_image },
      localised_name = {"entity-name."..data_util.mod_prefix .. "core-fissure"}
    }
    data:extend({
      core_resource_patch,
      item,
      recipe
    })
    table.insert(
      data.raw.technology[data_util.mod_prefix .. "core-miner"].effects,
      {
        type = "unlock-recipe",
        recipe = recipe.name,
      }
    )
    data_util.allow_productivity(fragment.name)
    se_delivery_cannon_recipes[fragment.name] = {name=fragment.name, amount=50}
end
