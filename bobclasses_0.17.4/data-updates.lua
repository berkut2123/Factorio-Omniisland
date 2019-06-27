local multiplier = data.raw.character.character.inventory_size / 80
if settings.startup["bobmods-plates-inventorysize"] then
  multiplier = settings.startup["bobmods-plates-inventorysize"].value / 80
end

for index, character in pairs(bobmods.classes.characters) do
  data.raw.character[character.name].inventory_size = math.floor(data.raw.character[character.name].inventory_size * multiplier)
end


require("bodies-updates")


if data.raw["item-group"]["bob-intermediate-products"] then
  data.raw["item-subgroup"]["body-parts"].group = "bob-intermediate-products"
end