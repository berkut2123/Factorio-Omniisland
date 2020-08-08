local werkzeug = {}

--- Fügt das angegebene Wissenschaftspaket (sciencep) zur Technologie (tech) hinzu. 
--- Optional kann eine Anzahl (count) angegeben werden.
--- @param tech string
--- @param sciencep string
--- @param count integer
function werkzeug.add_science_pack(tech, sciencep, count)
    if data.raw.technology[tech] then
        local tech_already_changed = false
        for k,i in pairs(data.raw.technology[tech]["unit"].ingredients) do
            if i[1] == sciencep then
                tech_already_changed = true
            end
        end
        if not tech_already_changed then
            if count == nil then count = 1 end
            table.insert(data.raw.technology[tech]["unit"].ingredients, {sciencep, count})
        end
    end
end

--- Entfernt das angegebene Wissenschaftspaket (sciencep) aus der Technologie (tech)
--- @param tech string
--- @param sciencep string
function werkzeug.remove_science_pack(tech, sciencep)
    if data.raw.technology[tech] then
    local tech_already_changed = true
        for k,i in pairs(data.raw.technology[tech]["unit"].ingredients) do
            if i[1] == sciencep then
                tech_already_changed = false
            end
        end
        if not tech_already_changed then
            local index = 0
            for i=1, #data.raw.technology[tech]["unit"].ingredients, 1 do
                if (data.raw.technology[tech]["unit"].ingredients[i][1] == sciencep) then
                    index = i
                end
            end
            if index > 0 then
                table.remove(data.raw.technology[tech]["unit"].ingredients, index)                
            end
        end
    end
end

--- Fügt das übergebene Rezept (recipe) zur gegebenen Technologie (tech) hinzu
--- @param recipe string
--- @param tech string
function werkzeug.add_recipe_to_tech(recipe, tech)
    if data.raw.technology[tech] then
    local tech_already_changed = false
        if data.raw.technology[tech]["effects"] == nil then
            data.raw.technology[tech]["effects"] = {}
        end
        for k,e in pairs(data.raw.technology[tech]["effects"]) do
            if e.recipe == recipe then
                tech_already_changed = true
            end
        end
        if not tech_already_changed then
            table.insert(data.raw.technology[tech].effects, {type = "unlock-recipe", recipe = recipe})
        end
    end
end

--- Entfernt das übergebene Rezept (recipe)  aus der angegeben Technologie (tech)
--- @param recipe string
--- @param tech string
function werkzeug.remove_recipe_from_tech(recipe, tech)
    if data.raw.technology[tech] then
    local tech_already_changed = true
        for k,e in pairs(data.raw.technology[tech]["effects"]) do
            if e.recipe == recipe then
                tech_already_changed = false
            end
        end
        if not tech_already_changed then
            local index = 0
            for i=1, #data.raw.technology[tech]["effects"], 1 do
                -- get the index ...
                if (data.raw.technology[tech].effects[i].recipe == recipe) then
                    index = i
                end
            end
            if index > 0 then
                -- ... and remove the effect from the right position in the list of effects      
                table.remove(data.raw.technology[tech].effects, index)                
            end
            if data.raw.technology[tech].effects == nil then
                data.raw.technology[tech].effects = {}
            end
        end
    end
end

--- Fügt die übergebene Technologievoraussetzung (new_req) dynamisch zu der übergebenen Technologie (tech) hinzu
--- @param new_req string
--- @param tech string
function werkzeug.add_tech_requirement(new_req, tech)
    if data.raw.technology[tech] then
    local tech_already_changed = false
		if data.raw.technology[tech]["prerequisites"] ~= nil then
			for k,e in pairs(data.raw.technology[tech]["prerequisites"]) do
				if e == new_req then
					tech_already_changed = true
				end
			end
		else
			data.raw.technology[tech]["prerequisites"] = {}
		end
		if not tech_already_changed then			
			table.insert(data.raw.technology[tech].prerequisites, new_req)
		end
    end
end

--- Entfernt die übergebene Technologievoraussetzung (remove_req) aus der Technologie (tech)
--- @param remove_req string
--- @param tech string
function werkzeug.remove_tech_requirement(remove_req, tech)
    if data.raw.technology[tech] then
    local tech_already_changed = true
        for k,e in pairs(data.raw.technology[tech]["prerequisites"]) do
            if e == remove_req then
                tech_already_changed = false
            end
        end
        if not tech_already_changed then
            local index = 0
            for i=1, #data.raw.technology[tech]["prerequisites"], 1 do
                -- get the index ...
                if (data.raw.technology[tech].prerequisites[i] == remove_req) then
                    index = i
                end
            end
            if index > 0 then
                -- ... and remove the effect from the right position in the list of effects      
                table.remove(data.raw.technology[tech].prerequisites, index)                
            end
        end
    end
