data:extend{
  {
      type = "int-setting",
      name = "se-meteor-interval",
      setting_type = "runtime-global",
      default_value = 20,
      minimum_value = 1,
      maximum_value = 2880,
  },
  {
      type = "int-setting",
      name = "se-plage-max-runtime",
      setting_type = "runtime-global",
      default_value = 15,
      minimum_value = 1,
      maximum_value = 1000,
  },
  {
      type = "bool-setting",
      name = "se-print-meteor-info",
      setting_type = "runtime-per-user",
      default_value = false,
  },
  {
      type = "bool-setting",
      name = "se-never-show-lifesupport",
      setting_type = "runtime-per-user",
      default_value = false,
  },
  {
      type = "bool-setting",
      name = "se-show-zone-preview",
      setting_type = "runtime-per-user",
      default_value = true,
  },
  {
      type = "int-setting",
      name = "se-space-pipe-capacity",
      setting_type = "startup",
      default_value = 100,
      minimum_value = 50,
      maximum_value = 200,
  },
  {
      type = "string-setting",
      name = "se-space-science-pack",
      setting_type = "startup",
      default_value = "Replace",
      allowed_values = {"Remove", "Replace", "OptimisationUranium", "OptimisationFish"},
      order = "i"
  },
  {
      type = "bool-setting",
      name = "se-electric-boiler",
      setting_type = "startup",
      default_value = true,
  },
  --[[{
      type = "bool-setting",
      name = "se-deep-space-belt-black",
      setting_type = "startup",
      default_value = false,
  },]]--
  {
      type = "int-setting",
      name = "se-deep-space-belt-speed",
      setting_type = "startup",
      default_value = 64,
      minimum_value = 1,
      maximum_value = 512,
  },
  {
      type = "bool-setting",
      name = "se-deep-space-belt-white",
      setting_type = "startup",
      default_value = true,
  },
  {
      type = "bool-setting",
      name = "se-deep-space-belt-red",
      setting_type = "startup",
      default_value = true,
  },
  {
      type = "bool-setting",
      name = "se-deep-space-belt-magenta",
      setting_type = "startup",
      default_value = true,
  },
  {
      type = "bool-setting",
      name = "se-deep-space-belt-blue",
      setting_type = "startup",
      default_value = true,
  },
  {
      type = "bool-setting",
      name = "se-deep-space-belt-cyan",
      setting_type = "startup",
      default_value = true,
  },
  {
      type = "bool-setting",
      name = "se-deep-space-belt-green",
      setting_type = "startup",
      default_value = true,
  },
  {
      type = "bool-setting",
      name = "se-deep-space-belt-yellow",
      setting_type = "startup",
      default_value = true,
  },
  {
      type = "bool-setting",
      name = "se-pylon-charge-points",
      setting_type = "startup",
      default_value = true,
  }
--[[
    {
        type = "int-setting",
        name = "se-planets",
        setting_type = "startup",
        default_value = 100,
        minimum_value = 100,
        maximum_value = 500,
    },{
        type = "int-setting",
        name = "se-planet-size",
        setting_type = "startup",
        default_value = 100,
        minimum_value = 1,
        maximum_value = 10000,
    },
    {
        type = "int-setting",
        name = "se-seed",
        setting_type = "startup",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 5000,
    }]]--
}

for _, setting in pairs(data.raw["string-setting"]) do
  if string.find(setting.name, "alien-biomes-include-", 1, true) and setting.name ~= "alien-biomes-include-rivers" then
    setting.allowed_values = {"Enabled"}
  end
end
data.raw["string-setting"]["alien-biomes-disable-vegetation"].allowed_values = {"Disabled"}
