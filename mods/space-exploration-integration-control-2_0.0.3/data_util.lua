local data_util = {}

data_util.mod_prefix = "se-" -- update strings.cfg

data_util.liquid_rocket_fuel_per_solid = 50

data_util.coolant_temperature = {
    supercooled = -273,
    cold = -100,
    normal = -10,
    hot = 25
}

data_util.obs_types = {
  ["visible"] = {"visible", 12, 0.98},
  ["infrared"] = {"infrared", 10, 0.85},
  ["uv"] = {"uv", 10, 0.9},
  ["microwave"] = {"microwave", 8, 0.75},
  ["xray"] = {"xray", 4, 0.85},
  ["radio"] = {"radio", 6, 0.6},
  ["gammaray"] = {"gammaray", 3, 0.85},
}

data_util.char_to_multiplier = {
    m = 0.001,
    c = 0.01,
    d = 0.1,
    h = 100,
    k = 1000,
    M = 1000000,
    G = 1000000000,
    T = 1000000000000,
    P = 1000000000000000,
}


function data_util.string_to_number (str)
    str = ""..str
    local number_string = ""
    local last_char = nil
    for i = 1, #str do
        local c = str:sub(i,i)
        if c == "." or tonumber(c) ~= nil then
            number_string = number_string .. c
        else
            last_char = c
            break
        end
    end
    if last_char and data_util.char_to_multiplier[last_char] then
        return tonumber(number_string) * data_util.char_to_multiplier[last_char]
    end
    return tonumber(number_string)
end

function data_util.replace (str, what, with)
    what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = string.gsub(with, "[%%]", "%%%%") -- escape replacement
    return string.gsub(str, what, with)
end

function data_util.hr(value)
  if mods["space-exploration-hr-graphics"] then return value end
end

function data_util.remove_from_table(list, item)
    local index = 0
    for _,_item in ipairs(list) do
        if item == _item then
            index = _
            break
        end
    end
    if index > 0 then
        table.remove(list, index)
    end
end

function data_util.table_contains(table, check)
  for k,v in pairs(table) do if v == check then return true end end
  return false
end

-- return {name = name, amount = amount::float}
function data_util.collapse_product(product)
  if product[1] and type(product[1]) == "string" then
    if product[2] then
      return {name = product[1], amount = product[2]}
    else
      return {name = product[1], amount = 1}
    end
  end
  if product.name then
    local collapsed = {name = product.name, amount = product.amount, type = product.type}
    if product.amount_min and product.amount_max then
      collapsed.amount = (product.amount_min + product.amount_max) / 2 * (product.probability or 1)
    end
    return collapsed
  end
end

-- return {name = name, amount = amount::float}
function data_util.collapse_products(products)
  local combined = {}
  for _, product in pairs(products) do
    local collapsed = data_util.collapse_product(product)
    if collapsed then
      if combined[collapsed.name] then
        combined[collapsed.name].amount = combined[collapsed.name].amount + collapsed.amount
      else
        combined[collapsed.name] = collapsed
      end
    end
  end
  return combined
end

function data_util.result_to_results(recipe_section)
  -- transform result style definition to full results definition for a given prototype section
  -- recipe_section is either the recipe prrototype, recipe.normal, or recipe.difficult
  if not recipe_section.result then return end
  local result_count = recipe_section.result_count or 1
  if type(recipe_section.result) == "string" then
    recipe_section.results = {{type="item", name= recipe_section.result, amount = result_count}}
  elseif recipe_section.result.name then
    recipe_section.results = {recipe_section.result}
  elseif recipe_section.result[1] then
    result_count = recipe_section.result[2] or result_count
    recipe_section.results = {{type="item", name= recipe_section.result[1], amount = result_count}}
  end
  recipe_section.result = nil
end


function data_util.get_ingredients_tables(recipe)
  local tables = {}
  if recipe.ingredients then table.insert(tables, recipe.ingredients) end
  if recipe.normal and recipe.normal.ingredients then table.insert(tables, recipe.normal.ingredients) end
  if recipe.expensive and recipe.expensive.ingredients then table.insert(tables, recipe.expensive.ingredients) end
  return tables
end