end

--- Fügt den übergebenen Effekt (etype) und seinen Wert (edata) zu den Effekten der Technologie (tech) hinzu
--- @param tech string
--- @param etype string
--- @param edata any
function werkzeug.add_science_effect(tech, etype, edata)
    if data.raw.technology[tech] then
        local tech_already_changed = false
        for k,e in pairs(data.raw.technology[tech]["effects"]) do
            if e["type"] ~= nil and e["type"] == etype then
                if etype == "unlock-recipe" and e["recipe"] ~= nil and e["recipe"] == edata then
                    tech_already_changed = true
                end
            end
        end
        if not tech_already_changed then
            if etype == "unlock-recipe" then
                table.insert(data.raw.technology[tech].effects, {type = etype, recipe = edata})
            end
        end
    end
end


--- @param recipe string
--- @param difficulty string
local function get_ingredients(recipe, difficulty)
    if data.raw.recipe[recipe] then
        local ingredient_data = {}
        if difficulty ~= nil then
            ingredient_data = {data.raw.recipe[recipe][difficulty].ingredients}
        elseif data.raw.recipe[recipe].ingredients ~= nil then
            ingredient_data = {data.raw.recipe[recipe].ingredients}
        else
            if data.raw.recipe[recipe].normal then
                ingredient_data[#ingredient_data+1] = data.raw.recipe[recipe].normal.ingredients
            end
            if data.raw.recipe[recipe].expensive then
                ingredient_data[#ingredient_data+1] = data.raw.recipe[recipe].expensive.ingredients
            end
        end
        return ingredient_data
    end
end

--- Löscht alle Zutaten aus dem angegebenen Rezept (recipe).
--- Optional: Schwierigkeitsstufe (difficulty)
--- @param recipe string
--- @param difficulty string
function werkzeug.clear_recipe_ingredients(recipe, difficulty)
    if data.raw.recipe[recipe] then
        local ingredient_data
        if difficulty ~= nil then
            ingredient_data = get_ingredients(recipe, difficulty)
        else
            ingredient_data = get_ingredients(recipe)
        end
        for _,idata in pairs(ingredient_data) do
            for k,i in pairs(idata) do
                idata[k] = nil -- delete the ingredients
            end
        end
    end
end

--- Fügt dem angegebenen Rezept (recipe) einen Gegenstand (newIngredient) als neue Zutat hinzu.
--- Form: {"<item>", <amount>} oder {type = "<itemtype>", name = "<item>", amount = <amount>}.
--- Optional: Schwierigkeitsstufe (difficulty)
--- @param recipe string
--- @param newIngredient table
--- @param difficulty string
function werkzeug.add_recipe_ingredient(recipe, newIngredient, difficulty)
    if data.raw.recipe[recipe] then
        local newIngredientName = newIngredient.name or newIngredient[1]
        local ingredient_data
        if difficulty ~= nil then
            ingredient_data = get_ingredients(recipe, difficulty)
        else
            ingredient_data = get_ingredients(recipe)
        end
        for _,idata in pairs(ingredient_data) do
            local duplicateFound = false -- search for duplicates, sometimes both difficulties refer to the same table
            for _,i in pairs(idata) do
                if i.name ~= nil and i.name == newIngredientName then
                    duplicateFound = true
                elseif i[1] ~= nil and i[1] == newIngredientName then
                    duplicateFound = true
                end
            end
            if not duplicateFound then
                table.insert(idata, newIngredient)
            end
        end
    end
end

--- Entfernt eine Zutat (removeIngredient) aus dem angegebenen Rezept (recipe).
--- Optional: Schwierigkeitsstufe (difficulty)
--- @param recipe string
--- @param removeIngredient string
--- @param difficulty string
function werkzeug.remove_recipe_ingredient(recipe, removeIngredient, difficulty)
    if data.raw.recipe[recipe] then
        local ingredient_removed = false
        local ingredient_data
        if difficulty ~= nil then
            ingredient_data = get_ingredients(recipe, difficulty)
        else
            ingredient_data = get_ingredients(recipe)
        end
        for _,idata in pairs(ingredient_data) do
            for k,i in pairs(idata) do
                if (i.name ~= nil and i.name == removeIngredient) or (i[1] ~= nil and i[1] == removeIngredient) then
                    idata[k] = nil -- delete the ingredient
                    ingredient_removed = true
                end
            end
        end
    end
end

--- Ersetzt im angegebenen Rezept (recipe) eine Zutat (oldIngredient) durch eine andere (newIngredient). Alle anderen Eigenschaften werden beibehalten.
--- Optional: Schwierigkeitsstufe (difficulty)
--- @param recipe string
--- @param oldIngredient string
--- @param newIngredient string
--- @param difficulty string
function werkzeug.replace_recipe_ingredient(recipe, oldIngredient, newIngredient, difficulty)
    if data.raw.recipe[recipe] then
        local ingredient_data
        if difficulty ~= nil then
            ingredient_data = get_ingredients(recipe, difficulty)
        else
            ingredient_data = get_ingredients(recipe)
        end
        for _,idata in pairs(ingredient_data) do
            for k,i in pairs(idata) do
                if i.name ~= nil and i.name == oldIngredient then
                    idata[k].name = newIngredient -- replace the ingredient
                elseif i[1] ~= nil and i[1] == oldIngredient then
                    idata[k][1] = newIngredient -- replace the ingredient
                end
            end
        end
    end
end

--- @param recipe string
--- @param difficulty string
local function get_results(recipe, difficulty)
    if data.raw.recipe[recipe] then
        local result_data = {}
        local recipe_data = {}
        if difficulty ~= nil then
            recipe_data = {data.raw.recipe[recipe][difficulty]}
        elseif data.raw.recipe[recipe].result ~= nil or data.raw.recipe[recipe].results ~= nil then
            recipe_data = {data.raw.recipe[recipe]}
        else
            if data.raw.recipe[recipe].normal then
                recipe_data[#recipe_data+1] = data.raw.recipe[recipe].normal
            end
            if data.raw.recipe[recipe].expensive then
                recipe_data[#recipe_data+1] = data.raw.recipe[recipe].expensive
            end
        end
        for _, r in pairs (recipe_data) do
            result_data[#result_data+1] = {}
            if r.result then
                result_data[#result_data].result = r.result
                result_data[#result_data].result_count = r.result_count or 1
            elseif r.results then
                result_data[#result_data] = r
            end
        end
        return result_data
    end
end

--- Löscht alle Produkte aus dem angegebenen Rezept (recipe).
--- Optional: Schwierigkeitsstufe (difficulty)
--- @param recipe string
--- @param difficulty string
function werkzeug.clear_recipe_results(recipe, difficulty)
    if data.raw.recipe[recipe] then
        local result_data
        if difficulty ~= nil then
            result_data = get_results(recipe, difficulty)
        else
            result_data = get_results(recipe)
        end
        for _,rdata in pairs(result_data) do
            if rdata.result ~= nil then
                rdata.result = nil
                rdata.result_count = nil
                --data.raw.recipe[recipe].result = nil
                --data.raw.recipe[recipe].result_count = nil
            else
                for k,_ in pairs(rdata.results) do
                    rdata.results[k] = nil -- delete the result
                end
            end
        end
    end
end

--- Entfernt ein Produkt (removeResult) aus dem angegebenen Rezept (recipe).
--- Optional: Schwierigkeitsstufe (difficulty)
--- @param recipe string
--- @param removeResult string
--- @param difficulty string
function werkzeug.remove_recipe_result(recipe, removeResult, difficulty)
    if data.raw.recipe[recipe] then
        local result_removed = false
        local result_data
        if difficulty ~= nil then
            result_data = get_results(recipe, difficulty)
        else
            result_data = get_results(recipe)
        end
        for _,rdata in pairs(result_data) do
            if rdata.result ~= nil and rdata.result == removeResult then
                rdata.result = nil
                rdata.result_count = nil
                --data.raw.recipe[recipe].result = nil
                --data.raw.recipe[recipe].result_count = nil
            else
                for k,r in pairs(rdata.results) do
                    if (r.name ~= nil and r.name == removeResult) or (r[1] ~= nil and r[1] == removeResult) then
                        rdata.results[k] = nil -- delete the result
                        result_removed = true
                    end
                end
            end
        end
    end
end

--- Fügt dem angegebenen Rezept (recipe) einen Gegenstand (newResult) als weiteres Produkt hinzu.
--- Form: {"<item>", <amount>} oder {type = "<itemtype>", name = "<item>", amount = <amount>[, ...]}.
--- Optional: Schwierigkeitsstufe (difficulty)
--- @param recipe string
--- @param newResult table
--- @param difficulty string
function werkzeug.add_recipe_result(recipe, newResult, difficulty)
    if data.raw.recipe[recipe] then
        local result_data
        local newResultName = newResult.name or newResult[1]
        if difficulty ~= nil then
            result_data = get_results(recipe, difficulty)
        else
            result_data = get_results(recipe)
        end
        for _,rdata in pairs(result_data) do
            if rdata == nil then rdata = {} end
            if rdata.result ~= nil then
                local prev_result = rdata.result
                local prev_result_count = rdata.result_count
                rdata.result = nil
                rdata.result_count = nil
                rdata.results = {{prev_result, prev_result_count}}
                --rdata.main_product = prev_result
                --data.raw.recipe[recipe].result = nil
                --data.raw.recipe[recipe].result_count = nil
                --werkzeug.add_recipe_result(recipe, {prev_result, prev_result_count}, difficulty)
            end
            if #rdata.results == 1 and rdata.main_product == nil then
                rdata.main_product = rdata.results[1].name or rdata.results[1][1] -- set the result as main product before adding a second result
            end
            local duplicateFound = false -- search for duplicates, sometimes both difficulties refer to the same table
            for k,r in pairs(rdata.results) do
                if r.name ~= nil and r.name == newResultName then
                    duplicateFound = true
                elseif r[1] ~= nil and r[1] == newResultName then
                    duplicateFound = true
                end
            end
            if not duplicateFound then
                table.insert(rdata.results, newResult)
            elseif rdata.main_product == nil then
                rdata.main_product = rdata.results[1].name or rdata.results[1][1] -- set the result as main product before adding a second result
            end
            --table.insert(rdata, newResult)
            --if data.raw.recipe[recipe].results == nil then
            --    data.raw.recipe[recipe].results = {}
            --end
            --table.insert(data.raw.recipe[recipe].results, newResult)
        end
    end
end

--- Ersetzt im angegebenen Rezept (recipe) ein Produkt (oldResult) durch ein anderes (newResult). Alle anderen Eigenschaften werden beibehalten.
--- Optional: Neue Produktmenge (newAmount), Schwierigkeitsstufe (difficulty)
--- @param recipe string
--- @param oldResult string
--- @param newResult string
--- @param newAmount number
--- @param difficulty string
function werkzeug.replace_recipe_result(recipe, oldResult, newResult, newAmount, difficulty)
    if data.raw.recipe[recipe] then
        local result_data
        if difficulty ~= nil then
            result_data = get_results(recipe, difficulty)
        else
            result_data = get_results(recipe)
        end
        for _,rdata in pairs(result_data) do
            if rdata.result ~= nil and rdata.result == oldResult then
                rdata.result = newResult
                --data.raw.recipe[recipe].result = newResult -- replace result name
                if newAmount ~= nil then
                    rdata.result_count = newAmount
                end
            else
                for k,r in pairs(rdata.results) do
                    if r.name ~= nil and r.name == oldResult then
                        rdata.results[k].name = newResult -- replace result name
                        if newAmount ~= nil and rdata.results[k].amount then
                            rdata.results[k].amount = newAmount
                        end
                    elseif r[1] ~= nil and r[1] == oldResult then
                        rdata.results[k][1] = newResult -- replace result name
                        if newAmount ~= nil then
                            rdata.results[k][2] = newAmount
                        end
                    end
                end
            end
        end
    end
end

local function indexToOrderString(index, maxIndex, endIndex)
    local charShift = 96 -- (e.g. ASCII 97 = "a") 
    local orderString = ""
    if maxIndex > 26 then 
        orderString = string.char(math.ceil(index/26) + 96)
    end
    if index % 26 > 0 then
        orderString = orderString..string.char(math.floor(index % 26) + 96)
    else
        orderString = orderString..string.char(26 + 96)
    end
    return orderString
end

--- Ordnet der Objektgruppe (itemSubGroup) alle angegebenen Rezepte (recipes) zu und zwar genau in angegebener Reihenfolge.
--- Die Rezepte müssen in Form einer Liste angegeben werden.
--- Optional: Index-Parameter. Wenn angegeben, werden alle Rezepte nach dem angegeben Index einsortiert, z.B. "c" -> "c-a", "c-b" usw.
--- Form: {subIndex = "a"}
--- @param itemSubGroup string
--- @param recipes table
--- @param indexParam table
function werkzeug.order_recipes(itemSubGroup, recipes, indexParam)
    if data.raw["item-subgroup"][itemSubGroup] then
        local prefix, suffix = "",""
        if indexParam ~= nil then
            if indexParam.subIndex ~= nil or indexParam.sub_index ~= nil then
                prefix = (indexParam.subIndex or indexParam.sub_index).."-["
                suffix = "]"
            end
        end
        local orderIndex = 1
        local maxIndex = #recipes
        for _,r in pairs(recipes) do
            local recipe = data.raw.recipe[r]
            if recipe then
                recipe.subgroup = itemSubGroup
                recipe.order = prefix..indexToOrderString(orderIndex, maxIndex)..suffix
                orderIndex = orderIndex + 1
            end
        end
    end
end

return werkzeug