local data_util = {}
data_util.str_gsub = string.gsub

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

function data_util.string_to_number(str)
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

function data_util.replace(str, what, with)
    what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = string.gsub(with, "[%%]", "%%%%") -- escape replacement
    return string.gsub(str, what, with)
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

function data_util.result_to_results (recipe_section)
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

function data_util.conditional_modify (prototype)
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
        raw.normal.ingredients = table.deepcopy(property)
        raw.expensive.ingredients = table.deepcopy(property)
      elseif key == "results" then
        raw.normal.results = table.deepcopy(property)
        raw.expensive.results = table.deepcopy(property)
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

function data_util.replace_or_add_ingredient_sub (recipe, old, new, amount, is_fluid)
  -- old can be nil to just add
  local found = false
  if old then
    for i, component in pairs(recipe.ingredients) do
      for _, value in pairs(component) do
        if value == old then
          found = true
          recipe.ingredients[i] = {type=is_fluid and "fluid" or "item", name=new, amount=amount}
          break
        end
      end
    end
  end
  if not found then
    table.insert(recipe.ingredients, {type=is_fluid and "fluid" or "item", name=new, amount=amount})
  end
end

function data_util.replace_or_add_ingredient (recipe, old, new, amount, is_fluid)
  if type(recipe) == "string" then recipe = data.raw.recipe[recipe] end
  if not recipe then return end
  if recipe.ingredients then
    data_util.replace_or_add_ingredient_sub(recipe, old, new, amount, is_fluid)
  end
  if recipe.normal and recipe.normal.ingredients then
    data_util.replace_or_add_ingredient_sub(recipe.normal, old, new, amount, is_fluid)
  end
  if recipe.expensive and recipe.expensive.ingredients then
    data_util.replace_or_add_ingredient_sub(recipe.expensive, old, new, amount, is_fluid)
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

function data_util.tech_lock_recipes(tech_name, recipe_names)
  if not data.raw.technology[tech_name] then
    return
  end
  if type(recipe_names) == "string" then recipe_names = {recipe_names} end
  for _, recipe_name in pairs(recipe_names) do
    if data.raw.recipe[recipe_name] then
      data_util.recipe_require_tech(recipe_name, tech_name)
    end
  end
end

function data_util.tech_add_prerequisites(tech_name, require_names)
  if not data.raw.technology[tech_name] then return end
  if type(require_names) == "string" then require_names = {require_names} end
  for _, require_name in pairs(require_names) do
    if data.raw.technology[require_name] then
      data.raw.technology[tech_name].prerequisites = data.raw.technology[tech_name].prerequisites or {}
      local already = false
      for _, prerequisite in pairs(data.raw.technology[tech_name].prerequisites) do
        if prerequisite == require_name then
          already = true
          break
        end
      end
      if not already then
        table.insert(data.raw.technology[tech_name].prerequisites, require_name)
      end
    end
  end
end

function data_util.tech_remove_prerequisites (prototype_name, prerequisites)
  local prototype = data.raw.technology[prototype_name]
  if not prototype then return end
  for _, new_prerequisite in pairs(prerequisites) do
    for i = #prototype.prerequisites, 1, -1 do
      if prototype.prerequisites[i] == new_prerequisite then
        table.remove(prototype.prerequisites, i)
      end
    end
  end
end

function data_util.techs_add_ingredients(prototype_names, ingredients, cascade)
  for _, prototype_name in pairs(prototype_names) do
    data_util.tech_add_ingredients (prototype_name, ingredients, cascade)
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

function data_util.tech_remove_ingredients (prototype_name, packs)
  local prototype = data.raw.technology[prototype_name]
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

function data_util.allow_productivity(recipe_name)
  if data.raw.recipe[recipe_name] then
    for _, prototype in pairs(data.raw["module"]) do
      if prototype.limitation and string.find(prototype.name, "productivity", 1, true) then
        table.insert(prototype.limitation, recipe_name)
      end
    end
  end
end

function data_util.replace(str, what, with)
    what = data_util.str_gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = data_util.str_gsub(with, "[%%]", "%%%%") -- escape replacement
    return data_util.str_gsub(str, what, with)
end


function data_util.replace_filenames_recursive(subject, what, with)
  if subject.filename then
    subject.filename = data_util.replace(subject.filename, what, with)
  end
  for _, sub in pairs(subject) do
    if (type(sub) == "table") then
      data_util.replace_filenames_recursive(sub, what, with)
    end
  end
end

function data_util.auto_sr_hr(hr_version)
  local sr_version = table.deepcopy(hr_version)
  if not hr_version.scale then
    hr_version.scale = 0.5
  end
  if not hr_version.priority then
    hr_version.priority = "extra-high"
  end
  sr_version.scale = (hr_version.scale or 0.5) * 2
  sr_version.width = math.floor(hr_version.width/2)
  sr_version.height = math.floor(hr_version.height/2)
  if hr_version.x then
    sr_version.x = math.floor(hr_version.x/2)
  end
  if hr_version.y then
    sr_version.y = math.floor(hr_version.y/2)
  end
  sr_version.filename = data_util.replace(sr_version.filename, "/hr/", "/sr/")
  sr_version.filename = data_util.replace(sr_version.filename, "/hr-", "/")
  sr_version.hr_version = hr_version
  return sr_version
end


function data_util.tint_recursive(subject, tint)
  if not subject then return end
  if subject.filename then
    subject.tint = tint
  end
  for _, sub in pairs(subject) do
    if (type(sub) == "table") then
      data_util.tint_recursive(sub, tint)
    end
  end
end

function data_util.add_fuel_category(burner, category)
  burner.fuel_categories = burner.fuel_categories or {}
  if burner.fuel_category then
    table.insert(burner.fuel_categories, burner.fuel_category)
    burner.fuel_category = nil
  end
  if not data_util.table_contains(burner.fuel_categories, category) then
    table.insert(burner.fuel_categories, category)
  end
end

function data_util.recipe_set_result_count(recipe_name, count)
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    recipe.result_count = count
    if recipe.results and recipe.results[1] then recipe.results[1].amount = count end
    if recipe.normal then
      recipe.normal.result_count = count
      if recipe.normal.results and recipe.normal.results[1] then recipe.normal.results[1].amount = count end
    end
    if recipe.expensive then
      recipe.expensive.result_count = count
      if recipe.expensive.results and recipe.expensive.results[1] then recipe.expensive.results[1].amount = count end
    end
  end
end

function data_util.recipe_set_time(recipe_name, time)
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    if recipe.energy_required then recipe.energy_required = time end
    if recipe.normal and recipe.normal.energy_required then recipe.normal.energy_required = time end
    if recipe.expensive and recipe.expensive.energy_required then recipe.expensive.energy_required = time end
  end
end

function data_util.recipe_multiply_time(recipe_name, multiplier)
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    if recipe.energy_required then recipe.energy_required = recipe.energy_required * multiplier end
    if recipe.normal and recipe.normal.energy_required then recipe.normal.energy_required = recipe.normal.energy_required * multiplier end
    if recipe.expensive and recipe.expensive.energy_required then recipe.expensive.energy_required = recipe.expensive.energy_required * multiplier end
  end
end

return data_util
