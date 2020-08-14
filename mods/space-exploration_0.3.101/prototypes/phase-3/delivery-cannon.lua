local data_util = require("data_util")

for _, resource in pairs(se_delivery_cannon_recipes) do
  local type = resource.type or "item"
  if data.raw[type][resource.name] then
    local base = data.raw[type][resource.name]
    local amount = resource.amount
    if not amount then
      if type == "fluid" then
        amount = 1000
      else
        amount = base.stack_size or 1
      end
    end
    local order = ""
    local o_subgroup = data.raw["item-subgroup"][base.subgroup]
    local o_group = data.raw["item-group"][o_subgroup.group]
    order = o_group.order .. "-|-"..o_subgroup.order.."-|-"..base.order
    data:extend({
      {
          type = "item",
          name = data_util.mod_prefix .. "delivery-cannon-package-"..resource.name,
          icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-capsule.png",
          icon_size = 64,
          order = order,
          flags = {"hidden"},
          subgroup = base.subgroup or "delivery-cannon-capsules",
          stack_size = 1,
          localised_name = {"item-name.se-delivery-cannon-capsule-packed", base.localised_name or {type.."-name."..resource.name}}
      },
      {
          type = "recipe",
          name = data_util.mod_prefix .. "delivery-cannon-pack-" .. resource.name,
          icon = base.icon,
          icon_size = base.icon_size,
          icon_mipmaps = base.icon_mipmaps,
          icons = base.icons,
          result = data_util.mod_prefix .. "delivery-cannon-package-"..resource.name,
          enabled = true,
          energy_required = 5,
          ingredients = {
            { data_util.mod_prefix .. "delivery-cannon-capsule", 1 },
            { type = type, name = resource.name, amount = amount},
          },
          requester_paste_multiplier = 1,
          always_show_made_in = false,
          category = "delivery-cannon",
          hide_from_player_crafting = true,
          localised_name = {"item-name.se-delivery-cannon-capsule-packed", base.localised_name or {type.."-name."..resource.name}}
      },
    })
    if is_debug_mode then
      --log(serpent.block(data.raw.item[data_util.mod_prefix .. "delivery-cannon-package-"..resource.name]))
    end
  end
end