function data_util.conditional_modify(prototype)
  -- pass in a partial prototype that includes .type and .name
  -- overwrite sections of the raw prototype with the new one
  if data.raw[prototype.type] and data.raw[prototype.type][prototype.name] then
    local raw = data.raw[prototype.type][prototype.name]

    -- update to new spec
    if not raw.normal then
      raw.normal = {
        enabled = raw.enabled,
        energy_required = raw.energy_required,
        requester_paste_multiplier = raw.requester_paste_multiplier,
        hidden = raw.hidden,
        ingredients = raw.ingredients,
        results = raw.results,
        result = raw.result,
        result_count = raw.result_count,
      }
      raw.enabled = nil
      raw.energy_required = nil
      raw.requester_paste_multiplier = nil
      raw.hidden = nil
      raw.ingredients = nil
      raw.results = nil
      raw.result = nil
      raw.result_count = nil
    end
    if not raw.expensive then
      raw.expensive = table.deepcopy(raw.normal)
    end
    if not raw.normal.results and raw.normal.result then
        data_util.result_to_results(raw.normal)
    end
    if not raw.expensive.results and raw.expensive.result then
        data_util.result_to_results(raw.expensive)
    end

    for key, property in pairs(prototype) do
      if key == "ingredients" then
        raw.normal.ingredients = property
        raw.expensive.ingredients = property
      elseif key ~= "normal" and key ~= "expensive" then
        raw[key] = property
      end
    end

    if prototype.normal then
      for key, property in pairs(prototype.normal) do
          raw.normal[key] = property
      end
    end

    if prototype.expensive then
      for key, property in pairs(prototype.expensive) do
          raw.expensive[key] = property
      end
    end

  end
end

function data_util.disable_recipe(recipe_name)
  data_util.conditional_modify({
    type = "recipe",
    name = recipe_name,
    enabled = false,
    normal = {
      enabled = false
    },
    expensive = {
      enabled = false
    }
  })
end

function data_util.remove_recipe_from_effects(effects, recipe)
    local index = 0
    for _,_item in ipairs(effects) do
        if _item.type == "unlock-recipe" and _item.recipe == recipe then
            index = _
            break
        end
    end
    if index > 0 then
        table.remove(effects, index)
    end
end

function data_util.remove_ingredient_sub(recipe, name)
  for i = #recipe.ingredients, 1, -1 do
    if recipe.ingredients[i] then
      for _, value in pairs(recipe.ingredients[i]) do
        if value == name then
          table.remove(recipe.ingredients, i)
        end
      end
    end
  end
end

function data_util.add_ingredient_sub(recipe, name, amount)
  local found = false
  for i = #recipe.ingredients, 1, -1 do
    if recipe.ingredients[i] then
      for _, value in pairs(recipe.ingredients[i]) do
        if value == name then
          found = true
          recipe.ingredients[i] = {type="item", name=name, amount=amount}
          break
        end
      end
    end
  end
  if not found then
    table.insert(recipe.ingredients, {type="item", name=name, amount=amount})
  end
end

function data_util.replace_or_add_ingredient_sub(recipe, old, new, amount)
  -- old can be nil to just add
  if old then
    data_util.remove_ingredient_sub(recipe, old)
  end
  data_util.add_ingredient_sub(recipe, new, amount)
--[[
  local found = false
  if old then
    for i, component in pairs(recipe.ingredients) do
      for _, value in pairs(component) do
        if value == old then
          found = true
          recipe.ingredients[i] = {type="item", name=new, amount=amount}
          break
        end
      end
    end
  end
  if not found then
    table.insert(recipe.ingredients, {type="item", name=new, amount=amount})
  end
  ]]--
end

function data_util.replace_or_add_ingredient(recipe, old, new, amount)
  if type(recipe) == "string" then recipe = data.raw.recipe[recipe] end
  if not recipe then return end
  if recipe.ingredients then
    data_util.replace_or_add_ingredient_sub(recipe, old, new, amount)
  end
  if recipe.normal and recipe.normal.ingredients then
    data_util.replace_or_add_ingredient_sub(recipe.normal, old, new, amount)
  end
  if recipe.expensive and recipe.expensive.ingredients then
    data_util.replace_or_add_ingredient_sub(recipe.expensive, old, new, amount)
  end
end

