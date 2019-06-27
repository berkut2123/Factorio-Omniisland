-- renaming

local amount = 0

function deep_rename (tabl, old_name, new_name)
  for i, v in pairs (tabl) do
    if type (v) == "table" then
      deep_rename (v, old_name, new_name)
    elseif type (v) == "string" then
      if v == old_name then
        tabl[i] = new_name
        amount = amount + 1
      end
    end
  end
end


for recipe_name, recipe in pairs (data.raw.recipe) do
  if not (recipe_name == 'offshore-pump') then
    deep_rename (recipe, 'offshore-pump', 'burner-offshore-pump')
  end
end

log ('replaced: '..amount)