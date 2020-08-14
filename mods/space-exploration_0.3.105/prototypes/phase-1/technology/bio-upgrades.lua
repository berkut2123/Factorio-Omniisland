local data_util = require("data_util")

local upgrade_types = {
  {name = "constitution", tint = {r = 1, g = 0, b = 0}, effects = {{type = "character-health-bonus", modifier = 50}}},
  {name = "strength", tint = {r = 1, g = 1, b = 0}, effects = {{type = "character-inventory-slots-bonus", modifier = 5}}},
  {name = "agility", tint = {r = 0, g = 1, b = 0}, effects = {{type = "character-running-speed", modifier = 0.1}}},
  {name = "dexterity", tint = {r = 0, g = 1, b = 1}, effects = {{type = "character-crafting-speed", modifier = 0.2}}},
  {name = "intelligence", tint = {r = 0, g = 0, b = 1}, effects = {{type = "laboratory-productivity", modifier = 0.05}}},
}

for _, upgrade_type in pairs(upgrade_types) do
  for i = 1, 5 do
    data:extend({
      {
        type = "technology",
        name = data_util.mod_prefix .. "bio-upgrade-"..upgrade_type.name.."-"..i,
        effects = table.deepcopy(upgrade_type.effects),
        icons = {
          { icon = "__space-exploration-graphics__/graphics/technology/bio-upgrade-base.png", icon_size = 128 },
          { icon = "__space-exploration-graphics__/graphics/technology/bio-upgrade-flask.png", icon_size = 128 },
          { icon = "__space-exploration-graphics__/graphics/technology/bio-upgrade-mask.png", icon_size = 128, tint = upgrade_type.tint},
        },
        order = "e-g",
        upgrade = true,
        prerequisites = {
          i == 5 and (data_util.mod_prefix .. "deep-space-science-pack") or (data_util.mod_prefix .. "biological-science-pack-"..math.min(4,i)),
          i > 1 and (data_util.mod_prefix .. "bio-upgrade-"..upgrade_type.name.."-"..(i-1)) or nil,
        },
        unit = {
         count = 2^i*50,
         time = 60,
         ingredients = {
           { "automation-science-pack", 1 },
           { "logistic-science-pack", 1 },
           { "chemical-science-pack", 1 },
           { data_util.mod_prefix .. "rocket-science-pack", 1 },
           { data_util.mod_prefix .. "biological-science-pack-"..math.min(4,i), 1 },
           i == 5 and { data_util.mod_prefix .. "deep-space-science-pack", 1 } or nil,
         }
        },
      },
    })
  end
end

data.raw.technology[data_util.mod_prefix .. "bio-upgrade-strength-5"].effects[1].modifier = 10