function data_util.recipe_require_tech(recipe_name, tech_name)
  if data.raw.recipe[recipe_name] and data.raw.technology[tech_name] then
    data_util.disable_recipe(recipe_name)
    for _, tech in pairs(data.raw.technology) do
        if tech.effects then
            data_util.remove_recipe_from_effects(tech.effects, recipe_name)
        end
    end
    local already = false
    data.raw.technology[tech_name].effects = data.raw.technology[tech_name].effects or {}
    for _, effect in pairs(data.raw.technology[tech_name].effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
        already = true
        break
      end
    end
    if not already then
      table.insert(data.raw.technology[tech_name].effects, { type = "unlock-recipe", recipe = recipe_name})
    end
  end
end

function data_util.tech_split_at_level(tech_name, level)
  -- skip if it exists
  if data.raw.technology[tech_name.."-"..level] then return end
  local last_tech
  for i = 1, level - 1 do
    if data.raw.technology[tech_name.."-"..i] then
      last_tech = data.raw.technology[tech_name.."-"..i]
    end
  end
  if last_tech then
    local new_tech = table.deepcopy(last_tech)
    last_tech.max_level = level - 1
    new_tech.name = tech_name.."-"..level
    new_tech.prerequisites = {last_tech.name}
    data:extend({new_tech})
  end
end

function data_util.tech_split_at_levels(tech_name, levels)
  for _, level in pairs(levels) do
    data_util.tech_split_at_level(tech_name, level)
  end
end

function data_util.tech_split_levels(tech_name, max_split_level)
  if not max_split_level then max_split_level = 9 end
  local max_level = 1
  local prev_tech_template
  local prev_tech_name

  local last_i = 0
  for i = 1, max_split_level do
    -- prep prerequisites
    local prerequisites = {}
    local tech_template

    -- load best template
    if data.raw.technology[tech_name.."-"..i] then
      tech_template = data.raw.technology[tech_name.."-"..i]
      if tech_template.prerequisites then
        prerequisites = tech_template.prerequisites
      end
      tech_template.prerequisites = nil
    end
    if not tech_template then
      if prev_tech_template and (max_level == "infinite" or i <= max_level) then
        tech_template = prev_tech_template
      end
    end

    if not tech_template then return end
    prev_tech_template = tech_template
    last_i = i

    -- link the chain
    if prev_tech_name and not data_util.table_contains(prerequisites, prev_tech_name)then
      table.insert(prerequisites, prev_tech_name)
    end

    -- establish maximum
    if max_level ~= "infinite" then
      if tech_template.max_level then
        if tech_template.max_level == "infinite" then
          max_level = "infinite"
        elseif tech_template.max_level > max_level then
          max_level = tech_template.max_level
        end
      end
    end

    local new_tech = table.deepcopy(tech_template)
    new_tech.name = tech_name.."-"..i
    new_tech.prerequisites = prerequisites
    new_tech.max_level = nil
    data:extend({new_tech})

    prev_tech_name = new_tech.name

  end
  if max_level == "infinite" then
    data.raw.technology[tech_name.."-"..last_i].max_level = max_level
  else
    data.raw.technology[tech_name.."-"..last_i].max_level = math.max(last_i, max_level)
  end

end

function data_util.tech_lock_recipes(tech_name, recipe_names)
  if not data.raw.technology[tech_name] then return end
  if type(recipe_names) == "string" then recipe_names = {recipe_names} end
  for _, recipe_name in pairs(recipe_names) do
    if data.raw.recipe[recipe_name] then
      data_util.recipe_require_tech(recipe_name, tech_name)
    end
  end
end

function data_util.tech_find_parent_names_cascade(names, prototype_name, cascade)
  if not data.raw.technology[prototype_name] and data.raw.technology[prototype_name].prerequisites then return end
  if data.raw.technology[prototype_name].prerequisites then
    for _, prerequisite in pairs(data.raw.technology[prototype_name].prerequisites) do
      if not names[prerequisite] then
        names[prerequisite] = prerequisite
        if cascade then
          data_util.tech_find_parent_names_cascade(names, prerequisite, cascade)
        end
      end
    end
  end
  return names
end

function data_util.tech_find_parent_names(prototype_name, cascade)
  return data_util.tech_find_parent_names_cascade({}, prototype_name, cascade)
end

function data_util.tech_find_child_names(prototype_name)
  local names = {}
  for _, tech in pairs(data.raw.technology) do
    if tech.prerequisites then
      for _, prerequisite in pairs(tech.prerequisites) do
        if prerequisite == prototype_name then
          table.insert(names, tech.name)
        end
      end
    end
  end
  return names
end

function data_util.tech_add_prerequisites(prototype_name, prerequisites)
  local prototype = data.raw.technology[prototype_name]
  if not prototype then return end
  for _, new_prerequisite in pairs(prerequisites) do
    local found = false
    if prototype.prerequisites then
      for _, old_prerequisite in pairs(prototype.prerequisites) do
        if old_prerequisite == new_prerequisite then
          found = true break
        end
      end
    end
    if not found then
      prototype.prerequisites = prototype.prerequisites or {}
      table.insert(prototype.prerequisites, new_prerequisite)
    end
  end
end

function data_util.tech_remove_prerequisites (prototype_name, prerequisites)
  local prototype = data.raw.technology[prototype_name]
  if not prototype then return end
  for _, new_prerequisite in pairs(prerequisites) do
    if prototype.prerequisites then
      for i = #prototype.prerequisites, 1, -1 do
        if prototype.prerequisites[i] == new_prerequisite then
          table.remove(prototype.prerequisites, i)
        end
      end
    end
  end
end
--[[
function util.tech_remove_prerequisites (prototype_name, prerequisites)
  local prototype = data.raw.technology[prototype_name]
  if not prototype then return end
  for _, new_prerequisite in pairs(prerequisites) do
    for _, old_prerequisite in pairs(prototype.prerequisites) do
      if old_prerequisite == new_prerequisite then
        prototype.prerequisites[_] = nil
      end
    end
  end
end]]--

function data_util.tech_has_ingredient (prototype_name, pack)
  local prototype = data.raw.technology[prototype_name]
  if prototype then
    for _, ingredient in pairs(prototype.unit.ingredients) do
      if ingredient[1] == pack then
        return true
      end
    end
  end
  return false
end

function data_util.tech_remove_ingredients_recursive (prototype_name, packs)
  local names = data_util.tech_find_parent_names(prototype_name, true)
  table.insert(names, prototype_name)

  for _, name in pairs(names) do
    local prototype = data.raw.technology[name]
    if prototype then
      for _, pack in pairs(packs) do
        for i = #prototype.unit.ingredients, 1, -1 do
          if prototype.unit.ingredients[i] and prototype.unit.ingredients[i][1] == pack then
            table.remove(prototype.unit.ingredients, i)
          end
        end
      end
    end
  end
end

function data_util.tech_remove_effects(prototype_name, effects)
  --log("tech_remove_effects")
  local prototype = data.raw.technology[prototype_name]
  if not data.raw.technology[prototype_name] then return end
  for _, new_effect in pairs(effects) do
    --log("new effect: " .. new_effect.type .. " " .. new_effect.recipe)
    for _, old_effect in pairs(prototype.effects) do
      --log("old effect: " .. old_effect.type .. " " .. old_effect.recipe)
      local match = true
      for new_key, new_var in pairs(new_effect) do
        if old_effect[new_key] ~= new_var then
          --log("compare fails")
          match = false break
        end
      end
      if match then
      --  log("compare pass")
        prototype.effects[_] = nil
      end
    end
  end
end

-- cascade applies to children too
function data_util.tech_add_ingredients(prototype_name, ingredients, cascade)
  --log("tech_add_ingredients: " .. prototype_name)
  local prototype = data.raw.technology[prototype_name]
  if not prototype then return end
  local added = false
  for _, new_ingredient in pairs(ingredients) do
    local found = false
    for _, old_ingredient in pairs(prototype.unit.ingredients) do
      if old_ingredient[1] == new_ingredient then
        found = true break
      end
    end
    if not found then
      table.insert(prototype.unit.ingredients, {new_ingredient, 1})
      added = true
    end
  end
  if added and cascade then
    local child_techs = data_util.tech_find_child_names(prototype_name)
    for _, tech in pairs(child_techs) do
      data_util.tech_add_ingredients(tech, ingredients, cascade)
    end
  end
end

-- cascade applies to children too
function data_util.tech_add_ingredients_with_prerequisites (prototype_name, ingredients)
  -- assumes that ingredient and tech are same name
  --log("tech_add_ingredients: " .. prototype_name)
  local prototype = data.raw.technology[prototype_name]
  if not prototype then return end
  for _, ingredient in pairs(ingredients) do
    if not data_util.tech_has_ingredient(prototype_name, ingredient) then
      data_util.tech_add_prerequisites(prototype_name, {ingredient})
      data_util.tech_add_ingredients(prototype_name, {ingredient}, true)
    end
  end
end

function data_util.disallow_productivity(recipe_name)
  for _, prototype in pairs(data.raw["module"]) do
    if prototype.limitation and string.find(prototype.name, "productivity", 1, true) then
      for i = #prototype.limitation, 1, -1 do
        if prototype.limitation[i] == recipe_name then
          table.remove(prototype.limitation, i)
        end
      end
    end
  end
end

function data_util.allow_productivity(recipe_name)
  if data.raw.recipe[recipe_name] then
    for _, prototype in pairs(data.raw["module"]) do
      if prototype.limitation and string.find(prototype.name, "productivity", 1, true) then
        table.insert(prototype.limitation, recipe_name)
      end
    end
  end
end

function data_util.replace_filenames_recursive(subject, what, with)
  if not subject then return end
  if subject.filename then
    subject.filename = data_util.replace(subject.filename, what, with)
  end
  for _, sub in pairs(subject) do
    if (type(sub) == "table") then
      data_util.replace_filenames_recursive(sub, what, with)
    end
  end
end


function data_util.make_recipe(proto)
  --name is prefixed with data_util.mod_prefix
  --energy required deafults to 10
  local name = proto.name
  if proto.is_data then name = name .. "-data" end
  local def = {
    type = "recipe",
    name = name,
    category = proto.category or nil,
    enabled = proto.enabled == true,
    energy_required = proto.energy_required or 10,
    ingredients = proto.ingredients,
    results = proto.results or { { name = name, amount = 1 } },
    icon = proto.icon or nil,
    icons = proto.icons or nil,
    icon_size = proto.icon_size or 32,
    crafting_machine_tint = proto.crafting_machine_tint or nil,
    main_product = proto.main_product or nil,
    allow_as_intermediate = proto.allow_as_intermediate,
    subgroup = proto.subgroup or nil,
    order = proto.order or nil,
    localised_name = proto.localised_name,
    always_show_products = true,
    always_show_made_in = true,
  }

  if (not def.main_product) and #def.results == 1 then
    local p_name = def.results[1].name or def.results[1][1]
    local p_type = def.results[1].type or "item"
    local prod = data.raw[p_type][p_name]
    if p_type == "item" and not prod then
      p_type = "capsule"
      prod = data.raw[p_type][p_name]
    end
    if prod then
      def.main_product = prod.name
    end
  end
  if not (def.icon or def.icons) then
    local p_name = def.results[1].name or def.results[1][1]
    local p_type = def.results[1].type or "item"
    local prod = data.raw[p_type][p_name]
    if p_type == "item" and not prod then
      p_type = "capsule"
      prod = data.raw[p_type][p_name]
    end
    if prod then
      --log("recipe " .. name .. " icon " .. p_type .. "." .. p_name)
      if prod.icon then
        def.icon = prod.icon
        def.icon_size = prod.icon_size
      elseif prod.icons then
        def.icons = prod.icons
      else
        --log("recipe " .. name .. " error: items has no icon(s)")
      end
    elseif p_type and p_name then
      --log("recipe " .. name .. " can't find: " .. p_type .. "." .. p_name)
    else
      --log("recipe " .. name .. " error")
    end
  end
  data:extend({def})
end

function data_util.transition_icons(icon_from, icon_to)
  if type(icon_to) == "string" then
    return {
      { icon = "__space-exploration-graphics__/graphics/blank.png", scale = 1, shift = {0, 0}, icon_size = 32 }, -- to lock scale
      { icon = icon_from, scale = 0.66, shift = {8, -8}, icon_size = 32 },
      { icon = icon_to, scale = 0.66, shift = {-8, 8}, icon_size = 32 },
      { icon = "__space-exploration-graphics__/graphics/icons/transition-arrow.png", scale = 1, shift = {0, 0}, icon_size = 32 }, -- to overlay
    }
  else
    local icons = {
      { icon = "__space-exploration-graphics__/graphics/blank.png", scale = 1, shift = {0, 0}, icon_size = 32 }, -- to lock scale
      { icon = icon_from, scale = 0.66, shift = {8, -8}, icon_size = 32 },
    }
    for _, icon in pairs(icon_to) do
      table.insert(icons, { icon = icon, scale = 0.5, shift = {-12 + (_-1) * 8, 12}, icon_size = 32 })
    end
    table.insert(icons, { icon = "__space-exploration-graphics__/graphics/icons/transition-arrow.png", scale = 1, shift = {0, 0}, icon_size = 32 })
    return icons
  end
end

return data_util
