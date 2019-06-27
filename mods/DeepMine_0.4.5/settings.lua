data:extend({
  {
    type = "int-setting",
    name = "deep-mine-recipe-amount",
    order = "aa",
    setting_type = "startup",
    default_value = 1,
    minimum_value = 1
  },
  {
    type = "double-setting",
    name = "deep-mine-recipe-percentage",
    order = "ab",
    setting_type = "startup",
    default_value = 50.0,
    minimum_value = 1,
    maximum_value = 100
  },  
  {
    type = "double-setting",
    name = "deep-mine-adv-recipe-primary-percentage",
    order = "ac",
    setting_type = "startup",
    default_value = 80.0,
    minimum_value = 1,
    maximum_value = 100
  },
  {
    type = "double-setting",
    name = "deep-mine-adv-recipe-secondary-percentage",
    order = "ad",
    setting_type = "startup",
    default_value = 10.0,
    minimum_value = 1,
    maximum_value = 100
  },  
  {
    type = "double-setting",
    name = "deep-mine-crafting-speed",
    order = "ba",
    setting_type = "startup",
    default_value = 1.0,
    minimum_value = 1
  },
  -- {
    -- type = "double-setting",
    -- name = "quarry-power-usage",
    -- order = "bc",
    -- setting_type = "startup",
    -- default_value = 1.0,
    -- minimum_value = 0
  -- },

})